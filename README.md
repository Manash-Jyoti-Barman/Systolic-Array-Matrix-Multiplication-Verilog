# 2×2 Systolic Array for Matrix Multiplication (Verilog)

## Overview
This project implements a **2×2 Systolic Array Architecture** in Verilog for performing matrix multiplication using a **datapath and controller design methodology**.

Systolic arrays are widely used in:
- AI/ML accelerators (e.g., TPUs)
- Digital Signal Processing (DSP)
- High-performance computing

This design demonstrates efficient **parallel computation**, **pipelined data flow**, and **modular RTL design**.

---

## Architecture

The system is divided into the following major components:

### Processing Element (PE)
- Core computational unit
- Performs **Multiply-Accumulate (MAC)** operation
- Stores intermediate partial sums

**Operation:**
```verilog
psum <= cin + (a_in * b);
