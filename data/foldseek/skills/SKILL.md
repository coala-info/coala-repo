---
name: foldseek
description: Foldseek is a high-performance tool designed for the rapid comparison of large-scale protein structure datasets.
homepage: https://github.com/steineggerlab/foldseek
---

# foldseek

## Overview
Foldseek is a high-performance tool designed for the rapid comparison of large-scale protein structure datasets. It works by encoding tertiary interactions into a structural alphabet (3Di), allowing it to leverage optimized sequence alignment algorithms for structural search. Use this skill to perform monomer or multimer searches, create custom structural databases, and execute structural clustering at speeds orders of magnitude faster than traditional tools like TM-align, while maintaining comparable sensitivity.

## Core Workflows

### Structural Search (Easy Search)
The `easy-search` module is the most common entry point for querying structures against a target set.

```bash
# Search query PDBs against a target folder of PDBs
foldseek easy-search input_queries/ target_pdb_folder/ results.tsv tmp/

# Search against a pre-built database (e.g., AlphaFoldDB)
foldseek easy-search query.pdb path/to/afdb results.tsv tmp/
```

### Database Management
For repetitive searches or very large datasets, create a formatted Foldseek database first.

```bash
# Create a database from a folder of PDB/mmCIF files
foldseek createdb path/to/pdb_folder/ targetDB

# Download common databases (AlphaFoldDB, PDB, etc.)
foldseek databases AFDB target_dir tmp/
```

### Structural Clustering
Cluster structures based on structural similarity (TM-score or 3Di-score).

```bash
# Cluster a database
foldseek cluster targetDB clusterDB tmp/

# Generate a TSV of cluster members
foldseek createtsv targetDB targetDB clusterDB clustering_results.tsv
```

## Expert Tips and Parameters

### Customizing Output Fields
Use `--format-output` to extract specific metrics. Useful codes include:
- `query,target`: Identifiers
- `alntmscore`: TM-score of the alignment
- `qtmscore,ttmscore`: TM-score normalized by query or target length
- `lddt`: Local Distance Difference Test score
- `u,t`: Rotation matrix and translation vector for superposition

```bash
foldseek easy-search query.pdb targetDB aln.tsv tmp --format-output "query,target,evalue,alntmscore,lddt"
```

### Alignment Modes
- **Default**: Fast 3Di-based alignment.
- **TM-align mode** (`--alignment-type 1`): Uses TM-align for the alignment stage (slower but standard for some publications).
- **GPU Acceleration**: If using the GPU build, add `--prefilter-mode 1` to utilize GPU resources for the prefilter step, which is significantly faster for single-query searches.

### Memory Optimization
- **Large Databases**: Searching the full AFDB50 requires ~151GB RAM with Cα information.
- **Low RAM Mode**: Disable structure bits (`--sort-by-structure-bits 0`) to reduce RAM usage (e.g., AFDB50 drops to ~35GB). This affects ranking for hits with E-values > 10⁻¹ but preserves E-value accuracy.

### Multimer Search
For complex-to-complex alignment, use the `complexsearch` module.
```bash
foldseek complexsearch query_complex.pdb target_complex_dir/ results.tsv tmp/
```

## Reference documentation
- [Foldseek Wiki](./references/github_com_steineggerlab_foldseek_wiki.md)
- [Foldseek Main README](./references/github_com_steineggerlab_foldseek.md)