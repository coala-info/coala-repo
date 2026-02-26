---
name: abpoa
description: abPOA is a high-performance tool that performs multiple sequence alignment and consensus calling using adaptive banded partial order graphs. Use when user asks to generate consensus sequences from noisy long-reads, create multiple sequence alignments, output alignment graphs in GFA format, or align protein sequences.
homepage: https://github.com/yangao07/abPOA
---


# abpoa

## Overview
abPOA (adaptive banded Partial Order Alignment) is a high-performance tool designed for multiple sequence alignment and consensus calling. By utilizing SIMD (Single Instruction, Multiple Data) vectorization and an adaptive banding technique, it significantly accelerates the dynamic programming required for partial order graphs. It is particularly robust for processing noisy long-read data, allowing users to generate consensus sequences, row-column MSAs, or graph-based representations of sequence relationships.

## Common CLI Patterns

### Consensus Sequence Generation
By default, abPOA uses the "heaviest bundling" algorithm to find the path with the largest weight in the graph.

*   **Standard consensus**:
    `abpoa sequences.fa > consensus.fa`
*   **Most frequent bases method**: Use this if the default bundling is not producing the expected result for specific motifs.
    `abpoa sequences.fa -a1 > consensus.fa`
*   **Diploid/Polyploid consensus**: Generate multiple consensus sequences for heterozygous samples.
    `abpoa sequences.fa -d 2 > 2_consensus.fa`

### Multiple Sequence Alignment (MSA)
abPOA can output traditional row-column alignments in FASTA format.

*   **Generate MSA only**:
    `abpoa sequences.fa -r1 > output.msa`
*   **Generate MSA including the consensus**:
    `abpoa sequences.fa -r2 > output_with_cons.msa`

### Graph and Incremental Alignment
abPOA supports the Graphical Fragment Assembly (GFA) format for representing the partial order graph.

*   **Output graph in GFA**:
    `abpoa sequences.fa -r3 > graph.gfa`
*   **Align new sequences to an existing graph**: Useful for iterative assembly or adding reads to a known backbone.
    `abpoa -i existing_graph.gfa new_reads.fa -r3 > updated_graph.gfa`

### Amino Acid Alignment
When working with protein sequences, you must enable the amino acid mode and specify a scoring matrix.

*   **Protein consensus**:
    `abpoa -c -t BLOSUM62.mtx protein_seqs.fa > protein_cons.fa`
    *Note: abPOA typically bundles `BLOSUM62.mtx` and `HOXD70.mtx`.*

## Expert Tips

*   **Input Flexibility**: abPOA natively handles FASTA, FASTQ, and their gzipped versions (`.fa.gz`, `.fq.gz`).
*   **Batch Processing**: If you have many sets of sequences to process independently, use the `-l` flag with a file containing a list of paths to your sequence files. abPOA will process each file in the list sequentially.
*   **Visualization**: You can generate a visual plot of the alignment graph using the `-g` option (requires appropriate library support during compilation).
    `abpoa sequences.fa -g alignment_graph.png > consensus.fa`
*   **Scoring Schemes**: abPOA supports global, local, and extension alignment modes. It also allows for complex gap penalties (linear, affine, and convex) which can be tuned for specific sequencing technologies (e.g., adjusting for high indel rates in ONT data).

## Reference documentation
- [abPOA GitHub Repository](./references/github_com_yangao07_abPOA.md)
- [abPOA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_abpoa_overview.md)