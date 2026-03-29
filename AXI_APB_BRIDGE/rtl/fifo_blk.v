module fifo_sub(sclk,srstn,mclk,mrstn,wa_push,wa_wdata,wa_full,wa_pop,wa_rdata,wa_empty,wd_push,wd_wdata,wd_full,wd_pop,wd_rdata,wd_empty,ra_push,ra_wdata,ra_full,ra_pop,ra_rdata,ra_empty,rd_pop,rd_rdata,rd_empty,rd_push,rd_wdata,rd_full);

parameter aw=32,dw=32,iw=4,lw=4;
input srstn,sclk,mrstn,mclk,wa_push,wd_push,ra_push,rd_pop,wa_pop,wd_pop,ra_pop,rd_push;
input [(aw+iw+lw+7):0]wa_wdata,ra_wdata;
input [((dw/8)+dw):0]wd_wdata;
input [(dw+iw+2):0]rd_wdata;
output [(dw+iw+2):0]rd_rdata;
output [(aw+iw+lw+7):0]wa_rdata,ra_rdata;
output [((dw/8)+dw):0]wd_rdata;
output wa_full,wd_full,ra_full,rd_empty,wa_empty,wd_empty,ra_empty,rd_full;

//dut instantiation

//write address fifo
dp_fifo #(.aw(2) , .dw(aw+iw+lw+8)) f1(sclk,srstn,wa_push,wa_wdata,wa_full,mclk,mrstn,wa_pop,wa_rdata,wa_empty);

//write data fifo
dp_fifo #(.aw(2+lw) , .dw((dw/8)+dw+1)) f2(sclk,srstn,wd_push,wd_wdata,wd_full,mclk,mrstn,wd_pop,wd_rdata,wd_empty);

//read address fifo
dp_fifo #(.aw(2), .dw(aw+iw+lw+8)) f3(sclk,srstn,ra_push,ra_wdata,ra_full,mclk,mrstn,ra_pop,ra_rdata,ra_empty);

//read data fifo
dp_fifo #(.aw(2+lw), .dw(dw+iw+3)) f4(sclk,srstn,rd_push,rd_wdata,rd_full,mclk,mrstn,rd_pop,rd_rdata,rd_empty);

endmodule
~
