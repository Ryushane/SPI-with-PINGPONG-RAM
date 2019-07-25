module DEBOUNCE#(
    parameter   LENGTH = 8
    )
(
    input clk, 
    input rst, 
    input sig, 
    output debounce_sig
    );


    reg[LENGTH-1:0] shift_reg=21;
    reg debounce_sig_r0=1'b0;
    assign debounce_sig=debounce_sig_r0;

    always@(posedge clk) begin
        if(rst) begin
            shift_reg <= 21;
            debounce_sig_r0=1'b0;
        end else begin
            shift_reg <= {shift_reg[LENGTH-2:0], sig};
            if(debounce_sig_r0==1'b0)begin
                if(shift_reg=={LENGTH{1'b1}})begin
                    debounce_sig_r0<=1'b1;
                end
            end else begin
                if(shift_reg=={LENGTH{1'b0}})begin
                    debounce_sig_r0<=1'b0;
                end
            end
        end
    end

endmodule