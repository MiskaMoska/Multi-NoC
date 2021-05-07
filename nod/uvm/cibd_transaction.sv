class cibd_transaction extends uvm_sequence_item;

    bit [2:0] srid_x,srid_y;
    rand bit [2:0] rtrid_x,rtrid_y,drid_x,drid_y;
    rand bit [3:0] scid,dcid;
    rand bit [127:0] payload[];

    `uvm_object_utils_begin(cibd_transaction)
        `uvm_field_int(rtrid_x,UVM_ALL_ON)
        `uvm_field_int(rtrid_y,UVM_ALL_ON)
        `uvm_field_int(srid_x,UVM_ALL_ON)
        `uvm_field_int(srid_y,UVM_ALL_ON)
        `uvm_field_int(drid_x,UVM_ALL_ON)
        `uvm_field_int(drid_y,UVM_ALL_ON)
        `uvm_field_int(scid,UVM_ALL_ON)
        `uvm_field_int(dcid,UVM_ALL_ON)
        `uvm_field_array_int(payload,UVM_ALL_ON)
    `uvm_object_utils_end


    function new(string name = "cibd_transaction");
        super.new(name);
    endfunction


    virtual function void pack(ref bit[129:0] data_q[$]);
        bit[129:0] temp_data;
        data_q = {}; //clear the queue
        temp_data = ((2'b00) << 128) | (this.rtrid_x << 23) | (this.rtrid_y << 20) |
                    (this.scid << 16) | (this.dcid << 12) | (this.srid_x << 9) |
                    (this.srid_y << 6) | (this.drid_x << 3) | this.drid_y; //head flit

        data_q.push_back(temp_data);
        for(int i = 0; i < this.payload.size(); i++)
        begin
            temp_data = ((2'b01)<<128) | this.payload[i]; //body flit
            data_q.push_back(temp_data);
        end
        data_q.push_back(((2'b10)<<128)|128'hFFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF_FFFF); //tail flit
    endfunction


    virtual function void unpack(ref bit[129:0] data_q[$]);
        int i = 0;
        bit[129:0] temp_data;
        temp_data = data_q.pop_front(); //head flit
        if(temp_data[129:128] != 2'b00)
            `uvm_error("cibd_monitor","the first received data is not head flit");
        
        this.rtrid_x = temp_data >> 23;
        this.rtrid_y = temp_data >> 20;
        this.scid    = temp_data >> 16;
        this.dcid    = temp_data >> 12;
        this.srid_x  = temp_data >> 9;
        this.srid_y  = temp_data >> 6;
        this.drid_x  = temp_data >> 3;
        this.drid_y  = temp_data;

        this.payload = new[data_q.size()-1];
        while(data_q.size() > 1)
        begin
            this.payload[i] = data_q.pop_front(); //body flit
            i++;
        end
        data_q.pop_front(); //tail flit
    endfunction


    constraint payload_const{
        payload.size inside {[1:`MAX_PKT_LEN-2]};
    }

    constraint id_const{
        rtrid_x inside {[0:4]}; //5*5 NoC
        rtrid_y inside {[0:4]}; //5*5 NoC
        if(rtrid_x == srid_x) rtrid_y != srid_y;
    }
endclass