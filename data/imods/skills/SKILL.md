---
name: imods
description: The imods toolkit performs normal mode analysis in internal coordinates to explore the conformational flexibility and structural transitions of macromolecules. Use when user asks to calculate vibrational modes, animate molecular motions, generate morphing trajectories between two structures, or perform Monte-Carlo sampling in modal space.
homepage: https://chaconlab.org/multiscale-simulations/imod
metadata:
  docker_image: "quay.io/biocontainers/imods:1.0.4--h9ee0642_3"
---

# imods

## Overview

The `imods` (iMOD) toolkit provides a specialized framework for exploring the conformational flexibility of macromolecules. Unlike standard Cartesian NMA, `imods` operates in internal coordinates (dihedral angles), which naturally preserves bond lengths and angles, making it highly efficient for large systems. It supports multiple coarse-graining levels—from single-atom (Cα) to full-heavy-atom representations—and allows for extensive customization of the potential energy model through distance-dependent functions or secondary structure-based constraints.

## Core Workflows

### 1. Normal Mode Analysis (iMODE)
The primary tool for calculating eigenvectors and eigenvalues in internal coordinates.

*   **Basic Usage:** `imode <input.pdb>`
*   **Coarse-Graining:** Use `-m` to define the model: `0` (Cα), `1` (C5/3BB2R), or `2` (Full-atom, default).
*   **Deformability:** Add `-d` to calculate atomic deformability and mobility (saved to `imode_def.pdb`).
*   **Large Systems:** For systems exceeding memory limits, use `-r <float>` (e.g., `-r 0.5`) to randomly fix a ratio of dihedrals, reducing the degrees of freedom.

### 2. Motion Animation (iMOVE)
Generates a trajectory showing the vibrational motion of a specific mode.

*   **Command:** `imove <model.pdb> <modes.evec> <output.pdb> <mode_number>`
*   **Amplitude:** Adjust the motion scale with `-a <float>` (default is 2.0).
*   **Conformations:** Set the number of frames with `-c <int>` (must be an odd number).

### 3. Morphing Trajectories (iMORPH)
Generates a plausible transition path between two different conformations of the same molecule.

*   **Command:** `imorph <initial.pdb> <target.pdb>`
*   **Requirement:** Both PDB files must have the exact same atom count and naming.
*   **Output:** Produces a multi-model PDB (`imorph_movie.pdb`) and a convergence score file.

### 4. Monte-Carlo Simulations (iMC)
Performs sampling in the modal space to generate a diverse ensemble of conformations.

*   **Command:** `imc <input.pdb> <modes.evec>`
*   **Sampling:** Control the number of iterations per frame with `-i <int>` and the total output frames with `-c <int>`.

## Expert Tips & Best Practices

*   **PDB Preparation:** `imods` requires all heavy atoms to be present for Internal Coordinate calculations. Always pre-process PDBs to fix missing atoms or alternative locations before running `imode`.
*   **Cα Model Requirement:** If using the Cα model (`-m 0`), the input PDB must contain backbone N, Cα, and C atoms to define the dihedral angles. A PDB containing *only* Cα atoms will fail.
*   **Visualization:** To visualize modes as arrows in VMD, you must first run `imode` with the `--save_cart` flag to generate Cartesian eigenvectors, then use `imodview`.
*   **Custom Potentials:** Use the `--func` option with a parameter file to apply different force constants to specific secondary structures (e.g., making loops more flexible than helices).
*   **Memory Management:** For 64-bit systems, memory usage scales with the square of the degrees of freedom. If the Hessian rank is >50,000, utilize the `-S` (fix by secondary structure) or `-r` (random fix) options to make the computation feasible on standard workstations.



## Subcommands

| Command | Description |
|---------|-------------|
| imc | Monte-Carlo IC-NMA based program v1.11 |
| imodview | Cartesian Normal Modes and Springs Visualization tool |
| imove | Internal coordinates MOVEment tool. |

## Reference documentation

- [iMOD Intro](./references/chaconlab_org_multiscale-simulations_imod_imod-intro.md)
- [iMOD Tutorial](./references/chaconlab_org_multiscale-simulations_imod_imod-tutorial.md)
- [iMOD Tips and Tricks](./references/chaconlab_org_multiscale-simulations_imod_imod-tips.md)