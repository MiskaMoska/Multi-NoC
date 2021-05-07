`include "param.vh"

module router #(
    parameter   ROUTER_ID_X =                       0,
    parameter   ROUTER_ID_Y =                       0
)(
    input       wire                                CDCLK,
    input       wire                                CDRESETn,

    // left data in
    input       wire        [`DATA_WIDTH-1:0]       CDIDATAW,
    input       wire                                CDIVALIDW,
    output      wire                                CDIREADYW,

    // left data out
    output      wire        [`DATA_WIDTH-1:0]       CDODATAW,
    output      wire                                CDOVALIDW,
    input       wire                                CDOREADYW,

    // right data in
    input       wire        [`DATA_WIDTH-1:0]       CDIDATAE,
    input       wire                                CDIVALIDE,
    output      wire                                CDIREADYE,

    // right data out
    output      wire        [`DATA_WIDTH-1:0]       CDODATAE,
    output      wire                                CDOVALIDE,
    input       wire                                CDOREADYE,

    // local data in
    input       wire        [`DATA_WIDTH-1:0]       CDIDATAL,
    input       wire                                CDIVALIDL,
    output      wire                                CDIREADYL,

    // up data in
    input       wire        [`DATA_WIDTH-1:0]       CDIDATAN,
    input       wire                                CDIVALIDN,
    output      wire                                CDIREADYN,

    // up data out
    output      wire        [`DATA_WIDTH-1:0]       CDODATAN,
    output      wire                                CDOVALIDN,
    input       wire                                CDOREADYN,

    // down data in
    input       wire        [`DATA_WIDTH-1:0]       CDIDATAS,
    input       wire                                CDIVALIDS,
    output      wire                                CDIREADYS,

    // down data out
    output      wire        [`DATA_WIDTH-1:0]       CDODATAS,
    output      wire                                CDOVALIDS,
    input       wire                                CDOREADYS,

    // local data out
    output      wire        [`DATA_WIDTH-1:0]       CDODATAL,
    output      wire                                CDOVALIDL,
    input       wire                                CDOREADYL
);


// X router to Y router
wire [`DATA_WIDTH-1:0] x_to_y_data_w;
wire x_to_y_valid_w;
wire y_to_x_ready_w;

x_router #(
.ROUTER_ID_X            (ROUTER_ID_X),
.ROUTER_ID_Y            (ROUTER_ID_Y)
) X_ROUTER_UNIT (
.clk                    (CDCLK),
.rstn                   (CDRESETn),

// left data in
.left_in_data           (CDIDATAW),
.left_in_valid          (CDIVALIDW),
.left_in_ready          (CDIREADYW),

// left data out
.left_out_data          (CDODATAW),
.left_out_valid         (CDOVALIDW),
.left_out_ready         (CDOREADYW),

// right data in
.right_in_data          (CDIDATAE),
.right_in_valid         (CDIVALIDE),
.right_in_ready         (CDIREADYE),

// right data out
.right_out_data         (CDODATAE),
.right_out_valid        (CDOVALIDE),
.right_out_ready        (CDOREADYE),

// local data in
.local_in_data          (CDIDATAL),
.local_in_valid         (CDIVALIDL),
.local_in_ready         (CDIREADYL),

// inter data out
.inter_out_data         (x_to_y_data_w),
.inter_out_valid        (x_to_y_valid_w),
.inter_out_ready        (y_to_x_ready_w)
);

y_router#(
.ROUTER_ID_X            (ROUTER_ID_X),
.ROUTER_ID_Y            (ROUTER_ID_Y)
) Y_ROUTER_UNIT (
.clk                    (CDCLK),
.rstn                   (CDRESETn),

// up data in
.up_in_data             (CDIDATAN),
.up_in_valid            (CDIVALIDN),
.up_in_ready            (CDIREADYN),

// up data out
.up_out_data            (CDODATAN),
.up_out_valid           (CDOVALIDN),
.up_out_ready           (CDOREADYN),

// down data in
.down_in_data           (CDIDATAS),
.down_in_valid          (CDIVALIDS),
.down_in_ready          (CDIREADYS),

// down data out
.down_out_data          (CDODATAS),
.down_out_valid         (CDOVALIDS),
.down_out_ready         (CDOREADYS),

// inter data in
.inter_in_data          (x_to_y_data_w),
.inter_in_valid         (x_to_y_valid_w),
.inter_in_ready         (y_to_x_ready_w),

// local data out
.local_out_data         (CDODATAL),
.local_out_valid        (CDOVALIDL),
.local_out_ready        (CDOREADYL)
);
endmodule 