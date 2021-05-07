module Block_DualPort_RAM #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 4
)(
    input clka,
    input clkb,
    input [ADDR_WIDTH-1:0] addra,
    input [ADDR_WIDTH-1:0] addrb,
    input [DATA_WIDTH-1:0] dina,
    output reg [DATA_WIDTH-1:0] doutb,
    input wea,
    input rea

);

reg [DATA_WIDTH-1:0] mem [(2**ADDR_WIDTH-1):0];

always@(posedge clka) begin
    if(wea) 
        mem[addra] <= dina;
end

always@(posedge clkb) begin
    if(rea)
        doutb <= mem[addrb];
end

endmodule