`timescale 1ns / 1ps

module riscv_soc_tb();
  reg     clk, rst;
  
  always #10 clk =~clk;
  
  initial begin
	clk = 1'b0;
    #10 rst =0;
    #10 rst= 1;
    #40 rst=0;

  end

       
  wire[31:0] inst_addr, inst;
  wire  inst_ce, data_ce, data_we;
  wire[31:0] data_addr;
  wire[31:0] wdata;
  wire[31:0] rdata; 
  wire[31:0] verify; 
 
 	riscv riscv0(
		.clk(clk),
		.rst(rst),
		.inst_addr_o(inst_addr),
		.inst_i(inst),
		.inst_ce_o(inst_ce),
		.data_ce_o(data_ce),	
		.data_we_o(data_we),
		.data_addr_o(data_addr),
		.data_i(rdata),
		.data_o(wdata)		
	);
	
	inst_mem inst_mem0(
		.rst(rst),
		.addr(inst_addr),
		.inst(inst)	
	);

	data_mem data_mem0(
		.clk(clk),
		.ce(data_ce),
		.we(data_we),
		.addr(data_addr),
		.data_i(wdata),
		.data_o(rdata),
		.verify(verify)
	);

    endmodule