//allocation for left_in/right_in/up_in/down_in port
`include "param.vh"

module alloc_two #(
    parameter   CHANNEL_ID =                        `LEFT, //input port
    parameter   ROUTER_ID_X =                       0,
    parameter   ROUTER_ID_Y =                       0                 
)(
    input       wire                                clk,
    input       wire                                rstn,

    input       wire        [`DATA_WIDTH-1:0]       data_i,
    input       wire                                valid_i,
    output      wire                                ready_o,

    //right out for LEFT in
    //left out for RIGHT in
    //down out for UP in
    //up out for DOWN in
    output      wire                                A_valid_o,
    input       wire                                A_ready_i,
    output      wire        [`DATA_WIDTH-1:0]       A_data_o,

    //inter out for LEFT in
    //inter out for RIGHT in
    //local out for UP in
    //local out for DOWN in
    output      wire                                B_valid_o,
    input       wire                                B_ready_i,
    output      wire        [`DATA_WIDTH-1:0]       B_data_o
);

wire fifo_valid,fifo_full,fifo_wr,fifo_ready;
wire [`DATA_WIDTH-1:0] fifo_dout;
wire fire_A,fire_B,any_fire;

assign fifo_wr = valid_i & (~fifo_full);
assign ready_o = ~fifo_full;

fifo_NoD_wrapper fifo(
    .clk                 (clk),
    .rstn                (rstn),
    .din                 (data_i),
    .wr_en               (fifo_wr),
    .full                (fifo_full),
    .dout                (fifo_dout),
    .ready               (fifo_ready),
    .valid               (fifo_valid)
);

//channel allocation
wire [`RTID_H - `RTID_L : 0] data_rt_id;
assign data_rt_id = fifo_dout[`RTID_H:`RTID_L];
wire dst_A,dst_B;

wire [(`RTID_H-`RTID_L+1)/2-1:0] rt_id_x,rt_id_y;
assign rt_id_x = data_rt_id[`RTID_H-`RTID_L:(`RTID_H-`RTID_L+1)/2];
assign rt_id_y = data_rt_id[(`RTID_H-`RTID_L+1)/2-1:0];

generate if(CHANNEL_ID == `LEFT) begin:LEFT

    assign dst_A = rt_id_y > ROUTER_ID_Y;
    assign dst_B = rt_id_y == ROUTER_ID_Y;

end else if(CHANNEL_ID == `RIGHT) begin:RIGHT

    assign dst_A = rt_id_y < ROUTER_ID_Y; 
    assign dst_B = rt_id_y == ROUTER_ID_Y; 

end else if(CHANNEL_ID == `UP) begin:UP

    assign dst_A = rt_id_x > ROUTER_ID_X; 
    assign dst_B = rt_id_x == ROUTER_ID_X; 

end else begin:DOWN

    assign dst_A = rt_id_x < ROUTER_ID_X; 
    assign dst_B = rt_id_x == ROUTER_ID_X; 

end endgenerate

//state == 1 indicates there is a packet in flight
reg state;
wire nxt_state;
always@(posedge clk or negedge rstn)
begin
    if(~rstn) state <= 0;
    else state <= nxt_state;
end

wire [1:0] fifo_dout_typebits = fifo_dout[`DATA_WIDTH-1:`DATA_WIDTH-2];
assign  nxt_state = (state == 0) & any_fire ? 1 : (
                    (state == 1) & any_fire & (fifo_dout_typebits == `TAIL) ? 0 : state);

//info registering
reg dst_A_reg,dst_B_reg;
always@(posedge clk or negedge rstn)
begin
    if(~rstn)
    begin
        dst_A_reg <= 0;
        dst_B_reg <= 0;
    end
    else if((~state) & any_fire)
    begin
        dst_A_reg <= dst_A;
        dst_B_reg <= dst_B;
    end
end

//generating valid_out for each channel
assign A_valid_o = fifo_valid & (state ? dst_A_reg : dst_A);
assign B_valid_o = fifo_valid & (state ? dst_B_reg : dst_B);

//fire == 1 indicates a flit finished transportation
assign fifo_ready = A_ready_i & (state ? dst_A_reg : dst_A) |
                    B_ready_i & (state ? dst_B_reg : dst_B);

assign fire_A = A_valid_o & A_ready_i;
assign fire_B = B_valid_o & B_ready_i;
assign any_fire = fire_A | fire_B;

assign A_data_o = fifo_dout;
assign B_data_o = fifo_dout;
endmodule