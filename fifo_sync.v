`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.01.2026 17:48:17
// Design Name: 
// Module Name: fifo_sync
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo_sync(
    input clk , rst, 
    input write , 
    input read,
    input [15:0]data_in,
    output reg [15:0]data_out,
    output full , empty
    );
    integer i;
    reg [15:0] data_array [7:0] ;
    reg [2:0]rd_p , wr_p;
    
always@(posedge clk) 
begin    
    if(rst)begin
            for(i = 0 ; i < 8 ; i= i +1) begin 
                data_array [i] <= 16'b0;
            end
            rd_p <= 3'b0;
            wr_p <= 3'b0;
            data_out <= 16'b0;
        end
    else begin
        if(write && !full)begin
            data_array[wr_p] <= data_in;
            wr_p <= wr_p + 1;
        end
        else if(read && !empty) begin
            data_out <= data_array[rd_p];
            rd_p <= rd_p +1;
        end
        
        else begin
            data_out <= 0;
        end
    end      
end

assign full = wr_p + 1 == rd_p;
assign empty  = wr_p == rd_p;
endmodule
