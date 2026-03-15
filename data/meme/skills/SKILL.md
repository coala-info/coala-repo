---
name: meme
description: "MEME discovers novel motifs in sets of related DNA, RNA, or protein sequences. Use when user asks to discover novel patterns, identify regulatory elements, or find conserved protein domains in biological sequence data."
homepage: https://meme-suite.org
---


# meme

## Overview

The MEME Suite is a comprehensive toolkit for motif-based sequence analysis. It is used to discover novel patterns (motifs) in sets of related DNA, RNA, or protein sequences, search for known motifs within new sequences, and determine the statistical enrichment of motifs in specific datasets. This skill should be used when you need to process biological sequence data to identify regulatory elements, binding sites, or conserved protein domains.

## Core Tool Selection

Choose the specific tool based on the analytical goal:

- **Motif Discovery**:
  - `meme`: Best for small to medium datasets where high sensitivity is required.
  - `streme`: Optimized for large datasets (e.g., ChIP-seq) and identifies motifs of varying lengths quickly.
  - `dreme`: Specifically for short motifs in large DNA datasets.
- **Motif Scanning (Searching)**:
  - `fimo`: Finds individual occurrences of motifs in a sequence database.
  - `mast`: Searches a sequence database for matches to a set of motifs, treating the motifs as a group.
  - `mcast`: Searches for clusters of motifs.
- **Enrichment Analysis**:
  - `ame`: Tests a set of sequences for enrichment of known motifs from a database.
  - `centrimo`: Identifies motifs that are locally enriched (e.g., in the center of ChIP-seq peaks).
- **Comparison & Conversion**:
  - `tomtom`: Compares discovered motifs against databases of known motifs (like JASPAR or HOCOMOCO).
  - `bed2fasta`: Converts genomic coordinates (BED) into sequence files (FASTA) for analysis.

## Input Format Requirements

### FASTA Sequences
- Must be plain text.
- Header line starts with `>` followed by an ID.
- Sequences can be DNA, RNA, or Protein.

### BED Files (Genomic Loci)
- Tab-delimited plain text.
- Required fields: `chrom`, `chromStart` (0-indexed), `chromEnd`.
- Optional field 6 (`strand`) is used by many MEME tools to determine orientation.

### Minimal MEME Motif Format
If creating a motif file manually, it must follow this structure:
1. **Version**: `MEME version 5` (or current version).
2. **Alphabet**: `ALPHABET= ACGT` (DNA), `ACGU` (RNA), or `ACDEFGHIKLMNPQRSTVWY` (Protein).
3. **Background**: `Background letter frequencies` (e.g., `A 0.25 C 0.25 G 0.25 T 0.25`).
4. **Motif Header**: `MOTIF [Identifier] [Alternate Name]`.
5. **Matrix**: `letter-probability matrix:` followed by rows of probabilities summing to 1.

## CLI Best Practices

- **Installation**: Use Conda for the most stable environment: `conda install bioconda::meme`.
- **Output Directories**: Most tools use the `-o <dir>` (overwrite) or `-oc <dir>` (create if missing) flags. Always specify an output directory to avoid cluttering the workspace.
- **Background Models**: For better statistical accuracy, provide a background model file (`--bgfile`) that reflects the global composition of the genome or organism being studied.
- **Parallelization**: For `meme`, use the `-p <n>` flag to specify the number of processors for parallel execution.
- **Handling Large Data**: When working with ChIP-seq data, prefer `meme-chip`, which runs a pipeline including `meme`, `streme`, and `centrimo` automatically.

## Expert Tips

- **Sequence Weights**: In `meme`, you can add a `>WEIGHTS` line in the FASTA file to down-weight redundant or highly similar sequences.
- **Ambiguity Codes**: MEME tools support standard IUPAC ambiguity codes (e.g., N, R, Y, W, S).
- **E-values vs. P-values**: Focus on the E-value for motif discovery; it represents the expected number of motifs of the same width and site count that one would find in a similarly sized set of random sequences.
- **Custom Alphabets**: If working with modified bases (e.g., methylcytosine), define a custom alphabet at the start of the motif or sequence file.



## Subcommands

| Command | Description |
|---------|-------------|
| ame | AME (Analysis of Motif Enrichment) finds known motifs that are enriched in a set of sequences. |
| centrimo | CentriMo (Local Motif Enrichment Analysis) - identifies motifs that are enriched in the center of sequences. |
| dreme | Finds discriminative regular expressions in two sets of DNA sequences. It can also find motifs in a single set of DNA sequences, in which case it uses a dinucleotide shuffled version of the first set of sequences as the second set. |
| fasta-get-markov | Estimate a Markov model from a FASTA file of sequences. Skips tuples containing ambiguous symbols. Combines both strands of complementable alphabets unless -norc is set. |
| fimo | Find Individual Motif Occurrences (FIMO) searches a sequence database for occurrences of known motifs. |
| glam2 | Gapped Local Alignment of Motifs (GLAM2) finds motifs in sequences, allowing for insertions and deletions. |
| mast | Motif Alignment and Search Tool (MAST) - searches for motifs in sequence databases. |
| sea | Simple Enrichment Analysis (SEA) for motifs in sequences. |
| streme | STREME (Sensitive, Thorough, Rapid, Enriched Motif Elicitation) discovers motifs in a set of sequences. |
| tomtom | Compare a query motif database against one or more target motif databases. |

## Reference documentation
- [MEME Motif Format](./references/meme_doc_meme-format.html.md)
- [FASTA Sequence Format](./references/meme_doc_fasta-format.html.md)
- [BED Genomic Loci Format](./references/meme-suite_org_meme_doc_bed-format.html.md)
- [AME Tool Details](./references/meme_tools_ame.md)
- [BED2FASTA Tool Details](./references/meme-suite_org_meme_tools_bed2fasta.md)