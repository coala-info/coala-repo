---
name: bioconductor-dasper
description: "bioconductor-dasper detects aberrant splicing events from RNA-sequencing data by integrating junction counts and coverage information. Use when user asks to process RNA-seq junction data, annotate junctions with reference genomes, normalize counts, integrate coverage data from BigWig files, or perform outlier detection to identify pathogenic splicing."
homepage: https://bioconductor.org/packages/3.12/bioc/html/dasper.html
---


# bioconductor-dasper

name: bioconductor-dasper
description: Detecting aberrant splicing events from RNA-sequencing data. Use this skill to process RNA-seq junction data, annotate junctions with reference genomes, normalize counts, integrate coverage data from BigWig files, and perform outlier detection to identify pathogenic splicing.

## Overview

The `dasper` package is designed to identify aberrant splicing events by comparing a patient's RNA-seq data against a set of control samples. It integrates two main sources of information: junction counts (the number of reads spanning an exon-exon junction) and coverage (the depth of reads in regions flanking the junction). The workflow typically involves processing junctions, processing coverage, and then using an isolation forest algorithm to detect outliers.

## Core Workflow

### 1. Setup and Data Loading

`dasper` requires junction data (typically STAR `SJ.out` files) and coverage data (BigWig files). It also requires a reference annotation (TxDb object or GTF).

```R
library(dasper)
library(magrittr)

# Load reference annotation (e.g., GENCODE v31 for hg38)
ref <- GenomicState::GenomicStateHub(version = "31", genome = "hg38", filetype = "TxDb")[[1]]

# Load junctions
# You can include public controls (e.g., "fibroblasts", "whole_blood") from recount2
junctions <- junction_load(
    junction_paths = c("path/to/sample1.txt", "path/to/sample2.txt"),
    controls = "fibroblasts",
    chrs = c("chr21", "chr22") # Optional: limit to specific chromosomes
)
```

### 2. Junction Processing

This stage annotates, filters, and normalizes the junction data.

```R
junctions <- junctions %>%
    junction_annot(ref) %>%
    junction_filter(count_thresh = c(raw = 5), n_samp = c(raw = 1)) %>%
    junction_norm() %>%
    junction_score()
```

- `junction_annot`: Classifies junctions (e.g., annotated, novel_acceptor, novel_donor).
- `junction_norm`: Calculates Proportion Spliced In (PSI) by clustering junctions sharing a splice site.
- `junction_score`: Calculates a z-score comparing the sample's PSI to the control distribution.

### 3. Coverage Processing

This step requires the `megadepth` system tool to be installed via `megadepth::install_megadepth()`.

```R
# coverage_paths should correspond to the samples in the junctions object
coverage <- coverage_norm(
    junctions,
    ref,
    coverage_paths_case = c("sample1.bw", "sample2.bw"),
    coverage_paths_control = c("ctrl1.bw", "ctrl2.bw", "ctrl3.bw")
)

junctions <- coverage_score(junctions, coverage)
```

### 4. Outlier Detection and Aggregation

The final step uses an isolation forest to score junctions based on both count and coverage scores.

```R
junctions <- outlier_detect(junctions, random_state = 32L)

# Aggregate junction-level scores to the cluster/gene level
outlier_scores <- outlier_aggregate(junctions, samp_id_col = "samp_id")
```

## Visualization

Use `plot_sashimi` to inspect the top-ranked aberrant splicing events.

```R
# Visualize the top-ranked gene for a specific sample
gene_id <- unlist(outlier_scores[["gene_id_cluster"]][1])

plot_sashimi(
    junctions,
    ref,
    case_id = list(samp_id = "sample1"),
    gene_tx_id = gene_id,
    count_label = TRUE
)
```

## Tips for Success

- **Control Matching**: Always try to match the control tissue (via the `controls` argument in `junction_load`) to your patient's sample tissue.
- **Parallelization**: For large datasets, use `BiocParallel::MulticoreParam()` in the `bp_param` argument of `coverage_process` and `outlier_process`.
- **Megadepth**: Ensure `megadepth` is installed, as it is significantly faster than other BigWig readers for the specific regions `dasper` queries.

## Reference documentation

- [Introduction to dasper](./references/dasper.Rmd)
- [Introduction to dasper](./references/dasper.md)