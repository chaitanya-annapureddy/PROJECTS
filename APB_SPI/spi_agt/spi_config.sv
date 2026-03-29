
class spi_config extends uvm_object;

        `uvm_object_utils(spi_config)

        function new (string name = "spi_config");
                super.new(name);
        endfunction

        virtual spi_intf spif;
        uvm_active_passive_enum is_active;

endclass


