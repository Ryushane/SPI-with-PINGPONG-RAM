module SPI_PINGPONG(
    input clk,
    input sck,
    input ssel,
    input rst_n,
    input mosi,
    output wire miso,
    output wire dataNeeded,
    output wire readya0
);
    // SPI 
    wire byteReceived; // 在第八个sck_risingEdge置为1

    wire [7:0] receivedData; // shift register
    wire dataNeeded; // MOSI ready信号
    // wire [7:0] dataToSend;  

    reg[1:0] sselr;
    wire ssel_active = ~ssel; // ssel 低电平有效
    wire sck_risingEdge;

    // RAM0
    wire[7:0] doutb0;
    reg[7:0] addra0;
    reg[7:0] addrb0;
    reg finisha0;
    reg finishb0;

    // RAM1
    wire[7:0] doutb1;
    reg[7:0] addra1;
    reg[7:0] addrb1;
    reg finisha1;
    reg finishb1;

    

    SPI_slave  u_SPI_slave (
        .clk                     ( clk                     ),
        .sck                     ( sck                     ),
        .mosi                    ( mosi                    ),
        .ssel                    ( ssel                    ),
        .dataToSend              ( doutb1 [7:0]   ),

        .miso                    ( miso                    ),
        .byteReceived            ( byteReceived            ),
        .receivedData            ( receivedData  [7:0]  ),
        .dataNeeded              ( dataNeeded              ),
        .sck_risingEdge          (sck_risingEdge           )
        );

    // MOSI RAM
    PINGPONG_RAM  u0_PINGPONG_RAM (
        .clka                    ( clk            ),
        .rsta                    ( rst_n            ),
        .addra                   ( addra0    [6:0]  ),
        .wea                     ( byteReceived    ),
        .dina                    ( receivedData [7:0] ),
        .finisha                 ( finisha0         ),
        .readya                  ( readya0          ),

        .clkb                    ( clk            ),
        .rstb                    ( rst_n            ),
        .addrb                   ( addrb0    [6:0]  ),
        .finishb                 ( finishb0         ),
        .doutb                   ( doutb0    [7:0] ),
        .readyb                  ( readyb0          )
        );

    // MISO RAM
    PINGPONG_RAM  u1_PINGPONG_RAM (
        .clka                    ( clk            ),
        .rsta                    ( rst_n            ),
        .addra                   ( addra1    [6:0]  ),
        .wea                     ( byteReceived    ),
        .dina                    ( receivedData [7:0] ),
        .finisha                 ( finisha1         ),
        .readya                  ( readya1          ),

        .clkb                    ( clk            ),
        .rstb                    ( rst_n            ),
        .addrb                   ( addrb1    [6:0]  ),
        .finishb                 ( finishb1         ),
        .doutb                   ( doutb1    [7:0] ),
        .readyb                  ( readyb1          )
        );

    // MOSI 
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            sselr <= 2'b00;
            // byteReceivedr <= 2'b00;
        end
        else begin
            sselr <= { sselr[0], ssel};
            // byteReceivedr <= { byteReceivedr[0], byteReceived};
        end
    end

    wire ssel_risingEdge = (sselr == 2'b01);
    wire ssel_fallingEdge = (sselr == 2'b10);

    // wire byteReceived_risingEdge = (sselr == 2'b01);
    // wire byteReceived_fallingEdge = (sselr == 2'b10);


    always @(posedge clk or negedge rst_n) begin
        if((!rst_n) || (ssel_risingEdge)) begin
            addra0 <= 7'b0;
        end
        else if(byteReceived) begin
            addra0 <= addra0 + 1;
        end
    end

    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            finisha0 <= 0;
        end
        else if(ssel_risingEdge) begin
            finisha0 <= 1;
        end 
        else if(finisha0 == 1) begin
            finisha0 <= ~finisha0; // finishia only last one period
        end
    end


    // MISO
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n || ssel_risingEdge) begin
            addrb1 <= 7'b0;
        end
        // dataNeeded 维持一个SCK
        else if(sck_risingEdge && dataNeeded) begin
            addrb1 <= addrb1 + 1;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            finishb1 <= 0;
        end
        else if(ssel_risingEdge) begin
            finishb1 <= 1;
        end
        else if(finishb1 == 1) begin
            finishb1 = ~finishb1;
        end
    end
endmodule