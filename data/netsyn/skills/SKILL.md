---
name: netsyn
description: NetSyn is a bioinformatics tool designed to identify and analyze synteny—the conservation of gene order and genomic context—across a list of target proteins.
homepage: https://github.com/labgem/netsyn
---

# netsyn

## Overview
NetSyn is a bioinformatics tool designed to identify and analyze synteny—the conservation of gene order and genomic context—across a list of target proteins. It automates the process of fetching genomic data, performing sequence similarity searches via MMseqs2, and constructing a graph of genomic neighborhoods. This skill is particularly useful for functional annotation, identifying operon-like structures, and studying the evolutionary history of specific protein families across diverse taxa.

## Basic Usage Patterns

NetSyn requires an output directory (`-o`) and one of two primary input types: a list of UniProt accessions or a custom correspondences file.

### 1. Using UniProt Accessions
The simplest entry point when you have a list of protein IDs. NetSyn will attempt to download the necessary genomic files (INSDC/GenBank) automatically.
```bash
netsyn -u protein_list.txt -o results_dir
```

### 2. Using a Correspondences File
Use this when you already have local genomic files or specific mappings between proteins and their source genomes.
```bash
netsyn -c correspondences.tab -o results_dir
```

### 3. Combined Input
You can provide both to supplement a local dataset with additional UniProt targets.
```bash
netsyn -u protein_list.txt -c correspondences.tab -o results_dir
```

## Core Parameters and Tuning

### Synteny Definition
*   **Window Size (`-ws`)**: Controls how many neighboring genes are considered. Must be an odd number (3–11). Default is 11.
*   **Synteny Gap (`-sg`)**: The maximum number of genes allowed between two homologous genes before the synteny chain is broken. Increase this for more divergent genomes. Default is 3.
*   **Score Cutoff (`-ssc`)**: The minimum score required to create an edge between two target genes in the final graph. Default is 3.

### Clustering and Sequence Identity
*   **Identity (`-id`)**: Minimum sequence identity for MMseqs2 (default 0.3).
*   **Coverage (`-cov`)**: Minimum sequence coverage for MMseqs2 (default 0.8).
*   **Clustering Method (`-cm`)**: Choose from `MCL`, `Infomap`, `Louvain`, or `WalkTrap` to group similar synteny blocks.

### Graph Reduction
To simplify complex results, you can merge nodes based on taxonomy or metadata:
*   **Taxonomy (`-gt`)**: Merge nodes in the same cluster belonging to the same rank (e.g., `genus`, `family`).
*   **Metadata (`-gl`)**: Merge nodes based on a custom label provided in a metadata file (`-md`).

## Advanced Configuration
For fine-grained control over MMseqs2 or clustering algorithms, provide a YAML configuration file.

**MMseqs2 Settings (`-mas`):**
```yaml
MMseqs advanced settings:
  MMseqs_threads: 8
  MMseqs_max-seqs: 500
  MMseqs_cluster-mode: 1
```

**Clustering Settings (`-asc`):**
```yaml
MCL advanced settings:
  MCL_inflation: 2.5
WalkTrap advanced settings:
  walktrap_step: 4
```

## Expert Tips
*   **Project Management**: Use `-np` or `--newProject` to force overwrite an existing directory if you are iterating on parameters.
*   **Data Retention**: By default, NetSyn deletes downloaded INSDC files. Use `--conserveDownloadedINSDC` if you plan to re-run the analysis or inspect the source genomes.
*   **Environment**: Ensure `mmseqs` is in your system PATH, as NetSyn relies on it for all homology searches.
*   **Input Formatting**: The UniProt list should be a simple text file with one accession per line. The correspondences file typically maps protein accessions to nucleic accessions and file paths.

## Reference documentation
- [NetSyn GitHub Repository](./references/github_com_labgem_netsyn.md)
- [Bioconda NetSyn Package](./references/anaconda_org_channels_bioconda_packages_netsyn_overview.md)