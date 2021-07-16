/* ARBITRO FINAL REALIZADO POR:
 * FREDDY ZUNIGA PARA EL PROYECTO 2 DE CIRCUITOS DIGITALES II
 * I SEMESTRE 2021 UNIVERSIDAD DE COSTA RICA */

module arbitro( output reg       pop0_out, pop1_out, pop2_out, pop3_out,
		output reg 	 push0_out, push1_out, push2_out, push3_out,
		output reg [1:0] demux0_out,
		input wire [1:0] dest,
		input wire 	 empty0, empty1, empty2, empty3,
		input wire 	 afull0, afull1, afull2, afull3,
		input wire 	 reset, clk );

   reg [3:0] 		 pops;
   reg [3:0] 		 pushs;
   
   wire [3:0] 		 emptys;
   wire 		 any_almot_full;
   
	    
   //// AGREGADO
   reg [4:0] 			 contador_markas;
   reg 				 any;
   reg [3:0] 			 emptys_s;
   always @( posedge clk ) begin
      emptys_s <= emptys;
   end
   
   

   always @( posedge clk ) begin
      any <= any_almost_full;
   end
   
   always @( posedge clk ) begin
      if( pops == 4'b0000 ) begin
	 contador_markas <= 0;
      end
      else begin
	 contador_markas <= contador_markas + 1'b1;
      end
   end
   //////
   
   //// any_almost_full SE REFIERE A LOS FIFOS DE SALIDA CLARAMENTE
   assign any_almost_full = afull0 | afull1 | afull2 | afull3;  
   assign emptys[3] = empty3;
   assign emptys[2] = empty2;
   assign emptys[1] = empty1;
   assign emptys[0] = empty0;
   

   always @( * ) begin
      {pop3_out, pop2_out, pop1_out, pop0_out} = pops;
      {push3_out, push2_out, push1_out, push0_out} = pushs;
   end
   
   /// LOGICA DE POP FIFOS DE ENTRADA
   always @( * ) begin: POP_LOGIC
      if( !reset ) begin: RESET_THEN_NOT_POPS
	 pops = 4'b0000;
      end
      else begin
	 if( any_almost_full /*|| contador_markas == 5'd25*/) begin: ANY_ALMOST_FULL_THEN_NOT_POPS
	    pops = 4'b0000;
	 end
	 /// 
	 else begin
	    if( emptys == 4'b1111 ) begin: ALL_FIFOS_EMPTY
	       pops = 4'b0000;
	    end
	    else if( emptys == 4'b0111 ) begin: F0F1F2_EMPTY_F3_NOT_EMPTY
	       pops = 4'b1000;
	    end
	    else if( emptys[2:0] == 3'b011 ) begin: F0F1_EMPTY_F2_NOT_EMPTY
	       pops = 4'b0100;
	    end
	    else if( emptys[1:0] == 2'b01 ) begin: F0_EMPTY_F1_NOT_EMPTY
	       pops = 4'b0010;
	    end
	    else begin: F0_NOT_EMPTY
	       pops = 4'b0001;
	    end
	 end
      end
   end // block: POP_LOGIC

   // LOGICA DE PUSH FIFOS DE SALIDA
   always @( * ) begin: PUSH_LOGIC
      if( !reset ) begin
	 pushs = 4'b0000;
      end
      else begin
	 if( (emptys == 4'b1111) || any_almost_full ) begin
	    pushs = 4'b0000;	    
	    if( emptys == 4'b1111 && contador_markas != 5'd0) begin
	       pushs = 4'b1000;
	    end
	    else begin
	       pushs = 4'b0000;
	    end
	 end
	 else begin   
	    if( dest == 2'b00 ) begin
	       pushs = 4'b0001;
	    end
	    else if( dest == 2'b01 ) begin
	       pushs = 4'b0010;
	    end
	    else if( dest == 2'b10 ) begin
	       pushs = 4'b0100;
	    end
	    else begin
	       pushs = 4'b1000;
	    end
	 end // else: !if( emptys = 4'b1111 )
      end // else: !if( !reset )
   end // block: PUSH_LOGIC

   // CONTROLA LA LOGICA DEL DEMUX0
   // FUE NECESARIO USAR POSEDGE CLK PARA QUE
   // EN LA INTEGRACION NO HICIERA PROBLEMA
   always @( posedge clk ) begin: DEMUX0_LOGIC
      if( !reset ) begin
	 demux0_out <= 2'b00;
      end
      else begin
	 if( any ) begin
	    demux0_out <= demux0_out;
	 end
	 else begin
	    if( pops == 4'b0000 ) begin
	       demux0_out <= demux0_out;
	    end
	    else if( pops == 4'b0001 ) begin
	       demux0_out <= 2'b00;
	    end
	    else if( pops == 4'b0010 ) begin
	       demux0_out <= 2'b01;
	    end 
	    else if( pops == 4'b0100 ) begin
	       demux0_out <= 2'b10;
	    end
	    else begin
	       demux0_out <= 2'b11;
	    end
	 end
      end // else: !if( !reset )
   end // block: DEMUX0_LOGIC
   
	 
endmodule // arbitro

