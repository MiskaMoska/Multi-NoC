class nod_env extends uvm_env;

    `uvm_component_utils(nod_env)

    cibd_agent i_agt[];
    cibd_agent o_agt[];
    nod_model mdl;
    nod_scoreboard sb;
    nod_latency lat;

    uvm_tlm_analysis_fifo #(cibd_transaction) drv_mdl_fifo[]; //TLM
    uvm_tlm_analysis_fifo #(cibd_transaction) mdl_sb_fifo[]; //TLM
    uvm_tlm_analysis_fifo #(cibd_transaction) mon_sb_fifo[]; //TLM
    uvm_tlm_analysis_fifo #(longint) drv_lat_fifo[]; //TLM
    uvm_tlm_analysis_fifo #(longint) mon_lat_fifo[]; //TLM

    function new(string name = "nod_env",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        i_agt = new[25];
        o_agt = new[25];

        foreach(i_agt[i]) begin
            i_agt[i] = cibd_agent::type_id::create($sformatf("i_agt[%0d]",i),this);
            i_agt[i].is_active = UVM_ACTIVE;
        end
        foreach(o_agt[i]) begin
            o_agt[i] = cibd_agent::type_id::create($sformatf("o_agt[%0d]",i),this); 
            o_agt[i].is_active = UVM_PASSIVE;
        end

        `uvm_info("nod_env","all i_agts are built",UVM_LOW)
        `uvm_info("nod_env","all o_agts are built",UVM_LOW)
        
        mdl = nod_model::type_id::create("mdl",this);
        sb = nod_scoreboard::type_id::create("sb",this);
        lat = nod_latency::type_id::create("lat",this);

        `uvm_info("nod_env","mdl is built",UVM_LOW)
        `uvm_info("nod_env","sb is built",UVM_LOW)
        `uvm_info("nod_env","lat is built",UVM_LOW)

        drv_mdl_fifo = new[25];
        mdl_sb_fifo = new[25];
        mon_sb_fifo = new[25];
        drv_lat_fifo = new[25];
        mon_lat_fifo = new[25];
        
        foreach(drv_mdl_fifo[i])
            drv_mdl_fifo[i] = new($sformatf("drv_mdl_fifo[%0d]",i),this);

        foreach(mdl_sb_fifo[i])
            mdl_sb_fifo[i] = new($sformatf("mdl_sb_fifo[%0d]",i),this);

        foreach(mon_sb_fifo[i])
            mon_sb_fifo[i] = new($sformatf("mon_sb_fifo[%0d]",i),this);

        foreach(drv_lat_fifo[i])
            drv_lat_fifo[i] = new($sformatf("drv_lat_fifo[%0d]",i),this);

        foreach(mon_lat_fifo[i])
            mon_lat_fifo[i] = new($sformatf("mon_lat_fifo[%0d]",i),this);
    endfunction



    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        for(int i = 0; i < 25; i++)
        begin
            i_agt[i].tr_ap.connect(drv_mdl_fifo[i].analysis_export); 
            mdl.bp[i].connect(drv_mdl_fifo[i].blocking_get_export); 

            mdl.ap[i].connect(mdl_sb_fifo[i].analysis_export); 
            sb.exp_bp[i].connect(mdl_sb_fifo[i].blocking_get_export); 
            
            o_agt[i].tr_ap.connect(mon_sb_fifo[i].analysis_export); 
            sb.act_bp[i].connect(mon_sb_fifo[i].blocking_get_export); 

            i_agt[i].time_ap.connect(drv_lat_fifo[i].analysis_export);
            o_agt[i].time_ap.connect(mon_lat_fifo[i].analysis_export);

            lat.inj_bp[i].connect(drv_lat_fifo[i].blocking_get_export);
            lat.eje_bp[i].connect(mon_lat_fifo[i].blocking_get_export);
        end
    endfunction



    virtual function void final_phase(uvm_phase phase);
        super.final_phase(phase);
    endfunction
endclass