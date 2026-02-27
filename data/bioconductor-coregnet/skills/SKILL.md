---
name: bioconductor-coregnet
description: CoRegNet reconstructs and analyzes large-scale transcription factor co-regulatory networks by modeling synergistic interactions between regulators. Use when user asks to infer co-regulatory networks, estimate transcription factor activity, integrate external regulatory evidence, or visualize gene regulatory networks interactively.
homepage: https://bioconductor.org/packages/3.8/bioc/html/CoRegNet.html
---


# bioconductor-coregnet

## Overview
CoRegNet is a Bioconductor package designed to infer large-scale transcription co-regulatory networks. Unlike standard networks that map single TF-to-gene interactions, CoRegNet models cooperation between transcription factors (co-activators and co-inhibitors) to regulate target genes. It provides a complete workflow from network reconstruction and refinement with external data to the estimation of transcription factor activity (influence) and interactive visualization.

## Core Workflow

### 1. Data Preparation and Discretization
The inference algorithm (hLICORN) requires both continuous expression data and a discretized version.

```r
library(CoRegNet)
data(CIT_BLCA_EXP, HumanTF)

# Discretize data: +1 (over-expressed), -1 (under-expressed), 0 (no change)
# Uses SD-based threshold by default
discData = discretizeExpressionData(CIT_BLCA_EXP)

# Optional: Use a hard threshold
discData_hard = discretizeExpressionData(CIT_BLCA_EXP, threshold = 1.0)
```

### 2. Network Reconstruction (hLICORN)
Reconstruct the network using the hybrid LICORN algorithm. This identifies sets of TFs that synergistically regulate target genes.

```r
# TFlist should be a character vector of gene symbols or Entrez IDs
grn = hLICORN(CIT_BLCA_EXP, TFlist = HumanTF)

# Parallelization: hLICORN uses mclapply
options("mc.cores" = 4)
grn = hLICORN(CIT_BLCA_EXP, TFlist = HumanTF)
```

### 3. Integrating External Evidence
Refine the inferred network by adding biological evidence such as ChIP-seq data (TF-to-gene) or Protein-Protein Interactions (TF-to-TF).

```r
# Add regulatory evidence (e.g., ChIP-seq)
enrichedGRN = addEvidences(grn, CHEA_sub, ENCODE_sub)

# Add cooperative evidence (e.g., PPI)
enrichedGRN = addCooperativeEvidences(enrichedGRN, HIPPIE_sub, STRING_sub)

# Refine the network based on integrated scores
# integration can be "unsupervised" (default) or "supervised"
refinedGRN = refine(enrichedGRN, integration = "unsupervised")
```

### 4. Estimating TF Activity (Influence)
Calculate the "influence" of a TF, which measures the divergence in expression between its activated and repressed target genes in a specific sample.

```r
# Returns a matrix: rows = TFs, cols = samples
tf_influence = regulatorInfluence(grn, CIT_BLCA_EXP)
```

### 5. Identifying Co-regulators
Extract significant pairs of TFs that share more target genes than expected by chance.

```r
coregs = coregulators(grn)
head(coregs)
```

### 6. Interactive Visualization
Launch a Shiny-based interface to explore the network, TF influence, and clinical associations.

```r
# Basic display
display(grn, CIT_BLCA_EXP)

# Advanced display with influence and clinical subgroups
display(grn, expressionData = CIT_BLCA_EXP, TFA = tf_influence, clinicalData = CIT_BLCA_Subgroup)

# Include alteration data (e.g., CNV)
display(grn, expressionData = CIT_BLCA_EXP, TFA = tf_influence, 
        clinicalData = CIT_BLCA_Subgroup, alterationData = CIT_BLCA_CNV)
```

## Key Functions Reference
- `hLICORN()`: Main inference function.
- `discretizeExpressionData()`: Prepares data for the discrete step of LICORN.
- `regulatorInfluence()`: Calculates TF activity scores.
- `addEvidences()` / `addCooperativeEvidences()`: Integrates external datasets.
- `refine()`: Filters the network using integrated evidence.
- `display()`: Starts the interactive Cytoscape/Shiny web interface.

## Reference documentation
- [CoRegNet: Reconstruction and integrated analysis of Co-Regulatory Networks](./references/CoRegNet.md)