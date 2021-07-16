/* ARBITRO FINAL REALIZADO POR:
 * FREDDY ZUNIGA PARA EL PROYECTO 2 DE CIRCUITOS DIGITALES II
 * I SEMESTRE 2021 UNIVERSIDAD DE COSTA RICA */

module arbitro( output reg       pop0, pop1, pop2, pop3,
		output reg 	 push4, push5, push6, push7,
		output reg [1:0] demux, destino,
		input wire 	 empty0, empty1, empty2, empty3,
		input wire 	 full4, full5, full6, full7,
		input wire 	 disparador,
		input wire [1:0] destino0, destino1, 
		input wire [1:0] destino2, destino3,
		input wire 	 reset, clk );

   //reg [1:0]   destino;
   wire        all_emptys = empty0 && empty1 && empty2 && empty3;

   reg 	       counter_control;
   reg 	       pulso_counter, inicio_counter;
   wire 	       full;
   assign full = full4 | full5 | full6 | full7;
   
   
   
   
   always @( posedge clk ) begin
      if( !reset ) begin
	 counter_control <= 0;
      end
      else begin
	 counter_control <= counter_control + 1;
      end
   end

   


   always @( * ) begin
      if( !reset ) begin
	 push4 = 0;
      end
      else begin
	 if( destino == 0 && !full && !all_emptys 
	     && counter_control % 2 != 0
	     /*&& destino0 != 2'b00*/ ) begin
	    push4 = 1;
	 end
	 else begin
	    push4 = 0;
	 end
      end // else: !if( !reset )
   end // always @ ( * )
   
   always @( * ) begin
      if( !reset ) begin
	 push5 = 0;
      end
      else begin
	 if( destino == 1 && !full && !all_emptys 
	     && counter_control % 2 != 0) begin
	    push5 = 1;
	 end
	 else begin
	    push5 = 0;
	 end
      end // else: !if( !reset )
   end // always @ ( * )

   always @( * ) begin
      if( !reset ) begin
	 push6 = 0;
      end
      else begin
	 if( destino == 2 && !full 
	     && counter_control % 2 != 0 ) begin
	    push6 = 1;
	 end
	 else begin
	    push6 = 0;
	 end
      end // else: !if( !reset )
   end // always @ ( * )

   always @( * ) begin
      if( !reset ) begin
	 push7 = 0;
      end
      else begin
	 if( destino == 3 && !full 
	     && counter_control % 2 != 0 ) begin
	    push7 = 1;
	 end
	 else begin
	    push7 = 0;
	 end
      end // else: !if( !reset )
   end // always @ ( * )
   

   always @( posedge clk ) begin
      if( !reset ) begin
	 demux <= 2'b00;
	 destino <= 2'b00;
      end
      else begin
	 if( !empty0 ) begin
	    demux <= 2'b00;
	    destino <= destino0;
	 end
	 else begin
	    if( !empty1 ) begin
	       demux <= 2'b01;
	       destino <= destino1;
	    end
	    else begin
	       if( !empty2 ) begin
		  demux <= 2'b10;
		  destino <= destino2;
	       end
	       else begin
		  if( !empty3 ) begin
		     demux <= 2'b11;
		     destino <= destino3;
		  end
		  else begin
		     demux <= 2'b00;
		     destino <= 2'b00;
		  end
	       end // else: !if( !empty2 )
	    end // else: !if( !empty1 )
	 end // else: !if( !empty0 )
      end // else: !if( !reset )
   end // always @ ( * )
   

	       
   always @( * ) begin
      if( !reset ) begin
	 pop0 = 0;
      end
      else begin
	 if( !empty0 && counter_control % 2 == 0 ) begin
	    pop0 = 1;
	 end
	 else begin
	    pop0 = 0;
	 end
      end // else: !if( !reset )
   end // always @ ( * )

   always @( * ) begin
      if( !reset ) begin
	 pop1 = 0;
      end
      else begin
	 if( empty0 && !empty1 
	     && counter_control % 2 == 0 ) begin
	    pop1 = 1;
	 end
	 else begin
	    pop1 = 0;
	 end
      end // else: !if( !reset )
   end // always @ ( * )
   
   
   always @( * ) begin
      if( !reset ) begin
	 pop2 = 0;
      end
      else begin
	 if( empty0 && empty1 && !empty2 
	     && counter_control % 2 == 0) begin
	    pop2 = 1;
	 end
	 else begin
	    pop2 = 0;
	 end
      end // else: !if( !reset )
   end // always @ ( * )

   
   always @( * ) begin
      if( !reset ) begin
	 pop3 = 0;
      end
      else begin
	 if( empty0 && empty1 && empty2 && !empty3 
	     && counter_control % 2 == 0) begin
	    pop3 = 1;
	 end
	 else begin
	    pop3 = 0;
	 end
      end // else: !if( !reset )
   end // always @ ( * )

	     
endmodule // arbitro

