---
name: bioconductor-geuvadistranscriptexpr
description: This package provides preprocessed GEUVADIS project transcript expression and genotype data for chromosome 19 to support splicing QTL analysis. Use when user asks to load example GEUVADIS datasets, preprocess transcript counts and gene annotations, or encode VCF-based genotypes for sQTL studies.
homepage: https://bioconductor.org/packages/release/data/experiment/html/GeuvadisTranscriptExpr.html
---

# bioconductor-geuvadistranscriptexpr

name: bioconductor-geuvadistranscriptexpr
description: Access and preprocess GEUVADIS project data (transcript expression and genotypes) for sQTL analysis. Use this skill when you need to load example datasets for chromosome 19 (CEU population) or follow the workflow for preparing transcript counts, gene annotations (BED), and VCF-based genotypes for splicing QTL studies.

# bioconductor-geuvadistranscriptexpr

## Overview

The `GeuvadisTranscriptExpr` package is a data-experiment package providing a subset of the GEUVADIS project data. It specifically contains preprocessed transcript quantification and genotype data for chromosome 19 from the CEU (CEPH) population. This data is primarily used as a benchmark or example for splicing quantitative trait loci (sQTL) analysis.

The package serves two purposes:
1. Providing ready-to-use data files for testing sQTL methods.
2. Demonstrating the workflow to process raw GEUVADIS FluxCapacitor counts and VCF genotypes into a format suitable for analysis.

## Data Access

The package provides several key files located in the `extdata` directory. You can locate them using `system.file`.

### Loading Example Data
```r
library(GeuvadisTranscriptExpr)

# Locate the preprocessed files
counts_file <- system.file("extdata", "TrQuantCount_CEU_chr19.tsv", package="GeuvadisTranscriptExpr")
genotypes_file <- system.file("extdata", "genotypes_CEU_chr19.tsv", package="GeuvadisTranscriptExpr")
genes_bed_file <- system.file("extdata", "genes_chr19.bed", package="GeuvadisTranscriptExpr")

# Read the data
counts <- read.table(counts_file, header = TRUE, sep = "\t", as.is = TRUE)
genotypes <- read.table(genotypes_file, header = TRUE, sep = "\t", as.is = TRUE)
genes_bed <- read.table(genes_bed_file, header = FALSE, sep = "\t")
```

## Workflow for Data Preprocessing

If you are processing full GEUVADIS datasets beyond the provided example, follow these steps:

### 1. Annotation and Metadata
Use `rtracklayer` to import Gencode GTF files and filter for protein-coding genes.
- Convert GTF to BED format (Chr, Start, End, GeneID).
- Ensure chromosome naming consistency (e.g., removing "chr" prefix) to match VCF files.
- Shorten sample IDs to match genotype headers (e.g., using `limma::strsplit2`).

### 2. Transcript Counts
- Filter the raw quantification file (e.g., `GD660.TrQuantCount.txt`) for the specific population and chromosome of interest.
- Map `TargetID` and `Gene_Symbol` to the expression values.

### 3. Genotype Processing
The package demonstrates a specific encoding for genotypes using `VariantAnnotation`:
- **Input**: VCF files (bgzipped and indexed).
- **Filtering**: Select bi-allelic SNPs within a specific window (e.g., 5000bp) of the gene body.
- **Encoding**:
    - `0`: Reference/Reference (0/0 or 0|0)
    - `1`: Reference/Alternative (0/1, 1/0, etc.)
    - `2`: Alternative/Alternative (1/1 or 1|1)
    - `-1` or `NA`: Missing values

```r
# Example of genotype encoding logic
# vcf is a VCF object from VariantAnnotation::readVcf
geno <- geno(vcf)$GT
geno01 <- geno
geno01[] <- -1
geno01[geno %in% c("0/0", "0|0")] <- 0
geno01[geno %in% c("0/1", "0|1", "1/0", "1|0")] <- 1
geno01[geno %in% c("1/1", "1|1")] <- 2
```

## Tips for sQTL Analysis
- **Window Size**: A common default is testing SNPs within 5kb of the gene, but this can be adjusted using `GenomicRanges::resize`.
- **Population Stratification**: GEUVADIS contains five populations (CEU, FIN, GBR, TSI, YRI). Always subset your data by population to avoid confounding.
- **Normalization**: While this package provides counts, sQTL analysis typically requires normalization (e.g., TMM or CQN) and often uses transcript ratios rather than absolute counts.

## Reference documentation
- [GeuvadisTranscriptExpr](./references/GeuvadisTranscriptExpr.md)