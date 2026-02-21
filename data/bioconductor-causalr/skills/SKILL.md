---
name: bioconductor-causalr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/CausalR.html
---

# bioconductor-causalr

name: bioconductor-causalr
description: Causal reasoning and network analysis using the CausalR Bioconductor package. Use this skill to predict upstream regulators (hypotheses) from differential experimental data (e.g., gene expression) by integrating it with causal interaction networks. Use when you need to: (1) Create Causal Graphs (CG) or Computational Causal Graphs (CCG) from .sif files, (2) Rank hypotheses based on their fit with experimental data, (3) Calculate statistical significance (p-values and enrichment) for regulators, (4) Perform Sequential Causal Analysis of Networks (SCAN), or (5) Generate hypothesis-specific sub-networks for visualization in Cytoscape.

# bioconductor-causalr

## Overview
CausalR is an R package designed for causal reasoning over biological networks. It integrates prior knowledge (interaction networks) with experimental observations (up/down-regulation) to identify potential regulators. It transforms standard causal graphs into Computational Causal Graphs (CCG) to efficiently score how well a hypothesis (e.g., "Node A is activated") explains the observed experimental changes across a defined path length (delta).

## Core Workflow

### 1. Setup and Data Loading
Load the library and prepare the network and experimental data.

```R
library(CausalR)

# Load network from a .sif file (NodeA Activates/Inhibits NodeB)
# CreateCCG is preferred for processing efficiency
ccg <- CreateCCG("path/to/network.sif")

# Load experimental data (Tab-separated: NodeName, Regulation [-1, 0, 1])
# Note: Including non-differential (0) results is critical for p-value accuracy
experimentalData <- ReadExperimentalData("path/to/data.txt", ccg)

# Optional: Visualize the network
PlotGraphWithNodeNames(ccg)
```

### 2. Ranking Hypotheses
The primary function `RankTheHypotheses` identifies which nodes are most likely to be the upstream regulators of the observed data.

```R
# delta: path length to look forward from the hypothesis
# Higher delta increases connectivity but may degrade differentiation
results <- RankTheHypotheses(ccg, experimentalData, delta = 2)

# To analyze specific nodes only:
results_subset <- RankTheHypotheses(ccg, experimentalData, delta = 2, listOfNodes = c("Node0", "Node1"))
```

### 3. Sequential Causal Analysis of Networks (SCAN)
SCAN improves reliability by identifying regulators that consistently rank highly across multiple path lengths (deltas).

```R
# Scans deltas from 1 to 2, keeping top 4 genes
scanResults <- runSCANR(ccg, experimentalData, 
                        numberOfDeltaToScan = 2, 
                        topNumGenes = 4,
                        correctPredictionsThreshold = 1)

# Access common nodes found across all deltas
scanResults$commonNodes
```

### 4. Detailed Hypothesis Analysis
To inspect why a specific node scored the way it did:

```R
# 1. Make predictions for a specific signed hypothesis (e.g., Node0 is +1)
predictions <- MakePredictionsFromCCG('Node0', +1, ccg, delta = 2)

# 2. Compare predictions against experimental data
comparison <- CompareHypothesis(predictions, experimentalData)
GetNodeName(ccg, comparison)

# 3. Calculate specific significance
Score <- ScoreHypothesis(predictions, experimentalData)
CalculateEnrichmentPvalue(predictions, experimentalData)
```

### 5. Exporting for Visualization
Generate `.sif` and annotation files for Cytoscape to visualize the "explained" portion of the network.

```R
# For a single hypothesis
WriteExplainedNodesToSifFile("Node1", +1, ccg, experimentalData, delta = 2)

# For all common nodes found in a SCAN run
WriteAllExplainedNodesToSifFile(scanResults, ccg, experimentalData, delta = 2)
```

## Performance Tips
- **Parallelization**: Use `doParallel = TRUE` and `numCores` in `RankTheHypotheses` or `runSCANR` for large networks.
- **Significance Calculation**: The "cubic" algorithm is the default and much faster than the "quartic" algorithm for large datasets.
- **Filtering**: Use `correctPredictionsThreshold` to skip p-value calculations for low-scoring hypotheses to save time.
- **Network Filtering**: `CreateCCG` can take a `nodeInclusionFile` to focus the analysis on a specific subset of the interactome.

## Reference documentation
- [Overview of Causal Reasoning with CausalR](./references/CausalR.md)