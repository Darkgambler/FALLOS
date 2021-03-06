module probador( output reg [9:0] data0_in, data1_in,
		 output reg [9:0] data2_in, data3_in,
		 output reg 	  push0, push1, push2, push3,
		 output reg 	  pop4, pop5, pop6, pop7,
		 output reg 	  clk, reset, init, req,
		 output reg [2:0] limit_low, limit_high,
		 output reg [1:0] idx, 
		 input wire [9:0] fifo4_out, fifo5_out,
		 input wire [9:0] fifo6_out, fifo7_out,
		 input wire [4:0] counter_out, 
		 input wire [9:0] fifo4_out_synt, fifo5_out_synt,
		 input wire [9:0] fifo6_out_synt, fifo7_out_synt,
		 input wire [4:0] counter_out_synt  );


   reg [9:0] 			  data0, data1, data2, data3;
   reg [2:0] 			  limitlow, limithigh;
   reg [1:0] 			  idx_n;
   reg 				  push0_n, push1_n, push2_n, push3_n;
   reg 				  pop4_n, pop5_n, pop6_n, pop7_n;
   reg 				  reset_n, init_n, req_n;
   reg 				  valid4, valid5, valid6, valid7;

   always @( posedge clk ) begin
      valid4 <= pop4;
      valid5 <= pop5;
      valid6 <= pop6;
      valid7 <= pop7;
   end
   
   initial begin
      $dumpfile( "000.vcd" );
      $dumpvars( 0 );
   end

   initial begin
      clk = 0;
      idx_n = 2'b00;
      req_n = 1'b0;
      reset_n = 0;
      init_n = 0;
      {data0, data1, data2, data3} = $random;
      limitlow = 1;
      limithigh = 7;
      {push0_n,push1_n,push2_n, push3_n} = 4'h0;
      {pop4_n, pop5_n, pop6_n, pop7_n} = 4'h0;
   end

   always begin
      #1 clk = !clk;
   end

   always @( posedge clk ) begin
      reset <= reset_n;
      init <= init_n;
      data0_in <= data0;
      data1_in <= data1;
      data2_in <= data2;
      data3_in <= data3;
      limit_low <= limitlow;
      limit_high <= limithigh;
      push0 <= push0_n;
      push1 <= push1_n;
      push2 <= push2_n;
      push3 <= push3_n;
      pop4 <= pop4_n;
      pop5 <= pop5_n;
      pop6 <= pop6_n;
      pop7 <= pop7_n;  
      req <= req_n;
      idx <= idx_n;
   end

   integer k = 0;
   
   initial begin
      // PASO 1: SACAR BLOQUE RESET MANTENIENDO INIT EN ALTO
      //#15 reset_n = 1;
      #2 init_n = 1;
      #4 reset_n = 1;
      
      // PASO 2: CAMBIAR 2
      
      limitlow = 3;
      limithigh = 6;
      #5 limitlow = 2;
      limithigh = 7;      
      #15
      init_n = 0;
      limitlow = 1;
      limithigh = 4;

      #5;
      
      // METE PAQUETES DE DATOS A CADA FIFO DE
      // ENTRADA CON EL FIN DE LLENAR LOS DE SALIDA
      /*
      repeat( 8 ) begin	
	 data0[9:8] = 2'b00 + k;
	 data0[7:0] = $random; 
	 push0_n = 1'b1; 
	 data1[9:8] = 2'b00 + k;
	 data1[7:0] = $random; 
	 push1_n = 1'b1; 
	 data2[9:8] = 2'b00 + k;
	 data2[7:0] = $random; 
	 push2_n = 1'b1;
	 if( k < 4 ) begin
	    data3[9:8] = 2'b00 + k;
	    data3[7:0] = $random; 
	    push3_n = 1'b1;
	 end
	 else begin
	    data3 = 'b0;
	    push3_n = 1'b0;
	 end
	 #2;
	 k = k + 1;
      end // 
      data0 = 'b0;
      data1 = 'b0;
      data2 = 'b0;
      data3 = 'b0;
      push0_n = 1'b0; 
      push1_n = 1'b0; 
      push2_n = 1'b0; 
      push3_n = 1'b0;
      #50;
      #2 pop4_n = 1'b1;
      #2 pop4_n = 1'b0;
      #2 pop5_n = 1'b1;
      #2 pop5_n = 1'b0;
      #2 pop6_n = 1'b1;
      #2 pop6_n = 1'b0;
      #2 pop7_n = 1'b1;
      #2 pop7_n = 1'b0;

      repeat( 6 ) begin ///6
      #2 pop4_n = 1'b1;
      pop5_n = 1'b1;
      pop6_n = 1'b1;
      pop7_n = 1'b1;
      end
      
      #2 pop4_n = 1'b0;
      pop5_n = 1'b0;
      pop6_n = 1'b0;
      pop7_n = 1'b0;
      
      //#2 pop5_n = 1'b1;
      //#2 pop5_n = 1'b0;

      
      #50;
*/
      repeat( 8 ) begin	
	 data0[9:8] = 2'b00 + k;
	 data0[7:0] = $random; 
	 push0_n = 1'b1; 
	 data1[9:8] = 2'b00 + k;
	 data1[7:0] = $random; 
	 push1_n = 1'b1; 
	 data2[9:8] = 2'b00 + k;
	 data2[7:0] = $random; 
	 push2_n = 1'b1;
	 data3[9:8] = 2'b00 + k;
	 data3[7:0] = $random; 
	 push3_n = 1'b1;
	 #2;
	 k = k + 1;
      end // 
      data0 = 'b0;
      data1 = 'b0;
      data2 = 'b0;
      data3 = 'b0;
      push0_n = 1'b0; 
      push1_n = 1'b0; 
      push2_n = 1'b0; 
      push3_n = 1'b0;

      #60
      repeat( 8 ) begin	
	 data0[9:8] = 2'b00 + k;
	 data0[7:0] = $random; 
	 push0_n = 1'b1; 
	 data1[9:8] = 2'b00 + k;
	 data1[7:0] = $random; 
	 push1_n = 1'b1; 
	 data2[9:8] = 2'b00 + k;
	 data2[7:0] = $random; 
	 push2_n = 1'b1; 
	 //data3[9:8] = 2'b00 + k;
	 //data3[7:0] = $random; 
	 //push3_n = 1'b1;
	 #2;
	 k = k + 1;
      end // repeat ( 6 )
      data0 = 'b0;
      data1 = 'b0;
      data2 = 'b0;
      push0_n = 1'b0; 
      push1_n = 1'b0; 
      push2_n = 1'b0; 
/*
      data3[9:8] = 2'b00 + k;
      data3[7:0] = $random; 
      push3_n = 1'b0;*/
      #2
      data3 = 'b0;
      push3_n = 1'b0;
      
      #100;
      pop4_n = 1'b1;   
      #2 pop4_n = 1'b0;
      #2 pop5_n = 1'b1;   
      #2 pop5_n = 1'b0;
      #2 pop6_n = 1'b1;   
      #2 pop6_n = 1'b0;
      #2 pop7_n = 1'b1;   
      #2 pop7_n = 1'b0;

      repeat( 5 ) begin ///6
      #2 pop4_n = 1'b1;
      pop5_n = 1'b1;
      pop6_n = 1'b1;
      pop7_n = 1'b1;
      end
      
      #2 pop4_n = 1'b0;
      pop5_n = 1'b0;
      pop6_n = 1'b0;
      pop7_n = 1'b0;
            
      #2 pop4_n = 1'b1;
      #2 pop4_n = 1'b0;
      #2 pop5_n = 1'b1;
       pop6_n = 1'b1;  
       pop7_n = 1'b1;
      #2
       pop7_n = 1'b0;    
       pop5_n = 1'b0;  
       pop6_n = 1'b0;
      #2 pop5_n = 1'b1;
      #2  
       pop5_n = 1'b0;

      #10
	repeat(3 ) begin
      #2 pop4_n = 1'b1;
      pop5_n = 1'b1;
      pop6_n = 1'b1;
      pop7_n = 1'b1;
      end
      
      #2 pop4_n = 1'b0;
      pop5_n = 1'b0;
      pop6_n = 1'b0;
      pop7_n = 1'b0;
      #20
	repeat( 1 ) begin
      #2 pop4_n = 1'b1;
      pop5_n = 1'b1;
      pop6_n = 1'b1;
      pop7_n = 1'b1;
      end
      
      #2 pop4_n = 1'b0;
      pop5_n = 1'b0;
      pop6_n = 1'b0;
      pop7_n = 1'b0; 

      #2 pop4_n = 1'b1;
      #2 pop4_n = 1'b0;
      #2 pop4_n = 1'b1;
      #2 pop4_n = 1'b0;
      #2 pop4_n = 1'b1;
      #2 pop4_n = 1'b0;
      
      #2 pop5_n = 1'b1;
      #2 pop5_n = 1'b0;
      #2 pop5_n = 1'b1;
      #2 pop5_n = 1'b0;
      
      #2 pop6_n = 1'b1;
      #2 pop6_n = 1'b0;
      #2 pop6_n = 1'b1;
      #2 pop6_n = 1'b0;

      
      #2 pop7_n = 1'b1;
      #2 pop7_n = 1'b0;
      #2 pop7_n = 1'b1;
      #2 pop7_n = 1'b0;
      #2 pop7_n = 1'b1;
      #2 pop7_n = 1'b0;
      #2 pop7_n = 1'b1;
      #2 pop7_n = 1'b0;
      

     /*
      #2 pop4_n = 1'b1;
      #2 pop4_n = 1'b0;
      #2 pop5_n = 1'b1;   
      #2 pop5_n = 1'b0;
      #2 pop6_n = 1'b1;   
      #2 pop6_n = 1'b0;
      #2 pop7_n = 1'b1;   
      #2 pop7_n = 1'b0;*/
      /*
      #50;
      repeat( 6 ) begin
      #2 pop4_n = 1'b1;
      pop5_n = 1'b1;
      pop6_n = 1'b1;
      pop7_n = 1'b1;
      end
      #2 pop4_n = 1'b0;
      pop5_n = 1'b0;
      pop6_n = 1'b0;
      pop7_n = 1'b0;
      #50;
      repeat( 2 ) begin
      #2 pop4_n = 1'b1;
      pop5_n = 1'b1;
      pop6_n = 1'b1;
      pop7_n = 1'b1;
      end
      #2 pop4_n = 1'b0;
      pop5_n = 1'b0;
      pop6_n = 1'b0;
      pop7_n = 1'b0;
*/
      #50 $finish;
   end

endmodule // probador

