  class wr_drv extends uvm_driver #(wr_txn);
          `uvm_component_utils(wr_drv)

            virtual asyn_fifo_intf.wr_drv_mp vif;
            wr_cfg    wr_cfg_h;
            bit w_en_drv;

           function new(string name="wr_drv",uvm_component parent);
                super.new(name,parent);
           endfunction

           function void build_phase(uvm_phase phase);
              if(!uvm_config_db#(wr_cfg)::get(this,"","wr_cfg",wr_cfg_h))
                 `uvm_fatal(get_type_name(),"check the wr agt top")
                  $display("2222222222222222  %p",wr_cfg_h);
           endfunction

            function void connect_phase(uvm_phase phase);
                    vif=wr_cfg_h.vif;
                    $display("333333333333333333333333");

           endfunction

        task reset;
                     @(vif.wr_drv_cb)
                       vif.wr_drv_cb.w_rstn <= 0;
                     @(vif.wr_drv_cb)
                       vif.wr_drv_cb.w_rstn <= 1;
        endtask

            task run_phase(uvm_phase phase);
                $display("44444444444444444444444");
                reset;
                $display("5555555555555555555555555");

                forever
                        begin
                             $display("6666666666666666666666666666666");
                             seq_item_port.get_next_item(req);
                             //$display("7777777777777777777777777777777");

                             send_to_dut(req);
                             //$display("printing from the wr driver ");
                            // req.print();
                               seq_item_port.item_done();
                        end
           endtask


           task send_to_dut(wr_txn req);
           //  `uvm_info("WR_DRIVER",$sformatf("printing from WRITE DRIVER \n %s", req.sprint()),UVM_LOW)
            //      @(vif.wr_drv_cb)
              //    @(vif.wr_drv_cb)
                //  @(vif.wr_drv_cb)

                    req.full    = vif.wr_drv_cb.full;
                                $display("fffffulllllllllllllllllllllllllll %b",req.full);
                //wait(vif.wr_drv_cb.full === 0)
                if(!vif.wr_drv_cb.full)
                  begin
                                       //while (condition) is true statement executs not it comes out of it;
                        @(vif.wr_drv_cb)
                //      $display("inside if blk in driver after clk blk");
                         vif.wr_drv_cb.w_en    <= 1;
                //      $display("inside if blk after driving w en");
                         vif.wr_drv_cb.data_in <= req.data_in;
                //      $display("wr_enable in the driver %d",vif.wr_drv_cb.w_en);


                     @(vif.wr_drv_cb)
                //      $display("after driving data_in ");
                    vif.wr_drv_cb.w_en    <= 1'b0;
                //      $display("after wen to 0");
                 end

                else
                        $display("lastttttttttttttttttttttttttt");

                     @(vif.wr_drv_cb)

       `uvm_info("WR_DRIVER",$sformatf("printing from WRITE DRIVER \n %s", req.sprint()),UVM_LOW)



           endtask



   endclass


