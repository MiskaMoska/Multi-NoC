class cibd_monitor extends uvm_monitor;

    virtual cibd_if mon_if;
    uvm_analysis_port #(cibd_transaction) tr_ap; //TLM
    uvm_analysis_port #(longint) time_ap; //TLM

    `uvm_component_utils(cibd_monitor)  

    function new(string name = "cibd_monitor",uvm_component parent = null);
        super.new(name,parent);
    endfunction


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual cibd_if)::get(this,"","vif",mon_if))
            `uvm_fatal("cibd_monitor","virtual interface must be set for cibd_if!!!");
        tr_ap = new("tr_ap",this);  
        time_ap = new("time_ap",this);
    endfunction


    virtual task main_phase(uvm_phase phase);
        cibd_transaction tr;
        // phase.raise_objection(this);
        mon_if.ready <= 1'b0;

        while(!mon_if.rstn)
            @(posedge mon_if.clk);

        while(1)
        begin
            tr = new("tr");
            collect_one_pkt(tr);
            tr_ap.write(tr); //TLM monitor to scoreboard
        end
        // phase.drop_objection(this);
    endtask


    virtual task collect_one_pkt(cibd_transaction tr);
        bit [129:0] data_q[$];
        longint time_temp;

        @(posedge mon_if.clk)
            mon_if.ready <= 1'b1;

        while(1)
        begin
            @(posedge mon_if.clk);
            if(mon_if.valid) break;
        end

        if(mon_if.data[129:128] != 2'b00) //not a head flit
            `uvm_error("cibd_monitor","the first flit received is not a head flit");

        while(1)
        begin
            if(mon_if.valid)
            begin
                data_q.push_back(mon_if.data);
                if(mon_if.data[129:128] == 2'b10) //is tail flit
                begin
                    mon_if.ready <= 1'b0;
                    break;
                end
            end
            @(posedge mon_if.clk);
        end

        time_temp = $time;
        time_ap.write(time_temp);
        tr.unpack(data_q);
        // `uvm_info("cibd_monitor","finish collecting one pkt",UVM_LOW);
        // `uvm_info("cibd_monitor",{"received transaction:\n",tr.sprint()},UVM_LOW)
    endtask
endclass