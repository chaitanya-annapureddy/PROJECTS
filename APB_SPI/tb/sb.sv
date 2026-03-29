class scoreboard extends uvm_scoreboard;

        `uvm_component_utils(scoreboard)

        function new (string name = "scoreboard",uvm_component parent);
                super.new(name,parent);
        endfunction

        uvm_tlm_analysis_fifo#(apb_trans) am2sb;
        uvm_tlm_analysis_fifo#(spi_trans) sm2sb;

        apb_trans at;
        spi_trans st;


        int ap_rdata[$];
        int ap_wdata[$];

        int sp_miso[$];
        int sp_mosi[$];

        int Prdata,Pwdata;
        int mosi,miso;

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);

                am2sb = new("am2sb",this);
                sm2sb = new("sm2sb",this);

                at = apb_trans::type_id::create("at");
                st = spi_trans::type_id::create("st");


        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);


                fork
                        forever
                                begin
                                        am2sb.get(at);
                                        `uvm_info(get_type_name(),"DATA FRM APB_MON",UVM_LOW);
                                     at.print();
                                        ap_rdata.push_back(at.Prdata);
                                        ap_wdata.push_back(at.Pwdata);
                                end

                        forever
                                begin
                                        sm2sb.get(st);
                                        `uvm_info(get_type_name(),"DATA FRM SPI_MON",UVM_LOW);
                                        st.print();
                                        sp_miso.push_back(st.miso);
                                        sp_mosi.push_back(st.mosi);
                                end

                join



        endtask


        function void report_phase(uvm_phase phase);
                super.report_phase(phase);
            for(int i = 0 ; i < $size(sp_miso) ; i++ )
                        begin
                                foreach(ap_rdata[j])
                                        begin
                                                if(sp_miso[i] == ap_rdata[j] )
                                                        begin
                                                                $display("\n\n ============= THE MISO DATA IS CORRECT ============= ");
                                                                $display("\tPRDATA == %d   \t  MISO == %d" ,ap_rdata[j],sp_miso[i]);
                                                                $display(" ================ COMPARISSION PASSED ================ \n\n");
                                                        end
                                                else
                                                        begin
                                                        //      $display(" ================ COMPARISSION FAILED ================ \n\n");
                                                        end
                                        end
                        end


                for(int i = 0 ; i < $size(sp_mosi) ; i++ )
                        begin
                                foreach(ap_wdata[j])
                                        begin
                                                if(sp_mosi[i] == ap_wdata[j] )
                                                        begin
                                                                $display("\n\n ============= THE MOSI DATA IS CORRECT ============= ");
                                                                $display("\tPWDATA == %d   \t  MOSI == %d" ,ap_wdata[j],sp_mosi[i]);
                                                                $display(" ================ COMPARISSION PASSED ================ \n\n");
                                                        end
                                                else
                                                        begin
                                                        //      $display(" ================ COMPARISSION FAILED ================ \n\n");
                                                        end
                                        end
                        end



        endfunction


endclass



