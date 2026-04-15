---
name: bioconductor-elmer.data
description: ELMER.data provides essential metadata, motif occurrence matrices, and transcription factor classifications required for the ELMER R package. Use when user asks to access DNA methylation probe manifests, retrieve motif enrichment data for enhancer regions, or identify transcription factor family classifications.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ELMER.data.html
---

# bioconductor-elmer.data

## Overview

ELMER.data is a specialized data package that provides the necessary infrastructure for the ELMER R package. It contains metadata for Infinium DNA methylation platforms (450K and EPIC), motif occurrences within enhancer regions, and transcription factor (TF) classifications. This data is essential for identifying enhancers, correlating them with target genes, and inferring upstream regulators.

## Installation and Loading

To use the data in an R session, ensure the package is installed and loaded:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ELMER.data")

library(ELMER.data)
```

## Accessing Data Objects

The package provides several key datasets that are typically called internally by ELMER functions but can be accessed directly for custom analyses.

### 1. Probe Manifests
These objects contain genomic coordinates and metadata for methylation probes, retrieved from InfiniumAnnotation.

```r
# Load 450K or EPIC manifests for hg19 or hg38
data("hm450.hg19.manifest")
data("hm450.hg38.manifest")
data("EPIC.hg19.manifest")
data("EPIC.hg38.manifest")

# View structure
head(as.data.frame(EPIC.hg38.manifest))
```

### 2. Motif Occurrence Matrices (Probes.motif)
These are sparse matrices (`ngCMatrix`) indicating the presence (1) or absence (0) of TF motifs within ±250bp of probe sites. These are used by ELMER to calculate Odds Ratios for motif enrichment.

```r
# Load motif data for specific platform and genome
data("Probes.motif.hg19.450K")
data("Probes.motif.hg38.450K")
data("Probes.motif.hg19.EPIC")
data("Probes.motif.hg38.EPIC")

# Check dimensions (Rows = Probes, Columns = Motifs)
dim(Probes.motif.hg38.EPIC)
```

### 3. Transcription Factor Classifications
ELMER uses TFClass and HOCOMOCO classifications to group TFs into families and subfamilies. This allows the tool to identify potential redundant or co-regulatory TFs.

```r
# Load TF family and subfamily mappings
data("TF.family")
data("TF.subfamily")

# Load curated human TF list (Lambert et al. 2018)
data("human.TF")
```

### 4. Gene and TSS Information
The package includes pre-processed ENSEMBL gene and Transcription Start Site (TSS) data for hg19 and hg38.

```r
data("Human_genes__GRCh37_p13")
data("Human_genes__GRCh38_p12")
data("Human_genes__GRCh37_p13__tss")
data("Human_genes__GRCh38_p12__tss")
```

## Usage Tips

- **Memory Management**: The `Probes.motif` objects are large sparse matrices. Ensure you have sufficient RAM when loading them directly.
- **Genome Versions**: Always match the data object (e.g., `hg38`) to the genome build used in your primary analysis to avoid coordinate mismatches.
- **Integration with ELMER**: Most users do not need to load these datasets manually; the `ELMER` package functions (like `get.enriched.motif`) will automatically look for these objects if `ELMER.data` is installed.

## Reference documentation

- [ELMER.data: Supporting data for the ELMER package](./references/vignettes.md)