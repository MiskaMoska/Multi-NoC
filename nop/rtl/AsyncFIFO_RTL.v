/*
    standard mode
*/
module AsyncFIFO_RTL#(
    parameter   DATA_WIDTH =                            16,
    parameter   ADDR_WIDTH =                            4
)(
    input       wire                                    wrclk,
    input       wire                                    rstn_wrclk,
    input       wire        [DATA_WIDTH-1:0]            wr_data,
    input       wire                                    wr_en,
    output      wire                                    full,

    input       wire                                    rdclk,
    input       wire                                    rstn_rdclk,
    output      wire        [DATA_WIDTH-1:0]            rd_data,
    input       wire                                    rd_en,
    output      wire                                    empty
);

//==================================================================
//
//                        wr_ptr counter
//
//==================================================================
wire [ADDR_WIDTH:0] wrptr_gnext,wrptr_bnext;
reg [ADDR_WIDTH:0] wrptr_gray,wrptr_bin;

assign wrptr_bnext = wrptr_bin + (wr_en & (~full));
always@(posedge wrclk or negedge rstn_wrclk)
begin
    if(~rstn_wrclk)
        wrptr_gray <= 0;
    else 
        wrptr_gray <= wrptr_gnext;
end

/*
    bin to gray
*/
genvar i;
integer k,j;
generate
    for(i=0;i<=ADDR_WIDTH;i=i+1)
    begin
        if(i!=ADDR_WIDTH)
            assign wrptr_gnext[i] = wrptr_bnext[i] ^ wrptr_bnext[i+1];
        else
            assign wrptr_gnext[i] = wrptr_bnext[ADDR_WIDTH];
    end
endgenerate

/*
    gray to bin
*/
always@(*)
begin
    for(k=0;k<=ADDR_WIDTH;k=k+1)
    begin
        for(j=k;j<=ADDR_WIDTH;j=j+1)
        begin
            if(j==k)
                wrptr_bin[k] = wrptr_gray[k];
            else
                wrptr_bin[k] = wrptr_bin[k] ^ wrptr_gray[j];
        end
    end
end



//==================================================================
//
//                        rd_ptr counter
//
//==================================================================
wire [ADDR_WIDTH:0] rdptr_gnext,rdptr_bnext;
reg [ADDR_WIDTH:0] rdptr_gray,rdptr_bin;

assign rdptr_bnext = rdptr_bin + (rd_en & (~empty));
always@(posedge rdclk or negedge rstn_rdclk)
begin
    if(~rstn_rdclk)
        rdptr_gray <= 0;
    else 
        rdptr_gray <= rdptr_gnext;
end

/*
    bin to gray
*/
generate
    for(i=0;i<=ADDR_WIDTH;i=i+1)
    begin
        if(i!=ADDR_WIDTH)
            assign rdptr_gnext[i] = rdptr_bnext[i] ^ rdptr_bnext[i+1];
        else
            assign rdptr_gnext[i] = rdptr_bnext[ADDR_WIDTH];
    end
endgenerate

/*
    gray to bin
*/
always@(*)
begin
    for(k=0;k<=ADDR_WIDTH;k=k+1)
    begin
        for(j=k;j<=ADDR_WIDTH;j=j+1)
        begin
            if(j==k)
                rdptr_bin[k] = rdptr_gray[k];
            else
                rdptr_bin[k] = rdptr_bin[k] ^ rdptr_gray[j];
        end
    end
end


//==================================================================
//
//                        dual RAM instance
//
//==================================================================
Block_DualPort_RAM #(
    .DATA_WIDTH               (DATA_WIDTH),
    .ADDR_WIDTH               (ADDR_WIDTH)
)DualRAM(
    .clka                     (wrclk),
    .clkb                     (rdclk),
    .addra                    (wrptr_bin[ADDR_WIDTH-1:0]),
    .addrb                    (rdptr_bin[ADDR_WIDTH-1:0]),
    .doutb                    (rd_data),
    .dina                     (wr_data),
    .wea                      (wr_en & (~full)),
    .rea                      (rd_en & (~empty))

);


//==================================================================
//
//                        synchronization
//
//==================================================================
reg [ADDR_WIDTH:0] rdptr_sync1,rdptr_sync2;
always@(posedge wrclk or negedge rstn_wrclk)
begin
    if(~rstn_wrclk)
    begin
        rdptr_sync1 <= 0;
        rdptr_sync2 <= 0;
    end
    else
    begin
        rdptr_sync1 <= rdptr_gray;
        rdptr_sync2 <= rdptr_sync1;
    end
end

reg [ADDR_WIDTH:0] wrptr_sync1,wrptr_sync2;
always@(posedge rdclk or negedge rstn_rdclk)
begin
    if(~rstn_rdclk)
    begin
        wrptr_sync1 <= 0;
        wrptr_sync2 <= 0;
    end
    else
    begin
        wrptr_sync1 <= wrptr_gray;
        wrptr_sync2 <= wrptr_sync1;
    end
end


//==================================================================
//
//                        generating flags
//
//==================================================================
reg [ADDR_WIDTH:0] wrptr_sync2_bin,rdptr_sync2_bin;

/*
    rdptr_sync2 gray to bin
*/
always@(*)
begin
    for(k=0;k<=ADDR_WIDTH;k=k+1)
    begin
        for(j=k;j<=ADDR_WIDTH;j=j+1)
        begin
            if(j==k)
                rdptr_sync2_bin[k] = rdptr_sync2[k];
            else
                rdptr_sync2_bin[k] = rdptr_sync2_bin[k] ^ rdptr_sync2[j];
        end
    end
end

/*
    wr_ptr_sync2 gray to bin
*/
always@(*)
begin
    for(k=0;k<=ADDR_WIDTH;k=k+1)
    begin
        for(j=k;j<=ADDR_WIDTH;j=j+1)
        begin
            if(j==k)
                wrptr_sync2_bin[k] = wrptr_sync2[k];
            else
                wrptr_sync2_bin[k] = wrptr_sync2_bin[k] ^ wrptr_sync2[j];
        end
    end
end

assign full  =  (wrptr_bin[ADDR_WIDTH] != rdptr_sync2_bin[ADDR_WIDTH]) &
                (wrptr_bin[ADDR_WIDTH-1:0] == rdptr_sync2_bin[ADDR_WIDTH-1:0]);

assign empty =  (rdptr_bin == wrptr_sync2_bin);

endmodule