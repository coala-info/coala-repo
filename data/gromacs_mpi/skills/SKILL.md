---
name: gromacs_mpi
description: This skill provides guidance for utilizing GROMACS (GROningen MAchine for Chemical Simulations) in an MPI-enabled environment.
homepage: http://www.gromacs.org/
---

# gromacs_mpi

## Overview
This skill provides guidance for utilizing GROMACS (GROningen MAchine for Chemical Simulations) in an MPI-enabled environment. It focuses on the workflow of transforming initial structures into production-ready simulations and performing subsequent trajectory analysis. It is designed for researchers needing to execute `gmx_mpi` commands for force field application, solvation, energy minimization, equilibration, and production runs.

## Core Workflow Patterns

### 1. System Preparation
Before running a simulation, the structure must be processed into a GROMACS topology.
- **Generate Topology**: `gmx_mpi pdb2gmx -f protein.pdb -o processed.gro -p topol.top`
- **Define Box**: `gmx_mpi editconf -f processed.gro -o newbox.gro -c -d 1.0 -bt cubic`
- **Solvate**: `gmx_mpi solvate -cp newbox.gro -cs spc216.gro -o solvated.gro -p topol.top`
- **Add Ions**: 
  1. Create a `.tpr` file: `gmx_mpi grompp -f ions.mdp -c solvated.gro -p topol.top -o ions.tpr`
  2. Replace solvent with ions: `gmx_mpi genion -s ions.tpr -o solvated_ions.gro -p topol.top -pname NA -nname CL -neutral`

### 2. Running Simulations with MPI
GROMACS uses the `mdrun` command for the actual calculation. In an MPI context, this is typically invoked via `mpirun` or `srun`.

- **Standard MPI Execution**: `mpirun -np [cores] gmx_mpi mdrun -v -deffnm em`
- **Performance Tuning**:
  - Use `-ntomp` to specify OpenMP threads per MPI rank for hybrid parallelization.
  - Use `-nb gpu` to offload non-bonded interactions if GPUs are available.
  - Example: `mpirun -np 4 gmx_mpi mdrun -v -deffnm production -ntomp 8 -nb gpu`

### 3. Essential Simulation Steps
1. **Energy Minimization**: `gmx_mpi grompp -f em.mdp -c solvated_ions.gro -p topol.top -o em.tpr` followed by `mdrun`.
2. **Equilibration (NVT/NPT)**: Use position restraints (`-r`) to stabilize the protein while the solvent relaxes.
3. **Production MD**: The final run where data is collected for analysis.

### 4. Analysis and Trajectory Handling
- **Correcting Periodic Boundary Conditions (PBC)**: `gmx_mpi trjconv -s topol.tpr -f traj.xtc -o fixed.xtc -pbc mol -center`
- **RMSD Calculation**: `gmx_mpi rms -s crystal.tpr -f fixed.xtc -o rmsd.xvg`
- **Energy Extraction**: `gmx_mpi energy -f ener.edr -o energy.xvg`

## Expert Tips
- **Checkpointing**: GROMACS automatically writes `.cpt` files. Resume a crashed run using `gmx_mpi mdrun -s topol.tpr -cpi state.cpt`.
- **MPI Efficiency**: For small systems, too many MPI ranks can decrease performance due to communication overhead. Aim for ~500-1000 atoms per core as a rule of thumb.
- **Grompp Validation**: Always check the output of `gmx_mpi grompp` for warnings. While `-maxwarn` can bypass them, it is safer to address the underlying physics issues.

## Reference documentation
- [GROMACS Webpage Overview](./references/www_gromacs_org_index.md)
- [Bioconda GROMACS MPI Package Details](./references/anaconda_org_channels_bioconda_packages_gromacs_mpi_overview.md)