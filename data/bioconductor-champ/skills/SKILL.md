---
name: bioconductor-champ
description: ChAMP is a comprehensive pipeline for the analysis of Illumina Methylation BeadArray data, including 450k and EPIC arrays. Use when user asks to load and filter methylation data, perform quality control and normalization, correct for batch effects, or identify differentially methylated probes, regions, and blocks.
homepage: https://bioconductor.org/packages/release/bioc/html/ChAMP.html
---


# bioconductor-champ

name: bioconductor-champ
description: Analysis of Illumina Methylation BeadArray data (EPIC and 450k). Use this skill to perform quality control, normalization (BMIQ, SWAN), batch effect correction (ComBat), and identification of differentially methylated probes (DMP), regions (DMR), and blocks. It also supports Gene Set Enrichment Analysis (GSEA), Copy Number Alteration (CNA) inference, and cell-type heterogeneity adjustment.

# bioconductor-champ

## Overview
ChAMP (Chip Analysis Methylation Pipeline) is a comprehensive R package for analyzing Illumina 450k and EPIC methylation arrays. It integrates various Bioconductor tools into a streamlined workflow, covering everything from raw `.idat` file import to high-level tertiary analyses like pathway enrichment and genomic block detection.

## Core Workflow

### 1. Data Loading and Filtering
The primary entry point is `champ.load()`, which reads `.idat` files and a `Sample_Sheet.csv` (pd file).

```R
library(ChAMP)
testDir <- system.file("extdata", package="ChAMPdata")

# Load and filter data (detects 450K vs EPIC automatically or via arraytype)
myLoad <- champ.load(testDir, arraytype="450K")

# Access components
beta <- myLoad$beta
pd <- myLoad$pd
intensity <- myLoad$intensity
```

**Filtering Criteria:**
- Probes with detection p-values > 0.01.
- Probes with < 3 beads in at least 5% of samples.
- Non-CpG probes, SNP-related probes, and multi-hit probes.
- Probes on X and Y chromosomes (optional).

### 2. Quality Control
Use `champ.QC()` for static plots or `QC.GUI()` for interactive exploration.

```R
champ.QC() 
# Or interactive:
QC.GUI(beta=myLoad$beta, arraytype="450K")
```

### 3. Normalization
Adjusts for the bias between Type-I and Type-II probes. BMIQ is the default and recommended method.

```R
# BMIQ normalization (supports parallel processing)
myNorm <- champ.norm(beta=myLoad$beta, arraytype="450K", cores=4)
```

### 4. Batch Effect Analysis (SVD & ComBat)
Identify technical variation using Singular Value Decomposition (SVD) and correct it with ComBat.

```R
# Identify batches
champ.SVD(beta=myNorm, pd=myLoad$pd)

# Correct for a specific batch (e.g., "Slide")
myCombat <- champ.runCombat(beta=myNorm, pd=myLoad$pd, batchname=c("Slide"))
```

### 5. Differential Methylation Analysis
ChAMP identifies changes at three levels: Probes (DMP), Regions (DMR), and Blocks.

**DMP (Probes):**
```R
myDMP <- champ.DMP(beta=myNorm, pheno=myLoad$pd$Sample_Group)
DMP.GUI(DMP=myDMP[[1]], beta=myNorm, pheno=myLoad$pd$Sample_Group)
```

**DMR (Regions):**
Supports "Bumphunter", "DMRcate", or "ProbeLasso".
```R
myDMR <- champ.DMR(beta=myNorm, pheno=myLoad$pd$Sample_Group, method="DMRcate")
DMR.GUI(DMR=myDMR)
```

**Blocks:**
Identifies large hypomethylated regions, typically in open sea areas.
```R
myBlock <- champ.Block(beta=myNorm, pheno=myLoad$pd$Sample_Group)
Block.GUI(Block=myBlock, beta=myNorm, pheno=myLoad$pd$Sample_Group)
```

### 6. Gene Set Enrichment (GSEA)
Tests if differentially methylated genes are enriched in specific pathways.

```R
myGSEA <- champ.GSEA(beta=myNorm, DMP=myDMP[[1]], DMR=myDMR, method="fisher")
```

## Advanced Features
- **CNA:** Infer copy number alterations using `champ.CNA(intensity=myLoad$intensity, pheno=myLoad$pd$Sample_Group)`.
- **Cell Heterogeneity:** For whole blood samples, estimate cell counts and adjust beta values using `champ.refbase(beta=myNorm, arraytype="450K")`.
- **EPIC Support:** For EPIC arrays, ensure `arraytype="EPIC"` is passed to all relevant functions.

## Tips for Success
- **Memory:** `champ.load()` is memory-intensive. For large datasets (>200 samples), use a server with at least 16GB-32GB RAM.
- **Interactive GUIs:** Functions ending in `.GUI()` (e.g., `DMP.GUI`) require an X11 forwarding system if running on a remote Linux server.
- **Beta-only Input:** If you only have a beta matrix (no `.idat`), start with `champ.filter(beta_matrix, pd_file)` instead of `champ.load()`.

## Reference documentation
- [The Chip Analysis Methylation Pipeline](./references/ChAMP.md)