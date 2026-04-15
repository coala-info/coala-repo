---
name: megadepth
description: Megadepth is a high-speed utility for quantifying genomic coverage and processing BigWig, BAM, or CRAM files. Use when user asks to calculate coverage, generate BigWig files, summarize intervals, or count junctions from genomic data.
homepage: https://github.com/ChristopherWilks/megadepth
metadata:
  docker_image: "quay.io/biocontainers/megadepth:1.2.0--h5ca1c30_7"
---

# megadepth

## Overview
Megadepth is a high-speed utility designed for large-scale genomic data processing. It excels at quantifying coverage across whole genomes or specific regions of interest. It is particularly useful for RNA-seq and DNA-seq workflows where processing speed and memory efficiency are critical, allowing users to generate BigWig files, junction counts, or summary statistics in a single pass.

## Common CLI Patterns

### BigWig Processing
To summarize coverage over specific intervals (e.g., exons) from an existing BigWig file:
```bash
megadepth input.bw --annotation regions.bed --op mean --auc
```
*   `--op`: Choose from `sum` (default), `mean`, `min`, or `max`.
*   `--auc`: Calculates the total Area Under the Curve for the annotated regions.

### BAM/CRAM Processing
To generate a BigWig and calculate AUC from a sorted BAM file using multiple threads:
```bash
megadepth input.sorted.bam --threads 4 --bigwig --auc --prefix output_name
```

### Interval Summaries from BAM
To get coverage summaries over intervals and output to a compressed, indexed file:
```bash
megadepth input.sorted.bam --annotation exons.bed --prefix sample_out --gzip
```
*   Using `--gzip` automatically suppresses standard output and creates a block-gzipped file with a `.csi` index.

### Filtering Alignments
Use SAM bitmasks to include or exclude specific reads during processing:
```bash
# Example: Filter out unmapped (4) and secondary (256) alignments (default is 260)
megadepth input.bam --filter-out 260 --prefix filtered_output
```

## Expert Tips and Best Practices

### Input Requirements
*   **Sorting**: BAM/CRAM files **must** be sorted by chromosome. Megadepth processes data one chromosome at a time; unsorted files will cause massive performance degradation or memory errors.
*   **Indexing**: While a BAM index (`.bai`) is not strictly required for a full pass, it is highly recommended for performance when using `--annotation` to query sparse regions.
*   **CRAM References**: If processing CRAM files, ensure the reference FASTA is accessible. Use `--fasta /path/to/ref.fa` if the reference is not available via default remote URIs.

### Performance Optimization
*   **Single Pass**: Megadepth is designed to perform all requested operations (BigWig generation, AUC calculation, junction counting) in a single pass through the input file. Combine flags to save I/O time.
*   **Remote Files**: When processing remote BAM or BigWig files, you **must** use the `--prefix` option to specify a local output destination.

### Output Management
*   **Standard Out**: By default, `--coverage` and `--auc` write to STDOUT. To prevent terminal flooding, use `--no-auc-stdout`, `--no-annotation-stdout`, or `--no-coverage-stdout` to force output into files defined by your `--prefix`.
*   **BigWig Output**: If `--coverage` is specified, a BigWig file is always produced regardless of other output settings.

## Reference documentation
- [Megadepth GitHub Repository](./references/github_com_ChristopherWilks_megadepth.md)
- [Bioconda Megadepth Overview](./references/anaconda_org_channels_bioconda_packages_megadepth_overview.md)