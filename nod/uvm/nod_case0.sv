class nod_case0 extends nod_base_test;

    `uvm_component_utils(nod_case0)
    nod_sequence seq[];
    
    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction 

    virtual task main_phase(uvm_phase phase);
        seq = new[25];
        for(int x = 0; x < 5; x ++) begin
            for(int y = 0; y < 5; y ++) begin
                seq[x*5+y] = new($sformatf("seq[%0d]",x*5+y));
                seq[x*5+y].starting_phase = phase;
                seq[x*5+y].srid_x = x;
                seq[x*5+y].srid_y = y;
            end
        end

        foreach(seq[j]) begin
            int i = j;
            fork
                seq[i].start(env.i_agt[i].sqr);
            join_none
        end
    endtask
endclass
