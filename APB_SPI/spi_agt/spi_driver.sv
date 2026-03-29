class spi_driver extends uvm_driver#(spi_trans);

        `uvm_component_utils(spi_driver)

        function new (string name = "spi_driver",uvm_component parent);
                super.new(name,parent);
        endfunction

        virtual spi_intf.SPI_DRV_MP spif;
        spi_config spi_cfg;


        bit [7:0] ctrl_reg_1;

        bit cpol;
        bit cphase;
        bit lsbfe;



        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                if(!uvm_config_db#(spi_config)::get(this,"","spi_config",spi_cfg))
                        `uvm_fatal("SPI_DRIVER","FAILED TO GET CONFIG");


                if(!uvm_config_db#(bit[7:0])::get(this,"","ctrl_reg_1",ctrl_reg_1))
                        `uvm_fatal(get_type_name,"FAILED TO GET CTRL_REG_1")

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
                                seq_item_port.get_next_item(req);
                                send_to_dut(req);
                                seq_item_port.item_done();
                        end

        endtask

        task send_to_dut(spi_trans t1);
                begin

                        wait(spif.spi_drv_cb.ss == 0)

                        begin
                                if(lsbfe == 1)
                                        begin

                                                if(cpol == 0 && cphase == 0)
                                                        begin
                                                                spif.spi_drv_cb.miso <= t1.miso[0];

                                                                for(int i = 1; i < 8; i++ )
                                                                        begin

                                                                        @(negedge spif.spi_drv_cb.sclk);

                                                                       spif.spi_drv_cb.miso <= t1.miso[i];

                                                                        end
                                                        end

                                               else if(cpol == 0 && cphase == 1)
                                                        begin

                                                                for(int i = 0; i < 8; i++)
                                                                        begin
                                                                                @(posedge spif.spi_drv_cb.sclk);
                                                                                spif.spi_drv_cb.miso <= t1.miso[i];
                                                                        end
                                                        end

                                                else if(cpol == 1 && cphase == 0)
                                                        begin

                                                                spif.spi_drv_cb.miso <= t1.miso[0];

                                                                for(int i = 1; i < 8; i++ )
                                                                        begin
                                                                                @(posedge spif.spi_drv_cb.sclk);
                                                                                spif.spi_drv_cb.miso <= t1.miso[i];
                                                                        end
                                                        end
                                                else
                                                        begin
                                                           begin

                                                                for(int i = 0; i < 8; i++)
                                                                        begin
                                                                                @(negedge spif.spi_drv_cb.sclk);
                                                                                spif.spi_drv_cb.miso <= t1.miso[i];
                                                                        end
                                                        end
                                        end

                                     else
                                        begin

                                                if(cpol == 0 && cphase == 0)
                                                        begin

                                                                spif.spi_drv_cb.miso <= t1.miso[7];

                                                                for(int i = 6; i >= 0; i--)
                                                                        begin
                                                                                @(negedge spif.spi_drv_cb.sclk);
                                                                                spif.spi_drv_cb.miso <= t1.miso[i];
                                                                        end
                                                        end

                                                else if(cpol == 0 && cphase == 1)
                                                        begin

                                                                for(int i = 7; i >= 0; i--)
                                                                        begin
                                                                                @(posedge spif.spi_drv_cb.sclk);
                                                                                spif.spi_drv_cb.miso <= t1.miso[i];
                                                                        end
                                                        end

                                                else if(cpol == 1 && cphase == 0)
                                                        begin

                                                                spif.spi_drv_cb.miso <= t1.miso[7];

                                                                for(int i = 6; i >= 0; i--)
                                                                        begin
                                                                                @(posedge spif.spi_drv_cb.sclk);
                                                                                spif.spi_drv_cb.miso <= t1.miso[i];
                                                                        end
                                                        end

                                                else
                                                        begin
                                                                begin

                                                                for(int i = 7; i >= 0; i--)
                                                                        begin
                                                                                @(negedge spif.spi_drv_cb.sclk);
                                                                                spif.spi_drv_cb.miso <= t1.miso[i];
                                                                        end
                                                        end
                                        end
                        end
                end

        //      `uvm_info(get_type_name(),"DRIVING TO DUT",UVM_LOW)
        //      t1.print();

        endtask

endclass




