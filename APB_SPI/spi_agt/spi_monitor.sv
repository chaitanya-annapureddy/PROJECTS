class spi_monitor extends uvm_monitor;

        `uvm_component_utils(spi_monitor);

        function new (string name = "spi_monitor",uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual spi_intf.SPI_MON_MP spif;
        spi_trans t1;
        spi_config spi_cfg;
        uvm_analysis_port#(spi_trans) sm2sb;

        bit [7:0] ctrl_reg_1;
        bit cpol;
        bit cphase;
        bit lsbfe;

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                if(!uvm_config_db#(spi_config)::get(this,"","spi_config",spi_cfg))
                        `uvm_fatal("SPI_MONITOR","failed to get config");

                if(!uvm_config_db#(bit[7:0])::get(this,"","ctrl_reg_1",ctrl_reg_1))
                        `uvm_fatal(get_type_name(),"FAILED TO GET CTRL_REG_1");

                t1 = spi_trans::type_id::create("t1");
                sm2sb = new("sm2sb",this);

                cpol = ctrl_reg_1[3];
                cphase = ctrl_reg_1[2];
                lsbfe = ctrl_reg_1[0];

        endfunction


        function void connect_phase(uvm_phase phase);
                super.connect_phase(phase);

                spif = spi_cfg.spif;

        endfunction

        task run_phase(uvm_phase phase);
              forever
                        begin
                                sample_frm_dut();
                                sm2sb.write(t1);
                        end

        endtask

        task sample_frm_dut();
                begin

                        wait(spif.spi_mon_cb.ss == 0)

                        begin
                                if(lsbfe == 1)

                                        begin

                                                if( (cphase == 0 && cpol == 0) || (cphase == 1 && cpol == 1) )
                                                        begin

                                                                for(int i = 0; i < 8; i++)
                                                                        begin
                                                                                @(posedge spif.spi_mon_cb.sclk);
                                                                                t1.miso[i] = spif.spi_mon_cb.miso;
                                                                                t1.mosi[i] = spif.spi_mon_cb.mosi;
                                                                                t1.spi_int_req = spif.spi_mon_cb.spi_inpt_req;
                                                                                t1.sclk = spif.spi_mon_cb.sclk;
                                                                                t1.ss = spif.spi_mon_cb.ss;
                                                                        end

                                                        end
                                           else
                                                        begin

                                                                for(int i = 0; i < 8; i++)
                                                                        begin
                                                                                @(negedge spif.spi_mon_cb.sclk);
                                                                                t1.miso[i] = spif.spi_mon_cb.miso;
                                                                                t1.mosi[i] = spif.spi_mon_cb.mosi;
                                                                                t1.spi_int_req = spif.spi_mon_cb.spi_inpt_req;
                                                                                t1.sclk = spif.spi_mon_cb.sclk;
                                                                                t1.ss = spif.spi_mon_cb.ss;
                                                                        end
                                                        end

                                        end


                                else
                                        begin
                                                if( (cphase == 0 && cpol == 0) || (cphase == 1 && cpol == 1) )
                                                        begin

                                                                for(int i = 7; i >= 0; i--)
                                                                        begin
                                                                                @(posedge spif.spi_mon_cb.sclk);
                                                                                t1.miso[i] = spif.spi_mon_cb.miso;
                                                                                t1.mosi[i] = spif.spi_mon_cb.mosi;
                                                                                t1.spi_int_req = spif.spi_mon_cb.spi_inpt_req;
                                                                                t1.sclk = spif.spi_mon_cb.sclk;
                                                                                t1.ss = spif.spi_mon_cb.ss;
                                                                        end
                                                        end

                                                else
                                                        begin
                                                               begin

                                                                for(int i = 7; i >= 0; i--)
                                                                        begin
                                                                                @(negedge spif.spi_mon_cb.sclk);
                                                                                t1.miso[i] = spif.spi_mon_cb.miso;
                                                                                t1.mosi[i] = spif.spi_mon_cb.mosi;
                                                                                t1.spi_int_req = spif.spi_mon_cb.spi_inpt_req;
                                                                                t1.sclk = spif.spi_mon_cb.sclk;
                                                                                t1.ss = spif.spi_mon_cb.ss;
                                                                        end
                                                        end
                                        end

                        end

                end


        //      `uvm_info(get_type_name(),"SAMPLING FRM DUT",UVM_LOW)
        //      t1.print();


        endtask


endclass




