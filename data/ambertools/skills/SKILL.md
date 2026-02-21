---
name: ambertools
description: This skill provides a streamlined workflow for setting up and analyzing molecular dynamics simulations.
homepage: https://github.com/quantaosun/Ambertools-OpenMM-MD
---

# ambertools

## Overview
This skill provides a streamlined workflow for setting up and analyzing molecular dynamics simulations. It focuses on using AmberTools for system preparation (topology and coordinate generation) and MMPBSA.py for post-simulation energetic analysis. It is particularly useful for researchers needing to parameterize small molecules with the General Amber Force Field (GAFF) and calculate binding free energies from trajectory data.

## Environment Setup
Before running AmberTools commands, ensure the environment is correctly sourced and dependencies are available.
- **Amber Home**: Always define the Amber home directory: `source /usr/local/amber.sh` (or your specific installation path).
- **Conda Environment**: Use a dedicated environment containing `openmm`, `ambertools`, and `openbabel`.

## System Preparation & Parameterization
When preparing protein-ligand complexes:
- **Force Fields**: Use Amber force fields for proteins and GAFF/GAFF2 for small molecules.
- **Hydrogen Addition**: Be cautious with `reduce` or `obabel`. If you encounter "odd electron number" errors, verify the chemical structure. Pymol's `h_add` is a reliable alternative for manual correction.
- **Protonation**: Use the H++ webserver or PDBfixer. If residues are consistently missing, consider using AlphaFold2 predicted structures as starting points.

## Binding Free Energy Calculation (MMGBSA/PBSA)
The `MMPBSA.py` tool is used to calculate binding free energies and per-residue decomposition.

### 1. Create Input File (`mmpbsa.in`)
Define the simulation range and method parameters:
```text
&general
  endframe=1000, interval=100,
  strip_mask=:WAT:Na+:Cl-:Mg+:K+,
/
&gb
  igb=2, saltcon=0.15,
/
&decomp
  idecomp=1,
/
```

### 2. Generate Topology Files (`ante-MMPBSA.py`)
Create the necessary stripped topology files for the complex, receptor, and ligand:
```bash
ante-MMPBSA.py -p SYS_gaff2.prmtop -c com.prmtop -r rec.prmtop -l ligand.prmtop -s :WAT:Na+:Cl-:Mg+:K+ -n :LIG --radii mbondi2
```

### 3. Run Analysis (`MMPBSA.py`)
Execute the energy calculation using the generated topologies and the simulation trajectory:
```bash
MMPBSA.py -O -i mmpbsa.in -o FINAL_RESULTS_MMPBSA_decomposition.dat -sp SYS_gaff2.prmtop -cp com.prmtop -rp rec.prmtop -lp ligand.prmtop -y trajectory.dcd
```

## Expert Tips & Troubleshooting
- **Trajectory Handling**: Ensure the trajectory file (`.dcd` or `.nc`) matches the topology file in terms of atom ordering.
- **Masking**: Double-check the `strip_mask` in `mmpbsa.in` to ensure all solvent and ions are correctly removed before energy evaluation.
- **Decomposition**: GB-based decomposition (`igb=2` or `5`) is generally faster and easier to converge for beginners than PB-based methods.
- **Structure Cleanup**: Delete repeated chains in PDB files to increase simulation speed and prevent "multiple chain" errors during parameterization.

## Reference documentation
- [Ambertools-OpenMM-MD README](./references/github_com_quantaosun_Ambertools-OpenMM-MD.md)