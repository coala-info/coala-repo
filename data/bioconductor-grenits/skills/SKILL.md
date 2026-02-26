---
name: bioconductor-grenits
description: This tool infers gene regulatory networks from time-series gene expression data using Dynamic Bayesian Networks and Gibbs Variable Selection. Use when user asks to reconstruct gene interaction networks, identify probable network topologies from time-course data, or analyze linear and non-linear gene interactions.
homepage: https://bioconductor.org/packages/release/bioc/html/GRENITS.html
---


# bioconductor-grenits

name: bioconductor-grenits
description: Gene Regulatory Network Inference Using Time Series (GRENITS). Use this skill to infer gene interaction networks from time-course data using Dynamic Bayesian Networks and Gibbs Variable Selection. It supports linear, non-linear, and noisy experimental models.

## Overview

GRENITS (Gene Regulatory Network Inference using Time Series) is an R package designed to reconstruct gene regulatory networks (GRNs) from time-series gene expression data. It utilizes a Bayesian framework, specifically Dynamic Bayesian Networks (DBN) combined with Gibbs Variable Selection, to identify the most probable network topology.

The package offers four statistical models:
1. **Linear Interaction Model**: Standard linear DBN.
2. **Linear with Gaussian Noise**: For data with replicates and Gaussian experimental noise.
3. **Linear with Student-t Noise**: For data with replicates and heavy-tailed experimental noise.
4. **Non-linear Interaction Model**: Uses spline autoregression for complex interactions.

## Typical Workflow

### 1. Data Preparation
Data should be a matrix with genes in rows and time points in columns.
```R
library(GRENITS)
data(Athaliana_ODE) # Example dataset
# Rows: Genes, Columns: Time points
```

### 2. Running Inference
Choose the appropriate model function. By default, these run two MCMC chains.
- `LinearNet(output.folder, data)`
- `NonLinearNet(output.folder, data)`
- `LinearNetGauss(output.folder, data, replicates)`
- `LinearNetStudent(output.folder, data, replicates)`

```R
output.dir <- "GRENITS_Results"
LinearNet(output.dir, Athaliana_ODE)
```

### 3. Analysis and Convergence
After the MCMC run, analyze the raw output to generate probability matrices and diagnostic plots.
```R
analyse.output(output.dir)
```
**Crucial Check**: Open `ConvergencePlots.pdf`. If the difference in connection probabilities between chains is > 0.2, re-run with more iterations using `mcmc.params`.

### 4. Extracting the Network
Load the probability matrix and apply a threshold (e.g., 0.8) to define the network.
```R
prob.file <- file.path(output.dir, "NetworkProbability_Matrix.txt")
prob.mat <- read.table(prob.file)
inferred.net <- 1 * (prob.mat > 0.8)
```

### 5. Interaction Sign and Strength
To determine if an interaction is activating or inhibiting, check the `NetworkProbability_List.txt` file.
```R
list.file <- file.path(output.dir, "NetworkProbability_List.txt")
prob.list <- read.table(list.file, header = TRUE)
# Filter for high-confidence links
significant_links <- prob.list[prob.list$Probability > 0.8, ]
```

## Tips and Best Practices
- **Default Parameters**: The package provides `mcmc.defaultParams_Linear()` and `mcmc.defaultParams_NonLinear()`. Use these as templates if you need to increase `iter` or `burnin`.
- **Log Transformation**: It is often beneficial to take the log of gene expression data before processing.
- **Replicates**: If your data has replicates, use the `Gauss` or `Student` variants to explicitly model experimental noise.
- **Visualization**: Use the generated `AnalysisPlots.pdf` to visualize the distribution of link probabilities, which helps in choosing an appropriate threshold.

## Reference documentation
- [GRENITS: Gene Regulatory Network Inference Using Time Series](./references/GRENITS_package.md)