---
name: spacedust
description: Spacedust is a modular toolkit for the de novo discovery of conserved gene clusters.
homepage: https://github.com/soedinglab/spacedust
---

# spacedust

## Overview

Spacedust is a modular toolkit for the de novo discovery of conserved gene clusters. It identifies groups of genes that appear together across different genomes by combining fast homology searches with an agglomerative hierarchical clustering algorithm that accounts for gene neighborhood. It supports both traditional sequence-based comparison and advanced structure-based comparison by integrating with Foldseek and MMseqs2.

## Core Workflow

### 1. Database Initialization
Before searching, input genomes must be converted into a Spacedust database format (`setDB`).

**For Nucleotide Input (.fna + .gff3):**
Requires GFF3 files to provide genomic coordinates.
```bash
spacedust createsetdb genome1.fna genome2.fna setDB tmpFolder --gff-dir gff_directory/ --gff-type CDS
```

**For Protein Input (.faa):**
Requires protein headers in Prodigal format to extract coordinates.
```bash
spacedust createsetdb proteins1.faa proteins2.faa setDB tmpFolder
```

### 2. Enhancing with Structural Data (Optional)
To use structural comparison (Search Mode 1), you must map sequences to a structure database or use a language model.

**Mapping to AlphaFoldDB/UniProt:**
```bash
spacedust aa2foldseek setDB path/to/refFoldseekDB tmpFolder
```

**Predicting structures with ProstT5:**
```bash
# Create DB with ProstT5 embeddings first
foldseek createdb input.faa DB --prostt5-model weights
spacedust createsetdb DB setDB tmpFolder
```

### 3. Searching for Conserved Clusters
The `clustersearch` module performs the all-against-all comparison and identifies conserved neighborhoods.

**Standard Sequence Search (MMseqs2):**
```bash
spacedust clustersearch querySetDB targetSetDB result.tsv tmpFolder --search-mode 0
```

**Structural Search (Foldseek):**
```bash
spacedust clustersearch querySetDB targetSetDB result.tsv tmpFolder --search-mode 1 --foldseek-path /path/to/bin/
```

## Key Parameters and Tuning

| Parameter | Default | Description |
|-----------|---------|-------------|
| `--search-mode` | 0 | 0: Sequence (MMseqs2), 1: Structure (Foldseek), 2: Foldseek + ProstT5 |
| `--num-iterations` | 1 | Increase for sensitive iterative profile searches (PSI-BLAST style) |
| `--max-gene-gap` | 3 | Max number of intervening non-homologous genes allowed within a cluster |
| `--cluster-size` | 2 | Minimum number of homologous gene pairs required to define a cluster |
| `--filter-self-match` | N/A | Use when searching a database against itself to remove redundant hits |

## Expert Tips

- **Foldseek Integration**: If `foldseek` is not in your system PATH, ensure the binary is in the same directory as `spacedust` or explicitly provide the path using `--foldseek-path`.
- **Sensitivity vs. Speed**: For highly divergent clusters, use `--search-mode 1` with `--num-iterations 2` or higher. Structural comparison often finds conservation that sequence-only methods miss.
- **Handling Large Datasets**: Spacedust is optimized for multi-core execution. Ensure your environment has sufficient threads available, as the underlying MMseqs2/Foldseek engines will scale to use them.
- **GFF Filtering**: When using `createsetdb` with GFF files, always specify `--gff-type CDS` (or the specific feature type used in your annotation) to avoid including non-coding features in the neighborhood analysis.

## Reference documentation
- [Spacedust GitHub Repository](./references/github_com_soedinglab_spacedust.md)
- [Bioconda Spacedust Package](./references/anaconda_org_channels_bioconda_packages_spacedust_overview.md)