---
name: bamtocov
description: bamtocov is a high-performance bioinformatics toolkit used to extract sequence coverage from BAM or CRAM alignment files. Use when user asks to calculate physical or stranded coverage, convert alignments to bedGraph or WIG formats, determine coverage for specific target regions, or count reads per reference sequence.
homepage: https://github.com/telatin/bamtocov
---


# bamtocov

## Overview
bamtocov is a high-performance bioinformatics toolkit designed for efficient sequence coverage extraction. Built on the principles of the `covtobed` algorithm, it provides a memory-efficient way to process large alignment files (BAM/CRAM). It is uniquely suited for workflows requiring "physical coverage" (counting the entire insert between paired-end reads) and "stranded coverage," which are essential for RNA-seq and specialized sequencing assays.

## Core Tools and Usage

The suite consists of several specialized binaries. Ensure the input BAM/CRAM files are indexed for tools requiring random access.

### 1. bamtocov (Main Converter)
The primary tool for converting alignment files to coverage tracks.
*   **Basic Usage**: `bamtocov input.bam > output.bedgraph`
*   **Streaming**: It supports input from stdin, allowing integration with samtools:
    `samtools view -u -f 2 input.bam | bamtocov > physical_coverage.bedgraph`
*   **Output Formats**: Supports bedGraph (default) and WIG formats.

### 2. covtotarget
Used to calculate coverage specifically for regions defined in a target file (BED or GFF).
*   **Basic Usage**: `covtotarget --bed targets.bed input.bam > target_coverage.txt`
*   **Efficiency**: This is significantly faster than calculating whole-genome coverage when only specific genes or exons are of interest.

### 3. bamcountrefs
A utility to quickly count reads or calculate basic statistics per reference sequence (chromosome/contig) in the alignment file.
*   **Basic Usage**: `bamcountrefs input.bam`

## Expert Tips and Best Practices

*   **Memory Efficiency**: bamtocov is designed with a small memory footprint. If you are working on a cluster with strict memory limits or on a local machine with large datasets, prefer `bamtocov` over heavier tools like `bedtools genomecov`.
*   **Physical Coverage**: When analyzing paired-end data, use the physical coverage feature to represent the actual DNA fragments sequenced, rather than just the read coordinates.
*   **CRAM Support**: The tool natively supports CRAM files. Ensure the reference genome is accessible (via `REF_PATH` or a local fasta) when processing CRAM to avoid decompression errors.
*   **Strandedness**: For strand-specific RNA-seq data, utilize the stranded coverage options to separate signal from the forward and reverse strands, which is critical for identifying antisense transcription.
*   **Filtering**: While `bamtocov` has internal filters, for complex filtering (e.g., specific MAPQ thresholds or bitwise flags), it is often more robust to pipe filtered output from `samtools view` into `bamtocov`.

## Reference documentation
- [bamtocov - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_bamtocov_overview.md)
- [GitHub - telatin/bamtocov: coverage extraction from BAM/CRAM files](./references/github_com_telatin_bamtocov.md)