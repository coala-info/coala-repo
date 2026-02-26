---
name: fgsv
description: The fgsv toolkit provides high-resolution evidence gathering for structural variant exploration and breakpoint detection by analyzing alignment chains within read templates. Use when user asks to identify genomic junctions, aggregate clustered breakpoint signals, or prepare structural variant evidence for visualization in BEDPE format.
homepage: https://github.com/fulcrumgenomics/fgsv
---


# fgsv

## Overview

The `fgsv` toolkit is a specialized suite for structural variant exploration and breakpoint detection. Rather than acting as a standalone SV caller, it provides high-resolution evidence gathering by analyzing "chains" of aligned sub-segments within read templates. Use this skill to identify junctions between genomic loci (breakpoints), aggregate noisy or clustered signals caused by alignment artifacts, and prepare evidence for manual curation in tools like IGV.

## Core Workflow and CLI Patterns

### 1. Evidence Collection with SvPileup
The primary tool for scanning alignments. It identifies jumps between reference sequences or distant loci within the same sequence.

*   **Requirement**: Input BAM files must be queryname-grouped.
*   **Logic**: It constructs alignment chains for each template, favoring split-read evidence (precise) over inter-read/discordant-pair evidence (approximate).
*   **Command**:
    ```bash
    fgsv SvPileup \
      --input sample.bam \
      --output sample.svpileup.txt
    ```
*   **Key Parameters**:
    *   `--min-intra-read-jump`: Minimum distance for a jump within a single read (default: 100bp).
    *   `--min-inter-read-jump`: Minimum distance for a jump between paired reads (default: 1000bp).

### 2. Signal Refinement with AggregateSvPileup
Short-read alignments often produce slightly different coordinates for the same biological event due to homology or sequencing errors. This tool clusters these signals.

*   **Logic**: Merges breakpoints if left and right breakends map to the same strands/sequences and fall within a specific distance threshold.
*   **Command**:
    ```bash
    fgsv AggregateSvPileup \
      --bam sample.bam \
      --input sample.svpileup.txt \
      --output sample.svpileup.aggregate.txt
    ```
*   **Key Parameter**:
    *   `--max-distance`: The genomic distance within which breakends are merged (default: 10bp).

### 3. Visualization Preparation
To review candidates in IGV or other browsers, convert the aggregated output to BEDPE.

*   **Command**:
    ```bash
    fgsv AggregateSvPileupToBedPE \
      --input sample.svpileup.aggregate.txt \
      --output sample.svpileup.aggregate.bedpe
    ```

## Expert Tips and Best Practices

*   **Coordinate System**: All point intervals reported are 1-based inclusive relative to the reference sequence.
*   **BAM Tagging**: Both `SvPileup` and `AggregateSvPileup` can produce a modified BAM file where alignments are tagged with a unique ID (e.g., a breakpoint ID). This is invaluable for filtering a BAM in a genome browser to see only the reads supporting a specific putative SV.
*   **Duplicate Reads**: By default, `SvPileup` ignores duplicate records. Ensure your BAM is properly marked if you want to exclude PCR artifacts from your evidence counts.
*   **Precision vs. Sensitivity**: If you are working with highly repetitive regions, consider increasing the `--max-distance` in `AggregateSvPileup` to account for greater alignment "slop."
*   **Terminology**: 
    *   **Breakpoint**: The junction between two loci.
    *   **Breakend**: One of the two loci involved in a breakpoint.

## Reference documentation
- [fgsv GitHub Repository](./references/github_com_fulcrumgenomics_fgsv.md)
- [fgsv Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fgsv_overview.md)