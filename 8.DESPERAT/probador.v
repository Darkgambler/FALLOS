module probador( input wire [9:0] fifo4_out, fifo5_out, 
		 input wire [9:0] fifo6_out, fifo7_out,
		 output reg [9:0] fifo0_i, fifo1_i, fifo2_i, fifo3_i,
		 output reg 	  push0, push1, push2, push3,
		 output reg 	  pop4, pop5, pop6, pop7,
		 output reg 	  reset, clk );


   reg [9:0] 			  fifo0_is, fifo1_is, fifo2_is, fifo3_is;
   reg 				  push0s, push1s, push2s, push3s;
   reg 				  pop4s, pop5s, pop6s, pop7s;
   reg 				  reset_n;
   reg 				  valid4, valid5, valid6, valid7;
   always @( posedge clk ) begin
      valid4 <= pop4;   
      valid5 <= pop5; 
      valid6 <= pop6;
      valid7 <= pop7;
   end
   

   always @( posedge clk ) begin
      fifo0_i <= fifo0_is;
      fifo1_i <= fifo1_is;
      fifo2_i <= fifo2_is;
      fifo3_i <= fifo3_is;
      push0 <= push0s;
      push1 <= push1s;
      push2 <= push2s;
      push3 <= push3s;
      pop4 <= pop4s;
      pop5 <= pop5s;
      pop6 <= pop6s;
      pop7 <= pop7s;
      reset <= reset_n;
   end
   
   initial begin
      $dumpfile( "000normal.vcd" );
      $dumpvars( 0 );
   end

   initial begin
      //high_limit = HIGH;
      //low_limit = LOW;
      fifo0_is = 0;
      fifo1_is = 0;
      fifo2_is = 0;
      fifo3_is = 0;
      push0s = 0;
      push1s = 0;
      push2s = 0;
      push3s = 0;
      pop4s = 0;
      pop5s= 0;
      pop6s= 0;
      pop7s= 0;
      clk = 0;
      reset_n = 0;
   end

   always begin
      #1 clk = !clk;
   end

   integer k = 0;
   initial begin
      #15 reset_n = 1;
      #10;
     repeat( 8 ) begin	
	 fifo0_is[9:8] = 2'b00 + k;
	 fifo0_is[7:0] = $random; 
	 push0s = 1'b1; 
	 fifo1_is[9:8] = 2'b00 + k;
	 fifo1_is[7:0] = $random; 
	 push1s = 1'b1; 
	 fifo2_is[9:8] = 2'b00 + k;
	 fifo2_is[7:0] = $random; 
	 push2s = 1'b1;
	 fifo3_is[9:8] = 2'b00 + k;
	 fifo3_is[7:0] = $random; 
	 push3s = 1'b1;
	 #2;
	 k = k + 1;
      end // 
      fifo0_is = 'b0;
      fifo1_is = 'b0;
      fifo2_is = 'b0;
      fifo3_is = 'b0;
      push0s = 1'b0; 
      push1s = 1'b0; 
      push2s = 1'b0; 
      push3s = 1'b0;

      #90;
      pop4s = 1'b1;
      #2 pop4s = 1'b0;
      
      #10;
      /*
      repeat( 1 ) begin
      #2 pop4s = 1'b1;
      pop5s = 1'b1;
      pop6s = 1'b1;
      pop7s = 1'b1;
      end
      
      #2 pop4s = 1'b0;
      pop5s = 1'b0;
      pop6s = 1'b0;
      pop7s = 1'b0;

      #2
      repeat( 1 ) begin
      #2 pop4s = 1'b1;
      pop5s = 1'b1;
      pop6s = 1'b1;
      pop7s = 1'b1;
      end
      
      #2 pop4s = 1'b0;
      pop5s = 1'b0;
      pop6s = 1'b0;
      pop7s = 1'b0;

      

      
      repeat( 1 ) begin
      #2 pop4s = 1'b1;
      #2 pop4s = 1'b0;
      #2 pop5s = 1'b1;
      #2 pop5s = 1'b0;
      #2 pop6s = 1'b1;
      #2 pop6s = 1'b0;
      #2 pop7s = 1'b1;
      #2 pop7s = 1'b0;
      end*/
      
      #200 $finish;
   end
endmodule // probador

      

   
