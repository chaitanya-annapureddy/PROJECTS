class apb_config extends uvm_object;

        `uvm_object_utils(apb_config)

        function new (string name = "apb_config");
                super.new(name);
        endfunction

        virtual apb_intf apbf;
        uvm_active_passive_enum is_active;

endclass

~
