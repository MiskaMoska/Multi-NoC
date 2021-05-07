/*
    only support `DATA_WIDTH/2-1 data width,standard asynchronous FIFO
    for FIFOs in sync_controller
*/
`include "param.vh"

module fifo_PTC_wrapper(
    input       wire                                clk_wr,
    input       wire                                clk_rd,
    input       wire                                rstn,

    input       wire        [`DATA_WIDTH/2-1:0]     din,
    input       wire                                wr_en,
    output      wire                                full,

    output      wire        [`DATA_WIDTH/2-1:0]     dout,
    input       wire                                ready,
    output      reg                                 valid
);

localparam IDLE = 2'b00;
localparam TRANS = 2'b01;
localparam WAIT = 2'b11;

wire empty;
reg [1:0] state;
reg [1:0] nxt_state;

always@(posedge clk_rd or negedge rstn)
begin
    if(~rstn) state <= IDLE;
    else state <= nxt_state;
end

always@(*)
begin
    case(state)
        IDLE: nxt_state = ~empty ? TRANS : state;
        TRANS: 
        begin
            case(empty)
                1'b0:       nxt_state = state;
                1'b1:       nxt_state = ready ? IDLE : WAIT;
                default:    nxt_state = IDLE;
            endcase
        end 
        WAIT:
        begin
            case(empty)
                1'b0:       nxt_state = ready ? TRANS : state;
                1'b1:       nxt_state = ready ? IDLE  : state;
                default:    nxt_state = IDLE;
            endcase
        end
        default: nxt_state = IDLE;
    endcase
end

reg rd_en;

always@(*)
begin
    case(state)
        IDLE: begin
            valid = 1'b0;
            rd_en = ~empty;
        end      
        TRANS: begin
            valid = 1'b1;
            rd_en = ~empty & ready;
        end    
        WAIT: begin
            valid = 1'b1;
            rd_en = ready;
        end      
        default: begin
            valid = 1'b0;
            rd_en = 1'b0;
        end    
    endcase
end


AsyncFIFO_RTL #(
    .DATA_WIDTH               (`DATA_WIDTH/2),
    .ADDR_WIDTH               (`ASYNC_FIFO_DEPTH_LOG)
)fifo(
    .wrclk                    (clk_wr),
    .rstn_wrclk               (rstn),
    .wr_data                  (din),
    .wr_en                    (wr_en),
    .full                     (full),
    .rdclk                    (clk_rd),
    .rstn_rdclk               (rstn),
    .rd_data                  (dout),
    .rd_en                    (rd_en),
    .empty                    (empty)
);
endmodule