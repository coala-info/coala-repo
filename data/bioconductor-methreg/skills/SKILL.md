---
name: bioconductor-methreg
description: MethReg performs integrative analysis of DNA methylation, gene expression, and transcription factor binding data to identify functional regulatory triplets. Use when user asks to evaluate the regulatory potential of DNA methylation on gene transcription, identify synergistic transcription factor-methylation interactions, or prioritize CpG-TF-target gene triplets.
homepage: https://bioconductor.org/packages/release/bioc/html/MethReg.html
---


# bioconductor-methreg

name: bioconductor-methreg
description: Integrative analysis of DNA methylation, gene expression, and transcription factor (TF) binding data. Use this skill to evaluate the regulatory potential of DNA methylation (CpGs or DMRs) on gene transcription, identify synergistic TF-methylation interactions, and prioritize regulatory triplets (CpG-TF-Target Gene).

## Overview

MethReg is designed to identify functional associations between DNA methylation and gene expression by incorporating Transcription Factor Binding Site (TFBS) information. It operates by creating "triplets" consisting of a methylation site (CpG or DMR), a Transcription Factor (TF) that binds near that site, and a putative target gene. It then applies robust linear models to test for interactions between TF activity and methylation levels on target gene expression.

## Core Workflow

### 1. Data Preparation
Input data should be matched samples with DNA methylation (Beta or M-values) and gene expression (normalized log2 counts).

```R
library(MethReg)
library(SummarizedExperiment)

# Create DNA methylation SE object (supports 450k and EPIC)
dna.met.se <- make_dnam_se(
  dnam = dna_matrix, 
  genome = "hg38", 
  arrayType = "450k"
)

# Create Gene Expression SE object
gene.exp.se <- make_exp_se(
  exp = exp_matrix, 
  genome = "hg38"
)
```

### 2. Creating Triplets
Triplets link a genomic region (CpG) to a TF and a target gene.

**Distance-based approach (Promoter or Distal):**
```R
# Promoter overlap: links CpG to genes within +/- 2kb of TSS
triplet.promoter <- create_triplet_distance_based(
  region = dna.met.se,
  target.method = "genes.promoter.overlap",
  genome = "hg38",
  motif.search.window.size = 400 # Search for TF motifs around CpG
)

# Window-based (Distal): links CpG to genes within a 500kb window
triplet.distal <- create_triplet_distance_based(
  region = dna.met.se,
  target.method = "window",
  target.window.size = 500000,
  genome = "hg38"
)
```

**Regulon-based approach:**
Uses external TF-target databases (e.g., Dorothea).
```R
triplet.regulon <- create_triplet_regulon_based(
  region = dna.met.se,
  genome = "hg38",
  tf.target = dorothea::dorothea_hs
)
```

### 3. Statistical Modeling
MethReg tests if the interaction between TF activity and DNA methylation significantly affects target gene expression.

```R
# Interaction model: log2(Target) ~ log2(TF) + DNAm_Group + log2(TF):DNAm_Group
results.inter <- interaction_model(
  triplet = triplet.promoter,
  dnam = dna.met.se,
  exp = gene.exp.se,
  dnam.group.threshold = 0.25, # Top/Bottom 25% for binary group
  fdr = TRUE
)

# Stratified model: assess TF effect separately in High and Low methylation groups
results.strat <- stratified_model(
  triplet = results.inter,
  dnam = dna.met.se,
  exp = gene.exp.se
)
```

### 4. Visualization
Visualize the interaction to interpret if methylation enhances or attenuates TF activity.

```R
plots <- plot_interaction_model(
  triplet.results = results.inter[1, ], 
  dnam = dna.met.se, 
  exp = gene.exp.se
)
plots[[1]]
```

## Advanced Features

### Controlling for Confounders
If data has batch effects, age, or sex bias, use residuals for the analysis.
```R
# Extract residuals after adjusting for metadata
exp.residuals <- get_residuals(gene.exp.se, metadata_df)
dnam.residuals <- get_residuals(dna.met.se, metadata_df)
```

### TF Activity Estimation
Instead of raw TF expression, use Enrichment Scores (ES) from GSVA or VIPER.
```R
# Calculate TF activity using Dorothea regulons
tf.es <- get_tf_ES(
  exp = assay(gene.exp.se),
  regulons = dorothea::dorothea_hs
)
```

## Key Parameters
- `motif.search.window.size`: Recommended <= 400bp around the CpG to ensure the methylation site is likely to affect the TF binding site.
- `target.method`: Use `genes.promoter.overlap` for proximal regulation and `window` or `nearby.genes` for enhancer/distal regulation.
- `dnam.group.threshold`: Defines the "High" vs "Low" methylation groups (default 0.25).

## Reference documentation
- [MethReg: estimating regulatory potential of DNA methylation in gene transcription](./references/MethReg.md)
- [MethReg Vignette Source](./references/MethReg.Rmd)