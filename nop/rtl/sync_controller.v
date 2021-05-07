`include "param.vh"

module sync_controller(
    input       wire                                    CDCLK,
    input       wire                                    CPCLK,
    input       wire                                    CDRESETn,

    //in channel from LVDS  
    input       wire        [`DATA_WIDTH/2-1:0]         CPIDATA,
    input       wire                                    CPIVALID,
    output      wire                                    CPIREADY,

    //out channel to LVDS   
    output      wire        [`DATA_WIDTH/2-1:0]         CPODATA,
    output      wire                                    CPOVALID,
    input       wire                                    CPOREADY,

    //in channel from bypass_controller 
    input       wire        [`DATA_WIDTH-1:0]           INDATA,
    input       wire                                    INVALID,
    output      wire                                    INREADY,

    //out channel to bypass_controller  
    output      wire        [`DATA_WIDTH-1:0]           OUTDATA,
    output      wire                                    OUTVALID,
    input       wire                                    OUTREADY
);


//-----------------------------------------------------------------------------------------

//                              Input Channel from LVDS

//-----------------------------------------------------------------------------------------
wire fifo_i_full,fifo_i_ready,fifo_i_valid;
wire [`DATA_WIDTH/2-1:0] fifo_i_dout;
fifo_PTC_wrapper fifo_i(
    .clk_wr               (CPCLK),
    .clk_rd               (CDCLK),
    .rstn                 (CDRESETn),
    .din                  (CPIDATA),
    .wr_en                (CPIVALID & CPIREADY),
    .full                 (fifo_i_full),
    .dout                 (fifo_i_dout),
    .ready                (fifo_i_ready),
    .valid                (fifo_i_valid)
);

assign CPIREADY = (~fifo_i_full);

reg in_flag;
always@(posedge CDCLK or negedge CDRESETn)
begin
    if(~CDRESETn) in_flag <= 1'b0;
    else
    begin
        if((~in_flag) & fifo_i_valid)
            in_flag <= 1'b1;
        else if(in_flag & OUTVALID & OUTREADY)
            in_flag <= 1'b0;
    end
end

assign fifo_i_ready = (~in_flag) | OUTREADY;

reg [`DATA_WIDTH/2-1:0] in_data_reg;
always@(posedge CDCLK or negedge CDRESETn)
begin
    if(~CDRESETn) in_data_reg <= 65'b0;
    else
    begin
        if((~in_flag) & fifo_i_valid)
            in_data_reg <= fifo_i_dout;
    end
end

assign OUTVALID = in_flag & fifo_i_valid;
assign OUTDATA = {in_data_reg,fifo_i_dout};



//-----------------------------------------------------------------------------------------

//                              Output Channel to LVDS

//-----------------------------------------------------------------------------------------
wire [`DATA_WIDTH/2-1:0] fifo_o_din;
wire fifo_o_wr_en,fifo_o_full;
fifo_PTC_wrapper fifo_o(
    .clk_wr               (CDCLK),
    .clk_rd               (CPCLK),
    .rstn                 (CDRESETn),
    .din                  (fifo_o_din),
    .wr_en                (fifo_o_wr_en),
    .full                 (fifo_o_full),
    .dout                 (CPODATA),
    .ready                (CPOREADY),
    .valid                (CPOVALID)
);

reg out_flag;
always@(posedge CDCLK or negedge CDRESETn)
begin
    if(~CDRESETn) out_flag <= 1'b0;
    else
    begin
        if((~out_flag) & fifo_o_wr_en)
            out_flag <= 1'b1;
        else if(out_flag & fifo_o_wr_en)
            out_flag <= 1'b0;
    end
end

assign fifo_o_wr_en = (~fifo_o_full) & INVALID;
assign INREADY = out_flag & (~fifo_o_full);
assign fifo_o_din = out_flag ? INDATA[`DATA_WIDTH/2-1:0] : INDATA[`DATA_WIDTH-1:`DATA_WIDTH/2];

endmodule