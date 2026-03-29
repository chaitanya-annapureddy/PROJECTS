     class rd_sqn extends uvm_sequence #(rd_txn);
          `uvm_object_utils(rd_sqn)

           function new(string name="rd_sqn");
                super.new(name);
           endfunction

        endclass


    class rd_sqn_1 extends rd_sqn;
          `uvm_object_utils(rd_sqn_1)

           function new(string name="rd_sqn_1");
                super.new(name);
           endfunction

           bit[3:0] no_of_locations;



          task body();
             if(!uvm_config_db#(bit[3:0])::get(null,get_full_name(),"bit",no_of_locations))  //get_full_name() not get_full_name()
                   `uvm_fatal(get_type_name(),"check the test")

                repeat(30)
                   begin
                        $display("HHHHHHHHHHHHHHHHHHHHHHHHHHH");
                        req = rd_txn::type_id::create("req");

                        start_item(req);
                        $display("eeeeeeeeeeeeeeeeeeeeeeeeeeee");

                        assert(req.randomize());
                        finish_item(req);
                   end
           endtask
      endclass

