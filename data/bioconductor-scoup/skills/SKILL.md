---
name: bioconductor-scoup
description: The scoup package simulates codon-based genetic sequences under various evolutionary scenarios using the Mutation-Selection framework and Ornstein-Uhlenbeck processes. Use when user asks to simulate codon sequences, model shifting adaptive landscapes, or apply episodic selection pressures across different branches of a phylogenetic tree.
homepage: https://bioconductor.org/packages/release/bioc/html/scoup.html
---

# bioconductor-scoup

## Overview
The `scoup` package is a Bioconductor tool designed to simulate codon-based genetic sequences under various evolutionary scenarios. It utilizes the Mutation-Selection (MutSel) framework and incorporates Darwinian selection as an Ornstein-Uhlenbeck (OU) process. This allows for the simulation of complex evolutionary dynamics, including frequency-dependent selection, shifting adaptive landscapes, and episodic (branch-wise) selection. A key feature is the use of the vN/vS ratio (variance of non-synonymous to synonymous selection coefficients) as a metric for imposed selection pressure.

## Core Workflow

### 1. Define Simulation Parameters
Simulations in `scoup` require three primary configuration components:
*   **Sequence Details**: Define the alignment size (sites, taxa, or branch lengths).
*   **Selection Parameters**: Define the selection coefficients and variance (vN/vS).
*   **Evolutionary Model**: Choose between Frequency-dependent, OU, or Episodic (Discrete) models.

### 2. Initialize Configuration Objects
Use the following helper functions to prepare inputs for the simulator:
*   `seqDetails()`: Sets `nsite`, `ntaxa`, and optionally `blength`.
*   `hbInput()`: Sets the selection landscape parameters (`vNvS`, `nsynVar`).
*   `ouInput()`: Configures OU parameters (`eVar` for asymptotic variance, `Theta` for reversion).
*   `wInput()`: Configures frequency-dependent selection parameters.
*   `discreteInput()`: Configures branch-specific selection for episodic models.

### 3. Execute Simulation
The primary execution function is `alignsim()`.
```r
library(scoup)

# 1. Setup sequence dimensions
seq_info <- seqDetails(c(nsite = 20, ntaxa = 8))

# 2. Setup selection landscape
landscape <- hbInput(c(vNvS = 1, nsynVar = 0.01))

# 3. Setup evolutionary process (e.g., OU)
process <- ouInput(c(eVar = 0.0001, Theta = 0.01))

# 4. Run simulation
sim_result <- alignsim(process, seq_info, landscape, NULL)
```

## Simulation Modes

### Ornstein-Uhlenbeck (OU) Process
Used for modeling shifting adaptive landscapes where selection pressures revert toward an optimum.
```r
adaptStat <- ouInput(c(eVar = 0.0001, Theta = 0.01))
simData <- alignsim(adaptStat, seqStat, hbrunoStat, NULL)
```

### Frequency-Dependent Selection
Used for standard mutation-selection simulations where selection depends on the current state.
```r
adaptData <- wInput(list(vNvS = 1, nsynVar = 0.001))
simulateSeq <- alignsim(adaptData, seqStat, NA)
```

### Episodic (Branch-wise) Selection
Used to apply different selection pressures to different internal nodes of the tree.
```r
# Define different vNvS for different nodes
scInput <- rbind(vNvS = c(0, 0, 1e-06), nsynVar = rep(0.01, 3))
adaptBranch <- discreteInput(list(p02xnodes = scInput))
genSeq <- alignsim(adaptBranch, seqsBwise, NULL)
```

## Handling Output
The simulation returns objects that can be converted or viewed using:
*   `seqCOL(simData)`: Displays the simulated alignment as a `DNAStringSet`.
*   `cseq(simData)`: Prints the simulated codon sequences in a tabular format.

## Tips
*   **vN/vS Metric**: Use the ratio of the variance of non-synonymous to synonymous selection coefficients to control the magnitude of selection pressure.
*   **Directional Selection**: To simulate directional selection, modify the `aaPlus` element within the `wInput` configuration.
*   **Validation**: The package is designed so that simulated $\mathrm{d}N/\mathrm{d}S$ values should correlate strongly with inferred $\omega$ values from tools like PAML or FUBAR.

## Reference documentation
- [scoup Tutorial](./references/scoup.Rmd)
- [scoup: Simulate Codons with Darwinian Selection Incorporated as an Ornstein-Uhlenbeck Process](./references/scoup.md)