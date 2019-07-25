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
    output wire wea
);

    parameter DATADEPTH = 128;

    // wire dataout_w;
    assign dataout = datain + 1;
    reg[6:0] addrb0_r;


    assign wea1 = readyb0 && readya1;
    reg wea1_r, wea1_rr;
    assign wea = wea1_r && wea1_rr;

    always @(posedge clk) begin
        if(!rst_n) begin
            wea1_r <= 0;
            wea1_rr <= 0;
        end
        else begin
            wea1_r <= wea1;
            wea1_rr <= wea1_r;
        end
    end


    always @(posedge clk) begin
        if(!rst_n || !readyb0) begin
            addrb0 <= 7'b0;
        end
        else if(readyb0 && readya1)begin
            addrb0 <= addrb0 + 1;
        end
    end


    always @(posedge clk) begin
        if(!rst_n) begin
            finishb0 <= 0;
        end
        else if(finishb0 == 1)
            finishb0 <= ~finishb0;
        else if(addrb0 == (DATADEPTH - 1)) begin
            finishb0 <= ~finishb0;
        end
    end


    // dina1 差两个拍子
    always @(posedge clk) begin
        if(!rst_n) begin
            addra1 <= 7'b0;
            addrb0_r <= 7'b0;
        end
        else begin
            addrb0_r <= addrb0;
            addra1 <= addrb0_r;
        end
    end


    always @(posedge clk) begin
        if(!rst_n) begin
            finisha1 <= 0;
        end
        else if(finisha1 == 1)
            finisha1 <= ~finisha1;
        else if(addra1 == (DATADEPTH - 1)) begin
            finisha1 <= ~finisha1;
        end
    end

    
endmodule
    