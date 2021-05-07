class cibd_sequencer extends uvm_sequencer #(cibd_transaction);

    `uvm_component_utils(cibd_sequencer)

    function new(string name = "cibd_sequencer",uvm_component parent = null);
        super.new(name,parent);
    endfunction

endclass