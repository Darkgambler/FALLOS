`include "integracion.v"
`include "synth_integracion.v"
`include "probador.v"
`include "./UTILIDADES/cmos_cells.v"

module testbench;
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			clk;			// From PROBADOR of probador.v
   wire [9:0]		fifo0_i;		// From PROBADOR of probador.v
   wire [9:0]		fifo1_i;		// From PROBADOR of probador.v
   wire [9:0]		fifo2_i;		// From PROBADOR of probador.v
   wire [9:0]		fifo3_i;		// From PROBADOR of probador.v
   wire [9:0]		fifo4_out;		// From CONDUCTUAL of integracion.v
   wire [9:0]		fifo4_out_synt;		// From SINTETIZADO of synth_integracion.v
   wire [9:0]		fifo5_out;		// From CONDUCTUAL of integracion.v
   wire [9:0]		fifo5_out_synt;		// From SINTETIZADO of synth_integracion.v
   wire [9:0]		fifo6_out;		// From CONDUCTUAL of integracion.v
   wire [9:0]		fifo6_out_synt;		// From SINTETIZADO of synth_integracion.v
   wire [9:0]		fifo7_out;		// From CONDUCTUAL of integracion.v
   wire [9:0]		fifo7_out_synt;		// From SINTETIZADO of synth_integracion.v
   wire			pop4;			// From PROBADOR of probador.v
   wire			pop5;			// From PROBADOR of probador.v
   wire			pop6;			// From PROBADOR of probador.v
   wire			pop7;			// From PROBADOR of probador.v
   wire			push0;			// From PROBADOR of probador.v
   wire			push1;			// From PROBADOR of probador.v
   wire			push2;			// From PROBADOR of probador.v
   wire			push3;			// From PROBADOR of probador.v
   wire			reset;			// From PROBADOR of probador.v
   // End of automatics

   probador PROBADOR( /*AUTOINST*/
		     // Outputs
		     .fifo0_i		(fifo0_i[9:0]),
		     .fifo1_i		(fifo1_i[9:0]),
		     .fifo2_i		(fifo2_i[9:0]),
		     .fifo3_i		(fifo3_i[9:0]),
		     .push0		(push0),
		     .push1		(push1),
		     .push2		(push2),
		     .push3		(push3),
		     .pop4		(pop4),
		     .pop5		(pop5),
		     .pop6		(pop6),
		     .pop7		(pop7),
		     .reset		(reset),
		     .clk		(clk),
		     // Inputs
		     .fifo4_out		(fifo4_out[9:0]),
		     .fifo5_out		(fifo5_out[9:0]),
		     .fifo6_out		(fifo6_out[9:0]),
		     .fifo7_out		(fifo7_out[9:0]));
   integracion CONDUCTUAL( /*AUTOINST*/
			  // Outputs
			  .fifo4_out		(fifo4_out[9:0]),
			  .fifo5_out		(fifo5_out[9:0]),
			  .fifo6_out		(fifo6_out[9:0]),
			  .fifo7_out		(fifo7_out[9:0]),
			  // Inputs
			  .fifo0_i		(fifo0_i[9:0]),
			  .fifo1_i		(fifo1_i[9:0]),
			  .fifo2_i		(fifo2_i[9:0]),
			  .fifo3_i		(fifo3_i[9:0]),
			  .push0		(push0),
			  .push1		(push1),
			  .push2		(push2),
			  .push3		(push3),
			  .pop4			(pop4),
			  .pop5			(pop5),
			  .pop6			(pop6),
			  .pop7			(pop7),
			  .reset		(reset),
			  .clk			(clk));
   synth_integracion SINTETIZADO( /*AUTOINST*/
				 // Outputs
				 .fifo4_out_synt	(fifo4_out_synt[9:0]),
				 .fifo5_out_synt	(fifo5_out_synt[9:0]),
				 .fifo6_out_synt	(fifo6_out_synt[9:0]),
				 .fifo7_out_synt	(fifo7_out_synt[9:0]),
				 // Inputs
				 .clk			(clk),
				 .fifo0_i		(fifo0_i[9:0]),
				 .fifo1_i		(fifo1_i[9:0]),
				 .fifo2_i		(fifo2_i[9:0]),
				 .fifo3_i		(fifo3_i[9:0]),
				 .pop4			(pop4),
				 .pop5			(pop5),
				 .pop6			(pop6),
				 .pop7			(pop7),
				 .push0			(push0),
				 .push1			(push1),
				 .push2			(push2),
				 .push3			(push3),
				 .reset			(reset));

endmodule // testbench
