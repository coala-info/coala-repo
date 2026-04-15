---
name: bioconductor-rcistarget.hg19.motifdbs.cisbponly.500bp
description: This package provides gene-based motif rankings and transcription factor annotations for the human genome (hg19) restricted to CIS-BP motifs within 500bp upstream of the transcription start site. Use when user asks to perform motif enrichment analysis with RcisTarget, identify transcription factor binding sites in promoter regions, or access lightweight motif ranking databases for hg19.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RcisTarget.hg19.motifDBs.cisbpOnly.500bp.html
---

# bioconductor-rcistarget.hg19.motifdbs.cisbponly.500bp

## Overview

This package is a specialized data experiment package for use with `RcisTarget`. It contains gene-based motif rankings and transcription factor (TF) annotations for the human genome (hg19). Unlike the full RcisTarget databases (which contain ~20k motifs and 10kbp search spaces), this package is a lightweight subset containing 4,600 motifs from the CIS-BP database, specifically scored within the 500bp region upstream of the TSS.

## Data Objects

The package provides two primary objects once loaded:

1.  `hg19_500bpUpstream_motifRanking_cispbOnly`: A ranking matrix where rows are motifs and columns are genes. It stores the ranking of each gene for each motif.
2.  `hg19_motifAnnotation_cisbpOnly`: A `data.table` containing the mapping between motifs and TFs, including the source of the annotation (direct, orthology, or similarity).

## Usage Workflow

### 1. Loading the Data
To use these databases in an `RcisTarget` workflow, first load the package:

```r
library(RcisTarget.hg19.motifDBs.cisbpOnly.500bp)

# Access the objects
data(hg19_500bpUpstream_motifRanking_cispbOnly)
data(hg19_motifAnnotation_cisbpOnly)
```

### 2. Integrating with RcisTarget
These objects are passed directly to `RcisTarget` functions. 

**Important Constraint:** Because this is a subset, only rankings under 5050 are kept. You must set `aucMaxRank` and `maxRank` parameters to a maximum of **5050** in the following functions:

```r
library(RcisTarget)

# Calculate AUC
motifs_AUC <- calcAUC(geneLists, 
                      hg19_500bpUpstream_motifRanking_cispbOnly, 
                      aucMaxRank = 5050)

# Identify enriched motifs
enrichedMotifs <- addSignificantGenes(motifs_AUC, 
                                      rankings = hg19_500bpUpstream_motifRanking_cispbOnly, 
                                      motifAnnot = hg19_motifAnnotation_cisbpOnly,
                                      maxRank = 5050)
```

### 3. Exploring Annotations
You can filter the annotation table to see how a specific motif is linked to a TF:

```r
# View annotations for a specific motif
library(data.table)
annot <- hg19_motifAnnotation_cisbpOnly[motif == "cisbp__M0010"]

# Filter for direct annotations only
directAnnot <- hg19_motifAnnotation_cisbpOnly[directAnnotation == TRUE]
```

## Tips and Limitations
- **Search Space:** This database only considers 500bp upstream of the TSS. If you expect regulatory elements to be further away (e.g., enhancers), use the full 10kbp databases instead.
- **Ranking Limit:** Do not exceed a rank of 5050 in your analysis parameters, as data beyond this threshold was truncated to save space.
- **TF Mapping:** The `annotationSource` column helps distinguish between high-confidence "directAnnotation" and inferred relationships (orthology/similarity).

## Reference documentation
- [RcisTarget.hg19.motifDBs.cisbpOnly.500bp Reference Manual](./references/reference_manual.md)