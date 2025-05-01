`timescale 1ns / 1ps

// MEM/WB pipeline register
module memwb_memstage(
    input wire clk,
    input wire [1:0] control_wb_in,
    input wire [31:0] Read_data_in,
    input wire [31:0] ALU_result_in,
    input wire [4:0] Write_reg_in,
    output reg [1:0] mem_control_wb,
    output reg [31:0] mem_Read_data,
    output reg [31:0] mem_ALU_result,
    output reg [4:0] mem_Write_reg
);

    // Initialize outputs to prevent high impedance or X values
    initial begin
        mem_control_wb = 2'b00;
        mem_Read_data = 32'h00000000;  // Initialize to avoid high impedance
        mem_ALU_result = 32'h00000000;
        mem_Write_reg = 5'h00;
    end

    // Pipeline register update on positive clock edge
    always @(posedge clk) begin
        mem_control_wb <= control_wb_in;
        mem_Read_data <= Read_data_in;   // Direct assignment from input
        mem_ALU_result <= ALU_result_in;
        mem_Write_reg <= Write_reg_in;
    end

endmodule