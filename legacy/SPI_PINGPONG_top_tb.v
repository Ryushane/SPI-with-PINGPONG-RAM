`timescale 1ns / 1ps
`define NULL 0

module SPI_PINGPONG_top_tb;
  reg clk;
  wire sck;
  reg sck_ori;

  reg rst_n;
  wire mosi;
  wire miso;
  reg ssel;
  wire ssel_active = ~ssel;
  // wire readya1;
  // wire byteReceived; // received a bit
  
  wire DRDY;

  parameter LOOPTIME = 256;
  parameter PERIOD = 10; // must be even
  parameter SCKPERIOD = 50;

  integer f_send, f_receive, f_ssel;
  integer counter;
  
  reg[2:0] bitcnt = 3'b000;
  reg[1:0] sckr = 2'b00;

  reg[1:0] sselr;

  reg[7:0] MOSI_data;
  reg[7:0] MOSI_data_Buffer;
  reg[7:0] MISO_data;

  SPI_PINGPONG_top SPI_PINGPONG_top(clk, sck, ssel, rst_n, mosi, miso, DRDY);
  

  initial
  begin
    clk = 0;
    MOSI_data = 0;
    MISO_data = 0;
    counter = 0;
    rst_n = 0;
    sck_ori = 0;
    f_send = $fopen("MOSI_data.txt","r"); //读打开
    // f_receive = $fopen("MISO_data.txt","w");//收回的数据
    f_ssel = $fopen("ssel_data.txt", "r"); // ssel data
    if(f_send == `NULL)
      $display("fail to open data MOSI_data.txt!");
    if(f_receive == `NULL)
      // $display("fail to open data MISO_data.txt!");
    if(f_ssel == `NULL)
      $display("fail to open data ssel_data.txt!");
    
    # PERIOD
    rst_n = 1;
    $fscanf(f_send, "%b", MOSI_data);
  end
  
  always #(PERIOD/2) begin
    clk = ~clk; 
  end

  always #(SCKPERIOD/2) begin
    sck_ori = ~sck_ori;
  end

  assign sck = sck_ori && !ssel;

  // load ssel data
  always @(posedge clk) begin
    if(!$feof(f_ssel))
      $fscanf(f_ssel, "%b", ssel);
    else
      $fclose(f_ssel);
  end

  always @(posedge clk) begin
    if(!rst_n)
      sckr <= 2'b00;
    else begin
      sckr <= { sckr[0], sck};
    end
  end

  wire sck_risingEdge = (sckr == 2'b01);
  wire sck_fallingEdge = (sckr == 2'b10);

  // load MOSI_data

  always @(posedge clk) begin
    if(!$feof(f_send)&&(sck_risingEdge)&&(bitcnt == 0)) begin
        counter <= counter + 1;
        $fscanf(f_send, "%b", MOSI_data);
        $display("Reading MOSI_data");
    end
    else if($feof(f_send)) begin
        $fclose(f_send);
    end
  end

  // Save MISO_data
  // always @(posedge clk) begin
  //   if()

  //
  always @(posedge clk or negedge rst_n) begin
      if(!rst_n) begin
          sselr <= 2'b00;
      end
      else begin
          sselr <= { sselr[0], ssel};
      end
  end

  wire ssel_risingEdge = (sselr == 2'b01);
  wire ssel_fallingEdge = (sselr == 2'b10);

  always @(posedge clk) begin
    if(~ssel_active) begin
      bitcnt <= 3'b000;
    end
    else if(sck_risingEdge) begin
      bitcnt <= bitcnt + 3'b001;
    end
  end

  always @(posedge clk) begin
    if(~ssel_active)
      MOSI_data_Buffer <= MOSI_data;
    else if(((bitcnt == 3'b000)&&(sck_fallingEdge)) || ssel_fallingEdge) begin
      // if(DRDY)
        MOSI_data_Buffer <= MOSI_data;
      // else
        // MOSI_data_Buffer <= 8'b0;
    end
    else if(sck_fallingEdge)
      MOSI_data_Buffer <= { MOSI_data_Buffer[6:0], 1'b0};
  end

  assign mosi = MOSI_data_Buffer[7];
endmodule
