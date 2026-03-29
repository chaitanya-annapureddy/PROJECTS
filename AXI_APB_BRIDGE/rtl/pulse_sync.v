
   module pulse_sync #(parameter width=3) (
                                           input clk,
                                           input rstn,
                                           input data_in,
                                           output pulse_out);


         //reg pulse_1,pulse_2,pulse_3;
           reg [2:0] pulse_in;


         always @(posedge clk or negedge rstn)
           begin
                 if(!rstn)
                    pulse_in <= 3'b0;
                 else
                   begin
                     pulse_in[0]  <= data_in;
                    pulse_in[1]  <= pulse_in[0];
                    pulse_in[2]  <= pulse_in[1];

                    //or//
                //   pulse_in[2]  <= {data_in,pulse_in[1:0]};

                  end
          end


        assign  pulse_out  = ((~pulse_in[2]) && (pulse_in[1]));


  endmodule



