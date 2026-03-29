module dp_sram#(parameter AW = 8,

                          DW = 16
                                 )
                     ( input wclk,
                       input wen,
                       input [AW-1:0] waddr,
                       input [DW-1:0] wdata,

                       input rclk,
                       input ren,
                       input [AW-1:0] raddr,
                       output reg[DW-1:0]  rdata
                        );

                reg[DW-1:0]mem[AW-1:0];



                always@(posedge wclk)
                        begin
                                if(wclk && wen) begin
                                mem[waddr] <= wdata;
                        end
                end

                always@(posedge rclk)
                begin
                        if(rclk && ren) begin
                                rdata <= mem[raddr];
                        end

                        else
                                rdata <= rdata;
                end

endmodule

