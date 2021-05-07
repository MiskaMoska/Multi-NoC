class router_env extends uvm_env;

    `uvm_component_utils(router_env)

    //0-west 1-east 2-north 3-south 4-local
    cibd_agent i_agt[5];
    cibd_agent o_agt[5];
    router_model mdl;
    router_scoreboard sb;

    uvm_tlm_analysis_fifo #(cibd_transaction) drv_mdl_fifo[5]; //TLM
    uvm_tlm_analysis_fifo #(cibd_transaction) mdl_sb_fifo[5]; //TLM
    uvm_tlm_analysis_fifo #(cibd_transaction) mon_sb_fifo[5]; //TLM

    UVM_FILE drv_w_log,drv_e_log,drv_n_log,drv_s_log,drv_l_log;
    UVM_FILE mon_w_log,mon_e_log,mon_n_log,mon_s_log,mon_l_log;
    UVM_FILE expect_w_log,expect_e_log,expect_n_log,expect_s_log,expect_l_log;
    UVM_FILE actual_w_log,actual_e_log,actual_n_log,actual_s_log,actual_l_log;
    UVM_FILE report_log;

    function new(string name = "router_env",uvm_component parent = null);
        super.new(name,parent);
    endfunction



    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        i_agt[0] = cibd_agent::type_id::create("i_agt[0]",this);
        i_agt[1] = cibd_agent::type_id::create("i_agt[1]",this);
        i_agt[2] = cibd_agent::type_id::create("i_agt[2]",this);
        i_agt[3] = cibd_agent::type_id::create("i_agt[3]",this);
        i_agt[4] = cibd_agent::type_id::create("i_agt[4]",this);
        o_agt[0] = cibd_agent::type_id::create("o_agt[0]",this);
        o_agt[1] = cibd_agent::type_id::create("o_agt[1]",this);
        o_agt[2] = cibd_agent::type_id::create("o_agt[2]",this);
        o_agt[3] = cibd_agent::type_id::create("o_agt[3]",this);
        o_agt[4] = cibd_agent::type_id::create("o_agt[4]",this);

        foreach(i_agt[i]) begin
            i_agt[i].is_active = UVM_ACTIVE;
        end
        foreach(o_agt[i]) begin
            o_agt[i].is_active = UVM_PASSIVE;
        end

        `uvm_info("router_env","all i_agts are built",UVM_LOW)
        `uvm_info("router_env","all o_agts are built",UVM_LOW)
        
        mdl = router_model::type_id::create("mdl",this);
        sb = router_scoreboard::type_id::create("sb",this);

        `uvm_info("cibd_env","mdl is built",UVM_LOW)
        `uvm_info("cibd_env","sb is built",UVM_LOW)

        drv_mdl_fifo[0] = new("drv_mdl_fifo[0]",this); //TLM
        drv_mdl_fifo[1] = new("drv_mdl_fifo[1]",this); //TLM
        drv_mdl_fifo[2] = new("drv_mdl_fifo[2]",this); //TLM
        drv_mdl_fifo[3] = new("drv_mdl_fifo[3]",this); //TLM
        drv_mdl_fifo[4] = new("drv_mdl_fifo[4]",this); //TLM

        mdl_sb_fifo[0] = new("mdl_sb_fifo[0]",this); //TLM
        mdl_sb_fifo[1] = new("mdl_sb_fifo[1]",this); //TLM
        mdl_sb_fifo[2] = new("mdl_sb_fifo[2]",this); //TLM
        mdl_sb_fifo[3] = new("mdl_sb_fifo[3]",this); //TLM
        mdl_sb_fifo[4] = new("mdl_sb_fifo[4]",this); //TLM

        mon_sb_fifo[0] = new("mon_sb_fifo[0]",this); //TLM
        mon_sb_fifo[1] = new("mon_sb_fifo[1]",this); //TLM
        mon_sb_fifo[2] = new("mon_sb_fifo[2]",this); //TLM
        mon_sb_fifo[3] = new("mon_sb_fifo[3]",this); //TLM
        mon_sb_fifo[4] = new("mon_sb_fifo[4]",this); //TLM

    endfunction



    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        for(int i = 0; i < 5; i++)
        begin
            i_agt[i].ap.connect(drv_mdl_fifo[i].analysis_export); //TLM
            mdl.bp[i].connect(drv_mdl_fifo[i].blocking_get_export); //TLM

            mdl.ap[i].connect(mdl_sb_fifo[i].analysis_export); //TLM
            sb.exp_bp[i].connect(mdl_sb_fifo[i].blocking_get_export); //TLM
            
            o_agt[i].ap.connect(mon_sb_fifo[i].analysis_export); //TLM
            sb.act_bp[i].connect(mon_sb_fifo[i].blocking_get_export); //TLM
        end

        drv_w_log = $fopen("drv_w_log","w");
        drv_e_log = $fopen("drv_e_log","w");
        drv_n_log = $fopen("drv_n_log","w");
        drv_s_log = $fopen("drv_s_log","w");
        drv_l_log = $fopen("drv_l_log","w");
        mon_w_log = $fopen("mon_w_log","w");
        mon_e_log = $fopen("mon_e_log","w");
        mon_n_log = $fopen("mon_n_log","w");
        mon_s_log = $fopen("mon_s_log","w");
        mon_l_log = $fopen("mon_l_log","w");
        expect_w_log = $fopen("expect_w","w");
        expect_e_log = $fopen("expect_e","w");
        expect_n_log = $fopen("expect_n","w");
        expect_s_log = $fopen("expect_s","w");
        expect_l_log = $fopen("expect_l","w");
        actual_w_log = $fopen("actual_w","w");
        actual_e_log = $fopen("actual_e","w");
        actual_n_log = $fopen("actual_n","w");
        actual_s_log = $fopen("actual_s","w");
        actual_l_log = $fopen("actual_l","w");
        report_log = $fopen("report_log","w");

        this.i_agt[0].drv.set_report_severity_file_hier(UVM_INFO, drv_w_log);
        this.i_agt[1].drv.set_report_severity_file_hier(UVM_INFO, drv_e_log);
        this.i_agt[2].drv.set_report_severity_file_hier(UVM_INFO, drv_n_log);
        this.i_agt[3].drv.set_report_severity_file_hier(UVM_INFO, drv_s_log);
        this.i_agt[4].drv.set_report_severity_file_hier(UVM_INFO, drv_l_log);
        this.o_agt[0].mon.set_report_severity_file_hier(UVM_INFO, mon_w_log);
        this.o_agt[1].mon.set_report_severity_file_hier(UVM_INFO, mon_e_log);
        this.o_agt[2].mon.set_report_severity_file_hier(UVM_INFO, mon_n_log);
        this.o_agt[3].mon.set_report_severity_file_hier(UVM_INFO, mon_s_log);
        this.o_agt[4].mon.set_report_severity_file_hier(UVM_INFO, mon_l_log);
        this.sb.set_report_id_file("expect_w",expect_w_log);
        this.sb.set_report_id_file("expect_e",expect_e_log);
        this.sb.set_report_id_file("expect_n",expect_n_log);
        this.sb.set_report_id_file("expect_s",expect_s_log);
        this.sb.set_report_id_file("expect_l",expect_l_log);
        this.sb.set_report_id_file("actual_w",actual_w_log);
        this.sb.set_report_id_file("actual_e",actual_e_log);
        this.sb.set_report_id_file("actual_n",actual_n_log);
        this.sb.set_report_id_file("actual_s",actual_s_log);
        this.sb.set_report_id_file("actual_l",actual_l_log);
        this.sb.set_report_id_file("router_scoreboard",report_log);

        this.i_agt[0].drv.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        this.i_agt[1].drv.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        this.i_agt[2].drv.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        this.i_agt[3].drv.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        this.i_agt[4].drv.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        this.o_agt[0].mon.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        this.o_agt[1].mon.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        this.o_agt[2].mon.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        this.o_agt[3].mon.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        this.o_agt[4].mon.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        this.sb.set_report_id_action("expect_w",UVM_DISPLAY | UVM_LOG);
        this.sb.set_report_id_action("expect_e",UVM_DISPLAY | UVM_LOG);
        this.sb.set_report_id_action("expect_n",UVM_DISPLAY | UVM_LOG);
        this.sb.set_report_id_action("expect_s",UVM_DISPLAY | UVM_LOG);
        this.sb.set_report_id_action("expect_l",UVM_DISPLAY | UVM_LOG);
        this.sb.set_report_id_action("actual_w",UVM_DISPLAY | UVM_LOG);
        this.sb.set_report_id_action("actual_e",UVM_DISPLAY | UVM_LOG);
        this.sb.set_report_id_action("actual_n",UVM_DISPLAY | UVM_LOG);
        this.sb.set_report_id_action("actual_s",UVM_DISPLAY | UVM_LOG);
        this.sb.set_report_id_action("actual_l",UVM_DISPLAY | UVM_LOG);
        this.sb.set_report_id_action("router_scoreboard",UVM_DISPLAY | UVM_LOG);
    endfunction

    // virtual task main_phase(uvm_phase phase); 
    //     start sequence,if it is started in top_tb,this code is not needed
    //     cibd_sequence seq;
    //     phase.raise_objection(this);
    //     seq = cibd_sequence::type_id::create("seq"); //sequence is newed in main phase
    //     seq.start(i_agt.sqr); //tell sequence to send transaction to which sequencer
    //     phase.drop_objection(this);
    // endtask

    virtual function void final_phase(uvm_phase phase);
        super.final_phase(phase);
        $fclose(drv_w_log);
        $fclose(drv_e_log);
        $fclose(drv_n_log);
        $fclose(drv_s_log);
        $fclose(drv_l_log);
        $fclose(mon_w_log);
        $fclose(mon_e_log);
        $fclose(mon_n_log);
        $fclose(mon_s_log);
        $fclose(mon_l_log);
        $fclose(expect_w_log);
        $fclose(expect_e_log);
        $fclose(expect_n_log);
        $fclose(expect_s_log);
        $fclose(expect_l_log);
        $fclose(actual_w_log);
        $fclose(actual_e_log);
        $fclose(actual_n_log);
        $fclose(actual_s_log);
        $fclose(actual_l_log);
        $fclose(report_log);
    endfunction
endclass