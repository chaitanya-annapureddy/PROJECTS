
 `timescale 1ns / 1ps
 interface spi_intf(input bit clock);
   bit       ss;
   bit      sclk;
   bit      mosi;
   bit      miso;
   bit      spi_inpt_req;

   clocking spi_drv_cb@(posedge clock);
     default input #1 output #1;
     input  ss;
     input  sclk;
     input  mosi;
     output miso;
     input  spi_inpt_req;
   endclocking


   clocking spi_mon_cb@(posedge clock);
     default input #1 output #1;
     input ss;
     input sclk;
     input mosi;
     input miso;
     input spi_inpt_req;
   endclocking

   modport SPI_DRV_MP (clocking spi_drv_cb,output miso);
   modport SPI_MON_MP (clocking spi_mon_cb,input ss, sclk, mosi, miso, spi_inpt_req);
 endinterface
-- VISUAL LINE --                                                                                                                          56        56,2          Bot
