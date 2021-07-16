
module misc( output reg [9:0] dato_inter,
	     input wire [9:0]  fifo0_out, fifo1_out, fifo2_out, fifo3_out,
	     input wire [1:0]  demux0,
	     input wire        reset, clk );

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
   
endmodule
