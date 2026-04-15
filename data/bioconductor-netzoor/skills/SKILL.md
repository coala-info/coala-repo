---
name: bioconductor-netzoor
description: This tool performs multi-omic integration to reconstruct and analyze gene regulatory networks using the netZoo suite. Use when user asks to reconstruct networks with PANDA or OTTER, estimate single-sample networks with LIONESS, build genotype-specific networks with EGRET, perform community detection with CONDOR or ALPACA, analyze network transitions with MONSTER, or subtype mutations with SAMBAR.
homepage: https://bioconductor.org/packages/release/bioc/html/netZooR.html
---

# bioconductor-netzoor

name: bioconductor-netzoor
description: Comprehensive gene regulatory network inference and analysis using the netZooR package. Use this skill to reconstruct networks (PANDA, OTTER), estimate single-sample networks (LIONESS), build genotype-specific networks (EGRET), and perform network analysis including community detection (CONDOR), differential community detection (ALPACA), network transitions (MONSTER), and mutation subtyping (SAMBAR).

# bioconductor-netzoor

## Overview
`netZooR` is a unified R interface for the Network Zoo (netZoo) suite. It provides tools for the multi-omic integration of biological data to reconstruct regulatory networks and analyze their structure. The package is particularly powerful for identifying how regulatory patterns change across different phenotypic states, tissues, or individuals.

## Core Workflows

### 1. Network Reconstruction (PANDA & OTTER)
PANDA integrates TF motif priors, Protein-Protein Interactions (PPI), and gene expression data using message passing. OTTER provides an alternative optimization-based approach.

```R
library(netZooR)

# PANDA (Standard)
# motif: TF-gene prior, expr: gene expression matrix, ppi: TF-TF interactions
panda_res <- panda(motif, expr, ppi, mode="intersection")
reg_net <- panda_res@regNet # Access the bipartite network

# OTTER (Optimization-based)
# Requires correlation matrix C instead of raw expression
C_matrix <- cor(t(expr))
otter_res <- otter(W0, P, C_matrix)
```

### 2. Single-Sample Networks (LIONESS)
LIONESS uses linear interpolation to extract the contribution of a single sample to an aggregate network.

```R
# Returns a matrix where columns are individual samples
lioness_results <- lionessPy(expr_file = "expr.txt", motif_file = "motif.txt", ppi_file = "ppi.txt")
```

### 3. Genotype-Specific Networks (EGRET)
EGRET incorporates VCF genotype data and eQTL information to penalize TF-gene edges based on individual mutations.

```R
# Requires qtl, vcf, qbic predictions, motif, expr, ppi, and a gene map
runEgret(qtl, vcf, qbic, motif, expr, ppi, nameGeneMap, tag="my_run")
```

### 4. Community Detection (CONDOR & ALPACA)
CONDOR clusters bipartite networks into modules. ALPACA identifies differential modules between two networks (e.g., Case vs. Control).

```R
# CONDOR: Community detection
condor_obj <- createCondorObject(edgelist)
condor_obj <- condorCluster(condor_obj)

# ALPACA: Differential community detection
# Compares treated vs control networks
alpaca_res <- pandaToAlpaca(treated_net, control_net)
```

### 5. Network Transitions (MONSTER)
MONSTER identifies TFs that drive the transition between two cellular states.

```R
# design: vector of 0s and 1s indicating groups
monster_res <- monster(expr, design, motif, nullPerms=100)
monsterPlotMonsterAnalysis(monster_res)
```

### 6. Mutation Subtyping (SAMBAR)
SAMBAR de-sparsifies somatic mutation data into pathway-level scores for subtyping.

```R
# mutdata: mutation matrix, esize: gene lengths, signatureset: .gmt file
subtypes <- sambar(mutdata, esize, signatureset="pathways.gmt")
```

## Implementation Tips
- **Python Integration**: Functions ending in `Py` (e.g., `pandaPy`, `lionessPy`) require a Python 3 environment with `numpy`, `pandas`, and `scipy` installed. Use `reticulate::use_python()` to specify the path.
- **Data Preparation**: Ensure gene identifiers match across all input layers (Motif, Expression, PPI).
- **Memory Management**: For large datasets (e.g., GTEx), use `data.table::fread` for fast I/O and consider subsetting genes to those with high variance or prior evidence.
- **Degree Calculation**: Use `calcDegree(panda_obj, type="gene")` or `type="tf"` to quickly summarize network connectivity.

## Reference documentation
- [Detecting differential modules using ALPACA](./references/ALPACA.Rmd)
- [Building PANDA and LIONESS Regulatory Networks from GTEx Gene Expression Data in R](./references/ApplicationinGTExData.Rmd)
- [netZooR application with TB dataset](./references/ApplicationwithTBdataset.Rmd)
- [Using CONDOR for community detection in bipartite graphs](./references/CONDOR.Rmd)
- [Constructing genotype-specific gene regulatory networks with EGRET](./references/EGRET_toy_example.Rmd)
- [Comparing LIONESS Regulatory Networks using limma](./references/LionessApplicationinGTExData.Rmd)
- [An Introduction to the MONSTER Package](./references/MONSTER.Rmd)
- [SAMBAR: Subtyping Agglomerated Mutations By Annotation Relations](./references/SAMBAR.Rmd)
- [Inferring Gene Regulatory Networks from GTEx Gene Expression Data in R with OTTER](./references/TutorialOTTER.Rmd)
- [An Introduction to the pandaR Package](./references/pandaR.Rmd)
- [Building PANDA Regulatory Networks from GTEx Gene Expression Data in R](./references/pandaRApplicationinGTExData.Rmd)
- [YARN: Robust Multi-Tissue RNA-Seq Preprocessing and Normalization](./references/yarn.Rmd)