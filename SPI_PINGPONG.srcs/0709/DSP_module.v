module DSP_module(
    input wire clk,
    input wire rst_n,
    input wire[7:0] datain,
    output wire[7:0]dataout,

    // 与RAM交互的线
    input readyb0,
    input readya1,
    output reg[6:0] addrb0,
    output reg[6:0] addra1,
    output reg finishb0,
    output reg finisha1,
    output wire wea1
);

    parameter DATALENGTH = 64;

    // wire dataout_w;
    assign dataout = datain + 1;
    reg[6:0] addrb0_r;

    // 与RAM有关的交互
    // always @(posedge clk or negedge rst_n) begin
    //     if(!rst_n) begin
    //         wea1 <= 0;
    //     end
    //     else begin
    assign wea1 = readyb0 && readya1;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            addrb0 <= 7'b0;
        end
        else if(readyb0 && readya1) begin
            addrb0 <= addrb0 + 1;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            finishb0 <= 0;
        end
        else if(addrb0 == (DATALENGTH - 1)) begin
            finishb0 <= ~finishb0;
        end
    end


    // dina1 差两个拍子
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            addra1 <= 7'b0;
            addrb0_r <= 7'b0;
        end
        else begin
            addrb0_r <= addrb0;
            addra1 <= addrb0_r;
        end
    end

    // always @(posedge clk or negedge rst_n) begin
    //     if(!rst_n || ssel_risingEdge) begin
    //         addra1 <= 7'b0;
    //     end
    //     else if(readya1 && (addra1 < data_counter)) begin
    //         addra1 <= addra1 + 1;
    //     end
    // end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            finisha1 <= 0;
        end
        else if(addra1 == (DATALENGTH - 1)) begin
            finisha1 <= ~finisha1;
        end
    end
endmodule
    