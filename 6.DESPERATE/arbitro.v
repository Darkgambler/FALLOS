/* ARBITRO FINAL REALIZADO POR:
 * FREDDY ZUNIGA PARA EL PROYECTO 2 DE CIRCUITOS DIGITALES II
 * I SEMESTRE 2021 UNIVERSIDAD DE COSTA RICA */

module arbitro( output reg       pop0, pop1, pop2, pop3,
		output reg 	 push4, push5, push6, push7,
		output reg [1:0] demux,
		input wire [1:0] destino,
		input wire 	 empty0, empty1, empty2, empty3,
		input wire 	 full0, full1, full2, full3,
		input wire 	 reset, clk );

   wire [3:0] emptys = {empty3, empty2, empty1, empty0};
   reg [3:0] pops, pushs;
   reg 	     fifos_salida_llenos;
   reg 	     fifos_entrada_vacios;
   reg 	     hacerpoppush;

   wire      dest;
   assign dest = destino;
   

   always @( * ) begin
      if( !reset ) begin
	 fifos_salida_llenos = 1'b0;
      end
      else begin
	 if( full0 || full1 || full2 || full3 ) begin
	    fifos_salida_llenos = 1'b1;
	 end
	 else begin
	    fifos_salida_llenos = 1'b0;
	 end
      end
   end // always @ ( * )

   
   always @( * ) begin
      if( !reset ) begin
	 fifos_entrada_vacios = 1'b1;
      end
      else begin
	 if( empty3 && empty2 && empty1 && empty0 ) begin
	    fifos_entrada_vacios = 1'b1;
	 end
	 else begin
	    fifos_entrada_vacios = 1'b0;
	 end
      end
   end // always @ ( * )
   
   	 

   always @( * ) begin     
      if( !reset ) begin
	 {pop3, pop2, pop1, pop0} = 4'b0000;
	 {push7, push6, push5, push4} = 4'b0000;
      end
      else begin
	 {pop3, pop2, pop1, pop0} = pops;
	 {push7, push6, push5, push4} = pushs;
      end 
   end
   


   
	 


   always @( * ) begin
      if( !reset ) begin
	 pops = 4'b0000;
      end
      else begin
	 if( !fifos_entrada_vacios && !fifos_salida_llenos ) begin
	    if( emptys == 4'b1111 ) begin
	       pops = 4'b0000;
	    end
	    else if( emptys[0] == 1'b0 ) begin
	       pops = 4'b0001;
	    end
	    else if( emptys[1:0] == 2'b01 ) begin
	       pops = 4'b0010;
	    end
	    else if( emptys[2:0] == 3'b011 ) begin
	       pops = 4'b0100;
	    end
	    else if( emptys[3:0] == 4'b0111 ) begin
	       pops = 4'b1000;
	    end
	    else begin
	       pops = 4'b0000;
	    end
	 end // if ( !fifos_entrada_vacios && !fifos_salida_llenos )
	 else begin
	    pops = 4'b0000;
	 end
      end
   end // always @ ( posedge clk )
   
   always @( * ) begin
      if( !reset ) begin
	 pushs = 4'b0000;
      end
      else begin
	 if( !fifos_entrada_vacios && !fifos_salida_llenos ) begin
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
	 end // if ( !fifos_entrada_vacios && !fifos_salida_llenos )
	 else begin
	    pushs = 4'b0000;
	 end
      end // else: !if( !reset )
   end // always @ ( posedge clk )
   
   always @( * ) begin
      if( !reset ) begin
	 demux = 2'b00;
      end
      else begin
	 if( pops == 4'b0001 ) begin
	    demux = 2'b00;
	 end
	 else if( pops == 4'b0010 ) begin
	    demux = 2'b01;
	 end
	 else if( pops == 4'b0100 ) begin
	    demux = 2'b10;
	 end
	 else if( pops == 4'b1000 ) begin
	    demux = 2'b11;
	 end
	 else begin
	    demux = 2'b00;
	 end
      end // else: !if( !reset )
   end // always @ ( * )*/
   
      
endmodule // arbitro

