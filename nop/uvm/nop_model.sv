class nop_model extends uvm_component;

    `uvm_component_utils(nop_model)

    uvm_blocking_get_port #(cibd_transaction) bp[]; //TLM connect to driver
    uvm_analysis_port #(cibd_transaction) ap[]; //TLM connect to scoreboard

    cibd_transaction rx[];

    function new(string name = "nop_model",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    protected function bit assert_port(input int i);
        if(i == 10 || i == 14 || i == 35 || i == 39 || i == 60 || i == 64)
            return 0;
        return 1;
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        bp = new[75];
        ap = new[75];
        rx = new[75];
        for(int i = 0; i < 75; i++) begin
            if(assert_port(i)) begin
                bp[i] = new($sformatf("bp[%0d]",i),this);
                ap[i] = new($sformatf("ap[%0d]",i),this);
                rx[i] = new($sformatf("rx[%0d]",i));
            end
        end
    endfunction

    protected function void fire(input cibd_transaction trans);
        `uvm_info("model",$sformatf("%0d,%0d,%0d,%0d,%0d,%0d",
                trans.scid,trans.dcid,trans.rtrid_x,trans.rtrid_y,trans.drid_x,trans.drid_y),UVM_LOW)
        if(trans.is_out == 1) begin
            ap[trans.dcid * 25 + trans.drid_x * 5 + trans.drid_y].write(trans);
        end else begin
            ap[trans.dcid * 25 + trans.rtrid_x * 5 + trans.rtrid_y].write(trans);
        end
        
    endfunction 

    virtual task main_phase(uvm_phase phase);
        super.main_phase(phase);
        foreach(bp[i_item]) begin
            int i = i_item;
            if(assert_port(i)) begin
                fork
                    while(1) begin
                        bp[i].get(rx[i]);
                        fire(rx[i]);
                    end
                join_none
            end
        end
    endtask
endclass