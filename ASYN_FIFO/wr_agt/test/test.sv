   class base_test extends uvm_test;
          `uvm_component_utils(base_test)

           env             env_han;
           env_cfg         env_cfg_h;
           wr_cfg          wr_cfg_i;
           rd_cfg          rd_cfg_i;

           function new(string name="base_test",uvm_component parent=null);
                    super.new(name,parent);
           endfunction

           function void build_phase(uvm_phase phase);
                env_cfg_h = env_cfg::type_id::create("env_cfg_h");

                //WRITE CONIFG
                wr_cfg_i= wr_cfg::type_id::create("wr_cfg");
                if(!uvm_config_db#(virtual asyn_fifo_intf)::get(this,"","asyn_fifo_intf",wr_cfg_i.vif))
                 `uvm_fatal(get_type_name(),"check the top")
                wr_cfg_i.is_active = UVM_ACTIVE;
                env_cfg_h.wr_cfg_h = wr_cfg_i;


                //READ CONFIG
                rd_cfg_i = rd_cfg::type_id::create("rd_cfg");
                if(!uvm_config_db#(virtual asyn_fifo_intf)::get(this,"","asyn_fifo_intf",rd_cfg_i.vif))
                  `uvm_fatal(get_type_name(),"check the top interface setting")
                rd_cfg_i.is_active = UVM_ACTIVE;
                env_cfg_h.rd_cfg_h = rd_cfg_i;




                env_han = env::type_id::create("env_han",this);
                uvm_config_db #(env_cfg)::set(this,"*","env_cfg",env_cfg_h);

           endfunction


           function void end_of_elaboration_phase(uvm_phase phase);
                      uvm_top.print_topology();
           endfunction
   endclass


        class wr_rd_half_test extends base_test;
           `uvm_component_utils(wr_rd_half_test)

            wr_sqn_1 wr_sq_han;
            rd_sqn_1 rd_sq_han;

            bit[3:0] no_of_operations = 18;

            function new(string name ="wr_rd_half_test",uvm_component parent);
                  super.new(name,parent);
            endfunction

            function void build_phase(uvm_phase phase);
                uvm_config_db  #(bit[3:0]) :: set(this,"*","bit",no_of_operations);
                super.build_phase(phase);  //need to call this
            endfunction

            task run_phase(uvm_phase phase);
                wr_sq_han = wr_sqn_1::type_id::create("wr_sq_han");
                rd_sq_han = rd_sqn_1::type_id::create("rd_sq_han");

                        phase.raise_objection(this);
        //       fork
                                $display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
                                wr_sq_han.start(env_han.wr_agtop_han.wr_agt_han.sqr_han);
                                $display("//////////////////////////////////////");

                          //rd_sq_han.start(env_han.rd_agtop_han.rd_agt_han.sqr_han);
        //               join
                        #100;
                        phase.drop_objection(this);
            endtask

        endclass
   /// empty test case

                class empty_test extends base_test;
           `uvm_component_utils(empty_test)

            //wr_sqn_1 wr_sq_han;
            rd_sqn_1 rd_sq_han;

            bit[3:0] no_of_operations = 18;

            function new(string name ="",uvm_component parent);
                  super.new(name,parent);
            endfunction

            function void build_phase(uvm_phase phase);
                uvm_config_db  #(bit[3:0]) :: set(this,"*","bit",no_of_operations);
                super.build_phase(phase);  //need to call this
            endfunction

            task run_phase(uvm_phase phase);
             //   wr_sq_han = wr_sqn_1::type_id::create("wr_sq_han");
                rd_sq_han = rd_sqn_1::type_id::create("rd_sq_han");

                        phase.raise_objection(this);
        //       fork
                                $display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
                        //      wr_sq_han.start(env_han.wr_agtop_han.wr_agt_han.sqr_han);

                          rd_sq_han.start(env_han.rd_agtop_han.rd_agt_han.sqr_han);
        //               join
                        #100;
                        phase.drop_objection(this);
            endtask

        endclass

                //////////////////////////////////      WRITE FIRST LATER READ SECOND ////////////////////////////////////////

                  class write_1_read_2 extends base_test;
           `uvm_component_utils(write_1_read_2)

            wr_sqn_1 wr_sq_han;
              rd_sqn_1 rd_sq_han;

            bit[3:0] no_of_operations = 18;

            function new(string name ="",uvm_component parent);
                  super.new(name,parent);
            endfunction

            function void build_phase(uvm_phase phase);
                uvm_config_db  #(bit[3:0]) :: set(this,"*","bit",no_of_operations);
                super.build_phase(phase);  //need to call this
            endfunction

            task run_phase(uvm_phase phase);
            wr_sq_han = wr_sqn_1::type_id::create("wr_sq_han");
                rd_sq_han = rd_sqn_1::type_id::create("rd_sq_han");

                        phase.raise_objection(this);
        //       fork
                                $display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
                          wr_sq_han.start(env_han.wr_agtop_han.wr_agt_han.sqr_han);


                          rd_sq_han.start(env_han.rd_agtop_han.rd_agt_han.sqr_han);
        //               join
                        #100;
                        phase.drop_objection(this);
            endtask

        endclass


                /////////////////////////////////////  PRALLEL WRITE AND READ OPERATION  //////////////////////

                class prallel_write_read extends base_test;
           `uvm_component_utils(prallel_write_read)

                    wr_sqn_1 wr_sq_han;
            rd_sqn_1 rd_sq_han;

            bit[3:0] no_of_operations = 18;

            function new(string name ="",uvm_component parent);
                  super.new(name,parent);
            endfunction

            function void build_phase(uvm_phase phase);
                uvm_config_db  #(bit[3:0]) :: set(this,"*","bit",no_of_operations);
                super.build_phase(phase);  //need to call this
            endfunction

            task run_phase(uvm_phase phase);
            wr_sq_han = wr_sqn_1::type_id::create("wr_sq_han");
                rd_sq_han = rd_sqn_1::type_id::create("rd_sq_han");

                        phase.raise_objection(this);
           fork
                                $display("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
                          wr_sq_han.start(env_han.wr_agtop_han.wr_agt_han.sqr_han);


                          rd_sq_han.start(env_han.rd_agtop_han.rd_agt_han.sqr_han);
                 join
                        #100;
                        phase.drop_objection(this);
            endtask

        endclass

        
