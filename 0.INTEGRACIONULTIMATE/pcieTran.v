`include "arbitro.v"
`include "xfifo.v"
`include "contadores.v"

module pcieTran( output wire [9:0] fifo4_out, fifo5_out,
		 output wire [9:0] fifo6_out, fifo7_out,
		 output wire [4:0] counter_out,
		 output wire 	   valid_out,
		 input wire [9:0]  data0_in, data1_in,
		 input wire [9:0]  data2_in, data3_in,
		 input wire 	   push0, push1, push2, push3,
		 input wire 	   pop4, pop5, pop6, pop7,
		 input wire 	   clk, reset, init, req,
		 input wire [2:0]  limit_low, limit_high,
		 input wire [1:0]  idx );

   wire 			  reset_system, idle;
   wire [2:0] 			  limit_low_mach, limit_high_mach;
   wire [1:0] 			  demux0; 

   wire 			  emptys, retorno, AFULL;
   wire 			  empty0, empty1, empty2, empty3;
   wire [1:0] 			  dest;

   assign retorno = push0 | push1 | push2 | push3;
   assign AFULL = afull4 | afull5 | afull6 | afull7;
   assign APOPS = pop0 | pop1 | pop2 | pop3;
   reg 				  retornador;

   always @( posedge clk ) begin
      retornador <= APOPS;
   end
   reg ret;
   always @( * ) begin
      if( retornador && AFULL ) begin
	 ret = 1'b1;
      end
      else begin
	 ret = 1'b0;
      end
   end
   
   
   
   
   
   assign emptys = fifo0empty & fifo1empty & fifo2empty & fifo3empty & 
		   fifo4empty & fifo5empty & fifo6empty & fifo7empty;
   
   //// salidas de los fifos de entrada
   wire [9:0] fifo0_out, fifo1_out, fifo2_out, fifo3_out;
   wire       fifo0full, fifo1full, fifo2full, fifo3full;
   wire       fifo0empty, fifo1empty, fifo2empty, fifo3empty;
   wire       fifo4empty, fifo5empty, fifo6empty, fifo7empty;
   wire       errorfifo0, errorfifo1, errorfifo2, errorfifo3;
   wire       errorfifo4, errorfifo5, errorfifo6, errorfifo7;
   wire       pop0, pop1, pop2, pop3;
   
   wire [4:0] counter0_out, counter1_out;
   wire [4:0] counter2_out, counter3_out;
   wire       valid0_out, valid1_out;
   wire       valid2_out, valid3_out;
   
   reg 	      reset_system2, a;
   
   always @( posedge clk ) begin
      a <= reset_system;     
      reset_system2 <= a;
   end
   
   
   //// FIFOS DE ENTRADA
   xfifo FIFO0( fifo0_out, fifo0full, fifo0empty, errorfifo0, 
	       data0_in, limit_high_mach, limit_low_mach, 
	       push0, pop0, clk, reset_system, 1'b0 );
   xfifo FIFO1( fifo1_out, fifo1full, fifo1empty, errorfifo1, 
	       data1_in, limit_high_mach, limit_low_mach, 
	       push1, pop1, clk, reset_system, 1'b0 );
   xfifo FIFO2( fifo2_out, fifo2full, fifo2empty, errorfifo2, 
	       data2_in, limit_high_mach, limit_low_mach, 
	       push2, pop2, clk, reset_system, 1'b0 );
   xfifo FIFO3( fifo3_out, fifo3full, fifo3empty, errorfifo3, 
	       data3_in, limit_high_mach, limit_low_mach, 
	       push3, pop3, clk, reset_system, ret );
   
   satanic_machine MACH( reset_system, idle, limit_low_mach, limit_high_mach,
			 limit_low, limit_high, clk, reset, init, emptys );
   
   arbitro ARBITRO( pop0, pop1, pop2, pop3, push4, push5, push6, push7,
		    demux0, dest, fifo0empty, fifo1empty, fifo2empty, 
		    fifo3empty, afull4, afull5, afull6, afull7,
		    reset_system, clk );

   wire [9:0] 			  fifo4_in, fifo5_in, fifo6_in, fifo7_in;
   
   misc MISCELANEO( fifo4_in, fifo5_in, fifo6_in, fifo7_in, dest,
		    fifo0_out, fifo1_out, fifo2_out, fifo3_out, 
		    demux0, reset_system, clk );
   
   //// FIFOS DE SALIDA


   xfifo FIFO4( fifo4_out, afull4, fifo4empty, errorfifo4, 
	       fifo4_in, limit_high_mach, limit_low_mach, 
	       push4, pop4, clk, reset_system2, 1'b0 );  
   xfifo FIFO5( fifo5_out, afull5, fifo5empty, errorfifo5, 
	       fifo5_in, limit_high_mach, limit_low_mach, 
	       push5, pop5, clk, reset_system2, 1'b0 ); 
   xfifo FIFO6( fifo6_out, afull6, fifo6empty, errorfifo6, 
	       fifo6_in, limit_high_mach, limit_low_mach, 
	       push6, pop6, clk, reset_system2, 1'b0 ); 
   xfifo FIFO7( fifo7_out, afull7, fifo7empty, errorfifo7, 
	       fifo7_in, limit_high_mach, limit_low_mach, 
	       push7, pop7, clk, reset_system2, 1'b0 );  
   
   

   contadores COUNTERS( counter_out, valid_out, idx, push4, push5, 
			push6, push7, idle, req, clk, reset_system2 );
   
endmodule // pcieTran

module misc( output reg [9:0] fifo4_in, fifo5_in, fifo6_in, fifo7_in,
	     output reg [1:0] dest,
	     input wire [9:0]  fifo0_out, fifo1_out, fifo2_out, fifo3_out,
	     input wire [1:0]  demux0,
	     input wire        reset, clk );

   reg [9:0] 		      dato_inter;
   

   always @( * ) begin
      if( !reset ) begin
	 dest = 2'b00;
      end
      else begin
	 dest = dato_inter[9:8];
      end
   end
   
 
   
   always @( * ) begin
      if( !reset ) begin
	 dato_inter = 'h0;
      end
      else begin 
      if( demux0 == 2'b00 ) begin
	 dato_inter = fifo0_out;
      end
      else if( demux0 == 2'b01 ) begin
	 dato_inter = fifo1_out;
      end
      else if( demux0 == 2'b10 ) begin
	 dato_inter = fifo2_out;
      end
      else begin
	 dato_inter = fifo3_out;
      end
      end
   end // always @ ( * )

   always @( * ) begin
      if( dest == 2'b00 ) begin
	 fifo4_in = dato_inter;
	 fifo5_in = 'h0;
	 fifo6_in = 'h0;
	 fifo7_in = 'h0;
      end
      else if( dest == 2'b01 ) begin
	 fifo5_in = dato_inter;
	 fifo4_in = 'h0;
	 fifo6_in = 'h0;
	 fifo7_in = 'h0;
      end
      else if( dest == 2'b10 ) begin
	 fifo6_in = dato_inter;
	 fifo4_in = 'h0;
	 fifo5_in = 'h0;
	 fifo7_in = 'h0;
      end
      else begin
	 fifo7_in = dato_inter;
	 fifo4_in = 'h0;
	 fifo5_in = 'h0;
	 fifo6_in = 'h0;
      end
   end // always @ ( * )
   
endmodule	 
	 
   
module satanic_machine( output reg reset_out, idle_out,
			output reg [2:0] limit_low_out, limit_high_out,
			input wire [2:0] limit_low, limit_high,
			input wire 	 clk, reset, init, emptys );

   reg [3:0] 				state, next_state;
   
   parameter 				RESET = 4'b0001;
   parameter 				INIT = 4'b0010;
   parameter 				IDLE = 4'b0100;
   parameter 				ACTIVE = 4'b1000;

   always @( posedge clk ) begin: STATE_LOGIC
      state <= next_state;
   end

   always @( * ) begin: NEXT_STATE_LOGIC
      case( state )
	 RESET:
	   if( !reset ) begin
	      next_state = RESET;
	   end
	   else begin
	      next_state = INIT;
	   end
	 INIT:
	   if( !reset ) begin
	      next_state = RESET;
	   end
	   else begin
	      if( init ) begin
		 next_state = INIT;
	      end
	      else begin
		 next_state = IDLE;
	      end
	   end 
	 IDLE: //4
	   if( !reset ) begin
	      next_state = RESET;
	   end
	   else begin
	      if( init ) begin
		 next_state = INIT;
	      end
	      else begin
		 if( emptys ) begin
		    next_state = IDLE;
		 end
		 else begin
		    next_state = ACTIVE;
		 end
	      end // else: !if( init )
	   end // else: !if( !reset )
	 ACTIVE:
	   if( !reset ) begin
	      next_state = RESET;
	   end
	   else begin
	      if( init ) begin
		 next_state = INIT;
	      end
	      else begin
		 if( emptys ) begin
		    next_state = IDLE;
		 end
		 else begin
		    next_state = ACTIVE;
		 end
	      end // else: !if( init )
	   end	   
	 default: next_state = RESET;
      endcase // case ( state )
   end // always @ ( * )
   

   always @( posedge clk ) begin
      if( init ) begin
	 limit_low_out <= limit_low;
	 limit_high_out <= limit_high;
      end
      else begin
	 limit_low_out <= limit_low_out;
	 limit_high_out <= limit_high_out;
      end
   end
   
	      
   always @( * ) begin: OUTPUTS_LOGIC
      if( state == RESET ) begin //1
	 reset_out = 1'b0;
	 idle_out = 1'b0;
	 //limit_low_out = 'h0;
	 //limit_high_out = 'h0;
      end
      else if( state == INIT ) begin //2
	 //limit_low_out = limit_low;
	 //limit_high_out = limit_high;
	 idle_out = 1'b0;
	 if( init ) begin
	    reset_out = 1'b0;
	 end
	 else begin
	    reset_out = 1'b1;
	 end
      end
      else if( state == IDLE ) begin //4
	 reset_out = 1'b1;
	 idle_out = 1'b1;
      end
      else begin //8
	 reset_out = 1'b1;
	 idle_out = 1'b0;
      end
   end // block: OUTPUTS_LOGIC

endmodule // satanic_machine

      
	 
		 
 
