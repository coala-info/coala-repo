---
name: bioconductor-bionet
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BioNet.html
---

# bioconductor-bionet

name: bioconductor-bionet
description: Integrated network analysis using the BioNet R package. Use this skill to identify functional modules (subnetworks) in biological networks by integrating gene expression data, p-values from differential expression or survival analysis, and protein-protein interaction (PPI) networks.

## Overview

BioNet provides a framework for the integrated analysis of biological networks and "omics" data. It maps p-values (from differential expression, survival analysis, etc.) onto a network, fits a Beta-uniform mixture (BUM) model to the p-value distribution, and identifies high-scoring subnetworks (modules). These modules represent functional units that are significantly perturbed under the studied conditions.

## Core Workflow

### 1. Data Preparation and Network Mapping
Load the network (typically a `graphNEL` or `igraph` object) and your p-values. Map the experimental data to the network nodes.

```R
library(BioNet)
# Load network and data (e.g., from DLBCL package)
data(interactome) 
data(dataLym)

# Create a subnetwork containing only genes present in your study
subnet <- subNetwork(dataLym$label, interactome)
subnet <- rmSelfLoops(subnet)

# If multiple p-values exist (e.g., t-test and survival), aggregate them
pvals <- cbind(t = dataLym$t.pval, s = dataLym$s.pval)
pval_agg <- aggrPvals(pvals, order = 2, plot = FALSE)
```

### 2. Scoring Nodes
BioNet uses a BUM model to transform p-values into scores. Positive scores indicate significant nodes; negative scores indicate non-significant nodes.

```R
# Fit the Beta-uniform mixture model
fb <- fitBumModel(pval_agg, plot = TRUE)

# Score nodes based on a specific False Discovery Rate (FDR)
# Higher FDR results in larger modules; lower FDR results in smaller, more stringent modules
scores <- scoreNodes(subnet, fb, fdr = 0.001)
```

### 3. Module Identification
Identify the maximum-scoring subnetwork.

*   **Heuristic Approach:** Use `runFastHeinz` for a quick approximation (recommended for most users).
*   **Exact Approach:** Use `runHeinz` or `writeHeinzNodes`/`writeHeinzEdges` if the external HEINZ tool and a CPLEX license are available.

```R
# Fast heuristic calculation
module <- runFastHeinz(subnet, scores)
```

### 4. Visualization and Export
Visualize the resulting module with expression data (fold changes) mapped to node colors.

```R
# Plot the module (red/green for up/down regulation)
logFC <- dataLym$diff
names(logFC) <- dataLym$label
plotModule(module, scores = scores, diff.expr = logFC)

# Export for Cytoscape
saveNetwork(module, file = "my_module", type = "XGMML")
```

## Advanced Features

### Consensus Modules
To handle variability, use jackknife resampling to generate an ensemble of modules and identify robust "consensus" components.

1.  Generate multiple p-value sets via resampling.
2.  Score the network for each set.
3.  Calculate frequency-based scores using `consensusScores`.
4.  Identify the final module based on these consensus scores.

### Mapping Identifiers
Use `mapByVar` when dealing with microarray data (e.g., Affymetrix) to map probe IDs to gene symbols or Entrez IDs while selecting the probe with the highest variance for each gene.

## Tips for Success
*   **Largest Connected Component:** Use `largestComp(network)` before scoring to ensure the analysis focuses on the main body of the interactome.
*   **FDR Selection:** If `runFastHeinz` returns an empty or tiny module, try increasing the `fdr` parameter in `scoreNodes`. If the module is too large/hairball-like, decrease the `fdr`.
*   **Self-Loops:** Always run `rmSelfLoops(network)` as they can interfere with the optimization algorithms.

## Reference documentation
- [BioNet Tutorial](./references/Tutorial.md)