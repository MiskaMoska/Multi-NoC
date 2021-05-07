class nod_model extends uvm_component;

    `uvm_component_utils(nod_model)

    uvm_blocking_get_port #(cibd_transaction) bp[]; //TLM connect to driver
    uvm_analysis_port #(cibd_transaction) ap[]; //TLM connect to scoreboard

    cibd_transaction rx[];

    function new(string name = "nod_model",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        bp = new[25];
        ap = new[25];
        rx = new[25];
        foreach(bp[i])
            bp[i] = new($sformatf("bp[%0d]",i),this);
        foreach(ap[i])
            ap[i] = new($sformatf("ap[%0d]",i),this);
        foreach(rx[i])
            rx[i] = new($sformatf("rx[%0d]",i));
    endfunction

    protected function void fire(input cibd_transaction trans);
        ap[trans.rtrid_x * 5 + trans.rtrid_y].write(trans);
    endfunction 

    virtual task main_phase(uvm_phase phase);
        super.main_phase(phase);
        foreach(bp[i_item]) begin
            int i = i_item;
            fork
                while(1) begin
                    bp[i].get(rx[i]);
                    fire(rx[i]);
                end
            join_none
        end
    endtask
endclass