`timescale 1ns / 1ps
module inst_mem(

	input	wire		rst,    // chip select signal
	input	wire[31:0]	addr,  // instruction address 
	output 	reg [31:0]	inst   // instruction
	
);

	reg[31:0]  inst_memory[0:1000];

	initial $readmemb ("machinecode.txt", inst_memory);	// read test Binary Instruction file
always @ (*) begin
	if (rst)
		inst <= 32'b0;
	else
		inst <= inst_memory[addr[31:2]]; // for expressing 4 byte pre inst, just use [31:2] bits  
end

endmodule
