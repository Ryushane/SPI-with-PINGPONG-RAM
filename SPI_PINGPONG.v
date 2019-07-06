module SPI_PINGPONG(clk, sck, ssel, rst_n, din, dout
);

    input clk;
    input sck;
    input wire ssel;
    output reg byteReceived = 1'b0;
    output reg [7:0] receivedData = 8'b00000000;
    output wire dataNeeded;
    input wire[7:0] dataToSend;

    
    input rsta;
    input 
    input [6:0]addra;

SPI_slave  u_SPI_slave (
    .clk                     ( clk                     ),
    .sck                     ( sck                     ),
    .mosi                    ( mosi                    ),
    .ssel                    ( ssel                    ),
    .wire[7:0] dataToSend    ( wire[7:0] dataToSend    ),

    .miso                    ( miso                    ),
    .byteReceived            ( byteReceived            ),
    .reg[7:0] receivedData   ( reg[7:0] receivedData   ),
    .dataNeeded              ( dataNeeded              )
);


PINGPONG_RAM  u_PINGPONG_RAM (
    .clka                    ( clk            ),
    .rsta                    ( rst_n            ),
    .addra                   ( addra    [6:0]  ),
    .wea                     ( wea             ),
    .dina                    ( dina     [15:0] ),
    .finisha                 ( finisha         ),
    .clkb                    ( clk            ),
    .rstb                    ( rst_n            ),
    .addrb                   ( addrb    [6:0]  ),
    .finishb                 ( finishb         ),

    .readya                  ( readya          ),
    .doutb                   ( doutb    [15:0] ),
    .readyb                  ( readyb          )
);