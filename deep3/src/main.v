---- main.v -------------------------------------------

// Verilog harjoitus v3.4
// https://kirjoitusalusta.fi/hacklab-x-digi-perus-harjoituksia

`timescale 1ns / 1ps
`default_nettype none


module main(
        input   wire                slowclk,
        input   wire    [7:0]       sw_in,
        output  reg     [7:0]       sw_out
    );

    reg         [7:0]   state_next;
    reg         [7:0]   state = 0;

    // Next state kombinaatiologiikka
    always @* begin
        if (state == 9) begin
            state_next = 0;
        end else begin
            state_next = state + 1;
        end
    end
    
    // Sekvenssilogiikka
    always @(posedge slowclk) begin
        state <= state_next; 
    end

    // Output kombinaatiologiikka
    always @* begin
        sw_out = state;
    end
    
endmodule