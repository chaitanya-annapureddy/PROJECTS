
class spi_agent extends uvm_agent;

        `uvm_component_utils(spi_agent)

        function new (string name = "spi_agent",uvm_component parent);
                super.new(name,parent);
        endfunction

        spi_config      spi_cfg;

        spi_driver      spi_drv;
        spi_monitor     spi_mon;
        spi_sequencer   spi_seqr;


        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                if(!uvm_config_db#(spi_config)::get(this,"","spi_config",spi_cfg))
                        `uvm_fatal("SPI_AGENT","failed to get config");

                        spi_mon = spi_monitor::type_id::create("spi_mon",this);

                        if(spi_cfg.is_active == UVM_ACTIVE)
                                begin
                                        spi_drv = spi_driver::type_id::create("spi_drv",this);
                                        spi_seqr = spi_sequencer::type_id::create("spi_seqr",this);
                                end

        endfunction


        function void connect_phase(uvm_phase phase);
                super.connect_phase(phase);

                if(spi_cfg.is_active == UVM_ACTIVE)
                begin
                        spi_drv.seq_item_port.connect(spi_seqr.seq_item_export);
                end
        endfunction

endclass


