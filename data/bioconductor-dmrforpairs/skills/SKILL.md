---
name: bioconductor-dmrforpairs
description: DMRforPairs identifies differentially methylated regions by comparing unique samples based on probe proximity and functional annotation. Use when user asks to identify differentially methylated regions in n=1 vs n=1 comparisons, tune parameters for region identification, or visualize methylation patterns for specific genes and genomic coordinates.
homepage: https://bioconductor.org/packages/3.8/bioc/html/DMRforPairs.html
---

# bioconductor-dmrforpairs

## Overview

DMRforPairs is an R package designed to identify Differentially Methylated Regions (DMRs) by comparing unique samples (n=1 vs n=1) rather than large groups. It identifies regions based on probe proximity and functional annotation, then evaluates differential methylation using median differences in M-values and beta values, followed by formal statistical testing.

## Core Workflow

### 1. Data Preparation
The package requires methylation data (M-values and Beta-values) along with genomic coordinates and functional annotations (gene and island relationship).

```r
library(DMRforPairs)
data(DMRforPairs_data) # Example dataset CL.methy

# Required columns: targetID, chromosome, position, 
# class.gene.related, class.island.related, M-values, Beta-values
```

### 2. Parameter Tuning
Before running the full analysis, use `tune_parameters` to estimate the number of regions identified under different settings for `min_distance` (max gap between probes) and `min_n` (min probes per region).

```r
parameters <- expand.grid(min_distance = c(200, 300), min_n = c(4, 5))
results <- tune_parameters(parameters, 
                           classes_gene = CL.methy$class.gene.related,
                           classes_island = CL.methy$class.island.related,
                           targetID = CL.methy$targetID,
                           chr = CL.methy$chromosome,
                           position = CL.methy$position,
                           m.v = CL.methy[,7:8],
                           beta.v = CL.methy[,11:12])
```

### 3. Identifying DMRs
The main wrapper function `DMRforPairs` executes the full pipeline: recoding classes, finding regions, and testing for significance.

```r
output <- DMRforPairs(
    classes_gene = CL.methy$class.gene.related,
    classes_island = CL.methy$class.island.related,
    targetID = CL.methy$targetID,
    chr = CL.methy$chromosome,
    position = CL.methy$position,
    m.v = CL.methy[, 8:10],    # M-values for samples
    beta.v = CL.methy[, 12:14], # Beta-values for samples
    min_n = 4, 
    min_distance = 200, 
    min_dM = 1.4,              # Threshold for median M-value difference
    method = "fdr"             # Multiple testing correction
)
```

### 4. Export and Visualization
`export_data` generates a comprehensive HTML report with tables, statistics, and thumbnails.

```r
export_data(tested = output$tested, 
            regions = output$regions, 
            th = 0.05, 
            min_dM = 1.4, 
            experiment.name = "my_dmr_study")
```

## Specialized Visualization Functions

For deep dives into specific genomic areas or genes:

*   **Specific Region:** `plot_annotate_region(output$tested, output$regions, regionID = 16)`
*   **Specific Gene:** `plot_annotate_gene(gs = "BMPER", regions = output$regions)`
*   **Custom Coordinates:** `plot_annotate_custom_region(chr = 7, st = 33943000, ed = 33945000, output$regions)`

## Key Parameters and Tips

*   **min_dM:** The threshold for a "relevant" difference in median M-values. A common starting point is 1.4.
*   **recode:** Controls how probe classes are merged. `recode=1` uses a built-in scheme to simplify Illumina annotations into 'gene', 'tss', and 'island'.
*   **Annotation:** Set `annotate = TRUE` in plotting functions to pull Ensembl information via Gviz/biomaRt (requires internet connection).
*   **Parallelization:** Use `do.parallel = 0` to disable or specify the number of cores for large datasets.

## Reference documentation

- [DMRforPairs vignette](./references/DMRforPairs_vignette.md)