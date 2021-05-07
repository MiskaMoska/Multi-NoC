`timescale 1ns/1ns
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "param.vh"
`include "cibd_if.sv"
`include "cibd_transaction.sv"
`include "cibd_driver.sv"
`include "cibd_monitor.sv"
`include "cibd_sequencer.sv"
`include "cibd_agent.sv"
`include "nod_latency.sv"
`include "nod_model.sv"
`include "nod_scoreboard.sv"
`include "nod_env.sv"
`include "nod_base_test.sv"
`include "nod_sequence.sv"
`include "nod_case0.sv"

module top_tb;
reg clk;
reg rstn;

cibd_if i_if[25](clk,rstn);
cibd_if o_if[25](clk,rstn);

NoD #(
    .NODID                        (0)
)dut(
    .CDCLK                        (clk),
    .CDRESETn                     (rstn),
    .CDIDATA_X0_Y0                (i_if[0].data),
    .CDIVALID_X0_Y0               (i_if[0].valid),
    .CDIREADY_X0_Y0               (i_if[0].ready),
    .CDODATA_X0_Y0                (o_if[0].data),
    .CDOVALID_X0_Y0               (o_if[0].valid),
    .CDOREADY_X0_Y0               (o_if[0].ready),
    .CDIDATA_X0_Y1                (i_if[1].data),
    .CDIVALID_X0_Y1               (i_if[1].valid),
    .CDIREADY_X0_Y1               (i_if[1].ready),
    .CDODATA_X0_Y1                (o_if[1].data),
    .CDOVALID_X0_Y1               (o_if[1].valid),
    .CDOREADY_X0_Y1               (o_if[1].ready),
    .CDIDATA_X0_Y2                (i_if[2].data),
    .CDIVALID_X0_Y2               (i_if[2].valid),
    .CDIREADY_X0_Y2               (i_if[2].ready),
    .CDODATA_X0_Y2                (o_if[2].data),
    .CDOVALID_X0_Y2               (o_if[2].valid),
    .CDOREADY_X0_Y2               (o_if[2].ready),
    .CDIDATA_X0_Y3                (i_if[3].data),
    .CDIVALID_X0_Y3               (i_if[3].valid),
    .CDIREADY_X0_Y3               (i_if[3].ready),
    .CDODATA_X0_Y3                (o_if[3].data),
    .CDOVALID_X0_Y3               (o_if[3].valid),
    .CDOREADY_X0_Y3               (o_if[3].ready),
    .CDIDATA_X0_Y4                (i_if[4].data),
    .CDIVALID_X0_Y4               (i_if[4].valid),
    .CDIREADY_X0_Y4               (i_if[4].ready),
    .CDODATA_X0_Y4                (o_if[4].data),
    .CDOVALID_X0_Y4               (o_if[4].valid),
    .CDOREADY_X0_Y4               (o_if[4].ready),
    .CDIDATA_X1_Y0                (i_if[5].data),
    .CDIVALID_X1_Y0               (i_if[5].valid),
    .CDIREADY_X1_Y0               (i_if[5].ready),
    .CDODATA_X1_Y0                (o_if[5].data),
    .CDOVALID_X1_Y0               (o_if[5].valid),
    .CDOREADY_X1_Y0               (o_if[5].ready),
    .CDIDATA_X1_Y1                (i_if[6].data),
    .CDIVALID_X1_Y1               (i_if[6].valid),
    .CDIREADY_X1_Y1               (i_if[6].ready),
    .CDODATA_X1_Y1                (o_if[6].data),
    .CDOVALID_X1_Y1               (o_if[6].valid),
    .CDOREADY_X1_Y1               (o_if[6].ready),
    .CDIDATA_X1_Y2                (i_if[7].data),
    .CDIVALID_X1_Y2               (i_if[7].valid),
    .CDIREADY_X1_Y2               (i_if[7].ready),
    .CDODATA_X1_Y2                (o_if[7].data),
    .CDOVALID_X1_Y2               (o_if[7].valid),
    .CDOREADY_X1_Y2               (o_if[7].ready),
    .CDIDATA_X1_Y3                (i_if[8].data),
    .CDIVALID_X1_Y3               (i_if[8].valid),
    .CDIREADY_X1_Y3               (i_if[8].ready),
    .CDODATA_X1_Y3                (o_if[8].data),
    .CDOVALID_X1_Y3               (o_if[8].valid),
    .CDOREADY_X1_Y3               (o_if[8].ready),
    .CDIDATA_X1_Y4                (i_if[9].data),
    .CDIVALID_X1_Y4               (i_if[9].valid),
    .CDIREADY_X1_Y4               (i_if[9].ready),
    .CDODATA_X1_Y4                (o_if[9].data),
    .CDOVALID_X1_Y4               (o_if[9].valid),
    .CDOREADY_X1_Y4               (o_if[9].ready),
    .CDIDATA_X2_Y0                (i_if[10].data),
    .CDIVALID_X2_Y0               (i_if[10].valid),
    .CDIREADY_X2_Y0               (i_if[10].ready),
    .CDODATA_X2_Y0                (o_if[10].data),
    .CDOVALID_X2_Y0               (o_if[10].valid),
    .CDOREADY_X2_Y0               (o_if[10].ready),
    .CDIDATA_X2_Y1                (i_if[11].data),
    .CDIVALID_X2_Y1               (i_if[11].valid),
    .CDIREADY_X2_Y1               (i_if[11].ready),
    .CDODATA_X2_Y1                (o_if[11].data),
    .CDOVALID_X2_Y1               (o_if[11].valid),
    .CDOREADY_X2_Y1               (o_if[11].ready),
    .CDIDATA_X2_Y2                (i_if[12].data),
    .CDIVALID_X2_Y2               (i_if[12].valid),
    .CDIREADY_X2_Y2               (i_if[12].ready),
    .CDODATA_X2_Y2                (o_if[12].data),
    .CDOVALID_X2_Y2               (o_if[12].valid),
    .CDOREADY_X2_Y2               (o_if[12].ready),
    .CDIDATA_X2_Y3                (i_if[13].data),
    .CDIVALID_X2_Y3               (i_if[13].valid),
    .CDIREADY_X2_Y3               (i_if[13].ready),
    .CDODATA_X2_Y3                (o_if[13].data),
    .CDOVALID_X2_Y3               (o_if[13].valid),
    .CDOREADY_X2_Y3               (o_if[13].ready),
    .CDIDATA_X2_Y4                (i_if[14].data),
    .CDIVALID_X2_Y4               (i_if[14].valid),
    .CDIREADY_X2_Y4               (i_if[14].ready),
    .CDODATA_X2_Y4                (o_if[14].data),
    .CDOVALID_X2_Y4               (o_if[14].valid),
    .CDOREADY_X2_Y4               (o_if[14].ready),
    .CDIDATA_X3_Y0                (i_if[15].data),
    .CDIVALID_X3_Y0               (i_if[15].valid),
    .CDIREADY_X3_Y0               (i_if[15].ready),
    .CDODATA_X3_Y0                (o_if[15].data),
    .CDOVALID_X3_Y0               (o_if[15].valid),
    .CDOREADY_X3_Y0               (o_if[15].ready),
    .CDIDATA_X3_Y1                (i_if[16].data),
    .CDIVALID_X3_Y1               (i_if[16].valid),
    .CDIREADY_X3_Y1               (i_if[16].ready),
    .CDODATA_X3_Y1                (o_if[16].data),
    .CDOVALID_X3_Y1               (o_if[16].valid),
    .CDOREADY_X3_Y1               (o_if[16].ready),
    .CDIDATA_X3_Y2                (i_if[17].data),
    .CDIVALID_X3_Y2               (i_if[17].valid),
    .CDIREADY_X3_Y2               (i_if[17].ready),
    .CDODATA_X3_Y2                (o_if[17].data),
    .CDOVALID_X3_Y2               (o_if[17].valid),
    .CDOREADY_X3_Y2               (o_if[17].ready),
    .CDIDATA_X3_Y3                (i_if[18].data),
    .CDIVALID_X3_Y3               (i_if[18].valid),
    .CDIREADY_X3_Y3               (i_if[18].ready),
    .CDODATA_X3_Y3                (o_if[18].data),
    .CDOVALID_X3_Y3               (o_if[18].valid),
    .CDOREADY_X3_Y3               (o_if[18].ready),
    .CDIDATA_X3_Y4                (i_if[19].data),
    .CDIVALID_X3_Y4               (i_if[19].valid),
    .CDIREADY_X3_Y4               (i_if[19].ready),
    .CDODATA_X3_Y4                (o_if[19].data),
    .CDOVALID_X3_Y4               (o_if[19].valid),
    .CDOREADY_X3_Y4               (o_if[19].ready),
    .CDIDATA_X4_Y0                (i_if[20].data),
    .CDIVALID_X4_Y0               (i_if[20].valid),
    .CDIREADY_X4_Y0               (i_if[20].ready),
    .CDODATA_X4_Y0                (o_if[20].data),
    .CDOVALID_X4_Y0               (o_if[20].valid),
    .CDOREADY_X4_Y0               (o_if[20].ready),
    .CDIDATA_X4_Y1                (i_if[21].data),
    .CDIVALID_X4_Y1               (i_if[21].valid),
    .CDIREADY_X4_Y1               (i_if[21].ready),
    .CDODATA_X4_Y1                (o_if[21].data),
    .CDOVALID_X4_Y1               (o_if[21].valid),
    .CDOREADY_X4_Y1               (o_if[21].ready),
    .CDIDATA_X4_Y2                (i_if[22].data),
    .CDIVALID_X4_Y2               (i_if[22].valid),
    .CDIREADY_X4_Y2               (i_if[22].ready),
    .CDODATA_X4_Y2                (o_if[22].data),
    .CDOVALID_X4_Y2               (o_if[22].valid),
    .CDOREADY_X4_Y2               (o_if[22].ready),
    .CDIDATA_X4_Y3                (i_if[23].data),
    .CDIVALID_X4_Y3               (i_if[23].valid),
    .CDIREADY_X4_Y3               (i_if[23].ready),
    .CDODATA_X4_Y3                (o_if[23].data),
    .CDOVALID_X4_Y3               (o_if[23].valid),
    .CDOREADY_X4_Y3               (o_if[23].ready),
    .CDIDATA_X4_Y4                (i_if[24].data),
    .CDIVALID_X4_Y4               (i_if[24].valid),
    .CDIREADY_X4_Y4               (i_if[24].ready),
    .CDODATA_X4_Y4                (o_if[24].data),
    .CDOVALID_X4_Y4               (o_if[24].valid),
    .CDOREADY_X4_Y4               (o_if[24].ready)
);

initial
begin
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[0].drv","vif",i_if[0]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[1].drv","vif",i_if[1]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[2].drv","vif",i_if[2]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[3].drv","vif",i_if[3]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[4].drv","vif",i_if[4]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[5].drv","vif",i_if[5]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[6].drv","vif",i_if[6]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[7].drv","vif",i_if[7]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[8].drv","vif",i_if[8]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[9].drv","vif",i_if[9]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[10].drv","vif",i_if[10]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[11].drv","vif",i_if[11]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[12].drv","vif",i_if[12]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[13].drv","vif",i_if[13]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[14].drv","vif",i_if[14]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[15].drv","vif",i_if[15]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[16].drv","vif",i_if[16]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[17].drv","vif",i_if[17]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[18].drv","vif",i_if[18]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[19].drv","vif",i_if[19]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[20].drv","vif",i_if[20]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[21].drv","vif",i_if[21]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[22].drv","vif",i_if[22]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[23].drv","vif",i_if[23]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[24].drv","vif",i_if[24]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[0].mon","vif",o_if[0]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[1].mon","vif",o_if[1]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[2].mon","vif",o_if[2]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[3].mon","vif",o_if[3]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[4].mon","vif",o_if[4]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[5].mon","vif",o_if[5]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[6].mon","vif",o_if[6]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[7].mon","vif",o_if[7]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[8].mon","vif",o_if[8]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[9].mon","vif",o_if[9]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[10].mon","vif",o_if[10]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[11].mon","vif",o_if[11]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[12].mon","vif",o_if[12]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[13].mon","vif",o_if[13]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[14].mon","vif",o_if[14]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[15].mon","vif",o_if[15]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[16].mon","vif",o_if[16]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[17].mon","vif",o_if[17]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[18].mon","vif",o_if[18]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[19].mon","vif",o_if[19]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[20].mon","vif",o_if[20]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[21].mon","vif",o_if[21]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[22].mon","vif",o_if[22]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[23].mon","vif",o_if[23]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[24].mon","vif",o_if[24]);
end

initial
begin
    run_test("nod_case0");
end

initial
begin
    clk = 0;
    forever
    begin
        #5 clk = ~clk;
    end
end

initial
begin
    rstn = 1'b0;
    #33;
    rstn = 1'b1;
end

endmodule