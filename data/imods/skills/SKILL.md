---
name: imods
description: The imods toolkit uses internal coordinate Normal Mode Analysis to explore the conformational space and flexibility of biological macromolecules. Use when user asks to calculate normal modes, animate vibrations, visualize modes, perform Monte-Carlo sampling, morph between conformations, or determine structural deformability.
homepage: https://chaconlab.org/multiscale-simulations/imod
---


# imods

## Overview
The imods toolkit (iMOD) is a specialized suite for exploring the conformational space of biological macromolecules using Normal Mode Analysis in internal coordinates. Unlike Cartesian-based NMA, this approach naturally preserves bond lengths and angles, making it highly efficient for large systems. Use this skill to determine structural deformability, create transition trajectories between different states (morphing), or simulate thermal fluctuations through Monte-Carlo sampling.

## Core Workflows

### 1. Calculating Normal Modes (iMODE)
The primary tool for generating eigenvectors and eigenvalues.
- **Basic Usage**: `imode <input.pdb>`
- **Coarse-Graining**: Use `-m` to handle large systems or different resolutions.
  - `-m 0`: Cα-only (requires N, Cα, and C atoms).
  - `-m 1`: 3BB2R (5 atoms per residue).
  - `-m 2`: Full-atom (default).
- **Potential Models**: Customize the spring network using `-P`.
  - `-P 0`: Sigmoid/Inverse exponential (default).
  - `-P 1`: Tirion's cutoff.
- **Key Outputs**:
  - `imode_ic.evec`: The internal coordinate eigenvectors.
  - `imode_model.pdb`: The model used for calculation.

### 2. Animating Vibrations (iMOVE)
Generates a multi-model PDB showing the motion of a specific mode.
- **Command**: `imove <model.pdb> <modes.evec> <output.pdb> <mode_number>`
- **Scaling**: Use `-a <float>` to adjust the amplitude (default is 2.0).
- **Frames**: Use `-c <int>` to set the number of snapshots (must be an odd number).

### 3. Visualizing with VMD (iMODVIEW)
Creates a VMD script to represent modes as arrows or springs.
- **Arrows**: `imodview <pdb> <cartesian_modes.evec> <output.vmd> -n <mode_index> -c <color>`
- **Springs**: `imodview <pdb> <Kfile.dat> <output.vmd> --op 2`
- **Note**: Requires Cartesian modes. Generate these in iMODE using the `--save_cart` flag.

### 4. Sampling and Morphing (iMC & iMORPH)
- **Monte-Carlo**: `imc <pdb> <modes.evec>` generates a stochastic trajectory based on computed modes.
- **Morphing**: `imorph <start.pdb> <target.pdb>` produces a trajectory of the transition between two conformations. Both PDBs must have identical atom counts and naming.

## Expert Tips & Best Practices
- **PDB Preparation**: iMOD requires all heavy atoms for full-atom models. Use tools like MolProbity or pdb2pqr to fix missing atoms before running `imode`.
- **Memory Management**: For systems >15,000 degrees of freedom on 32-bit systems, or very large complexes on 64-bit systems, use Coarse-Graining (`-m 0` or `-m 1`) to reduce the Hessian matrix size.
- **Deformability**: Run `imode -d <pdb>` to calculate atomic mobility and deformability, which are written to the B-factor column of the output PDBs for easy visualization in molecular viewers.
- **Fixing Coordinates**: To simulate restricted environments (e.g., a protein domain fixed in a membrane), use the `-f` option with a fixation file to remove specific internal coordinates from the calculation.

## Reference documentation
- [iMOD User Guide](./references/chaconlab_org_multiscale-simulations_imod.md)
- [iMOD Tips and Coarse Graining](./references/chaconlab_org_multiscale-simulations_imod_imod-tips.md)
- [iMOD Tutorial](./references/chaconlab_org_multiscale-simulations_imod_imod-tutorial.md)