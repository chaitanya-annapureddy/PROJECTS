
class env_config extends uvm_object;

        `uvm_object_utils(env_config)

        function new (string name = "env_confgi");
                super.new(name);
        endfunction

        apb_config apb_cfg[];
        spi_config spi_cfg[];

        int no_of_spi_agents;
        int no_of_apb_agents;

endclass

~
