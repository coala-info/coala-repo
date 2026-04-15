---
name: bioconductor-somaticcanceralterations
description: This package provides access to curated somatic mutation data from TCGA studies in standardized Bioconductor formats. Use when user asks to retrieve somatic variants from TCGA, load cancer mutation datasets as GRanges objects, or analyze curated somatic callsets across different tumor types.
homepage: https://bioconductor.org/packages/release/data/experiment/html/SomaticCancerAlterations.html
---

# bioconductor-somaticcanceralterations

name: bioconductor-somaticcanceralterations
description: Access and analyze somatic mutation callsets from TCGA studies. Use when working with cancer genomics data in R, specifically for retrieving curated somatic variants (SNPs, Indels) across various tumor types (GBM, LUAD, OV, etc.) and integrating them with GenomicRanges workflows.

# bioconductor-somaticcanceralterations

## Overview

The `SomaticCancerAlterations` package provides a curated collection of somatic mutation data from The Cancer Genome Atlas (TCGA). It transforms raw mutation callsets (MAF files) into Bioconductor-standard `GRanges` objects, facilitating seamless integration with other genomic analysis tools.

Key features:
- Access to multiple TCGA studies (e.g., Glioblastoma, Lung Adenocarcinoma, Ovarian Cancer).
- Standardized genomic coordinates (NCBI 37/hg19).
- Metadata for study-level information (sequencing platform, sample size).
- Integration with `GenomicRanges` for spatial queries and overlaps.

## Core Workflow

### 1. Discover Available Data
Use `scaListDatasets()` to see available study IDs and `scaMetadata()` to view study details.

```r
library(SomaticCancerAlterations)

# List available study IDs
ids <- scaListDatasets()

# View metadata (Cancer Type, Sequencer, Sample Count, etc.)
meta <- scaMetadata()
head(meta)
```

### 2. Load Datasets
Load one or more datasets using `scaLoadDatasets()`. You can choose to keep them as a list or merge them into a single object.

```r
# Load a single dataset (returns GRanges)
ov <- scaLoadDatasets("ov_tcga")

# Load multiple datasets as a GRangesList
multi <- scaLoadDatasets(c("gbm_tcga", "luad_tcga"))

# Load and merge multiple datasets into one GRanges object
merged <- scaLoadDatasets(c("gbm_tcga", "luad_tcga"), merge = TRUE)
```

### 3. Explore Mutation Data
The data is stored as a `GRanges` object. Metadata columns (`mcols`) contain critical information like gene symbols and mutation types.

```r
# View the first few mutations
head(ov)

# Tabulate mutation types
table(ov$Variant_Classification)

# Identify most frequently mutated genes
head(sort(table(ov$Hugo_Symbol), decreasing = TRUE))
```

### 4. Genomic Queries
Since the data is in `GRanges` format, you can subset mutations by specific genomic regions.

```r
library(GenomicRanges)

# Define a region of interest (e.g., TP53 locus on Chr 17)
tp53_region <- GRanges("17", IRanges(7571720, 7590863))

# Subset mutations overlapping this region
tp53_muts <- subsetByOverlaps(ov, tp53_region)

# Analyze variants in this region across studies
table(tp53_muts$Variant_Classification)
```

## Common Analysis Patterns

### Calculating Mutation Fractions
To determine the percentage of patients in a study harboring a mutation in a specific region:

```r
# Function to calculate fraction of mutated patients
calc_mut_fraction <- function(gr) {
    # Get total patients from study metadata
    total_patients <- metadata(gr)$Number_Patients
    # Count unique patients with mutations in the current GRanges
    mutated_patients <- length(unique(gr$Patient_ID))
    return(mutated_patients / total_patients)
}

# Apply to a list of studies
fractions <- sapply(multi, function(x) {
    region_hits <- subsetByOverlaps(x, tp53_region)
    calc_mut_fraction(region_hits)
})
```

### Cross-Study Comparisons
When using `merge = TRUE`, the `Dataset` column allows you to group and compare mutation profiles across different cancer types.

```r
merged_data <- scaLoadDatasets(scaListDatasets(), merge = TRUE)

# Compare mutation counts for a specific gene across all TCGA studies
gene_counts <- table(merged_data$Hugo_Symbol, merged_data$Dataset)
tp53_counts <- gene_counts["TP53", ]
```

## Usage Tips
- **Genome Build**: Data is consistently mapped to NCBI 37 (hg19). Ensure your reference objects (e.g., TxDb) match this build.
- **Metadata Access**: Use `metadata(gr)` on a loaded dataset to access study-specific information like the number of patients and sequencing center.
- **Filtering**: Use standard `mcols()` filtering to remove "Silent" mutations if focusing only on functional alterations: `ov[ov$Variant_Classification != "Silent"]`.

## Reference documentation

- [SomaticCancerAlterations](./references/SomaticCancerAlterations-html.md)