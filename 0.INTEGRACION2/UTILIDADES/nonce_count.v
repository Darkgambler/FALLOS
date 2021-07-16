module nonce_count( output reg [0:7] dataN1_out, dataN2_out,
		    output reg 	      not_found_out,
		    input wire [0:31] nonce,
		    input wire 	      clk_a, inicio );

   // ncount_out[0:7] = ||||| 
   always @( posedge clk_a ) begin
      if( inicio ) begin
	 ncount_out[8:15] <= 8'h01;
	 ncount_out[16:17] <= 2'b00;
	 if( nonce[0:7] != 8'hff ) begin
	    ncount_out[0:7] <= nonce[0:7];
	    ncount_out[18:22] <= 5'b00000;
	    not_found_out <= 1'b0;
	 end
	 else begin
	    if( nonce[8:15] != 8'hff ) begin
	       ncount_out[0:7] <= nonce[8:15];
	       ncount_out[18:22] <= 5'b00001;
	       not_found_out <= 1'b0;
	    end
	    else begin
	       if( nonce[16:23] != 8'hff ) begin
		  ncount_out[0:7] <= nonce[16:23];
		  ncount_out[18:22] <= 5'b00010;
		  not_found_out <= 1'b0;
	       end
	       else begin
		  if( nonce[24:31] != 8'hff ) begin
		     ncount_out[0:7] <= nonce[24:31];
		     ncount_out[18:22] <= 5'b00011;
		     not_found_out <= 1'b0;
		  end
		  else begin
		     ncount_out[0:7] <= 8'hfe;
		     ncount_out[18:22] <= 5'b00011;
		     not_found_out <= 1'b1;
		  end
	       end // else: !if( nonce[16:23] != 8'hff )
	    end // else: !if( nonce[8:15] != 8'hff )
	 end // else: !if( nonce[0:7] != 8'hff )
      end // if ( inicio )
      else begin
	 ncount_out[0:7] <= 8'h00;
	 ncount_out[8:15] <= 8'h00;
	 ncount_out[16:17] <= 2'b00;
	 ncount_out[18:22] <= 5'b00000;
	 not_found_out <= 1'b0;
      end
   end // always @ ( posedge clk_a )
   
endmodule // nonce_count
