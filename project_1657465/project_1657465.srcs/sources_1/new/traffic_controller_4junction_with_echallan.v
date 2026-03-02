`timescale 1ns / 1ps

module traffic_controller_4junction_with_echallan(

    input clk,
    input reset,

    input emergency,
    input night_mode,

    input density_N,
    input density_E,
    input density_S,
    input density_W,

    input ped_request,

    // vehicle sensors (for e-challan)
    input vehicle_N,
    input vehicle_E,
    input vehicle_S,
    input vehicle_W,

    output reg red_N, yellow_N, green_N,
    output reg red_E, yellow_E, green_E,
    output reg red_S, yellow_S, green_S,
    output reg red_W, yellow_W, green_W,

    output reg ped_walk,
    output reg [3:0] countdown,

    output reg challan_N,
    output reg challan_E,
    output reg challan_S,
    output reg challan_W
);

// ---------------- STATES ----------------
localparam N_GREEN  = 4'd0;
localparam N_YELLOW = 4'd1;
localparam E_GREEN  = 4'd2;
localparam E_YELLOW = 4'd3;
localparam S_GREEN  = 4'd4;
localparam S_YELLOW = 4'd5;
localparam W_GREEN  = 4'd6;
localparam W_YELLOW = 4'd7;
localparam PED      = 4'd8;
localparam NIGHT    = 4'd9;

reg [3:0] state;
reg [3:0] timer;
reg ped_latched;
reg blink;

// ---------------- TIME VALUES ----------------
localparam GREEN_NORMAL = 4'd5;
localparam GREEN_DENSE  = 4'd8;
localparam YELLOW_TIME  = 4'd2;
localparam PED_TIME     = 4'd4;

// ---------------- BLINK ----------------
always @(posedge clk or posedge reset)
begin
    if(reset)
        blink <= 0;
    else
        blink <= ~blink;
end

// ---------------- FSM ----------------
always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        state <= N_GREEN;
        timer <= GREEN_NORMAL;
        ped_latched <= 0;
    end
    else
    begin
        if(ped_request)
            ped_latched <= 1;

        if(emergency)
        begin
            state <= N_GREEN;
            timer <= GREEN_NORMAL;
            ped_latched <= 0;
        end
        else if(night_mode)
        begin
            state <= NIGHT;
        end
        else
        begin
            if(timer == 0)
            begin
                case(state)

                    N_GREEN:  begin state<=N_YELLOW; timer<=YELLOW_TIME; end
                    N_YELLOW: begin
                                if(ped_latched)
                                begin state<=PED; timer<=PED_TIME; ped_latched<=0; end
                                else begin state<=E_GREEN; timer<=density_E?GREEN_DENSE:GREEN_NORMAL; end
                              end
                    E_GREEN:  begin state<=E_YELLOW; timer<=YELLOW_TIME; end
                    E_YELLOW: begin state<=S_GREEN; timer<=density_S?GREEN_DENSE:GREEN_NORMAL; end
                    S_GREEN:  begin state<=S_YELLOW; timer<=YELLOW_TIME; end
                    S_YELLOW: begin state<=W_GREEN; timer<=density_W?GREEN_DENSE:GREEN_NORMAL; end
                    W_GREEN:  begin state<=W_YELLOW; timer<=YELLOW_TIME; end
                    W_YELLOW: begin state<=N_GREEN; timer<=density_N?GREEN_DENSE:GREEN_NORMAL; end
                    PED:      begin state<=N_GREEN; timer<=GREEN_NORMAL; end
                    default:  begin state<=N_GREEN; timer<=GREEN_NORMAL; end
                endcase
            end
            else
                timer <= timer - 1;
        end
    end
end

// ---------------- OUTPUT LOGIC ----------------
always @(*)
begin
    red_N=0; yellow_N=0; green_N=0;
    red_E=0; yellow_E=0; green_E=0;
    red_S=0; yellow_S=0; green_S=0;
    red_W=0; yellow_W=0; green_W=0;
    ped_walk=0;

    countdown = timer;

    case(state)
        N_GREEN:  begin green_N=1; red_E=1; red_S=1; red_W=1; end
        N_YELLOW: begin yellow_N=1; red_E=1; red_S=1; red_W=1; end
        E_GREEN:  begin green_E=1; red_N=1; red_S=1; red_W=1; end
        E_YELLOW: begin yellow_E=1; red_N=1; red_S=1; red_W=1; end
        S_GREEN:  begin green_S=1; red_N=1; red_E=1; red_W=1; end
        S_YELLOW: begin yellow_S=1; red_N=1; red_E=1; red_W=1; end
        W_GREEN:  begin green_W=1; red_N=1; red_E=1; red_S=1; end
        W_YELLOW: begin yellow_W=1; red_N=1; red_E=1; red_S=1; end
        PED:      begin red_N=1; red_E=1; red_S=1; red_W=1; ped_walk=1; end
        NIGHT:    begin yellow_N=blink; yellow_E=blink; yellow_S=blink; yellow_W=blink; end
    endcase
end

// ---------------- E-CHALLAN LOGIC ----------------
always @(*)
begin
    challan_N = (vehicle_N && red_N);
    challan_E = (vehicle_E && red_E);
    challan_S = (vehicle_S && red_S);
    challan_W = (vehicle_W && red_W);
end

endmodule