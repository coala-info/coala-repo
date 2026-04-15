---
name: cyntenator
description: Cyntenator identifies synteny and conserved gene order across multiple genomes by performing local alignments of gene sequences. Use when user asks to identify conserved gene blocks, perform multi-species synteny alignment, or find optimal gene order alignments using phylogenetic distances.
homepage: https://github.com/dieterich-lab/cyntenator
metadata:
  docker_image: "quay.io/biocontainers/cyntenator:0.0.r2326--h9948957_4"
---

# cyntenator

## Overview
Cyntenator is a specialized tool for identifying synteny—conserved gene order—across multiple genomes. Unlike traditional sequence-level aligners, it treats annotated genes as the basic units of alignment. It employs an extension of the Smith-Waterman algorithm to find optimal local alignments of gene sequences, incorporating protein similarity and phylogenetic distances to score conserved blocks. This skill provides guidance on configuring guide trees, selecting homology types, and managing multi-species alignment workflows.

## Command Line Usage

The basic syntax for cyntenator requires a guide tree and a homology definition:

```bash
cyntenator -t "((species1.txt species2.txt) species3.txt)" -h <type> [options]
```

### Core Arguments
- `-t "<tree>"`: **Obligatory.** A parenthesized string specifying the order of alignment. Leaf nodes must be the filenames of the gene annotation files.
- `-h <type>`: **Obligatory.** Defines the scoring system.
    - `id`: Matches based on identical Gene Symbols or IDs.
    - `blast [file]`: Uses BLAST bitscores from the provided file.
    - `orthologs [file]`: Uses a correspondence file for gene pairs.
    - `phylo [file] [weighted_tree]`: Weights matches by sequence similarity and phylogenetic distance.

### Alignment Parameters
- `-thr [int]`: Score threshold for reporting alignments (default: 4).
- `-gap [int]`: Penalty for gene gaps (default: -2).
- `-mis [int]`: Penalty for mismatches (default: -3).

### Filtering and Output
- `-filter [int]`: Limits output to the N best alignments or unique assignments.
- `-coverage [int]`: Limits how many times a single gene can appear in different alignments (default: 2).
- `-length [int]`: Minimum number of genes required in an alignment block.
- `-last`: Only prints alignments generated at the final step of the progressive alignment (highly recommended for multiple species to reduce intermediate noise).
- `-o [file]`: Redirects output to a specific file.

## Input File Formats

Cyntenator requires specific headers in the first row of input files to determine how to process them:

1.  **#genome**: Standard format for genomic alignment. Requires unique IDs. It merges redundant gene annotations (e.g., multiple transcripts for one gene).
    - Columns: `ID CHROMOSOME START END STRAND`
2.  **#sequence**: Used for alignments using IDs as the similarity measure. Does not require unique IDs.
3.  **#alignment**: The output format of cyntenator, which can be used as input for iterative or parallel alignment steps.

## Expert Tips and Best Practices

### Parallel Pairwise Alignment
For large datasets, you can compute pairwise alignments separately and then combine them into a multiple alignment:
1. Run pairwise: `cyntenator -t "(A.txt B.txt)" -h blast scores.txt > pair_AB.txt`
2. Run triple: `cyntenator -t "(pair_AB.txt C.txt)" -h blast scores.txt > triple_ABC.txt`

### Phylogenetic Weighting
When using `-h phylo`, the weighted tree string must include weights after closing brackets:
`"((HSX.txt:1.2 MMX.txt:1.3):0.5 CFX.txt:2.5):1"`
These weights represent the evolutionary distance and directly influence the alignment scoring matrix.

### Handling Ensembl Data
If obtaining data from Ensembl, ensure the coordinates are white-space separated. Cyntenator expects a simple flat-file structure where the strand is represented by `(+)` or `(-)`.

## Reference documentation
- [Cyntenator Overview](./references/anaconda_org_channels_bioconda_packages_cyntenator_overview.md)
- [Cyntenator GitHub Repository](./references/github_com_dieterich-lab_cyntenator.md)