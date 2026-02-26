---
name: cmseq
description: "cmseq extracts biological metrics from BAM files to assess strain heterogeneity and genome coverage in metagenomics. Use when user asks to calculate breadth and depth of coverage, identify synonymous and non-synonymous mutations, or generate consensus sequences."
homepage: https://github.com/SegataLab/cmseq
---


# cmseq

## Overview
cmseq is a suite of command-line utilities designed to provide a streamlined interface for extracting biological metrics from BAM files. It is particularly useful in metagenomics for assessing strain heterogeneity and genome coverage. The toolset allows users to calculate breadth and depth of coverage, identify synonymous and non-synonymous mutations within protein-coding regions using GFF annotations, and generate consensus sequences.

## Core Commands and Usage

### 1. Breadth and Depth of Coverage
Use `breadth_depth.py` to obtain tabular data on how well reads map to references.

*   **Basic usage**:
    `breadth_depth.py my_alignment.sorted.bam`
*   **Filter by quality and coverage**:
    To ensure high-confidence metrics, set a minimum base quality and a minimum depth for a position to be counted.
    `breadth_depth.py --minqual 30 --mincov 10 my_alignment.bam`
*   **Target specific contigs**:
    Provide a comma-separated list or a FASTA file containing the IDs of interest.
    `breadth_depth.py -c genome_id_1,genome_id_2 my_alignment.bam`
*   **Handle unsorted files**:
    If the BAM file is not yet indexed or sorted, use the `--sortindex` flag to perform these operations on the fly.
    `breadth_depth.py --sortindex my_unsorted_alignment.bam`

### 2. Polymorphic Rate on CDS
Use `polymut.py` to calculate synonymous and non-synonymous mutation rates. This is essential for studying strain-level variation.

*   **Requirement**: A GFF file (e.g., from Prokka) where contig names match the BAM file.
*   **Basic usage**:
    `polymut.py --gff_file annotations.gff my_alignment.bam`
*   **Adjusting dominance threshold**:
    The `--dominant_frq_thrsh` (default 0.8) determines the ratio between the second-dominant and dominant allele required to consider a position polymorphic.
    `polymut.py --dominant_frq_thrsh 0.9 --gff_file annotations.gff my_alignment.bam`

## Expert Tips and Best Practices

*   **Quality Control**: The default `--minqual` is 30. If working with low-quality sequencing data or ancient DNA (aDNA), you may need to lower this, but be aware that it increases the risk of false-positive polymorphisms.
*   **Truncation**: Use the `--truncate` parameter in `breadth_depth.py` to ignore a specific number of nucleotides at the ends of contigs. This helps avoid edge-effect artifacts where mapping is often less reliable.
*   **Biopython Compatibility**: Note that `polymut.py` specifically requires Biopython <= 1.76. If using a newer environment, this specific script may fail due to changes in the Biopython SeqFeature API.
*   **Output Interpretation**: The output of `breadth_depth.py` includes a summary line (`all_contigs`) which treats all references as a single concatenated sequence. This is useful for overall sample statistics but should be distinguished from individual contig metrics.
*   **Read Filtering**: Use the `-f` flag to exclude unmapped, secondary, QC-failed, and duplicate reads. By default, cmseq considers all reads (similar to `bedtools genomecov`).

## Reference documentation
- [cmseq GitHub Repository](./references/github_com_SegataLab_cmseq.md)
- [cmseq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cmseq_overview.md)