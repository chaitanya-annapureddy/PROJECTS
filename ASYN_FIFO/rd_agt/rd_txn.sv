    class rd_txn extends uvm_sequence_item;
          `uvm_object_utils(rd_txn)

             bit[7:0] data_in;
             bit  w_en;
             bit  w_clk;
             bit  w_rstn;
             bit  r_en;
             bit  r_clk;
        rand    bit  r_rstn;
             bit [7:0] data_out;
             bit empty;
             bit full;

           function new(string name="rd_txn");
                super.new(name);
           endfunction

           function void do_print(uvm_printer printer);
                printer.print_field("r_en",    this.r_en,    1,UVM_DEC);
                printer.print_field("full",    this.full,    1,UVM_DEC);
                printer.print_field("empty",   this.empty,   1,UVM_DEC);
                printer.print_field("data_out",this.data_out,8,UVM_DEC);
                printer.print_field("r_rstn",  this.r_rstn,  1,UVM_DEC);
           endfunction

        endclass

~
~
