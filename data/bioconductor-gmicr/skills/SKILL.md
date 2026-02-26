---
name: bioconductor-gmicr
description: This tool builds Gene Module-Immune Cell networks by integrating gene expression data and immune cell signatures using WGCNA and Bayesian Network learning. Use when user asks to build GMIC networks, perform integrative analysis of gene expression and immune cell signatures, or infer causal relationships between gene modules and cell types.
homepage: https://bioconductor.org/packages/release/bioc/html/GmicR.html
---


# bioconductor-gmicr

name: bioconductor-gmicr
description: Expert guidance for the GmicR R package to build Gene Module-Immune Cell (GMIC) networks. Use this skill when performing integrative analysis of gene expression data and immune cell signatures using WGCNA and Bayesian Network learning.

# bioconductor-gmicr

## Overview
GmicR is a Bioconductor package designed to infer causal relationships between gene modules and immune cell signatures. It integrates Weighted Gene Co-expression Network Analysis (WGCNA) for dimensionality reduction of expression data with Bayesian Network (BN) learning and xCell cell signatures. The workflow transforms high-dimensional transcriptomic data into module eigengenes, discretizes them alongside cell signatures, and uses bootstrapping to learn a robust network structure.

## Core Workflow

### 1. Data Preparation and QC
Input expression data must be normalized (RPKM/FPKM/TPM/RSEM) and annotated with official gene symbols.

```r
library(GmicR)
library(WGCNA)

# Transpose so genes are columns
datExpr <- data.frame(t(read.delim("expression_data.txt", row.names = 1)))

# Quality Control
gsg <- goodSamplesGenes(datExpr, verbose = 3)
if (!gsg$allOK) {
  # Remove offending genes/samples if necessary
  datExpr <- datExpr[gsg$goodSamples, gsg$goodGenes]
}
```

### 2. Gene Module Detection (WGCNA)
Use `Auto_WGCNA` as a wrapper for module detection.

```r
GMIC_Builder <- Auto_WGCNA(datExpr,
  mergeCutHeight = 0.35, 
  minModuleSize = 10,
  networkType = "signed hybrid", 
  corFnc = "bicor")

# Annotate modules with Gene Ontology
GMIC_Builder <- Query_Prep(GMIC_Builder, calculate_intramodularConnectivity = TRUE, Find_hubs = TRUE)
GMIC_Builder <- GSEAGO_Builder(GMIC_Builder, species = "Homo sapiens", ontology = "BP")
GMIC_Builder <- GO_Module_NameR(GMIC_Builder)
```

### 3. Integration with xCell Signatures
GmicR requires cell signature results (typically from the xCell web portal).

```r
# file_dir should point to the xCell results text file
GMIC_Builder_disc <- Data_Prep(GMIC_Builder, 
                               xCell_Signatures = "path/to/xCell_results.txt",
                               ibreaks = 10, 
                               Remove_ME0 = TRUE)
```

### 4. Bayesian Network Learning
Learn the network structure using tabu search with bootstrapping.

```r
library(parallel)
cl <- makeCluster(detectCores() - 1)

GMIC_net <- bn_tabu_gen(GMIC_Builder_disc,
                        cluster = cl,
                        bootstraps_replicates = 50, 
                        score = "bds") # 'bds' is preferred for sparse data

stopCluster(cl)
```

### 5. Relationship Inference and Visualization
Identify inverse relationships and visualize the resulting GMIC network.

```r
# Identify positive vs negative relationships
GMIC_Final <- InverseARCs(GMIC_net, threshold = -0.3)

# Launch Shiny app for visualization
if(interactive()){
  Gmic_viz(GMIC_Final)
}
```

## Key Functions Reference
- `Auto_WGCNA()`: Automates the WGCNA pipeline to identify gene modules.
- `GSEAGO_Builder()`: Builds a library for GO enrichment.
- `GO_Module_NameR()`: Assigns biological names to modules based on GO terms.
- `Data_Prep()`: Merges module eigengenes with cell signatures and performs discretization.
- `bn_tabu_gen()`: Performs Bayesian Network structure learning via bootstrapping.
- `InverseARCs()`: Calculates the slope of relationships to distinguish activation from inhibition.

## Tips for Success
- **Gene Symbols**: Ensure your expression matrix uses official Gene Symbols; otherwise, GO annotation will fail.
- **xCell Data**: The package is specifically tuned for xCell signatures. Ensure you use the "xCell results" file provided by the xCell portal.
- **Computational Load**: Bayesian Network learning with many bootstraps is CPU-intensive. Always use the `cluster` argument in `bn_tabu_gen` to enable parallel processing.
- **ME0**: Module 0 (ME0) usually contains unassigned genes. It is often recommended to set `Remove_ME0 = TRUE` in `Data_Prep` to reduce noise in the network.

## Reference documentation
- [GmicR_vignette](./references/GmicR_vignette.md)