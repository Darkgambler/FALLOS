`include "probador.v"
`include "pcieTran.v"
`include "synth_pcieTran.v"
`include "./UTILIDADES/cmos_cells.v"

module testbench;

   parameter DATA_BITS = 8;
   parameter ADDR_BITS = 6; 
 
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			clk;			// From PROB of probador.v
   wire [4:0]		counter_out;		// From COND of pcieTran.v
   wire [4:0]		counter_out_synt;	// From SYNT of synth_pcieTran.v
   wire [9:0]		data0_in;		// From PROB of probador.v
   wire [9:0]		data1_in;		// From PROB of probador.v
   wire [9:0]		data2_in;		// From PROB of probador.v
   wire [9:0]		data3_in;		// From PROB of probador.v
   wire [9:0]		fifo4_out;		// From COND of pcieTran.v
   wire [9:0]		fifo4_out_synt;		// From SYNT of synth_pcieTran.v
   wire [9:0]		fifo5_out;		// From COND of pcieTran.v
   wire [9:0]		fifo5_out_synt;		// From SYNT of synth_pcieTran.v
   wire [9:0]		fifo6_out;		// From COND of pcieTran.v
   wire [9:0]		fifo6_out_synt;		// From SYNT of synth_pcieTran.v
   wire [9:0]		fifo7_out;		// From COND of pcieTran.v
   wire [9:0]		fifo7_out_synt;		// From SYNT of synth_pcieTran.v
   wire [1:0]		idx;			// From PROB of probador.v
   wire			init;			// From PROB of probador.v
   wire [2:0]		limit_high;		// From PROB of probador.v
   wire [2:0]		limit_low;		// From PROB of probador.v
   wire			pop4;			// From PROB of probador.v
   wire			pop5;			// From PROB of probador.v
   wire			pop6;			// From PROB of probador.v
   wire			pop7;			// From PROB of probador.v
   wire			push0;			// From PROB of probador.v
   wire			push1;			// From PROB of probador.v
   wire			push2;			// From PROB of probador.v
   wire			push3;			// From PROB of probador.v
   wire			req;			// From PROB of probador.v
   wire			reset;			// From PROB of probador.v
   wire			valid_out;		// From COND of pcieTran.v
   wire			valid_out_synt;		// From SYNT of synth_pcieTran.v
   // End of automatics

   probador PROB( /*AUTOINST*/
		 // Outputs
		 .data0_in		(data0_in[9:0]),
		 .data1_in		(data1_in[9:0]),
		 .data2_in		(data2_in[9:0]),
		 .data3_in		(data3_in[9:0]),
		 .push0			(push0),
		 .push1			(push1),
		 .push2			(push2),
		 .push3			(push3),
		 .pop4			(pop4),
		 .pop5			(pop5),
		 .pop6			(pop6),
		 .pop7			(pop7),
		 .clk			(clk),
		 .reset			(reset),
		 .init			(init),
		 .req			(req),
		 .limit_low		(limit_low[2:0]),
		 .limit_high		(limit_high[2:0]),
		 .idx			(idx[1:0]),
		 // Inputs
		 .fifo4_out		(fifo4_out[9:0]),
		 .fifo5_out		(fifo5_out[9:0]),
		 .fifo6_out		(fifo6_out[9:0]),
		 .fifo7_out		(fifo7_out[9:0]),
		 .counter_out		(counter_out[4:0]),
		 .fifo4_out_synt	(fifo4_out_synt[9:0]),
		 .fifo5_out_synt	(fifo5_out_synt[9:0]),
		 .fifo6_out_synt	(fifo6_out_synt[9:0]),
		 .fifo7_out_synt	(fifo7_out_synt[9:0]),
		 .counter_out_synt	(counter_out_synt[4:0]));
   pcieTran COND( /*AUTOINST*/
		 // Outputs
		 .fifo4_out		(fifo4_out[9:0]),
		 .fifo5_out		(fifo5_out[9:0]),
		 .fifo6_out		(fifo6_out[9:0]),
		 .fifo7_out		(fifo7_out[9:0]),
		 .counter_out		(counter_out[4:0]),
		 .valid_out		(valid_out),
		 // Inputs
		 .data0_in		(data0_in[9:0]),
		 .data1_in		(data1_in[9:0]),
		 .data2_in		(data2_in[9:0]),
		 .data3_in		(data3_in[9:0]),
		 .push0			(push0),
		 .push1			(push1),
		 .push2			(push2),
		 .push3			(push3),
		 .pop4			(pop4),
		 .pop5			(pop5),
		 .pop6			(pop6),
		 .pop7			(pop7),
		 .clk			(clk),
		 .reset			(reset),
		 .init			(init),
		 .req			(req),
		 .limit_low		(limit_low[2:0]),
		 .limit_high		(limit_high[2:0]),
		 .idx			(idx[1:0]));
   synth_pcieTran SYNT( /*AUTOINST*/
		       // Outputs
		       .counter_out_synt(counter_out_synt[4:0]),
		       .fifo4_out_synt	(fifo4_out_synt[9:0]),
		       .fifo5_out_synt	(fifo5_out_synt[9:0]),
		       .fifo6_out_synt	(fifo6_out_synt[9:0]),
		       .fifo7_out_synt	(fifo7_out_synt[9:0]),
		       .valid_out_synt	(valid_out_synt),
		       // Inputs
		       .clk		(clk),
		       .data0_in	(data0_in[9:0]),
		       .data1_in	(data1_in[9:0]),
		       .data2_in	(data2_in[9:0]),
		       .data3_in	(data3_in[9:0]),
		       .idx		(idx[1:0]),
		       .init		(init),
		       .limit_high	(limit_high[2:0]),
		       .limit_low	(limit_low[2:0]),
		       .pop4		(pop4),
		       .pop5		(pop5),
		       .pop6		(pop6),
		       .pop7		(pop7),
		       .push0		(push0),
		       .push1		(push1),
		       .push2		(push2),
		       .push3		(push3),
		       .req		(req),
		       .reset		(reset));
   

endmodule // testbench
