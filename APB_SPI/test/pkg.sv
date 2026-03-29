
package test_pkg;

        `include "uvm_macros.svh"

        import uvm_pkg::*;

        `include "apb_trans.sv"
        `include "spi_trans.sv"

        `include "apb_config.sv"
        `include "spi_config.sv"
        `include "env_config.sv"

        `include "apb_sequence.sv"
        `include "spi_sequence.sv"

        `include "apb_driver.sv"
        `include "apb_monitor.sv"
        `include "apb_sequencer.sv"

        `include "spi_driver.sv"
        `include "spi_monitor.sv"
        `include "spi_sequencer.sv"

        `include "apb_agent.sv"
        `include "spi_agent.sv"

        `include "apb_agent_top.sv"
        `include "spi_agent_top.sv"

        `include "scoreboard.sv"
        `include "environment.sv"

        `include "test.sv"

endpackage
