---
name: r-qtlseqr
description: R package qtlseqr (documentation from project home).
homepage: https://cran.r-project.org/web/packages/qtlseqr/index.html
---

# r-qtlseqr

## Overview

QTLseqr is designed for identifying QTLs in bulked populations using NGS data. It supports two primary statistical frameworks:
1. **QTL-seq**: Uses a simulation-based method to calculate confidence intervals for the delta SNP index.
2. **G'**: Uses a tricube-smoothed G statistic to identify significant genomic regions.

The package handles the entire workflow from data ingestion and quality filtering to statistical analysis and publication-quality visualization.

## Installation

To install the package from CRAN:
install.packages("qtlseqr")

To install the development version from GitHub:
devtools::install_github("bmansfeld/QTLseqr")

## Workflow and Functions

### 1. Data Import
Use `importFromGATK()` to load SNP data exported from GATK's VariantsToTable tool.
- `file`: Path to the GATK table.
- `highBulk` / `lowBulk`: Sample names for the two bulks.
- `chromList`: Vector of chromosomes to include (e.g., `paste0("Chr", 1:12)`).

### 2. SNP Filtering
Use `filterSNPs()` to remove low-quality or uninformative variants.
- `refAlleleFreq`: Filter by reference allele frequency (e.g., 0.20).
- `minTotalDepth` / `maxTotalDepth`: Filter by combined depth across bulks.
- `minSampleDepth`: Minimum depth per bulk.
- `minGQ`: Minimum Genotype Quality score.

### 3. G' Analysis
Use `runGprimeAnalysis()` for the G' method.
- `windowSize`: The size of the sliding window in base pairs (e.g., 1e6).
- `outlierFilter`: Method to filter outliers (e.g., "deltaSNP").

### 4. QTL-seq Analysis
Use `runQTLseqAnalysis()` for the delta SNP index method.
- `popStruc`: Population structure (e.g., "F2" or "RIL").
- `bulkSize`: Vector of the number of individuals in each bulk (e.g., `c(25, 25)`).
- `replications`: Number of simulations for confidence intervals (e.g., 10000).

### 5. Visualization
Use `plotQTLStats()` to generate plots for G' or delta SNP values.
- `var`: The variable to plot ("Gprime" or "deltaSNP").
- `plotThreshold`: Boolean to show the FDR threshold (for G').
- `plotIntervals`: Boolean to show confidence intervals (for QTL-seq).

### 6. Results Extraction
Use `getQTLTable()` to summarize significant QTL regions.
- `alpha`: Significance level (e.g., 0.01).
- `export`: Boolean to save as a CSV file.

## Tips for Success
- Ensure the GATK table includes AD (Allele Depth) and GQ (Genotype Quality) fields.
- Use a `windowSize` that reflects the expected linkage disequilibrium in your population; 1Mb is a common starting point for many crops.
- When running `runQTLseqAnalysis`, ensure `bulkSize` accurately reflects the number of individuals pooled, not the sequencing depth.

## Reference documentation
- [NEWS.md](./references/NEWS.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)