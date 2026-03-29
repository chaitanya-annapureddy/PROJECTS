  class rd_mon extends uvm_monitor;
          `uvm_component_utils(rd_mon)

            virtual asyn_fifo_intf.rd_mon_mp vif;
           rd_txn    rd_txn_h;
           rd_cfg    rd_cfg_h;

           uvm_analysis_port #(rd_txn) rd_port_h;


           function new(string name="rd_mon",uvm_component parent);
                super.new(name,parent);
                 rd_port_h = new("rd_port_h",this);
           endfunction

          function void build_phase(uvm_phase phase);
          if(!uvm_config_db#(rd_cfg)::get(this,"","rd_cfg",rd_cfg_h))
                 `uvm_fatal(get_type_name(),"check the wr agt top")
          endfunction

          function void connect_phase(uvm_phase phase);
                    vif=rd_cfg_h.vif;
          endfunction



          task run_phase(uvm_phase phase);
            rd_txn_h = rd_txn::type_id::create("rd_txn_h");
                forever
                        begin
                                collect_data();
          rd_port_h.write(rd_txn_h);
                                //$display("printing from the rd monitor");
                               // rd_txn_h.print();
                        end
          endtask

          task collect_data();
            @(vif.rd_mon_cb)
            rd_txn_h.r_rstn   = vif.rd_mon_cb.r_rstn;

     // wait(vif.rd_mon_cb.empty==0)
               if(!vif.rd_mon_cb.empty)
          begin
                      @(vif.rd_mon_cb)
                        rd_txn_h.r_en     = 1;
                       rd_txn_h.data_out = vif.rd_mon_cb.data_out;
                        rd_txn_h.empty    = vif.rd_mon_cb.empty;
                        @(vif.rd_mon_cb)
                        rd_txn_h.r_en    = 0;

          end

        else
                @(vif.rd_mon_cb);
          endtask




        endclass

