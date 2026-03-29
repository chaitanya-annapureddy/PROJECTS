class apb_driver extends uvm_driver#(apb_trans);

        `uvm_component_utils(apb_driver)

        function new (string name = "apb_driver",uvm_component parent);
                super.new(name,parent);
        endfunction

        apb_config apb_cfg;
        virtual  apb_intf.APB_DRV_MP apbf;

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                if(!uvm_config_db#(apb_config)::get(this,"","apb_config",apb_cfg))
                        `uvm_fatal("APB_DRIVER","failed to get config");

        endfunction

        function void connect_phase(uvm_phase phase);
                super.connect_phase(phase);

                apbf = apb_cfg.apbf;

        endfunction



        task run_phase(uvm_phase phase);
                @(apbf.apb_drv_cb)
                apbf.apb_drv_cb.PRESETn<=1'b0;
                @(apbf.apb_drv_cb)
                apbf.apb_drv_cb.PRESETn<=1'b1;

        forever

                begin
                        seq_item_port.get_next_item(req);
                        send_to_dut(req);
                        seq_item_port.item_done();
                end
        endtask

        task send_to_dut(apb_trans t1);
                begin

                            //  SETUP PHASE

                                @(apbf.apb_drv_cb);
                                        apbf.apb_drv_cb.PSEL    <= 1'b1;
                                        apbf.apb_drv_cb.PENABLE <= 1'b0;
                                        apbf.apb_drv_cb.PWRITE  <= t1.Pwrite;
                                        apbf.apb_drv_cb.PADDR   <= t1.Paddr;
                                        if(t1.Pwrite == 1)
                                        apbf.apb_drv_cb.PWDATA  <= t1.Pwdata;


                                //  ACCESS PHASE
                                @(apbf.apb_drv_cb);
                                        apbf.apb_drv_cb.PENABLE <= 1;


                        //      wait(apbf.apb_drv_cb.PREADY == 1)
                        //              if(t1.Pwrite == 0)
                        //                      t1.Prdata = apbf.apb_drv_cb.PRDATA;

                        //      `uvm_info(get_type_name,"DRIVING TO DUT",UVM_LOW)
                        //      req.print();

                                // IDLE PHASE
                                @(apbf.apb_drv_cb);
                                        apbf.apb_drv_cb.PSEL    <= 1'b0;
                                        apbf.apb_drv_cb.PENABLE <= 1'b0;        

                end
        endtask

endclass

-- VISUAL LINE --                                   80        80,0-1        Bot
