---
name: zerone
description: Zerone is a ChIP-seq analysis tool that discretizes continuous read counts into background and enriched genomic regions across multiple replicates. Use when user asks to discretize ChIP-seq read counts, identify enriched genomic regions, resolve conflicts between ChIP-seq replicates, get quality control scores for ChIP-seq analysis, or analyze ChIP-seq data with a custom window size.
homepage: https://github.com/nanakiksc/zerone
metadata:
  docker_image: "quay.io/biocontainers/zerone:1.0--h577a1d6_9"
---

# zerone

## Overview
Zerone is a specialized tool designed for ChIP-seq analysis that transforms continuous read counts into discrete states—specifically background signal (0) and enriched windows (1). Unlike many peak callers that process samples individually, Zerone discretizes multiple replicates simultaneously. This approach allows the tool to resolve conflicts between replicates and provide a quantitative Quality Control (QC) score to help researchers decide whether to accept or reject the resulting discretization.

## Installation
The most efficient way to install Zerone is via Bioconda:
```bash
conda install bioconda::zerone
```
Alternatively, it can be compiled from source using `make` within the repository directory.

## Command Line Usage

### Basic Syntax
Zerone requires at least one mock control and one experimental replicate.
```bash
zerone -0 <mock_files> -1 <chip_files> [options]
```

### Common CLI Patterns
*   **Multiple Replicates (Comma Separated):**
    ```bash
    zerone --mock control.bam --chip rep1.bam,rep2.bam
    ```
*   **Multiple Replicates (Flag Based):** Use this method if your file paths require shell expansion (like `~`).
    ```bash
    zerone -0 control.bam -1 rep1.bam -1 rep2.bam
    ```
*   **Target List Output:** Use the `-l` flag to output only the merged enriched regions (targets) rather than every genomic window.
    ```bash
    zerone -l -0 control.bam -1 rep1.bam -1 rep2.bam
    ```
*   **Custom Window Size:** The default window size is 300bp. Adjust this based on the expected width of your epigenetic marks.
    ```bash
    zerone -w 500 -0 control.bam -1 chip.bam
    ```

## Expert Tips and Best Practices

### Interpreting Quality Control
Every Zerone run outputs a QC header. Focus on the `advice` and `QC score`:
*   **Accept:** The discretization is statistically sound (Score > 0).
*   **Reject:** The signal-to-noise ratio or replicate consistency is too low (Score < 0).
*   **Reliability:** Scores greater than 1 or less than -1 are considered extremely reliable.
*   **Note:** If you provide only one replicate, the QC score will return `-nan` as it cannot perform consistency checks.

### Input Format Considerations
*   **Preferred Formats:** SAM, BAM, and GEM (.map) are handled natively and are generally more reliable for read counting.
*   **BED and WIG Caution:** If using BED or WIG files, ensure the scores represent raw read counts per window. The window size in the file must match the `-w` parameter used in Zerone (default 300).
*   **Compression:** Zerone can process gzipped files directly.

### Output Columns (Window Mode)
When running in default mode, the output columns are:
1.  Chromosome
2.  Start Position
3.  End Position
4.  Enrichment State (0 = background, 1 = enriched)
5.  Summed Control Counts
6.  Replicate Counts (one column per input file)
7.  Confidence Score (probability that the window is a target)

## Reference documentation
- [Zerone Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_zerone_overview.md)
- [Zerone GitHub README and Tutorial](./references/github_com_nanakiksc_zerone.md)