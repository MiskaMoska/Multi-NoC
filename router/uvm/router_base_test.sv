class router_base_test extends uvm_test;

    router_env env;
    router_vsqr vsqr;

    `uvm_component_utils(router_base_test)

    function new(string name = "router_base_test",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = router_env::type_id::create("env",this);
        vsqr = router_vsqr::type_id::create("vsqr",this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        vsqr.p_sqr_w = env.i_agt[0].sqr;
        vsqr.p_sqr_e = env.i_agt[1].sqr;
        vsqr.p_sqr_n = env.i_agt[2].sqr;
        vsqr.p_sqr_s = env.i_agt[3].sqr;
        vsqr.p_sqr_l = env.i_agt[4].sqr;
    endfunction

endclass