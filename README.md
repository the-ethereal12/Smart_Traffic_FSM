# 🚦 Smart Traffic FSM

## Advanced FSM-Based Intelligent Traffic Light Controller for a Four-Way Junction

Smart Traffic FSM is a **Verilog HDL-based intelligent traffic control system** designed to manage a four-way road intersection using a **Finite State Machine (FSM)** architecture.

The controller manages traffic signals for **North, East, South, and West** directions while incorporating traffic-density-based timing, emergency vehicle priority, pedestrian crossing requests, night-mode operation, countdown timing, and simulation-based red-light violation detection.

The project demonstrates the practical application of **digital logic design, RTL architecture, sequential and combinational logic, FSM-based control, timing logic, priority handling, and hardware-oriented simulation** using **Xilinx Vivado**.

> **Project Type:** Group / Academic Digital Design Project  
> **HDL:** Verilog  
> **Architecture:** Finite State Machine (FSM)  
> **Simulation:** Xilinx Vivado Behavioral Simulation  
> **Application:** Intelligent Transportation Systems

---

# 📌 Table of Contents

- [Overview](#-overview)
- [Objectives](#-objectives)
- [Key Features](#-key-features)
- [System Architecture](#-system-architecture)
- [FSM Architecture](#-fsm-architecture)
- [Normal Traffic Operation](#-normal-traffic-operation)
- [Traffic Density Control](#-traffic-density-control)
- [Emergency Vehicle Priority](#-emergency-vehicle-priority)
- [Pedestrian Crossing](#-pedestrian-crossing)
- [Night Mode](#-night-mode)
- [Countdown Timer](#-countdown-timer)
- [E-Challan / Violation Detection](#-e-challan--violation-detection)
- [Inputs and Outputs](#-inputs-and-outputs)
- [Simulation and Verification](#-simulation-and-verification)
- [Simulation Flow](#-simulation-flow)
- [Project Structure](#-project-structure)
- [Technologies Used](#-technologies-used)
- [How to Run](#-how-to-run)
- [Expected Behavior](#-expected-behavior)
- [Current Limitations](#-current-limitations)
- [Future Enhancements](#-future-enhancements)
- [Applications](#-applications)
- [Digital Design Concepts](#-digital-design-concepts)
- [Conclusion](#-conclusion)
- [Team Project](#-team-project)
- [License](#-license)

---

# 🔎 Overview

Traditional traffic-light controllers generally operate using predefined timing sequences. This project extends the basic traffic-light concept by introducing an FSM-based controller capable of responding to multiple operating conditions.

The system controls a **four-way intersection** and supports:

- 🚗 Four-direction traffic management
- 📊 Traffic-density-based green-light timing
- 🚑 Emergency vehicle priority
- 🚶 Pedestrian crossing requests
- 🌙 Blinking-yellow night mode
- ⏱️ Countdown timer
- 🚨 Red-light violation detection
- 🧪 Verilog testbench-based verification
- 📈 Behavioral waveform analysis

The controller is implemented at the **RTL level**, making it suitable for studying how intelligent traffic-control logic can be represented using digital hardware design techniques.

---

# 🎯 Objectives

The main objectives of this project are:

1. Design a reliable FSM-based traffic controller for a four-way junction.
2. Control traffic signals for North, East, South, and West directions.
3. Dynamically modify green-light duration based on traffic density.
4. Provide priority handling for emergency conditions.
5. Support pedestrian crossing requests.
6. Implement a dedicated night-mode operation.
7. Provide countdown information for the active traffic phase.
8. Detect potential red-light violations at the digital logic level.
9. Verify the controller through Verilog behavioral simulation.
10. Demonstrate practical RTL and FSM design concepts using Xilinx Vivado.

---

# ✨ Key Features

| Feature | Description |
|---|---|
| 🚦 Four-Way Control | Controls traffic signals for North, East, South, and West |
| 🧠 FSM Controller | Uses a dedicated finite-state-machine architecture |
| 📊 Traffic Density | Adjusts green duration according to traffic-density input |
| 🚑 Emergency Priority | Provides priority operation when emergency input is activated |
| 🚶 Pedestrian Mode | Provides a dedicated pedestrian crossing phase |
| 🌙 Night Mode | Enables blinking-yellow operation |
| ⏱️ Countdown Timer | Tracks remaining duration of the active phase |
| 🚨 Violation Detection | Generates digital flags for vehicles detected during red signals |
| 🧪 Testbench | Includes a dedicated Verilog testbench |
| 📈 Waveform Verification | Supports behavioral simulation and waveform analysis |
| 💻 RTL Implementation | Designed using hardware-description and digital-logic principles |

---

# 🏗️ System Architecture

The overall system can be represented as:

```text
                    ┌─────────────────────────────┐
                    │        INPUT SIGNALS        │
                    │                             │
                    │  Emergency Request          │
                    │  Night Mode                 │
                    │  Pedestrian Request         │
                    │  Traffic Density N/E/S/W    │
                    │  Vehicle Sensors N/E/S/W    │
                    └──────────────┬──────────────┘
                                   │
                                   ▼
                    ┌─────────────────────────────┐
                    │       FSM CONTROLLER        │
                    │                             │
                    │  State Selection            │
                    │  Priority Handling          │
                    │  Timer Management           │
                    │  Pedestrian Handling        │
                    │  Traffic-Density Logic      │
                    └──────────────┬──────────────┘
                                   │
                 ┌─────────────────┼──────────────────┐
                 │                 │                  │
                 ▼                 ▼                  ▼
       ┌─────────────────┐ ┌───────────────┐ ┌─────────────────┐
       │ TRAFFIC SIGNALS │ │  COUNTDOWN    │ │ E-CHALLAN /    │
       │                 │ │    TIMER      │ │ VIOLATION LOGIC │
       │ N / E / S / W   │ │               │ │                 │
       │ RED/YELLOW/GREEN│ │ Active Phase  │ │ Vehicle + RED   │
       └─────────────────┘ └───────────────┘ └─────────────────┘
````

The FSM acts as the central control unit. It receives operating requests and determines the appropriate traffic state, signal outputs, timing behavior, pedestrian operation, and violation flags.

The architecture is divided into three major functional areas:

### 1. Input Layer

The controller receives information related to:

* Traffic density
* Vehicle detection
* Emergency requests
* Pedestrian requests
* Night-mode activation
* Clock and reset

### 2. FSM Control Layer

The FSM is responsible for:

* Selecting the current traffic state
* Managing state transitions
* Controlling phase duration
* Handling priority conditions
* Processing pedestrian requests
* Processing traffic-density conditions

### 3. Output Layer

The controller produces:

* Traffic-light signals
* Countdown information
* Pedestrian walk indication
* Violation/challan flags

This separation makes the design easier to understand, simulate, debug, and extend.

---

# 🧠 FSM Architecture

The traffic controller is implemented using a **Finite State Machine**.

The FSM divides the intersection operation into clearly defined states. Each state represents a particular traffic-control condition.

The major states include:

| State      | Description                           |
| ---------- | ------------------------------------- |
| `N_GREEN`  | North traffic receives green          |
| `N_YELLOW` | North traffic enters transition phase |
| `E_GREEN`  | East traffic receives green           |
| `E_YELLOW` | East traffic enters transition phase  |
| `S_GREEN`  | South traffic receives green          |
| `S_YELLOW` | South traffic enters transition phase |
| `W_GREEN`  | West traffic receives green           |
| `W_YELLOW` | West traffic enters transition phase  |
| `PED`      | Pedestrian crossing phase             |
| `NIGHT`    | Blinking-yellow night operation       |

The high-level FSM sequence can be represented as:

```text
             ┌─────────────┐
             │   N_GREEN   │
             └──────┬──────┘
                    ↓
             ┌─────────────┐
             │  N_YELLOW   │
             └──────┬──────┘
                    ↓
             ┌─────────────┐
             │   E_GREEN   │
             └──────┬──────┘
                    ↓
             ┌─────────────┐
             │  E_YELLOW   │
             └──────┬──────┘
                    ↓
             ┌─────────────┐
             │   S_GREEN   │
             └──────┬──────┘
                    ↓
             ┌─────────────┐
             │  S_YELLOW   │
             └──────┬──────┘
                    ↓
             ┌─────────────┐
             │   W_GREEN   │
             └──────┬──────┘
                    ↓
             ┌─────────────┐
             │  W_YELLOW   │
             └──────┬──────┘
                    │
                    └──────────────► N_GREEN
```

Special operating conditions such as pedestrian requests, emergency requests, and night mode can modify the normal sequence according to the implemented control logic.

---

# 🔄 Normal Traffic Operation

During normal operation, the controller follows a cyclic sequence for the four traffic directions:

```text
North → East → South → West → North
```

Each direction receives a green phase followed by a yellow transition phase.

For example:

```text
N_GREEN
   ↓
N_YELLOW
   ↓
E_GREEN
   ↓
E_YELLOW
   ↓
S_GREEN
   ↓
S_YELLOW
   ↓
W_GREEN
   ↓
W_YELLOW
   ↓
N_GREEN
```

During a green state, the corresponding direction is allowed to proceed while the remaining directions are held at red.

The yellow state provides a transition interval before control is transferred to the next direction.

This state-based approach prevents conflicting green signals and provides a structured sequence for the intersection.

---

# 📊 Traffic Density Control

The controller accepts traffic-density information for the four directions:

```text
density_N
density_E
density_S
density_W
```

These inputs allow the controller to distinguish between normal and high traffic conditions.

The implemented timing behavior includes different phase durations based on traffic conditions.

Example timing configuration:

| Condition                |            Duration |
| ------------------------ | ------------------: |
| Normal Green Phase       | 5 clock-count units |
| High-Density Green Phase | 8 clock-count units |
| Yellow Phase             | 2 clock-count units |
| Pedestrian Phase         | 4 clock-count units |

When high traffic density is detected for the active direction, the green phase can be extended.

This provides an adaptive element compared with a completely fixed-time traffic controller.

---

# 🚑 Emergency Vehicle Priority

The controller includes an emergency input:

```text
emergency
```

When the emergency condition is activated, the controller gives priority to the emergency operating condition according to the implemented FSM logic.

Emergency handling demonstrates how **priority-based control** can be incorporated into an FSM-driven traffic system.

The current architecture uses a general emergency request rather than independently identifying the physical direction of an emergency vehicle.

A future version can extend this functionality with:

```text
Emergency_N
Emergency_E
Emergency_S
Emergency_W
```

to provide direction-specific emergency routing.

---

# 🚶 Pedestrian Crossing

Pedestrian requests are provided through:

```text
ped_request
```

When a pedestrian request is received, the controller can service the request through the dedicated pedestrian state.

During the pedestrian phase, vehicle traffic is placed into a safe signal configuration while the pedestrian walk signal is activated.

Conceptually:

```text
North → RED
East  → RED
South → RED
West  → RED

ped_walk → 1
```

The pedestrian phase uses a defined duration before returning control to the normal traffic sequence.

This approach allows pedestrian requests to be incorporated without disrupting the basic FSM structure.

---

# 🌙 Night Mode

The controller provides a dedicated night-mode state:

```text
NIGHT
```

Night mode is activated using:

```text
night_mode
```

During night operation, the controller uses a blinking-yellow behavior.

Conceptually:

```text
Yellow ON
    ↓
Yellow OFF
    ↓
Yellow ON
    ↓
Yellow OFF
    ↓
   Repeat
```

This represents a reduced-traffic operating mode in which the intersection uses flashing yellow signals instead of the normal sequential traffic cycle.

The blinking behavior is generated using an internal timing mechanism.

---

# ⏱️ Countdown Timer

The design includes a countdown output:

```text
countdown
```

The countdown tracks the remaining duration of the current traffic phase.

A typical phase can be represented as:

```text
5 → 4 → 3 → 2 → 1 → 0
                         ↓
                    Next State
```

The countdown provides useful timing information that can be displayed through external hardware such as:

* Seven-segment displays
* FPGA LEDs
* External digital displays
* Future traffic-management dashboards

The countdown is synchronized with the FSM's current operating phase.

---

# 🚨 E-Challan / Violation Detection

The project includes digital red-light violation detection.

Vehicle detection inputs are provided for each direction:

```text
vehicle_N
vehicle_E
vehicle_S
vehicle_W
```

The basic violation concept is:

```text
Vehicle Detected
       +
Corresponding RED Signal
       ↓
Violation Condition
       ↓
Challan Flag
```

For example:

```text
challan_N = vehicle_N && red_N
```

Equivalent logic is applied to the other directions.

The resulting flags can indicate that a vehicle was detected while the corresponding traffic signal was red.

## Digital-Level Implementation

The current implementation represents the e-challan functionality at the **RTL/simulation level**.

It generates digital violation flags based on the combination of:

1. Vehicle detection input
2. Corresponding red-light condition

The current design does not directly implement:

* Camera capture
* Automatic number-plate recognition
* OCR
* Vehicle database lookup
* Driver identification
* Online payment
* Real-world challan issuance

These capabilities can be integrated in future versions.

---

# 🔌 Inputs and Outputs

## Inputs

| Signal        | Description                  |
| ------------- | ---------------------------- |
| `clk`         | System clock                 |
| `reset`       | Controller reset             |
| `density_N`   | North traffic-density input  |
| `density_E`   | East traffic-density input   |
| `density_S`   | South traffic-density input  |
| `density_W`   | West traffic-density input   |
| `ped_request` | Pedestrian crossing request  |
| `emergency`   | Emergency-priority request   |
| `night_mode`  | Enables night-mode operation |
| `vehicle_N`   | North vehicle detection      |
| `vehicle_E`   | East vehicle detection       |
| `vehicle_S`   | South vehicle detection      |
| `vehicle_W`   | West vehicle detection       |

## Outputs

The controller generates traffic signals for four directions:

```text
North → RED / YELLOW / GREEN
East  → RED / YELLOW / GREEN
South → RED / YELLOW / GREEN
West  → RED / YELLOW / GREEN
```

Additional outputs include:

```text
countdown
ped_walk
challan_N
challan_E
challan_S
challan_W
```

These outputs provide both traffic-control information and additional system-status information.

---

# 🧪 Simulation and Verification

A dedicated Verilog testbench is included to verify the controller's behavior under different operating conditions.

The verification process covers major scenarios including:

* Normal traffic operation
* Traffic-density-based timing
* Pedestrian requests
* Emergency operation
* Night-mode operation
* Red-light violation detection
* Countdown behavior
* FSM state transitions

The design can be simulated using **Xilinx Vivado Behavioral Simulation**.

Waveforms allow the behavior of the controller to be inspected over time.

Important signals to observe include:

```text
FSM State
Traffic Light Outputs
Countdown
Pedestrian Walk
Emergency Input
Night Mode
Traffic Density
Vehicle Detection
Challan Flags
```

---

# 🔬 Simulation Flow

The overall verification process can be represented as:

```text
                 ┌─────────────┐
                 │    RESET    │
                 └──────┬──────┘
                        ↓
             ┌─────────────────────┐
             │ Normal Traffic Test │
             └──────────┬──────────┘
                        ↓
             ┌─────────────────────┐
             │ Density Timing Test │
             └──────────┬──────────┘
                        ↓
             ┌─────────────────────┐
             │ Pedestrian Request  │
             └──────────┬──────────┘
                        ↓
             ┌─────────────────────┐
             │ Violation Detection │
             └──────────┬──────────┘
                        ↓
             ┌─────────────────────┐
             │ Emergency Operation │
             └──────────┬──────────┘
                        ↓
             ┌─────────────────────┐
             │    Night Mode Test  │
             └──────────┬──────────┘
                        ↓
             ┌─────────────────────┐
             │ Waveform Analysis   │
             └──────────┬──────────┘
                        ↓
                 ┌─────────────┐
                 │   VERIFIED  │
                 └─────────────┘
```

The testbench provides stimulus to the design and the resulting waveforms can be inspected to verify state transitions and output behavior.

---

# 📂 Project Structure

The repository is organized around a Xilinx Vivado project:

```text
Smart_Traffic_FSM/
│
├── README.md
│
└── project_1657465/
    │
    ├── project_1657465.xpr
    │
    └── project_1657465.srcs/
        │
        ├── sources_1/
        │   └── new/
        │       └── traffic_controller_4junction_with_echallan.v
        │
        └── sim_1/
            └── new/
                └── tb_traffic_controller_4junction_with_echallan.v
```

### Main RTL Design

```text
traffic_controller_4junction_with_echallan.v
```

This file contains the Verilog implementation of the traffic controller and its associated control logic.

### Testbench

```text
tb_traffic_controller_4junction_with_echallan.v
```

This file provides simulation stimulus for verifying the traffic controller under different conditions.

### Vivado Project

```text
project_1657465.xpr
```

This is the Xilinx Vivado project file used to open and work with the design.

---

# 🛠️ Technologies Used

| Technology                | Purpose                          |
| ------------------------- | -------------------------------- |
| **Verilog HDL**           | RTL hardware description         |
| **Finite State Machine**  | Traffic-control architecture     |
| **Xilinx Vivado**         | Design and simulation            |
| **Behavioral Simulation** | Functional verification          |
| **Verilog Testbench**     | Automated simulation stimulus    |
| **RTL Design**            | Hardware-oriented implementation |
| **Waveform Analysis**     | Debugging and verification       |

---

# ▶️ How to Run

## 1. Clone the Repository

```bash
git clone https://github.com/the-ethereal12/Smart_Traffic_FSM.git
```

Then enter the repository:

```bash
cd Smart_Traffic_FSM
```

---

## 2. Open the Vivado Project

Launch **Xilinx Vivado**.

Open the project:

```text
project_1657465/project_1657465.xpr
```

---

## 3. Run Behavioral Simulation

Inside Vivado:

```text
Simulation
      ↓
Run Simulation
      ↓
Run Behavioral Simulation
```

Vivado will compile the RTL design and testbench and launch the waveform viewer.

---

## 4. Analyze the Waveforms

Observe the major signals during simulation:

```text
FSM State
Traffic Signals
Countdown
Pedestrian Walk
Emergency
Night Mode
Traffic Density
Vehicle Detection
Challan Flags
```

The waveform should demonstrate the expected state transitions and corresponding output behavior.

---

# 📈 Expected Behavior

During normal operation, the controller should cycle through the four traffic directions:

```text
North → East → South → West → North
```

Each direction passes through its corresponding green and yellow phases.

When high traffic density is detected, the active green phase can use an extended duration.

When a pedestrian request is received, the controller services it through the dedicated pedestrian state.

When emergency operation is activated, the controller handles the emergency condition according to its priority logic.

When night mode is enabled, the controller enters the blinking-yellow operating mode.

When a vehicle is detected while its corresponding traffic signal is red, the appropriate violation/challan flag is generated.

The countdown output provides the remaining phase timing information during the active state.

---

# ⚠️ Current Limitations

The current project is an **RTL-level academic implementation**. Therefore, several components of a real-world intelligent traffic system are outside the current scope.

### Emergency Detection

The current implementation uses an emergency input rather than a complete emergency-vehicle detection and localization system.

It does not currently determine the exact physical direction of an approaching emergency vehicle.

### Vehicle Detection

Vehicle detection is represented using digital input signals.

The project does not currently include physical:

* Cameras
* Radar
* LiDAR
* Ultrasonic sensors
* Computer-vision detection

### E-Challan

The e-challan functionality currently operates through digital violation flags.

It does not currently perform:

* Number-plate recognition
* OCR
* Vehicle identification
* Driver identification
* Database integration
* Online payment
* Automatic real-world challan generation

### Hardware Deployment

The current repository is primarily focused on RTL design and simulation.

Physical FPGA deployment would additionally require:

* FPGA board selection
* Pin constraints
* Clock configuration
* I/O mapping
* Hardware interfaces
* Physical validation

---

# 🚀 Future Enhancements

The architecture provides several possible directions for future development.

## 🚑 Direction-Specific Emergency Handling

The emergency system could be extended to accept independent directional inputs:

```text
Emergency_N
Emergency_E
Emergency_S
Emergency_W
```

This would allow the controller to determine which direction requires emergency priority.

---

## 📷 Computer-Vision-Based Vehicle Detection

A camera-based system could be integrated to automatically detect:

* Vehicles
* Traffic density
* Red-light violations
* Traffic incidents

Possible architecture:

```text
Camera
   ↓
Vehicle Detection
   ↓
Traffic Analysis
   ↓
Signal Controller
```

---

## 🔢 Automatic Number-Plate Recognition

The violation-detection subsystem could be extended using ANPR:

```text
Camera
   ↓
Vehicle Detection
   ↓
Number Plate Detection
   ↓
OCR / Recognition
   ↓
Vehicle Identification
   ↓
Violation Record
```

This would transform the current digital challan flag into a more complete automated enforcement pipeline.

---

## ☁️ IoT and Cloud Monitoring

The traffic controller could be connected to an IoT platform to monitor:

* Traffic density
* Signal states
* Emergency events
* Pedestrian requests
* Violation events
* Historical traffic statistics

---

## 🧠 Adaptive Traffic Optimization

Future versions could incorporate more advanced optimization or machine-learning methods to determine signal timing from:

* Real-time traffic density
* Historical traffic patterns
* Time of day
* Emergency conditions
* Pedestrian demand

This could transform the fixed FSM timing system into a more adaptive traffic-management platform.

---

## 🖥️ Traffic Management Dashboard

A monitoring dashboard could provide real-time information such as:

```text
┌─────────────────────────────────────┐
│       SMART TRAFFIC MONITOR         │
├─────────────────────────────────────┤
│ North Signal      : GREEN           │
│ East Signal       : RED             │
│ South Signal      : RED             │
│ West Signal       : RED             │
│                                     │
│ Countdown          : 04              │
│ Traffic Density    : HIGH            │
│ Pedestrian Request : NO              │
│ Emergency          : NO              │
│ Violations         : 02              │
└─────────────────────────────────────┘
```

---

## ⚙️ FPGA Implementation

The design could be deployed on an FPGA development board.

Possible hardware components include:

* LEDs for traffic signals
* Seven-segment display for countdown
* Push buttons for pedestrian requests
* Switches for emergency mode
* Sensor inputs
* Hardware clock
* External display interfaces

This would provide a physical demonstration of the RTL traffic controller.

---

# 🌍 Applications

The architecture demonstrated in this project can serve as a foundation for:

* Smart-city traffic control
* FPGA-based traffic controllers
* Digital logic design education
* Intelligent transportation systems
* Embedded traffic-control systems
* FSM design demonstrations
* Hardware-based traffic simulations
* Traffic signal prototyping
* Future IoT-connected traffic systems
* Academic RTL and digital-design projects

---

# 📚 Digital Design Concepts

This project demonstrates several important concepts in digital system design.

## Finite State Machines

The traffic controller is modeled using explicit states and transitions.

Each state represents a particular traffic-control condition.

---

## Sequential Logic

State and timing information are maintained synchronously using the system clock.

---

## Combinational Logic

Traffic-light outputs and control decisions depend on the current state and relevant input conditions.

---

## Priority Logic

Emergency requests and special operating modes introduce priority-based control behavior into the FSM.

---

## Timing and Counters

Counters are used to determine the duration of traffic phases and support countdown functionality.

---

## Input Processing

The controller processes multiple types of input:

* Traffic density
* Vehicle detection
* Pedestrian requests
* Emergency requests
* Night-mode activation
* Reset and clock

---

## RTL Verification

A dedicated testbench is used to provide simulation inputs and observe the resulting controller behavior.

Waveform analysis helps verify:

* State transitions
* Signal outputs
* Timing
* Pedestrian operation
* Emergency handling
* Night mode
* Violation detection

---

# 🏁 Conclusion

Smart Traffic FSM demonstrates the design and simulation of an **intelligent four-way traffic-light controller using Verilog HDL and Finite State Machine architecture**.

The system extends the concept of a basic fixed-sequence traffic controller by incorporating several additional operating modes and control mechanisms, including:

* Four-direction traffic management
* Traffic-density-based timing
* Emergency priority
* Pedestrian crossing
* Night-mode operation
* Countdown timing
* Digital red-light violation detection

The project demonstrates how **FSM modeling, sequential logic, combinational logic, counters, priority handling, input processing, and RTL verification** can be combined to create a structured digital traffic-control system.

The current implementation operates at the **RTL and simulation level**, providing a foundation that can be further extended toward physical FPGA deployment and intelligent transportation applications.

Future development can integrate physical traffic sensors, FPGA hardware, computer vision, automatic number-plate recognition, IoT connectivity, centralized monitoring, and adaptive traffic optimization.

Overall, the project provides a practical demonstration of how **digital hardware design principles can be applied to intelligent traffic-management problems**.

---

# 👥 Team Project

This project was developed as a **collaborative group project**.

The project covers multiple areas of digital-system development, including:

* FSM architecture
* Verilog RTL implementation
* Traffic-control logic
* Timing and countdown design
* Traffic-density handling
* Emergency-priority handling
* Pedestrian-control logic
* Night-mode implementation
* Violation-detection logic
* Verilog testbench development
* Behavioral simulation
* Waveform analysis
* Technical documentation

---

# 📄 License

This project is developed for **educational and academic purposes**.

---

# 🔗 Repository

**GitHub Repository:**
[https://github.com/the-ethereal12/Smart_Traffic_FSM](https://github.com/the-ethereal12/Smart_Traffic_FSM)

```

This is the **complete version** — the Table of Contents now corresponds to sections that actually continue all the way through the README, rather than ending around the architecture portion.
```
