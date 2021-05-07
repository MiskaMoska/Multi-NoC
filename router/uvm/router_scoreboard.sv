class router_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(router_scoreboard)

    cibd_transaction expect_queue_w[$];
    cibd_transaction expect_queue_e[$];
    cibd_transaction expect_queue_n[$];
    cibd_transaction expect_queue_s[$];
    cibd_transaction expect_queue_l[$];

    cibd_transaction actual_queue_w[$];
    cibd_transaction actual_queue_e[$];
    cibd_transaction actual_queue_n[$];
    cibd_transaction actual_queue_s[$];
    cibd_transaction actual_queue_l[$];

    uvm_blocking_get_port #(cibd_transaction) exp_bp[5]; //TLM from model
    uvm_blocking_get_port #(cibd_transaction) act_bp[5]; //TLM from monitor

    function new(string name = "router_scoreboard",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        exp_bp[0] = new("exp_bp[0]",this); //TLM
        exp_bp[1] = new("exp_bp[1]",this); //TLM
        exp_bp[2] = new("exp_bp[2]",this); //TLM
        exp_bp[3] = new("exp_bp[3]",this); //TLM
        exp_bp[4] = new("exp_bp[4]",this); //TLM
        act_bp[0] = new("act_bp[0]",this); //TLM
        act_bp[1] = new("act_bp[1]",this); //TLM
        act_bp[2] = new("act_bp[2]",this); //TLM
        act_bp[3] = new("act_bp[3]",this); //TLM
        act_bp[4] = new("act_bp[4]",this); //TLM
    endfunction

    virtual task main_phase(uvm_phase phase);
        cibd_transaction get_expect[5],get_actual[5];
        bit result;

        super.main_phase(phase);
        fork
            //expect threads
            while(1)
            begin
                exp_bp[0].get(get_expect[0]);
                `uvm_info("expect_w",{"\n",get_expect[0].sprint()},UVM_LOW)
                expect_queue_w.push_back(get_expect[0]);
            end

            while(1)
            begin
                exp_bp[1].get(get_expect[1]);
                `uvm_info("expect_e",{"\n",get_expect[1].sprint()},UVM_LOW)
                expect_queue_e.push_back(get_expect[1]);
            end

            while(1)
            begin
                exp_bp[2].get(get_expect[2]);
                `uvm_info("expect_n",{"\n",get_expect[2].sprint()},UVM_LOW)
                expect_queue_n.push_back(get_expect[2]);
            end

            while(1)
            begin
                exp_bp[3].get(get_expect[3]);
                `uvm_info("expect_s",{"\n",get_expect[3].sprint()},UVM_LOW)
                expect_queue_s.push_back(get_expect[3]);
            end

            while(1)
            begin
                exp_bp[4].get(get_expect[4]);
                `uvm_info("actual_l",{"\n",get_expect[4].sprint()},UVM_LOW)
                expect_queue_l.push_back(get_expect[4]);
            end

            //actual threads
            while(1)
            begin
                act_bp[0].get(get_actual[0]);
                `uvm_info("actual_w",{"\n",get_actual[0].sprint()},UVM_LOW)
                actual_queue_w.push_back(get_actual[0]);
            end

            while(1)
            begin
                act_bp[1].get(get_actual[1]);
                `uvm_info("expect_e",{"\n",get_actual[1].sprint()},UVM_LOW)
                actual_queue_e.push_back(get_actual[1]);
            end

            while(1)
            begin
                act_bp[2].get(get_actual[2]);
                `uvm_info("actual_n",{"\n",get_actual[2].sprint()},UVM_LOW)
                actual_queue_n.push_back(get_actual[2]);
            end

            while(1)
            begin
                act_bp[3].get(get_actual[3]);
                `uvm_info("actual_s",{"\n",get_actual[3].sprint()},UVM_LOW)
                actual_queue_s.push_back(get_actual[3]);
            end

            while(1)
            begin
                act_bp[4].get(get_actual[4]);
                `uvm_info("actual_l",{"\n",get_actual[4].sprint()},UVM_LOW)
                actual_queue_l.push_back(get_actual[4]);
            end
        join
    endtask


    virtual function void report_phase(uvm_phase phase);
        cibd_transaction temp_trans;
        int i = 0;
        bit flag = 0;

        `uvm_info("router_scoreboard","\n\n\nstarting west port verification",UVM_LOW)
        super.report_phase(phase);
        if(actual_queue_w.size() == expect_queue_w.size()) begin
            while(actual_queue_w.size() > 0)
            begin
                temp_trans = actual_queue_w.pop_front();
                for(i = 0; i < expect_queue_w.size(); i++) begin
                    if(temp_trans.compare(expect_queue_w[i])) begin
                        flag = 1;
                        break;
                    end
                end
                if(!flag) begin
                    `uvm_error("router_scoreboard","packet transfer error")
                end
                else begin
                    `uvm_info("router_scoreboard","packet transfer successfully",UVM_LOW)
                    flag = 0;
                end
            end
        end
        else begin
            `uvm_error("router_scoreboard","size not equal")
        end

        `uvm_info("router_scoreboard","\n\n\nstarting east port verification",UVM_LOW)
        if(actual_queue_e.size() == expect_queue_e.size()) begin
            while(actual_queue_e.size() > 0)
            begin
                temp_trans = actual_queue_e.pop_front();
                for(i = 0; i < expect_queue_e.size(); i++) begin
                    if(temp_trans.compare(expect_queue_e[i])) begin
                        flag = 1;
                        break;
                    end
                end
                if(!flag) begin
                    `uvm_error("router_scoreboard","packet transfer error")
                end
                else begin
                    `uvm_info("router_scoreboard","packet transfer successfully",UVM_LOW)
                    flag = 0;
                end
            end
        end
        else begin
            `uvm_error("router_scoreboard","size not equal")
        end

        `uvm_info("router_scoreboard","\n\n\nstarting north port verification",UVM_LOW)
        if(actual_queue_n.size() == expect_queue_n.size()) begin
            while(actual_queue_n.size() > 0)
            begin
                temp_trans = actual_queue_n.pop_front();
                for(i = 0; i < expect_queue_n.size(); i++) begin
                    if(temp_trans.compare(expect_queue_n[i])) begin
                        flag = 1;
                        break;
                    end
                end
                if(!flag) begin
                    `uvm_error("router_scoreboard","packet transfer error")
                end
                else begin
                    `uvm_info("router_scoreboard","packet transfer successfully",UVM_LOW)
                    flag = 0;
                end
            end
        end
        else begin
            `uvm_error("router_scoreboard","size not equal")
        end

        `uvm_info("router_scoreboard","\n\n\nstarting south port verification",UVM_LOW)
        if(actual_queue_s.size() == expect_queue_s.size()) begin
            while(actual_queue_s.size() > 0)
            begin
                temp_trans = actual_queue_s.pop_front();
                for(i = 0; i < expect_queue_s.size(); i++) begin
                    if(temp_trans.compare(expect_queue_s[i])) begin
                        flag = 1;
                        break;
                    end
                end
                if(!flag) begin
                    `uvm_error("router_scoreboard","packet transfer error")
                end
                else begin
                    `uvm_info("router_scoreboard","packet transfer successfully",UVM_LOW)
                    flag = 0;
                end
            end
        end
        else begin
            `uvm_error("router_scoreboard","size not equal")
        end

        `uvm_info("router_scoreboard","\n\n\nstarting local port verification",UVM_LOW)
        if(actual_queue_l.size() == expect_queue_l.size()) begin
            while(actual_queue_l.size() > 0)
            begin
                temp_trans = actual_queue_l.pop_front();
                for(i = 0; i < expect_queue_l.size(); i++) begin
                    if(temp_trans.compare(expect_queue_l[i])) begin
                        flag = 1;
                        break;
                    end
                end
                if(!flag) begin
                    `uvm_error("router_scoreboard","packet transfer error")
                end
                else begin
                    `uvm_info("router_scoreboard","packet transfer successfully",UVM_LOW)
                    flag = 0;
                end
            end
        end
        else begin
            `uvm_error("router_scoreboard","size not equal")
        end

    endfunction
endclass