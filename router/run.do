set UVM_DPI_HOME E:/QuestaSim/uvm-1.1d/win64
vlib work

vlog "./rtl/*"
vlog "./uvm/top_tb.sv"

vsim -voptargs=+acc -c -sv_lib $UVM_DPI_HOME/uvm_dpi work.top_tb
add wave top_tb/dut/*

run -all