class nop_sequence extends uvm_sequence #(cibd_transaction);

    `uvm_object_utils(nop_sequence)

    cibd_transaction tr;
    int srid_x,srid_y;
    int scid;

    function new(string name = "nop_sequence");
        super.new(name);
    endfunction

    virtual task body();
        int i = 0;
        if(starting_phase != null) begin
            starting_phase.raise_objection(this);
        end
        #100
        repeat(`PKT_NUM) begin
            tr = new("tr");
            tr.srid_x = srid_x;
            tr.srid_y = srid_y;
            tr.scid = scid;
            if(i == 2) tr.is_out = 1;
            assert(tr.randomize());
            start_item(tr);
            finish_item(tr);
            i++;
            if(i >= 3) i = 0;
        end
        #60000
        if(starting_phase != null) begin
            starting_phase.drop_objection(this);
        end
    endtask

endclass