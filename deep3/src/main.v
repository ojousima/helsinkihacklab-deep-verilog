---- main.v -------------------------------------------

// Verilog harjoitus v3.5 - Larson scanner
// https://kirjoitusalusta.fi/hacklab-x-digi-perus-harjoituksia

`timescale 1ns / 1ps
`default_nettype none


module main(
        input   wire                slowclk,
        input   wire    [7:0]       sw_in,
        output  reg     [7:0]       sw_out
    );

    reg         [3:0]   state_next, state = 0;

    // Next state kombinaatiologiikka
    always @* begin
        state_next = state + 1;
        if (state == 13) begin
            state_next = 0;
        end 
        if (~sw_in[0] == 1'b0) begin
            state_next = state;
        end
    end
    
    // Sekvenssilogiikka
    always @(posedge slowclk) begin
        state <= state_next; 
    end

    // Output kombinaatiologiikka
    always @* begin
        sw_out = 8'b00000000;
        case (state)
            0:  sw_out = 8'b00000001;
            1:  sw_out = 8'b00000010;
            2:  sw_out = 8'b00000100;
            3:  sw_out = 8'b00001000;
            4:  sw_out = 8'b00010000;
            5:  sw_out = 8'b00100000;
            6:  sw_out = 8'b01000000;
            7:  sw_out = 8'b10000000;
            8:  sw_out = 8'b01000000;
            9:  sw_out = 8'b00100000;
            10: sw_out = 8'b00010000;
            11: sw_out = 8'b00001000;
            12: sw_out = 8'b00000100;
            13: sw_out = 8'b00000010;
        endcase
     end
    
endmodule
