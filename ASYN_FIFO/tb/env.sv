  class env extends uvm_env;
          `uvm_component_utils(env)

           sb sb_h;
           rd_agtop rd_agtop_han;
           wr_agtop wr_agtop_han;

          function new(string name="env",uvm_component parent);
                super.new(name,parent);
          endfunction

          function void build_phase(uvm_phase phase);
                sb_h = sb::type_id::create("sb_h",this);

                rd_agtop_han = rd_agtop::type_id::create("rd_agtop_han",this);
                wr_agtop_han = wr_agtop::type_id::create("wr_agtop_han",this);

          endfunction

          function void connect_phase (uvm_phase phase);
               wr_agtop_han.wr_agt_han.mon_han.mon_fifo_h.connect(sb_h.wr_ff_h.analysis_export);
                           rd_agtop_han.rd_agt_han.mon_han.rd_port_h.connect(sb_h.rd_ff_h.analysis_export);
          endfunction

        endclass
