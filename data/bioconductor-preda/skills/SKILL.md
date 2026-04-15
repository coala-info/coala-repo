---
name: bioconductor-preda
description: This tool identifies position-related trends and significant genomic regions in functional genomics data using non-linear regression and permutation tests. Use when user asks to identify clusters of differentially expressed genes, detect chromosomal aberrations, or perform integrative analysis of genomic data and their physical positions.
homepage: https://bioconductor.org/packages/release/bioc/html/PREDA.html
---

# bioconductor-preda

name: bioconductor-preda
description: Expert guidance for the PREDA (Position RElated Data Analysis) R package. Use this skill when performing integrative analysis of functional genomics data (gene expression, copy number, methylation) and their genomic positions to identify differentially expressed or imbalanced genomic regions.

# bioconductor-preda

## Overview

PREDA (Position RElated Data Analysis) is a Bioconductor package designed to identify position-related trends in functional genomics data. It uses non-linear regression (smoothing) and permutation tests to detect significant genomic regions, such as clusters of differentially expressed genes or chromosomal aberrations in cancer. It is particularly effective at handling variable gene density along chromosomes.

## Core Workflow

### 1. Data Preparation
PREDA uses specialized S4 classes to manage genomic data and annotations.

```r
library(PREDA)

# Create GenomicAnnotations
# ids: unique identifiers (e.g., probe IDs)
# chrom, start, end: genomic coordinates
# strand: 1 (plus), -1 (minus), or 0 (unknown)
genomic_annot <- new("GenomicAnnotations", 
                     ids=probe_ids, 
                     chromosome=chroms, 
                     start=starts, 
                     end=ends, 
                     strand=strands)

# Convert to GenomicAnnotationsForPREDA (requires a single reference position)
# reference_position_type can be "median", "start", "end", "strand.start", or "end.start"
genomic_annot_preda <- GenomicAnnotations2GenomicAnnotationsForPREDA(genomic_annot, 
                        reference_position_type="median")

# Create StatisticsForPREDA (the data matrix)
stats_preda <- new("StatisticsForPREDA", 
                   ids=probe_ids, 
                   statistic=data_matrix)

# Merge into DataForPREDA
data_for_preda <- MergeStatisticAnnotations2DataForPREDA(stats_preda, 
                    genomic_annot_preda)
```

### 2. Running the Analysis
The `PREDA_main` function performs the smoothing and permutation testing.

```r
# Basic analysis
results <- PREDA_main(data_for_preda)

# Advanced options
results <- PREDA_main(data_for_preda, 
                      nperms=10000, 
                      smoothMethod="lokern", 
                      parallelComputations=TRUE)
```

### 3. Extracting and Visualizing Results
Identify significant regions based on q-values and smoothed statistic thresholds.

```r
# Extract significant UP-regulated regions
regions_up <- PREDAResults2GenomicRegions(results, 
                qval.threshold=0.05, 
                smoothStatistic.tail="upper", 
                smoothStatistic.threshold=0.5)

# Convert to dataframe for inspection
df_up <- GenomicRegions2dataframe(regions_up[[1]])

# Plot results across the genome
genomePlot(results, 
           genomicRegions=regions_up, 
           region.colors="red")
```

## Specialized Workflows

### SODEGIR (Significant Overlap of Differentially Expressed and Genomic Imbalanced Regions)
This workflow integrates Gene Expression (GE) and Copy Number (CN) data.

1.  **Analyze GE**: Run `PREDA_main` on expression statistics.
2.  **Analyze CN**: Run `PREDA_main` on copy number data, using the GE annotations as the `outputGenomicAnnotationsForPREDA` to ensure alignment.
3.  **Find Overlap**:
    ```r
    sodegir_amplified <- GenomicRegionsFindOverlap(ge_regions_up, cn_regions_gain)
    ```
4.  **Dataset Signature**: Identify recurrent alterations across multiple samples.
    ```r
    signature <- computeDatasetSignature(ge_data_obj, 
                    genomicRegionsList=sodegir_amplified)
    ```

## Tips for Success
- **Custom CDFs**: For Affymetrix data, using gene-centered custom CDFs is highly recommended to reduce noise compared to standard probe-set definitions.
- **Filtering**: Always filter results using both `qval.threshold` and `smoothStatistic.threshold` to ensure biological relevance and reduce false positives.
- **Parallelization**: Set `parallelComputations=TRUE` for large datasets or high permutation counts, as the process is computationally intensive.
- **Reference Positions**: While "median" is the standard choice for reference positions, "strand.start" is often preferred for transcription-related analyses.

## Reference documentation
- [PREDA S4-classes](./references/PREDAclasses.md)
- [PREDA tutorial](./references/PREDAtutorial.md)