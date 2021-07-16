module probador( output reg [1:0] dest,
		 output reg 	  empty0, empty1, empty2, empty3,
		 output reg 	  afull0, afull1, afull2, afull3,
		 output reg 	  reset, clk, 
		 input wire 	  pop0_out, pop1_out, 
		 input wire 	  pop2_out, pop3_out,
		 input wire 	  pop0_out_synt, pop1_out_synt, 
		 input wire 	  pop2_out_synt, pop3_out_synt,
		 input wire 	  push0_out, push1_out, 
		 input wire 	  push2_out, push3_out,
		 input wire 	  push0_out_synt, push1_out_synt, 
		 input wire 	  push2_out_synt, push3_out_synt,
		 input wire [1:0] demux0_out, demux0_out_synt );

   reg [3:0] 		    emptys, afulls;
   reg [1:0] 		    dest_n;
   reg 			    reset_n;
   wire [3:0] 		    allpops, allpops_synt;
   wire [3:0] 		    allpushs, allpushs_synt;

   assign allpops = {pop0_out, pop1_out, pop2_out, pop3_out};
   assign allpops_synt = {pop0_out_synt, pop1_out_synt,
			  pop2_out_synt, pop3_out_synt};
   assign allpushs = {push0_out, push1_out, push2_out, push3_out};
   assign allpushs_synt = {push0_out_synt, push1_out_synt,
			   push2_out_synt, push3_out_synt};
   
   always @( posedge clk ) begin
      if( allpops != allpops_synt ) begin
	 $display( "Discrepancia en los pop_outs en %t", $time );
      end
      if( allpushs != allpushs_synt ) begin
	 $display( "Discrepancia en los push_outs en %t", $time );
      end
      if( demux0_out != demux0_out_synt ) begin
	 $display( "Discrepancia en los demux0_outs en %t", $time );
      end
   end
      
      
   initial begin
      $dumpfile( "000pops.vcd" );
      $dumpvars( 0 );
   end

   initial begin
      clk = 0;
      reset_n = 0;
      emptys = 4'b0000;
      afulls = 4'b0000;
      dest_n = 2'b00;
   end

   always begin
      #1 clk = !clk;
   end

   always @( posedge clk ) begin
      {empty3, empty2, empty1, empty0} <= emptys;
      {afull3, afull2, afull1, afull0} <= afulls;
      dest <= dest_n;
      reset <= reset_n;
   end

   initial begin
      #5 reset_n = 1;
      // PRUEBA CON empty0 EN BAJO, LO QUE SIGNIFIA QUE
      // EL FIFO0 DE ENTRADA NO ESTA EMPTY POR LO QUE
      // POR LA PRIORIDAD EL ARBITRO PONDRA EN ALTO pop0_out
      repeat( 10 ) begin
	 #2 emptys[3:1] = $random;
	 emptys[0] = 1'b0;
	 dest_n = $random;
      end
      // PRUEBA CON empty0 EN ALTO Y empty1 EN BAJO, Y LOS
      // DEMAS EMPTYS RANDOM, POR LO QUE EL ARBITRO PONDRA
      // EN ALTO pop1_out.
      repeat( 10 ) begin
	 #2 emptys[3:2] = $random;
	 emptys[1] = 1'b0;
	 emptys[0] = 1'b1;
	 dest_n = $random;
      end
      // PRUEBA CON empty0 EN ALTO Y empty1 EN ALTO, Y
      // empty2 en bajo, el empty3 random. ARBITRO PONDRA
      // EN ALTO LA SENAL DE pop2_out.
      repeat( 5 ) begin
	 #2 emptys[3] = $random;
	 emptys[2] = 1'b0;
	 emptys[1] = 1'b1;
	 emptys[0] = 1'b1;
	 dest_n = $random;
      end
      // PRUEBA CON empty0 EN ALTO Y empty1 EN ALTO, 
      // empty2 en ALTO, Y empty3 en bajo. ARBITRO PONDRA
      // EN ALTO LA SENAL DE pop3_out.
      #2 emptys[3] = 1'b0;
      emptys[2] = 1'b1;
      emptys[1] = 1'b1;
      emptys[0] = 1'b1;
      dest_n = $random;
      // PRUEBA CON TODOS LOS EMPTYS EN ALTO( FIFOS VACIOS )
      // EL ARBITRO NO HACE POPS A NINGUN FIFO EN ESTE CASO
      #2 emptys[3] = 1'b1;
      emptys[2] = 1'b1;
      emptys[1] = 1'b1;
      emptys[0] = 1'b1;
      dest_n = $random;
      #10 $finish;
   end

endmodule // probador

