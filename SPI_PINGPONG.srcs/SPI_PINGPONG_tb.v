`timescale 1ns / 1ps

module SPI_PINGPONG_tb;
  reg clk;
  reg sck;
  reg rst_n;
  reg mosi;
  wire miso;
  reg ssel;
  wire readya;
  // wire byteReceived; // received a bit
  wire[7:0] receivedData;
  reg[7:0] expectedData; // 
  wire dataNeeded; // received the right data flag
  reg[7:0] dataToSend; 
  reg[7:0] expectedDataToSend;
  reg[7:0] misoData; // slave to master data
  
  SPI_PINGPONG SPI_PINGPONG(clk, sck, ssel, rst_n, mosi, miso, dataNeeded, readya);
  
  initial
  begin
    sck = 1'b0;
    mosi = 1'b0;
    ssel = 1'b1;
    rst_n = 0;
    misoData = 8'h00;
  
    #50 ssel = 1'b0;
    rst_n = 1;

    expectedData = 8'b10011011;
    expectedDataToSend = 8'h9b;
    #50 mosi = 1'b1; #50 sck = 1'b0; #50 sck = 1'b1; #50 misoData <= { misoData[6:0], miso }; // bit 0
    #50 mosi = 1'b0; #50 sck = 1'b0; #50 sck = 1'b1; #50 misoData <= { misoData[6:0], miso }; // bit 1
    #50 mosi = 1'b0; #50 sck = 1'b0; #50 sck = 1'b1; #50 misoData <= { misoData[6:0], miso }; // bit 2
    #50 mosi = 1'b1; #50 sck = 1'b0; #50 sck = 1'b1; #50 misoData <= { misoData[6:0], miso }; // bit 3
    #50 mosi = 1'b1; #50 sck = 1'b0; #50 sck = 1'b1; #50 misoData <= { misoData[6:0], miso }; // bit 4
    #50 mosi = 1'b0; #50 sck = 1'b0; #50 sck = 1'b1; #50 misoData <= { misoData[6:0], miso }; // bit 5
    #50 mosi = 1'b1; #50 sck = 1'b0; #50 sck = 1'b1; #50 misoData <= { misoData[6:0], miso }; // bit 6
    #50 mosi = 1'b1; #50 sck = 1'b0; #50 sck = 1'b1; #50 misoData <= { misoData[6:0], miso }; // bit 7
    #50
    $display("assertEquals(misoData,0x%h,0x%h)", expectedDataToSend, misoData);

    expectedData = 8'b00000000;
    expectedDataToSend = 8'h00;
    #50 mosi = 1'b0; #50 sck = 1'b0; #50 sck = 1'b1; #50 misoData <= { misoData[6:0], miso }; // bit 0
    #50 mosi = 1'b0; #50 sck = 1'b0; #50 sck = 1'b1; #50 misoData <= { misoData[6:0], miso }; // bit 1
    #50 mosi = 1'b0; #50 sck = 1'b0; #50 sck = 1'b1; #50 misoData <= { misoData[6:0], miso }; // bit 2
    #50 mosi = 1'b0; #50 sck = 1'b0; #50 sck = 1'b1; #50 misoData <= { misoData[6:0], miso }; // bit 3
    #50 mosi = 1'b0; #50 sck = 1'b0; #50 sck = 1'b1; #50 misoData <= { misoData[6:0], miso }; // bit 4
    #50 mosi = 1'b0; #50 sck = 1'b0; #50 sck = 1'b1; #50 misoData <= { misoData[6:0], miso }; // bit 5
    #50 mosi = 1'b0; #50 sck = 1'b0; #50 sck = 1'b1; #50 misoData <= { misoData[6:0], miso }; // bit 6
    #50 mosi = 1'b0; #50 sck = 1'b0; #50 sck = 1'b1; #50 misoData <= { misoData[6:0], miso }; // bit 7
    #50
    $display("assertEquals(misoData,0x%h,0x%h)", expectedDataToSend, misoData);
    
    #500 $finish;
    ssel = 1'b1;
  end

  // always @(*) begin
  //   if(byteReceived)
  //     $display("assertEquals(receivedData,%b,%b)", receivedData, expectedData);
  // end

  always @(*) begin
    if(dataNeeded)
      dataToSend = expectedDataToSend;
  end
  
  always
  begin
    clk = 1'b0;
    forever
      #1 clk = ~clk; 
  end
endmodule
