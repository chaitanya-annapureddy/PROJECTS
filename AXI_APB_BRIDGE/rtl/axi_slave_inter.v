 module AXI_SLAVE_INTF //#(parameter  )
                         (
                          // WRITE ADDR SIGNALS
                          input           ACLK,
                          input           ARESETn,
                          input [3:0]     AWID,
                          input [31:0]    AWADDR,
                          input [3:0]     AWLEN,
                          input [2:0]     AWSIZE,
                          input [1:0]     AWBURST,
                          input [1:0]     AWPROT,
                          input           AWVALID,
                          output           AWREADY,

                          // WRITE DATA CHANNEL SIGNALS
                          input [31:0]   WDATA,
                          input [3:0]    WSTRB,
                          input          WLAST,
                          input          WVALID,
                          output          WREADY,

                          //WRITE RESPONE
                          output [3:0]   BID,
                          output reg[1:0]   BRESP,
                          output         BVALID,
                          input         BREADY,

                          // READ ADDRESS
                          input  [3:0]  ARID,
                          input  [31:0] ARADDR,
                          input  [3:0]  ARLEN,
                          input  [2:0]  ARSIZE,
                          input  [1:0]  ARBURST,
                          input  [1:0]  ARPROT,
                          input         ARVALID,
                          output        ARREADY,


                          //READ RESPONSE
                          input         RREADY,
                          output [3:0]  RID,
                          output [31:0] RDATA,
                              output [1:0]  RRESP,
                          output  reg      RLAST,
                          output  reg   RVALID,


                          //OUTPUT SIGNALS
                          output [47:0] W_ADDR_CTRL,
                          output        W_ADDR_WEN,
                          input         W_ADDR_FULL,


                          //OUTPUT SINGALS WR DATA
                          output  [36:0] W_DATA_CTRL,
                          output         W_DATA_WEN,
                          input          W_DATA_FULL,

                          // READ ADDR SINGALS
                          output  [47:0] R_ADDR_CTRL,
                          output         R_ADDR_REN,
                          input         R_ADDR_FULL,

                          // READ DATA SIGNALS
                          input  [38:0] R_DATA_CTRL,
                          output         R_DATA_EN,
                          input          R_DATA_EMPTY,


                          // RESP CSR
                          input  [1:0] WR_RESP_2_AXI,
                          input  [3:0] WR_BID_2_AXI,

                          //USING CSR
                          input   MSTR_WR_2_AXI,
                          input   USE_MWERR_RESP
                        );


          // INTERANL SINGALS
           reg    rlast;
           wire   WR_RESP_2_AXI_S;
           reg   WR_RESP_2_AXI_S_D;
       reg   WR_RESP_2_AXI_S_D;
           wire  MSTR_WR_2_AXI_S;
           reg   W_AXI_ADDR_VLD;
           reg   R_AXI_ADDR_VLD;


           // here i have to do instantion
           pulse_sync dut (.clk(ACLK),
                           .rstn(ARESETn),
                           .data_in(MSTR_WR_2_AXI),
                           .pulse_out(MSTR_WR_2_AXI_S));




           // WRITE RESP FSM   // ONE HOT ENCODING
           reg [3:0] WR_CSTATE,WR_NSTATE;
           parameter WR_IDLE  = 4'B0001,
                     WR_IRESP = 4'B0010,
                     WR_WRESP = 4'B0100,
                     WR_MRESP = 4'B1000;


           // READ FSM
           reg  [1:0] RR_CSTATE ,RR_NSTATE;
           parameter  RR_IDLE    = 2'B01,
                      RR_RESP_MC = 2'B10;




           ////////////////////////////////////////////
           ///////////TO W_ADDRESSS CHANNEL/////////////
           /////////////////////////////////////////////

           assign  W_ADDR_CTRL  = {AWPROT,AWBURST,AWSIZE,AWLEN,AWADDR,AWID};
        assign  W_ADDR_WEN   = AWVALID && AWREADY;

           assign  AWREADY      = !(W_ADDR_FULL);


           always @ (posedge ACLK or negedge ARESETn)
             begin
                      if(!ARESETn)
                            W_AXI_ADDR_VLD <= 1'B0;
                      else
                            W_AXI_ADDR_VLD <= W_ADDR_WEN;
             end

           ////////////////////////////////////
           //////////WRITE DATA////////////////
           ////////////////////////////////////
            assign  W_DATA_WEN   = WVALID && WREADY;

            assign  WREADY       = !(W_DATA_FULL);

            assign W_DATA_CTRL  = {WLAST,WSTRB,WDATA};




           /////////////////////////////////////////////////////
          //////////// WR RESPONSE CHANNEL /////////////////////
          /////////////////////////////////////////////////////
            assign   BID = (WR_IRESP ==  WR_CSTATE)? AWID : (WR_MRESP == WR_CSTATE)?(WR_BID_2_AXI):1'b0;

   assign BVALID  = (USE_MWERR_RESP) ? (WR_CSTATE == WR_WRESP && MSTR_WR_2_AXI_S) || ((WR_CSTATE ==WR_MRESP) && MSTR_WR_2_AXI_S):(WR_IRESP == WR_CSTATE);

            always @(posedge ACLK or negedge ARESETn)
             begin
                      if(!ARESETn)
                           BRESP <= 2'B0;
                      else
                            begin
                                   if(WR_MRESP == WR_CSTATE)
                                          BRESP  <= 2'B0;
                                   else
                                           BRESP <= WR_RESP_2_AXI;
                                   end
            end


          ////////////////////////////////
          //WRITE RESPONSE FSM ///////////
          ///////////////////////////////////
            always @(posedge ACLK or negedge ARESETn)
             begin
                    if(!ARESETn)
                        WR_CSTATE <= WR_IDLE;
                    else
                        WR_CSTATE <= WR_NSTATE;
             end


           always @(*)
            begin
                  case(1'b1)

                          WR_IDLE[0] :if(!USE_MWERR_RESP && !W_AXI_ADDR_VLD)
                                       begin
                                         WR_NSTATE =  WR_IDLE;
                                         WR_CSTATE = WR_IDLE;
                                       end

                                     else if(!USE_MWERR_RESP && W_AXI_ADDR_VLD)
                                      begin
                                       WR_NSTATE = WR_IRESP;
                                       WR_CSTATE = WR_IRESP;
                                      end

                                    else
                                     begin
                                      WR_NSTATE = WR_WRESP;
                                      WR_CSTATE = WR_WRESP;
                                     end

                      WR_IRESP[1] : if(!BREADY)
                                   begin
                                     WR_NSTATE = WR_IRESP;
                                     WR_CSTATE = WR_IRESP;
                                   end

                                 else
                                     begin
                                   WR_NSTATE = WR_IDLE;
                                   WR_CSTATE = WR_IRESP;
                                  end


                     WR_WRESP[2] :
                                begin
                                   WR_NSTATE = WR_MRESP;
                                   WR_CSTATE = WR_MRESP;
                                end

                   WR_MRESP[3] : if(BREADY && BVALID)
                                  begin
                                   WR_NSTATE = WR_IDLE;
                                   WR_CSTATE = WR_MRESP;
                                  end
                                else
                                 begin
                                  WR_NSTATE = WR_MRESP;
                                  WR_CSTATE = WR_MRESP;
                                 end
                  default : WR_NSTATE = WR_IDLE;
                 endcase
          end

        //  assign WR_CSTATE = (WR_IDLE || WR_IRESP || WR_WRESP || WR_MRESP);


          //////////////////////////////////////
          /////// READ ADDRESS////////////////////
          ////////////////////////////////////////

            assign R_DATA_CTRL  = {ARPROT,ARBURST,ARSIZE,ARLEN,ARADDR,ARID};

            assign R_ADDR_REN  = (ARVALID && ARREADY);

             assign  ARREADY   = !(R_ADDR_FULL);


            always @(posedge ACLK or negedge ARESETn)
                 begin
                         if(!ARESETn)
                            R_AXI_ADDR_VLD <= 1'B0;
                         else
                             R_AXI_ADDR_VLD <= R_ADDR_REN;
                 end



           ////////////////////////////////
           // READ DATA AND READ RESPONESE
           // /////////////////////////////////

           assign  RID       =  (R_DATA_CTRL[3:0]);

           assign  RDATA     = (R_DATA_CTRL[35:4]);

           assign  RRESP     = (R_DATA_CTRL[37:36]);

           assign  R_DATA_REN = (RR_IDLE == RR_CSTATE) && (!R_DATA_EMPTY);




         // READ ADDRESS  this logic check
          // assign RLAST =  (RR_CSTATE == RR_RESP_MC)?(RVALID)? R_DATA_CTRL[38]:1'B0

           always @(*)
            begin
                   if(RR_RESP_MC == RR_CSTATE)
                        RVALID = 1'B1;
                  else
                        RVALID = 1'B0;
           end

           always @(*)
            begin
                  if(RVALID)
                   begin
                       rlast = R_DATA_CTRL[38];
                       RLAST = rlast;
                     end
                  else
                        RLAST = 1'B0;
           end

     /////////////////////////////
     // READ RESPONSE FSM //////////
     // //////////////////////////
  always @(posedge ACLK or negedge ARESETn)
             begin
                    if(!ARESETn)
                        RR_CSTATE <= RR_IDLE;
                    else
                        RR_CSTATE <= RR_RESP_MC;
             end


           always @(*)
            begin
                  case(1'B1)

                          RR_IDLE[0]: if(R_DATA_EMPTY)
                                     begin
                                       RR_NSTATE =  RR_IDLE;
                                       RR_CSTATE =  RR_IDLE;
                                     end
                                   else
                                     begin
                                        RR_NSTATE = RR_RESP_MC;
                                        RR_CSTATE =  RR_RESP_MC;
                                     end

                        RR_RESP_MC[1] : if(!RREADY)
                               begin
                                  RR_NSTATE = RR_RESP_MC;
                                  RR_CSTATE = RR_RESP_MC;
                               end
                             else
                              begin
                                RR_NSTATE = RR_IDLE;
                                RR_CSTATE = RR_IDLE;
                              end


                          default : RR_NSTATE = RR_IDLE;
                 endcase
          end

endmodule







