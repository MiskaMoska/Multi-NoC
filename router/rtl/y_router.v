`include "param.vh"

module y_router #(
    parameter   ROUTER_ID_X =                       0,
    parameter   ROUTER_ID_Y =                       0
)(
    input       wire                                clk,
    input       wire                                rstn,
    
    input       wire        [`DATA_WIDTH-1:0]       up_in_data,
    input       wire                                up_in_valid,
    output      wire                                up_in_ready,

    input       wire        [`DATA_WIDTH-1:0]       down_in_data,
    input       wire                                down_in_valid,
    output      wire                                down_in_ready,

    input       wire        [`DATA_WIDTH-1:0]       inter_in_data,
    input       wire                                inter_in_valid,
    output      wire                                inter_in_ready,

    output      wire        [`DATA_WIDTH-1:0]       up_out_data,
    output      wire                                up_out_valid,
    input       wire                                up_out_ready,

    output      wire        [`DATA_WIDTH-1:0]       down_out_data,
    output      wire                                down_out_valid,
    input       wire                                down_out_ready,

    output      wire     [`DATA_WIDTH-1:0]          local_out_data,
    output      wire                                local_out_valid,
    input       wire                                local_out_ready
);
wire [`DATA_WIDTH-1:0] up2local_out_data;
wire [`DATA_WIDTH-1:0] up2down_out_data;
wire [`DATA_WIDTH-1:0] down2local_out_data;
wire [`DATA_WIDTH-1:0] down2up_out_data;
wire [`DATA_WIDTH-1:0] inter2local_out_data;
wire [`DATA_WIDTH-1:0] inter2up_out_data;
wire [`DATA_WIDTH-1:0] inter2down_out_data;

wire up2local_out_valid,  up2local_out_ready;
wire up2down_out_valid,  up2down_out_ready;
wire down2local_out_valid, down2local_out_ready;
wire down2up_out_valid,  down2up_out_ready;
wire inter2local_out_valid, inter2local_out_ready;
wire inter2up_out_valid,  inter2up_out_ready;
wire inter2down_out_valid, inter2down_out_ready;
//up in
alloc_two #(
    .CHANNEL_ID(`UP), //input port
    .ROUTER_ID_X(ROUTER_ID_X),
    .ROUTER_ID_Y(ROUTER_ID_Y)                 
)up_alloc(
    .clk                    (clk),
    .rstn                   (rstn),

    .data_i                 (up_in_data),
    .valid_i                (up_in_valid),
    .ready_o                (up_in_ready),

    //right out for LEFT in
    //left out for RIGHT in
    //down out for UP in
    //up out for DOWN in
    .A_valid_o              (up2down_out_valid),
    .A_ready_i              (up2down_out_ready),
    .A_data_o               (up2down_out_data),

    //inter out for LEFT in
    //inter out for RIGHT in
    //local out for UP in
    //local out for DOWN in
    .B_valid_o              (up2local_out_valid),
    .B_ready_i              (up2local_out_ready),
    .B_data_o               (up2local_out_data)
);


alloc_two #(
    .CHANNEL_ID(`DOWN), //input port
    .ROUTER_ID_X(ROUTER_ID_X),
    .ROUTER_ID_Y(ROUTER_ID_Y)                 
)down_alloc(
    .clk                    (clk),
    .rstn                   (rstn),

    .data_i                 (down_in_data),
    .valid_i                (down_in_valid),
    .ready_o                (down_in_ready),

    //right out for LEFT in
    //left out for RIGHT in
    //down out for UP in
    //up out for DOWN in
    .A_valid_o              (down2up_out_valid),
    .A_ready_i              (down2up_out_ready),
    .A_data_o               (down2up_out_data),

    //inter out for LEFT in
    //inter out for RIGHT in
    //local out for UP in
    //local out for DOWN in
    .B_valid_o              (down2local_out_valid),
    .B_ready_i              (down2local_out_ready),
    .B_data_o               (down2local_out_data)
);


alloc_three #(
    .CHANNEL_ID(`INTER), //input port
    .ROUTER_ID_X(ROUTER_ID_X),
    .ROUTER_ID_Y(ROUTER_ID_Y)                 
)inter_alloc(
    .clk                    (clk),
    .rstn                   (rstn),

    .data_i                 (inter_in_data),
    .valid_i                (inter_in_valid),
    .ready_o                (inter_in_ready),

    //left out for LOCAL in
    //up out for INTER in 
    .A_valid_o              (inter2up_out_valid),
    .A_ready_i              (inter2up_out_ready),
    .A_data_o               (inter2up_out_data),

    //right out for LOCAL in
    //down out for INTER in
    .B_valid_o              (inter2down_out_valid),
    .B_ready_i              (inter2down_out_ready),
    .B_data_o               (inter2down_out_data),

    //inter out for LOCAL in
    //local out for INTER in
    .C_valid_o              (inter2local_out_valid),
    .C_ready_i              (inter2local_out_ready),
    .C_data_o               (inter2local_out_data)
);

link_two up_link(
    .clk                    (clk),
    .rstn                   (rstn),

    .A_data_i               (inter2up_out_data),
    .A_valid_i              (inter2up_out_valid),
    .A_ready_o              (inter2up_out_ready),

    .B_data_i               (down2up_out_data),
    .B_valid_i              (down2up_out_valid),
    .B_ready_o              (down2up_out_ready),

    .data_o                 (up_out_data),
    .valid_o                (up_out_valid),
    .ready_i                (up_out_ready)
);

link_two down_link(
    .clk                    (clk),
    .rstn                   (rstn),

    .A_data_i               (inter2down_out_data),
    .A_valid_i              (inter2down_out_valid),
    .A_ready_o              (inter2down_out_ready),

    .B_data_i               (up2down_out_data),
    .B_valid_i              (up2down_out_valid),
    .B_ready_o              (up2down_out_ready),

    .data_o                 (down_out_data),
    .valid_o                (down_out_valid),
    .ready_i                (down_out_ready)
);

link_three local_link(
    .clk                    (clk),
    .rstn                   (rstn),

    .A_data_i               (inter2local_out_data),
    .A_valid_i              (inter2local_out_valid),
    .A_ready_o              (inter2local_out_ready),

    .B_data_i               (up2local_out_data),
    .B_valid_i              (up2local_out_valid),
    .B_ready_o              (up2local_out_ready),

    .C_data_i               (down2local_out_data),
    .C_valid_i              (down2local_out_valid),
    .C_ready_o              (down2local_out_ready),

    .data_o                 (local_out_data),
    .valid_o                (local_out_valid),
    .ready_i                (local_out_ready)
);

endmodule