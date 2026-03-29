 class sb extends uvm_scoreboard;
           `uvm_component_utils(sb)

          uvm_tlm_analysis_fifo #(wr_txn) wr_ff_h;
            uvm_tlm_analysis_fifo #(rd_txn) rd_ff_h;

           wr_txn wr_txn_h,wr_txn_cc;
           rd_txn rd_txn_h,rd_txn_cc;

            int expected_data_out;
           int actual_data_out;


           int tb_to_comp[$];
           int dut_to_comp[$];

           function new(string name="sb",uvm_component parent);
                super.new(name,parent);
                wr_ff_h = new("wr_ff_h",this);
                rd_ff_h = new("rd_ff_h",this);
           endfunction

           function void build_phase(uvm_phase phase);

                       wr_txn_h = wr_txn::type_id::create("wr_txnh");
                           rd_txn_h = rd_txn::type_id::create("rd_txn_h");

           endfunction
         /* covergroup asy_ff_cg;


          endgroup
        */

                task run_phase(uvm_phase phase);
            forever
                   fork
                        begin
                             wr_ff_h.get(wr_txn_h);
                                 tb_to_comp.push_back(wr_txn_h.data_in);
                             $display("wr txn from the scoreboard");
                        end

                        begin
                             rd_ff_h.get(rd_txn_h);
                                 tb_to_comp.push_back(wr_txn_h.data_in);
                             $display("wr txn from the scoreboard");
                        end

                        begin
                             rd_ff_h.get(rd_txn_h);
                                 dut_to_comp.push_back(rd_txn_h.data_out);
                        end
                   join
         endtask

        //COMPARE LOGIC
        function void check_phase(uvm_phase phase);
           $display("the no of wr txn data in %p",wr_txn_h.data_in);
           $display("rd txn of  data_out is %p",rd_txn_h.data_out);

        while((tb_to_comp.size() > 0) && (dut_to_comp.size() > 0)) begin
           expected_data_out = tb_to_comp.pop_front();              // without looping it will pop only one time ,i should the loop to pop all the elements
           actual_data_out   = dut_to_comp.pop_front();

          if(expected_data_out === actual_data_out)
            `uvm_info(get_type_name(),
        $sformatf("PASS: EXP=%0h ACT=%0h", expected_data_out, actual_data_out),UVM_LOW)

          else
             `uvm_error(get_type_name(),
                                                                        $sformatf("FAIL: EXPECTED=%0H ACTUAL=%0H", expected_data_out,actual_data_out))

        end
        endfunction


  endclass

