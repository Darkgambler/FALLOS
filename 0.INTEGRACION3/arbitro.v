/* ARBITRO FINAL REALIZADO POR:
 * FREDDY ZUNIGA PARA EL PROYECTO 2 DE CIRCUITOS DIGITALES II
 * I SEMESTRE 2021 UNIVERSIDAD DE COSTA RICA */

module arbitro( output reg       pop0_out, pop1_out, pop2_out, pop3_out,
		output reg 	 push0_out, push1_out, push2_out, push3_out,
		output reg [1:0] demux0_out,
		output reg [3:0] retorno,
		input wire [1:0] dest,
		input wire 	 empty0, empty1, empty2, empty3,
		input wire 	 afull0, afull1, afull2, afull3,
		input wire 	 reset, clk );

   reg 				 empty0_s, empty1_s, empty2_s, empty3_s;
   assign any_full = afull0 | afull1 | afull2 | afull3;
   assign all_empty = empty0_s & empty1_s & empty2_s & empty3_s;

   reg 				 any_full_ex;
   wire 			 any_full2;
   
   always @( posedge clk ) begin
      any_full_ex <= any_full;
   end
   assign any_full2 = any_full | any_full_ex;
   
   
   
   always @( posedge clk ) begin
      if( !reset ) begin
	 retorno <= 4'b0000;
      end
      else begin
	 if( !any_full2 ) begin
	    retorno <= 4'b0000;
	 end
	 else begin
	    if( pop0_out ) begin
	       retorno[0] <= 1'b1;
	       retorno[1] <= 1'b0;
	       retorno[2] <= 1'b0;
	       retorno[3] <= 1'b0;
	    end
	    if( pop1_out ) begin
	       retorno[0] <= 1'b0;
	       retorno[1] <= 1'b1;
	       retorno[2] <= 1'b0;
	       retorno[3] <= 1'b0;
	    end
	    if( pop2_out ) begin
	       retorno[0] <= 1'b0;
	       retorno[1] <= 1'b0;
	       retorno[2] <= 1'b1;
	       retorno[3] <= 1'b0;
	    end
	    if( pop3_out ) begin
	       retorno[0] <= 1'b0;
	       retorno[1] <= 1'b0;
	       retorno[2] <= 1'b0;
	       retorno[3] <= 1'b1;
	    end
	 end // else: !if( !any_full )
      end // else: !if( !reset )
   end // always @ ( posedge clk )
   
	       
	    

   always @( * ) begin: PUSH_LOGIC;
      if( !reset ) begin
	 push0_out = 1'b0;
	 push1_out = 1'b0;
	 push2_out = 1'b0;
	 push3_out = 1'b0;
      end
      else begin
	 if( any_full2 || all_empty ) begin
	    push0_out = 1'b0;
	    push1_out = 1'b0;
	    push2_out = 1'b0;
	    push3_out = 1'b0;
	 end
	 else begin 
	 if( dest == 2'b00 ) begin
	    push0_out = 1'b1;
	    push1_out = 1'b0;
	    push2_out = 1'b0;
	    push3_out = 1'b0;
	 end
	 else if( dest == 2'b01 ) begin
	    push0_out = 1'b0;
	    push1_out = 1'b1;
	    push2_out = 1'b0;
	    push3_out = 1'b0;
	 end
	 else if( dest == 2'b10 ) begin
	    push0_out = 1'b0;
	    push1_out = 1'b0;
	    push2_out = 1'b1;
	    push3_out = 1'b0;
	 end
	 else if( dest == 2'b11 ) begin
	    push0_out = 1'b0;
	    push1_out = 1'b0;
	    push2_out = 1'b0;
	    push3_out = 1'b1;
	 end
	 else begin 
	    push0_out = 1'b0;
	    push1_out = 1'b0;
	    push2_out = 1'b0;
	    push3_out = 1'b0;
	 end // else: !if( dest == 2'b11 )
	 end
      end // else: !if( !reset )
   end // block: PUSH_LOGIC;
   
	
   always @( posedge clk ) begin
      empty0_s <= empty0;
      empty1_s <= empty1;
      empty2_s <= empty2;
      empty3_s <= empty3;
   end
 
   always @( * ) begin: DEMUX_LOGIC
      if( !reset ) begin
	 demux0_out = 2'b00;
      end
      else begin
	 if( !empty0_s ) begin
	    demux0_out = 2'b00;
	 end
	 else
	   if( !empty1_s ) begin
	      demux0_out = 2'b01;
	   end
	   else begin
	      if( !empty2_s ) begin
		 demux0_out = 2'b10;
	      end
	      else begin
		 if( !empty3_s ) begin
		    demux0_out = 2'b11;
		 end
		 else begin
		    demux0_out = 2'b00;
		 end
	      end // else: !if( !empty2 )
	   end // else: !if( !empty1 )
      end // else: !if( !reset )
   end // block: DEMUX_LOGIC
   

   always @( * ) begin: POP_LOGIC
      if( !reset ) begin
	 pop0_out = 1'b0;
	 pop1_out = 1'b0;
	 pop2_out = 1'b0;
	 pop3_out = 1'b0;
      end
      else begin
	 if( !empty0 ) begin
	    if( !any_full ) begin
	       pop0_out = 1'b1;
	       pop1_out = 1'b0;
	       pop2_out = 1'b0;
	       pop3_out = 1'b0;
	    end
	    else begin
	       pop0_out = 1'b0;
	       pop1_out = 1'b0;
	       pop2_out = 1'b0;
	       pop3_out = 1'b0;
	    end // else: !if( !any_full )
	 end
	 else begin
	    if( !empty1 ) begin
	       if( !any_full ) begin
		  pop0_out = 1'b0;
		  pop1_out = 1'b1;
		  pop2_out = 1'b0;
		  pop3_out = 1'b0;
	       end
	       else begin
		  pop0_out = 1'b0;
		  pop1_out = 1'b0;
		  pop2_out = 1'b0;
		  pop3_out = 1'b0;
	       end // else: !if( !any_full )
	    end
	    else begin
	       if( !empty2 ) begin
		  if( !any_full ) begin
		     pop0_out = 1'b0;
		     pop1_out = 1'b0;
		     pop2_out = 1'b1;
		     pop3_out = 1'b0;
		  end
		  else begin
		     pop0_out = 1'b0;
		     pop1_out = 1'b0;
		     pop2_out = 1'b0;
		     pop3_out = 1'b0;
		  end // else: !if( !any_full )
	       end
	       else begin
		  if( !empty3 ) begin
		     if( !any_full ) begin
			pop0_out = 1'b0;
			pop1_out = 1'b0;
			pop2_out = 1'b0;
			pop3_out = 1'b1;
		     end
		     else begin
			pop0_out = 1'b0;
			pop1_out = 1'b0;
			pop2_out = 1'b0;
			pop3_out = 1'b0;
		     end
		  end
		  else begin
		     pop0_out = 1'b0;
		     pop1_out = 1'b0;
		     pop2_out = 1'b0;
		     pop3_out = 1'b0;
		  end
	       end
	    end // else: !if( !empty1 )
	 end // else: !if( !empty0 )
      end // else: !if( !reset )
   end // block: POP_LOGIC
   
 
	 
endmodule // arbitro

