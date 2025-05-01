module fifo (
    input  wire       wclk,
    input  wire       wrst,
    input  wire       wen,
    input  wire [2:0] wdata,

    input  wire       rclk,
    input  wire       rrst,
    input  wire       ren,
    output wire [2:0] rdata,

    output wire       full,
    output wire       empty
);

    wire [2:0] waddr;
    wire [2:0] wptr_gray;
    wire [2:0] wptr_gray_sync;

    wire [2:0] raddr;
    wire [2:0] rptr_gray;
    wire [2:0] rptr_gray_sync;

    // 写控制器
    write_ctrl u_write_ctrl (
        .wclk(wclk),
        .wrst(wrst),
        .wen(wen),
        .rptr_gray_sync(rptr_gray_sync),
        .waddr(waddr),
        .wptr_gray(wptr_gray),
        .full(full)
    );

    // 读控制器
    read_ctrl u_read_ctrl (
        .rclk(rclk),
        .rrst(rrst),
        .ren(ren),
        .wptr_gray_sync(wptr_gray_sync),
        .raddr(raddr),
        .rptr_gray(rptr_gray),
        .empty(empty)
    );

    // 写指针格雷码同步到读时钟域
    sync_gray u_sync_w2r (
        .clk(rclk),
        .rst(rrst),
        .gray_in(wptr_gray),
        .gray_out(wptr_gray_sync)
    );

    // 读指针格雷码同步到写时钟域
    sync_gray u_sync_r2w (
        .clk(wclk),
        .rst(wrst),
        .gray_in(rptr_gray),
        .gray_out(rptr_gray_sync)
    );

    // 双口RAM
    dual_port_ram u_dual_port_ram (
        .wclk(wclk),
        .wen(wen && ~full),
        .waddr(waddr),
        .wdata(wdata),
        .rclk(rclk),
        .ren(ren && ~empty),
        .raddr(raddr),
        .rdata(rdata)
    );

endmodule
