// Verilog harjoitus v3.0
// https://kirjoitusalusta.fi/hacklab-x-digi-perus-harjoituksia

`timescale 1ns / 1ps
`default_nettype none


module main(
        input   wire                slowclk,
        input   wire    [7:0]       sw_in,
        output  wire    [7:0]       sw_out
    );

    wire        [7:0]   state_next;
    reg         [7:0]   state = 0;

    // Next state kombinaatiologiikka
    assign      state_next = state + (~sw_in);
    
    // Sekvenssilogiikka
    always @(posedge slowclk) begin
        state <= state_next; 
    end

    // Output kombinaatiologiikka
    assign      sw_out = state;
    
endmodule