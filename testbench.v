`timescale 1ns/1ps

module tb_fifo;

    reg wclk, wrst, wen;
    reg [2:0] wdata;
    reg rclk, rrst, ren;
    wire [2:0] rdata;
    wire full, empty;

    // 实例化 DUT
    fifo dut (
        .wclk(wclk), .wrst(wrst), .wen(wen), .wdata(wdata),
        .rclk(rclk), .rrst(rrst), .ren(ren), .rdata(rdata),
        .full(full), .empty(empty)
    );

    // 写时钟：10ns 周期
    always #5 wclk = ~wclk;

    // 读时钟：20ns 周期
    always #10 rclk = ~rclk;

    initial begin
        // 初始化
        wclk = 0; rclk = 0;
        wrst = 1; rrst = 1;
        wen = 0; ren = 0;
        wdata = 0;

        #20;
        wrst = 0; rrst = 0;

        // 写入 4 个数据
        repeat (4) begin
            @(posedge wclk);
            wen = 1;
            wdata = wdata + 1;
        end

        @(posedge wclk);
        wen = 0;

        // 读取 4 个数据
        repeat (4) begin
            @(posedge rclk);
            ren = 1;
        end

        @(posedge rclk);
        ren = 0;

        #100;
        $stop;
    end

endmodule
