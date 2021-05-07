DATA_WIDTH = 130
NETWORK_WIDTH = 5
NETWORK_HEIGHT = 5

file_name = r"F:\本科毕设相关\源代码\scripts\NoD.txt"

def gen_instances(data_width,w,h):
    data_width = str(data_width)
    inst_str = ""
    for i in range(h): #row
        for j in range(w): #column
            id = w*i+j

            '''
            generate north port signals
            '''
            if i == 0: #north boundary
                north_in_data = data_width + "'b0"
                north_in_valid = "1'b0"
                north_in_ready = ""

                north_out_data = ""
                north_out_valid = ""
                north_out_ready = "1'b0"
            else:
                north_in_data = "data_"+str(id-w)+"_to_"+str(id)
                north_in_valid = "valid_"+str(id-w)+"_to_"+str(id)
                north_in_ready = "ready_"+str(id)+"_to_"+str(id-w)

                north_out_data = "data_"+str(id)+"_to_"+str(id-w)
                north_out_valid = "valid_"+str(id)+"_to_"+str(id-w)
                north_out_ready = "ready_"+str(id-w)+"_to_"+str(id)

            '''
            generate south port signals
            '''
            if i == h-1: #south boundary
                south_in_data = data_width + "'b0"
                south_in_valid = "1'b0"
                south_in_ready = ""

                south_out_data = ""
                south_out_valid = ""
                south_out_ready = "1'b0"
            else:
                south_in_data = "data_"+str(id+w)+"_to_"+str(id)
                south_in_valid = "valid_"+str(id+w)+"_to_"+str(id)
                south_in_ready = "ready_"+str(id)+"_to_"+str(id+w)

                south_out_data = "data_"+str(id)+"_to_"+str(id+w)
                south_out_valid = "valid_"+str(id)+"_to_"+str(id+w)
                south_out_ready = "ready_"+str(id+w)+"_to_"+str(id)

            '''
            generate west port signals
            '''
            if j == 0: #west boundary
                west_in_data = data_width + "'b0"
                west_in_valid = "1'b0"
                west_in_ready = ""

                west_out_data = ""
                west_out_valid = ""
                west_out_ready = "1'b0"
            else:
                west_in_data = "data_"+str(id-1)+"_to_"+str(id)
                west_in_valid = "valid_"+str(id-1)+"_to_"+str(id)
                west_in_ready = "ready_"+str(id)+"_to_"+str(id-1)

                west_out_data = "data_"+str(id)+"_to_"+str(id-1)
                west_out_valid = "valid_"+str(id)+"_to_"+str(id-1)
                west_out_ready = "ready_"+str(id-1)+"_to_"+str(id)

            '''
            generate east port signals
            '''
            if j == w-1: #east boundary
                east_in_data = data_width + "'b0"
                east_in_valid = "1'b0"
                east_in_ready = ""

                east_out_data = ""
                east_out_valid = ""
                east_out_ready = "1'b0"
            else:
                east_in_data = "data_"+str(id+1)+"_to_"+str(id)
                east_in_valid = "valid_"+str(id+1)+"_to_"+str(id)
                east_in_ready = "ready_"+str(id)+"_to_"+str(id+1)

                east_out_data = "data_"+str(id)+"_to_"+str(id+1)
                east_out_valid = "valid_"+str(id)+"_to_"+str(id+1)
                east_out_ready = "ready_"+str(id+1)+"_to_"+str(id)


            router_txt = '''    
router #(
    .ROUTER_ID_X        ('''+str(i)+'''),
    .ROUTER_ID_Y        ('''+str(j)+''')
)router'''+str(id)+'''(
    .CDCLK              (CDCLK),
    .CDRESETn           (CDRESETn),
    .CDIDATAW           ('''+west_in_data+'''),
    .CDIVALIDW          ('''+west_in_valid+'''),
    .CDIREADYW          ('''+west_in_ready+'''),
    .CDODATAW           ('''+west_out_data+'''),
    .CDOVALIDW          ('''+west_out_valid+'''),
    .CDOREADYW          ('''+west_out_ready+'''),
    .CDIDATAE           ('''+east_in_data+'''),
    .CDIVALIDE          ('''+east_in_valid+'''),
    .CDIREADYE          ('''+east_in_ready+'''),
    .CDODATAE           ('''+east_out_data+'''),
    .CDOVALIDE          ('''+east_out_valid+'''),
    .CDOREADYE          ('''+east_out_ready+'''),
    .CDIDATAL           (CDIDATA_X'''+str(i)+'''_Y'''+str(j)+'''),
    .CDIVALIDL          (CDIVALID_X'''+str(i)+'''_Y'''+str(j)+'''),
    .CDIREADYL          (CDIREADY_X'''+str(i)+'''_Y'''+str(j)+'''),
    .CDIDATAN           ('''+north_in_data+'''),
    .CDIVALIDN          ('''+north_in_valid+'''),
    .CDIREADYN          ('''+north_in_ready+'''),
    .CDODATAN           ('''+north_out_data+'''),
    .CDOVALIDN          ('''+north_out_valid+'''),
    .CDOREADYN          ('''+north_out_ready+'''),
    .CDIDATAS           ('''+south_in_data+'''),
    .CDIVALIDS          ('''+south_in_valid+'''),
    .CDIREADYS          ('''+south_in_ready+'''),
    .CDODATAS           ('''+south_out_data+'''),
    .CDOVALIDS          ('''+south_out_valid+'''),
    .CDOREADYS          ('''+south_out_ready+'''),
    .CDODATAL           (CDODATA_X'''+str(i)+'''_Y'''+str(j)+'''),
    .CDOVALIDL          (CDOVALID_X'''+str(i)+'''_Y'''+str(j)+'''),
    .CDOREADYL          (CDOREADY_X'''+str(i)+'''_Y'''+str(j)+''')
);\n'''
            inst_str += router_txt
    return inst_str



def gen_ports(w,h):

    port_str = '''//Network on Chip
//Width: '''+str(w)+'''
//Height:'''+str(h)+'''
`include "param.v"

module NoD #(
    parameter NODID = 0
)(
    input       wire                                CDCLK,
    input       wire                                CDRESETn,
    '''

    for i in range(h):
        for j in range(w):
            temp_txt = '''
    //router''' + str(i*w+j) + '''
    input       wire        [`DATA_WIDTH-1:0]       CDIDATA_X''' + str(i) + '''_Y''' + str(j) + ''',
    input       wire                                CDIVALID_X'''+str(i)+'''_Y'''+str(j)+''',
    output      wire                                CDIREADY_X'''+str(i)+'''_Y'''+str(j)+''',

    output      wire        [`DATA_WIDTH-1:0]       CDODATA_X'''+str(i)+'''_Y'''+str(j)+''',
    output      wire                                CDOVALID_X'''+str(i)+'''_Y'''+str(j)+''',
    input       wire                                CDOREADY_X'''+str(i)+'''_Y'''+str(j)
            if i != h-1 or j != w-1:
                temp_txt += ","
            port_str += temp_txt
            port_str += "\n"
    port_str += ");\n"
    return port_str



def gen_wires(w,h):

    wires_str = "\n//horizontal signals"
    for i in range(h):
        for j in range(w-1):
            temp_txt = '''
wire    [`DATA_WIDTH-1:0]   data_'''+str(w*i+j)+'''_to_'''+str(w*i+j+1)+''',\tdata_'''+str(w*i+j+1)+'''_to_'''+str(w*i+j)+''';
wire                        valid_'''+str(w*i+j)+'''_to_'''+str(w*i+j+1)+''',\tvalid_'''+str(w*i+j+1)+'''_to_'''+str(w*i+j)+''';
wire                        ready_'''+str(w*i+j)+'''_to_'''+str(w*i+j+1)+''',\tready_'''+str(w*i+j+1)+'''_to_'''+str(w*i+j)+''';'''
            wires_str += temp_txt


    wires_str += "\n\n//vertical signals"
    for i in range(w):
        for j in range(h-1):
            temp_txt = '''
wire    [`DATA_WIDTH-1:0]   data_'''+str(i+j*w)+'''_to_'''+str(i+(j+1)*w)+''',\tdata_'''+str(i+(j+1)*w)+'''_to_'''+str(i+j*w)+''';
wire                        valid_'''+str(i+j*w)+'''_to_'''+str(i+(j+1)*w)+''',\tvalid_'''+str(i+(j+1)*w)+'''_to_'''+str(i+j*w)+''';
wire                        ready_'''+str(i+j*w)+'''_to_'''+str(i+(j+1)*w)+''',\tready_'''+str(i+(j+1)*w)+'''_to_'''+str(i+j*w)+''';'''
            wires_str += temp_txt
    wires_str += "\n"
    return wires_str



def gen_verilog_file():
    containt = ""
    containt += gen_ports(NETWORK_WIDTH,NETWORK_HEIGHT)
    containt += gen_wires(NETWORK_WIDTH,NETWORK_HEIGHT)
    containt += gen_instances(DATA_WIDTH,NETWORK_WIDTH,NETWORK_HEIGHT)
    containt += "\nendmodule"

    my_file = open(file_name,"w")
    my_file.write("{0}\n".format(containt))
    my_file.flush()
    my_file.close()

    print("Text has been written into:",file_name)



if __name__ == "__main__":
    gen_verilog_file()


