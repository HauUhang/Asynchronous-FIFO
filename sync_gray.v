module sync_gray (
    input wire clk,
    input wire rst,
    input wire gray_in,

    output wire gray_out
);
    reg sync1;
    reg sync2;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
          sync1 <= 0;
          sync2 <= 0;
        end else begin
          sync1 <= gray_in;
          sync2 <= sync1;
        end
    end

    assign gray_out = sync2;

endmodule