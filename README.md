# RMSF Sidechain per Residue in VMD

This repository contains a memory-efficient Tcl script to calculate the **Root Mean Square Fluctuation (RMSF)** of **sidechain atoms** per residue, using trajectory files loaded into **VMD (Visual Molecular Dynamics)**.

---

## How does this script work?

- Loads your **structure** (e.g., `.psf`) and **trajectory** (e.g., `.dcd`) in VMD — though you can modify it for any VMD-compatible format.
- Selects **sidechain atoms only** (excluding hydrogens).
- Computes the **RMSF per atom**, then averages the values **per residue**.
- It is optimized for **very low memory usage**, making it ideal for:
  - Large protein systems
  - Long trajectories
- Outputs a simple text file with **average sidechain RMSF per residue**.

To run the script in text mode (no GUI), use:

```bash
vmd -dispdev text -e rmsf_sidechain.tcl
