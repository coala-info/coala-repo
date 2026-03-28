---
name: pomoxis
description: Pomoxis is a suite of bioinformatics utilities designed to streamline the analysis, assembly, and quality assessment of Oxford Nanopore sequencing data. Use when user asks to align reads to a reference, generate draft assemblies, filter or subsample BAM files, and assess assembly accuracy or error profiles.
homepage: https://github.com/nanoporetech/pomoxis
---

# pomoxis

## Overview

Pomoxis is a suite of bioinformatic utilities developed by Oxford Nanopore Technologies to streamline the analysis of nanopore sequencing data. It acts as a wrapper for high-performance third-party tools (like minimap2, racon, and samtools) while providing its own specialized scripts for downstream analysis. You should use this skill to perform common tasks such as creating consensus assemblies, filtering alignments by quality or length, and generating detailed error reports (homopolymers, substitutions, etc.) to evaluate sequencing performance or assembly accuracy.

## Core CLI Workflows

### Alignment and Assembly
Pomoxis provides high-level wrappers that bundle standard parameters for nanopore data.

*   **Align reads to a reference**:
    `mini_align -r reference.fa -i reads.fastq -p output_prefix -t 8`
    *   Use `-y` to include supplementary alignments.
    *   Use `-d` to specify minimap2 presets (e.g., `map-ont`, `asm5`).
    *   Use `-C` to copy FASTX comments into BAM tags.
*   **Generate a draft assembly**:
    `mini_assemble -i reads.fastq -o assembly_dir -t 8`
    *   This wraps `miniasm` and `racon` for rapid assembly and polishing.

### BAM Manipulation and Filtering
Use these tools to prepare datasets for specific coverage depths or quality thresholds.

*   **Subsample a BAM file**:
    `subsample_bam -i input.bam -p output.bam -c 50`
    *   Targets a specific coverage (e.g., 50x).
    *   Use `--quality` to filter by mean error probability.
    *   Use `--force_low_coverage` to keep contigs that don't meet the target depth.
*   **General BAM filtering**:
    `filter_bam -i input.bam -o filtered.bam --min_length 1000 --min_qual 10`
    *   Supports multithreaded I/O and can retain unmapped reads that pass non-alignment filters.

### Quality Assessment and Statistics
These tools are essential for benchmarking assemblies or evaluating run quality.

*   **Generate alignment statistics**:
    `stats_from_bam input.bam > stats.tsv`
    *   Provides read-level metrics including mean Q-score, alignment flags, and mapping quality.
*   **Assess assembly accuracy**:
    `assess_assembly -r reference.fa -i assembly.fa -t 8`
    *   Calculates identity, indels, and mismatches.
    *   Use `-a` to accumulate errors over multiple chunks for more robust statistics.
*   **Analyze homopolymer errors**:
    `assess_homopolymers -r reference.fa -i assembly.fa -t 8`
    *   Specifically targets common nanopore systematic errors in homopolymer runs.

## Expert Tips

*   **Memory Management**: If `catalogue_errors` is consuming too much memory, ensure you are using the latest version, as memory optimizations were introduced in v0.3.9.
*   **Coverage Analysis**: Use `coverage_from_bam` with the `--one_file` option for a simplified output format when calculating depth across a reference.
*   **Fast Conversion**: Use `fast_convert qa` to quickly convert files to FASTA format while maintaining quality-aware headers.
*   **Handling LRA**: Pomoxis handles LRA (Long Read Aligner) BAMs where the `NM` tag represents matches rather than edit distance.



## Subcommands

| Command | Description |
|---------|-------------|
| assess_assembly | Calculate accuracy statistics for an assembly. |
| filter_bam | Filter a bam |
| intersect_assembly_errors | Assess errors which occur in the same reference position accross multiple assemblies. |
| mini_align | Align fastq/a or bam formatted reads to a genome using minimap2. |
| mini_assemble | Assemble fastq/fasta formatted reads and perform POA consensus. |
| stats_from_bam | Parse a bamfile (from a stream) and output summary stats for each read. |
| subsample_bam | Subsample a bam to uniform or proportional depth |

## Reference documentation

- [Pomoxis GitHub README](./references/github_com_nanoporetech_pomoxis_blob_master_README.md)
- [Pomoxis Changelog](./references/github_com_nanoporetech_pomoxis_blob_master_CHANGELOG.md)