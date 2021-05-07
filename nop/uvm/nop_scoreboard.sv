class queue;
    cibd_transaction q[$];
endclass

class nop_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(nop_scoreboard)

    queue matrix_act[];
    queue matrix_exp[];

    cibd_transaction get_exp[];
    cibd_transaction get_act[];

    uvm_blocking_get_port #(cibd_transaction) act_bp[];
    uvm_blocking_get_port #(cibd_transaction) exp_bp[];

    longint latency[$];
    int pkt_type[$]; //0:in 1:out1 2:out2

    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction

    protected function bit assert_port(input int i);
        if(i == 10 || i == 14 || i == 35 || i == 39 || i == 60 || i == 64)
            return 0;
        return 1;
    endfunction

    virtual function void build_phase(uvm_phase phase);
        act_bp = new[75];
        exp_bp = new[75];
        get_act = new[75];
        get_exp = new[75];
        matrix_act = new[75];
        matrix_exp = new[75];

        foreach(matrix_act[i]) begin
            if(assert_port(i))
                matrix_act[i] = new();
        end

        foreach(matrix_exp[i]) begin
            if(assert_port(i))
                matrix_exp[i] = new();
        end
        
        foreach(act_bp[i]) begin
            if(assert_port(i))
                act_bp[i] = new($sformatf("act_bp[%0d]",i),this);
        end

        foreach(exp_bp[i]) begin
            if(assert_port(i))
                exp_bp[i] = new($sformatf("exp_bp[%0d]",i),this);
        end

        foreach(get_act[i]) begin
            if(assert_port(i))
                get_act[i] = new($sformatf("get_act[%0d]",i));
        end

        foreach(get_exp[i]) begin
            if(assert_port(i))
                get_exp[i] = new($sformatf("get_exp[%0d]",i));
        end
    endfunction


    protected function void act_queue_push(input cibd_transaction trans,input int port);
        matrix_act[port].q.push_back(trans);
    endfunction

    protected function void exp_queue_push(input cibd_transaction trans,input int port);
        matrix_exp[port].q.push_back(trans);
    endfunction

    virtual task main_phase(uvm_phase phase);
        super.main_phase(phase);

        foreach(exp_bp[i_item]) begin
            int i = i_item;
            if(assert_port(i)) begin
                fork
                    while(1) begin
                        exp_bp[i].get(get_exp[i]);
                        exp_queue_push(get_exp[i],i);
                    end
                join_none
            end
        end
        foreach(act_bp[i_item]) begin
            int i = i_item;
            if(assert_port(i)) begin
                fork
                    while(1) begin
                        act_bp[i].get(get_act[i]);
                        act_queue_push(get_act[i],i);
                    end
                join_none
            end
        end
    endtask

    function int test_check();
        for(int port = 0; port < 75; port ++) begin
            if(assert_port(port)) begin
                for(int act = 0; act < matrix_act[port].q.size(); act++) begin
                    for(int exp = 0; exp < matrix_exp[port].q.size(); exp ++) begin
                        if(matrix_exp[port].q[exp].compare_payload(matrix_act[port].q[act])) begin
                            matrix_exp[port].q.delete(exp);
                            break;
                        end
                    end
                end              
            end
        end

        for(int port = 0; port < 75; port ++) begin
            if(assert_port(port)) begin
                if(matrix_exp[port].q.size() > 0)
                    return 0;
            end
        end
        return 1;
    endfunction

    virtual function void report_phase(uvm_phase phase);
        UVM_FILE scoreboard,latency_log;
        int sum_inside = 0,sum_outside_1 = 0,sum_outside_2 = 0;
        int lat_av,lat_av_0,lat_av_1,lat_av_2;
        int lat_sum=0,lat_sum_0=0,lat_sum_1=0,lat_sum_2=0;
        int lat_num=0,lat_num_0=0,lat_num_1=0,lat_num_2=0;
        int lat_max=0,lat_max_0=0,lat_max_1=0,lat_max_2=0;
        int lat_min=10000000,lat_min_0=10000000,lat_min_1=10000000,lat_min_2=10000000;
        super.report_phase(phase);
        scoreboard = $fopen("scoreborad_log","w");
        latency_log = $fopen($sformatf("pcycle_%0d_bypass_%0d_rate_%f_asyncfifo_%0d",
                            `CP_CYCLE,`IS_BYPASS,`INJECT_RATE,`ASYNC_FIFO_DEPTH_LOG),"w");
        $fwrite(latency_log,$sformatf("the clock cycle of CDCLK is always 10\nthe clock cycle of CPCLK is %0d\nbypass_ctrl is %0d(0:disable bypass channel,1:enable bypass channel)\ninjecting rate is %f\nthe depth_log of the async_fifo in portcontroller is %0d\n\n\n",
                            `CP_CYCLE,`IS_BYPASS,`INJECT_RATE,`ASYNC_FIFO_DEPTH_LOG));
        //get latency
        for(int i = 0; i < 75; i++) begin
            if(assert_port(i)) begin
                for(int j = 0; j < matrix_exp[i].q.size(); j++) begin
                    for(int k = 0; k < matrix_act[i].q.size(); k++) begin
                        if(matrix_exp[i].q[j].compare_payload(matrix_act[i].q[k])) begin
                            latency.push_back(matrix_act[i].q[k].eje_time - matrix_exp[i].q[j].inj_time);
                            if(!matrix_exp[i].q[j].is_out) 
                                pkt_type.push_back(0);
                            else if(matrix_exp[i].q[j].dcid == 2 && matrix_exp[i].q[j].scid == 0) 
                                pkt_type.push_back(2);
                            else if(matrix_exp[i].q[j].dcid == 0 && matrix_exp[i].q[j].scid == 2) 
                                pkt_type.push_back(2);
                            else 
                                pkt_type.push_back(1);
                        end
                    end
                end
            end
        end

        //caclulate average latency
        for(int i = 0; i < latency.size(); i++) begin
            lat_num ++;lat_sum += latency[i];
            if(latency[i] > lat_max) lat_max = latency[i];
            if(latency[i] < lat_min) lat_min = latency[i];
            if(pkt_type[i] == 0) begin
                lat_num_0 ++;lat_sum_0 += latency[i];
                if(latency[i] > lat_max_0) lat_max_0 = latency[i];
                if(latency[i] < lat_min_0) lat_min_0 = latency[i];
            end else if(pkt_type[i] == 1) begin
                lat_num_1 ++;lat_sum_1 += latency[i];
                if(latency[i] > lat_max_1) lat_max_1 = latency[i];
                if(latency[i] < lat_min_1) lat_min_1 = latency[i];
            end else if(pkt_type[i] == 2) begin
                lat_num_2 ++;lat_sum_2 += latency[i];
                if(latency[i] > lat_max_2) lat_max_2 = latency[i];
                if(latency[i] < lat_min_2) lat_min_2 = latency[i];
            end
        end
        lat_max = lat_max / `CD_CYCLE;
        lat_max_0 = lat_max_0 / `CD_CYCLE;
        lat_max_1 = lat_max_1 / `CD_CYCLE;
        lat_max_2 = lat_max_2 / `CD_CYCLE;
        lat_min = lat_min / `CD_CYCLE;
        lat_min_0 = lat_min_0 / `CD_CYCLE;
        lat_min_1 = lat_min_1 / `CD_CYCLE;
        lat_min_2 = lat_min_2 / `CD_CYCLE;
        lat_av = lat_sum / lat_num / `CD_CYCLE;
        lat_av_0 = lat_sum_0 / lat_num_0 / `CD_CYCLE;
        lat_av_1 = lat_sum_1 / lat_num_1 / `CD_CYCLE;
        lat_av_2 = lat_sum_2 / lat_num_2 / `CD_CYCLE;

        $fwrite(latency_log,$sformatf("lat_av:      %0d\t lat_max:   %0d\t lat_min:    %0d\t\n",lat_av,lat_max,lat_min));
        $fwrite(latency_log,$sformatf("lat_av_0:    %0d\t lat_max_0: %0d\t lat_min_0:  %0d\t\n",lat_av_0,lat_max_0,lat_min_0));
        $fwrite(latency_log,$sformatf("lat_av_1:    %0d\t lat_max_1: %0d\t lat_min_1:  %0d\t\n",lat_av_1,lat_max_1,lat_min_1));
        $fwrite(latency_log,$sformatf("lat_av_2:    %0d\t lat_max_2: %0d\t lat_min_2:  %0d\t\n",lat_av_2,lat_max_2,lat_min_2));
        $fwrite(latency_log,$sformatf("total %0d packets; %0d inside pakets; %0d out1 packets; %0d out2 packets\n",
                                                lat_num,lat_num_0,lat_num_1,lat_num_2));

        //caluculate the mumber of actual/expect packets of each port
        for(int i = 0; i < 75; i++) begin
            if(assert_port(i)) begin
                $fwrite(scoreboard,$sformatf("port %0d: %0d actual packets,%0d expect packets\n",
                                                i,matrix_act[i].q.size(),matrix_exp[i].q.size()));
            end
        end

        //check if all packets transferred accurately
        if(test_check()) begin
            $fwrite(scoreboard,"compare successfully");
        end else begin
            $fwrite(scoreboard,"compare failed");
        end
        $fclose(scoreboard);
        $fclose(latency_log);
    endfunction
endclass