`include "param.vh"

module ExtenNoD #(
    parameter   NODID =                             0
)(
    input       wire                                CDCLK,
    input       wire                                CPCLK,
    input       wire                                CDRESETn,
    
    //router0
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X0_Y0,
    input       wire                                CDIVALID_X0_Y0,
    output      wire                                CDIREADY_X0_Y0,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X0_Y0,
    output      wire                                CDOVALID_X0_Y0,
    input       wire                                CDOREADY_X0_Y0,

    //router1
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X0_Y1,
    input       wire                                CDIVALID_X0_Y1,
    output      wire                                CDIREADY_X0_Y1,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X0_Y1,
    output      wire                                CDOVALID_X0_Y1,
    input       wire                                CDOREADY_X0_Y1,

    //router2
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X0_Y2,
    input       wire                                CDIVALID_X0_Y2,
    output      wire                                CDIREADY_X0_Y2,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X0_Y2,
    output      wire                                CDOVALID_X0_Y2,
    input       wire                                CDOREADY_X0_Y2,

    //router3
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X0_Y3,
    input       wire                                CDIVALID_X0_Y3,
    output      wire                                CDIREADY_X0_Y3,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X0_Y3,
    output      wire                                CDOVALID_X0_Y3,
    input       wire                                CDOREADY_X0_Y3,

    //router4
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X0_Y4,
    input       wire                                CDIVALID_X0_Y4,
    output      wire                                CDIREADY_X0_Y4,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X0_Y4,
    output      wire                                CDOVALID_X0_Y4,
    input       wire                                CDOREADY_X0_Y4,

    //router5
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X1_Y0,
    input       wire                                CDIVALID_X1_Y0,
    output      wire                                CDIREADY_X1_Y0,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X1_Y0,
    output      wire                                CDOVALID_X1_Y0,
    input       wire                                CDOREADY_X1_Y0,

    //router6
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X1_Y1,
    input       wire                                CDIVALID_X1_Y1,
    output      wire                                CDIREADY_X1_Y1,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X1_Y1,
    output      wire                                CDOVALID_X1_Y1,
    input       wire                                CDOREADY_X1_Y1,

    //router7
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X1_Y2,
    input       wire                                CDIVALID_X1_Y2,
    output      wire                                CDIREADY_X1_Y2,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X1_Y2,
    output      wire                                CDOVALID_X1_Y2,
    input       wire                                CDOREADY_X1_Y2,

    //router8
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X1_Y3,
    input       wire                                CDIVALID_X1_Y3,
    output      wire                                CDIREADY_X1_Y3,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X1_Y3,
    output      wire                                CDOVALID_X1_Y3,
    input       wire                                CDOREADY_X1_Y3,

    //router9
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X1_Y4,
    input       wire                                CDIVALID_X1_Y4,
    output      wire                                CDIREADY_X1_Y4,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X1_Y4,
    output      wire                                CDOVALID_X1_Y4,
    input       wire                                CDOREADY_X1_Y4,

    // //router10
    // input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X2_Y0,
    // input       wire                                CDIVALID_X2_Y0,
    // output      wire                                CDIREADY_X2_Y0,

    // output      wire        [`DATA_WIDTH-1:0]       CDODATA_X2_Y0,
    // output      wire                                CDOVALID_X2_Y0,
    // input       wire                                CDOREADY_X2_Y0,

    //router11
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X2_Y1,
    input       wire                                CDIVALID_X2_Y1,
    output      wire                                CDIREADY_X2_Y1,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X2_Y1,
    output      wire                                CDOVALID_X2_Y1,
    input       wire                                CDOREADY_X2_Y1,

    //router12
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X2_Y2,
    input       wire                                CDIVALID_X2_Y2,
    output      wire                                CDIREADY_X2_Y2,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X2_Y2,
    output      wire                                CDOVALID_X2_Y2,
    input       wire                                CDOREADY_X2_Y2,

    //router13
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X2_Y3,
    input       wire                                CDIVALID_X2_Y3,
    output      wire                                CDIREADY_X2_Y3,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X2_Y3,
    output      wire                                CDOVALID_X2_Y3,
    input       wire                                CDOREADY_X2_Y3,

    // //router14
    // input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X2_Y4,
    // input       wire                                CDIVALID_X2_Y4,
    // output      wire                                CDIREADY_X2_Y4,

    // output      wire        [`DATA_WIDTH-1:0]       CDODATA_X2_Y4,
    // output      wire                                CDOVALID_X2_Y4,
    // input       wire                                CDOREADY_X2_Y4,

    //router15
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X3_Y0,
    input       wire                                CDIVALID_X3_Y0,
    output      wire                                CDIREADY_X3_Y0,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X3_Y0,
    output      wire                                CDOVALID_X3_Y0,
    input       wire                                CDOREADY_X3_Y0,

    //router16
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X3_Y1,
    input       wire                                CDIVALID_X3_Y1,
    output      wire                                CDIREADY_X3_Y1,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X3_Y1,
    output      wire                                CDOVALID_X3_Y1,
    input       wire                                CDOREADY_X3_Y1,

    //router17
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X3_Y2,
    input       wire                                CDIVALID_X3_Y2,
    output      wire                                CDIREADY_X3_Y2,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X3_Y2,
    output      wire                                CDOVALID_X3_Y2,
    input       wire                                CDOREADY_X3_Y2,

    //router18
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X3_Y3,
    input       wire                                CDIVALID_X3_Y3,
    output      wire                                CDIREADY_X3_Y3,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X3_Y3,
    output      wire                                CDOVALID_X3_Y3,
    input       wire                                CDOREADY_X3_Y3,

    //router19
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X3_Y4,
    input       wire                                CDIVALID_X3_Y4,
    output      wire                                CDIREADY_X3_Y4,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X3_Y4,
    output      wire                                CDOVALID_X3_Y4,
    input       wire                                CDOREADY_X3_Y4,

    //router20
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X4_Y0,
    input       wire                                CDIVALID_X4_Y0,
    output      wire                                CDIREADY_X4_Y0,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X4_Y0,
    output      wire                                CDOVALID_X4_Y0,
    input       wire                                CDOREADY_X4_Y0,

    //router21
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X4_Y1,
    input       wire                                CDIVALID_X4_Y1,
    output      wire                                CDIREADY_X4_Y1,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X4_Y1,
    output      wire                                CDOVALID_X4_Y1,
    input       wire                                CDOREADY_X4_Y1,

    //router22
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X4_Y2,
    input       wire                                CDIVALID_X4_Y2,
    output      wire                                CDIREADY_X4_Y2,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X4_Y2,
    output      wire                                CDOVALID_X4_Y2,
    input       wire                                CDOREADY_X4_Y2,

    //router23
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X4_Y3,
    input       wire                                CDIVALID_X4_Y3,
    output      wire                                CDIREADY_X4_Y3,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X4_Y3,
    output      wire                                CDOVALID_X4_Y3,
    input       wire                                CDOREADY_X4_Y3,

    //router24
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X4_Y4,
    input       wire                                CDIVALID_X4_Y4,
    output      wire                                CDIREADY_X4_Y4,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X4_Y4,
    output      wire                                CDOVALID_X4_Y4,
    input       wire                                CDOREADY_X4_Y4,

    //West LVDS 
    input       wire        [`DATA_WIDTH/2-1:0]         CPIDATA_W,
    input       wire                                    CPIVALID_W,
    output      wire                                    CPIREADY_W,

    output      wire        [`DATA_WIDTH/2-1:0]         CPODATA_W,
    output      wire                                    CPOVALID_W,
    input       wire                                    CPOREADY_W,

    //East LVDS 
    input       wire        [`DATA_WIDTH/2-1:0]         CPIDATA_E,
    input       wire                                    CPIVALID_E,
    output      wire                                    CPIREADY_E,

    output      wire        [`DATA_WIDTH/2-1:0]         CPODATA_E,
    output      wire                                    CPOVALID_E,
    input       wire                                    CPOREADY_E
);

wire nod_2_wp_valid,nod_2_wp_ready,nod_2_ep_valid,nod_2_ep_ready;
wire wp_2_nod_valid,wp_2_nod_ready,ep_2_nod_valid,ep_2_nod_ready;
wire ep_2_wp_valid,ep_2_wp_ready,wp_2_ep_valid,wp_2_ep_ready;
wire [`DATA_WIDTH-1:0] nod_2_wp_data,nod_2_ep_data,wp_2_nod_data,ep_2_nod_data;
wire [`DATA_WIDTH-1:0] wp_2_ep_data,ep_2_wp_data;


NoD #(
    .NODID                        (NODID)
)NoD(
    .CDCLK                        (CDCLK),
    .CDRESETn                     (CDRESETn),
    .CDIDATA_X0_Y0                (CDIDATA_X0_Y0),
    .CDIVALID_X0_Y0               (CDIVALID_X0_Y0),
    .CDIREADY_X0_Y0               (CDIREADY_X0_Y0),
    .CDODATA_X0_Y0                (CDODATA_X0_Y0),
    .CDOVALID_X0_Y0               (CDOVALID_X0_Y0),
    .CDOREADY_X0_Y0               (CDOREADY_X0_Y0),
    .CDIDATA_X0_Y1                (CDIDATA_X0_Y1),
    .CDIVALID_X0_Y1               (CDIVALID_X0_Y1),
    .CDIREADY_X0_Y1               (CDIREADY_X0_Y1),
    .CDODATA_X0_Y1                (CDODATA_X0_Y1),
    .CDOVALID_X0_Y1               (CDOVALID_X0_Y1),
    .CDOREADY_X0_Y1               (CDOREADY_X0_Y1),
    .CDIDATA_X0_Y2                (CDIDATA_X0_Y2),
    .CDIVALID_X0_Y2               (CDIVALID_X0_Y2),
    .CDIREADY_X0_Y2               (CDIREADY_X0_Y2),
    .CDODATA_X0_Y2                (CDODATA_X0_Y2),
    .CDOVALID_X0_Y2               (CDOVALID_X0_Y2),
    .CDOREADY_X0_Y2               (CDOREADY_X0_Y2),
    .CDIDATA_X0_Y3                (CDIDATA_X0_Y3),
    .CDIVALID_X0_Y3               (CDIVALID_X0_Y3),
    .CDIREADY_X0_Y3               (CDIREADY_X0_Y3),
    .CDODATA_X0_Y3                (CDODATA_X0_Y3),
    .CDOVALID_X0_Y3               (CDOVALID_X0_Y3),
    .CDOREADY_X0_Y3               (CDOREADY_X0_Y3),
    .CDIDATA_X0_Y4                (CDIDATA_X0_Y4),
    .CDIVALID_X0_Y4               (CDIVALID_X0_Y4),
    .CDIREADY_X0_Y4               (CDIREADY_X0_Y4),
    .CDODATA_X0_Y4                (CDODATA_X0_Y4),
    .CDOVALID_X0_Y4               (CDOVALID_X0_Y4),
    .CDOREADY_X0_Y4               (CDOREADY_X0_Y4),
    .CDIDATA_X1_Y0                (CDIDATA_X1_Y0),
    .CDIVALID_X1_Y0               (CDIVALID_X1_Y0),
    .CDIREADY_X1_Y0               (CDIREADY_X1_Y0),
    .CDODATA_X1_Y0                (CDODATA_X1_Y0),
    .CDOVALID_X1_Y0               (CDOVALID_X1_Y0),
    .CDOREADY_X1_Y0               (CDOREADY_X1_Y0),
    .CDIDATA_X1_Y1                (CDIDATA_X1_Y1),
    .CDIVALID_X1_Y1               (CDIVALID_X1_Y1),
    .CDIREADY_X1_Y1               (CDIREADY_X1_Y1),
    .CDODATA_X1_Y1                (CDODATA_X1_Y1),
    .CDOVALID_X1_Y1               (CDOVALID_X1_Y1),
    .CDOREADY_X1_Y1               (CDOREADY_X1_Y1),
    .CDIDATA_X1_Y2                (CDIDATA_X1_Y2),
    .CDIVALID_X1_Y2               (CDIVALID_X1_Y2),
    .CDIREADY_X1_Y2               (CDIREADY_X1_Y2),
    .CDODATA_X1_Y2                (CDODATA_X1_Y2),
    .CDOVALID_X1_Y2               (CDOVALID_X1_Y2),
    .CDOREADY_X1_Y2               (CDOREADY_X1_Y2),
    .CDIDATA_X1_Y3                (CDIDATA_X1_Y3),
    .CDIVALID_X1_Y3               (CDIVALID_X1_Y3),
    .CDIREADY_X1_Y3               (CDIREADY_X1_Y3),
    .CDODATA_X1_Y3                (CDODATA_X1_Y3),
    .CDOVALID_X1_Y3               (CDOVALID_X1_Y3),
    .CDOREADY_X1_Y3               (CDOREADY_X1_Y3),
    .CDIDATA_X1_Y4                (CDIDATA_X1_Y4),
    .CDIVALID_X1_Y4               (CDIVALID_X1_Y4),
    .CDIREADY_X1_Y4               (CDIREADY_X1_Y4),
    .CDODATA_X1_Y4                (CDODATA_X1_Y4),
    .CDOVALID_X1_Y4               (CDOVALID_X1_Y4),
    .CDOREADY_X1_Y4               (CDOREADY_X1_Y4),
    .CDIDATA_X2_Y0                (wp_2_nod_data),
    .CDIVALID_X2_Y0               (wp_2_nod_valid),
    .CDIREADY_X2_Y0               (wp_2_nod_ready),
    .CDODATA_X2_Y0                (nod_2_wp_data),
    .CDOVALID_X2_Y0               (nod_2_wp_valid),
    .CDOREADY_X2_Y0               (nod_2_wp_ready),
    .CDIDATA_X2_Y1                (CDIDATA_X2_Y1),
    .CDIVALID_X2_Y1               (CDIVALID_X2_Y1),
    .CDIREADY_X2_Y1               (CDIREADY_X2_Y1),
    .CDODATA_X2_Y1                (CDODATA_X2_Y1),
    .CDOVALID_X2_Y1               (CDOVALID_X2_Y1),
    .CDOREADY_X2_Y1               (CDOREADY_X2_Y1),
    .CDIDATA_X2_Y2                (CDIDATA_X2_Y2),
    .CDIVALID_X2_Y2               (CDIVALID_X2_Y2),
    .CDIREADY_X2_Y2               (CDIREADY_X2_Y2),
    .CDODATA_X2_Y2                (CDODATA_X2_Y2),
    .CDOVALID_X2_Y2               (CDOVALID_X2_Y2),
    .CDOREADY_X2_Y2               (CDOREADY_X2_Y2),
    .CDIDATA_X2_Y3                (CDIDATA_X2_Y3),
    .CDIVALID_X2_Y3               (CDIVALID_X2_Y3),
    .CDIREADY_X2_Y3               (CDIREADY_X2_Y3),
    .CDODATA_X2_Y3                (CDODATA_X2_Y3),
    .CDOVALID_X2_Y3               (CDOVALID_X2_Y3),
    .CDOREADY_X2_Y3               (CDOREADY_X2_Y3),
    .CDIDATA_X2_Y4                (ep_2_nod_data),
    .CDIVALID_X2_Y4               (ep_2_nod_valid),
    .CDIREADY_X2_Y4               (ep_2_nod_ready),
    .CDODATA_X2_Y4                (nod_2_ep_data),
    .CDOVALID_X2_Y4               (nod_2_ep_valid),
    .CDOREADY_X2_Y4               (nod_2_ep_ready),
    .CDIDATA_X3_Y0                (CDIDATA_X3_Y0),
    .CDIVALID_X3_Y0               (CDIVALID_X3_Y0),
    .CDIREADY_X3_Y0               (CDIREADY_X3_Y0),
    .CDODATA_X3_Y0                (CDODATA_X3_Y0),
    .CDOVALID_X3_Y0               (CDOVALID_X3_Y0),
    .CDOREADY_X3_Y0               (CDOREADY_X3_Y0),
    .CDIDATA_X3_Y1                (CDIDATA_X3_Y1),
    .CDIVALID_X3_Y1               (CDIVALID_X3_Y1),
    .CDIREADY_X3_Y1               (CDIREADY_X3_Y1),
    .CDODATA_X3_Y1                (CDODATA_X3_Y1),
    .CDOVALID_X3_Y1               (CDOVALID_X3_Y1),
    .CDOREADY_X3_Y1               (CDOREADY_X3_Y1),
    .CDIDATA_X3_Y2                (CDIDATA_X3_Y2),
    .CDIVALID_X3_Y2               (CDIVALID_X3_Y2),
    .CDIREADY_X3_Y2               (CDIREADY_X3_Y2),
    .CDODATA_X3_Y2                (CDODATA_X3_Y2),
    .CDOVALID_X3_Y2               (CDOVALID_X3_Y2),
    .CDOREADY_X3_Y2               (CDOREADY_X3_Y2),
    .CDIDATA_X3_Y3                (CDIDATA_X3_Y3),
    .CDIVALID_X3_Y3               (CDIVALID_X3_Y3),
    .CDIREADY_X3_Y3               (CDIREADY_X3_Y3),
    .CDODATA_X3_Y3                (CDODATA_X3_Y3),
    .CDOVALID_X3_Y3               (CDOVALID_X3_Y3),
    .CDOREADY_X3_Y3               (CDOREADY_X3_Y3),
    .CDIDATA_X3_Y4                (CDIDATA_X3_Y4),
    .CDIVALID_X3_Y4               (CDIVALID_X3_Y4),
    .CDIREADY_X3_Y4               (CDIREADY_X3_Y4),
    .CDODATA_X3_Y4                (CDODATA_X3_Y4),
    .CDOVALID_X3_Y4               (CDOVALID_X3_Y4),
    .CDOREADY_X3_Y4               (CDOREADY_X3_Y4),
    .CDIDATA_X4_Y0                (CDIDATA_X4_Y0),
    .CDIVALID_X4_Y0               (CDIVALID_X4_Y0),
    .CDIREADY_X4_Y0               (CDIREADY_X4_Y0),
    .CDODATA_X4_Y0                (CDODATA_X4_Y0),
    .CDOVALID_X4_Y0               (CDOVALID_X4_Y0),
    .CDOREADY_X4_Y0               (CDOREADY_X4_Y0),
    .CDIDATA_X4_Y1                (CDIDATA_X4_Y1),
    .CDIVALID_X4_Y1               (CDIVALID_X4_Y1),
    .CDIREADY_X4_Y1               (CDIREADY_X4_Y1),
    .CDODATA_X4_Y1                (CDODATA_X4_Y1),
    .CDOVALID_X4_Y1               (CDOVALID_X4_Y1),
    .CDOREADY_X4_Y1               (CDOREADY_X4_Y1),
    .CDIDATA_X4_Y2                (CDIDATA_X4_Y2),
    .CDIVALID_X4_Y2               (CDIVALID_X4_Y2),
    .CDIREADY_X4_Y2               (CDIREADY_X4_Y2),
    .CDODATA_X4_Y2                (CDODATA_X4_Y2),
    .CDOVALID_X4_Y2               (CDOVALID_X4_Y2),
    .CDOREADY_X4_Y2               (CDOREADY_X4_Y2),
    .CDIDATA_X4_Y3                (CDIDATA_X4_Y3),
    .CDIVALID_X4_Y3               (CDIVALID_X4_Y3),
    .CDIREADY_X4_Y3               (CDIREADY_X4_Y3),
    .CDODATA_X4_Y3                (CDODATA_X4_Y3),
    .CDOVALID_X4_Y3               (CDOVALID_X4_Y3),
    .CDOREADY_X4_Y3               (CDOREADY_X4_Y3),
    .CDIDATA_X4_Y4                (CDIDATA_X4_Y4),
    .CDIVALID_X4_Y4               (CDIVALID_X4_Y4),
    .CDIREADY_X4_Y4               (CDIREADY_X4_Y4),
    .CDODATA_X4_Y4                (CDODATA_X4_Y4),
    .CDOVALID_X4_Y4               (CDOVALID_X4_Y4),
    .CDOREADY_X4_Y4               (CDOREADY_X4_Y4)
);

PortController #(
    .NODID                    (NODID)
)wp(
    .CDCLK                    (CDCLK),
    .CPCLK                    (CPCLK),
    .CDRESETn                 (CDRESETn),
    .CDIDATA                  (nod_2_wp_data),
    .CDIVALID                 (nod_2_wp_valid),
    .CDIREADY                 (nod_2_wp_ready),
    .CDODATA                  (wp_2_nod_data),
    .CDOVALID                 (wp_2_nod_valid),
    .CDOREADY                 (wp_2_nod_ready),
    .CDBPIDATA                (ep_2_wp_data),
    .CDBPIVALID               (ep_2_wp_valid),
    .CDBPIREADY               (ep_2_wp_ready),
    .CDBPODATA                (wp_2_ep_data),
    .CDBPOVALID               (wp_2_ep_valid),
    .CDBPOREADY               (wp_2_ep_ready),
    .CPIDATA                  (CPIDATA_W),
    .CPIVALID                 (CPIVALID_W),
    .CPIREADY                 (CPIREADY_W),
    .CPODATA                  (CPODATA_W),
    .CPOVALID                 (CPOVALID_W),
    .CPOREADY                 (CPOREADY_W)
);

PortController #(
    .NODID                    (NODID)
)ep(
    .CDCLK                    (CDCLK),
    .CPCLK                    (CPCLK),
    .CDRESETn                 (CDRESETn),
    .CDIDATA                  (nod_2_ep_data),
    .CDIVALID                 (nod_2_ep_valid),
    .CDIREADY                 (nod_2_ep_ready),
    .CDODATA                  (ep_2_nod_data),
    .CDOVALID                 (ep_2_nod_valid),
    .CDOREADY                 (ep_2_nod_ready),
    .CDBPIDATA                (wp_2_ep_data),
    .CDBPIVALID               (wp_2_ep_valid),
    .CDBPIREADY               (wp_2_ep_ready),
    .CDBPODATA                (ep_2_wp_data),
    .CDBPOVALID               (ep_2_wp_valid),
    .CDBPOREADY               (ep_2_wp_ready),
    .CPIDATA                  (CPIDATA_E),
    .CPIVALID                 (CPIVALID_E),
    .CPIREADY                 (CPIREADY_E),
    .CPODATA                  (CPODATA_E),
    .CPOVALID                 (CPOVALID_E),
    .CPOREADY                 (CPOREADY_E)
);
endmodule