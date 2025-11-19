//commented for vivado, undo for gtkwave
`include "pe.v"

module systolic_array
#(
    parameter DATA_BIT = 8
)
(
    // Gunakan parameter DATA_BIT untuk semua port data
    input [DATA_BIT-1:0] input_west0, 
    input [DATA_BIT-1:0] input_west4, 
    input [DATA_BIT-1:0] input_west8, 
    input [DATA_BIT-1:0] input_west12,
    
    input [DATA_BIT-1:0] input_north0, 
    input [DATA_BIT-1:0] input_north1, 
    input [DATA_BIT-1:0] input_north2, 
    input [DATA_BIT-1:0] input_north3,
    
    input clk, 
    input rst, 
    
    output reg done,

    output [2*DATA_BIT-1:0] result0, result1, result2, result3, 
                            result4, result5, result6, result7, 
                            result8, result9, result10, result11, 
                            result12, result13, result14, result15
);
    
    //counter for done signal
    reg [3:0] count;
    
    //internal wire declaration
    wire [DATA_BIT-1:0] output_south0, output_south1, output_south2, output_south3, 
                         output_south4, output_south5, output_south6, output_south7, 
                         output_south8, output_south9, output_south10, output_south11, 
                         output_south12, output_south13, output_south14, output_south15;
                         
    wire [DATA_BIT-1:0] output_east0, output_east1, output_east2, output_east3, 
                         output_east4, output_east5, output_east6, output_east7, 
                         output_east8, output_east9, output_east10, output_east11, 
                         output_east12, output_east13, output_east14, output_east15;
    
    //pe initialization    
    //from north and west 
    pe #(.DATA_BIT(DATA_BIT)) P0 (clk, rst, input_north0, input_west0, output_south0, output_east0, result0);
    // from north
    pe #(.DATA_BIT(DATA_BIT)) P1 (clk, rst, input_north1, output_east0, output_south1, output_east1, result1);
    pe #(.DATA_BIT(DATA_BIT)) P2 (clk, rst, input_north2, output_east1, output_south2, output_east2, result2);
    pe #(.DATA_BIT(DATA_BIT)) P3 (clk, rst, input_north3, output_east2, output_south3, output_east3, result3);
    // from west
    pe #(.DATA_BIT(DATA_BIT)) P4 (clk, rst, output_south0, input_west4, output_south4, output_east4, result4);
    pe #(.DATA_BIT(DATA_BIT)) P8 (clk, rst, output_south4, input_west8, output_south8, output_east8, result8);
    pe #(.DATA_BIT(DATA_BIT)) P12 (clk, rst, output_south8, input_west12, output_south12, output_east12, result12);
    
    //no direct inputs
    //second row
    pe #(.DATA_BIT(DATA_BIT)) P5 (clk, rst, output_south1, output_east4, output_south5, output_east5, result5);
    pe #(.DATA_BIT(DATA_BIT)) P6 (clk, rst, output_south2, output_east5, output_south6, output_east6, result6);
    pe #(.DATA_BIT(DATA_BIT)) P7 (clk, rst, output_south3, output_east6, output_south7, output_east7, result7);
    // third row
    pe #(.DATA_BIT(DATA_BIT)) P9 (clk, rst, output_south5, output_east8, output_south9, output_east9, result9);
    pe #(.DATA_BIT(DATA_BIT)) P10 (clk, rst, output_south6, output_east9, output_south10, output_east10, result10);
    pe #(.DATA_BIT(DATA_BIT)) P11 (clk, rst, output_south7, output_east10, output_south11, output_east11, result11);
    // fourth row
    pe #(.DATA_BIT(DATA_BIT)) P13 (clk, rst, output_south9, output_east12, output_south13, output_east13, result13);
    pe #(.DATA_BIT(DATA_BIT)) P14 (clk, rst, output_south10, output_east13, output_south14, output_east14, result14);
    pe #(.DATA_BIT(DATA_BIT)) P15 (clk, rst, output_south11, output_east14, output_south15, output_east15, result15);
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            done <= 0;
            count <= 0;
        end
        else begin
            if(count == 9) begin
                done <= 1;
                count <= 0;
            end
            else begin
                done <= 0;
                count <= count + 1;
            end
        end 
    end 
    
endmodule