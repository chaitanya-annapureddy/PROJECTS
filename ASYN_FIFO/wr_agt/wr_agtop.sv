

        class wr_agtop extends uvm_env;
          `uvm_component_utils(wr_agtop)
           wr_agt   wr_agt_han;
           wr_cfg   wr_cfg_han;
           env_cfg  env_cfg_han;


           function new(string name="wr_agtop",uvm_component parent);
                super.new(name,parent);
           endfunction

           function void build_phase(uvm_phase phase);
                 if(!uvm_config_db#(env_cfg)::get(this,"","env_cfg",env_cfg_han))
                     `uvm_fatal(get_type_name(),"get failed check the test env conifg set")

                  wr_agt_han=wr_agt::type_id::create("wr_agt_han",this);
                  uvm_config_db#(wr_cfg)::set(this,"wr_agt_han*","wr_cfg",env_cfg_han.wr_cfg_h);

           endfunction

        endclass

~
~
~
