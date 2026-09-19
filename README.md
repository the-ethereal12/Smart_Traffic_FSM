# 🚦 Smart Traffic FSM

## Advanced FSM-Based Intelligent Traffic Light Controller for a Four-Way Junction

Smart Traffic FSM is a **Verilog HDL-based intelligent traffic control system** designed to manage a four-way road intersection using a **Finite State Machine (FSM)** architecture.

The controller manages traffic signals for **North, East, South, and West** directions while incorporating traffic-density-based timing, emergency vehicle priority, pedestrian crossing requests, night-mode operation, countdown timing, and simulation-based red-light violation detection.

The project demonstrates the practical application of **digital logic design, RTL architecture, sequential and combinational logic, FSM-based control, timing logic, priority handling, and hardware-oriented simulation** using **Xilinx Vivado**.

> **Project Type:** Group / Academic Digital Design Project  
> **HDL:** Verilog  
> **Design Approach:** Finite State Machine (FSM)  
> **Simulation:** Xilinx Vivado Behavioral Simulation  
> **Application:** Intelligent Transportation Systems

---

## 📌 Table of Contents

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
- [Limitations](#-current-limitations)
- [Future Enhancements](#-future-enhancements)
- [Applications](#-applications)
- [Conclusion](#-conclusion)
- [Team Project](#-team-project)
- [License](#-license)

---

## 🔎 Overview

Traditional traffic light controllers generally operate using predefined timing sequences. This project extends the basic traffic-light concept by introducing an FSM-based controller capable of responding to multiple operating conditions.

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

## 🎯 Objectives

The main objectives of the project are:

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

## ✨ Key Features

| Feature | Description |
|---|---|
| 🚦 Four-Way Control | Controls traffic signals for North, East, South, and West |
| 🧠 FSM Controller | Uses a 10-state finite state machine |
| 📊 Traffic Density | Adjusts green duration according to density input |
| 🚑 Emergency Priority | Provides priority operation when emergency input is activated |
| 🚶 Pedestrian Mode | Provides a dedicated pedestrian crossing phase |
| 🌙 Night Mode | Enables blinking-yellow operation |
| ⏱️ Countdown Timer | Tracks remaining duration of the active phase |
| 🚨 Violation Detection | Generates digital flags for vehicles detected during red signals |
| 🧪 Testbench | Includes a dedicated Verilog testbench |
| 📈 Waveform Verification | Supports behavioral simulation and waveform analysis |
| 💻 RTL Implementation | Designed using synthesizable hardware-description concepts |

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
                    │  Timer Management            │
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
