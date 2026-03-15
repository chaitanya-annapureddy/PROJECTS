 class spi_test extends uvm_test;
          `uvm_component_utils(spi_test)

           spi_env       env_han;
           spi_env_cfg   env_cfg_h;
           spi_cfg       sp_cfg_i[];
           apb_cfg       ap_cfg_i[];
           bit [7:0]ctrl;

           int no_of_spi_agts =1;
           int no_of_apb_agts =1;

           function new(string name="spi_test",uvm_component parent=null);
                    super.new(name,parent);
           endfunction

           function void build_phase(uvm_phase phase);
                env_cfg_h = spi_env_cfg::type_id::create("env_cfg_h");

                sp_cfg_i = new[no_of_spi_agts];
                ap_cfg_i = new[no_of_apb_agts];

                env_cfg_h.ap_cfg_han = new[no_of_spi_agts];
                env_cfg_h.sp_cfg_han = new[no_of_apb_agts];

                foreach(sp_cfg_i[i])
                  begin
                        sp_cfg_i[i] = spi_cfg::type_id::create($sformatf("sp_cfg_i[%0d]",i));
                        if(!uvm_config_db#(virtual spi_intf)::get(this,"","spi_intf",sp_cfg_i[i].spi_vif))
                            `uvm_fatal(get_type_name(),"check the top")
                        sp_cfg_i[i].is_active = UVM_ACTIVE;
                        env_cfg_h.sp_cfg_han[i] = sp_cfg_i[i];
                  end

                foreach(ap_cfg_i[i])
                  begin
                        ap_cfg_i[i] = apb_cfg::type_id::create($sformatf("ap_cfg_i[%0d]",i));
                        if(!uvm_config_db#(virtual apb_intf)::get(this,"","apb_intf",ap_cfg_i[i].apb_vif))
                          `uvm_fatal(get_type_name(),"check the top interface setting")
                        ap_cfg_i[i].is_active = UVM_ACTIVE;
                        env_cfg_h.ap_cfg_han[i] = ap_cfg_i[i];
                  end


                env_cfg_h.no_of_spi_agts = no_of_spi_agts;
              env_cfg_h.no_of_apb_agts = no_of_apb_agts;


                env_han = spi_env::type_id::create("env_han",this);
                uvm_config_db #(spi_env_cfg)::set(this,"*","spi_env_cfg",env_cfg_h);

           endfunction


           function void end_of_elaboration_phase(uvm_phase phase);
                      uvm_top.print_topology();
           endfunction

   endclass

/////////////////////////////////////////////////////////////////////////////////////////
///////       RESET TEST CASE           ///////////////////////////////////////////

      class reset_test extends spi_test;
        `uvm_component_utils(reset_test)


         function new(string name="",uvm_component parent);
                 super.new(name,parent);
         endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task run_phase(uvm_phase phase);

                rst_apb_sqn rst_sqn_han = rst_apb_sqn::type_id::create("rst_sqn_han");

                phase.raise_objection(this);
                        rst_sqn_han.start(env_han.apb_agtop_han. agt_han[0].sqr_han);
                phase.drop_objection(this);

        endtask

     endclass

 ///////////////// CPOL == 0 AND CPHA == 0  TEST CASE //////////////////////////////////////////
                //     lsbfe = 1 means when u receiving u will receive it from lsb side but driving is normally only

     class test_cpol_cpha_00 extends spi_test;
        `uvm_component_utils(test_cpol_cpha_00)

        function new(string name="",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
        endfunction


        task run_phase(uvm_phase phase);
                sqn_cpha0_cpol0   han;
                spi_sqn           han2;
                cpol0_cpha0_read  han3;


                han = sqn_cpha0_cpol0::type_id::create("han");
                han2 = spi_sqn::type_id::create("han2");
                han3 = cpol0_cpha0_read::type_id::create("han3");

                phase.raise_objection(this);

                ctrl = 8'b0001_0001;
;
                uvm_config_db #(bit[7:0])::set(this,"*","bit[7:0]",ctrl);

                  fork
                        han.start(env_han.apb_agtop_han.agt_han[0].sqr_han);   // for writing only
                        han2.start(env_han.spi_agtop_han.agt_han[0].sqr_han);
                  join

                   // for reading purpose full duplex write and read

                        #10000;
                         han3.start(env_han.apb_agtop_han.agt_han[0].sqr_han);
                        #10000;
                phase.drop_objection(this);
        endtask
        endclass

                                                  
                                                                                          
                                                                         
