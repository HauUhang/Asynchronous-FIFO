module wirte_ctrl(
    input wire       wclk, 
    input wire       wrst,
    input wire       wen, //enable使能
    input wire [2:0] rptr_gray_sync, //来自读域，同步过来的格雷码读指针

    output wire [2:0] waddr, //给RAM写地址
    output wire [2:0] wptr_gray, //发给读域，用于同步
    output wire       wfull //满信号
);
    reg [3:0] wptr_bin; 
    reg [3:0] wptr_gray_full;

    //写指针二进制逻辑
    always @(posedge wclk or posedge wrst) begin
        if (wrst)
            wptr_bin <= 4'b0000;
        else if (wen && ~wfull)
            wptr_bin <= wptr_bin + 1;
    end

    //写指针输出
    assign waddr = wptr_bin[2:0];

    //写指针的格雷码形式
    always @(posedge wclk or posedge wrst) begin
        if (wrst)
            wptr_gray_full <= 4'b0000;
        else
            wptr_gray_full <= wptr_bin ^ (wptr_bin >> 1);
    end

    assign wptr_gray = wptr_gray_full[2:0];

    // 写满判断
    assign wfull = (wptr_gray_full == {~rptr_gray_sync[2], rptr_gray_sync[1:0]});
endmodule