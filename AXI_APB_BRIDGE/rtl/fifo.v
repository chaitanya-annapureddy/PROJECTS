module dp_fifo(wclk,wrst,push,wdata,full,rclk,rrst,pop,rdata,empty);
parameter aw=5;
parameter dw=32;
input wclk,wrst,push,rclk,rrst,pop;
input [dw-1:0]wdata;
output [dw-1:0]rdata;
output reg full,empty;

//internal registers
reg [aw:0]wp_binary,rp_binary;
wire [aw:0]wp_binary_next,wp_gray_next;
wire [aw:0]rp_binary_next,rp_gray_next;
reg [aw:0]wp_gray,rp_gray;
wire [aw:0]rp_sync_2w_binary;
reg [aw:0]wp_sync_2r,rp_sync_2w;
reg [aw:0]wp_meta,rp_meta;

//dut instantiation
dp_sram #(aw,dw)ram(.wclk(wclk),.wen(push),.waddr(wp_binary[aw-1:0]),.wdata(wdata),.rclk(rclk),.ren(pop),.raddr(rp_binary[aw-1:0]),.rdata(rdata));

//wp_binary
always@(posedge wclk or negedge wrst)
begin
        if(wrst == 1'b0)
                wp_binary <= 'b0;
        else
        begin
                if((push == 1'b1) && (full == 1'b0))
                        wp_binary <= wp_binary_next;
                else
                        wp_binary <= wp_binary;
        end
end

//wp_gray
always@(posedge wclk or negedge wrst)
begin
        if(wrst == 1'b0)
                wp_gray <= 'b0;
        else
        begin
                if((push == 1'b1) && (full == 1'b0))
                        wp_gray <= wp_gray_next;
                else
                        wp_gray <= wp_gray;
        end
end
  //wp_sync_2rp
always@(posedge rclk or negedge rrst)
begin
        if(rrst == 1'b0)
        begin
                wp_meta <= 'b0;
                wp_sync_2r <= 'b0;
        end
        else
        begin
                wp_meta <= wp_gray;
                wp_sync_2r <= wp_meta;
        end
end

//rp_binary
always@(posedge rclk or negedge rrst)
begin
        if(rrst == 1'b0)
                rp_binary <= 'b0;
        else
        begin
                if((pop == 1'b1) && (empty == 1'b0))
                        rp_binary <= rp_binary_next;
                else
                        rp_binary <= rp_binary;
        end
end

//rp_gray
always@(posedge rclk or negedge rrst)
begin
        if(rrst == 1'b0)
                rp_gray <= 'b0;
        else
        begin
                if((pop == 1'b1) && (empty == 1'b0))
                        rp_gray <= rp_gray_next;
                else
                        rp_gray <= rp_gray;
        end
end

//rp_sync_2wp
always@(posedge wclk or negedge wrst)
  begin
        if(wrst == 1'b0)
        begin
                rp_meta <= 'b0;
                rp_sync_2w <= 'b0;
        end
        else
        begin
                rp_meta <= rp_gray;
                rp_sync_2w <= rp_meta;
        end
end

//full
always@(posedge wclk or negedge wrst)
begin
        if(wrst == 1'b0)
                full <= 1'b0;
        else
                full <= ((rp_sync_2w_binary[aw-1:0] == wp_binary[aw-1:0]) & (rp_sync_2w_binary[aw] != wp_binary[aw])) | ((rp_sync_2w_binary[aw-1:0] == wp_binary_next[aw-1:0]) & (rp_sync_2w_binary[aw] != wp_binary_next[aw]) & (push == 1'b1));
end

//empty
always@(posedge rclk or negedge rrst)
begin
        if(rrst == 1'b0)
                empty <= 1'b1;
        else
                empty <= (wp_sync_2r == rp_gray) | ((wp_sync_2r == rp_gray_next) & (pop == 1'b1));
end

//wp_binary_next
assign wp_binary_next = wp_binary + 'b1;

//wp_gray_next
assign wp_gray_next = wp_binary_next ^ {1'b0,wp_binary_next[aw:1]};


//rp_binary_next
assign rp_binary_next = rp_binary + 'b1;

//rp_gray_next
  assign rp_gray_next = rp_binary_next ^ {1'b0,rp_binary_next[aw:1]};


//rp_sync_2w_binary
assign rp_sync_2w_binary = rp_sync_2w ^ {1'b0,rp_sync_2w_binary[aw:1]};


endmodule
                            
                                        
