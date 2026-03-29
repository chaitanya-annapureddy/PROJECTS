      class rd_agt extends uvm_agent;
          `uvm_component_utils(rd_agt)

           rd_mon    mon_han;
           rd_drv    drv_han;
           rd_sqr    sqr_han;
           rd_cfg    rd_cfg_han;

           function void build_phase(uvm_phase phase);
                if(!uvm_config_db#(rd_cfg)::get(this,"","rd_cfg",rd_cfg_han))
                   `uvm_fatal(get_type_name(),"getting is failed in rd_agt check the rd_agtop")

                    mon_han = rd_mon::type_id::create("mon_han",this);
                    if(rd_cfg_han.is_active ==UVM_ACTIVE)
                     begin
                         drv_han = rd_drv::type_id::create("drv_han",this);
                         sqr_han = rd_sqr::type_id::create("sqr_han",this);
                     end
           endfunction

           function new(string name="rd_agt",uvm_component parent);
                super.new(name,parent);
           endfunction

         function void connect_phase(uvm_phase phase);
                drv_han.seq_item_port.connect(sqr_han.seq_item_export);
          endfunction

        endclass

