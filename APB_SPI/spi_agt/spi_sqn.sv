
class spi_base_sequence extends uvm_sequence#(spi_trans);

        `uvm_object_utils(spi_base_sequence)

        function new (string name = "spi_base_sequence");
                super.new(name);
        endfunction


endclass

class cpol_cphase_00_spi extends spi_base_sequence;

        `uvm_object_utils(cpol_cphase_00_spi);

        function new (string name = "cpol_cphase_00_spi");
                super.new(name);
        endfunction

        task body();
                begin

                        req = spi_trans::type_id::create("req");

                        start_item(req);
                        assert(req.randomize() with { miso == 8'b1111_0000; });
                        finish_item(req);

                end
        endtask

endclass


class cpol_cphase_01_spi extends spi_base_sequence;

        `uvm_object_utils(cpol_cphase_01_spi);

        function new (string name = "cpol_cphase_01_spi");
                super.new(name);
        endfunction

        task body();
                begin
                  
                        req = spi_trans::type_id::create("req");

                        start_item(req);
                        assert(req.randomize() with { miso == 8'b1111_1001; });
                        finish_item(req);

                end
        endtask

endclass


class cpol_cphase_10_spi extends spi_base_sequence;

        `uvm_object_utils(cpol_cphase_10_spi);

        function new (string name = "cpol_cphase_10_spi");
                super.new(name);
        endfunction

        task body();
                begin

                        req = spi_trans::type_id::create("req");

                        start_item(req);
                        assert(req.randomize() with { miso == 8'b1001_1001; });
                        finish_item(req);

                end
        endtask

endclass


class cpol_cphase_11_spi extends spi_base_sequence;

        `uvm_object_utils(cpol_cphase_11_spi);

        function new (string name = "cpol_cphase_11_spi");
                super.new(name);
        endfunction

        task body();
                begin

                        req = spi_trans::type_id::create("req");

                        start_item(req);
                        assert(req.randomize() with { miso == 8'b1001_1001; });
                        finish_item(req);

                end
        endtask

endclass


class cpol_cphase_00m_spi extends spi_base_sequence;

        `uvm_object_utils(cpol_cphase_00m_spi);

        function new (string name = "cpol_cphase_00m_spi");
                super.new(name);
        endfunction

        task body();
                begin

                        req = spi_trans::type_id::create("req");

                        start_item(req);
                        assert(req.randomize() with { miso == 8'b1101_1101; });

                            finish_item(req);

                end
        endtask

endclass


class cpol_cphase_01m_spi extends spi_base_sequence;

        `uvm_object_utils(cpol_cphase_01m_spi);

        function new (string name = "cpol_cphase_01m_spi");
                super.new(name);
        endfunction

        task body();
                begin

                        req = spi_trans::type_id::create("req");

                        start_item(req);
                        assert(req.randomize() with { miso == 8'b1001_1101; });
                        finish_item(req);

                end
        endtask

endclass

class cpol_cphase_10m_spi extends spi_base_sequence;

        `uvm_object_utils(cpol_cphase_10m_spi);

        function new (string name = "cpol_cphase_10m_spi");
                super.new(name);
        endfunction

        task body();  begin

                        req = spi_trans::type_id::create("req");

                        start_item(req);
                        assert(req.randomize() with { miso == 8'b1111_1101; });
                        finish_item(req);

                end
        endtask

endclass

class cpol_cphase_11m_spi extends spi_base_sequence;

        `uvm_object_utils(cpol_cphase_11m_spi);

        function new (string name = "cpol_cphase_11m_spi");
                super.new(name);
        endfunction

        task body();
                begin
                         begin

                        req = spi_trans::type_id::create("req");

                        start_item(req);
                        assert(req.randomize() with { miso == 8'b1100_1101; });
                        finish_item(req);

                end
        endtask

endclass


class repeat_spi_seq extends spi_base_sequence;

        `uvm_object_utils(repeat_spi_seq);

        function new (string name = "repeat_spi_seq");
                super.new(name);
        endfunction

        int repeat_count;

        task body();

                        if(!uvm_config_db#(int)::get(null,get_full_name(),"repeat_count",repeat_count))
                        `uvm_fatal(get_type_name(),"failed getting repeat_count")


                repeat(repeat_count)
                        begin

                                req = spi_trans::type_id::create("req");
                                start_item(req);
                                assert(req.randomize());
                                finish_item(req);

                end

        endtask

endclass




class lp_spi_seq extends spi_base_sequence;

        `uvm_object_utils(lp_spi_seq);

        function new (string name = "lp_spi_seq");
                super.new(name);
        endfunction

        task body();

                        begin

                                req = spi_trans::type_id::create("req");
                                start_item(req);
                                assert(req.randomize());
                                finish_item(req);

                        end

        endtask

endclass



                         

                               

