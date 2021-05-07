
for d in range(3):
    for x in range(5):
        for y in range(5):
            if(x*5+y != 10 and x*5+y != 14):
                print('uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt['+str(d*25+x*5+y)+'].drv","vif",i_if['+str(d*25+x*5+y)+']);')
                print('uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt['+str(d*25+x*5+y)+'].mon","vif",o_if['+str(d*25+x*5+y)+']);')



    #             print('''
    # .CDIDATA_X'''+str(x)+'''_Y'''+str(y)+'''_D'''+str(d)+'''                (i_if['''+str(d*25+x*5+y)+'''].data),
    # .CDIVALID_X'''+str(x)+'''_Y'''+str(y)+'''_D'''+str(d)+'''               (i_if['''+str(d*25+x*5+y)+'''].valid),
    # .CDIREADY_X'''+str(x)+'''_Y'''+str(y)+'''_D'''+str(d)+'''               (i_if['''+str(d*25+x*5+y)+'''].ready),
    # .CDODATA_X'''+str(x)+'''_Y'''+str(y)+'''_D'''+str(d)+'''                (o_if['''+str(d*25+x*5+y)+'''].data),
    # .CDOVALID_X'''+str(x)+'''_Y'''+str(y)+'''_D'''+str(d)+'''               (o_if['''+str(d*25+x*5+y)+'''].valid),
    # .CDOREADY_X'''+str(x)+'''_Y'''+str(y)+'''_D'''+str(d)+'''               (o_if['''+str(d*25+x*5+y)+'''].ready),''')

    