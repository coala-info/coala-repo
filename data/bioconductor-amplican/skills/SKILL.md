---
name: bioconductor-amplican
description: The amplican package automates the analysis of CRISPR experiments by processing raw FASTQ files into comprehensive alignment reports and editing visualizations. Use when user asks to analyze CRISPR sequencing data, align reads to amplicons, normalize editing rates against controls, or generate HTML reports for genome editing experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/amplican.html
---

# bioconductor-amplican

## Overview

The `amplican` package is a high-level Bioconductor tool designed for the precise analysis of CRISPR experiments. It automates the pipeline from raw FASTQ files to knitable HTML reports. Key features include robust alignment using the `pwalign` engine, consensus calling between paired-end reads, normalization of background noise using control samples, and visualization of editing events (deletions, insertions, and mismatches).

## Core Workflow

The most efficient way to use `amplican` is through the `amplicanPipeline` function, which handles filtering, alignment, and report generation in one call.

### 1. Prepare the Configuration File
A CSV configuration file is mandatory. It must contain the following columns:
- **ID**: Unique experiment identifier.
- **Barcode**: Groups experiments sharing the same FASTQ files.
- **Forward_Reads / Reverse_Reads**: Filenames (can be .gz).
- **Forward_Primer / Reverse_Primer**: Primer sequences (must match perfectly).
- **guideRNA**: The 5' to 3' guide sequence.
- **Direction**: 0 if guide is on forward strand, 1 if reverse complement.
- **Amplicon**: The full amplicon sequence. Use **UPPER CASE** to denote the expected cut site/PAM region.
- **Group**: User-defined grouping (e.g., "Control" vs "Treatment").
- **Control**: 1 for control samples, 0 for experiments.

### 2. Execute the Pipeline
```R
library(amplican)

config <- "path/to/config.csv"
fastq_folder <- "path/to/fastq_files"
results_folder <- "path/to/output"

# Run the full analysis
amplicanPipeline(config, fastq_folder, results_folder, knit_files = TRUE)
```

### 3. Manual Analysis Steps
If you need granular control, you can call the internal steps individually:
- `amplicanAlign`: Performs the alignment of reads to amplicons.
- `amplicanConsensus`: Reconciles forward and reverse reads for paired-end data.
- `amplicanNormalize`: Adjusts edit rates based on control samples to account for sequencing noise or pre-existing mutations.
- `amplicanReport`: Generates specific HTML reports (ID, Barcode, Group, Guide, or Amplicon levels).

## Key Functions and Tips

### Normalization and Thresholds
- **Default Threshold**: `amplican` uses a 1% (`min_freq = 0.01`) threshold for normalization.
- **High Precision**: For depth-heavy sequencing requiring <0.01% sensitivity, set `min_freq = 0.001`.
- **Index Hopping**: If index hopping is suspected, increase `min_freq` to ~0.03 or use `amplicanPipelineConservative`.
- **Low Depth**: For low sequencing depth or homogenous backgrounds, consider `min_freq = 0.1`.

### Handling Different Editing Tools
- **TALENs/Nickases**: Place the expected edit site (UPPER CASE) to span the region between the two binding sites.
- **HDR/Base Editors**: Use the **Donor** column in the config file to provide the template sequence. `amplican` will estimate HDR efficiency automatically.

### Interpreting Results
- **Reads_Edited**: Total reads with any edit. Note that `Reads_Edited` may be less than `Reads_Del + Reads_Ins` if a single read contains both.
- **Unique Reads**: A metric of heterogeneity. High unique reads suggest mosaic activity or sequencing errors; low unique reads suggest high specificity or no cutting.
- **PRIMER_DIMER**: Reads significantly shorter than the amplicon that match primer sequences are automatically filtered.

## Visualization
`amplican` provides specialized plotting functions for `AlignmentsExperimentSet` objects:
- `plot_mismatches()`: Stacked bar-plots of mismatches.
- `plot_deletions()`: Arch-plots showing deletion spans.
- `plot_insertions()`: Triangle plots where size indicates insertion length.
- `plot_variants()`: Detailed view of the most frequent alleles with frameshift info.

## Reference documentation
- [ampliCan FAQ](./references/amplicanFAQ.md)
- [ampliCan Overview](./references/amplicanOverview.md)
- [Report breakdown by amplicon sequence](./references/example_amplicon_report.md)
- [Report breakdown by barcode](./references/example_barcode_report.md)
- [Report breakdown by group](./references/example_group_report.md)
- [Report breakdown by guideRNA](./references/example_guide_report.md)
- [Report breakdown by ID](./references/example_id_report.md)
- [Summary Read Report](./references/example_index.md)