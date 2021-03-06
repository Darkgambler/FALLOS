
module misc( output reg [9:0] fifo4_in, fifo5_in, fifo6_in, fifo7_in,
	     output reg [1:0] dest,
	     input wire [9:0]  fifo0_out, fifo1_out, fifo2_out, fifo3_out,
	     input wire [1:0]  demux0,
	     input wire        reset, clk );

   reg [9:0] 		      dato_inter;
   
   wire [1:0] 		      probar;
   always @( * ) begin
      dest = dato_inter[9:8];
   end

   
   always @( * ) begin
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
