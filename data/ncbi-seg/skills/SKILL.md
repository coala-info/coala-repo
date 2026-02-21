---
name: ncbi-seg
description: NCBI `seg` is a specialized tool designed to partition amino acid or nucleotide sequences into segments of low and high local complexity based on Shannon entropy.
homepage: https://github.com/abelardoacm/genomic_seg_plots
---

# ncbi-seg

## Overview
NCBI `seg` is a specialized tool designed to partition amino acid or nucleotide sequences into segments of low and high local complexity based on Shannon entropy. Low-complexity regions—often characterized by repetitive motifs or biased composition—can confound sequence analysis and database searches. This skill provides the necessary command-line patterns to operate the core `seg` utility and its associated genomic visualization scripts to automate the location of simple sequences in short genomes.

## Command Line Usage

### Core `seg` Syntax
The basic structure for the `seg` command is:
`seg <file> <window> <locut> <hicut> <options>`

*   **file**: Fasta-formatted sequence file.
*   **window**: The window size for complexity calculation (default: 12).
*   **locut**: The low (trigger) complexity threshold (default: 2.2).
*   **hicut**: The high (extension) complexity threshold (default: locut + 0.3).

### Common CLI Patterns

**1. Masking Sequences for BLAST**
To replace low-complexity regions with 'x' characters (standard preprocessing for homology searches):
`seg input.fasta -x > masked_output.fasta`

**2. Extracting Specific Segments**
*   **Low-complexity only**: `seg input.fasta -l`
*   **High-complexity only**: `seg input.fasta -h`
*   **All segments in Fasta format**: `seg input.fasta -a`

**3. Adjusting Stringency**
To increase sensitivity (detect more LCRs), lower the complexity cutoffs:
`seg input.fasta 12 1.9 2.1`

**4. Formatting Output**
*   **Prettyprint (Tree format)**: `seg input.fasta -p`
*   **Prettyprint (Block format)**: `seg input.fasta -q`
*   **Set characters per line**: `seg input.fasta -c 80`

### Genomic Visualization Pipeline
The `genomic_seg_plots` wrapper automates the analysis and plotting of these regions across a genome.

**Execution Pattern:**
From the `bin` directory:
`./genomic_slimcomplots.sh <taxon_name> <window> <locut> <hicut>`

**Example:**
`./genomic_slimcomplots.sh Nidovirales 12 1.9 2.1`

*   **Input Requirement**: Genbank files must be placed in `data/Raw_Database/` before execution.
*   **Output**: Results and plots are generated in the `results/Complexity_genomic_plots/` directory.

## Expert Tips and Best Practices

*   **Merging Segments**: Use the `-m <size>` option to merge short high-complexity segments (shorter than `<size>`) with adjacent low-complexity regions. This prevents over-fragmentation of the sequence.
*   **Overlapping Regions**: By default, `seg` merges overlapping low-complexity segments. Use the `-o` flag if you need to see the raw, overlapping segments.
*   **Header Management**: Use the `-n` flag to prevent `seg` from appending complexity information to the Fasta header line, which is useful when downstream tools require strict header formats.
*   **Trimming**: The `-t <maxtrim>` option controls the maximum trimming of raw segments (default 100). Adjust this if you find that the boundaries of your detected LCRs are too broad or too narrow.

## Reference documentation
- [genomic_seg_plots Main Repository](./references/github_com_abelardoacm_genomic_seg_plots.md)
- [Bin Directory and Scripts](./references/github_com_abelardoacm_genomic_seg_plots_tree_main_bin.md)