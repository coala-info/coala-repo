---
name: bioconductor-funcisnp
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/bioc/html/FunciSNP.html
---

# bioconductor-funcisnp

name: bioconductor-funcisnp
description: Integrating functional non-coding datasets with genetic association studies (GWAS) to identify candidate regulatory SNPs. Use this skill when analyzing GWAS tagSNPs to find correlated SNPs (in Linkage Disequilibrium) that overlap with functional genomic features (Biofeatures) like ChIP-seq peaks, enhancers, or promoters.

## Overview

FunciSNP is an R/Bioconductor package that identifies putative functional SNPs (YAFSNPs) by integrating GWAS results with functional genomic data. It automates the process of fetching correlated SNPs from the 1000 Genomes Project, calculating Linkage Disequilibrium (LD), and intersecting these variants with user-provided or built-in genomic features (BED files).

## Core Workflow

### 1. Data Preparation

Two primary inputs are required:
- **GWAS SNP File**: A whitespace/tab-separated file with three columns: `Position` (hg19 chrom:pos), `rsID`, and `population` (EUR, AFR, AMR, ASN, or ALL).
- **Biofeatures**: A folder containing genomic features in BED format (extension `.bed`).

```r
library(FunciSNP)

# Example GWAS input
# Format: 11:118477367 rs498872 EUR
gwas_file <- "path/to/gwas_snps.txt"

# Example Biofeatures folder
bio_folder <- "path/to/bed_files/"
```

### 2. Identifying Functional SNPs

The primary function is `getFSNPs`. It connects to 1000 Genomes (NCBI or EBI) to find SNPs in LD with your tagSNPs and filters for those overlapping your biofeatures.

```r
# This step requires internet access and can be computationally intensive
results <- getFSNPs(
  snp.regions.file = gwas_file, 
  bio.features.loc = bio_folder,
  bio.features.TSS = FALSE # Set TRUE to include built-in TSS features
)

# View summary of results at different R-squared thresholds
results
summary(results)
```

### 3. Annotation and Summarization

Annotate the identified SNPs with genomic context (intron, exon, promoter, etc.) using `FunciSNPAnnotateSummary`.

```r
# Create a comprehensive data frame of results
annotated_df <- FunciSNPAnnotateSummary(results)

# Generate a summary table at a specific R-squared cutoff
FunciSNPtable(annotated_df, rsq = 0.5)

# Get gene symbols associated with SNPs at a specific cutoff
FunciSNPtable(annotated_df, rsq = 0.5, geneSum = TRUE)
```

### 4. Visualization

FunciSNP provides several plotting options to evaluate the distribution and significance of results.

```r
# 1. Distribution of R-squared values
FunciSNPplot(annotated_df)

# 2. Distribution split by tagSNP
FunciSNPplot(annotated_df, splitbysnp = TRUE)

# 3. Heatmap of tagSNP vs Biofeature overlaps
FunciSNPplot(annotated_df, heatmap = TRUE, rsq = 0.1)

# 4. Genomic feature enrichment (Exon, Intron, etc.)
FunciSNPplot(annotated_df, rsq = 0.5, genomicSum = TRUE)
```

### 5. Exporting for Genome Browsers

Export results to BED format for visualization in tools like the UCSC Genome Browser.

```r
# Exports a BED file to the current working directory
FunciSNPbed(annotated_df, rsq = 0.5)
```

## Tips and Best Practices

- **Genome Build**: FunciSNP is designed for **hg19**. Ensure your coordinates and BED files match this assembly.
- **Performance**: On Linux/Mac, the package can use multiple cores. On Windows, it runs on a single core and may take significantly longer.
- **Population Selection**: Match the population code (e.g., `EUR`) to the study population of the GWAS to ensure accurate LD calculations.
- **R-squared Cutoff**: Use `FunciSNPplot` first to see the distribution of LD before deciding on a strict `rsq` cutoff for downstream analysis.

## Reference documentation

- [Using the FunciSNP package](./references/FunciSNP_vignette.md)