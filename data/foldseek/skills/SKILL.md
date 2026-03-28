---
name: foldseek
description: Foldseek performs fast and sensitive structural alignments by encoding protein tertiary structures into a specialized 3Di alphabet. Use when user asks to search for structural homologs, cluster protein monomers or multimers, rescore alignments using TM-score, or perform sequence-to-structure searches using ProstT5.
homepage: https://github.com/steineggerlab/foldseek
---

# foldseek

## Overview

Foldseek is a high-performance tool designed to bridge the gap between the speed of sequence-based searches and the sensitivity of structural comparisons. It works by encoding tertiary protein structures into a "3Di" alphabet, allowing for extremely fast structural alignments. Use this skill to perform monomer or multimer searches, cluster protein universes at scale, or rescore alignments using TM-score. It is particularly effective for identifying remote homologs that have conserved structures despite low sequence identity.

## Core Workflows

### Structural Search (Monomers)
The `easy-search` module is the most common entry point for comparing structures.

```bash
# Basic search: query PDBs against a target database/folder
foldseek easy-search input_folder/ target_folder/ results.m8 tmp/

# Search with TM-score rescoring (more accurate but slower)
foldseek easy-search query.pdb target_db results.m8 tmp/ --alignment-type 1
```

### Structural Clustering
Use `easy-cluster` to group similar structures based on structural redundancy.

```bash
# Cluster structures with 50% sequence identity and 80% coverage
foldseek easy-cluster structures/ cluster_out tmp/ --min-seq-id 0.5 -c 0.8
```

### Multimer Search and Clustering
For protein complexes, use the multimer-specific modules which account for relative chain orientations.

```bash
# Search protein complexes
foldseek easy-multimersearch query_complex/ target_db results.m8 tmp/

# Cluster protein complexes
foldseek easy-multimercluster input_complexes/ cluster_out tmp/
```

### Sequence-to-Structure Search (ProstT5)
If you only have sequences but want structural sensitivity, Foldseek can use the ProstT5 language model to predict structural descriptors.

```bash
# Search FASTA sequences against a structure database
foldseek easy-search sequences.fasta structure_db results.m8 tmp/
```

## Expert Tips and Parameters

### Alignment Modes (`--alignment-mode`)
- `0`: High-speed 3Di-based alignment (default).
- `1`: TM-align (global-to-global) - best for high-quality structural similarity.
- `2`: 3Di + Smith-Waterman - better for local structural similarities.

### Output Customization
Use `--format-output` to define specific columns in the tab-separated results.
Common fields: `query,target,fident,alnlen,mismatch,gapopen,qstart,qend,tstart,tend,evalue,bits,prob,tmscore`.

```bash
foldseek easy-search q/ t/ res.m8 tmp/ --format-output "query,target,evalue,tmscore"
```

### Performance Optimization
- **GPU Acceleration**: If available, Foldseek automatically detects CUDA. For large-scale searches, ensure the database is padded for GPU using `foldseek createdb ... --pad-for-gpu 1`.
- **Memory**: For massive databases like AlphaFoldDB, ensure you have sufficient RAM or use `.idx` files to limit memory footprint.

### Database Management
For repetitive searches, create a permanent database instead of pointing to a folder.

```bash
# Create a database from PDB files
foldseek createdb input_pdbs/ target_db

# Create an index for faster subsequent searches
foldseek createindex target_db tmp/
```



## Subcommands

| Command | Description |
|---------|-------------|
| foldseek easy-cluster | By Martin Steinegger <martin.steinegger@snu.ac.kr> |
| foldseek easy-multimercluster | By Seongeun Kim <seamustard52@gmail.com> & Sooyoung Cha <ellen2g77@gmail.com> |
| foldseek easy-multimersearch | By Woosub Kim <woosubgo@snu.ac.kr> |
| foldseek easy-rbh | By Eli Levy Karin & Martin Steinegger <martin.steinegger@snu.ac.kr> |
| foldseek easy-search | By Martin Steinegger <martin.steinegger@snu.ac.kr> |

## Reference documentation
- [Foldseek README](./references/github_com_steineggerlab_foldseek_blob_master_README.md)
- [Foldseek Main Page](./references/github_com_steineggerlab_foldseek.md)