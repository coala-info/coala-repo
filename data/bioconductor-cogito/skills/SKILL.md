---
name: bioconductor-cogito
description: This tool automates the comparison and reporting of multi-omics genomic datasets by aggregating diverse genomic intervals to a common reference. Use when user asks to aggregate multi-omics data to a common reference, generate automated summary reports for genomic experiments, or perform correlation analyses across different technologies and conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/Cogito.html
---


# bioconductor-cogito

name: bioconductor-cogito
description: Automated comparison and reporting for multi-omics genomic datasets (RNA-seq, ChIP-seq, RRBS). Use when needing to aggregate diverse genomic intervals (GRanges) to a common reference (genes) and generate comprehensive summary reports and correlation analyses across experimental conditions and technologies.

## Overview

Cogito is designed to provide a high-level overview and automated reporting for biological studies involving multiple conditions and technologies. It aggregates data from various sources—such as gene expression (RNA-seq), methylation status (RRBS), and peak scores (ChIP-seq)—onto a shared genomic reference (typically genes). The package then generates a structured report (PDF or HTML) that summarizes individual samples, replicates, technologies, and cross-sample correlations.

## Typical Workflow

### 1. Data Preparation
Input data should be organized into `GRanges` or `GRangesList` objects. Each column in the metadata (`mcols`) typically represents an experimental condition.

```r
library(Cogito)
library(TxDb.Mmusculus.UCSC.mm9.knownGene)

# Define the reference genome/annotation
mm9 <- TxDb.Mmusculus.UCSC.mm9.knownGene

# Organize input data into a named list by technology
example.dataset <- list(
  ChIP = MurEpi.ChIP.small, # GRangesList
  RNA = MurEpi.RNA.small,   # GRanges
  RRBS = MurEpi.RRBS.small  # GRanges
)
```

### 2. Aggregating Ranges
The `aggregateRanges` function maps all input intervals to the closest gene (default max distance 100,000bp).

```r
aggregated.ranges <- aggregateRanges(
  ranges = example.dataset,
  organism = mm9,
  name = "my_experiment"
)
```

**Key Output Components:**
- `aggregated.ranges$genes`: A single `GRanges` object where rows are genes and columns are the aggregated values from all input samples.
- `aggregated.ranges$config`: Contains inferred groupings for `technologies` and `conditions`. **Note:** You should inspect these lists and manually correct them if the automatic naming detection failed to group replicates correctly.

### 3. Summarizing and Reporting
The `summarizeRanges` function performs the statistical analysis and generates the output files.

```r
summarizeRanges(
  aggregated.ranges = aggregated.ranges,
  outputFormat = "pdf" # or "html"
)
```

**Generated Files:**
- **Report (PDF/HTML):** Contains four chapters:
  1. Individual sample summaries (location/dispersion).
  2. Grouped summaries (condition + technology replicates).
  3. Technology-specific summaries.
  4. Pairwise comparisons and correlation tests (focusing on p-value < 0.01).
- **.Rmd file:** The source code for the report, allowing for custom modifications.
- **.RData file:** Processed data for further manual analysis.

## Tips for Success

- **Configuration Check:** Always verify `aggregated.ranges$config$conditions` before running `summarizeRanges`. If replicates aren't grouped, the report will treat them as independent conditions.
- **Memory Management:** For very large datasets, subsetting to specific chromosomes or using a more restrictive `configfile` for aggregation can save processing time.
- **Reference Ranges:** While the default is gene-centric, you can provide custom `referenceRanges` to `aggregateRanges` if you wish to aggregate data onto enhancers or other genomic features.

## Reference documentation

- [Cogito: Compare annotated genomic intervals tool](./references/Cogito.md)