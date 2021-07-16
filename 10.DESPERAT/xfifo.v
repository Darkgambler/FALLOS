/* FIFO FINAL REALIZADO POR:
 * FREDDY ZUNIGA PARA EL PROYECTO 2 DE CIRCUITOS DIGITALES II
 * I SEMESTRE 2021 UNIVERSIDAD DE COSTA RICA */

`include "ram.v"

module xfifo #( parameter DATA_BITS = 10,
	       parameter ADDR_BITS = 3 )
             ( output wire [DATA_BITS-1:0] fifo_data_out,
	       output reg 		  fifo_full_out, fifo_empty_out,
	       output reg 		  error_fifo_out,
	       input wire [DATA_BITS-1:0] fifo_data_in,
	       input wire [ADDR_BITS-1:0] high_limit, low_limit,
	       input wire 		  write, read, clk, reset );

   parameter 		 SIZE = 2 ** ADDR_BITS;
   reg [ADDR_BITS-1:0]  write_ptr, read_ptr;

   reg 			 fase_read, fase_write, fase;
   reg 			 full;
   
   always @( * ) begin
      if( full && write || fifo_empty_out && read ) begin
	 error_fifo_out = 1;
      end
      else begin
	 error_fifo_out = 0;
      end
   end
   
   always @( * ) begin
      if( fase_read == fase_write ) begin
	 fase = 1;
      end
      else begin
	 fase = 0;
      end
   end

   always @( * ) begin
      if( write_ptr == read_ptr ) begin
	 if( fase ) begin
	    fifo_empty_out = 1;
	    full = 0;
	 end
	 else begin
	    fifo_empty_out = 0;
	    full = 1;
	 end
      end
      else begin
	 full = 0;
	 fifo_empty_out = 0;
      end // else: !if( write_ptr == read_ptr )
   end // always @ ( * )

   always @( * ) begin
      if( write_ptr - read_ptr >= high_limit || full ) begin
	 fifo_full_out = 1;
      end
      else begin
	 fifo_full_out = 0;
      end
   end
   
	    
		

   always @( posedge clk ) begin
      if( !reset ) begin
	 fase_write <= 0;
      end
      else begin
	 if( write_ptr == 7 ) begin
	    if( write ) begin
	       fase_write <= fase_write + 1;
	    end
	    else begin
	       fase_write <= fase_write;
	    end
	 end
	 else begin
	    fase_write <= fase_write;
	 end // else: !if( write_ptr == 7 )
      end // else: !if( !reset )
   end // always @ ( posedge clk )
   
   always @( posedge clk ) begin
      if( !reset ) begin
	 fase_read <= 0;
      end
      else begin
	 if( read_ptr == 7 ) begin
	    if( read ) begin
	       fase_read <= fase_read + 1;
	    end
	    else begin
	       fase_read <= fase_read;
	    end
	 end
	 else begin
	    fase_read <= fase_read;
	 end // else: !if( write_ptr == 7 )
      end // else: !if( !reset )
   end // always @ ( posedge clk )	    

   /* MEMORIA DEL FIFO DUAL PORT */
   ram #( DATA_BITS, ADDR_BITS )
   MEM( fifo_data_out, fifo_data_in, write_ptr, 
	read_ptr, write, read, clk );

   /* SI FULL == EMPTY == 0 ES OPERACION NORMAL
    * LO QUE QUIERE DECIR QUE HAY AL MENOS UN
    * ESPACIO DE LA MEMORIA LLENO Y PERO NO TODA 
    * LA MEMORIA LLENA.
    * WRITE_PTR VA POR DELANTE SIEMPRE POR LO QUE SI
    * WRITE_PTR < READ_PTR SIGNIFICA QUE WRITE_PTR
    * YA SOBREPASO EL MAXIMO DE LA MEMORIA QUE EN ESTE
    * CASO ES 7.
    */

   always @( posedge clk ) begin
      if( !reset ) begin
	 write_ptr <= 3'b000;
      end
      else begin
	 if( write ) begin
	    write_ptr <= write_ptr + 1;
	 end
	 else begin
	    write_ptr <= write_ptr;
	 end
      end // else: !if( !reset )
   end // always @ ( posedge clk )

   always @( posedge clk ) begin
      if( !reset ) begin
	 read_ptr <= 3'b000;
      end
      else begin
	 if( read ) begin
	    read_ptr <= read_ptr + 1;
	 end
	 else begin
	    read_ptr <= read_ptr;
	 end
      end // else: !if( !reset )
   end // always @ ( posedge clk )
   
      
   

endmodule
