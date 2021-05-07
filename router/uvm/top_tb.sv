`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "cibd_if.sv"
`include "cibd_transaction.sv"
// `include "router_sequence.sv"
`include "cibd_sequencer.sv"
`include "router_vsqr.sv"
`include "cibd_driver.sv"
`include "cibd_monitor.sv"
`include "cibd_agent.sv"
`include "router_model.sv"
`include "router_scoreboard.sv"
`include "router_env.sv"
`include "router_base_test.sv"
`include "router_case0.sv"

module top_tb;
reg clk;
reg rstn;

cibd_if i_if_w(clk,rstn); //for i_agt
cibd_if i_if_e(clk,rstn); //for i_agt
cibd_if i_if_n(clk,rstn); //for i_agt
cibd_if i_if_s(clk,rstn); //for i_agt
cibd_if i_if_l(clk,rstn); //for i_agt

cibd_if o_if_w(clk,rstn); //for o_agt
cibd_if o_if_e(clk,rstn); //for o_agt
cibd_if o_if_n(clk,rstn); //for o_agt
cibd_if o_if_s(clk,rstn); //for o_agt
cibd_if o_if_l(clk,rstn); //for o_agt

router #(
    .ROUTER_ID_X        (2),
    .ROUTER_ID_Y        (2)
)dut(
    .CDCLK              (clk),
    .CDRESETn           (rstn),
    .CDIDATAW           (i_if_w.data),
    .CDIVALIDW          (i_if_w.valid),
    .CDIREADYW          (i_if_w.ready),
    .CDODATAW           (o_if_w.data),
    .CDOVALIDW          (o_if_w.valid),
    .CDOREADYW          (o_if_w.ready),
    .CDIDATAE           (i_if_e.data),
    .CDIVALIDE          (i_if_e.valid),
    .CDIREADYE          (i_if_e.ready),
    .CDODATAE           (o_if_e.data),
    .CDOVALIDE          (o_if_e.valid),
    .CDOREADYE          (o_if_e.ready),
    .CDIDATAL           (i_if_l.data),
    .CDIVALIDL          (i_if_l.valid),
    .CDIREADYL          (i_if_l.ready),
    .CDIDATAN           (i_if_n.data),
    .CDIVALIDN          (i_if_n.valid),
    .CDIREADYN          (i_if_n.ready),
    .CDODATAN           (o_if_n.data),
    .CDOVALIDN          (o_if_n.valid),
    .CDOREADYN          (o_if_n.ready),
    .CDIDATAS           (i_if_s.data),
    .CDIVALIDS          (i_if_s.valid),
    .CDIREADYS          (i_if_s.ready),
    .CDODATAS           (o_if_s.data),
    .CDOVALIDS          (o_if_s.valid),
    .CDOREADYS          (o_if_s.ready),
    .CDODATAL           (o_if_l.data),
    .CDOVALIDL          (o_if_l.valid),
    .CDOREADYL          (o_if_l.ready)
);

// router #(
//     .ROUTER_ID_X        (2),
//     .ROUTER_ID_Y        (2)
// )dut(
//     .CDCLK              (clk),
//     .CDRESETn           (rstn),
//     .CDIDATAW           (130'b0),
//     .CDIVALIDW          (1'b0),
//     .CDIREADYW          (),
//     .CDODATAW           (o_if_w.data),
//     .CDOVALIDW          (o_if_w.valid),
//     .CDOREADYW          (o_if_w.ready),
//     .CDIDATAE           (130'b0),
//     .CDIVALIDE          (1'b0),
//     .CDIREADYE          (),
//     .CDODATAE           (o_if_e.data),
//     .CDOVALIDE          (o_if_e.valid),
//     .CDOREADYE          (o_if_e.ready),
//     .CDIDATAL           (130'b0),
//     .CDIVALIDL          (1'b0),
//     .CDIREADYL          (),
//     .CDIDATAN           (130'b0),
//     .CDIVALIDN          (1'b0),
//     .CDIREADYN          (),
//     .CDODATAN           (o_if_n.data),
//     .CDOVALIDN          (o_if_n.valid),
//     .CDOREADYN          (o_if_n.ready),
//     .CDIDATAS           (130'b0),
//     .CDIVALIDS          (1'b0),
//     .CDIREADYS          (),
//     .CDODATAS           (o_if_s.data),
//     .CDOVALIDS          (o_if_s.valid),
//     .CDOREADYS          (o_if_s.ready),
//     .CDODATAL           (o_if_l.data),
//     .CDOVALIDL          (o_if_l.valid),
//     .CDOREADYL          (o_if_l.ready)
// );

initial
begin
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[0].drv","vif",i_if_w);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[1].drv","vif",i_if_e);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[2].drv","vif",i_if_n);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[3].drv","vif",i_if_s);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[4].drv","vif",i_if_l);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[0].mon","vif",i_if_w);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[1].mon","vif",i_if_e);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[2].mon","vif",i_if_n);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[3].mon","vif",i_if_s);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[4].mon","vif",i_if_l);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[0].mon","vif",o_if_w);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[1].mon","vif",o_if_e);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[2].mon","vif",o_if_n);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[3].mon","vif",o_if_s);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[4].mon","vif",o_if_l);
end

initial
begin
    run_test("router_case0");
end

initial
begin
    clk = 0;
    forever
    begin
        #2 clk = ~clk;
    end
end

initial
begin
    rstn = 1'b0;
    #33;
    rstn = 1'b1;
end

endmodule