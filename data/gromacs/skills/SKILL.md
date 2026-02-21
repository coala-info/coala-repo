---
name: gromacs
description: GROMACS is a high-performance molecular dynamics package designed for simulating the Newtonian equations of motion for systems ranging from hundreds to millions of particles.
homepage: https://www.gromacs.org/
---

# gromacs

## Overview

GROMACS is a high-performance molecular dynamics package designed for simulating the Newtonian equations of motion for systems ranging from hundreds to millions of particles. While optimized for biochemical molecules like proteins, lipids, and nucleic acids, its efficiency in calculating nonbonded interactions makes it suitable for non-biological systems like polymers and fluids. Use this skill to navigate the standard simulation pipeline, optimize performance across CPU/GPU architectures, and manage simulation parameters (.mdp files).

## Installation and Setup

Install GROMACS via Bioconda for a pre-configured environment:

```bash
conda install bioconda::gromacs
```

For high-performance environments, ensure the binary is compiled with SIMD support and linked against appropriate GPU libraries (CUDA, OpenCL, or SYCL) to exploit hardware acceleration.

## Core Command Line Patterns

GROMACS uses a single wrapper command, `gmx`, followed by specific modules.

### 1. System Preparation
Convert a PDB file to a GROMACS topology and structure:
```bash
gmx pdb2gmx -f protein.pdb -o protein_processed.gro -p topol.top -water spce
```
*   **Expert Tip**: Choose a force field (e.g., AMBER, CHARMM, OPLS) that matches your molecular system. User-contributed force fields can be added to the working directory.

### 2. Defining the Box and Solvation
Define the simulation box dimensions and fill with solvent:
```bash
gmx editconf -f protein_processed.gro -o protein_newbox.gro -c -d 1.0 -bt cubic
gmx solvate -cp protein_newbox.gro -cs spc216.gro -o protein_solv.gro -p topol.top
```

### 3. Adding Ions
Neutralize the system by replacing solvent molecules with ions:
```bash
gmx grompp -f ions.mdp -c protein_solv.gro -p topol.top -o ions.tpr
gmx genion -s ions.tpr -o protein_solv_ions.gro -p topol.top -pname NA -nname CL -neutral
```

### 4. Simulation Execution (The `mdrun` Module)
The `mdrun` module handles energy minimization, equilibration, and production:
```bash
gmx grompp -f md.mdp -c protein_equil.gro -t protein_equil.cpt -p topol.top -o production.tpr
gmx mdrun -deffnm production -v
```

## Performance Optimization

### GPU Acceleration
GROMACS can offload nonbonded interactions and PME (Particle Mesh Ewald) to GPUs:
*   Use `-nb gpu` to offload nonbonded forces.
*   Use `-pme gpu` for PME calculation offloading.
*   Use `-bonded gpu` for bonded interactions (available in newer versions).

### Parallelization
*   **Thread-MPI**: For single-node runs, GROMACS uses internal threading. Control with `-nt <threads>`.
*   **MPI**: For multi-node clusters, use `mpirun` or `srun` with the MPI-enabled `gmx_mpi` binary.
*   **Load Balancing**: Use `-dlb yes` to enable dynamic load balancing if the system density varies significantly during simulation.

## Simulation Parameters (.mdp)

The `.mdp` file controls every aspect of the simulation. Key sections to verify:
*   **Integrator**: `md` for leap-frog dynamics, `steep` for energy minimization.
*   **Time step**: Typically `0.002` ps for constrained systems.
*   **Temperature/Pressure Coupling**: Use `v-rescale` for temperature and `Parrinello-Rahman` for pressure in production runs.
*   **Nonbonded settings**: Ensure `rvdw` and `rcoulomb` match the requirements of your chosen force field.

## Trajectory Analysis

GROMACS provides a suite of tools for post-simulation analysis:
*   **RMSD**: `gmx rms -s reference.tpr -f trajectory.xtc`
*   **Radius of Gyration**: `gmx gyrate -s reference.tpr -f trajectory.xtc`
*   **Distance**: `gmx distance -s reference.tpr -f trajectory.xtc -select 'resname "LIG"'`

Use lossy compression for coordinates in the `.mdp` file (`compressed-x-grps`) to save disk space without sacrificing significant accuracy for analysis.

## Reference documentation
- [About GROMACS](./references/www_gromacs_org_about.html.md)
- [Installation via Bioconda](./references/anaconda_org_channels_bioconda_packages_gromacs_overview.md)
- [Tutorials and MDP Parameters](./references/www_gromacs_org_tutorial_webinar.html.md)
- [User Contributed Force Fields](./references/www_gromacs_org_user_contributions.html.md)