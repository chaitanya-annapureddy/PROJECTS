 class rd_drv extends uvm_driver #(rd_txn);
          `uvm_component_utils(rd_drv)

           virtual asyn_fifo_intf.rd_drv_mp vif;
           rd_txn    rd_txn_h;
           rd_cfg    rd_cfg_h;

           function new(string name="rd_drv",uvm_component parent);
                super.new(name,parent);
           endfunction

          function void build_phase(uvm_phase phase);
                 if(!uvm_config_db#(rd_cfg)::get(this,"","rd_cfg",rd_cfg_h))
                 `uvm_fatal(get_type_name(),"check the rd agt top")
          endfunction

            function void connect_phase(uvm_phase phase);
                    vif=rd_cfg_h.vif;
           endfunction



          task run_phase(uvm_phase phase);
                @(vif.rd_drv_cb)
                  vif.rd_drv_cb.r_rstn <= 0;
                @(vif.rd_drv_cb)
                  vif.rd_drv_cb.r_rstn <= 1;

                forever
                    begin
                          seq_item_port.get_next_item(req);
                          send_to_dut(req);
                          $display("printing from the rd driver");
                          req.print();
                          seq_item_port.item_done(req);
                    end
          endtask


         task send_to_dut(rd_txn req);

              req.empty    = vif.rd_drv_cb.empty;
           //wait(vif.rd_drv_cb.empty ==0)
                if(!vif.rd_drv_cb.empty)
 //wait(vif.rd_drv_cb.empty ==0)
                if(!vif.rd_drv_cb.empty)
                 begin
                        @(vif.rd_drv_cb)

                 vif.rd_drv_cb.r_en   <= 1;
                @(vif.rd_drv_cb)
                 vif.rd_drv_cb.r_en   <= 0;
                end

                else
                        @(vif.rd_drv_cb);
         endtask

   endclass

                        
