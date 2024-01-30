`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/06/2023 04:14:11 PM
// Design Name: 
// Module Name: data_mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module data_mem(

	input	wire		clk,
	input	wire		ce,		
	input	wire		we,		// When it's high, write data_mem. Otherwise read data_mem.
	input	wire[31:0]	addr,  // address from EX Module
	input	wire[31:0]	data_i,	// Data waiting for writing into data_mem
	output	reg [31:0]	data_o,	// Data reading from data_mem
	output 	wire[31:0]	verify	
	
);

	reg[7:0]  data[0:32'h400]; // 8bit -> 1 byte
	initial $readmemh ( "data_mem.txt", data );
	assign verify = {data[1], data[2], data[3], data[4]};
	
always @ (posedge clk) begin
	if (ce && we) begin
		data[addr]     <= data_i[7:0];
		data[addr + 1] <= data_i[15:8];
		data[addr + 2] <= data_i[23:16];
		data[addr + 3] <= data_i[31:24];
	end
end
always @ (*) begin
	if (!ce)
		data_o <= 32'b0;
	else if(we == 1'b0) begin
		data_o <= {
					data[addr + 3],
					data[addr + 2],
					data[addr + 1],
					data[addr]   };
	end else
		data_o <= 32'b0;
end		
endmodule