---
name: pyabpoa
description: pyabpoa is a high-performance tool that performs partial order alignment to generate consensus sequences and multiple sequence alignments from sets of sequences. Use when user asks to generate a consensus sequence, perform multiple sequence alignment, create an alignment graph, or align sequences to an existing graph.
homepage: https://github.com/yangao07/abPOA
---


# pyabpoa

## Overview
pyabpoa (the Python interface for abPOA) is a high-performance alignment tool that utilizes SIMD vectorization and adaptive banding to perform Partial Order Alignment. It is designed to align a set of sequences into a graph representation, allowing for the generation of accurate consensus sequences and multiple sequence alignments (MSA). It is significantly faster than traditional POA implementations and supports various scoring schemes, including affine and convex gap penalties, making it ideal for noisy long-read data.

## Installation
Install via bioconda:
```bash
conda install -c bioconda abpoa
```

## Common CLI Patterns

### Consensus Sequence Generation
By default, the tool uses the "heaviest bundling" algorithm to find the most supported path through the alignment graph.
* **Standard consensus**: `abpoa sequences.fa > consensus.fa`
* **Most frequent bases**: Use this if the default bundling is not desired: `abpoa sequences.fa -a1 > consensus.fa`
* **Diploid/Polyploid consensus**: Generate multiple consensus sequences for heterozygous samples: `abpoa input.fa -d 2 > 2cons.fa`

### Multiple Sequence Alignment (MSA)
* **Row-column FASTA format**: `abpoa sequences.fa -r1 > output.msa`
* **MSA with consensus**: `abpoa sequences.fa -r2 > output_with_cons.msa`

### Graph and Incremental Alignment
* **Generate GFA**: Output the alignment graph in Graphical Fragment Assembly format: `abpoa sequences.fa -r3 > output.gfa`
* **Incremental alignment**: Align new sequences to an existing graph (GFA) or MSA: `abpoa -i existing.gfa new_seqs.fa -r3 > updated.gfa`

### Protein Alignment
* **Amino acid mode**: Must specify the amino acid flag and a scoring matrix: `abpoa -c -t BLOSUM62.mtx input_aa.fa > cons_aa.fa`

## Expert Tips and Best Practices
* **Input Formats**: Supports FASTA, FASTQ, and their gzipped versions (.fa.gz, .fq.gz).
* **Batch Processing**: If you have many sets of sequences to align independently, use the `-l` flag with a file containing a list of paths to your sequence files. This is more efficient than calling the binary repeatedly.
* **Visualizing Results**: Use the `-g` flag to generate a PNG plot of the alignment graph: `abpoa seqs.fa -g alignment_graph.png > consensus.fa`.
* **Memory/Speed Trade-off**: The adaptive banding (enabled by default) significantly speeds up alignment. If you encounter issues with highly divergent sequences, check the banding parameters in the help menu (`abpoa -h`).
* **SIMD Support**: The tool automatically detects SSE2, SSE4.1, and AVX2 instructions. Ensure your environment supports these for maximum performance.

## Reference documentation
- [abPOA GitHub Repository](./references/github_com_yangao07_abPOA.md)
- [pyabpoa Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pyabpoa_overview.md)