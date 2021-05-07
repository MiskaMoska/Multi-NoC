`include "param.vh"

module x_router #(
    parameter   ROUTER_ID_X =                       0,
    parameter   ROUTER_ID_Y =                       0
)(  
    input       wire                                clk,
    input       wire                                rstn,
    
    input       wire        [`DATA_WIDTH-1:0]       left_in_data,
    input       wire                                left_in_valid,
    output      wire                                left_in_ready,

    input       wire        [`DATA_WIDTH-1:0]       right_in_data,
    input       wire                                right_in_valid,
    output      wire                                right_in_ready,

    input       wire        [`DATA_WIDTH-1:0]       local_in_data,
    input       wire                                local_in_valid,
    output      wire                                local_in_ready,

    output      wire        [`DATA_WIDTH-1:0]       left_out_data,
    output      wire                                left_out_valid,
    input       wire                                left_out_ready,

    output      wire        [`DATA_WIDTH-1:0]       right_out_data,
    output      wire                                right_out_valid,
    input       wire                                right_out_ready,

    output      wire        [`DATA_WIDTH-1:0]       inter_out_data,
    output      wire                                inter_out_valid,
    input       wire                                inter_out_ready
);
wire [`DATA_WIDTH-1:0] left2inter_out_data;
wire [`DATA_WIDTH-1:0] left2right_out_data;
wire [`DATA_WIDTH-1:0] right2inter_out_data;
wire [`DATA_WIDTH-1:0] right2left_out_data;
wire [`DATA_WIDTH-1:0] local2inter_out_data;
wire [`DATA_WIDTH-1:0] local2left_out_data;
wire [`DATA_WIDTH-1:0] local2right_out_data;

wire left2inter_out_valid,  left2inter_out_ready;
wire left2right_out_valid,  left2right_out_ready;
wire right2inter_out_valid, right2inter_out_ready;
wire right2left_out_valid,  right2left_out_ready;
wire local2inter_out_valid, local2inter_out_ready;
wire local2left_out_valid,  local2left_out_ready;
wire local2right_out_valid, local2right_out_ready;
//left in
alloc_two #(
    .CHANNEL_ID(`LEFT), //input port
    .ROUTER_ID_X(ROUTER_ID_X),
    .ROUTER_ID_Y(ROUTER_ID_Y)                 
)left_alloc(
    .clk                    (clk),
    .rstn                   (rstn),

    .data_i                 (left_in_data),
    .valid_i                (left_in_valid),
    .ready_o                (left_in_ready),

    //right out for LEFT in
    //left out for RIGHT in
    //down out for UP in
    //up out for DOWN in
    .A_valid_o              (left2right_out_valid),
    .A_ready_i              (left2right_out_ready),
    .A_data_o               (left2right_out_data),

    //inter out for LEFT in
    //inter out for RIGHT in
    //local out for UP in
    //local out for DOWN in
    .B_valid_o              (left2inter_out_valid),
    .B_ready_i              (left2inter_out_ready),
    .B_data_o               (left2inter_out_data)
);


alloc_two #(
    .CHANNEL_ID(`RIGHT), //input port
    .ROUTER_ID_X(ROUTER_ID_X),
    .ROUTER_ID_Y(ROUTER_ID_Y)                 
)right_alloc(
    .clk                    (clk),
    .rstn                   (rstn),

    .data_i                 (right_in_data),
    .valid_i                (right_in_valid),
    .ready_o                (right_in_ready),

    //right out for LEFT in
    //left out for RIGHT in
    //down out for UP in
    //up out for DOWN in
    .A_valid_o              (right2left_out_valid),
    .A_ready_i              (right2left_out_ready),
    .A_data_o               (right2left_out_data),

    //inter out for LEFT in
    //inter out for RIGHT in
    //local out for UP in
    //local out for DOWN in
    .B_valid_o              (right2inter_out_valid),
    .B_ready_i              (right2inter_out_ready),
    .B_data_o               (right2inter_out_data)
);


alloc_three #(
    .CHANNEL_ID(`LOCAL), //input port
    .ROUTER_ID_X(ROUTER_ID_X),
    .ROUTER_ID_Y(ROUTER_ID_Y)                 
)local_alloc(
    .clk                    (clk),
    .rstn                   (rstn),

    .data_i                 (local_in_data),
    .valid_i                (local_in_valid),
    .ready_o                (local_in_ready),

    //left out for LOCAL in
    //up out for INTER in 
    .A_valid_o              (local2left_out_valid),
    .A_ready_i              (local2left_out_ready),
    .A_data_o               (local2left_out_data),

    //right out for LOCAL in
    //down out for INTER in
    .B_valid_o              (local2right_out_valid),
    .B_ready_i              (local2right_out_ready),
    .B_data_o               (local2right_out_data),

    //inter out for LOCAL in
    //local out for INTER in
    .C_valid_o              (local2inter_out_valid),
    .C_ready_i              (local2inter_out_ready),
    .C_data_o               (local2inter_out_data)
);

link_two left_link(
    .clk                    (clk),
    .rstn                   (rstn),

    .A_data_i               (local2left_out_data),
    .A_valid_i              (local2left_out_valid),
    .A_ready_o              (local2left_out_ready),

    .B_data_i               (right2left_out_data),
    .B_valid_i              (right2left_out_valid),
    .B_ready_o              (right2left_out_ready),

    .data_o                 (left_out_data),
    .valid_o                (left_out_valid),
    .ready_i                (left_out_ready)
);

link_two right_link(
    .clk                    (clk),
    .rstn                   (rstn),

    .A_data_i               (local2right_out_data),
    .A_valid_i              (local2right_out_valid),
    .A_ready_o              (local2right_out_ready),

    .B_data_i               (left2right_out_data),
    .B_valid_i              (left2right_out_valid),
    .B_ready_o              (left2right_out_ready),

    .data_o                 (right_out_data),
    .valid_o                (right_out_valid),
    .ready_i                (right_out_ready)
);

link_three inter_link(
    .clk                    (clk),
    .rstn                   (rstn),

    .A_data_i               (local2inter_out_data),
    .A_valid_i              (local2inter_out_valid),
    .A_ready_o              (local2inter_out_ready),

    .B_data_i               (left2inter_out_data),
    .B_valid_i              (left2inter_out_valid),
    .B_ready_o              (left2inter_out_ready),

    .C_data_i               (right2inter_out_data),
    .C_valid_i              (right2inter_out_valid),
    .C_ready_o              (right2inter_out_ready),

    .data_o                 (inter_out_data),
    .valid_o                (inter_out_valid),
    .ready_i                (inter_out_ready)
);

endmodule