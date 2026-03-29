  class wr_txn extends uvm_sequence_item;
          `uvm_object_utils(wr_txn)

        rand bit[7:0] data_in;
         rand    bit  w_en;
             bit  w_clk;
             bit  w_rstn;
             bit  r_en;
             bit  r_clk;
             bit  r_rstn;
             bit [7:0] data_out;
             bit empty;
             bit full;



        constraint a1{w_en == 1;}

           function new(string name="wr_txn");
                super.new(name);
           endfunction

           function void do_print(uvm_printer printer);
             printer.print_field("data_in",this.data_in,8,UVM_DEC);
             printer.print_field("w_en",   this.w_en   ,1,UVM_DEC);
             printer.print_field("w_rstn", this.w_rstn  ,1,UVM_DEC);
             printer.print_field("full", this.full  ,1,UVM_DEC);


           endfunction

   endclass

~
