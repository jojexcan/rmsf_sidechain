# RMSF Sidechain per Residue in VMD

This repository contains a memory-efficient Tcl script to calculate the **Root Mean Square Fluctuation (RMSF)** of **sidechain atoms** per residue, using trajectory files loaded into **VMD (Visual Molecular Dynamics)**.

## Why Analyze Sidechain RMSF?

Analyzing the Root Mean Square Fluctuation (RMSF) of sidechain atoms provides valuable insights into the local flexibility and dynamic behavior of individual residues throughout a molecular dynamics simulation. Unlike backbone RMSF, sidechain fluctuations are often more sensitive to functional motions, conformational variability, and ligand interactions. This makes sidechain RMSF particularly useful for identifying flexible loops, surface regions, or dynamic domains, and for probing the mobility of residues within active sites or binding pockets.

By assessing sidechain RMSF, you can evaluate the structural stability of a protein under different conditions (e.g., mutations, ligand binding, or environmental changes), detect allosteric effects that propagate through the structure, and validate the consistency of simulations with experimental data. It is also a valuable tool for guiding rational mutagenesis to improve stability or function, comparing homologous proteins or variants, and identifying cryptic pockets that may serve as novel drug targets.

---

## How does this script work?

- Loads your **structure** (e.g., `.psf`) and **trajectory** (e.g., `.dcd`) in VMD — though you can modify it for any VMD-compatible format.
- Selects **sidechain atoms only** (excluding hydrogens and protein backbone atoms).
- Computes the **RMSF per atom**, then averages the values **per residue**.
- It is optimized for **very low memory usage**, making it ideal for:
  - Large protein systems
  - Long trajectories
- Outputs a simple text file with **average sidechain RMSF per residue**.

To run the script in text mode (no GUI), use:

```bash
vmd -dispdev text -e rmsf_sidechain.tcl
