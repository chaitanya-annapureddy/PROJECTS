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
