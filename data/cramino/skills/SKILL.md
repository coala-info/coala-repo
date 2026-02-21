---
name: cramino
description: cramino is a high-performance tool written in Rust, specifically engineered for the fast quality assessment of long-read sequencing data.
homepage: https://github.com/wdecoster/cramino
---

# cramino

## Overview
cramino is a high-performance tool written in Rust, specifically engineered for the fast quality assessment of long-read sequencing data. It excels at processing massive BAM or CRAM files with minimal memory overhead (typically <1GB), providing critical metrics such as N50, yield in Gigabases, and gap-compressed identity scores. It is the preferred choice for real-time or post-sequencing QC where speed is a priority.

## Usage Instructions

### Basic Quality Assessment
To get a standard summary report (Read count, N50, Median length, and Identity):
```bash
cramino input.bam
```

### Working with CRAM Files
CRAM files require the original reference genome for decompression:
```bash
cramino --reference genome.fasta input.cram
```

### Analyzing Unaligned Reads
By default, cramino focuses on aligned reads. To include metrics for all reads in the file (e.g., for raw data assessment):
```bash
cramino --ubam input.bam
```

### Generating Histograms
Cramino can generate ASCII histograms for read length and Phred-scaled accuracies directly in the terminal:
```bash
# Standard histograms
cramino --hist input.bam

# Basepair-weighted histograms (bins scaled by total bp, not just count)
cramino --scaled --hist input.bam

# Output histogram data to a TSV for external plotting
cramino --hist-count output_counts.tsv input.bam
```

### Specialized Analysis Modes
*   **Phased Data**: Calculate metrics specifically for phase blocks.
    ```bash
    cramino --phased input.bam
    ```
*   **Spliced Data**: Provide metrics relevant to transcriptomic/spliced alignments.
    ```bash
    cramino --spliced input.bam
    ```
*   **Karyotyping**: Generate normalized read counts per chromosome to identify sex or aneuploidies.
    ```bash
    cramino --karyotype input.bam
    ```

### Integration and Automation
For downstream processing or multi-sample reporting, use machine-readable formats:
```bash
# JSON output for automated pipelines
cramino --format json input.bam > report.json

# Arrow format for use with NanoPlot or NanoComp
cramino --arrow data.arrow input.bam
```

## Expert Tips
*   **Thread Optimization**: Use `-t` to set decompression threads. The default is 4, but increasing this on high-core systems significantly speeds up CRAM processing.
*   **Length Filtering**: Use `-m` or `--min-read-len` to ignore short fragments or adapter noise that might skew N50 and mean length calculations.
*   **Identity Definition**: Note that cramino uses "gap-compressed identity," which is often more representative of long-read sequencing accuracy than standard BLAST identity.

## Reference documentation
- [cramino Overview](./references/anaconda_org_channels_bioconda_packages_cramino_overview.md)
- [cramino GitHub Repository](./references/github_com_wdecoster_cramino.md)