# Smart_Traffic_FSM

## Overview
This project implements an **advanced Finite State Machine (FSM) based traffic light controller** for a four-way junction. Developed in **Verilog** and simulated in **Vivado**, it handles multiple real-world traffic scenarios.

## Features
- **Normal Traffic Operation** – standard traffic light cycle with countdown timers.  
- **Emergency Vehicle Override** – green signal priority for emergency vehicles.  
- **Pedestrian Request Handling** – allows safe pedestrian crossings.  
- **Night Mode** – blinking yellow lights during low traffic periods.  
- **E-Challan Integration** – marks traffic violations automatically (simulation-based).  

## How to Run
1. Open the project in **Vivado**.  
2. Add source files and testbench.  
3. Run **simulation** to verify functionality.
4. Check waveform screenshots to validate all features.

## Notes
- `.gitignore` is included to ignore Vivado temporary files like `*.runs`, `.cache`, `.Xil`, etc.  
- Designed for **educational and portfolio purposes**; can be extended for real hardware.  
