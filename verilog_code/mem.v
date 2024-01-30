`timescale 1ns / 1ps
module MEM (
    input   wire        rst,
    input   wire        WriteReg_i,
    input   wire[4:0]   WriteDataAddr_i,
    input   wire[4:0]   ALUop_i,
    input   wire[31:0]  WriteData_i,
    input   wire[31:0]  MemAddr_i,
    input   wire[31:0]  Reg_i,
    input   wire[31:0]  MemData_i,
    output  wire        MemWE_o,
    output  reg         WriteReg_o,
    output  reg         MemCE_o,
    output  reg [4:0]   WriteDataAddr_o,
    output  reg [31:0]  WriteData_o,
    output  reg [31:0]  MemAddr_o,
    output  reg [31:0]  MemData_o
);
    reg mem_we;
    assign MemWE_o = mem_we;


always @ (*) begin
    if (rst)
        WriteDataAddr_o <= 5'b0;
    else
        WriteDataAddr_o <= WriteDataAddr_i;
end


always @ (*) begin
    if (rst)
        WriteReg_o <= 1'b0;
    else
        WriteReg_o <= WriteReg_i;
end

always @ (*) begin
    if (rst)
        MemData_o <= 32'b0;
    else if (ALUop_i == 5'b10101)  // sw
        MemData_o <= Reg_i;
end


always @ (*) begin
    if (rst)
        WriteData_o <= 32'b0;
    else begin
        if (ALUop_i == 5'b10100)  // lw
            WriteData_o <= MemData_i;
        else
            WriteData_o <= WriteData_i;
    end
end


always @ (*) begin
    if (rst)
        MemAddr_o <= 32'b0;
    else begin
        if (ALUop_i == 5'b10101 || ALUop_i ==5'b10100)  // lw or sw 20, 21
            MemAddr_o <= MemAddr_i; // address setting
        else
            MemAddr_o <= 32'b0;
    end
end


always @ (*) begin
    if (rst)
        MemCE_o <= 1'b0;
    else begin
        if (ALUop_i == 5'b10101 || ALUop_i==5'b10100)  // lw or sw
            MemCE_o <= 1'b1;
        else
            MemCE_o <= 1'b0;
    end
end
 
always @ (*) begin
    if (rst)
        mem_we <= 1'b0;
    else begin
        if (ALUop_i == 5'b10100)  // lw
            mem_we <= 1'b0;
        else if (ALUop_i == 5'b10101)  // sw
            mem_we <= 1'b1;
        else
            mem_we <= 1'b0;
    end
end

endmodule