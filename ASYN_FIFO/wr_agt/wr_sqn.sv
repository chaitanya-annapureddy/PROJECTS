     class wr_sqn extends uvm_sequence #(wr_txn);
          `uvm_object_utils(wr_sqn)

           function new(string name="wr_sqn");
                super.new(name);
           endfunction

        endclass


       class wr_sqn_1 extends wr_sqn;
        `uvm_object_utils(wr_sqn_1)

           function new(string name="wr_sqn_1");
                super.new(name);
           endfunction

           bit[3:0] no_of_locations;

          // if(!uvm_config_db#(bit)::get(null,get_type_name(),"bit",no_of_locations))
        //      `uvm_fatal(get_type_name(),"check the test")

           task body();
                  if(!uvm_config_db#(bit[3:0])::get(null,get_full_name(),"bit",no_of_locations)) //for bit seeting and retrivng anything u need to give the size                                                                                                 //size also if u don't give it will throw an "0" default type.
                        `uvm_fatal(get_type_name(),"check the test")
                $display("%0d",no_of_locations);

           repeat(30)   // if repeat doesnot get the any value means if (repeat0) then it won't run any time zero time run
             begin

               req = wr_txn::type_id::create("req");

               start_item(req);
                $display("after start item");
               assert(req.randomize());
                $display("after start randomization");
               finish_item(req);
                $display("after finish item");

             end
           endtask

       endclass
