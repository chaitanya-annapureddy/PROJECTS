

class apb_trans extends uvm_sequence_item;

        `uvm_object_utils(apb_trans)



        rand    bit             Presetn;
                bit             Psel;
                bit             Penable;
                bit             Pready;
                bit             Pslverr;
        rand    bit             Pwrite;
        rand    bit     [2:0]   Paddr;
        randc   bit     [7:0]   Pwdata;
                bit     [7:0]   Prdata;


        function new (string name = "apb_trans");
                super.new(name);
        endfunction

        function void do_print(uvm_printer printer);
                super.do_print(printer);

                printer.print_field("Presetn",  Presetn, $bits(Presetn), UVM_BIN);
                printer.print_field("Psel",     Psel,    $bits(Psel),    UVM_BIN);
                printer.print_field("Penable",  Penable, $bits(Penable), UVM_BIN);
                printer.print_field("Pready",   Pready,  $bits(Pready),  UVM_BIN);
                printer.print_field("Pslverr",  Pslverr, $bits(Pslverr), UVM_BIN);
                printer.print_field("Pwrite",   Pwrite,  $bits(Pwrite),  UVM_BIN);
                printer.print_field("Paddr",    Paddr,   $bits(Paddr),   UVM_DEC);
                printer.print_field("Pwdata",   Pwdata,  $bits(Pwdata),  UVM_DEC);
                printer.print_field("Prdata",   Prdata,  $bits(Prdata),  UVM_DEC);

        endfunction

endclass

-- VISUAL LINE --                                   40        40,0-1        Bot

