`include "param.vh"

module bypass_controller #(
    parameter   NODID =                             0               
)(
    input       wire                                CDCLK,
    input       wire                                CDRESETn, //reset synchronized by CDCLK    

    //Dispatch channel in 
    input       wire        [`DATA_WIDTH-1:0]       INDATA,
    input       wire                                INVALID,
    output      wire                                INREADY,                

    //Dispach channel out to bypass
    output      wire        [`DATA_WIDTH-1:0]       CDBPODATA,
    output      wire                                CDBPOVALID,
    input       wire                                CDBPOREADY,

    //Dispatch channel out to NoD
    output      wire        [`DATA_WIDTH-1:0]       CDODATA,
    output      wire                                CDOVALID,
    input       wire                                CDOREADY,

    //Arbitration channel out
    output      wire        [`DATA_WIDTH-1:0]       OUTDATA,
    output      wire                                OUTVALID,
    input       wire                                OUTREADY,

    //Arbitration channel in from bypass
    input       wire        [`DATA_WIDTH-1:0]       CDBPIDATA,
    input       wire                                CDBPIVALID,
    output      wire                                CDBPIREADY,

    //Arbitration channel in from NoD
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA,
    input       wire                                CDIVALID,
    output      wire                                CDIREADY  
);

//-------------------------------------------------------------------------------
//
//                              Dispatch Channel
//
//-------------------------------------------------------------------------------
reg state_dspc;
wire is_bypass,dspc_cho; //dspc_cho:1-bypass,0-NoD
reg is_bypass_reg;
wire dspc_fire;

assign dspc_fire = INVALID & INREADY;
assign dspc_cho = state_dspc ? is_bypass_reg : is_bypass;
assign is_bypass = (INDATA[`DCID_H:`DCID_L] != NODID);

assign CDBPODATA = INDATA;
assign CDODATA[`DATA_WIDTH-1:`RTID_H+1] = INDATA[`DATA_WIDTH-1:`RTID_H+1];
assign CDODATA[`RTID_L-1:0] = INDATA[`RTID_L-1:0];


generate if(`IS_BYPASS == 1) begin
    assign INREADY = dspc_cho ? CDBPOREADY : CDOREADY;
    assign CDBPOVALID = dspc_cho & INVALID;
    assign CDOVALID = (~dspc_cho) & INVALID;
    assign CDODATA[`RTID_H:`RTID_L] = (INDATA[`DATA_WIDTH-1:`DATA_WIDTH-2] == `HEAD) ? 
                                        INDATA[`DRID_H:`DRID_L] : INDATA[`RTID_H:`RTID_L];
end else begin
    assign INREADY = CDOREADY;
    assign CDBPOVALID = 1'b0;
    assign CDOVALID = INVALID;
    assign CDODATA[`RTID_H:`RTID_L] = (INDATA[`DATA_WIDTH-1:`DATA_WIDTH-2] == `HEAD) &
                                        (INDATA[`DCID_H:`DCID_L] == NODID) ? 
                                        INDATA[`DRID_H:`DRID_L] : INDATA[`RTID_H:`RTID_L];
end endgenerate

always@(posedge CDCLK or negedge CDRESETn)
begin
    if(~CDRESETn)
    begin
        state_dspc <= 1'b0;
        is_bypass_reg <= 1'b0;
    end
    else
    begin
        if((~state_dspc) & dspc_fire & 
            (INDATA[`DATA_WIDTH-1:`DATA_WIDTH-2] == `HEAD))
        begin
            state_dspc <= 1'b1;
            is_bypass_reg <= is_bypass;
        end
        else if(state_dspc & dspc_fire &
            (INDATA[`DATA_WIDTH-1:`DATA_WIDTH-2] == `TAIL))
        begin
            state_dspc <= 1'b0;
        end
    end
end



//-------------------------------------------------------------------------------
//
//                              Arbitration Channel
//
//-------------------------------------------------------------------------------
wire [`DATA_WIDTH-1:0] fifo_dout;
wire fifo_wr,fifo_full,fifo_ready,fifo_valid;
fifo_NoD_wrapper fifo(
    .clk                 (CDCLK),
    .rstn                (CDRESETn),
    .din                 (CDIDATA),
    .wr_en               (fifo_wr),
    .full                (fifo_full),
    .dout                (fifo_dout),
    .ready               (fifo_ready),
    .valid               (fifo_valid)
);

wire [1:0] request,grant;
mtx_arbiter #(
    .LEN                   (2)
)arbiter(
    .clk                   (CDCLK),
    .rstn                  (CDRESETn),
    .request               (request),
    .grant                 (grant),
    .update                (1'b0)
);

assign request = {fifo_valid,CDBPIVALID};
reg state_arb;
reg [1:0] grant_reg;

wire arb_fire;
assign arb_fire = OUTVALID & OUTREADY;

always@(posedge CDCLK or negedge CDRESETn)
begin
    if(~CDRESETn)
    begin
        state_arb <= 1'b0;
        grant_reg <= 2'b0;
    end
    else
    begin
        if((~state_arb) & OUTVALID &
            (OUTDATA[`DATA_WIDTH-1:`DATA_WIDTH-2] == `HEAD))
        begin
            state_arb <= 1'b1;
            grant_reg <= grant;
        end
        else if(state_arb & arb_fire &
            (OUTDATA[`DATA_WIDTH-1:`DATA_WIDTH-2] == `TAIL))
        begin
            state_arb <= 1'b0;
        end
    end
end

wire [1:0] arb_cho; 
assign arb_cho = state_arb ? grant_reg : grant;

assign CDBPIREADY = arb_cho[0] & OUTREADY;
assign fifo_ready = arb_cho[1] & OUTREADY;
assign CDIREADY = ~fifo_full;
assign fifo_wr = CDIVALID & CDIREADY;
assign OUTDATA = arb_cho[0] ? CDBPIDATA : fifo_dout;
assign OUTVALID = arb_cho[0] & CDBPIVALID | arb_cho[1] & fifo_valid;

endmodule
