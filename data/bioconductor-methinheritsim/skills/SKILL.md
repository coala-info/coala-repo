---
name: bioconductor-methinheritsim
description: This package simulates the inheritance of DNA methylation patterns across multiple generations using real control datasets to generate synthetic chromosomes. Use when user asks to simulate multigenerational methylation data, model the inheritance of differentially methylated regions, or generate synthetic methylome datasets for case-control studies.
homepage: https://bioconductor.org/packages/release/bioc/html/methInheritSim.html
---

# bioconductor-methinheritsim

## Overview

The `methInheritSim` package simulates the inheritance of DNA methylation patterns across multiple generations (F1, F2, F3, etc.). It uses real control datasets to generate synthetic chromosomes by sampling regions and applying Beta distributions to model methylation levels. It allows for the customization of differentially methylated sites (DMS), differentially methylated regions (DMR), and the rate at which these changes are inherited in subsequent generations.

## Core Workflow

### 1. Loading the Package and Data
The simulation requires a template dataset (controls only) to estimate parameters for the synthetic chromosome.

```R
library(methInheritSim)

# Load example dataset (methylBase object)
data(samplesForChrSynthetic)
```

### 2. Running the Simulation
The primary function is `runSim()`. It handles the creation of synthetic chromosomes, the simulation of case/control datasets, and optionally performs differential methylation analysis.

```R
# Define output directory
temp_dir <- "simulation_results"

# Execute simulation
runSim(
  methData = samplesForChrSynthetic, # Real dataset for parameter estimation
  nbSynCHR = 1,                      # Number of synthetic chromosomes
  nbSimulation = 2,                  # Number of simulations per parameter set
  nbBlock = 10,                      # Number of blocks sampled from real data
  nbCpG = 20,                        # Number of consecutive CpG sites per block
  nbGeneration = 3,                  # Number of generations (F1, F2, F3)
  vNbSample = c(3, 6),               # Vector of sample sizes (cases = controls)
  vpDiff = c(0.9),                   # Proportion of cases with DMS (penetrance)
  vDiff = c(0.8),                    # Mean shift in C/T ratio for DMS
  vInheritance = c(0.5),             # Proportion of cases inheriting DMS
  propInherite = 0.3,                # Proportion of DMRs inherited
  rateDiff = 0.3,                    # Mean frequency of DMRs
  outputDir = temp_dir,              # Directory for RDS output files
  fileID = "S1",                     # Prefix for output files
  runAnalysis = TRUE,                # Run methylKit analysis automatically
  vSeed = 42                         # Seed for reproducibility
)
```

### 3. Key Parameters
- **nbBlock/nbCpG**: Controls the size and structure of the synthetic chromosome.
- **vpDiff**: Similar to penetrance; determines how many case individuals actually exhibit the differential methylation.
- **vDiff**: The magnitude of the methylation change (shift in Beta distribution).
- **vInheritance**: The rate at which the DMS/DMR is passed to the next generation.
- **propHetero**: Set to 0.5 by default; represents the reduction of `vDiff` in subsequent generations if only one parent is affected.

## Interpreting Output Files

The simulation saves results as `.rds` files in the `outputDir`.

- **syntheticChr_**: `GRanges` object containing the synthetic CpG sites and their original genomic coordinates.
- **simData_**: `GRanges` object containing the simulated C/T proportions for every sample across generations.
- **stateDiff_**: A list indicating which sites are DMS (`stateDiff`) and which were inherited (`stateInherite`).
- **meth_**: (If `runAnalysis=TRUE`) `methylBase` objects formatted for `methylKit`.
- **methDiff_**: (If `runAnalysis=TRUE`) `methylDiff` objects containing p-values and methylation differences.

## Tips for Success
- **Memory Management**: Large simulations (many blocks/CpGs) can be memory-intensive. Use `nbCores` to parallelize if the system allows.
- **Integration**: Use the output of this package as input for the `methylInheritance` package to test the performance of inheritance detection algorithms.
- **Real Data**: While the package provides example data, using your own control dataset ensures the synthetic chromosome reflects the specific CpG density and variance of your study organism.

## Reference documentation
- [Simulating Whole-Genome Inherited Bisulphite Sequencing Data](./references/methInheritSim.Rmd)
- [Simulating Whole-Genome Inherited Bisulphite Sequencing Data](./references/methInheritSim.md)