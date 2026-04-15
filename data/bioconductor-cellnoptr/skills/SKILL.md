---
name: bioconductor-cellnoptr
description: This tool creates logic-based models of signal transduction networks by training prior knowledge networks against experimental perturbation data. Use when user asks to train prior knowledge networks, create functional boolean models, preprocess signaling networks, or optimize models using genetic algorithms or integer linear programming.
homepage: https://bioconductor.org/packages/release/bioc/html/CellNOptR.html
---

# bioconductor-cellnoptr

name: bioconductor-cellnoptr
description: Logic-based modeling of signal transduction networks using the CellNOptR package. Use this skill to train prior knowledge networks (PKN) against perturbation data (MIDAS format) to create functional boolean models. It supports data loading (CNOlist), network preprocessing (compression, expansion), and optimization using Genetic Algorithms or Integer Linear Programming (ILP).

## Overview
CellNOptR (Cell Net Optimizer for R) is a tool for creating logic-based models of signaling pathways. It integrates a Prior Knowledge Network (PKN), representing known protein interactions, with experimental data (typically phosphoproteomics) under various perturbations (stimuli and inhibitors). The package identifies the subset of the PKN that best explains the observed data through boolean logic optimization.

## Typical Workflow

### 1. Data Loading and Initialization
The package uses two main inputs: a SIF file for the network and a MIDAS CSV file for the data.

```r
library(CellNOptR)

# Load Prior Knowledge Network (SIF format)
pknmodel <- readSIF("path/to/network.sif")

# Load and format data (MIDAS format)
# CNOlist is the central data object
cnolist <- CNOlist("path/to/data.csv")

# Visualize data
plot(cnolist)
plotModel(pknmodel, cnolist)
```

### 2. Preprocessing
Before optimization, the model must be processed to match the experimental design.

```r
# Combined preprocessing: 
# 1. Cut non-observable/non-controllable nodes
# 2. Compress linear cascades
# 3. Expand gates (create AND/OR logic combinations)
model <- preprocessing(cnolist, pknmodel, expansion=TRUE, compression=TRUE, cutNONC=TRUE)
```

### 3. Model Training (Optimization)
Training finds the bitstring (presence/absence of edges) that minimizes the difference between simulation and data.

**Genetic Algorithm (Standard):**
```r
# Optimize for a single time point (T1)
res <- gaBinaryT1(CNOlist = cnolist, model = model, verbose = FALSE)

# For two time points (T1 and T2)
resT1 <- gaBinaryT1(cnolist, model)
resT2 <- gaBinaryTN(cnolist, model, bStrings = list(resT1$bString))
```

**Integer Linear Programming (Requires CPLEX):**
```r
# Faster for large networks, requires external CPLEX solver
resILP <- ilpBinaryT1(cnolist = cnolist, model = model, cplexPath = "/path/to/cplex")
```

### 4. Results and Visualization
```r
# Plot simulated vs experimental data
cutAndPlot(cnolist, model, list(res$bString))

# Map the optimized model back to the original PKN
bs_mapped <- mapBack(model, pknmodel, res$bString)
plotModel(pknmodel, cnolist, bs_mapped, compressed = model$speciesCompressed)

# Generate a comprehensive HTML report
writeReport(modelOriginal=pknmodel, modelOpt=model, optimResT1=res, 
            CNOlist=cnolist, directory="CellNOpt_Results")
```

## One-Step Wrapper
For a quick analysis with default parameters:
```r
res <- CNORwrap(name="MyAnalysis", data=cnolist, model=pknmodel)
```

## Key Functions
- `CNOlist()`: Constructor for the data object.
- `readSIF()`: Reads Cytoscape-style SIF files.
- `preprocessing()`: Prepares the network for logic modeling.
- `gaBinaryT1()`: Primary Genetic Algorithm optimizer.
- `cutAndPlot()`: Overlays simulation results on experimental data plots.
- `mapBack()`: Translates results from the preprocessed model back to the original network topology.

## Reference documentation
- [CellNOptR Vignette](./references/CellNOptR-vignette.md)