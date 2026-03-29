class spi_agent_top extends uvm_env;

        `uvm_component_utils(spi_agent_top)

        function new (string name = "spi_agent_top",uvm_component parent);
                super.new(name,parent);
        endfunction

        env_config env_cfg;

        spi_agent spi_agt[];

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
                        `uvm_fatal("SPI_AGENT_TOP","failed to get config");

                spi_agt = new [env_cfg.no_of_spi_agents];

                foreach(spi_agt[i])
                        begin
                                spi_agt[i] = spi_agent::type_id::create($sformatf("spi_agt[%0d]",i),this);
                        end

        endfunction

endclass
~
