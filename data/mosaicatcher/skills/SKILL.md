---
name: mosaicatcher
description: Mosaicatcher analyzes Strand-seq genomic data to generate binned count tables and determine chromosome strand inheritance patterns. Use when user asks to count reads from Strand-seq BAM files, classify strand states, or simulate synthetic Strand-seq data for benchmarking.
homepage: https://github.com/friendsofstrandseq/mosaicatcher/
---

# mosaicatcher

## Overview
Mosaicatcher is a specialized bioinformatic tool designed for the analysis of Strand-seq genomic data. It functions as a critical upstream component in structural variant (SV) calling pipelines. The tool processes raw sequencing reads from single cells to generate binned count tables and determine the strand inheritance patterns (strand states) of chromosomes. It also includes robust simulation capabilities to generate synthetic Strand-seq data for benchmarking SV detection algorithms.

## Command Line Usage

### Read Counting and Strand State Classification
The `count` command is the primary entry point for processing BAM files. It bins reads and applies an HMM to classify strand states.

```bash
# Count reads using fixed-width bins (e.g., 200kb)
./mosaic count \
    -o counts.txt.gz \
    -i counts.info \
    -x data/exclude/GRCh38.exclude \
    -w 200000 \
    cell1.bam cell2.bam cell3.bam
```

**Key Arguments:**
- `-o`: Output compressed count table.
- `-i`: Output information file containing metadata.
- `-x`: Path to a file defining genomic regions to exclude (e.g., HLA, decoys).
- `-w`: Bin width in base pairs (mutually exclusive with `-b`).
- `-b`: Path to a file defining predefined variable-sized bins.

### Data Simulation
Generate synthetic Strand-seq data based on a structural variant configuration file.

```bash
# Simulate counts based on an SV config
./mosaic simulate -o simulated_counts.txt.gz sv_config.txt
```

### Quality Control and Visualization
Mosaicatcher includes R scripts to visualize the output of the counting and simulation steps.

```bash
# Generate QC plots
Rscript R/qc.R counts.txt.gz counts.info counts.pdf

# Plot counts for a specific chromosome including segments
Rscript R/chrom.R counts.txt.gz counts.pdf
```

## Expert Tips and Best Practices

### Input BAM Requirements
- **Single Cell per File**: Each BAM file must represent exactly one single cell.
- **Read Groups**: Every BAM must contain a single `@RG` header.
- **Sample Grouping**: Use the `SM` tag within the read group to group cells into samples.
- **Indexing**: All input BAM files must be coordinate-sorted and indexed (`.bai`).

### Normalization and Filtering
- **Normalization**: Use `R/norm.R` to scale count tables or apply blacklists to problematic bins.
- **None Bins**: In version 0.3+, the segmentation process penalizes or removes "None" bins (regions with no data) to improve SV calling accuracy.
- **Segment Constraints**: Avoid segments that are too small by using the penalty features in the cost matrix during the `segment` command.

### Simulation Reproducibility
- Use the random generator seed option in `simulate` to ensure reproducible synthetic datasets.
- Simulations can output phased reads for more complex benchmarking scenarios.



## Subcommands

| Command | Description |
|---------|-------------|
| count | Count reads from Strand-seq BAM files. |
| makebins | Specify whole genome sequencing data (or a set of Strand-seq cells merged into a single file) which were sequenced under equal conditions. This tool will create bins of variable width but which contian the same number of reads. This way we hope to overcome mappability issues. |
| segment | Find a segmentation across multiple cells. |
| simulate | Simulate binned Strand-seq data. |
| states | Call Sister chromatid exchange events (SCEs). |

## Reference documentation
- [Mosaicatcher README](./references/github_com_friendsofstrandseq_mosaicatcher_blob_master_README.md)
- [Mosaicatcher Changelog](./references/github_com_friendsofstrandseq_mosaicatcher_blob_master_CHANGELOG.md)