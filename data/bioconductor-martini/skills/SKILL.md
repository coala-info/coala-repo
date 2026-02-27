---
name: bioconductor-martini
description: This tool performs network-guided genome-wide association studies (GWAS) to identify interconnected sets of SNPs associated with a phenotype. Use when user asks to identify explanatory SNPs using the SConES algorithm, construct SNP networks based on genomic or molecular interactions, or simulate phenotypes from network-connected causal SNPs.
homepage: https://bioconductor.org/packages/release/bioc/html/martini.html
---


# bioconductor-martini

name: bioconductor-martini
description: Perform network-guided genome-wide association studies (GWAS) using the SConES algorithm. Use this skill to identify sets of SNPs that are both significantly associated with a phenotype and interconnected within a biological network (genomic structure, gene-protein interactions, or pathways).

## Overview

The `martini` package implements the SConES (Significant Conected Subsets) algorithm to find explanatory SNPs in GWAS data. Unlike univariate analysis, `martini` incorporates prior biological knowledge by representing SNPs as nodes in a network. It searches for a subset of SNPs that maximizes association with the phenotype while penalizing sparsity and lack of connectivity.

## Core Workflow

### 1. Data Preparation
`martini` works with GWAS data structures similar to those produced by `snpStats`. The input is typically a list containing:
- `genotypes`: A `SnpMatrix` object.
- `fam`: Patient information (including the `affected` column).
- `map`: SNP information (chromosome, name, position).

### 2. Network Construction
Create a SNP network using one of the three built-in functions:
- `get_GS_network(gwas)`: Genomic Structure network. Connects adjacent SNPs on the same chromosome.
- `get_GM_network(gwas, snpMapping)`: Genomic-Molecular network. Connects adjacent SNPs and all SNPs within the same gene.
- `get_GI_network(gwas, snpMapping, ppi)`: Genomic-Interaction network. Connects SNPs in interacting genes (e.g., via protein-protein interactions).

### 3. Running SConES
Use `scones.cv` to find the optimal connected subnetwork. It performs a grid search over the sparsity ($\eta$) and connectivity ($\lambda$) parameters using Bayesian Information Criterion (BIC).

```r
library(martini)

# Run SConES with cross-validation/grid search
# gi is the network, minigwas is the GWAS data
results <- scones.cv(minigwas, gi)
```

### 4. Interpreting Results
The output is a data frame (extending the SNP map) with additional columns:
- `c`: The univariate association score (e.g., chi-squared).
- `selected`: Boolean indicating if the SNP is part of the optimal subnetwork.
- `module`: ID for connected components within the solution.

## Phenotype Simulation
`martini` provides tools to simulate phenotypes based on network-connected causal SNPs, useful for benchmarking.

```r
# 1. Select causal SNPs from a network
causal_snps <- simulate_causal_snps(gi, ngenes = 2, pcausal = 0.3)

# 2. Simulate quantitative phenotype (h2 = heritability)
sim_quant <- simulate_phenotype(minigwas, snps = causal_snps, h2 = 0.9)

# 3. Simulate qualitative (case-control) phenotype
sim_qual <- simulate_phenotype(minigwas, snps = causal_snps, h2 = 0.8, 
                               qualitative = TRUE, ncases = 50, 
                               ncontrols = 50, prevalence = 0.1)
```

## Tips
- **SNP Mapping**: Functions like `get_GM_network` require a `snpMapping` data frame linking SNP IDs to Gene IDs.
- **PPI Data**: `get_GI_network` requires a data frame of protein-protein interactions.
- **Visualization**: Use `plot(network)` to visualize the SNP graph, or `plot(network, mark.groups = names(causal))` to highlight specific subsets.

## Reference documentation
- [Running SConES](./references/scones_usage.md)
- [Simulating SConES-based phenotypes](./references/simulate_phenotype.md)