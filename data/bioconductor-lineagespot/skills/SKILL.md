---
name: bioconductor-lineagespot
description: This tool identifies SARS-CoV-2 lineages and mutations from VCF files by cross-referencing variants against lineage-defining mutation reports. Use when user asks to identify SARS-CoV-2 lineages in wastewater samples, calculate allele frequency metrics for variants, or compare VCF data against known lineage-defining rules.
homepage: https://bioconductor.org/packages/release/bioc/html/lineagespot.html
---

# bioconductor-lineagespot

name: bioconductor-lineagespot
description: Identify SARS-CoV-2 lineages and mutations from VCF files, specifically for wastewater surveillance and genomic epidemiology. Use this skill when analyzing SARS-CoV-2 variant calling data to infer lineage distribution, calculate allele frequency (AF) metrics, and compare sample variants against known lineage-defining mutation reports.

# bioconductor-lineagespot

## Overview

`lineagespot` is an R package designed to identify SARS-CoV-2 lineages in NGS data, with a particular focus on the complexities of wastewater samples. It cross-references variants found in VCF files against lineage-defining mutation rules to provide a probabilistic view of lineage abundance. The tool calculates metrics such as mean allele frequency (AF) per lineage and the proportion of lineage-defining variants detected.

## Core Workflow

The primary entry point is the `lineagespot()` function, which automates the pipeline from VCF parsing to lineage reporting.

### 1. Basic Execution

To run the analysis, you need a folder containing VCF files, a GFF3 annotation file for SARS-CoV-2, and a reference folder containing lineage mutation reports (typically CSV files).

```r
library(lineagespot)

results <- lineagespot(
  vcf_folder = "path/to/vcf_files",
  gff3_path = "path/to/NC_045512.2_annot.gff3",
  ref_folder = "path/to/lineage_reports",
  af_threshold = 0.01 # Optional: filter variants by minimum allele frequency
)
```

### 2. Input Requirements

- **VCF Files**: Should contain variant calls (e.g., from FreeBayes or GATK). The package extracts depth (DP), allele depth (AD), and calculates allele frequency (AF).
- **GFF3 File**: Used for functional annotation of variants (mapping genomic positions to genes and amino acid changes).
- **Reference Folder**: Contains CSV files defining the mutations for each lineage of interest (e.g., AY.1, B.1.1.7).

### 3. Interpreting Results

The function returns a list containing three data tables:

- **`results$variants.table`**: A comprehensive list of all variants found across input samples, including genomic position, reference/alternate alleles, gene name, and amino acid change (AA_alt).
- **`results$lineage.hits`**: A filtered table showing only the variants that overlap with the provided lineage definitions.
- **`results$lineage.report`**: The summary table used for inference. Key columns include:
    - `meanAF`: Average allele frequency of all detected variants for that lineage.
    - `meanAF_uniq`: Average AF of variants unique to that specific lineage.
    - `N lineage`: Number of lineage-defining variants detected in the sample.
    - `N rules`: Total number of variants defined for that lineage in the reference.
    - `lineage prop.`: The ratio of detected variants to total expected variants (N lineage / N rules).

## Tips for Analysis

- **Allele Frequency**: In wastewater, multiple lineages often coexist. Pay close attention to `meanAF_uniq` to distinguish between closely related sub-lineages.
- **Data Cleaning**: Ensure your VCF files are properly annotated or that the `gff3_path` matches the reference genome used during alignment (usually NC_045512.2).
- **Custom Lineages**: You can add custom lineage definitions by placing new CSV files in the `ref_folder` following the package's expected schema (Gene, AA_alt).

## Reference documentation

- [lineagespot User Guide](./references/lineagespot.md)
- [lineagespot R Markdown Source](./references/lineagespot.Rmd)