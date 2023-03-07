`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:26:55 11/27/2022 
// Design Name: 
// Module Name:    div_algo 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module div_algo(
   Q,
   R,
   N,
   D);

parameter 							width = 16;

output   	[width - 1 : 0]   Q;
output  		[width - 1 : 0]   R;
input    	[width - 1 : 0]   N;
input    	[width - 1 : 0]   D;

integer 								i;

reg 			[width - 1 : 0] 	q;
reg 			[width - 1 : 0] 	r;

assign Q = q;
assign R = r;

always @(*) begin
	if (D != 0) begin
		// se initializeaza catul si restul cu 0
		q = 0;
		r = 0;
		for(i = width - 1; i >= 0; i = i-1) begin
			// se realizeaza deplasarea la stanga cu un bit
			r = r << 1;
			// se seteaza bitul cel mai putin semnificativ 
			//al restului cu valoarea bitului i a deimpartitului
			r[0] = N[i];
			if(r >= D) begin
				r = r - D;
				q[i] = 1;
			end
		end
	end
end

endmodule 