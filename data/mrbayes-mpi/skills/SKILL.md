---
name: mrbayes-mpi
description: This skill provides guidance for executing MrBayes in parallel environments to reconstruct evolutionary relationships.
homepage: http://mrbayes.sourceforge.net
---

# mrbayes-mpi

## Overview
This skill provides guidance for executing MrBayes in parallel environments to reconstruct evolutionary relationships. MrBayes-MPI is specifically designed for computationally intensive phylogenetic analyses, allowing for the simultaneous execution of multiple MCMC chains across different processor cores. It is the preferred tool for large datasets where standard Bayesian inference would be prohibitively slow.

## Core CLI Usage
The MPI version of MrBayes is typically invoked through an MPI runner (like `mpirun` or `mpiexec`).

```bash
# Basic execution with 4 processors
mpirun -np 4 mb
```

### Batch Processing
For reproducible research and high-performance computing (HPC) clusters, use a Nexus-formatted block within a command file:

```bash
mpirun -np 8 mb input_script.nex
```

## Common MCMC Patterns
When using the MPI version, ensure your `nchains` setting in the `mcmcp` or `mcmc` command is compatible with the number of processors allocated.

*   **Setting up the analysis:**
    `lset nst=6 rates=invgamma;` (Sets GTR+I+G model)
*   **Parallel MCMC configuration:**
    `mcmcp ngen=1000000 nruns=2 nchains=4 samplefreq=1000;`
*   **Starting the run:**
    `mcmc;`
*   **Summarizing results:**
    `sump;` (Summarizes parameters)
    `sumt;` (Summarizes trees and calculates posterior probabilities)

## Expert Tips
*   **Processor Allocation:** For maximum efficiency, the number of MPI processes (`-np`) should ideally be equal to the total number of chains (`nruns` × `nchains`). If you have 2 runs with 4 chains each, use 8 processors.
*   **Checkpointing:** Use `checkp=yes` and `checkpointfreq=[value]` in your MCMC settings. This allows you to resume long-running analyses if the cluster walltime is reached or the system crashes.
*   **Convergence Monitoring:** Always check the "Average standard deviation of split frequencies." Values below 0.01 generally indicate convergence, while values between 0.01 and 0.05 are often acceptable for preliminary results.
*   **Memory Management:** When working with very large alignments, use `outgroup [taxon_name]` early in the script to define the tree root and simplify the search space.

## Reference documentation
- [MrBayes Overview](./references/anaconda_org_channels_bioconda_packages_mrbayes_overview.md)
- [MrBayes Project Summary](./references/sourceforge_net_projects_mrbayes.md)