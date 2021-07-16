/* MEMORY MODIFICADA POR FREDDY ZUNIGA CERDAS PARA EL PROYECTO 2  
 * DE CIRCUITOS DIGITALES II, I SEMESTRE 2021, 
 * UNIVERSIDAD DE COSTA RICA
 * MODIFICADA DE UNA MEMORY RAM OBTENIDA EN EL SIGUIENTE LUGAR:
 * https://www.intel.com/content/www/us/en/programmable/support/
 * support-resources/design-examples/design-software/verilog/
 * ver-single-port-ram.html
 */

module ram #( parameter DATA_BITS = 10,
	      parameter ADDR_BITS = 3 )
            ( output reg [DATA_BITS-1:0]  data_out,
	      input wire [DATA_BITS-1:0]  data_in,
	      input wire [ADDR_BITS-1:0]  addr_write,
	      input wire [ADDR_BITS-1:0]  addr_read,
	      input wire 		  write, read, clk, reset );

   
   parameter 		RAM_SIZE = 2 ** ADDR_BITS;
    
   
   // Declare the RAM variable
   reg [DATA_BITS-1:0] 	memoria [RAM_SIZE-1:0];
   
   // Variable to hold the registered read address
   reg [ADDR_BITS-1:0] 	addr_reg;
   
   always @( posedge clk ) begin
      // Write
      if ( write ) begin
	 memoria[addr_write] <= data_in;
      end	
   end

   always @( posedge clk ) begin
      if( !reset ) begin
	 data_out <= 'h0;
      end
      else begin
	 if( read ) begin
	    data_out <= memoria[addr_read];
	 end
      end
   end


   //// BORRABLE DE COTROL /////
   reg [9:0] memoria0, memoria1, memoria2, memoria3, memoria4,
	     memoria5, memoria6, memoria7;
   always @( * ) begin
      memoria0 = memoria[0];
      memoria1 = memoria[1];
      memoria2 = memoria[2];
      memoria3 = memoria[3];
      memoria4 = memoria[4];
      memoria5 = memoria[5];
      memoria6 = memoria[6];
      memoria7 = memoria[7];
   end
      
   
endmodule
