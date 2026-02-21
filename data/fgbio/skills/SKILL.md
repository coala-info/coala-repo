---
name: fgbio
description: fgbio is a suite of high-performance tools designed to handle the complexities of modern sequencing workflows.
homepage: https://github.com/fulcrumgenomics/fgbio
---

# fgbio

## Overview

fgbio is a suite of high-performance tools designed to handle the complexities of modern sequencing workflows. It is particularly essential for high-sensitivity applications where UMIs are used to reduce sequencing noise and identify low-frequency variants. The toolkit provides a robust framework for transforming raw reads into high-fidelity consensus sequences, alongside utilities for BAM manipulation, quality control, and reference genome standardization.

## Core Workflows and CLI Patterns

### UMI Consensus Calling Pipeline
The most common use case for fgbio is collapsing multiple reads from the same original DNA molecule into a single consensus read.

1.  **Convert FASTQ to BAM and Extract UMIs**:
    Use `FastqToBam` to convert raw reads while extracting UMIs into BAM tags (usually the `RX` tag).
    ```bash
    fgbio FastqToBam \
        --input r1.fq.gz r2.fq.gz \
        --read-structures 5M145T 5M145T \
        --sample sample01 \
        --output unmapped.bam
    ```
    *Note: `5M145T` means 5bp of Molecular ID followed by 145bp of Template.*

2.  **Group Reads by UMI**:
    After alignment (e.g., via BWA) and sorting, group reads that share the same UMI and mapping position.
    ```bash
    fgbio GroupReadsByUmi \
        --input aligned.sorted.bam \
        --strategy adjacency \
        --edits 1 \
        --output grouped.bam
    ```

3.  **Call Consensus Reads**:
    Generate the consensus sequences from the grouped reads.
    ```bash
    fgbio CallMolecularConsensusReads \
        --input grouped.bam \
        --output consensus.unmapped.bam \
        --min-reads 1
    ```

4.  **Filter Consensus Reads**:
    Filter the resulting consensus BAM based on quality and supporting evidence.
    ```bash
    fgbio FilterConsensusReads \
        --input consensus.aligned.bam \
        --ref human_g1k_v37.fasta \
        --min-reads 3 \
        --max-read-error-rate 0.05 \
        --output filtered.consensus.bam
    ```

### Duplex Sequencing
For ultra-high sensitivity, fgbio supports duplex sequencing where both strands of a double-stranded DNA molecule are sequenced.
*   Use `CallDuplexConsensusReads` to identify and collapse reads from both the 'top' and 'bottom' strands.
*   This significantly reduces technical artifacts as true variants must appear on both strands.

### BAM Manipulation and QC
*   **ClipBam**: Useful for clipping adapter sequences or fixed-length segments from the ends of reads without re-aligning.
*   **ZipperBams**: Merges unmapped BAMs (containing metadata/UMIs) with aligned BAMs to produce a tagged, aligned BAM.
*   **ErrorRateByReadPosition**: Provides a detailed breakdown of substitution error rates across read cycles, essential for identifying sequencing quality issues.

## Expert Tips and Best Practices

*   **Read Structures**: Master the `--read-structures` syntax. It is the primary way fgbio understands where UMIs, cell barcodes, and templates are located within your raw reads.
*   **Memory Management**: Since fgbio is Java-based, ensure you provide enough heap memory for large BAM files using JVM flags: `java -Xmx8g -jar fgbio.jar ...`.
*   **Sorting Requirements**: Many fgbio tools (like `GroupReadsByUmi`) require the input BAM to be sorted by template-coordinate. Use `fgbio SortBam --sort-order TemplateCoordinate` if your aligner doesn't provide this.
*   **CRAM Support**: For modern workflows, use `--cram-ref-fasta` to enable direct reading and writing of CRAM files, saving significant disk space.
*   **Pipe Support**: fgbio tools generally support piping via `/dev/stdin` and `/dev/stdout` to avoid unnecessary intermediate disk I/O in complex pipelines.

## Reference documentation
- [fgbio GitHub Repository](./references/github_com_fulcrumgenomics_fgbio.md)
- [fgbio Wiki and Detailed Tool Guides](./references/github_com_fulcrumgenomics_fgbio_wiki.md)