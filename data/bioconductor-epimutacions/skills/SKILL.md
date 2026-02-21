---
name: bioconductor-epimutacions
description: The package includes some statistical outlier detection methods for epimutations detection in DNA methylation data. The methods included in the package are MANOVA, Multivariate linear models, isolation forest, robust mahalanobis distance, quantile and beta. The methods compare a case sample with a suspected disease against a reference panel (composed of healthy individuals) to identify epimutations in the given case sample. It also contains functions to annotate and visualize the identified epimutations.
homepage: https://bioconductor.org/packages/release/bioc/html/epimutacions.html
---

# bioconductor-epimutacions

## Overview

The `epimutacions` package provides a suite of statistical methods to detect "epimutations"—rare alterations in DNA methylation patterns at specific loci that may be associated with genetic diseases. It compares a case sample (proband) against a reference panel of healthy individuals to identify outliers.

The package supports six detection methods:
1. **manova**: Multivariate Analysis of Variance (default).
2. **mlm**: Multivariate Linear Model.
3. **iForest**: Isolation Forest.
4. **mahdist**: Robust Mahalanobis Distance.
5. **quantile**: Sliding window quantile comparison.
6. **beta**: Beta distribution-based outlier detection.

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("epimutacions")
# Optional: Example data
BiocManager::install("epimutacionsData")
```

## Typical Workflow

### 1. Data Preprocessing
Convert raw IDAT files into a `GenomicRatioSet`. This step handles normalization using `minfi` methods (e.g., `illumina`, `swan`, `quantile`, `noob`, `funnorm`).

```r
library(epimutacions)

# Set normalization parameters if needed
params <- norm_parameters(illumina = list("bg.correct" = TRUE))

# Preprocess IDATs
# baseDir: path to IDAT files
# reference_panel: an RGChannelSet object
grset <- epi_preprocess(baseDir, reference_panel, pattern = "SampleSheet.csv")
```

### 2. Epimutation Detection
The main function is `epimutations()`. It requires case samples and control samples separated.

```r
# Split data
case_samples <- methy[, methy$status == "case"]
control_samples <- methy[, methy$status == "control"]

# Run detection (e.g., using MANOVA)
results <- epimutations(case_samples, 
                        control_samples, 
                        method = "manova")
```

For cohorts without a separate reference panel, use the leave-one-out approach:
```r
results_loo <- epimutations_one_leave_out(grset, method = "manova")
```

### 3. Customizing Parameters
Use `epi_parameters()` to adjust method-specific thresholds like p-values or outlier scores.

```r
# View defaults
epi_parameters()

# Set custom p-value for MANOVA
custom_params <- epi_parameters(manova = list("pvalue_cutoff" = 0.01))
results <- epimutations(case_samples, control_samples, 
                        method = "manova", 
                        epi_params = custom_params)
```

### 4. Annotation
Enrich identified epimutations with gene names (GENCODE), regulatory features, CpG island context, and OMIM accessions.

```r
annotated_results <- annotate_epimutations(results, omim = TRUE)
```

### 5. Visualization
Visualize the methylation profile of a specific epimutation compared to the reference population.

```r
# Plot the first identified epimutation
# methy: the GenomicRatioSet containing all samples
plot_epimutations(as.data.frame(results[1,]), methy)

# Include gene annotations and chromatin marks
plot_epimutations(as.data.frame(results[1,]), 
                  methy = methy, 
                  genes_annot = TRUE, 
                  regulation = TRUE)
```

## Interpreting Results

The output is a tibble where each row is a candidate epimutation:
* **outlier_score**: Method-specific metric (e.g., Pillai score for MANOVA, R2 for MLM).
* **outlier_direction**: "hypomethylation" or "hypermethylation".
* **pvalue / adj_pvalue**: Statistical significance (available for `manova` and `mlm`).
* **CRE / CRE_type**: Overlapping cis-Regulatory Elements from ENCODE.

## Reference documentation
- [The epimutacions User's Guide](./references/epimutacions.Rmd)
- [The epimutacions User's Guide (Markdown)](./references/epimutacions.md)