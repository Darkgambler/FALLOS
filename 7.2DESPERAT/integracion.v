`include "xfifo.v"
`include "arbitro.v"
`include "misc.v"

module integracion( output wire [9:0] fifo4_out, fifo5_out, 
		    output wire [9:0] fifo6_out, fifo7_out,
		    input wire [9:0]  fifo0_i, fifo1_i, fifo2_i, fifo3_i,
		    input wire 	      push0, push1, push2, push3,
		    input wire 	      pop4, pop5, pop6, pop7,
		    input wire 	      reset, clk );

   wire [9:0] fifo0_o, fifo1_o, fifo2_o, fifo3_o;
   wire [9:0] fifo4_i, fifo5_i, fifo6_i, fifo7_i;
   
   wire [2:0] high, low;
   wire [1:0] dest;
   wire [1:0] demux;
   wire [1:0] destino;
   
   
   assign high = 7;
   assign low = 2;
   

   
   arbitro ARBITRO( pop0, pop1, pop2, pop3, push4, push5, 
		    push6, push7, demux, fifo0_empty, 
		    fifo1_empty, fifo2_empty, fifo3_empty, 
		    fifo4_full, fifo5_full, fifo6_full, 
		    fifo7_full, destino, reset, clk );

   xfifo FIFO0( fifo0_o, fifo0_full, fifo0_empty, fifo0_err, 
		fifo0_i, high, low, push0, pop0, clk, reset );
   xfifo FIFO1( fifo1_o, fifo1_full, fifo1_empty, fifo1_err, 
		fifo1_i, high, low, push1, pop1, clk, reset );
   xfifo FIFO2( fifo2_o, fifo2_full, fifo2_empty, fifo2_err, 
		fifo2_i, high, low, push2, pop2, clk, reset );
   xfifo FIFO3( fifo3_o, fifo3_full, fifo3_empty, fifo3_err, 
		fifo3_i, high, low, push3, pop3, clk, reset );
   
   misc MISC( fifo4_i, fifo5_i, fifo6_i, fifo7_i, destino, fifo0_o,
	      fifo1_o, fifo2_o, fifo3_o, demux, reset, clk );
 

   xfifo FIFO4( fifo4_out, fifo4_full, fifo4_empty, fifo4_err, 
		fifo4_i, high, low, push4, pop4, clk, reset );
   xfifo FIFO5( fifo5_out, fifo5_full, fifo5_empty, fifo5_err, 
		fifo5_i, high, low, push5, pop5, clk, reset );
   xfifo FIFO6( fifo6_out, fifo6_full, fifo6_empty, fifo6_err, 
		fifo6_i, high, low, push6, pop6, clk, reset );
   xfifo FIFO7( fifo7_out, fifo7_full, fifo7_empty, fifo7_err, 
		fifo7_i, high, low, push7, pop7, clk, reset );

endmodule // integracion
