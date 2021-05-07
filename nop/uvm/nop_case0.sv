class nop_case0 extends nop_base_test;

    `uvm_component_utils(nop_case0)
    nop_sequence seq[];
    
    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction 

    protected function bit assert_port(input int i);
        if(i == 10 || i == 14 || i == 35 || i == 39 || i == 60 || i == 64)
            return 0;
        return 1;
    endfunction

    virtual task main_phase(uvm_phase phase);
        seq = new[75];
        for(int d = 0; d < 3; d++) begin
            for(int x = 0; x < 5; x ++) begin
                for(int y = 0; y < 5; y ++) begin
                    if((x*5+y != 10) && (x*5+y != 14)) begin
                        seq[d*25+x*5+y] = new($sformatf("seq[%0d]",d*25+x*5+y));
                        seq[d*25+x*5+y].starting_phase = phase;
                        seq[d*25+x*5+y].srid_x = x;
                        seq[d*25+x*5+y].srid_y = y;
                        seq[d*25+x*5+y].scid = d;
                    end
                end
            end            
        end

        for(int j = 0; j < 75; j++) begin
            int i = j;
            if(assert_port(i)) begin
                fork
                    // `uvm_info("case0",$sformatf("sequence %0d",i),UVM_LOW)
                    seq[i].start(env.i_agt[i].sqr); 
                join_none
            end
        end
    endtask
endclass
