---
name: hhsuite-data
description: HH-suite3 performs sensitive protein sequence analysis and remote homology detection using HMM-HMM alignment. Use when user asks to perform iterative HMM searches, search HMM databases, filter multiple sequence alignments, or build profile HMMs.
homepage: https://github.com/soedinglab/hh-suite
---


# hhsuite-data

## Overview
HH-suite3 is a specialized bioinformatics toolkit designed for protein sequence analysis through the comparison of Hidden Markov Models (HMMs). Unlike standard sequence-to-sequence search tools, HH-suite uses HMM-HMM alignment, which is significantly more sensitive for detecting distant evolutionary relationships (remote homology). This skill provides the necessary command-line patterns for searching large-scale databases like Uniclust30 or Pfam, building high-quality alignments, and managing HMM-based workflows.

## Core Tool Usage

### HHblits: Iterative Search and Alignment
`hhblits` is the primary tool for fast, iterative HMM-based searching. It is faster and more sensitive than PSI-BLAST.

- **Single search iteration**:
  `hhblits -i <input_fasta_or_a3m> -o <result_file> -n 1 -d <database_basename>`
- **Generate a multiple sequence alignment (MSA)**:
  `hhblits -i <input_file> -o <result_file> -oa3m <output_alignment.a3m> -d <database_basename>`
- **Common Parameters**:
  - `-n <int>`: Number of iterations (default is 2).
  - `-e <double>`: E-value cutoff for inclusion in the next iteration.
  - `-cpu <int>`: Number of CPUs to use.

### HHsearch: HMM-HMM Database Searching
`hhsearch` is used to search a database of HMMs using a query MSA or HMM. It is the gold standard for template detection in protein structure prediction.

- **Basic search**:
  `hhsearch -i <query_msa_or_hhm> -d <database_basename> -o <result_file>`
- **Search with secondary structure scoring**:
  `hhsearch -i <query_file> -d <database_basename> -ssm 2` (0: no scoring, 1: posterior, 2: predicted vs. predicted)

### HHfilter: MSA Processing
Use `hhfilter` to reduce redundancy or filter sequences in an alignment before building an HMM.

- **Filter by identity and coverage**:
  `hhfilter -i <input_a3m> -o <output_a3m> -id 90 -cov 50`
  - `-id`: Maximum pairwise sequence identity (%).
  - `-cov`: Minimum coverage with query (%).
  - `-neff`: Target diversity (Neff) of the alignment.

### HHmake: Building HMMs
Convert a multiple sequence alignment into a profile HMM.

- **Basic HMM creation**:
  `hhmake -i <input_a3m> -o <output_hhm>`

## Expert Tips and Best Practices

- **Hardware Optimization**: HH-suite3 performance is heavily dependent on SIMD instruction sets. AVX2 builds are roughly 2x faster than SSE2. Always check CPU compatibility using `cat /proc/cpuinfo | grep avx2`.
- **Database Basenames**: When specifying the database (`-d`), provide the basename only (e.g., `uniclust30_2018_08`), not the file extension. The tool expects multiple files (e.g., `_cs219.ffdata`, `_hhm.ffdata`) to exist with that prefix.
- **Memory Management**: For very large databases like BFD, ensure the system has sufficient RAM to handle the prefilter indices.
- **Format Conversion**: Use the included `reformat.pl` script to convert between alignment formats (A3M, A2M, FASTA, Stockholm).
  - Example: `scripts/reformat.pl a3m fas input.a3m output.fas`
- **Secondary Structure**: For maximum sensitivity in remote homology detection, add predicted secondary structure to your query using `addss.pl` before running `hhsearch`.

## Reference documentation
- [HH-suite GitHub Repository](./references/github_com_soedinglab_hh-suite.md)
- [HH-suite Wiki and User Guide](./references/github_com_soedinglab_hh-suite_wiki.md)