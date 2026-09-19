You're right. **One single box only. No separate blocks.** Copy from `# Smart Traffic FSM` to the very end and paste it directly into `README.md`.

````markdown
# Smart Traffic FSM

## Advanced FSM-Based Traffic Light Controller for a Four-Way Junction

Smart Traffic FSM is a **Verilog HDL-based intelligent traffic light controller** designed for a four-way junction. It uses a **Finite State Machine (FSM)** to control North, East, South, and West traffic signals while supporting normal operation, traffic-density-based timing, emergency priority, pedestrian requests, night mode, countdown timing, and simulation-based red-light violation detection.

The project is implemented in **Verilog HDL** and developed and verified using **Xilinx Vivado**.

---

## Features

- Four-way traffic signal control
- Traffic-density-based green-light timing
- Emergency vehicle priority
- Pedestrian crossing support
- Blinking-yellow night mode
- Countdown timer
- Simulation-based e-challan / red-light violation detection
- Verilog testbench and behavioral simulation

---

## How It Works

The controller is based on a **Finite State Machine** with 10 states:

| State | Description |
|---|---|
| `N_GREEN` | North traffic moves |
| `N_YELLOW` | North transition |
| `E_GREEN` | East traffic moves |
| `E_YELLOW` | East transition |
| `S_GREEN` | South traffic moves |
| `S_YELLOW` | South transition |
| `W_GREEN` | West traffic moves |
| `W_YELLOW` | West transition |
| `PED` | Pedestrian crossing |
| `NIGHT` | Blinking-yellow night mode |

During normal operation, the controller follows:

```text
N_GREEN → N_YELLOW
    ↓
E_GREEN → E_YELLOW
    ↓
S_GREEN → S_YELLOW
    ↓
W_GREEN → W_YELLOW
    ↓
N_GREEN
````

Only one direction receives a green signal at a time while the other directions remain red.

### Traffic Density

Each direction has a density input:

```text
density_N
density_E
density_S
density_W
```

The green duration is adjusted according to traffic density:

| Condition        |            Duration |
| ---------------- | ------------------: |
| Normal traffic   | 5 clock-count units |
| High density     | 8 clock-count units |
| Yellow phase     | 2 clock-count units |
| Pedestrian phase | 4 clock-count units |

This allows a high-density direction to receive additional green time.

### Emergency Priority

When the `emergency` input is activated, the controller enters the defined emergency-priority state (`N_GREEN`) and resets its timer. The current implementation uses a single emergency input and does not identify the physical direction of the emergency vehicle.

### Pedestrian Crossing

A pedestrian request is received through `ped_request` and stored internally until it is serviced.

During the `PED` state:

```text
North → RED
East  → RED
South → RED
West  → RED

ped_walk → 1
```

The pedestrian phase lasts for 4 clock-count units before returning to normal traffic operation.

### Night Mode

When `night_mode` is enabled, the controller enters the `NIGHT` state. All four yellow signals are controlled using an internal blinking signal:

```text
Yellow ON → Yellow OFF → Yellow ON → Yellow OFF
```

This provides a blinking-yellow warning mode for night or low-traffic operation.

### Countdown Timer

A 4-bit timer tracks the remaining duration of the active traffic phase and is provided through the `countdown` output.

```text
5 → 4 → 3 → 2 → 1 → 0 → Next State
```

### E-Challan / Violation Detection

The project includes simulation-based red-light violation detection using vehicle inputs:

```text
vehicle_N
vehicle_E
vehicle_S
vehicle_W
```

A violation is detected when a vehicle is present while the corresponding signal is red:

```text
Vehicle Detected + Red Signal
            ↓
      Violation Flag
```

For example:

```text
challan_N = vehicle_N && red_N
```

The current implementation generates digital violation flags. It does not include camera-based number-plate recognition, an external database, or real-world challan processing.

---

## System Architecture

```text
                    ┌──────────────────────────┐
                    │       INPUT SIGNALS      │
                    │                          │
                    │ Emergency Request        │
                    │ Night Mode               │
                    │ Traffic Density N/E/S/W  │
                    │ Pedestrian Request       │
                    │ Vehicle Sensors N/E/S/W  │
                    └────────────┬─────────────┘
                                 │
                                 ▼
                    ┌──────────────────────────┐
                    │      FSM CONTROLLER      │
                    │                          │
                    │ State Selection          │
                    │ Timer Management         │
                    │ Priority Handling       │
                    │ Pedestrian Handling      │
                    └────────────┬─────────────┘
                                 │
                ┌────────────────┴────────────────┐
                │                                 │
                ▼                                 ▼
      ┌────────────────────┐            ┌────────────────────┐
      │  TRAFFIC SIGNALS   │            │  E-CHALLAN LOGIC   │
      │                    │            │                    │
      │ N / E / S / W      │            │ Vehicle + Red      │
      │ Red/Yellow/Green   │            │ Signal Detection   │
      └─────────┬──────────┘            └────────────────────┘
                │
                ▼
       ┌──────────────────┐
       │ Countdown /      │
       │ Pedestrian Walk  │
       └──────────────────┘
```

---

## Simulation & Verification

A dedicated Verilog testbench is included to verify:

1. Normal traffic operation
2. Traffic-density timing
3. Pedestrian requests
4. E-challan detection
5. Emergency operation
6. Night-mode operation

The design can be tested using **Xilinx Vivado Behavioral Simulation** and analyzed through simulation waveforms.

### Simulation Flow

```text
Reset
  ↓
Normal Traffic
  ↓
Density Test
  ↓
Pedestrian Test
  ↓
E-Challan Test
  ↓
Emergency Test
  ↓
Night Mode Test
  ↓
Simulation Complete
```

---

## Project Structure

```text
Smart_Traffic_FSM/
│
├── README.md
│
└── project_1657465/
    ├── project_1657465.xpr
    │
    └── project_1657465.srcs/
        ├── sources_1/
        │   └── new/
        │       └── traffic_controller_4junction_with_echallan.v
        │
        └── sim_1/
            └── new/
                └── tb_traffic_controller_4junction_with_echallan.v
```

---

## Technologies Used

* **Verilog HDL**
* **Finite State Machine (FSM)**
* **Xilinx Vivado**
* **RTL Design**
* **Behavioral Simulation**
* **Verilog Testbench**
* **Waveform Analysis**

---

## How to Run

### 1. Clone the Repository

```bash
git clone https://github.com/the-ethereal12/Smart_Traffic_FSM.git
```

### 2. Open the Vivado Project

Open:

```text
project_1657465/project_1657465.xpr
```

### 3. Run Behavioral Simulation

In Vivado, select:

```text
Simulation → Run Simulation → Run Behavioral Simulation
```

### 4. Analyze the Waveform

Observe the traffic-light transitions, countdown, pedestrian signal, emergency behavior, night-mode blinking, density-based timing, and e-challan outputs.

---

## Future Enhancements

* Direction-specific emergency vehicle detection
* Real-time traffic-density sensors
* Camera-based vehicle detection
* Automatic number-plate recognition
* FPGA hardware deployment
* Real e-challan database integration
* IoT-based traffic monitoring
* Adaptive traffic optimization
* Centralized traffic-control dashboard

---

## Conclusion

Smart Traffic FSM demonstrates the implementation of a **four-way intelligent traffic controller using a Finite State Machine in Verilog HDL**. The system combines normal traffic sequencing with **traffic-density-based timing, emergency priority, pedestrian handling, night-mode operation, countdown timing, and simulation-based red-light violation detection**.

The project demonstrates practical digital-design concepts including **FSM architecture, sequential logic, combinational output logic, timers, input handling, priority control, and RTL simulation**. A dedicated Verilog testbench is used to verify the major operating scenarios through **Xilinx Vivado behavioral simulation**.

The design provides a solid RTL-level foundation for future development toward hardware deployment, sensor integration, camera-based monitoring, and advanced intelligent transportation systems.

---

## Team Project

This repository is maintained as a **group project** covering FSM design, Verilog implementation, traffic-control logic, testbench development, simulation and waveform verification, feature integration, and technical documentation.

---

## License

This project is developed for **educational and academic purposes**.

```
```
