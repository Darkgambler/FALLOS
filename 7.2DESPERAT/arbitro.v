/* ARBITRO FINAL REALIZADO POR:
 * FREDDY ZUNIGA PARA EL PROYECTO 2 DE CIRCUITOS DIGITALES II
 * I SEMESTRE 2021 UNIVERSIDAD DE COSTA RICA */

module arbitro( output reg       pop0, pop1, pop2, pop3,
		output reg 	 push4, push5, push6, push7,
		output reg [1:0] demux,
		input wire 	 empty0, empty1, empty2, empty3,
		input wire 	 full4, full5, full6, full7,
		input wire [1:0] destino,
		input wire 	 reset, clk );

   parameter 			 WAIT = 3'b001;
   parameter 			 POP = 3'b010;
   parameter 			 PUSH = 3'b100;
   reg [2:0] 			 state, next_state;
   wire 			 all_empty, any_full;
   
   assign all_empty = empty0 & empty1 & empty2 & empty3;
   assign any_full = full4 | full5 | full6 | full7;
   
   

   always @( posedge clk ) begin
      state <= next_state;
   end

   always @( * ) begin
      case( state )
	 WAIT:
	   if( !reset ) begin
	      next_state = WAIT;
	   end
	   else begin
	      if( all_empty || any_full ) begin
		 next_state = WAIT;
	      end
	      else begin
		 next_state = POP;
	      end
	   end // else: !if( !reset )
	 POP:
	   if( !reset ) begin
	      next_state = WAIT;
	   end
	   else begin
	      next_state = PUSH;
	   end
	 PUSH:
	   next_state = WAIT;
	 default: 
	   next_state = WAIT;
      endcase // case ( state )
   end // always @ ( * )

   always @( * ) begin
	 pop0 = 1'b0;
	 pop1 = 1'b0;
	 pop2 = 1'b0;
	 pop3 = 1'b0;
	 demux = 2'b00;
      if( state == WAIT ) begin
	 pop0 = 1'b0;
	 pop1 = 1'b0;
	 pop2 = 1'b0;
	 pop3 = 1'b0;
	 demux = 2'b00;
      end // if ( state == WAIT )
      else if( state == POP ) begin
	 if( !empty0 ) begin
	    pop0 = 1'b1;
	    demux = 2'b00;
	 end
	 else begin
	    if( !empty1 ) begin
	       pop1 = 1'b1;
	       demux = 2'b01;
	    end
	    else begin
	       if( !empty2 ) begin
		  pop2 = 1'b1;
		  demux = 2'b10;
	       end
	       else begin
		  if( !empty3 ) begin
		     pop3 = 1'b1;
		     demux = 2'b11;
		  end
		  else begin
		     pop3 = 1'b0;
		     demux = 2'b00;
		  end
	       end // else: !if( !empty2 )
	    end // else: !if( !empty1 )
	 end // else: !if( !empty0 )
      end // if ( state == POP )
      else begin
	 demux <= demux;
	 pop0 <= 1'b0;
	 pop1 <= 1'b0;
	 pop2 <= 1'b0;
	 pop3 <= 1'b0;
      end
	 
   end // always @ ( * )
   
	       
   always @( * ) begin
      if( state == WAIT ) begin //// wait = 1
 	 push4 = 1'b0;
	 push5 = 1'b0;
	 push6 = 1'b0;
	 push7 = 1'b0;
      end
      else if( state == PUSH ) begin /// push = 4
	 if( destino == 2'b00 ) begin
	    push4 = 1'b1;
	    push5 = 1'b0;
	    push6 = 1'b0;
	    push7 = 1'b0;
	 end
	 else if( destino == 2'b01 ) begin
	    push4 = 1'b0;
	    push5 = 1'b1;
	    push6 = 1'b0;
	    push7 = 1'b0;
	 end
	 else if( destino == 2'b10 ) begin
	    push4 = 1'b0;
	    push5 = 1'b0;
	    push6 = 1'b1;
	    push7 = 1'b0;
	 end
	 else begin
	    push4 = 1'b0;
	    push5 = 1'b0;
	    push6 = 1'b0;
	    push7 = 1'b1;
	 end // else: !if( destino == 2'b10 )
      end // if ( state == PUSH )
      else begin
	 push4 = 1'b0;
	 push5 = 1'b0;
	 push6 = 1'b0;
	 push7 = 1'b0;
      end // else: !if( state == PUSH )
   end // 	   

	     
endmodule // arbitro

