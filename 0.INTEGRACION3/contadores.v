/* VERSION ALTERNATIVA DE CONTADORES, REALIZADA POR:
 * FREDDY ZUNIGA PARA EL PROYECTO 2 DE CIRCUITOS DIGITALES II
 * I SEMESTRE 2021 UNIVERSIDAD DE COSTA RICA */

module contadores #( parameter CBITS = 5 ) 
                   ( output reg [CBITS-1:0] counter_out,
		     output reg 	    valid_out,
		     input wire [1:0] 	    idx,
		     input wire 	    push0, push1, push2, push3,
		     input wire 	    idle, req, clk, reset );

   reg [CBITS-1:0] counter0, counter1, counter2, counter3;
   reg 		   valid0, valid1, valid2, valid3;
   

   /// LOGICA DE LAS SIGNALS DE SALIDA
   always @( * ) begin: OUTPUTS_LOGIC
      if( !idle ) begin
	 counter_out = 'b0;
	 valid_out = 1'b0;
      end
      else begin
	 if( req ) begin
	    valid_out = 1'b1;
	    if( idx == 2'b00 ) begin
	       counter_out = counter0;
	    end
	    else if( idx == 2'b01 ) begin
	       counter_out = counter1;
	    end
	    else if( idx == 2'b10 ) begin
	       counter_out = counter2;
	    end
	    else begin
	       counter_out = counter3;
	    end
	 end // if ( req )
	 else begin
	    counter_out = 'b0;
	    valid_out = 1'b0;
	 end // else: !if( req )	 
      end // else: !if( !idle )
   end // always @ ( * )
   
	 
   ///// ESTE BLOQUE FUNCIONA PORQUE LOS CONTADORES AUMENTAN UNO A LA
   ///// VEZ POR LA ARQUITECTURA, NO SE PUEDE USAR PARA OTRO TIPO DE
   ///// APLICACIONES SIMILARES.
   always @( posedge clk ) begin: COUNTER_FILL   
      if( !reset ) begin
	 counter0 <= 'b0;
	 counter1 <= 'b0;
	 counter2 <= 'b0;
	 counter3 <= 'b0;
      end
      else begin
	 if( push0 ) begin
	    counter0 <= counter0 + 1'b1;
	 end
	 else begin
	    counter0 <= counter0;
	 end
	 if( push1 ) begin
	    counter1 <= counter1 + 1'b1;
	 end
	 else begin
	    counter1 <= counter1;
	 end
	 if( push2 ) begin
	    counter2 <= counter2 + 1'b1;
	 end
	 else begin
	    counter2 <= counter2;
	 end
	 if( push3 ) begin
	    counter3 <= counter3 + 1'b1;
	 end
	 else begin
	    counter3 <= counter3;
	 end
      end // else: !if( !reset )
   end // always @ ( * )

   //always @( posedge clk ) begin
      
endmodule		 
