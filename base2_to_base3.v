`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:56:28 11/27/2022 
// Design Name: 
// Module Name:    base2_to_base3 
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
module base2_to_base3(
	base3_no,
	done,
	base2_no,
	en,
	clk);

parameter width = 16;

output 	 	[2*width - 1 : 0]  	base3_no; 
output 		     	    			 	done;
input    	[width - 1 : 0]	 	base2_no;
input 					 			 	en;
input	             	 			 	clk;
	
// se initializeaza varaibile corespunzatoare automatului finit
`define READ		'b00
`define EXEC		'b01
`define EXEC2		'b10
`define DONE		'b11

// se construiesc 2 registrii oentru starea curenta si starea urmatoare
reg 	[width - 1 : 0] 		state = `READ;
reg 	[width - 1 : 0]		next_state;

reg 	[2*width - 1 : 0] 		base3_no_reg;
reg 	[width - 1 : 0] 			base2_no_r;

wire 	[width - 1 : 0] 		Q;
wire 	[width - 1 : 0]		R;
reg 	[width - 1 : 0] 		N;
reg 	[width - 1 : 0] 		D;

reg 	[width - 1 : 0]		done_reg;

div_algo DIV(
	.Q(Q),
	.R(R),
	.N(N),
	.D(D));

assign base3_no = base3_no_reg;
assign done = done_reg;

reg 	[width - 1 : 0] 		count;

// se executa partea secventiala
always @(posedge clk) begin
	state <= next_state;
end

// se executa partea combinationala
always @(*) begin
	case(state)
		`READ: begin
			// se tine evidenta unui numar ce reprezinta numarul de executii a impartirii,
			// a numarului de deplasari
			count = 0;
			
			// se initializeaza registrii corespunzatori iesirilor cu 0
			base3_no_reg = 0;
			done_reg = 0;
			
			// se verifica valoarea de intrare 'en'(enable)
			// pentru trecerea in starea urmatoare
			if (en == 1) begin
				base2_no_r = base2_no;
				next_state = `EXEC;
			end
			if (en == 0) begin 
				next_state = `READ;
			end
		end
		
		`EXEC: begin
			// se initializeaza valorile de intrare pentru algoritmul de impartire
			N = base2_no_r;
			D = 3;
			count = count + 1;
			next_state = `EXEC2;
		end
		
		`EXEC2: begin
			// se deplaseaza la dreapta cu 2 biti numarul in baza 3
			base3_no_reg = base3_no_reg >> 2;
			base3_no_reg[31 : 30] = R[1 : 0];
			
			base2_no_r = Q;
			
			if	(base2_no_r != 0) begin
				next_state = `EXEC;
			end
			if	(base2_no_r == 0) begin
				// deplasarea la dreapta pentru aflarea numarului final in baza 3
				base3_no_reg = base3_no_reg >> 32 - count;
				next_state = `DONE;
			end
		end
		
		`DONE: begin
			done_reg = 1;
			next_state = `READ;
		end
		
		default: next_state = `READ;
	endcase
end

endmodule 