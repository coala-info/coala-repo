---
name: parsinsert
description: ParsInsert places microbial sequences into established phylogenetic frameworks to provide taxonomic assignments and updated tree structures. Use when user asks to insert sequences into a reference tree, classify microbial reads, or perform parsimonious phylogenetic placement.
homepage: https://github.com/dark2dark/parsinsert
---


# parsinsert

## Overview

ParsInsert is a C++ tool designed for the efficient placement of microbial sequences into established phylogenetic frameworks. By utilizing a parsimonious insertion algorithm, it maps query sequences onto curated reference trees to provide both a final tree structure and taxonomic assignments. Because the placement algorithm is deterministic, it is highly suitable for distributed processing environments where millions of sequence reads must be classified consistently across different compute nodes.

## Command Line Usage

The basic syntax for running ParsInsert requires a taxonomy file, a reference tree, a set of aligned reference sequences, and your query sequences.

```bash
ParsInsert -x <taxonomy_file> -t <tree_file> -s <aligned_reference_fasta> <query_sequences_fasta>
```

### Arguments

- `-x`: Path to the taxonomy classification file (e.g., `rdp.taxonomy`).
- `-t`: Path to the curated phylogenetic tree file (e.g., `core_set.tree`).
- `-s`: Path to the aligned reference sequences corresponding to the taxa in the tree (e.g., `core_set_aligned.fasta`).
- `<query_sequences_fasta>`: The input file containing the sequences you wish to classify and insert.

## Best Practices and Expert Tips

### Sequence Alignment
ParsInsert expects query sequences to be aligned. For the most accurate placement, ensure that your query sequences are aligned using the same reference or mask (such as a Lane Mask) used for the core reference set.

### Distributed Processing
Because ParsInsert is deterministic, you can process massive datasets by splitting a large query FASTA file into smaller chunks. Each chunk can be processed independently on different cores or machines using the same reference files (`-x`, `-t`, and `-s`), and the results will be identical to running them as a single batch.

### Reference Data Selection
The quality of the taxonomic assignment depends heavily on the curated tree and taxonomy files provided. It is common practice to use high-quality, curated datasets such as those provided by the Ribosomal Database Project (RDP).

### Testing the Installation
If you are setting up ParsInsert for the first time, you can verify the installation using the provided test suite in the source directory:
1. Run `make` to compile.
2. Run `make TEST` to execute the tool against the `TestData` directory and compare outputs to known valid results.

## Reference documentation
- [ParsInsert README and Documentation](./references/github_com_dark2dark_parsinsert.md)