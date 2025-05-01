`timescale 1ns / 1ps
// Data memory module

module dmem_memstage(
    input wire clk,
    input wire [31:0] Address,
    input wire [31:0] Write_data,
    input wire MemRead,
    input wire MemWrite,
    output reg [31:0] Read_data
);

    reg [31:0] MEM [0:255]; // 256 words of 32-bit memory
    
    // Initialize memory
    initial begin
        $readmemb("data.mem", MEM);
        for (integer i = 0; i < 6; i = i + 1)
            $display("Memory[%0d] = %h", i, MEM[i]);
    end
    
    // Combinational read logic
    always @(*) begin
        if (MemRead)
            Read_data = MEM[Address[9:2]]; // Word-aligned addressing
        else
            Read_data = 32'b0;
    end
    
    // Sequential write logic
    always @(posedge clk) begin
        if (MemWrite)
            MEM[Address[9:2]] = Write_data;
    end

endmodule