   class wr_mon extends uvm_monitor;
          `uvm_component_utils(wr_mon)

             virtual asyn_fifo_intf.wr_mon_mp vif;
            wr_cfg   wr_cfg_h;
            wr_txn   txn_h;

            uvm_analysis_port #(wr_txn) mon_fifo_h;

           function new(string name="wr_mon",uvm_component parent);
                super.new(name,parent);
                mon_fifo_h = new("mon_fifo_h",this);
           endfunction


           function void build_phase(uvm_phase phase);
            if(!uvm_config_db#(wr_cfg)::get(this,"","wr_cfg",wr_cfg_h))
                 `uvm_fatal(get_type_name(),"check the wr agt top")
           endfunction

           function void connect_phase(uvm_phase phase);
                vif = wr_cfg_h.vif;
           endfunction


           task run_phase(uvm_phase phase);
             txn_h = wr_txn::type_id::create("txn_h");
              forever
                     begin
                       collect_data();
                           mon_fifo_h.write(txn_h);

                       $display("printing from the source monitor");
                       txn_h.print();
                     end
           endtask

           task collect_data();

                   @(vif.wr_mon_cb)
                  @(vif.wr_mon_cb)

                   @(vif.wr_mon_cb)
               txn_h.w_rstn  = vif.wr_mon_cb.w_rstn;

               // wait(vif.wr_mon_cb.full==0)
                 if(!vif.wr_mon_cb.full)
                 begin
                   @(vif.wr_mon_cb)

                //$display("333333333333333333333333333333333");
                 txn_h.w_en    = vif.wr_mon_cb.w_en;
                // $display("22222222222222222222222222");
                 txn_h.data_in = vif.wr_mon_cb.data_in;

                                 txn_h.full    = vif.wr_mon_cb.full;

        //
                end


                else
                 begin
        ///     $display("111111111111111111111");
                 $display("after sampling the full value it is gonna loop");
                 end


           endtask

