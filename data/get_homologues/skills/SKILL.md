---
name: get_homologues
description: The `get_homologues` suite is a versatile toolkit designed for comparative genomics.
homepage: https://github.com/eead-csic-compbio/get_homologues
---

# get_homologues

## Overview
The `get_homologues` suite is a versatile toolkit designed for comparative genomics. It specializes in clustering protein or nucleotide sequences into homologous groups using various algorithms (BDBH, COGtriangles, and OrthoMCL). It is particularly effective for defining the "core" genome (genes shared by all taxa) and the "pan" genome (the entire set of genes within a group). Use `get_homologues.pl` for bacterial protein-coding sequences and `get_homologues-est.pl` for eukaryotic or intra-specific transcriptomes and CDS.

## Common CLI Patterns

### Basic Clustering
The most common entry point is running the main script on a directory containing GenBank (.gbk) or FASTA files.

```bash
# Cluster bacterial genomes using the BDBH algorithm (default)
get_homologues.pl -d directory_with_gbk_files

# Cluster using COGtriangles (-G) and OrthoMCL (-M) for more robust results
get_homologues.pl -d directory_with_gbk_files -G -M

# For plant or eukaryotic transcriptomes, use the EST version
get_homologues-est.pl -d directory_with_fasta_files
```

### Pan-Genome and Core-Genome Definition
After clustering, use `compare_clusters.pl` to find the intersection (core) or union (pan) of different algorithm results or different sets of genomes.

```bash
# Create a pangenome matrix from clusters
compare_clusters.pl -d cluster_directory1,cluster_directory2 -o output_directory -m
```

### Matrix and Plotting
Generate matrices for downstream statistical analysis or visualization.

```bash
# Parse a pangenome matrix to get a presence/absence table
parse_pangenome_matrix.pl -m pangenome_matrix.tab

# Plot pan-genome and core-genome growth curves
plot_pancore_matrix.pl -i pangenome_matrix.tab -f 10
```

## Expert Tips and Best Practices

- **Input Quality**: For `get_homologues.pl`, GenBank files are preferred over FASTA because they contain coordinates and locus tags, which are essential for identifying gene synteny and producing better annotations.
- **Algorithm Selection**: 
    - **BDBH (Bidirectional Best Hits)**: Fastest, best for very closely related strains.
    - **COGtriangles**: Good balance of speed and sensitivity for genus-level analysis.
    - **OrthoMCL**: Most sensitive, recommended for divergent species, but computationally intensive.
- **Consensus Clusters**: It is a best practice to run all three algorithms (`-M -G`) and then use `compare_clusters.pl` to identify the "consensus" core genome (clusters found by all methods).
- **Reference Genomes**: Use the `-r` flag to specify a reference genome. This anchors the clustering process and is useful when comparing several isolates to a well-annotated type strain.
- **Parallelization**: Use the `-n` flag to specify the number of CPU cores to speed up the BLAST/DIAMOND all-against-all search phase.

## Reference documentation
- [GET_HOMOLOGUES: a versatile software package for pan-genome analysis](./references/github_com_eead-csic-compbio_get_homologues.md)
- [get_homologues - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_get_homologues_overview.md)