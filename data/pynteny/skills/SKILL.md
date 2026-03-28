---
name: pynteny
description: Pynteny searches for syntenic blocks and conserved gene arrangements within prokaryotic sequence data using profile HMMs. Use when user asks to identify operons, search for specific genomic structures, or find groups of genes with defined relative positions and orientations.
homepage: http://github.com/robaina/Pynteny
---

# pynteny

## Overview

Pynteny is a specialized bioinformatics tool designed to search for syntenic blocks—groups of genes with specific relative positions and orientations—within prokaryotic sequence data. It leverages HMMER to identify Open Reading Frames (ORFs) and then filters these hits based on a user-defined synteny structure. This approach transforms standard sequence similarity searches into context-aware genomic queries, allowing for the precise identification of operons or conserved gene arrangements even in unannotated assembly data.

## Core Workflow

### 1. Initialize HMM Resources
Before searching, you need a profile HMM database. Pynteny is optimized for the NCBI PGAP database.
```bash
pynteny download --outdir ./data/hmms --unpack
```

### 2. Prepare the Peptide Database
Pynteny requires a specific labeling format for peptide sequences to track genomic coordinates. Use the `build` command to convert nucleotide assemblies (FASTA) or GenBank files into a compatible labeled peptide database.
```bash
pynteny build --data assembly.fasta --outfile labeled_peptides.faa
```
*Note: If using a directory of multiple genomes, use `--prepend-filename` to track the genome of origin.*

### 3. Execute Synteny Search
The `search` command is the primary interface. It requires a synteny structure string.
```bash
pynteny search \
    --synteny_struc ">gene_A 0 >gene_B 2 <gene_C" \
    --data labeled_peptides.faa \
    --outdir ./results \
    --gene_ids
```

## Synteny Structure Syntax

The synteny string defines the spatial relationship between genes:
- **Orientation**: `>` for sense (positive) strand, `<` for antisense (negative) strand. Omitting the symbol makes the search strand-agnostic.
- **Distance**: An integer between gene names represents the **maximum** number of intervening ORFs allowed. `0` means the genes must be immediate neighbors.
- **HMM Groups**: Use `|` within parentheses to allow multiple HMMs for a single position: `(HMM_1|HMM_2) 0 >HMM_3`.
- **Gene Symbols**: If using the PGAP database, you can use common gene symbols (e.g., `leuC`) instead of HMM IDs by adding the `--gene_ids` flag.

## Expert Tips and Best Practices

- **Synteny vs. Collinearity**: By default, Pynteny searches for collinear structures (exact order). Use the `--unordered` flag to search for "true" synteny where the genes must be in the same neighborhood but can appear in any relative order.
- **Performance Optimization**: Use the `--reuse` flag if you are running multiple searches against the same database with different synteny structures. This prevents Pynteny from re-running HMMER for HMMs that were already processed in the same output directory.
- **Refining Hits**: Pass additional HMMER-specific arguments (like E-value thresholds) using the `--hmmsearch_args` flag: `--hmmsearch_args "-E 1e-10"`.
- **Validation**: Use the `parse` subcommand to verify how gene symbols translate to HMM IDs before committing to a long search:
  ```bash
  pynteny parse --synteny_struc ">soxX 0 >soxY" --hmm_meta ./data/hmms/hmm_meta.tsv
  ```



## Subcommands

| Command | Description |
|---------|-------------|
| pynteny build | Translate nucleotide assembly file and assign contig and gene location info to each identified ORF (using prodigal). Label predicted ORFs according to positional info and export a fasta file containing predicted and translated ORFs. Alternatively, extract peptide sequences from GenBank file containing ORF annotations and write labelled peptide sequences to a fasta file. |
| pynteny download | Download HMM database from NCBI. |
| pynteny parse | Translate synteny structure with gene symbols into one with HMM groups, according to provided HMM database. |
| pynteny search | Query sequence database for HMM hits arranged in provided synteny structure. |

## Reference documentation
- [Search Subcommand](./references/robaina_github_io_Pynteny_subcommands_search.md)
- [Build Subcommand](./references/robaina_github_io_Pynteny_subcommands_build.md)
- [CLI Examples](./references/robaina_github_io_Pynteny_examples_example_cli.md)
- [API Reference](./references/robaina_github_io_Pynteny_references_api.md)