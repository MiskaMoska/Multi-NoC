//link three input ports without order
`include "param.vh"

module link_three(
    input       wire                                clk,
    input       wire                                rstn,

    input       wire        [`DATA_WIDTH-1:0]       A_data_i,
    input       wire                                A_valid_i,
    output      wire                                A_ready_o,

    input       wire        [`DATA_WIDTH-1:0]       B_data_i,
    input       wire                                B_valid_i,
    output      wire                                B_ready_o,

    input       wire        [`DATA_WIDTH-1:0]       C_data_i,
    input       wire                                C_valid_i,
    output      wire                                C_ready_o,

    output      wire        [`DATA_WIDTH-1:0]       data_o,
    output      wire                                valid_o,
    input       wire                                ready_i
);

wire [1:0] data_in_typebits;
wire [2:0] request,grant;
wire fire,update_prior;

assign data_in_typebits = data_o[`DATA_WIDTH-1:`DATA_WIDTH-2];
assign request = {A_valid_i, B_valid_i, C_valid_i};

mtx_arbiter #(
    .LEN(3) 
)arbiter_three(
    .clk            (clk),
    .rstn           (rstn),

    .request        (request),
    .grant          (grant),

    .update         (update_prior)
);

reg state;
reg [2:0] grant_reg;

always@(posedge clk or negedge rstn)
begin
    if(~rstn) 
    begin
        state <= 0; grant_reg <= 0;
    end
    else if((~state) & fire) 
    begin
        state <= 1; grant_reg <= grant;
    end
    else if(state & (data_in_typebits == `TAIL) & fire) 
        state <= 0;
end

wire [2:0] mux_ctrl;
assign mux_ctrl = state ? grant_reg : grant;

assign  valid_o  =  mux_ctrl[2]  &  A_valid_i  | 
                    mux_ctrl[1]  &  B_valid_i  | 
                    mux_ctrl[0]  &  C_valid_i;

assign fire = valid_o & ready_i; 
assign update_prior = (~state) & fire;

assign data_o = mux_ctrl[2] ? A_data_i : (
                mux_ctrl[1] ? B_data_i : (
                mux_ctrl[0] ? C_data_i : 0));

assign A_ready_o = mux_ctrl[2] & ready_i;
assign B_ready_o = mux_ctrl[1] & ready_i;
assign C_ready_o = mux_ctrl[0] & ready_i;
endmodule