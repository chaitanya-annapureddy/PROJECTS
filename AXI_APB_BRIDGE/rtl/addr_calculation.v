
//aw = 32,iw = 4, lw =4
module apb_addr_calc (  input [47:0] waddr_ctrl_data,
                        input waddr_fifo_empty,
                        output waddr_fifo_pop,

                        input [47:0] raddr_ctrl_data,
                        input raddr_fifo_empty,
                        output raddr_fifo_pop,

                        input PCLK,
                        input PRESETn,
                        input waddr_wen,
                        input raddr_ren,

                        output [42:0] r_write_prot_addr_id,
                        output [42:0] r_read_prot_addr_id,
                        output  w_addr_fe,
                        output  r_addr_fe
                                );



                reg waddr_calc_progress;
                reg raddr_calc_progress;
                reg raddr_pop;
                reg waddr_pop;
                reg w_pop;
                reg r_pop;


                wire[2:0] awprot,arprot;
                wire[1:0] awid,arid;


        wire[1:0] awid,arid;

                reg w_addr_push;
                reg r_addr_push;

                wire w_addr_ff;
                wire r_addr_ff;

                wire[31:0] write_start_address;
                reg[31:0] write_next_address;
                wire[3:0] awlen;
                wire[2:0] awsize;
                wire[1:0] awburst;

                wire[31:0] read_start_address;
                reg[31:0] read_next_address;
                wire[3:0] arlen;
                wire[2:0] arsize;
                wire[1:0] arburst;

                reg[3:0] w_count;
                reg[3:0] r_count;

                wire [8:0] w_no_of_bytes;
                wire[8:0] r_no_of_bytes;
                wire[42:0] w_write_prot_addr_id,w_read_prot_addr_id;

                assign write_start_address = waddr_ctrl_rdata[35:4];
                assign read_start_address = raddr_ctrl_rdata[35:4];

                assign w_write_prot_addr_id = {awprot,awlen,write_next_address,awid};
                assign w_read_prot_addr_id = {arprot,arlen,read_next_address,arid};

                assign w_no_of_bytes = 2**awsize;
                assign r_no_of_bytes = 2**arsize;

                assign awid = waddr_ctrl_rdata[3:0];
                assign arid = raddr_ctrl_rdata[3:0];

                assign awlen = waddr_ctrl_rdata[39:36];
                assign arlen = raddr_ctrl_rdata[39:36];
                   begin

   assign awlen = waddr_ctrl_rdata[39:36];
                assign arlen = raddr_ctrl_rdata[39:36];

                assign awsize = waddr_ctrl_rdata[42:40];
                assign arsize = raddr_ctrl_rdata[42:40];

                assign awburst = waddr_ctrl_rdata[44:43];
                assign arburst = raddr_ctrl_rdata[44:43];

                assign awprot = waddr_ctrl_rdata[47:45];
                assign arprot = raddr_ctrl_rdata[47:45];

                //write_address_pop

                always@(*)
                        begin
                                if((!waddr_fifo_empty) && (!waddr_calc_progress) && (!w_addr_ff) && (!w_pop))
                                        waddr_pop = 1'b1;
                                else
                                        waddr_pop = 1'b0;
                        end

                //read_address_pop

                always@(*)
                        begin
                                if((!raddr_fifo_empty) && (!raddr_calc_progress) && (!r_addr_ff) && (!r_pop))
                                        raddr_pop = 1'b1;
                                else
                                        raddr_pop = 1'b0;
                        end
                //write next address based on the burst types

                always@(posedge PCLK or negedge PRESETn)
                        begin

                                if(!PRESETn)
                                        begin
                                                w_count <= 'b0;
                                                waddr_calc_progress <= 1'b0;
                                                w_addr_push <= 1'b0;
                                                w_pop <= 1'b0;
                                        end
                                else
                                        begin
                                                if(w_count <= {1'b0,awlen})
                                                        begin
                                                                w_pop <= 1'b0;
                                                                waddr_calc_progress <= 1'b1;
                                                                w_addr_push <= 1'b1;
                                                                if(awburst == 2'b00)
                                                                        write_next_address <= (write_start_address/w_no_of_bytes)*w_no_of_bytes;
                                                                else
                                                                        write_next_address <= (write_start_address/w_no_of_bytes)*w_no_of_bytes;
                                                                w_count <= w_count + 1'b1;
                                                        end
                                                else
                                                        begin
                                                                w_pop <= w_pop;
                                                                w_count <= w_count;
                                                                waddr_calc_progress <= waddr_calc_progress;
                                                                w_addr_push <= 1'b0;
                                                        end
                                        end
                                else
                                        begin
                                                if(waddr_fifo_pop)
                                                begin
                                                        w_count <= 1'b0;
                                                        w_pop <= 1'b1;
                                                end
                                                else
                                                begin
                                                        w_count <= w_count;
                                                        w_pop <= w_pop;
                                                end
                                                waddr_calc_progress <= 1'b0;
                                                w_addr_push <= 1'b1;
                                        end
                                end


-- VISUAL LINE --                                                                                                                          151       151,0-1       Bot
