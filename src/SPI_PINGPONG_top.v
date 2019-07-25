module SPI_PINGPONG_top(
    input clk,
    input sck,
    input ssel,
    input rst_n,
    input mosi,
    output wire miso,
    output wire DRDY
);
    // SPI 
    wire byteReceived; // 在第八个sck_risingEdge置为1

    wire [7:0] receivedData; // shift register
    // wire dataNeeded; // MOSI ready信号
    // // wire [7:0] dataToSend;  

    // reg[1:0] sselr;
    // wire ssel_active = ~ssel; // ssel 低电平有效

    // RAM0
    wire[7:0] doutb0;
    wire[6:0] addra0;
    wire[6:0] addrb0;
    wire finisha0;
    wire finishb0;

    // reg[7:0] data_counter;

    // RAM1
    wire[7:0] doutb1;
    wire[6:0] addra1;
    wire[6:0] addrb1;
    wire finisha1;
    wire finishb1;
    wire[7:0] dina1;
    wire wea1;
    wire readya0;

    assign DRDY = readya0 && readyb1;
    

    SPI_slave  u_SPI_slave (
        .clk                     ( clk                     ),
        .sck                     ( sck                     ),
        .rst_n                   ( rst_n                   ),
        .mosi                    ( mosi                    ),
        .ssel                    ( ssel                    ),
        .miso                    ( miso                    ),
        .receivedData            ( receivedData  [7:0]  ),
        .dataToSend              ( doutb1 [7:0]   ),
        .byteReceived            ( byteReceived),

        // 可选项
        .readya0                 (readya0),
        .readyb1                 (readyb1),
        
        .addra0                  (addra0 [6:0]),
        .addrb1                  (addrb1 [6:0]),
        .finisha0                (finisha0),
        .finishb1                (finishb1)
        );

    // MOSI RAM
    PINGPONG_RAM  u0_PINGPONG_RAM (
        .clka                    ( clk            ),
        .rsta                    ( !rst_n            ),
        .addra                   ( addra0    [6:0]  ),
        .wea                     ( byteReceived    ), //
        .dina                    ( receivedData [7:0] ),
        .finisha                 ( finisha0         ),
        .readya                  ( readya0          ),

        .clkb                    ( clk            ),
        .rstb                    ( !rst_n            ),
        .addrb                   ( addrb0    [6:0]  ),
        .finishb                 ( finishb0         ),
        .doutb                   ( doutb0    [7:0] ),
        .readyb                  ( readyb0          )
        );

    // MISO RAM
    PINGPONG_RAM  u1_PINGPONG_RAM (
        .clka                    ( clk            ),
        .rsta                    ( !rst_n            ),
        .addra                   ( addra1    [6:0]  ),
        .wea                     ( wea1    ),
        .dina                    ( dina1 [7:0] ),
        .finisha                 ( finisha1         ),
        .readya                  ( readya1          ),

        .clkb                    ( clk            ),
        .rstb                    ( !rst_n            ),
        .addrb                   ( addrb1    [6:0]  ),
        .finishb                 ( finishb1         ),
        .doutb                   ( doutb1    [7:0] ),
        .readyb                  ( readyb1          )
        );

    // doutb0为输入的数据, dina1为DSP输出的数据
    DSP_module DSP_module(
        .clk(clk), 
        .rst_n(rst_n),
        .datain(doutb0),
        .dataout(dina1),


        .readyb0(readyb0),
        .readya1(readya1),
        .addrb0(addrb0), 
        .addra1(addra1),
        .finishb0(finishb0),
        .finisha1(finisha1),
        .wea(wea1)
    );
  
endmodule