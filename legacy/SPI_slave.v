`timescale 1ns / 1ps

module SPI_slave(
  input wire clk,
  input wire sck,
  input wire rst_n,
  input wire mosi,
  output wire miso,
  input wire ssel,
  output reg[7:0] receivedData = 8'b00000000,
  input wire[7:0] dataToSend,
  
  output reg byteReceived,
  input wire readya0,
  input wire readyb1,
  output reg[6:0] addra0,
  output reg[6:0] addrb1,
  output reg finisha0,
  output reg finishb1
  );


  reg[1:0] sckr;
  reg[2:0] bitcnt; // SPI is 8-bits, so we need a 3 bits counter to count the bits as they come in
  reg[7:0] dataToSendBuffer;

  wire ssel_active = ~ssel;
  reg[1:0] sselr;

  always @(posedge clk) begin
    if(~ssel_active)
      sckr <= 2'b00;
    else
      sckr <= { sckr[0], sck };
  end

  assign sck_risingEdge = (sckr == 2'b01);
  wire sck_fallingEdge = (sckr == 2'b10);

  always @(posedge clk) begin
    if(~ssel_active) begin
      bitcnt <= 3'b000;
      receivedData <= 8'h00;
    end
    else if(sck_risingEdge) begin
      bitcnt <= bitcnt + 3'b001;
      receivedData <= { receivedData[6:0], mosi };
    end
  end

  always @(posedge clk)
    byteReceived <= ssel_active && sck_risingEdge && (bitcnt == 3'b111);

  always @(posedge clk) begin
    if(~ssel_active)
      dataToSendBuffer <= 8'h00;
      // dataToSendBuffer <= dataToSend;
    else if(((bitcnt == 3'b000) && (sck_fallingEdge))|| ssel_fallingEdge) begin
      if(readyb1)
        dataToSendBuffer <= dataToSend;
      else
        dataToSendBuffer <= 8'b0;
    end
    else if(sck_fallingEdge)
      dataToSendBuffer <= { dataToSendBuffer[6:0], 1'b0};
  end
    
  assign dataNeeded = ssel_active && (bitcnt == 3'b000);
  assign miso = dataToSendBuffer[7];


  // 与RAM交互的线

  // MOSI (dina0)
  always @(posedge clk or negedge rst_n) begin
      if(!rst_n) begin
          sselr <= 2'b11;
      end
      else begin
          sselr <= { sselr[0], ssel};
      end
  end

  wire ssel_risingEdge = (sselr == 2'b01);
  wire ssel_fallingEdge = (sselr == 2'b10);


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
      else if(finisha0 == 1) begin
          finisha0 <= 0;
      end
      else if(ssel_risingEdge) begin
          finisha0 <= 1;
      end 
  end


  // MISO doutb1 这里应该要打两拍时钟
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
      else if(finishb1 == 1)
          finishb1 <= 0;
      else if(ssel_risingEdge && readyb1) begin
          finishb1 = 1;
      end
  end
endmodule
