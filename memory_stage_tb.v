`timescale 1ns / 1ps

module memory_stage_tb();
    reg clk;
    reg [31:0] ALUResult, WriteData;
    reg [4:0] WriteReg;
    reg [1:0] WBControl;
    reg MemWrite, MemRead, Branch, Zero;
    wire [31:0] ReadData, ALUResult_out;
    wire [4:0] WriteReg_out;
    wire [1:0] WBControl_out;
    wire PCSrc;

    // Instantiate the Unit Under Test (UUT)
    memory_stage_top uut (
        .clk(clk),
        .ALUResult(ALUResult),
        .WriteData(WriteData),
        .WriteReg(WriteReg),
        .WBControl(WBControl),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Branch(Branch),
        .Zero(Zero),
        .ReadData(ReadData),
        .ALUResult_out(ALUResult_out),
        .WriteReg_out(WriteReg_out),
        .WBControl_out(WBControl_out),
        .PCSrc(PCSrc)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
    end
    
    // Test vectors - match exactly the original test
    initial begin
        // Mem Read
        ALUResult = 32'h00000004;
        WriteData = 32'h12345678;
        WriteReg = 5'h02;
        WBControl = 2'b01;
        MemWrite = 0;
        MemRead = 1;
        Branch = 0;
        Zero = 0;

        #10; 

        // Mem Write
        MemWrite = 1;
        MemRead = 0;
        #10; // Allow write to occur
        MemWrite = 0;
        MemRead = 1;
        #10; // Verify write by reading back

        // Branch
        Branch = 1;
        Zero = 1;
        #10; // Check PCSrc

        $finish;
    end
    
    // Add monitoring for debugging
    initial begin
        $monitor("Time=%0t | MemRead=%b, MemWrite=%b, Branch=%b | ReadData=%h, ALUResult=%h, PCSrc=%b",
                $time, MemRead, MemWrite, Branch, ReadData, ALUResult_out, PCSrc);
    end
endmodule