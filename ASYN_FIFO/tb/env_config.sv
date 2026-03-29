
        class env_cfg extends uvm_object;
          `uvm_object_utils(env_cfg)

           wr_cfg  wr_cfg_h;
           rd_cfg  rd_cfg_h;

           function new(string name="env_cfg");
                super.new(name);
           endfunction

        endclass
