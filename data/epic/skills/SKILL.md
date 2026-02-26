---
name: epic
description: epic is a high-performance implementation of the SICER algorithm used to identify diffuse domains in ChIP-Seq data. Use when user asks to call peaks for broad epigenetic marks, identify diffuse enriched regions, or perform parallelized SICER analysis on BED or BEDPE files.
homepage: http://github.com/endrebak/epic
---


# epic

## Overview
`epic` is a high-performance, parallelized implementation of the SICER algorithm. It is designed to identify diffuse domains in ChIP-Seq data by analyzing enrichment across genomic windows. Compared to the original SICER, `epic` is faster, more memory-efficient, and supports multi-core processing by processing chromosomes in parallel. It accepts BED or BEDPE files (including gzipped versions) and provides statistically significant enriched regions based on a false discovery rate (FDR) cutoff.

## Usage Patterns and Best Practices

### Basic Peak Calling
The most common use case involves comparing treatment (pull-down) files against control (input) files.
```bash
epic -t treatment.bed -c control.bed > results.csv
```

### Parallel Processing
`epic` can utilize one CPU core per chromosome. For human or mouse genomes, setting this to 20-24 can significantly decrease runtime.
```bash
epic -t treatment.bed -c control.bed --number-cores 20
```

### Handling Paired-End Data
If working with BAM files, convert them to BEDPE first using `bedtools`. `epic` natively accepts BEDPE format for paired-end reads.
```bash
# Conversion step
bamToBed -bedpe -i paired_end.bam > paired_end.bedpe

# Running epic
epic -t paired_end.bedpe -c control.bedpe
```

### Custom Genomes
If your species is not among the defaults (like hg19), you must provide a chromsizes file (two columns: chromosome name and size).
```bash
epic -t treatment.bed -c control.bed --chromsizes species.chrom.sizes --genome custom_name
```

### Tuning Sensitivity
*   **Window Size (`-w`)**: Default is 200bp. Increase for very broad marks; decrease for slightly more localized diffuse marks.
*   **Gaps Allowed (`-g`)**: This is a multiple of the window size. The default is 3 (600bp gap allowed). Increase this to merge smaller islands into larger domains.
*   **FDR Cutoff (`-fdr`)**: Default is 0.05. Tighten to 0.01 for higher confidence in noisy data.

### Expert Tips
*   **Duplicate Reads**: By default, `epic` removes all but one read at the same position/strand. Use `--keep-duplicates` only if you have performed independent PCR bottlenecking analysis and believe the duplicates are biological.
*   **Fragment Size**: For single-end reads, the default is 150bp. If your library preparation used a specific size selection (e.g., 300bp), update this with `-fs 300` to improve peak resolution.
*   **BigWig Output**: Use `--bigwig` or `--sum-bigwig` to generate tracks for visualization in IGV or UCSC Genome Browser alongside the peak calls.

## Reference documentation
- [epic: diffuse domain ChIP-Seq caller based on SICER](./references/github_com_biocore-ntnu_epic.md)
- [bioconda epic overview](./references/anaconda_org_channels_bioconda_packages_epic_overview.md)