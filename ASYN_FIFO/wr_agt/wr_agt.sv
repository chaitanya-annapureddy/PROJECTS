

        class wr_agt extends uvm_agent;
          `uvm_component_utils(wr_agt)

          wr_mon    mon_han;
          wr_drv    drv_han;
          wr_sqr    sqr_han;
          wr_cfg    wr_cfg_han;

           function new(string name="wr_agt",uvm_component parent);
                super.new(name,parent);
           endfunction

           function void build_phase(uvm_phase phase);
                if(!uvm_config_db#(wr_cfg)::get(this,"","wr_cfg",wr_cfg_han))
                   `uvm_fatal(get_type_name(),"getting is failed in wr_agt check the wr_agtop")

                    mon_han = wr_mon::type_id::create("mon_han",this);
                    if(wr_cfg_han.is_active ==UVM_ACTIVE)
                     begin
                         drv_han = wr_drv::type_id::create("drv_han",this);
                         sqr_han = wr_sqr::type_id::create("sqr_han",this);
                     end
           endfunction

          function void connect_phase(uvm_phase phase);
           //  if(wr_cfg_han.is_active ==UVM_ACTIVE) begin
                drv_han.seq_item_port.connect(sqr_han.seq_item_export);
                $display("driver to sequencer connection success");
        //        end
          endfunction
        endclass

