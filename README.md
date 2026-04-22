# Systolic Array Matrix Multiplier (Verilog RTL)

## Project Summary
Designed and implemented a 2×2 Systolic Array-based Matrix Multiplier in Verilog RTL, utilizing a weight-stationary dataflow architecture where weights remain locally stored within processing elements. The Weights are loaded once and then reused for multiple cycles.

---

## Systolic Array
- 2×2 grid of Processing Elements (PEs)
- **Row-wise streaming** of matrix A
- **Column-wise propagation** of matrix B
- Partial sums accumulated across pipeline stages

---

## Processing Element (PE) Design
The Processing Element (PE) is the fundamental building block of the systolic array architecture. Each PE performs a **Multiply-Accumulate (MAC)** operation and enables efficient data propagation across the array.

### Functional Description
Each PE takes three inputs:
- `ain` → Input activation (from left)
- `bin` → Weight (from top)
- `cin` → Partial sum (from upper PE)

It produces:
- `aout` → Forwarded activation (to the right)
- `bout` → Forwarded weight (to the bottom)
- `psum` → Updated partial sum

The core computation performed is:
psum = (ain × weight) + cin

Some additional control signaling I used for proper dataflow across the systolic array:
- `clk` → System clock signal
- `rst_n` → Active-low reset signal
- `in_valid` → Input valid signal for weight.
- `out_valid` → Output valid signal for weight.
  
The signals `in_valid` and `out_valid` is used to control dataflow and enable weight-stationary behavior. When `in_valid` is high, weights are loaded into the Processing Elements (PEs) and stored in internal registers. When `in_valid` is low, the stored weights are retained, making them **stationary** and reusable across multiple cycles. The `out_valid` signal from each PE is propagated to the next stage as `in_valid`.

The dataflow during various cycles are shown below:



