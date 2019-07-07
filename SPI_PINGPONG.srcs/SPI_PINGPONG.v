module SPI_PINGPONG(
    input clk,
    input sck,
    input ssel,
    input rst_n,
    input mosi,
    output wire miso,
    output reg dataNeeded,
    output wire readya
);

    wire byteReceived; // 在第八个sck_risingEdge置为1

    wire [7:0] receivedData; // shift register
    wire dataNeeded; // MOSI ready信号
    wire [7:0] dataToSend;  

    reg[1:0] sselr;
    wire ssel_active = ~ssel; // ssel 低电平有效

    wire[7:0] doutb;
    reg[7:0] addra;
    reg[7:0] addrb;
    reg finisha;



    SPI_slave  u_SPI_slave (
        .clk                     ( clk                     ),
        .sck                     ( sck                     ),
        .mosi                    ( mosi                    ),
        .ssel                    ( ssel                    ),
        .dataToSend              ( dataToSend [7:0]   ),

        .miso                    ( miso                    ),
        .byteReceived            ( byteReceived            ),
        .receivedData            ( receivedData  [7:0]  ),
        .dataNeeded              ( dataNeeded              )
        );


    PINGPONG_RAM  u0_PINGPONG_RAM (
        .clka                    ( clk            ),
        .rsta                    ( rst_n            ),
        .addra                   ( addra    [6:0]  ),
        .wea                     ( byteReceived    ),
        .dina                    ( receivedData [7:0] ),
        .finisha                 ( finisha         ),
        .clkb                    ( clk            ),
        .rstb                    ( rst_n            ),
        .addrb                   ( addrb    [6:0]  ),
        .finishb                 ( finishb         ),

        .readya                  ( readya          ),
        .doutb                   ( doutb    [7:0] ),
        .readyb                  ( readyb          )
        );

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
            addra <= 7'b0;
        end
        else if(byteReceived)
            addra <= addra + 1;
    end

    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            finisha <= 0;
        end
        else if(ssel_risingEdge) begin
            finisha <= 1;
        end 
        else if(finisha == 1) begin
            finisha = ~finisha; // finishia only last one period
        end
    end
endmodule