//commented for vivado, undo for gtkwave
`include "systolic_array.v"

module sys_array_tb;
    parameter DATA_BIT = 8;
    
    reg rst, clk;

    reg [DATA_BIT-1:0] input_west0, input_west4, input_west8, input_west12;
    reg [DATA_BIT-1:0] input_north0, input_north1, input_north2, input_north3;
    
    wire done;

    wire [2*DATA_BIT-1:0] w_result0,  w_result1,  w_result2,  w_result3,
                          w_result4,  w_result5,  w_result6,  w_result7,
                          w_result8,  w_result9,  w_result10, w_result11,
                          w_result12, w_result13, w_result14, w_result15;

    systolic_array #(
        .DATA_BIT(DATA_BIT)
    ) uut (
        .clk(clk), 
        .rst(rst), 
        .done(done),
        //port of left column
        .input_west0(input_west0), 
        .input_west4(input_west4), 
        .input_west8(input_west8), 
        .input_west12(input_west12),
        //port of first row
        .input_north0(input_north0), 
        .input_north1(input_north1), 
        .input_north2(input_north2), 
        .input_north3(input_north3),

        .result0(w_result0),
        .result1(w_result1),
        .result2(w_result2),
        .result3(w_result3),
        .result4(w_result4),
        .result5(w_result5),
        .result6(w_result6),
        .result7(w_result7),
        .result8(w_result8),
        .result9(w_result9),
        .result10(w_result10),
        .result11(w_result11),
        .result12(w_result12),
        .result13(w_result13),
        .result14(w_result14),
        .result15(w_result15)
    );


    //input P0 (input_west0) and P1-P3 (input_north0)
    initial begin
        #3  input_west0 <= 8'd3;
            input_north0 <= 8'd12;
        #10 input_west0 <= 8'd2;
            input_north0 <= 8'd8;
        #10 input_west0 <= 8'd1;
            input_north0 <= 8'd4;
        #10 input_west0 <= 8'd0; //reset
            input_north0 <= 8'd0; //reset
    end

    //input P4 (input_west4) and P1 (input_north1)
    initial begin
        #3  input_west4 <= 8'd0;
            input_north1 <= 8'd0;
        #10 input_west4 <= 8'd7;
            input_north1 <= 8'd13;
        #10 input_west4 <= 8'd6;
            input_north1 <= 8'd9;
        #10 input_west4 <= 8'd5;
            input_north1 <= 8'd5;
        #10 input_west4 <= 8'd4;
            input_north1 <= 8'd1;
        #10 input_west4 <= 8'd0;  //reset
            input_north1 <= 8'd0;  //reset
    end

    //input P8 (input_west8) and P2 (input_north2)
    initial begin
        #3  input_west8 <= 8'd0;
            input_north2 <= 8'd0;
        #10 input_west8 <= 8'd0;
            input_north2 <= 8'd0;
        #10 input_west8 <= 8'd11;
            input_north2 <= 8'd14;
        #10 input_west8 <= 8'd10;
            input_north2 <= 8'd10;
        #10 input_west8 <= 8'd9;
            input_north2 <= 8'd6;
        #10 input_west8 <= 8'd8;
            input_north2 <= 8'd2;
        #10 input_west8 <= 8'd0;  //reset
            input_north2 <= 8'd0;  //reset
    end

    //input P12 (input_west12) and P3 (input_north3)
    initial begin
        #3  input_west12 <= 8'd0;
            input_north3 <= 8'd0;
        #10 input_west12 <= 8'd0;
            input_north3 <= 8'd0;
        #10 input_west12 <= 8'd0;
            input_north3 <= 8'd0;
        #10 input_west12 <= 8'd15;
            input_north3 <= 8'd15;
        #10 input_west12 <= 8'd14;
            input_north3 <= 8'd11;
        #10 input_west12 <= 8'd13;
            input_north3 <= 8'd7;
        #10 input_west12 <= 8'd12;  
            input_north3 <= 8'd3;
        #10 input_west12 <= 8'd0;  
            input_north3 <= 8'd0;  
    end

    //initialization, reset, clock
    initial begin
        // Inisialisasi semua sinyal input ke 0
        input_west0  = 0; input_west4  = 0; input_west8  = 0; input_west12 = 0;
        input_north0 = 0; input_north1 = 0; input_north2 = 0; input_north3 = 0;
        
        rst <= 1;
        clk <= 0;
        #3
        rst <= 0;
    end

    //clock Generator
    // #5 -> 10ns clock periode
    initial begin
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("tb_wave.vcd");
        $dumpvars(0, sys_array_tb);
    end
    initial begin
        #200 $finish;
    end
endmodule