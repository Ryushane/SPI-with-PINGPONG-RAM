module DSP_tb(  
);
wire[7:0] dataout;
reg[7:0] datain;
reg clk;
reg rst_n;
reg readya1;
reg readyb0;
wire[6:0] addrb0;
wire[6:0] addra1;
wire finisha1;
wire finishb0;
wire wea1;

initial begin
    clk = 0;
    rst_n = 1;
    readya1 = 1;
    readyb0 = 1;
    # 50
    rst_n = 0;
    # 50
    rst_n = 1;
end

always #10 begin
    clk = ~clk;
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        datain <= 8'h0F;
    end
    else begin
        datain <= datain + 1;
    end
end

DSP_module DSP_module(clk, rst_n, datain, dataout, readyb0, readya1, addrb0, addra1, finishb0, finisha1, wea1);
endmodule // 