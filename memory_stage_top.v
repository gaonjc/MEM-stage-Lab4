`timescale 1ns / 1ps

// Memory Stage module with separate control signal inputs
module memory_stage_top(
    input wire clk,
    input wire [31:0] ALUResult,     // ALU result from EX
    input wire [31:0] WriteData,     // Register data from EX (for store)
    input wire [4:0] WriteReg,       // Register destination from EX
    input wire [1:0] WBControl,      // WB control signals from EX
    input wire MemWrite,             // Memory write control
    input wire MemRead,              // Memory read control
    input wire Branch,               // Branch control signal
    input wire Zero,                 // Zero flag from ALU
    output wire [31:0] ReadData,     // Read data from memory
    output wire [31:0] ALUResult_out, // Forwarded ALU result
    output wire [4:0] WriteReg_out,  // Register destination for WB
    output wire [1:0] WBControl_out, // WB control signals for WB stage
    output wire PCSrc                // Branch control signal for IF
);

    // Internal wire to capture data memory output
    wire [31:0] mem_data;
    
    // Instantiate the AND gate for branch control
    and_memstage andgate(
        .m_ctlout(Branch),
        .zero(Zero),
        .pcsrc(PCSrc)
    );
    
    // Instantiate the data memory
    dmem_memstage D_MEM(
        .clk(clk),
        .Address(ALUResult),
        .Write_data(WriteData),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Read_data(mem_data)  // Store output in internal wire
    );
    
    // Instantiate the MEM/WB pipeline register
    memwb_memstage MEM_WB(
        .clk(clk),
        .control_wb_in(WBControl),
        .Read_data_in(mem_data),     // Pass data memory output to MEM/WB register
        .ALU_result_in(ALUResult),
        .Write_reg_in(WriteReg),
        .mem_control_wb(WBControl_out),
        .mem_Read_data(ReadData),    // Connect to module output
        .mem_ALU_result(ALUResult_out),
        .mem_Write_reg(WriteReg_out)
    );

endmodule