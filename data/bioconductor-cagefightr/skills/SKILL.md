---
name: bioconductor-cagefightr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/CAGEfightR.html
---

# bioconductor-cagefightr

name: bioconductor-cagefightr
description: Expert guidance for using the CAGEfightR R/Bioconductor package to analyze 5'-end genomic data (CAGE, PRO-Cap, START-Seq, TSS-Seq). Use this skill when performing Transcription Start Site (TSS) and enhancer identification, quantification, annotation with transcript models, and spatial analysis like TSS-enhancer correlations or super-enhancer identification.

# bioconductor-cagefightr

## Overview

CAGEfightR is a Bioconductor package designed for the analysis of 5'-end sequencing data. It provides a comprehensive workflow to transform raw 5'-end counts (CTSSs) into biologically meaningful clusters (TSSs and enhancers). It supports:
- **Quantification**: Importing BigWig files and summarizing counts at CTSS, cluster, and gene levels.
- **Clustering**: Identifying unidirectional Tag Clusters (TSSs) and bidirectional clusters (enhancers).
- **Annotation**: Assigning clusters to transcript models (promoter, proximal, 5'-UTR, etc.) and genes.
- **Spatial Analysis**: Calculating expression correlations between nearby TSSs and enhancers (links) and identifying super-enhancers (stretches).

## Core Workflow

### 1. Data Import and CTSS Quantification
Analysis begins with BigWig files (plus and minus strands).

```r
library(CAGEfightR)
library(SummarizedExperiment)

# Define design and files
bw_plus <- BigWigFileList(c(S1_plus="path/to/s1_plus.bw"))
bw_minus <- BigWigFileList(c(S1_minus="path/to/s1_minus.bw"))
genomeInfo <- SeqinfoForUCSCGenome("mm9")

# Quantify CTSSs
CTSSs <- quantifyCTSSs(plusStrand=bw_plus,
                       minusStrand=bw_minus,
                       genome=genomeInfo)

# Normalize and Pool
CTSSs <- calcTPM(CTSSs, inputAssay="counts")
CTSSs <- calcPooled(CTSSs, inputAssay="TPM")
```

### 2. Identifying TSSs and Enhancers
Use `quickTSSs` and `quickEnhancers` for fast processing, or the underlying functions for control.

```r
# Unidirectional clustering (TSSs)
TSSs <- clusterUnidirectionally(CTSSs, pooledCutoff=0.1, mergeDist=20)

# Bidirectional clustering (Enhancers)
enhancers <- clusterBidirectionally(CTSSs, balanceThreshold=0.95)
enhancers <- calcBidirectionality(enhancers, samples=CTSSs)
enhancers <- subset(enhancers, bidirectionality > 0)
```

### 3. Annotation and Filtering
Annotate clusters using a `TxDb` object to determine genomic context.

```r
library(TxDb.Mmusculus.UCSC.mm9.knownGene)
txdb <- TxDb.Mmusculus.UCSC.mm9.knownGene

# Annotate and filter enhancers (keep only non-exonic)
enhancers <- assignTxType(enhancers, txModels=txdb)
enhancers <- subset(enhancers, txType %in% c("intergenic", "intron"))

# Combine for downstream analysis
RSE <- combineClusters(TSSs, enhancers, removeIfOverlapping="object1")
```

### 4. Spatial Analysis (Links and Stretches)
Identify potential regulatory interactions based on expression correlation.

```r
# Find TSS-Enhancer links
rowRanges(RSE)$clusterType <- factor(rowRanges(RSE)$clusterType, levels=c("TSS", "enhancer"))
links <- findLinks(RSE, inputAssay="counts", maxDist=5000, directional="clusterType", method="kendall")

# Find Super-enhancers (stretches of enhancers)
stretches <- findStretches(enhancers, inputAssay="counts", minSize=3, mergeDist=10000)
```

### 5. Gene-Level Analysis
Collapse cluster-level expression to gene-level for standard differential expression tools.

```r
# Assign Gene IDs and quantify
RSE <- assignGeneID(RSE, geneModels=txdb)
gene_level <- quantifyGenes(RSE, genes="geneID", inputAssay="counts")
```

## Key Functions Reference

| Function | Description |
| :--- | :--- |
| `quantifyCTSSs` | Imports BigWig files into a sparse RangedSummarizedExperiment. |
| `calcTPM` / `calcPooled` | Normalizes counts and creates a pooled signal across samples. |
| `clusterUnidirectionally` | Finds Tag Clusters (TCs) on the same strand. |
| `clusterBidirectionally` | Finds bidirectional clusters (BCs) based on balance score. |
| `assignTxType` | Hierarchical annotation (promoter > proximal > UTR > intron > etc). |
| `findLinks` | Calculates correlation between nearby genomic features. |
| `subsetBySupport` | Filters features based on the number of samples expressing them. |
| `trackCTSS` / `trackClusters` | Creates Gviz tracks for visualization. |

## Tips for Success
- **Sparsity**: CTSS data is stored as `dgCMatrix` (sparse) to save memory. Use `assay(RSE)` to access.
- **Peak vs Cluster**: Use `swap="thick"` in `assignTxType` to annotate based on the highest peak (TSS) rather than the whole cluster width.
- **Filtering**: Always filter lowly expressed features using `subsetBySupport` or `subsetByComposition` before differential expression analysis.
- **Parallelization**: `quantifyCTSSs` and `findLinks` support `BiocParallel`. Register a backend like `MulticoreParam()` to speed up processing.

## Reference documentation
- [Introduction to CAGEfightR](./references/Introduction_to_CAGEfightR.md)
- [Introduction to CAGEfightR (Rmd Source)](./references/Introduction_to_CAGEfightR.Rmd)