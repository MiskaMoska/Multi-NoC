class nod_latency extends uvm_component;

    `uvm_component_utils(nod_latency)

    uvm_blocking_get_port #(longint) inj_bp[]; //inject port 
    uvm_blocking_get_port #(longint) eje_bp[]; //eject port

    longint inj_sum;
    longint eje_sum;

    longint inj_num;
    longint eje_num;

    longint inj_time[];
    longint eje_time[];

    function new(string name,uvm_component parent);
        super.new(name,parent);
        inj_sum = 0;
        eje_sum = 0;
        inj_num = 0;
        eje_num = 0;
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        inj_bp = new[25];
        eje_bp = new[25];
        inj_time = new[25];
        eje_time = new[25];

        foreach(inj_bp[i])
            inj_bp[i] = new($sformatf("inj_bp[%0d]",i),this);

        foreach(eje_bp[i])
            eje_bp[i] = new($sformatf("eje_bp[%0d]",i),this);
    endfunction

    protected function void inj_add(input longint inj_item);
        inj_sum += inj_item;
        inj_num ++;
    endfunction

    protected function void eje_add(input longint eje_item);
        eje_sum += eje_item;
        eje_num ++;
    endfunction

    virtual task main_phase(uvm_phase phase);
        super.main_phase(phase);
        foreach(inj_bp[i_temp]) begin
            int i = i_temp;
            fork
                while(1) begin
                    inj_bp[i].get(inj_time[i]);
                    inj_add(inj_time[i]);
                end
            join_none
        end
        foreach(eje_bp[j_temp]) begin
            int j = j_temp;
            fork
                while(1) begin
                    eje_bp[j].get(eje_time[j]);
                    eje_add(eje_time[j]);
                end
            join_none
        end
    endtask

    virtual function void report_phase(uvm_phase phase);
        UVM_FILE file;
        super.report_phase(phase);
        if(inj_num != eje_num) begin
            `uvm_fatal("latency","the number of inject and eject packets do not match");
        end else begin
            real average_latency;
            average_latency = real'(eje_sum - inj_sum) / inj_num / 10;
            file = $fopen($sformatf("rate_%f_pktlen_%0d_fifodepth_%0d_.txt",`INJECT_RATE,`MAX_PKT_LEN,`FIFO_DEPTH),"w");
            $fwrite(file,"average_latency: %f\n",average_latency);
            $fwrite(file,"total number of packet: %d\n",eje_num);
            $fwrite(file,"total eject time sum: %d\n",eje_sum);
            $fwrite(file,"total inject time sum: %d\n", inj_sum);
            $fwrite(file,"total simulation time: %f\n", $time);
            $fclose(file);
        end
    endfunction
endclass