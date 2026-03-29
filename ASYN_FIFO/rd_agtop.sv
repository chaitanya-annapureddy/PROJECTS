     class rd_agtop extends uvm_env;
          `uvm_component_utils(rd_agtop)

           rd_agt   rd_agt_han;
           rd_cfg   rd_cfg_han;
           env_cfg  env_cfg_han;


           function void build_phase(uvm_phase phase);
                 if(!uvm_config_db#(env_cfg)::get(this,"","env_cfg",env_cfg_han))
                     `uvm_fatal(get_type_name(),"get failed check the test env conifg set")

                  rd_agt_han=rd_agt::type_id::create("rd_agt_han",this);
                  uvm_config_db#(rd_cfg)::set(this,"rd_agt_han*","rd_cfg",env_cfg_han.rd_cfg_h);

           endfunction


           function new(string name="rd_agtop",uvm_component parent);
                super.new(name,parent);
           endfunction

        endclass

~
