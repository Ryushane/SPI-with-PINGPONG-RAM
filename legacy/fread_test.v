module fread_test();

parameter LOOPTIME = 256;
parameter PERIOD = 10;
parameter SCKPERIOD = 50;

integer f_send, fp_w;
integer counter;
reg clk;
reg[7:0] dataToReceive;

initial begin
    clk = 0;
    dataToReceive = 0;
    counter = 0;
    f_send = $fopen("MOSI_data.txt","r"); //写打开
    fp_w = $fopen("MOSI_data_out.txt","w");
end

always #PERIOD clk = ~clk;

always @(posedge clk)
begin
    if(!$feof(f_send)) begin
        counter <= counter + 1;
        $fscanf(f_send, "%b", dataToReceive);
        $fdisplay(fp_w, "%b", dataToReceive);
    end
    else
    begin
        $fclose(f_send);
        $fclose(fp_w);
    end
end

endmodule