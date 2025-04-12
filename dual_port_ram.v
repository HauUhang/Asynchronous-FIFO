module dual_port_ram (
    input  wire       wclk,
    input  wire       wen,
    input  wire [2:0] waddr,
    input  wire [2:0] wdata,
    
    input  wire       rclk,
    input  wire       ren,
    input  wire [2:0] raddr,
    output reg  [2:0] rdata
);
    reg [2:0] mem [7:0];
    
    //write
    always @(posedge wclk) begin
        if(wen) //表示 “如果写使能是高电平”。
            mem[waddr] <= wdata;
    end

    //read
    always @(posedge rclk) begin
        if(ren) 
            rdata <= mem[raddr]; //读取是要把 mem[raddr] 的值读出来，赋给 rdata。
    end

endmodule