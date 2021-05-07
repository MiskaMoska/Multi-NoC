class nop_env extends uvm_env;

    `uvm_component_utils(nop_env)

    cibd_agent i_agt[];
    cibd_agent o_agt[];
    nop_model mdl;
    nop_scoreboard sb;

    uvm_tlm_analysis_fifo #(cibd_transaction) drv_mdl_fifo[]; //TLM
    uvm_tlm_analysis_fifo #(cibd_transaction) mdl_sb_fifo[]; //TLM
    uvm_tlm_analysis_fifo #(cibd_transaction) mon_sb_fifo[]; //TLM

    function new(string name = "nop_env",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    protected function bit assert_port(input int i);
        if(i == 10 || i == 14 || i == 35 || i == 39 || i == 60 || i == 64)
            return 0;
        return 1;
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        i_agt = new[75];
        o_agt = new[75];

        foreach(i_agt[i]) begin
            if(assert_port(i)) begin
                i_agt[i] = cibd_agent::type_id::create($sformatf("i_agt[%0d]",i),this);
                i_agt[i].is_active = UVM_ACTIVE;
            end
        end
        foreach(o_agt[i]) begin
            if(assert_port(i)) begin
                o_agt[i] = cibd_agent::type_id::create($sformatf("o_agt[%0d]",i),this); 
                o_agt[i].is_active = UVM_PASSIVE;
            end
        end

        `uvm_info("nop_env","all i_agts are built",UVM_LOW)
        `uvm_info("nop_env","all o_agts are built",UVM_LOW)
        
        mdl = nop_model::type_id::create("mdl",this);
        sb = nop_scoreboard::type_id::create("sb",this);

        `uvm_info("nop_env","mdl is built",UVM_LOW)
        `uvm_info("nop_env","sb is built",UVM_LOW)

        drv_mdl_fifo = new[75];
        mdl_sb_fifo = new[75];
        mon_sb_fifo = new[75];
        
        foreach(drv_mdl_fifo[i])
            if(assert_port(i)) begin
                drv_mdl_fifo[i] = new($sformatf("drv_mdl_fifo[%0d]",i),this);
            end

        foreach(mdl_sb_fifo[i])
            if(assert_port(i)) begin
                mdl_sb_fifo[i] = new($sformatf("mdl_sb_fifo[%0d]",i),this);
            end

        foreach(mon_sb_fifo[i])
            if(assert_port(i)) begin
                mon_sb_fifo[i] = new($sformatf("mon_sb_fifo[%0d]",i),this);
            end
    endfunction



    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        for(int i = 0; i < 75; i++)
        begin
            if(assert_port(i)) begin
                i_agt[i].tr_ap.connect(drv_mdl_fifo[i].analysis_export); 
                mdl.bp[i].connect(drv_mdl_fifo[i].blocking_get_export); 

                mdl.ap[i].connect(mdl_sb_fifo[i].analysis_export); 
                sb.exp_bp[i].connect(mdl_sb_fifo[i].blocking_get_export); 
                
                o_agt[i].tr_ap.connect(mon_sb_fifo[i].analysis_export); 
                sb.act_bp[i].connect(mon_sb_fifo[i].blocking_get_export);                 
            end
        end
    endfunction


    virtual function void final_phase(uvm_phase phase);
        super.final_phase(phase);
    endfunction
endclass