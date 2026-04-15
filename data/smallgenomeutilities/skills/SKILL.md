---
name: smallgenomeutilities
description: smallgenomeutilities provides a suite of command-line tools for viral genomics tasks including coordinate liftover, base counting, and consensus building. Use when user asks to transform alignments between references, extract subsequences, calculate coverage metrics, generate consensus sequences, or detect frameshift deletions.
homepage: https://github.com/cbg-ethz/smallgenomeutilities
metadata:
  docker_image: "quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0"
---

# smallgenomeutilities

## Overview

The `smallgenomeutilities` package is a suite of Python-based command-line tools designed to handle the unique challenges of viral genomics, such as high variability and the need for precise coordinate mapping (liftover). It is particularly useful for researchers working with the V-pipe workflow or anyone needing to perform base counting, consensus building, and frameshift detection in small, compact genomes.

## Core Workflows and CLI Patterns

### 1. Alignment and Reference Manipulation
Use these tools to move alignments between different reference coordinate systems or to extract specific subsets of data.

*   **Genomic Liftover**: Use `convert_reference` to transform a SAM/BAM alignment from one reference sequence to another. This is essential when comparing clinical samples against different standard reference strains.
*   **Subsequence Extraction**: Use `extract_sam` to pull specific regions from an alignment. It supports filtering by frequency and can automatically translate nucleotide sequences into peptide sequences for protein-level analysis.
*   **Sequence Retrieval**: Use `extract_seq` to filter FASTA files for specific sequences matching a provided string ID.

### 2. Coverage Analysis and Quality Control
These utilities help determine if sequencing depth is sufficient for variant calling or haplotype reconstruction.

*   **Base Counting**: Use `aln2basecnt` to generate TSV files containing base counts and coverage per position from a single alignment.
*   **QC Metrics**: Use `coverage_depth_qc` on the TSV output of `aln2basecnt` to calculate the fraction of the genome covered at specific depth thresholds (e.g., 10x, 100x).
*   **Targeted Coverage**: 
    *   Use `coverage_stats` for a specific region within an alignment.
    *   Use `coverage` when the target region is located on a different contig.
*   **ShoRAH Preparation**: Use `extract_coverage_intervals` to identify 0-indexed, half-open intervals `[start:end)` that meet the coverage requirements for running the ShoRAH haplotype reconstructor.

### 3. Consensus and Haplotype Analysis
Tools for summarizing alignments and visualizing the relationship between reconstructed viral variants.

*   **Consensus Generation**: Use `extract_consensus` to build a single sequence from a BAM file. You can choose to output the majority base at each position or use IUPAC ambiguous bases to represent diversity.
*   **Haplotype Visualization**: Use `compute_mds` to perform multidimensional scaling. This transforms genetic distances between haplotypes into a 2D or 3D space for visualization.
*   **QuasiRecomb Integration**: Use `convert_qr` to merge transmitter and recipient haplotype sets, filter gaps, and optionally translate the results to peptides.

### 4. Structural Integrity Checks
*   **Frameshift Detection**: Use `frameshift_deletions_checks` to identify deletions that disrupt the reading frame. 
    *   *Note*: This utility requires `mafft` to be installed and available in your PATH.

## Expert Tips
*   **Piping and Redirection**: Most utilities are designed to work within standard Unix pipelines. Ensure your input BAM files are indexed (using `samtools index`) before using extraction or coverage tools.
*   **Peptide Translation**: When using `extract_sam` or `convert_qr` for peptide translation, ensure your input coordinates align correctly with the coding sequence (CDS) boundaries to avoid out-of-frame translations.
*   **Memory Management**: While designed for "small" genomes, some utilities (like MDS computation) can become resource-intensive if the number of haplotypes is extremely large.



## Subcommands

| Command | Description |
|---------|-------------|
| aln2basecnt | Script to extract base counts and coverage information from a single alignment file |
| convert_reference | Convert reference sequences based on MSA and BAM alignment. |
| coverage_depth_qc | Computes 'fraction of genome covered a depth' QC metrics from coverage TSV files (made by aln2basecnt, samtools depth, etc.) |
| extract_consensus | Script to construct consensus sequences |
| extract_coverage_intervals | Script to extract coverage windows for ShoRAH |
| frameshift_deletions_checks | Produces a report about frameshifting indels and stops in a consensus sequences |
| mapper | Mapper tool |
| minority_freq | Script to extract minority alleles per samples |
| paired_end_read_merger | Merges paired-end reads to one fused reads based on alignment. |

## Reference documentation
- [smallgenomeutilities GitHub Repository](./references/github_com_cbg-ethz_smallgenomeutilities.md)
- [Detailed README and Tool Descriptions](./references/github_com_cbg-ethz_smallgenomeutilities_blob_master_README.rst.md)