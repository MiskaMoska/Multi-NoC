class queue;
    cibd_transaction q[$];
endclass

class nod_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(nod_scoreboard)

    queue matrix_act[];
    queue matrix_exp[];
    queue matrix_cover[];

    cibd_transaction get_exp[];
    cibd_transaction get_act[];

    uvm_blocking_get_port #(cibd_transaction) act_bp[];
    uvm_blocking_get_port #(cibd_transaction) exp_bp[];

    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        act_bp = new[25];
        exp_bp = new[25];
        get_act = new[25];
        get_exp = new[25];
        matrix_act = new[25];
        matrix_exp = new[25];
        matrix_cover = new[25];

        foreach(matrix_act[i]) begin
            matrix_act[i] = new();
        end

        foreach(matrix_exp[i]) begin
            matrix_exp[i] = new();
        end

        foreach(matrix_cover[i]) begin
            matrix_cover[i] = new();
        end
        
        foreach(act_bp[i]) begin
            act_bp[i] = new($sformatf("act_bp[%0d]",i),this);
        end

        foreach(exp_bp[i]) begin
            exp_bp[i] = new($sformatf("exp_bp[%0d]",i),this);
        end

        foreach(get_act[i]) begin
            get_act[i] = new($sformatf("get_act[%0d]",i));
        end

        foreach(get_exp[i]) begin
            get_exp[i] = new($sformatf("get_exp[%0d]",i));
        end
    endfunction

    protected function void act_queue_push(input cibd_transaction trans,input int port);
        matrix_act[port].q.push_back(trans);
    endfunction

    protected function void exp_queue_push(input cibd_transaction trans,input int port);
        matrix_exp[port].q.push_back(trans);
    endfunction

    protected function void cover_queue_try_push(input cibd_transaction trans,input int port);
        bit flag = 0;
        foreach(matrix_cover[port].q[i]) begin
            if(trans.srid_x == matrix_cover[port].q[i].srid_x) begin
                if(trans.srid_y == matrix_cover[port].q[i].srid_y) begin
                    flag = 1;
                end
            end
        end
        if(flag == 0)
            matrix_cover[port].q.push_back(trans);
    endfunction

    protected function int count_coverage(); 
        int sum = 0;
        foreach(matrix_cover[i]) begin
            sum += matrix_cover[i].q.size();
        end
        return sum;
    endfunction

    virtual task main_phase(uvm_phase phase);
        UVM_FILE coverage;
        super.main_phase(phase);
        coverage = $fopen($sformatf("rate_%0f_coverage_log",`INJECT_RATE),"w");
        foreach(exp_bp[i_item]) begin
            int i = i_item;
            fork
                while(1) begin
                    exp_bp[i].get(get_exp[i]);
                    exp_queue_push(get_exp[i],i);
                    cover_queue_try_push(get_exp[i],i);
                end
            join_none
        end
        foreach(act_bp[i_item]) begin
            int i = i_item;
            fork
                while(1) begin
                    act_bp[i].get(get_act[i]);
                    act_queue_push(get_act[i],i);
                end
            join_none
        end

        fork
            while(1) begin
                #`COVER_CYCLE 
                $fwrite(coverage,"%0d,",count_coverage());
            end
        join
        $fclose(coverage);
    endtask

    function int test_check();
        for(int port = 0; port < 25; port ++) begin
            for(int act = 0; act < matrix_act[port].q.size(); act++) begin
                for(int exp = 0; exp < matrix_exp[port].q.size(); exp ++) begin
                    if(matrix_exp[port].q[exp].compare(matrix_act[port].q[act])) begin
                        matrix_exp[port].q.delete(exp);
                        break;
                    end
                end
            end
        end

        for(int port = 0; port < 25; port ++) begin
            if(matrix_exp[port].q.size() > 0)
                return 0;
        end
        return 1;
    endfunction

    virtual function void report_phase(uvm_phase phase);
        UVM_FILE scoreboard;
        super.report_phase(phase);
        scoreboard = $fopen("scoreborad_log","w");
        if(test_check()) begin
            $fwrite(scoreboard,"compare successfully");
        end else begin
            $fwrite(scoreboard,"compare failed");
        end
        $fclose(scoreboard);
    endfunction
endclass