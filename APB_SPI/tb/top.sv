
module top;


        import uvm_pkg::*;

        import test_pkg::*;


        bit clk;

        always #10 clk = ~clk;

        apb_intf apbf(clk);
        spi_intf spif(clk);


        spi_core DUT    (
                         .PCLK                  (clk),
                         .PRESETn               (apbf.PRESETn),
                         .PADDR                 (apbf.PADDR),
                         .PWDATA                (apbf.PWDATA),
                         .PRDATA                (apbf.PRDATA),
                         .PWRITE                (apbf.PWRITE),
                         .PENABLE               (apbf.PENABLE),
                         .PSEL                  (apbf.PSEL),
                         .PREADY                (apbf.PREADY),
                         .PSLVERR               (apbf.PSLVERR),
                         .miso                  (spif.miso),
                         .mosi                  (spif.mosi),
                         .ss                    (spif.ss),
                         .sclk                  (spif.sclk),
                         .spi_interrupt_request (spif.spi_inpt_req)
                                );


        initial
                begin

                        `ifdef VCS
                        $fsdbDumpvars(0,top);
                        `endif
                        uvm_config_db#(virtual apb_intf)::set(null,"*","apb_intf",apbf);
                        uvm_config_db#(virtual spi_intf)::set(null,"*","spi_intf",spif);
                        run_test();
                end
  
endmodule


