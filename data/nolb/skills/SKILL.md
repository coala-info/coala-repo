---
name: nolb
description: The nolb tool performs non-linear rigid block normal mode analysis to model the dynamic motions and large-amplitude deformations of molecular structures. Use when user asks to compute normal modes, generate non-linear trajectories of conformational changes, or create structural ensembles for flexible docking.
homepage: https://team.inria.fr/nano-d/software/nolb-normal-modes/
---


# nolb

## Overview
The `nolb` skill enables the execution of the NOn-Linear rigid Block NMA approach, a computationally efficient method for analyzing the dynamic motions of molecular structures. Unlike traditional linear NMA, this tool interprets the angular velocity of residues as rotations about specific centers, allowing for more realistic large-amplitude deformations (bending and twisting) without the unphysical bond-stretching artifacts common in linear models.

## Usage Guidelines

### Installation and Setup
The tool is primarily distributed via Bioconda. Ensure the environment is prepared before execution:
```bash
conda install bioconda::nolb
```

### Core Command Patterns
While specific CLI flags are detailed in the version-specific user guides, the general workflow follows these functional patterns:

*   **Normal Mode Calculation**: Input a PDB file to compute the Hessian matrix and extract the first $N$ normal modes. The tool is optimized to handle large systems, capable of computing 1,000 modes for large structures in minutes.
*   **Non-Linear Extrapolation**: Use the calculated modes to generate trajectories. This is superior to linear extrapolation for visualizing large conformational changes like domain swapping or hinge motions.
*   **Structural Ensemble Generation**: Generate a set of conformations that maintain a constant RMSD from the starting structure, useful for preparing libraries for flexible docking.

### Expert Tips
*   **Residue Approximation**: The "Rigid Block" nature of the tool means it treats groups of atoms (typically residues) as rigid units. This significantly reduces the degrees of freedom and memory consumption without losing the essential global dynamics of the protein.
*   **Memory Efficiency**: For very large complexes, `nolb` is preferred over atomistic NMA tools because its CPU and memory scaling is significantly lower (log-log linear scaling with system size).
*   **Integration with HOPMA**: For enhanced functional transition predictions, consider using "colored contact maps" (HOPMA) to modify the elastic network, which can be integrated with the `nolb` workflow to boost the accuracy of predicted dynamics.

## Reference documentation
- [NOLB Normal Modes Overview](./references/team_inria_fr_nano-d_software_nolb-normal-modes.md)
- [Bioconda nolb Package Details](./references/anaconda_org_channels_bioconda_packages_nolb_overview.md)