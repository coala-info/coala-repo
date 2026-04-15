---
name: nemo
description: Nemo is a specialized simulation framework for modeling evolutionary biology and complex meta-population dynamics. Use when user asks to configure life-cycle events, run individual-based genetic simulations, or model the evolution of multiple traits under varying environmental scenarios.
homepage: http://nemo2.sourceforge.net
metadata:
  docker_image: "quay.io/biocontainers/nemo:2.3.51--h1c77041_2"
---

# nemo

## Overview
Nemo is a specialized simulation framework for evolutionary biology. It allows for the creation of complex meta-population models where individuals possess explicit genetic architectures. You should use this skill to configure and run simulations involving life-cycle events such as breeding, dispersal, selection, and aging. It is particularly powerful for modeling the joint evolution of multiple traits under varying demographic and environmental scenarios, including species interactions like Wolbachia-induced cytoplasmic incompatibility.

## Core Simulation Workflow
Nemo operates primarily through a central initialization file (init file) that defines the simulation parameters.

1.  **Initialization File Structure**: The interface is a text-based file where parameters are defined as `parameter_name value`.
2.  **Execution**: Run the simulation from the command line by passing the init file:
    ```bash
    nemo init_file.ini
    ```
3.  **Batch Processing**: Nemo supports multiple argument values for a single parameter within the init file, allowing for the execution of multiple simulation replicates or parameter sweeps from a single call.
4.  **Temporal Dynamics**: Parameters can be assigned temporal values to simulate environmental shifts, population bottlenecks, or changing selection pressures over the course of the run.

## Key Features and Parameters
*   **Genetic Architecture**: Define genetic maps including neutral markers (SNPs, microsatellites), deleterious mutations (with specific dominance/effect sizes), and quantitative trait loci (QTLs).
*   **Life Cycle Events**: Order events flexibly. Common sequences include:
    1.  `breeding`: Supports monogamy, polygyny, selfing, or cloning.
    2.  `disperse`: Supports island models, 1D/2D lattices, and migrant pools.
    3.  `selection`: Stabilizing selection on traits or directional selection on mutations.
    4.  `aging`: Handles patch regulation and carrying capacity.
*   **Metapopulation Control**: Configure patch-specific carrying capacities, dispersal rates, and extinction probabilities. Use dynamic population modifiers for patch fusion or fission.

## Expert Tips
*   **Memory Management**: For large-scale simulations (e.g., 10^6 individuals with 10^3 loci), ensure the system has at least 4-8GB of RAM.
*   **Parallelization**: Use the MPI-enabled version of Nemo for high-performance computing environments to distribute replicates across multiple cores.
*   **Cluster Integration**: For job scheduling on clusters (Slurm, PBS, LSF), use the `nemosub` utility to automate job submission directly from the init files.
*   **Trait Correlation**: When modeling multiple quantitative traits, define the mutational correlation and pleiotropic effects to accurately capture G-matrix evolution.

## Reference documentation
- [Nemo: Individual-based forward-time genetics simulation software](./references/nemo2_sourceforge_io_index.md)
- [Bioconda: nemo package overview](./references/anaconda_org_channels_bioconda_packages_nemo_overview.md)