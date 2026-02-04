
`timescale 1ns/1ps

module tb_fifo_sync;

    reg clk, rst;
    reg write, read;
    reg [15:0] data_in;
    wire [15:0] data_out;
    wire full, empty;

    fifo_sync dut (
        .clk(clk),
        .rst(rst),
        .write(write),
        .read(read),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    // 10ns clock
    always #5 clk = ~clk;

    integer i;

    initial begin
        // INIT
        clk   = 0;
        rst   = 1;
        write = 0;
        read  = 0;
        data_in = 16'h0000;

        // RESET
        #15 rst = 0;

        // -------------------
        // WRITE PHASE
        // -------------------
        $display("\n--- WRITE PHASE ---");
        for (i = 0; i < 6; i = i + 1) begin
            @(posedge clk);
            write = 1;
            data_in = i + 16'h10;
            $display("Writing %h", data_in);
        end
        @(posedge clk);
        write = 0;

        // -------------------
        // READ PHASE
        // -------------------
        $display("\n--- READ PHASE ---");
        for (i = 0; i < 6; i = i + 1) begin
            @(posedge clk);
            read = 1;
            @(posedge clk);
            $display("Read %h", data_out);
        end
        read = 0;

        #20 $finish;
    end

endmodule
