# Systolic Array Implementation

## Overview

This repository contains a Verilog implementation of a Systolic Array, designed for efficient parallel processing. Systolic arrays are a class of MIMD (Multiple Instruction, Multiple Data) parallel computer architectures that are highly suitable for compute-intensive tasks such as matrix multiplication, digital signal processing, and image processing, due to their regular and local data flow.

This project focuses on a fundamental Systolic Array design, complete with processing elements (PEs), a top-level array module, and a testbench for verification.

## Project Structure

The project is organized into the following main directories and files:
SystolicArray/ ├── out/ │ ├── tb_systolic_array.v.out # Simulation output log │ └── tb_wave.vcd # Value Change Dump (VCD) file for waveform analysis ├── pic/ │ ├── Device.png # Visual representation of the device in Vivado │ ├── time summary.png # Vivado Time Summary report │ ├── utilization table.png # Vivado Resource Utilization report │ └── Waveform.webp # Waveform visualization from simulation ├── src/ │ ├── pe.v # Processing Element (PE) module │ ├── systolic_array.v # Top-level Systolic Array module │ └── tb_systolic_array.v # Testbench for the Systolic Array ├── file.xdc # Xilinx Design Constraints file (if used for synthesis) ├── LICENSE # Project license (e.g., MIT, Apache 2.0) └── README.md # This README file

## Features

* **Modular Design:** Separate modules for Processing Elements (`pe.v`) and the overall `systolic_array.v` for clear hierarchy.
* **Testbench Included:** A comprehensive testbench (`tb_systolic_array.v`) for functional verification and waveform generation.
* **Vivado Integration:** Includes Vivado project constraints (`file.xdc`) and synthesis/implementation reports (visualized in `pic/`).

## Getting Started

### Prerequisites

* Vivado Design Suite (for synthesis, implementation, and detailed reports)
* Verilog simulator (e.g., Icarus Verilog, ModelSim, or Vivado Simulator) for testbench execution.

### Simulation

To simulate the design:

1.  Navigate to the `src` directory.
2.  Use your preferred Verilog simulator to run `tb_systolic_array.v`.
    * Example with Icarus Verilog:
        ```bash
        iverilog -o tb_systolic_array tb_systolic_array.v pe.v systolic_array.v
        vvp tb_systolic_array
        # This will generate tb_wave.vcd in the 'out/' directory
        ```
3.  View the generated `tb_wave.vcd` using a waveform viewer (e.g., GTKWave).

### Synthesis & Implementation (with Vivado)

1.  Open Vivado Design Suite.
2.  Create a new RTL project.
3.  Add the Verilog files from the `src/` directory (`pe.v`, `systolic_array.v`).
4.  Add the XDC file (`file.xdc`) if applicable.
5.  Run synthesis, implementation, and bitstream generation.

## Visuals

Here are some key visual outputs from the project:

### Device View in Vivado
*A visual representation of the implemented Systolic Array on the target FPGA device, as seen in Vivado.*



### Time Summary Report
*A snapshot of the Time Summary report from Vivado, indicating timing performance after implementation.*


### Resource Utilization Table
*A table detailing the FPGA resource usage (LUTs, FFs, DSPs) for the Systolic Array design.*