class base_test extends uvm_test;

        `uvm_component_utils(base_test)

        function new (string name = "base_test",uvm_component parent);
                super.new(name,parent);
        endfunction


        env_config env_cfg;
        apb_config apb_cfg[];
        spi_config spi_cfg[];
        environment env;

        bit [7:0] ctrl_reg_1;

        int no_of_spi_agents = 1;
        int no_of_apb_agents = 1;

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                env_cfg = env_config::type_id::create("env_cfg",this);

                ctrl_reg_1= 8'b0001_0001;

                uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg_1",ctrl_reg_1);

                env_cfg.no_of_spi_agents = this.no_of_spi_agents;
                env_cfg.no_of_apb_agents = this.no_of_apb_agents;

                apb_cfg = new [no_of_apb_agents];
                spi_cfg = new [no_of_spi_agents];

                env_cfg.apb_cfg = new [no_of_apb_agents];
                env_cfg.spi_cfg = new [no_of_spi_agents];


                foreach(apb_cfg[i])
                        begin

                                apb_cfg[i] = apb_config::type_id::create($sformatf("apb_cfg[%0d]",i),this);

                                if(!uvm_config_db#(virtual apb_intf)::get(this,"","apb_intf",apb_cfg[i].apbf))
                                        `uvm_fatal("TEST","failed to get apb interface");
                         
                                if(i == 0)
                                        begin
                                                apb_cfg[i].is_active = UVM_ACTIVE;
                                                uvm_config_db#(apb_config)::set(this,$sformatf("*apb_agt[%0d]*",i),"apb_config",apb_cfg[i]);
                                        end
                                else
                                        begin
                                                apb_cfg[i].is_active = UVM_PASSIVE;
                                                uvm_config_db#(apb_config)::set(this,$sformatf("*apb_agt[%0d]*",i),"apb_config",apb_cfg[i]);
                                        end

                                env_cfg.apb_cfg[i] = apb_cfg[i];

                        end



                foreach(spi_cfg[i])
                        begin
                                spi_cfg[i] = spi_config::type_id::create($sformatf("spi_cfg[%0d]",i),this);

                                if(!uvm_config_db#(virtual spi_intf)::get(this,"","spi_intf",spi_cfg[i].spif))
                                        `uvm_fatal("TEST","failed to get spi interface");

                                if(i == 0)
                                        begin
                                                spi_cfg[i].is_active = UVM_ACTIVE;
                                                uvm_config_db#(spi_config)::set(this,$sformatf("*spi_agt[%0d]*",i),"spi_config",spi_cfg[i]);
                                        end

                                else
                                        begin
                                                spi_cfg[i].is_active = UVM_PASSIVE;
                                                uvm_config_db#(spi_config)::set(this,$sformatf("*spi_agt[%0d]*",i),"spi_config",spi_cfg[i]);
                                        end

                                env_cfg.spi_cfg[i] = spi_cfg[i];

                        end

                        uvm_config_db#(env_config)::set(this,"*","env_config",env_cfg);

                        env = environment::type_id::create("env",this);
                         endfunction


        function void end_of_elaboration_phase(uvm_phase phase);
                super.end_of_elaboration_phase(phase);

                uvm_top.print_topology();

        endfunction


endclass



class apb_rst_seq_test extends base_test;

        `uvm_component_utils(apb_rst_seq_test)

        function new (string name = "apb_rst_seq_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        apb_reset_sequence apb_rst_seq;

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                apb_rst_seq = apb_reset_sequence::type_id::create("apb_rst_seq");

        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                        phase.raise_objection(this);
                                apb_rst_seq.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                        phase.drop_objection(this);
        endtask


endclass

class cpol_cphase_00_test extends base_test;

        `uvm_component_utils(cpol_cphase_00_test)

        function new (string name = "cpol_cphase_00_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        cpol_cphase_00_apb cp_00_a;
        cpol_cphase_00_spi cp_00_s;
        apb_read_00_seq apb_rd_00;

        bit [7:0] ctrl_reg_1;

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                cp_00_a = cpol_cphase_00_apb::type_id::create("cp_00_a");
                cp_00_s = cpol_cphase_00_spi::type_id::create("cp_00_s");
                apb_rd_00 = apb_read_00_seq::type_id::create("apb_rd_00");

                ctrl_reg_1= 8'b0001_0001;

                uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg_1",ctrl_reg_1);


        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                        phase.raise_objection(this);
                        fork
                                cp_00_s.start(env.spi_agt_top.spi_agt[0].spi_seqr);
                                cp_00_a.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                        join
                        #10000;
                        apb_rd_00.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                        #10000;
                        phase.drop_objection(this);
        endtask
endclass




class cpol_cphase_01_test extends base_test;

        `uvm_component_utils(cpol_cphase_01_test)

        function new (string name = "cpol_cphase_01_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        cpol_cphase_01_apb cp_01_a;
        cpol_cphase_01_spi cp_01_s;
        apb_read_01_seq apb_rd_01;

        bit [7:0] ctrl_reg_1;

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                cp_01_a = cpol_cphase_01_apb::type_id::create("cp_01_a");
                cp_01_s = cpol_cphase_01_spi::type_id::create("cp_01_s");
                apb_rd_01 = apb_read_01_seq::type_id::create("apb_rd_01");

                ctrl_reg_1= 8'b0001_0101;

                uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg_1",ctrl_reg_1);


        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                        phase.raise_objection(this);
                        fork
                                cp_01_s.start(env.spi_agt_top.spi_agt[0].spi_seqr);
                                cp_01_a.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                        join
                        #10000;
                        apb_rd_01.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                        #10000;
                        phase.drop_objection(this);
        endtask
endclass




class cpol_cphase_01_test extends base_test;

        `uvm_component_utils(cpol_cphase_01_test)

        function new (string name = "cpol_cphase_01_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        cpol_cphase_01_apb cp_01_a;
        cpol_cphase_01_spi cp_01_s;
        apb_read_01_seq apb_rd_01;

        bit [7:0] ctrl_reg_1;

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                cp_01_a = cpol_cphase_01_apb::type_id::create("cp_01_a");
                cp_01_s = cpol_cphase_01_spi::type_id::create("cp_01_s");
                apb_rd_01 = apb_read_01_seq::type_id::create("apb_rd_01");

                ctrl_reg_1= 8'b0001_0101;

                uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg_1",ctrl_reg_1);


        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                        phase.raise_objection(this);
                        fork
                                cp_01_s.start(env.spi_agt_top.spi_agt[0].spi_seqr);
                                cp_01_a.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                        join
                        #10000;
                        apb_rd_01.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                        #10000;
                        phase.drop_objection(this);
        endtask
endclass
class cpol_cphase_10_test extends base_test;

        `uvm_component_utils(cpol_cphase_10_test)

        function new (string name = "cpol_cphase_10_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        cpol_cphase_10_apb cp_10_a;
        cpol_cphase_10_spi cp_10_s;
        apb_read_10_seq apb_rd_10;

        bit [7:0] ctrl_reg_1;

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                cp_10_a = cpol_cphase_10_apb::type_id::create("cp_10_a");
                cp_10_s = cpol_cphase_10_spi::type_id::create("cp_10_s");
                apb_rd_10 = apb_read_10_seq::type_id::create("apb_rd_10");

                ctrl_reg_1= 8'b0001_1001;

                uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg_1",ctrl_reg_1);


        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                        phase.raise_objection(this);
                        fork
                                cp_10_s.start(env.spi_agt_top.spi_agt[0].spi_seqr);
                                cp_10_a.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                        join
                        #10000;
                        apb_rd_10.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                        #10000;
                        phase.drop_objection(this);
        endtask


endclass

class cpol_cphase_11_test extends base_test;

        `uvm_component_utils(cpol_cphase_11_test)

        function new (string name = "cpol_cphase_11_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        cpol_cphase_11_apb cp_11_a;
        cpol_cphase_11_spi cp_11_s;
        apb_read_11_seq apb_rd_11;

        bit [7:0] ctrl_reg_1;

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                cp_11_a = cpol_cphase_11_apb::type_id::create("cp_11_a");
                cp_11_s = cpol_cphase_11_spi::type_id::create("cp_11_s");
                apb_rd_11 = apb_read_11_seq::type_id::create("apb_rd_11 ");

                ctrl_reg_1= 8'b0101_1101;

                uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg_1",ctrl_reg_1);


        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                        phase.raise_objection(this);
                        fork
                                cp_11_s.start(env.spi_agt_top.spi_agt[0].spi_seqr);
                                cp_11_a.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                        join
                        #10000;
                        apb_rd_11.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                        #10000;
                        phase.drop_objection(this);
        endtask


endclass

class cpol_cphase_00m_test extends base_test;

        `uvm_component_utils(cpol_cphase_00m_test)

        function new (string name = "cpol_cphase_00m_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        cpol_cphase_00m_apb cp_00m_a;
        cpol_cphase_00m_spi cp_00m_s;
        apb_read_00m_seq apb_rd_00m;

        bit [7:0] ctrl_reg_1;

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                cp_00m_a = cpol_cphase_00m_apb::type_id::create("cp_00m_a");
                cp_00m_s = cpol_cphase_00m_spi::type_id::create("cp_00m_s");
                apb_rd_00m = apb_read_00m_seq::type_id::create("apb_rd_00m ");

                ctrl_reg_1= 8'b0101_0001;

                uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg_1",ctrl_reg_1);


        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                        phase.raise_objection(this);
                        fork
                                cp_00m_s.start(env.spi_agt_top.spi_agt[0].spi_seqr);
                                cp_00m_a.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                        join
                        #10000;
                        apb_rd_00m.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                        #10000;
                        phase.drop_objection(this);
        endtask


endclass


class cpol_cphase_01m_test extends base_test;

        `uvm_component_utils(cpol_cphase_01m_test)

        function new (string name = "cpol_cphase_01m_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        cpol_cphase_01m_apb cp_01m_a;
        cpol_cphase_01m_spi cp_01m_s;
        apb_read_01m_seq apb_rd_01m;

        bit [7:0] ctrl_reg_1;

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                cp_01m_a = cpol_cphase_01m_apb::type_id::create("cp_01m_a");
                cp_01m_s = cpol_cphase_01m_spi::type_id::create("cp_01m_s");
                apb_rd_01m = apb_read_01m_seq::type_id::create("apb_rd_01m ");

                ctrl_reg_1= 8'b0101_0100;

                uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg_1",ctrl_reg_1);


        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                        phase.raise_objection(this);
                        fork
                                cp_01m_s.start(env.spi_agt_top.spi_agt[0].spi_seqr);
                                cp_01m_a.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                        join
                        #10000;
                        apb_rd_01m.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                        #10000;
                                      phase.drop_objection(this);
        endtask


endclass


class cpol_cphase_10m_test extends base_test;

        `uvm_component_utils(cpol_cphase_10m_test)

        function new (string name = "cpol_cphase_10m_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        cpol_cphase_10m_apb cp_10m_a;
        cpol_cphase_10m_spi cp_10m_s;
        apb_read_10m_seq apb_rd_10m;

        bit [7:0] ctrl_reg_1;

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                cp_10m_a = cpol_cphase_10m_apb::type_id::create("cp_10m_a");
                cp_10m_s = cpol_cphase_10m_spi::type_id::create("cp_10m_s");
                apb_rd_10m = apb_read_10m_seq::type_id::create("apb_rd_10m ");

                ctrl_reg_1= 8'b0101_1000;

                uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg_1",ctrl_reg_1);


        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                        phase.raise_objection(this);
                        fork
                                cp_10m_s.start(env.spi_agt_top.spi_agt[0].spi_seqr);
                                cp_10m_a.start(env.apb_agt_top.apb_agt[0].apb_seqr);

                            join
                        #10000;
                        apb_rd_10m.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                        #10000;
                        phase.drop_objection(this);
        endtask


endclass


class cpol_cphase_11m_test extends base_test;

        `uvm_component_utils(cpol_cphase_11m_test)

        function new (string name = "cpol_cphase_11m_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        cpol_cphase_11m_apb cp_11m_a;
        cpol_cphase_11m_spi cp_11m_s;
        apb_read_11m_seq apb_rd_11m;

        bit [7:0] ctrl_reg_1;

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                cp_11m_a = cpol_cphase_11m_apb::type_id::create("cp_11m_a");
                cp_11m_s = cpol_cphase_11m_spi::type_id::create("cp_11m_s");
                apb_rd_11m = apb_read_11m_seq::type_id::create("apb_rd_11m ");

                ctrl_reg_1= 8'b0101_1100;

                uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg_1",ctrl_reg_1);


        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);
            fork
                                cp_11m_s.start(env.spi_agt_top.spi_agt[0].spi_seqr);
                                cp_11m_a.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                        join
                        #10000;
                        apb_rd_11m.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                        #10000;
                        phase.drop_objection(this);
        endtask


endclass



class repeat_test extends base_test;

        `uvm_component_utils(repeat_test)

        function new (string name = "repeat_test",uvm_component parent);
                super.new(name,parent);
        endfunction

     repeat_apb_seq apb_seq;
        repeat_spi_seq spi_seq;
        repeat_read_seq apb_rd_seq;

        bit [7:0] ctrl_reg_1;
        int repeat_count = 1;

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                apb_seq = repeat_apb_seq::type_id::create("apb_seq");
                spi_seq = repeat_spi_seq::type_id::create("spi_seq");
                apb_rd_seq = repeat_read_seq::type_id::create("apb_rd_seq ");

                ctrl_reg_1 = 8'b0101_0001;

                uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg_1",ctrl_reg_1);
                uvm_config_db#(int)::set(this,"*","repeat_count",repeat_count);



        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                        phase.raise_objection(this);

                repeat(100)
                        begin
 begin
                                fork
                                        spi_seq.start(env.spi_agt_top.spi_agt[0].spi_seqr);
                                        apb_seq.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                                join
                                #1000;
                                apb_rd_seq.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                                #1000;
                        end

                        phase.drop_objection(this);
        endtask


endclass



class low_power_test extends base_test;

        `uvm_component_utils(low_power_test)

        function new (string name = "low_power_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        lp_apb_seq lp_apb;
        lp_spi_seq lp_spi;
        lp_apb_read_seq lp_apb_r;

        bit [7:0] ctrl_reg_1;
        bit [7:0] ctrl_reg_2;


        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
            lp_apb = lp_apb_seq::type_id::create("lp_apb");
                lp_spi = lp_spi_seq::type_id::create("lp_spi");
                lp_apb_r = lp_apb_read_seq::type_id::create("lp_apb_r ");

                ctrl_reg_1 = 8'b0101_0001;
                ctrl_reg_2 = 8'b0000_0010;

                uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg_1",ctrl_reg_1);
                uvm_config_db#(bit[7:0])::set(this,"*","ctrl_reg_2",ctrl_reg_2);



        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                        phase.raise_objection(this);

                        begin
                                fork
                                        lp_spi.start(env.spi_agt_top.spi_agt[0].spi_seqr);
                                        lp_apb.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                                join
                                #1000;
                                lp_apb_r.start(env.apb_agt_top.apb_agt[0].apb_seqr);
                                #1000;
                      end

                        phase.drop_objection(this);
        endtask


endclass








                                                
                                                                                                                                                     

                                  
                                                                                          
                                                                         
