def gen_ports():
    print('''
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X0_Y0'''+id+''',
    input       wire                                CDIVALID_X0_Y0'''+id+''',
    output      wire                                CDIREADY_X0_Y0'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X0_Y0'''+id+''',
    output      wire                                CDOVALID_X0_Y0'''+id+''',
    input       wire                                CDOREADY_X0_Y0'''+id+''',

    //router1
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X0_Y1'''+id+''',
    input       wire                                CDIVALID_X0_Y1'''+id+''',
    output      wire                                CDIREADY_X0_Y1'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X0_Y1'''+id+''',
    output      wire                                CDOVALID_X0_Y1'''+id+''',
    input       wire                                CDOREADY_X0_Y1'''+id+''',

    //router2
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X0_Y2'''+id+''',
    input       wire                                CDIVALID_X0_Y2'''+id+''',
    output      wire                                CDIREADY_X0_Y2'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X0_Y2'''+id+''',
    output      wire                                CDOVALID_X0_Y2'''+id+''',
    input       wire                                CDOREADY_X0_Y2'''+id+''',

    //router3
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X0_Y3,
    input       wire                                CDIVALID_X0_Y3,
    output      wire                                CDIREADY_X0_Y3,

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X0_Y3,
    output      wire                                CDOVALID_X0_Y3,
    input       wire                                CDOREADY_X0_Y3,

    //router4
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X0_Y4'''+id+''',
    input       wire                                CDIVALID_X0_Y4'''+id+''',
    output      wire                                CDIREADY_X0_Y4'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X0_Y4'''+id+''',
    output      wire                                CDOVALID_X0_Y4'''+id+''',
    input       wire                                CDOREADY_X0_Y4'''+id+''',

    //router5
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X1_Y0'''+id+''',
    input       wire                                CDIVALID_X1_Y0'''+id+''',
    output      wire                                CDIREADY_X1_Y0'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X1_Y0'''+id+''',
    output      wire                                CDOVALID_X1_Y0'''+id+''',
    input       wire                                CDOREADY_X1_Y0'''+id+''',

    //router6
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X1_Y1'''+id+''',
    input       wire                                CDIVALID_X1_Y1'''+id+''',
    output      wire                                CDIREADY_X1_Y1'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X1_Y1'''+id+''',
    output      wire                                CDOVALID_X1_Y1'''+id+''',
    input       wire                                CDOREADY_X1_Y1'''+id+''',

    //router7
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X1_Y2'''+id+''',
    input       wire                                CDIVALID_X1_Y2'''+id+''',
    output      wire                                CDIREADY_X1_Y2'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X1_Y2'''+id+''',
    output      wire                                CDOVALID_X1_Y2'''+id+''',
    input       wire                                CDOREADY_X1_Y2'''+id+''',

    //router8
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X1_Y3'''+id+''',
    input       wire                                CDIVALID_X1_Y3'''+id+''',
    output      wire                                CDIREADY_X1_Y3'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X1_Y3'''+id+''',
    output      wire                                CDOVALID_X1_Y3'''+id+''',
    input       wire                                CDOREADY_X1_Y3'''+id+''',

    //router9
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X1_Y4'''+id+''',
    input       wire                                CDIVALID_X1_Y4'''+id+''',
    output      wire                                CDIREADY_X1_Y4'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X1_Y4'''+id+''',
    output      wire                                CDOVALID_X1_Y4'''+id+''',
    input       wire                                CDOREADY_X1_Y4'''+id+''',

    // //router10
    // input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X2_Y0,
    // input       wire                                CDIVALID_X2_Y0,
    // output      wire                                CDIREADY_X2_Y0,

    // output      wire        [`DATA_WIDTH-1:0]       CDODATA_X2_Y0,
    // output      wire                                CDOVALID_X2_Y0,
    // input       wire                                CDOREADY_X2_Y0,

    //router11
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X2_Y1'''+id+''',
    input       wire                                CDIVALID_X2_Y1'''+id+''',
    output      wire                                CDIREADY_X2_Y1'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X2_Y1'''+id+''',
    output      wire                                CDOVALID_X2_Y1'''+id+''',
    input       wire                                CDOREADY_X2_Y1'''+id+''',

    //router12
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X2_Y2'''+id+''',
    input       wire                                CDIVALID_X2_Y2'''+id+''',
    output      wire                                CDIREADY_X2_Y2'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X2_Y2'''+id+''',
    output      wire                                CDOVALID_X2_Y2'''+id+''',
    input       wire                                CDOREADY_X2_Y2'''+id+''',

    //router13
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X2_Y3'''+id+''',
    input       wire                                CDIVALID_X2_Y3'''+id+''',
    output      wire                                CDIREADY_X2_Y3'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X2_Y3'''+id+''',
    output      wire                                CDOVALID_X2_Y3'''+id+''',
    input       wire                                CDOREADY_X2_Y3'''+id+''',

    // //router14
    // input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X2_Y4,
    // input       wire                                CDIVALID_X2_Y4,
    // output      wire                                CDIREADY_X2_Y4,

    // output      wire        [`DATA_WIDTH-1:0]       CDODATA_X2_Y4,
    // output      wire                                CDOVALID_X2_Y4,
    // input       wire                                CDOREADY_X2_Y4,

    //router15
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X3_Y0'''+id+''',
    input       wire                                CDIVALID_X3_Y0'''+id+''',
    output      wire                                CDIREADY_X3_Y0'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X3_Y0'''+id+''',
    output      wire                                CDOVALID_X3_Y0'''+id+''',
    input       wire                                CDOREADY_X3_Y0'''+id+''',

    //router16
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X3_Y1'''+id+''',
    input       wire                                CDIVALID_X3_Y1'''+id+''',
    output      wire                                CDIREADY_X3_Y1'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X3_Y1'''+id+''',
    output      wire                                CDOVALID_X3_Y1'''+id+''',
    input       wire                                CDOREADY_X3_Y1'''+id+''',

    //router17
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X3_Y2'''+id+''',
    input       wire                                CDIVALID_X3_Y2'''+id+''',
    output      wire                                CDIREADY_X3_Y2'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X3_Y2'''+id+''',
    output      wire                                CDOVALID_X3_Y2'''+id+''',
    input       wire                                CDOREADY_X3_Y2'''+id+''',

    //router18
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X3_Y3'''+id+''',
    input       wire                                CDIVALID_X3_Y3'''+id+''',
    output      wire                                CDIREADY_X3_Y3'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X3_Y3'''+id+''',
    output      wire                                CDOVALID_X3_Y3'''+id+''',
    input       wire                                CDOREADY_X3_Y3'''+id+''',

    //router19
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X3_Y4'''+id+''',
    input       wire                                CDIVALID_X3_Y4'''+id+''',
    output      wire                                CDIREADY_X3_Y4'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X3_Y4'''+id+''',
    output      wire                                CDOVALID_X3_Y4'''+id+''',
    input       wire                                CDOREADY_X3_Y4'''+id+''',

    //router20
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X4_Y0'''+id+''',
    input       wire                                CDIVALID_X4_Y0'''+id+''',
    output      wire                                CDIREADY_X4_Y0'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X4_Y0'''+id+''',
    output      wire                                CDOVALID_X4_Y0'''+id+''',
    input       wire                                CDOREADY_X4_Y0'''+id+''',

    //router21
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X4_Y1'''+id+''',
    input       wire                                CDIVALID_X4_Y1'''+id+''',
    output      wire                                CDIREADY_X4_Y1'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X4_Y1'''+id+''',
    output      wire                                CDOVALID_X4_Y1'''+id+''',
    input       wire                                CDOREADY_X4_Y1'''+id+''',

    //router22
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X4_Y2'''+id+''',
    input       wire                                CDIVALID_X4_Y2'''+id+''',
    output      wire                                CDIREADY_X4_Y2'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X4_Y2'''+id+''',
    output      wire                                CDOVALID_X4_Y2'''+id+''',
    input       wire                                CDOREADY_X4_Y2'''+id+''',

    //router23
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X4_Y3'''+id+''',
    input       wire                                CDIVALID_X4_Y3'''+id+''',
    output      wire                                CDIREADY_X4_Y3'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X4_Y3'''+id+''',
    output      wire                                CDOVALID_X4_Y3'''+id+''',
    input       wire                                CDOREADY_X4_Y3'''+id+''',

    //router24
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X4_Y4'''+id+''',
    input       wire                                CDIVALID_X4_Y4'''+id+''',
    output      wire                                CDIREADY_X4_Y4'''+id+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X4_Y4'''+id+''',
    output      wire                                CDOVALID_X4_Y4'''+id+''',
    input       wire                                CDOREADY_X4_Y4'''+id+''',
''')

def gen_nod_inst(id = "_D2"):
    print('''
ExtenNoD #(
    .NODID                        (NODID)
)NoD0(
    .CDCLK                        (CDCLK),
    .CPCLK                        (CPCLK),
    .CDRESETn                     (CDRESETn),
    .CDIDATA_X0_Y0                (CDIDATA_X0_Y0'''+id+'''),
    .CDIVALID_X0_Y0               (CDIVALID_X0_Y0'''+id+'''),
    .CDIREADY_X0_Y0               (CDIREADY_X0_Y0'''+id+'''),
    .CDODATA_X0_Y0                (CDODATA_X0_Y0'''+id+'''),
    .CDOVALID_X0_Y0               (CDOVALID_X0_Y0'''+id+'''),
    .CDOREADY_X0_Y0               (CDOREADY_X0_Y0'''+id+'''),
    .CDIDATA_X0_Y1                (CDIDATA_X0_Y1'''+id+'''),
    .CDIVALID_X0_Y1               (CDIVALID_X0_Y1'''+id+'''),
    .CDIREADY_X0_Y1               (CDIREADY_X0_Y1'''+id+'''),
    .CDODATA_X0_Y1                (CDODATA_X0_Y1'''+id+'''),
    .CDOVALID_X0_Y1               (CDOVALID_X0_Y1'''+id+'''),
    .CDOREADY_X0_Y1               (CDOREADY_X0_Y1'''+id+'''),
    .CDIDATA_X0_Y2                (CDIDATA_X0_Y2'''+id+'''),
    .CDIVALID_X0_Y2               (CDIVALID_X0_Y2'''+id+'''),
    .CDIREADY_X0_Y2               (CDIREADY_X0_Y2'''+id+'''),
    .CDODATA_X0_Y2                (CDODATA_X0_Y2'''+id+'''),
    .CDOVALID_X0_Y2               (CDOVALID_X0_Y2'''+id+'''),
    .CDOREADY_X0_Y2               (CDOREADY_X0_Y2'''+id+'''),
    .CDIDATA_X0_Y3                (CDIDATA_X0_Y3'''+id+'''),
    .CDIVALID_X0_Y3               (CDIVALID_X0_Y3'''+id+'''),
    .CDIREADY_X0_Y3               (CDIREADY_X0_Y3'''+id+'''),
    .CDODATA_X0_Y3                (CDODATA_X0_Y3'''+id+'''),
    .CDOVALID_X0_Y3               (CDOVALID_X0_Y3'''+id+'''),
    .CDOREADY_X0_Y3               (CDOREADY_X0_Y3'''+id+'''),
    .CDIDATA_X0_Y4                (CDIDATA_X0_Y4'''+id+'''),
    .CDIVALID_X0_Y4               (CDIVALID_X0_Y4'''+id+'''),
    .CDIREADY_X0_Y4               (CDIREADY_X0_Y4'''+id+'''),
    .CDODATA_X0_Y4                (CDODATA_X0_Y4'''+id+'''),
    .CDOVALID_X0_Y4               (CDOVALID_X0_Y4'''+id+'''),
    .CDOREADY_X0_Y4               (CDOREADY_X0_Y4'''+id+'''),
    .CDIDATA_X1_Y0                (CDIDATA_X1_Y0'''+id+'''),
    .CDIVALID_X1_Y0               (CDIVALID_X1_Y0'''+id+'''),
    .CDIREADY_X1_Y0               (CDIREADY_X1_Y0'''+id+'''),
    .CDODATA_X1_Y0                (CDODATA_X1_Y0'''+id+'''),
    .CDOVALID_X1_Y0               (CDOVALID_X1_Y0'''+id+'''),
    .CDOREADY_X1_Y0               (CDOREADY_X1_Y0'''+id+'''),
    .CDIDATA_X1_Y1                (CDIDATA_X1_Y1'''+id+'''),
    .CDIVALID_X1_Y1               (CDIVALID_X1_Y1'''+id+'''),
    .CDIREADY_X1_Y1               (CDIREADY_X1_Y1'''+id+'''),
    .CDODATA_X1_Y1                (CDODATA_X1_Y1'''+id+'''),
    .CDOVALID_X1_Y1               (CDOVALID_X1_Y1'''+id+'''),
    .CDOREADY_X1_Y1               (CDOREADY_X1_Y1'''+id+'''),
    .CDIDATA_X1_Y2                (CDIDATA_X1_Y2'''+id+'''),
    .CDIVALID_X1_Y2               (CDIVALID_X1_Y2'''+id+'''),
    .CDIREADY_X1_Y2               (CDIREADY_X1_Y2'''+id+'''),
    .CDODATA_X1_Y2                (CDODATA_X1_Y2'''+id+'''),
    .CDOVALID_X1_Y2               (CDOVALID_X1_Y2'''+id+'''),
    .CDOREADY_X1_Y2               (CDOREADY_X1_Y2'''+id+'''),
    .CDIDATA_X1_Y3                (CDIDATA_X1_Y3'''+id+'''),
    .CDIVALID_X1_Y3               (CDIVALID_X1_Y3'''+id+'''),
    .CDIREADY_X1_Y3               (CDIREADY_X1_Y3'''+id+'''),
    .CDODATA_X1_Y3                (CDODATA_X1_Y3'''+id+'''),
    .CDOVALID_X1_Y3               (CDOVALID_X1_Y3'''+id+'''),
    .CDOREADY_X1_Y3               (CDOREADY_X1_Y3'''+id+'''),
    .CDIDATA_X1_Y4                (CDIDATA_X1_Y4'''+id+'''),
    .CDIVALID_X1_Y4               (CDIVALID_X1_Y4'''+id+'''),
    .CDIREADY_X1_Y4               (CDIREADY_X1_Y4'''+id+'''),
    .CDODATA_X1_Y4                (CDODATA_X1_Y4'''+id+'''),
    .CDOVALID_X1_Y4               (CDOVALID_X1_Y4'''+id+'''),
    .CDOREADY_X1_Y4               (CDOREADY_X1_Y4'''+id+'''),
    .CDIDATA_X2_Y1                (CDIDATA_X2_Y1'''+id+'''),
    .CDIVALID_X2_Y1               (CDIVALID_X2_Y1'''+id+'''),
    .CDIREADY_X2_Y1               (CDIREADY_X2_Y1'''+id+'''),
    .CDODATA_X2_Y1                (CDODATA_X2_Y1'''+id+'''),
    .CDOVALID_X2_Y1               (CDOVALID_X2_Y1'''+id+'''),
    .CDOREADY_X2_Y1               (CDOREADY_X2_Y1'''+id+'''),
    .CDIDATA_X2_Y2                (CDIDATA_X2_Y2'''+id+'''),
    .CDIVALID_X2_Y2               (CDIVALID_X2_Y2'''+id+'''),
    .CDIREADY_X2_Y2               (CDIREADY_X2_Y2'''+id+'''),
    .CDODATA_X2_Y2                (CDODATA_X2_Y2'''+id+'''),
    .CDOVALID_X2_Y2               (CDOVALID_X2_Y2'''+id+'''),
    .CDOREADY_X2_Y2               (CDOREADY_X2_Y2'''+id+'''),
    .CDIDATA_X2_Y3                (CDIDATA_X2_Y3'''+id+'''),
    .CDIVALID_X2_Y3               (CDIVALID_X2_Y3'''+id+'''),
    .CDIREADY_X2_Y3               (CDIREADY_X2_Y3'''+id+'''),
    .CDODATA_X2_Y3                (CDODATA_X2_Y3'''+id+'''),
    .CDOVALID_X2_Y3               (CDOVALID_X2_Y3'''+id+'''),
    .CDOREADY_X2_Y3               (CDOREADY_X2_Y3'''+id+'''),
    .CDIDATA_X3_Y0                (CDIDATA_X3_Y0'''+id+'''),
    .CDIVALID_X3_Y0               (CDIVALID_X3_Y0'''+id+'''),
    .CDIREADY_X3_Y0               (CDIREADY_X3_Y0'''+id+'''),
    .CDODATA_X3_Y0                (CDODATA_X3_Y0'''+id+'''),
    .CDOVALID_X3_Y0               (CDOVALID_X3_Y0'''+id+'''),
    .CDOREADY_X3_Y0               (CDOREADY_X3_Y0'''+id+'''),
    .CDIDATA_X3_Y1                (CDIDATA_X3_Y1'''+id+'''),
    .CDIVALID_X3_Y1               (CDIVALID_X3_Y1'''+id+'''),
    .CDIREADY_X3_Y1               (CDIREADY_X3_Y1'''+id+'''),
    .CDODATA_X3_Y1                (CDODATA_X3_Y1'''+id+'''),
    .CDOVALID_X3_Y1               (CDOVALID_X3_Y1'''+id+'''),
    .CDOREADY_X3_Y1               (CDOREADY_X3_Y1'''+id+'''),
    .CDIDATA_X3_Y2                (CDIDATA_X3_Y2'''+id+'''),
    .CDIVALID_X3_Y2               (CDIVALID_X3_Y2'''+id+'''),
    .CDIREADY_X3_Y2               (CDIREADY_X3_Y2'''+id+'''),
    .CDODATA_X3_Y2                (CDODATA_X3_Y2'''+id+'''),
    .CDOVALID_X3_Y2               (CDOVALID_X3_Y2'''+id+'''),
    .CDOREADY_X3_Y2               (CDOREADY_X3_Y2'''+id+'''),
    .CDIDATA_X3_Y3                (CDIDATA_X3_Y3'''+id+'''),
    .CDIVALID_X3_Y3               (CDIVALID_X3_Y3'''+id+'''),
    .CDIREADY_X3_Y3               (CDIREADY_X3_Y3'''+id+'''),
    .CDODATA_X3_Y3                (CDODATA_X3_Y3'''+id+'''),
    .CDOVALID_X3_Y3               (CDOVALID_X3_Y3'''+id+'''),
    .CDOREADY_X3_Y3               (CDOREADY_X3_Y3'''+id+'''),
    .CDIDATA_X3_Y4                (CDIDATA_X3_Y4'''+id+'''),
    .CDIVALID_X3_Y4               (CDIVALID_X3_Y4'''+id+'''),
    .CDIREADY_X3_Y4               (CDIREADY_X3_Y4'''+id+'''),
    .CDODATA_X3_Y4                (CDODATA_X3_Y4'''+id+'''),
    .CDOVALID_X3_Y4               (CDOVALID_X3_Y4'''+id+'''),
    .CDOREADY_X3_Y4               (CDOREADY_X3_Y4'''+id+'''),
    .CDIDATA_X4_Y0                (CDIDATA_X4_Y0'''+id+'''),
    .CDIVALID_X4_Y0               (CDIVALID_X4_Y0'''+id+'''),
    .CDIREADY_X4_Y0               (CDIREADY_X4_Y0'''+id+'''),
    .CDODATA_X4_Y0                (CDODATA_X4_Y0'''+id+'''),
    .CDOVALID_X4_Y0               (CDOVALID_X4_Y0'''+id+'''),
    .CDOREADY_X4_Y0               (CDOREADY_X4_Y0'''+id+'''),
    .CDIDATA_X4_Y1                (CDIDATA_X4_Y1'''+id+'''),
    .CDIVALID_X4_Y1               (CDIVALID_X4_Y1'''+id+'''),
    .CDIREADY_X4_Y1               (CDIREADY_X4_Y1'''+id+'''),
    .CDODATA_X4_Y1                (CDODATA_X4_Y1'''+id+'''),
    .CDOVALID_X4_Y1               (CDOVALID_X4_Y1'''+id+'''),
    .CDOREADY_X4_Y1               (CDOREADY_X4_Y1'''+id+'''),
    .CDIDATA_X4_Y2                (CDIDATA_X4_Y2'''+id+'''),
    .CDIVALID_X4_Y2               (CDIVALID_X4_Y2'''+id+'''),
    .CDIREADY_X4_Y2               (CDIREADY_X4_Y2'''+id+'''),
    .CDODATA_X4_Y2                (CDODATA_X4_Y2'''+id+'''),
    .CDOVALID_X4_Y2               (CDOVALID_X4_Y2'''+id+'''),
    .CDOREADY_X4_Y2               (CDOREADY_X4_Y2'''+id+'''),
    .CDIDATA_X4_Y3                (CDIDATA_X4_Y3'''+id+'''),
    .CDIVALID_X4_Y3               (CDIVALID_X4_Y3'''+id+'''),
    .CDIREADY_X4_Y3               (CDIREADY_X4_Y3'''+id+'''),
    .CDODATA_X4_Y3                (CDODATA_X4_Y3'''+id+'''),
    .CDOVALID_X4_Y3               (CDOVALID_X4_Y3'''+id+'''),
    .CDOREADY_X4_Y3               (CDOREADY_X4_Y3'''+id+'''),
    .CDIDATA_X4_Y4                (CDIDATA_X4_Y4'''+id+'''),
    .CDIVALID_X4_Y4               (CDIVALID_X4_Y4'''+id+'''),
    .CDIREADY_X4_Y4               (CDIREADY_X4_Y4'''+id+'''),
    .CDODATA_X4_Y4                (CDODATA_X4_Y4'''+id+'''),
    .CDOVALID_X4_Y4               (CDOVALID_X4_Y4'''+id+'''),
    .CDOREADY_X4_Y4               (CDOREADY_X4_Y4'''+id+'''),
    .CPIDATA_W                    (65'b0),
    .CPIVALID_W                   (1'b0),
    .CPIREADY_W                   (),
    .CPODATA_W                    (),
    .CPOVALID_W                   (),
    .CPOREADY_W                   (1'b0),
    .CPIDATA_E                    (d1_2_d0_data),
    .CPIVALID_E                   (d1_2_d0_data),
    .CPIREADY_E                   (d1_2_d0_data),
    .CPODATA_E                    (d0_2_d1_data),
    .CPOVALID_E                   (d0_2_d1_data),
    .CPOREADY_E                   (d0_2_d1_data)
);''')

if __name__ == "__main__":
    gen_nod_inst()