---
name: phyloaln
description: PhyloAln maps query sequences or raw reads directly to reference alignments to streamline the creation of datasets for evolutionary analysis. Use when user asks to align sequences to reference alignments, detect contamination in genomic data, or generate concatenated matrices for phylogenetic trees.
homepage: https://github.com/huangyh45/PhyloAln
---

# phyloaln

## Overview
PhyloAln is a specialized tool designed for the "omic era" that streamlines the creation of alignments for evolutionary analysis. Unlike traditional workflows that require separate steps for assembly, gene prediction, and orthology assignment, PhyloAln maps query data directly to existing reference alignments. It is particularly effective for processing high-throughput sequencing (HTS) reads and includes built-in mechanisms to detect and filter foreign or cross-contamination, ensuring higher quality downstream phylogenetic trees.

## Core Workflows and CLI Patterns

### Basic Alignment
To align query sequences (assembled or raw) against a set of reference alignments:
```bash
PhyloAln -i query_sequences.fasta -r reference_dir/ -o output_dir/
```
*   `-i`: Input file (FASTA format for sequences or FASTQ for reads).
*   `-r`: Directory containing reference alignments (FASTA format).
*   `-o`: Output directory for results.

### Handling Different Data Types
*   **Raw Reads**: PhyloAln can map reads directly. Ensure you have sufficient memory for large HTS datasets.
*   **Translated Sequences**: Use the auxiliary script `transseq.pl` if you need to convert nucleotide sequences to amino acids before alignment.
*   **Gene Families**: PhyloAln supports generating alignments for multiple-copy genes, making it suitable for gene family evolution studies.

### Contamination Detection
PhyloAln automatically checks for foreign sequences. To optimize this:
*   Provide an appropriate outgroup in your reference alignments to improve the sensitivity of contamination detection.
*   Review the contamination reports in the output directory to identify and remove suspicious taxa.

### Post-Alignment Processing
Use the provided auxiliary scripts in the `scripts/` directory to finalize your matrix:
*   **Concatenation**: Combine multiple gene alignments into a single supermatrix.
    ```bash
    perl scripts/connect.pl -i aln_dir/ -o concatenated.fas
    ```
*   **Trimming**: Remove poorly aligned or high-gap regions.
    ```bash
    python3 scripts/trim_matrix.py -i concatenated.fas -o trimmed.fas -p 0.5
    ```
*   **Back-translation**: Convert protein alignments back to nucleotide alignments.
    ```bash
    perl scripts/revertransseq.pl -p protein_aln.fas -n nucleotide_seqs.fas -o output_nt_aln.fas
    ```

## Expert Tips
*   **Memory Management**: If running on large datasets and encountering memory errors, process reference genes in smaller batches or increase the available swap space.
*   **Reference Quality**: The accuracy of PhyloAln is highly dependent on the quality of the reference alignments. Ensure your references are well-curated and representative of the diversity in your query.
*   **Path Configuration**: Always add the PhyloAln and scripts directory to your `$PATH` for easier access to auxiliary tools:
    ```bash
    export PATH=$PATH:/path/to/PhyloAln:/path/to/PhyloAln/scripts
    ```
*   **Tree Rooting**: Use `root_tree.py` after your phylogenetic inference (e.g., via IQ-TREE or RAxML) to automatically root your tree based on specified outgroups.



## Subcommands

| Command | Description |
|---------|-------------|
| PhyloAln | A program to directly generate multiple sequence alignments from FASTA/FASTQ files based on reference alignments for phylogenetic analyses. |
| perl /usr/local/bin/connect.pl | Concatenate multiple alignments into a matrix. |
| perl /usr/local/bin/revertransseq.pl | Used the aligned translated sequences in a file as blueprint to aligned nucleotide sequences, which means reverse-translation. |
| prune_tree.py | Prunes a phylogenetic tree by removing specified sequences from clades. |
| root_tree.py | Roots a phylogenetic tree. |
| transseq.pl | Converts sequences between different formats. |
| trim_matrix.py | Trims a multiple sequence alignment matrix based on specified criteria for columns and rows. |

## Reference documentation
- [PhyloAln GitHub Repository](./references/github_com_huangyh45_PhyloAln.md)
- [PhyloAln README and Usage Guide](./references/github_com_huangyh45_PhyloAln_blob_main_README.md)