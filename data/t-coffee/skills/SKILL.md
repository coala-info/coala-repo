---
name: t-coffee
description: T-Coffee is a comprehensive suite of tools designed for generating high-consistency multiple sequence alignments by combining various alignment sources. Use when user asks to align protein or nucleotide sequences, perform structure-based alignments, or use homology-extended methods for low-identity sequences.
homepage: https://github.com/cbcrg/tcoffee
metadata:
  docker_image: "quay.io/biocontainers/t-coffee:13.46.2.7c9e712d--pl5321hb2a3317_0"
---

# t-coffee

## Overview

T-Coffee (Tree-based Consistency Objective For alignment Evaluation) is a comprehensive suite of tools designed for multiple sequence alignment. Its primary strength lies in its ability to combine different alignment sources—such as local and global alignments, structural templates, or profile-based information—into a single, high-consistency output. Use this skill when you need to generate biologically accurate alignments that go beyond simple heuristic methods, or when you need to align sequences with known 3D structures.

## Common CLI Patterns

### Basic Alignment
The simplest way to align a set of sequences in FASTA format:
`t_coffee sequences.fasta`

### Structural Alignment (Expresso)
Use this mode when you have protein sequences and want T-Coffee to automatically fetch and use structural templates from the PDB:
`t_coffee -mode expresso -seq sequences.fasta`

### Large Scale Alignment (Regressive Mode)
For datasets containing hundreds or thousands of sequences where standard consistency-based alignment is too memory-intensive:
`t_coffee -method regressive -seq sequences.fasta`

### Homology-Extended Alignment (PSI-Coffee)
Use this for sequences with low identity by performing a BLAST search to build profiles before aligning:
`t_coffee -mode psicoffee -seq sequences.fasta`

### Output and Format Control
Direct output to specific files or standard streams:
`t_coffee -seq sequences.fasta -outfile=result.aln -outorder=input`

Supported output formats include:
- `-output=clustalw_aln` (Default)
- `-output=fasta_aln`
- `-output=score_ascii` (Shows alignment quality/consistency)

## Expert Tips

- **Consistency Scoring (TCS)**: Use the Transitive Consistency Score (TCS) to identify which parts of your alignment are most reliable. This is useful for filtering out poorly aligned regions before phylogenetic analysis.
- **Combining Methods**: You can combine multiple alignment methods by passing them to the `-method` flag (e.g., `-method mafftgins_msa,clustalw_msa`).
- **Memory Management**: If you encounter "MAX_N_PID" errors on Linux systems with very large parallel runs, ensure your kernel limits are adjusted or use the regressive mode to reduce the computational footprint.
- **PDB Headers**: When using structure-based modes, ensure your PDB files have standard headers; non-standard formatting can occasionally cause infinite loops in the template-matching phase.

## Reference documentation

- [t-coffee - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_t-coffee_overview.md)
- [cbcrg/tcoffee: A collection of tools for Multiple Alignments](./references/github_com_cbcrg_tcoffee.md)
- [T-Coffee Wiki Home](./references/github_com_cbcrg_tcoffee_wiki.md)
- [T-Coffee Issues and Bug Reports](./references/github_com_cbcrg_tcoffee_issues.md)