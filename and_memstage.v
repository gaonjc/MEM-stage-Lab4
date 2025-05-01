`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2025 01:07:15 PM
// Design Name: 
// Module Name: and_memstage
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

// AND gate module for branch control
module and_memstage(
    input wire m_ctlout,
    input wire zero,
    output wire pcsrc
);

    assign pcsrc = m_ctlout & zero;

endmodule