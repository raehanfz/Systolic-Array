module pe
#(
    parameter DATA_BIT = 8
)(
    input clk, 
    input rst,
    input [DATA_BIT-1:0] input_north, 
    input [DATA_BIT-1:0] input_west,
    output reg [DATA_BIT-1:0] output_south, 
    output reg [DATA_BIT-1:0] output_east,
    output reg [2*DATA_BIT-1:0] result
);
    
    //pipeline register for DSP inference
    (* use_dsp = "yes" *) reg [DATA_BIT-1:0] north_reg;
    (* use_dsp = "yes" *) reg [DATA_BIT-1:0] west_reg;
    (* use_dsp = "yes" *) reg [2*DATA_BIT-1:0] mult_reg;
    
    always @(posedge clk or posedge rst) begin 
        if(rst) begin
            north_reg <= 0;
            west_reg <= 0;
            mult_reg <= 0;
            result <= 0;
            output_east <= 0;
            output_south <= 0;
        end
        else begin
            //register inputs
            north_reg <= input_north;
            west_reg <= input_west;
            
            //multiplication
            mult_reg <= north_reg * west_reg;
            
            // accumulate
            result <= mult_reg + result;
            
            //forward signals
            output_east <= input_west;
            output_south <= input_north;
        end
    end
endmodule