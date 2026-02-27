---
name: bioconductor-qpgraph
description: This package infers molecular regulatory networks from high-throughput data using Gaussian graphical models and non-rejection rates. Use when user asks to estimate gene regulatory networks, calculate non-rejection rates, map eQTL networks, or perform network inference when the number of variables exceeds the number of samples.
homepage: https://bioconductor.org/packages/release/bioc/html/qpgraph.html
---


# bioconductor-qpgraph

name: bioconductor-qpgraph
description: Inference of molecular regulatory networks from high-throughput data (microarray, RNA-seq, eQTL) using Gaussian graphical models and non-rejection rates. Use this skill when you need to estimate gene regulatory networks, calculate partial correlations, or map eQTL networks using the qpgraph R package.

# bioconductor-qpgraph

## Overview
The `qpgraph` package is designed for the reverse engineering of molecular regulatory networks from high-throughput data, particularly when the number of variables (genes) $p$ is much larger than the number of samples $n$. It utilizes limited-order partial correlations and a quantity called the **non-rejection rate (NRR)** to distinguish between direct and indirect interactions. It also supports the estimation of eQTL networks using mixed graphical Markov models.

## Typical Workflow

### 1. Data Preparation
The package works with `ExpressionSet` objects or numeric matrices.
```R
library(qpgraph)
library(Biobase)

# Load example E. coli data
data(EcoliOxygen)
# gds680.eset is an ExpressionSet with 4205 genes and 43 samples
```

### 2. Estimating Non-Rejection Rates (NRR)
The NRR is the probability of not rejecting the null hypothesis of zero partial correlation between two genes, given a random subset of other genes.
- **Specific Order ($q$):** Use `qpNrr()` for a fixed number of conditioning variables.
- **Average NRR:** Use `qpAvgNrr()` to average over multiple orders, which is generally more robust.

```R
# Estimate NRR with q=3
nrr_matrix <- qpNrr(gds680.eset, q=3, clusterSize=8)

# Estimate Average NRR (recommended)
avg_nrr <- qpAvgNrr(gds680.eset, clusterSize=8)
```

### 3. Network Inference
Once NRRs are calculated, threshold them to create a graph.
```R
# Check graph density at different thresholds
qpGraphDensity(avg_nrr, title="Density Plot")

# Create a graphNEL object at a specific threshold (e.g., 0.1)
g <- qpGraph(avg_nrr, threshold=0.1, return.type="graphNEL")

# Extract top pairs
top_pairs <- qpTopPairs(avg_nrr, n=20)
```

### 4. eQTL Network Mapping
For genetical genomics data (genotypes + expression), use the eQTL workflow.
```R
# 1. Define parameters
param <- eQTLnetworkEstimationParam(cross_obj, physicalMap=pMap, 
                                    geneAnnotation=annot, genome=genome)

# 2. Estimate marginal associations
eqtl_net <- eQTLnetworkEstimate(param, ~ marker + gene)

# 3. Refine with NRR (q=3)
eqtl_net_refined <- eQTLnetworkEstimate(param, ~ marker + gene | gene(q=3), 
                                        estimate=eqtl_net)

# 4. Filter by FDR and NRR epsilon
final_net <- eQTLnetworkEstimate(param, estimate=eqtl_net_refined, 
                                 p.value=0.05, method="fdr", epsilon=0.1)
```

### 5. Visualization and Analysis
- **Network Plotting:** Use `qpPlotNetwork(g)` for standard graphs.
- **Hive Plots:** Use `plot(final_net, type="hive")` for eQTL networks.
- **Functional Coherence:** Use `qpFunctionalCoherence()` to validate modules against Gene Ontology.

## Tips and Best Practices
- **Parallelization:** Most heavy functions support `clusterSize`. Ensure `snow` and `rlecuyer` are loaded to use multiple cores.
- **Sparsity:** The method assumes the underlying network is sparse. If the resulting graph is too dense, decrease the NRR threshold.
- **Transcription Factors:** If TFs are known, use `pairup.i` and `pairup.j` in `qpAvgNrr()` to restrict calculations to TF-Target pairs, significantly speeding up the process.
- **Partial Correlations:** After obtaining a graph structure, use `qpPAC()` to estimate the actual partial correlation coefficients for the edges.

## Reference documentation
- [Inference of regulatory networks from microarray data with R and the Bioconductor package qpgraph](./references/BasicUsersGuide.md)
- [Estimate eQTL networks using qpgraph](./references/eQTLnetworks.md)
- [Reverse engineering transcriptional regulatory networks from gene expression microarray data using qpgraph](./references/qpTxRegNet.md)
- [Simulating molecular regulatory networks using qpgraph](./references/qpgraphSimulate.md)