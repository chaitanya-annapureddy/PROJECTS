class spi_trans extends uvm_sequence_item;

        `uvm_object_utils(spi_trans)

                bit [7:0] mosi; // 8 or 1
        randc   bit [7:0] miso; // 8 or 1
                bit     ss;
                bit     spi_int_req;
                bit sclk;

        function new (string name = "spi_trans");
                super.new(name);
        endfunction

        function void do_print(uvm_printer printer);
                super.do_print(printer);

                printer.print_field("mosi",mosi,$bits(mosi),UVM_DEC);
                printer.print_field("miso",miso,$bits(miso),UVM_DEC);
                printer.print_field("ss",ss,$bits(ss),UVM_BIN);
                printer.print_field("spi_int_req",spi_int_req,$bits(spi_int_req),UVM_BIN);
                printer.print_field("sclk",sclk,$bits(sclk),UVM_BIN);

        endfunction

endclass
