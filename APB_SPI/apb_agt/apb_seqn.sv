class apb_base_sequence extends uvm_sequence#(apb_trans);

        `uvm_object_utils(apb_base_sequence)

        function new (string name = "apb_base_sequence");
                super.new(name);
        endfunction


endclass

class apb_reset_sequence extends apb_base_sequence;

        `uvm_object_utils(apb_reset_sequence)

        function new (string name = "apb_reset_sequence");
                super.new(name);
        endfunction

        task body();
                begin


                        req = apb_trans::type_id::create("req");

                        //SPI CONTROL REG 1
                        start_item(req);
                        assert(req.randomize() with { Pwrite == 0; Paddr == 3'd0; Pwdata == 0;});
                        finish_item(req);

                        //SPI CONTROL REG
                        start_item(req);
                        assert(req.randomize() with {Pwrite == 0; Paddr == 3'd1; Pwdata == 0;});
                        finish_item(req);

                        //BAUD REG
                        start_item(req);
                        assert(req.randomize() with {Pwrite == 0; Paddr == 3'd2; Pwdata == 0;});
                        finish_item(req);

                        //STATUS REG
                        start_item(req);
                        assert(req.randomize() with {Pwrite == 0; Paddr == 3'd3; Pwdata == 0;});
                        finish_item(req);

                        //DATA REG
                   assert(req.randomize() with {Pwrite == 0; Paddr == 3'd5; Pwdata == 0;});
                        finish_item(req);


                end
        endtask

endclass




//                                                              cpol == 0       cphase == 0


//                                                              sampl @pos      drvi @neg
//                                                              imme drv

class cpol_cphase_00_apb extends apb_base_sequence;

        `uvm_object_utils(cpol_cphase_00_apb)

        function new(string name = "cpol_cphase_00_apb");
                super.new(name);
        endfunction

        bit[7:0] ctrl_reg_1;
        bit cpol;
        bit cphase;


        task body();
                begin

                        if(!uvm_config_db#(bit[7:0])::get(null,get_full_name(),"ctrl_reg_1",ctrl_reg_1))
                                `uvm_fatal(get_type_name(),"failed getting ctrl_reg_1")


                        req = apb_trans::type_id::create("apb_trans");

                        //SPI CONTROL REG 1
                        start_item(req);
                        assert(req.randomize() with { Pwrite == 1; Paddr == 3'd0; Pwdata == ctrl_reg_1;});
                        finish_item(req);

                        //SPI CONTROL REG
                        start_item(req);
                        assert(req.randomize() with {Pwrite == 1; Paddr == 3'd1; Pwdata == 0;});
                        finish_item(req);

                        //BAUD REG
                        start_item(req);
                        assert(req.randomize() with {Pwrite == 1; Paddr == 3'd2; Pwdata == 0;});
                        finish_item(req);


                        //DATA REG
                        start_item(req);
                        assert(req.randomize() with {Pwrite == 1; Paddr == 3'd5; Pwdata == 8'b1001_1001;});
                        finish_item(req);

                end
        endtask

endclass


class apb_read_00_seq extends apb_base_sequence;

        `uvm_object_utils(apb_read_00_seq)

        function new (string name = "apb_read_00_seq");
                super.new(name);
        endfunction

        task body();

                begin
                        req = apb_trans::type_id::create("req");

                        //STATUS REG
                        start_item(req);
                        assert(req.randomize() with {Pwrite == 0; Paddr == 3'd3; Pwdata == 0;});
                        finish_item(req);


                        //DATA REG
                        start_item(req);
                        assert(req.randomize() with {Pwrite == 0; Paddr == 3'd5;});
                        finish_item(req);
                end

        endtask

endclass


//                                                              --- x    end of sequence  x ---






//                                                              cpol == 0       cphase == 1


//                                                              sampl @neg      drvi @pos
//                                                              next cycle drv




class cpol_cphase_01_apb extends apb_base_sequence;

        `uvm_object_utils(cpol_cphase_01_apb)

        function new(string name = "cpol_cphase_01_apb");
                super.new(name);
        endfunction

        bit[7:0] ctrl_reg_1;
        bit cpol;
        bit cphase;


        task body();
                begin

                        if(!uvm_config_db#(bit[7:0])::get(null,get_full_name(),"ctrl_reg_1",ctrl_reg_1))
                                `uvm_fatal(get_type_name(),"failed getting ctrl_reg_1")


                        req = apb_trans::type_id::create("apb_trans");

                        //SPI CONTROL REG 1
                        start_item(req);
                                                     //SPI CONTROL REG 1
                        start_item(req);
                        assert(req.randomize() with { Pwrite == 1; Paddr == 3'd0; Pwdata == ctrl_reg_1;});
                        finish_item(req);

                        //SPI CONTROL REG
                        start_item(req);
                        assert(req.randomize() with {Pwrite == 1; Paddr == 3'd1; Pwdata == 0;});
                        finish_item(req);

                        //BAUD REG
                        start_item(req);
                        assert(req.randomize() with {Pwrite == 1; Paddr == 3'd2; Pwdata == 0;});
                        finish_item(req);


                        //DATA REG
                        start_item(req);
                        assert(req.randomize() with {Pwrite == 1; Paddr == 3'd5; Pwdata == 8'b1001_1001;});
                        finish_item(req);

                end
        endtask

endclass


class apb_read_01_seq extends apb_base_sequence;

        `uvm_object_utils(apb_read_01_seq)

        function new (string name = "apb_read_01_seq");
                super.new(name);
        endfunction

        task body();

                begin
                        req = apb_trans::type_id::create("req");

                        //STATUS REG
                                                       start_item(req);
                        assert(req.randomize() with {Pwrite == 0; Paddr == 3'd3; Pwdata == 0;});
                        finish_item(req);


                        //DATA REG
                        start_item(req);
                        assert(req.randomize() with {Pwrite == 0; Paddr == 3'd5;});
                        finish_item(req);
                end

        endtask

endclass



                         



                                          
