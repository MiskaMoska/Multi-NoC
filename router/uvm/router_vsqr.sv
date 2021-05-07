class router_vsqr extends uvm_sequencer;
    
    cibd_sequencer p_sqr_w,p_sqr_e,p_sqr_n,p_sqr_s,p_sqr_l;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction 
    
    `uvm_component_utils(router_vsqr)
endclass