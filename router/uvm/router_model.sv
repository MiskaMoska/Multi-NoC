class router_model extends uvm_component;

    `uvm_component_utils(router_model)

    uvm_blocking_get_port #(cibd_transaction) bp[5]; //TLM connect to driver
    uvm_analysis_port #(cibd_transaction) ap[5]; //TLM connect to scoreboard

    function new(string name = "router_model",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
            bp[0] = new("bp[0]",this); //TLM
            bp[1] = new("bp[1]",this); //TLM
            bp[2] = new("bp[2]",this); //TLM
            bp[3] = new("bp[3]",this); //TLM
            bp[4] = new("bp[4]",this); //TLM
            ap[0] = new("ap[0]",this); //TLM
            ap[1] = new("ap[1]",this); //TLM
            ap[2] = new("ap[2]",this); //TLM
            ap[3] = new("ap[3]",this); //TLM
            ap[4] = new("ap[4]",this); //TLM
    endfunction

    virtual task main_phase(uvm_phase phase);
        cibd_transaction tr[5];
        cibd_transaction new_tr[5];

        super.main_phase(phase);
        fork

            while(1) //west input port
            begin
                bp[0].get(tr[0]); 
                new_tr[0] = new("new_tr0");
                new_tr[0].copy(tr[0]);
                if(new_tr[0].rtrid_y > 2)
                    ap[1].write(new_tr[0]); //east output port
                else if(new_tr[0].rtrid_y == 2) begin
                    if(new_tr[0].rtrid_x > 2)
                        ap[3].write(new_tr[0]); //south output port
                    else if(new_tr[0].rtrid_x < 2)
                        ap[2].write(new_tr[0]); //north output port
                    else 
                        ap[4].write(new_tr[0]); //local output port
                end
                else begin
                    `uvm_fatal("router_model","illegal rtrid was given:west in cannot west out")
                    `uvm_info("router_model",{"\n",new_tr[0].sprint()},UVM_LOW)
                end
            end

            while(1) //east input port
            begin
                bp[1].get(tr[1]); 
                new_tr[1] = new("new_tr1");
                new_tr[1].copy(tr[1]);
                if(new_tr[1].rtrid_y < 2)
                    ap[0].write(new_tr[1]); //west output port
                else if(new_tr[1].rtrid_y == 2) begin
                    if(new_tr[1].rtrid_x > 2)
                        ap[3].write(new_tr[1]); //south output port
                    else if(new_tr[1].rtrid_x < 2)
                        ap[2].write(new_tr[1]); //north output port
                    else 
                        ap[4].write(new_tr[1]); //local output port
                end
                else begin
                    `uvm_fatal("router_model","illegal rtrid was given:east in cannot east out")
                    `uvm_info("router_model",{"\n",new_tr[1].sprint()},UVM_LOW)
                end
            end

            while(1) //north input port
            begin
                bp[2].get(tr[2]); 
                new_tr[2] = new("new_tr2");
                new_tr[2].copy(tr[2]);
                if(new_tr[2].rtrid_y == 2) begin
                    if(new_tr[2].rtrid_x > 2)
                        ap[3].write(new_tr[2]); //south output port
                    else if(new_tr[2].rtrid_x == 2)
                        ap[4].write(new_tr[2]); //local output port
                    else begin
                        `uvm_fatal("router_model","illegal rtrid was given:north in cannot north out")
                        `uvm_info("router_model",{"\n",new_tr[2].sprint()},UVM_LOW)
                    end
                end
                else begin
                    `uvm_fatal("router_model","illegal rtrid was given:north in y must == 2")
                    `uvm_info("router_model",{"\n",new_tr[2].sprint()},UVM_LOW)
                end
            end

            while(1) //south input port
            begin
                bp[3].get(tr[3]); 
                new_tr[3] = new("new_tr3");
                new_tr[3].copy(tr[3]);
                if(new_tr[3].rtrid_y == 2) begin
                    if(new_tr[3].rtrid_x < 2)
                        ap[2].write(new_tr[3]); //north output port
                    else if(new_tr[3].rtrid_x == 2)
                        ap[4].write(new_tr[3]); //local output port
                    else begin
                        `uvm_fatal("router_model","illegal rtrid was given:south in cannot south out")
                        `uvm_info("router_model",{"\n",new_tr[3].sprint()},UVM_LOW)
                    end
                end
                else begin
                    `uvm_fatal("router_model","illegal rtrid was given:south in y must == 2")
                    `uvm_info("router_model",{"\n",new_tr[3].sprint()},UVM_LOW)
                end
            end

            while(1) //local input port
            begin
                bp[4].get(tr[4]); 
                new_tr[4] = new("new_tr4");
                new_tr[4].copy(tr[4]);
                if(new_tr[4].rtrid_y > 2)
                    ap[1].write(new_tr[4]); //east output port
                else if(new_tr[4].rtrid_y < 2)
                    ap[0].write(new_tr[4]); //west output port
                else begin
                    if(new_tr[4].rtrid_x > 2)
                        ap[3].write(new_tr[4]); //south output port
                    else if(new_tr[4].rtrid_x < 2)
                        ap[2].write(new_tr[4]); //north output port
                    else 
                        ap[4].write(new_tr[4]); //local output port
                end
            end
        join

    endtask
endclass