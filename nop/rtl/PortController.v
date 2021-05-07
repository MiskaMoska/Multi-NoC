`include "param.vh"

module PortController #(
    parameter   NODID =                                 0
)(  
    input       wire                                    CDCLK,
    input       wire                                    CPCLK,
    input       wire                                    CDRESETn,


    //CIBD bus from NoD 
    input       wire        [`DATA_WIDTH-1:0]           CDIDATA,
    input       wire                                    CDIVALID,
    output      wire                                    CDIREADY,

    //CIBD bus to NoD   
    output      wire        [`DATA_WIDTH-1:0]           CDODATA,
    output      wire                                    CDOVALID,
    input       wire                                    CDOREADY,


    //Bypass bus from another port controller   
    input       wire        [`DATA_WIDTH-1:0]           CDBPIDATA,
    input       wire                                    CDBPIVALID,
    output      wire                                    CDBPIREADY,

    //Bypass bus to another port controller 
    output      wire        [`DATA_WIDTH-1:0]           CDBPODATA,
    output      wire                                    CDBPOVALID,
    input       wire                                    CDBPOREADY,


    //LVDS bus from outside 
    input       wire        [`DATA_WIDTH/2-1:0]         CPIDATA,
    input       wire                                    CPIVALID,
    output      wire                                    CPIREADY,

    //LVDS bus to outside   
    output      wire        [`DATA_WIDTH/2-1:0]         CPODATA,
    output      wire                                    CPOVALID,
    input       wire                                    CPOREADY
);

wire sync_2_byp_ready,sync_2_byp_valid,byp_2_sync_ready,byp_2_sync_valid;
wire [`DATA_WIDTH-1:0] sync_2_byp_data,byp_2_sync_data;

sync_controller sync(
    .CDCLK                  (CDCLK),
    .CPCLK                  (CPCLK),
    .CDRESETn               (CDRESETn),
    .CPIDATA                (CPIDATA),
    .CPIVALID               (CPIVALID),
    .CPIREADY               (CPIREADY),
    .CPODATA                (CPODATA),
    .CPOVALID               (CPOVALID),
    .CPOREADY               (CPOREADY),
    .INDATA                 (byp_2_sync_data),
    .INVALID                (byp_2_sync_valid),
    .INREADY                (byp_2_sync_ready),
    .OUTDATA                (sync_2_byp_data),
    .OUTVALID               (sync_2_byp_valid),
    .OUTREADY               (sync_2_byp_ready)
);

bypass_controller #(
    .NODID                    (NODID)
)bypass(
    .CDCLK                    (CDCLK),
    .CDRESETn                 (CDRESETn),
    .INDATA                   (sync_2_byp_data),
    .INVALID                  (sync_2_byp_valid),
    .INREADY                  (sync_2_byp_ready),
    .CDBPODATA                (CDBPODATA),
    .CDBPOVALID               (CDBPOVALID),
    .CDBPOREADY               (CDBPOREADY),
    .CDODATA                  (CDODATA),
    .CDOVALID                 (CDOVALID),
    .CDOREADY                 (CDOREADY),
    .OUTDATA                  (byp_2_sync_data),
    .OUTVALID                 (byp_2_sync_valid),
    .OUTREADY                 (byp_2_sync_ready),
    .CDBPIDATA                (CDBPIDATA),
    .CDBPIVALID               (CDBPIVALID),
    .CDBPIREADY               (CDBPIREADY),
    .CDIDATA                  (CDIDATA),
    .CDIVALID                 (CDIVALID),
    .CDIREADY                 (CDIREADY)
);

endmodule