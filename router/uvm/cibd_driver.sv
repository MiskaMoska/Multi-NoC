class cibd_driver extends uvm_driver #(cibd_transaction);

    `uvm_component_utils(cibd_driver);

    virtual cibd_if drv_if;
    uvm_analysis_port #(cibd_transaction) ap; //TLM

    function new(string name = "cibd_driver",uvm_component parent = null);
        super.new(name,parent);
    endfunction


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual cibd_if)::get(this,"","vif",drv_if))
            `uvm_fatal("cibd_driver","virtual interface must be set for cibd_driver!!!");
        ap = new("ap",this);  //TLM
    endfunction


    virtual task main_phase(uvm_phase phase);
        // phase.raise_objection(this);
        `uvm_info("cibd_driver","main_phase is called",UVM_LOW);
        drv_if.data <= 130'b0;
        drv_if.valid <= 1'b0;

        while(!drv_if.rstn)
            @(posedge drv_if.clk);

        while(1)
        begin
            seq_item_port.get_next_item(req); //apply to sequencer for a transaction
            ap.write(req); //TLM driver to model
            drive_one_pkt(req);
            seq_item_port.item_done(); //confirm to sequenser 
        end
        // phase.drop_objection(this);
    endtask


    virtual task drive_one_pkt(cibd_transaction tr);
        bit [129:0] temp_data;
        bit [129:0] data_q[$];

        tr.pack(data_q);
        
        while(1) //wait for ready
        begin
            @(posedge drv_if.clk);
            if(drv_if.ready) break;
        end

        drv_if.valid <= 1'b1;

        while(1)
        begin
            if(drv_if.ready)
            begin
                temp_data = data_q.pop_front();
                drv_if.data <= temp_data; 
                if(temp_data[129:128] == 2'b10) //is tail flit
                    break;
            end
            @(posedge drv_if.clk);
        end

        while(1) //waiting for tail flit to finish transfer 
        begin
            @(posedge drv_if.clk);
            if(drv_if.ready)
            begin
                drv_if.valid <= 1'b0;
                break;
            end
        end

        `uvm_info("cibd_driver","finish driving one pkt",UVM_LOW);
        `uvm_info("cibd_driver",{"\n",tr.sprint()},UVM_LOW)

    endtask
endclass