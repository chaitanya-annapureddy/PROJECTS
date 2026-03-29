class apb_agent_top extends uvm_env;

        `uvm_component_utils(apb_agent_top)

        function new (string name = "apb_agent_top",uvm_component parent);
                super.new(name,parent);
        endfunction

        apb_agent apb_agt[];

        env_config env_cfg;

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
                        `uvm_fatal("APB_AGENT_TOP","failed to get config");

                apb_agt = new [env_cfg.no_of_apb_agents];

                foreach(apb_agt[i])
                        begin
                                apb_agt[i] = apb_agent::type_id::create($sformatf("apb_agt[%0d]",i),this);
                        end

        endfunction

endclass
