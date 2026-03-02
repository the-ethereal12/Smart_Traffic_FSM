`timescale 1ns / 1ps

module tb_traffic_controller_4junction_with_echallan;

reg clk;
reg reset;

reg emergency;
reg night_mode;

reg density_N;
reg density_E;
reg density_S;
reg density_W;

reg ped_request;

reg vehicle_N;
reg vehicle_E;
reg vehicle_S;
reg vehicle_W;

wire red_N, yellow_N, green_N;
wire red_E, yellow_E, green_E;
wire red_S, yellow_S, green_S;
wire red_W, yellow_W, green_W;

wire ped_walk;
wire [3:0] countdown;

wire challan_N;
wire challan_E;
wire challan_S;
wire challan_W;


// DUT INSTANCE
traffic_controller_4junction_with_echallan DUT (

    clk,
    reset,

    emergency,
    night_mode,

    density_N,
    density_E,
    density_S,
    density_W,

    ped_request,

    vehicle_N,
    vehicle_E,
    vehicle_S,
    vehicle_W,

    red_N, yellow_N, green_N,
    red_E, yellow_E, green_E,
    red_S, yellow_S, green_S,
    red_W, yellow_W, green_W,

    ped_walk,
    countdown,

    challan_N,
    challan_E,
    challan_S,
    challan_W
);


// CLOCK GENERATION
always #5 clk = ~clk;


// TEST SEQUENCE
initial
begin
    clk = 0;
    reset = 1;

    emergency = 0;
    night_mode = 0;

    density_N = 0;
    density_E = 0;
    density_S = 0;
    density_W = 0;

    ped_request = 0;

    vehicle_N = 0;
    vehicle_E = 0;
    vehicle_S = 0;
    vehicle_W = 0;

    // Release reset
    #20 reset = 0;

    // ---------------- NORMAL OPERATION ----------------
    #80;

    // ---------------- DENSITY TEST ----------------
    density_E = 1;
    #80;
    density_E = 0;

    // ---------------- PEDESTRIAN TEST ----------------
    #50 ped_request = 1;
    #20 ped_request = 0;

    // ---------------- E-CHALLAN TEST ----------------
    // Try moving vehicle when red signal
    #60 vehicle_N = 1;   // if N is red → challan_N = 1
    #20 vehicle_N = 0;

    #60 vehicle_W = 1;   // if W is red → challan_W = 1
    #20 vehicle_W = 0;

    // ---------------- EMERGENCY TEST ----------------
    #100 emergency = 1;
    #30 emergency = 0;

    // ---------------- NIGHT MODE TEST ----------------
    #120 night_mode = 1;
    #80 night_mode = 0;

    #400 $finish;
end

endmodule