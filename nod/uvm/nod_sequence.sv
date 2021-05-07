class nod_sequence extends uvm_sequence #(cibd_transaction);

    `uvm_object_utils(nod_sequence)

    cibd_transaction tr;
    int srid_x,srid_y;

    function new(string name = "nod_sequence");
        super.new(name);
    endfunction

    virtual task body();
        if(starting_phase != null) begin
            starting_phase.raise_objection(this);
        end
        #400
        repeat(`PKT_NUM) begin
            tr = new("tr");
            tr.srid_x = srid_x;
            tr.srid_y = srid_y;
            assert(tr.randomize());
            start_item(tr);
            finish_item(tr);
        end
        #400
        if(starting_phase != null) begin
            starting_phase.drop_objection(this);
        end
    endtask

endclass