//~ `New testbench
`timescale  1ns / 1ps

module tb_PINGPONG_RAM;

// PINGPONG_RAM Parameters
parameter PERIOD  = 10;

reg clk;
reg rst;

// PINGPONG_RAM Inputs
// reg   clka                                 = 0 ;
// reg   rsta                                 = 0 ;
reg   [6:0]  addra                         = 7'b0000000 ;
reg   wea                                  = 0 ;
reg   [15:0]  dina                         = 16'b0 ;
reg   finisha                              = 0 ;
reg   clkb                                 = 0 ;
reg   rstb                                 = 0 ;
reg   [6:0]  addrb                         = 7'b0000000 ;
reg   finishb                              = 0 ;

// PINGPONG_RAM Outputs
wire  readya                               ;
wire  [15:0]  doutb                        ;
wire  readyb                               ;

reg data_v = 0;

initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    clk = 0;
    rst = 1;
    #(PERIOD*2) rst  =  0;
    @(posedge clk)
    gen_frame();
end

PINGPONG_RAM  u_PINGPONG_RAM (
    .clka                    ( clk            ),
    .rsta                    ( rst            ),
    .addra                   ( addra    [6:0]  ),
    .wea                     ( wea             ),
    .dina                    ( dina     [15:0] ),
    .finisha                 ( finisha         ),
    .clkb                    ( clk            ),
    .rstb                    ( rst            ),
    .addrb                   ( addrb    [6:0]  ),
    .finishb                 ( finishb         ),

    .readya                  ( readya          ),
    .doutb                   ( doutb    [15:0] ),
    .readyb                  ( readyb          )
);

task gen_data();
	integer i;
	begin
        addra = addra - 1;
		for(i=0;i<64;i=i+1)begin
			@(posedge clk)
            begin
			data_v =1;
			dina = i&8'hff;
            addra = addra + 1;
            wea = 1;
            end
		end
        wea = 0;
        finisha = 1;
        #(PERIOD)
        finisha = 0;
		@(posedge clk)
			data_v =0;
	end
endtask

task data_delay();
	integer i;
	begin
		for(i=0;i<16;i=i+1)
		begin
			@(posedge clk);
		end
	end
endtask

task gen_frame();
	integer i;
	begin
		for(i=0;i<32;i=i+1)begin
			gen_data();
			data_delay();
            addra = 7'b0;
		end
	end
endtask

endmodule