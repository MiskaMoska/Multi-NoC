//allocation for injection port and inter_in port
`include "param.vh"

module alloc_three #(
    parameter   CHANNEL_ID =                        `LOCAL, //input port
    parameter   ROUTER_ID_X =                       0,
    parameter   ROUTER_ID_Y =                       0                 
)(
    input       wire                                clk,
    input       wire                                rstn,

    input       wire        [`DATA_WIDTH-1:0]       data_i,
    input       wire                                valid_i,
    output      wire                                ready_o,

    //left out for LOCAL in
    //up out for INTER in 
    output      wire                                A_valid_o,
    input       wire                                A_ready_i,
    output      wire        [`DATA_WIDTH-1:0]       A_data_o,

    //right out for LOCAL in
    //down out for INTER in
    output      wire                                B_valid_o,
    input       wire                                B_ready_i,
    output      wire        [`DATA_WIDTH-1:0]       B_data_o,

    //inter out for LOCAL in
    //local out for INTER in
    output      wire                                C_valid_o,
    input       wire                                C_ready_i,
    output      wire        [`DATA_WIDTH-1:0]       C_data_o
);

wire fifo_full,fifo_wr;
wire fifo_valid,fifo_ready;
wire [`DATA_WIDTH-1:0] fifo_dout;
wire fire_A,fire_B,fire_C,any_fire;

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

wire [`RTID_H - `RTID_L : 0] data_rt_id;
wire [(`RTID_H-`RTID_L+1)/2-1:0] rt_id_x,rt_id_y;
assign rt_id_x = data_rt_id[`RTID_H-`RTID_L:(`RTID_H-`RTID_L+1)/2];
assign rt_id_y = data_rt_id[(`RTID_H-`RTID_L+1)/2-1:0];

//channel allocation
assign data_rt_id = fifo_dout[`RTID_H:`RTID_L];
wire dst_A,dst_B,dst_C;

generate if(CHANNEL_ID == `LOCAL) begin:LOCAL

    assign dst_A = (rt_id_y < ROUTER_ID_Y);
    assign dst_B = (rt_id_y > ROUTER_ID_Y);
    assign dst_C = (rt_id_y == ROUTER_ID_Y);

end else begin:INTER

    assign dst_A = (rt_id_x < ROUTER_ID_X);
    assign dst_B = (rt_id_x > ROUTER_ID_X);
    assign dst_C = (rt_id_x == ROUTER_ID_X);

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
reg dst_A_reg,dst_B_reg,dst_C_reg;
always@(posedge clk or negedge rstn)
begin
    if(~rstn)
    begin
        dst_A_reg <= 0;
        dst_B_reg <= 0;
        dst_C_reg <= 0;
    end
    else if((~state) & any_fire)
    begin
        dst_A_reg <= dst_A;
        dst_B_reg <= dst_B;
        dst_C_reg <= dst_C;
    end
end

//generating valid_out for each channel
assign A_valid_o = fifo_valid & (state ? dst_A_reg : dst_A);
assign B_valid_o = fifo_valid & (state ? dst_B_reg : dst_B);
assign C_valid_o = fifo_valid & (state ? dst_C_reg : dst_C);

//fire == 1 indicates a flit finished transportation
assign fifo_ready = A_ready_i & (state ? dst_A_reg : dst_A) |
                    B_ready_i & (state ? dst_B_reg : dst_B) |
                    C_ready_i & (state ? dst_C_reg : dst_C);

assign fire_A = A_valid_o & A_ready_i;
assign fire_B = B_valid_o & B_ready_i;
assign fire_C = C_valid_o & C_ready_i;
assign any_fire = fire_A | fire_B | fire_C;

assign A_data_o = fifo_dout;
assign B_data_o = fifo_dout;
assign C_data_o = fifo_dout;
endmodule