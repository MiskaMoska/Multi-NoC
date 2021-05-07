//--------------------------------------------------------------
//
//                       5 sequences
//
//--------------------------------------------------------------
//sequence for router west input port
class drv0_seq extends uvm_sequence #(cibd_transaction);
    cibd_transaction trans;
    `uvm_object_utils(drv0_seq)

    function new(string name= "drv0_seq");
        super.new(name);
    endfunction 
    
    virtual task body();
        repeat (100) begin
            `uvm_do_with(trans,{trans.rtrid_y >= 2;})
            `uvm_info("drv0_seq", "send one transaction", UVM_LOW)
        end
    endtask
endclass


//sequence for router east input port
class drv1_seq extends uvm_sequence #(cibd_transaction);
    cibd_transaction trans;
    `uvm_object_utils(drv1_seq)

    function new(string name= "drv1_seq");
        super.new(name);
    endfunction 
    
    virtual task body();
        repeat (100) begin
            `uvm_do_with(trans,{trans.rtrid_y <= 2;})
            `uvm_info("drv1_seq", "send one transaction", UVM_LOW)
        end
    endtask
endclass


//sequence for router north input port
class drv2_seq extends uvm_sequence #(cibd_transaction);
    cibd_transaction trans;
    `uvm_object_utils(drv2_seq)

    function new(string name= "drv2_seq");
        super.new(name);
    endfunction 
    
    virtual task body();
        repeat (100) begin
            `uvm_do_with(trans,{trans.rtrid_x >= 2; 
                                trans.rtrid_y == 2;})
            `uvm_info("drv2_seq", "send one transaction", UVM_LOW)
        end
    endtask
endclass


//sequence for router south input port
class drv3_seq extends uvm_sequence #(cibd_transaction);
    cibd_transaction trans;
    `uvm_object_utils(drv3_seq)

    function new(string name= "drv3_seq");
        super.new(name);
    endfunction 
    
    virtual task body();
        repeat (100) begin
            `uvm_do_with(trans,{trans.rtrid_x <= 2; 
                                trans.rtrid_y == 2;})
            `uvm_info("drv3_seq", "send one transaction", UVM_LOW)
        end
    endtask
endclass


//sequence for router local input port
class drv4_seq extends uvm_sequence #(cibd_transaction);
    cibd_transaction trans;
    `uvm_object_utils(drv4_seq)

    function new(string name= "drv4_seq");
        super.new(name);
    endfunction 
    
    virtual task body();
        repeat (100) begin
            `uvm_do(trans)
            `uvm_info("drv4_seq", "send one transaction", UVM_LOW)
        end
    endtask
endclass



//--------------------------------------------------------------
//
//                 virtual sequence for case 0
//
//--------------------------------------------------------------
class router_case0_vseq extends uvm_sequence;
    `uvm_object_utils(router_case0_vseq)
    `uvm_declare_p_sequencer(router_vsqr)

    function new(string name = "router_case0_vseq");
        super.new(name);
    endfunction

    virtual task body();
        cibd_transaction tr;
        drv0_seq seq0;
        drv1_seq seq1;
        drv2_seq seq2;
        drv3_seq seq3;
        drv4_seq seq4;
        if(starting_phase != null) 
            starting_phase.raise_objection(this);
        fork
            `uvm_do_on(seq0, p_sequencer.p_sqr_w)
            `uvm_do_on(seq1, p_sequencer.p_sqr_e)
            `uvm_do_on(seq2, p_sequencer.p_sqr_n)
            `uvm_do_on(seq3, p_sequencer.p_sqr_s)
            `uvm_do_on(seq4, p_sequencer.p_sqr_l)
        join 
        #100;
        if(starting_phase != null) 
            starting_phase.drop_objection(this);
    endtask
endclass



//--------------------------------------------------------------
//
//                        test case0
//
//--------------------------------------------------------------
class router_case0 extends router_base_test;

    `uvm_component_utils(router_case0)
    
    function new(string name = "router_case0", uvm_component parent = null);
        super.new(name,parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(uvm_object_wrapper)::set(this, 
                                            "vsqr.main_phase", 
                                            "default_sequence", 
                                            router_case0_vseq::type_id::get());
    endfunction

endclass
