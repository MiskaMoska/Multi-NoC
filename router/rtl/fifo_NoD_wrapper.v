/*
    only support `DATA_WIDTH data width,standard synchronous FIFO
    for FIFOs in NoD and bypass_controller
*/
`include "param.vh"

module fifo_NoD_wrapper(
    input       wire                                clk,
    input       wire                                rstn,

    input       wire        [`DATA_WIDTH-1:0]       din,
    input       wire                                wr_en,
    output      wire                                full,

    output      wire        [`DATA_WIDTH-1:0]       dout,
    input       wire                                ready,
    output      reg                                 valid
);

localparam IDLE = 2'b00;
localparam TRANS = 2'b01;
localparam WAIT = 2'b11;

wire empty;
reg [1:0] state;
reg [1:0] nxt_state;

always@(posedge clk or negedge rstn)
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


SyncFIFO_RTL #(
    .width                   (`DATA_WIDTH),
    .depth                   (`FIFO_DEPTH),
    .depth_LOG               (`FIFO_DEPTH_LOG),
    .FWFT                    (0)
)fifo(
    .clk_i                   (clk),
    .rst_i                   (~rstn),
    .read_i                  (rd_en),
    .write_i                 (wr_en),
    .full_o                  (full),
    .empty_o                 (empty),
    .data_i                  (din),
    .data_o                  (dout)
);


endmodule