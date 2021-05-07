class cibd_agent extends uvm_agent;

    `uvm_component_utils(cibd_agent)

    cibd_driver     drv;
    cibd_monitor    mon;
    cibd_sequencer  sqr;

    uvm_analysis_port #(cibd_transaction) tr_ap; //TLM 

    function new(string name = "cibd_agent",uvm_component parent = null);
        super.new(name,parent);
    endfunction


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(is_active == UVM_ACTIVE) //i_agt
        begin
            drv = cibd_driver::type_id::create("drv",this);
            sqr = cibd_sequencer::type_id::create("sqr",this);
            `uvm_info("cibd_agent","i_agt.driver is built",UVM_LOW)
            `uvm_info("cibd_agent","i_agt.sequencer is built",UVM_LOW)
        end
        else //o_agt
        begin
            mon = cibd_monitor::type_id::create("mon",this);
            `uvm_info("cibd_agent","o_agt.monitor is built",UVM_LOW)
        end
    endfunction


    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(is_active == UVM_ACTIVE) //i_agt
        begin
            drv.seq_item_port.connect(sqr.seq_item_export);
            tr_ap = drv.tr_ap;
        end
        else //o_agt
        begin
            tr_ap = mon.tr_ap; 
        end
        
    endfunction

endclass