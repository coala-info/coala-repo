---
name: godmd
description: GOdMD maps transition pathways between macromolecular structures using discrete molecular dynamics and biasing techniques. Use when user asks to find pathways between initial and target structures, simulate macromolecular transitions, or generate initial pathways for atomistic refinement.
homepage: http://mmb.irbbarcelona.org/gitlab/adam/GOdMD
metadata:
  docker_image: "quay.io/biocontainers/godmd:1.8--hb569540_0"
---

# godmd

## Overview
GOdMD is a specialized tool designed to map the transition pathways of macromolecules. Unlike standard molecular dynamics which can be computationally expensive for long-range transitions, GOdMD uses discrete molecular dynamics and biasing techniques to efficiently find pathways between an initial structure and a target structure. It is particularly useful for defining initial pathways that can later be refined with more accurate atomistic simulations.

## CLI Usage and Best Practices

The core functionality is accessed via the `discrete` executable. A typical command requires an initial PDB, a target PDB, and alignment files.

### Basic Command Pattern
```bash
discrete -i dmdtest.in \
         -pdbin initial_structure.pdb \
         -pdbtarg target_structure.pdb \
         -p1 initial.aln \
         -p2 target.aln \
         -trj output_trajectory.crd \
         -ener energy.dat \
         -o simulation.log
```

### Key Parameter Tuning
The behavior of the simulation is controlled by parameters often defined in the input file (`-i`).

*   **ACCEPTANCE**: This is the fraction of sampled structures accepted in the Monte Carlo test. 
    *   *Expert Tip*: Use values between **0.5 and 0.8**. Values too low result in heavily biased results; values too high may prevent the simulation from converging.
*   **TSNAP**: Controls the frequency of structure output. Decrease this value if you need a higher-resolution view of the transition pathway.
*   **TRECT**: Sets the frequency for applying the Maxwell-Demon algorithm.
*   **GOENER**: Defines the energy depth of the Go-model well in kcal/mol.
*   **RGYRPERCENT**: Sets the maximum distance for non-bonded interactions as a fraction of the average radius of gyration.

### Input Requirements
1.  **PDB Files**: You must provide both the starting (`-pdbin`) and the destination (`-pdbtarg`) structures.
2.  **Alignment Files (`.aln`)**: These files ensure that the residues in the initial and target structures are correctly mapped to one another, which is critical for the biasing algorithm to work.
3.  **Trajectory Output**: The output is typically a coordinate file (`.crd`) which can be visualized using standard molecular modeling software.

## Reference documentation
- [Anaconda Bioconda godmd Overview](./references/anaconda_org_channels_bioconda_packages_godmd_overview.md)
- [GitHub GOdMD Repository](./references/github_com_mmb-irb_godmd.md)