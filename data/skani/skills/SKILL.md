---
name: skani
description: skani is a high-performance genomic distance estimator designed to calculate ANI and Aligned Fraction (AF) for sequences with >80% identity.
homepage: https://github.com/bluenote-1577/skani
---

# skani

## Overview

skani is a high-performance genomic distance estimator designed to calculate ANI and Aligned Fraction (AF) for sequences with >80% identity. It utilizes an approximate mapping method that provides the speed of sketching tools (like Mash) with accuracy approaching alignment-based methods (like FastANI). It is specifically optimized for metagenomic applications, providing robust results even for incomplete genomes.

## Core Workflows

### Direct Comparison (dist)
Use `dist` for one-to-one or many-to-many comparisons without pre-indexing.

```bash
# Compare two specific genomes
skani dist genome1.fa genome2.fa

# Compare multiple queries against multiple references using 8 threads
skani dist -t 8 -q query1.fa query2.fa -r ref1.fa ref2.fa -o results.txt

# Compare individual contigs within files (treats each record as a separate entity)
skani dist --qi -q assembly1.fa --ri -r assembly2.fa
```

### Database Search (sketch & search)
For large-scale comparisons or repeated queries, first create a database.

```bash
# Construct a database from a folder of genomes
skani sketch genomes_folder/* -o my_database

# Search queries against the database
skani search query1.fa query2.fa -d my_database -o search_results.txt
```

### All-to-All Matrix (triangle)
Use `triangle` to generate distance matrices for clustering or phylogenomic analysis.

```bash
# Generate a lower-triangular ANI matrix
skani triangle genome_folder/* > ani_matrix.txt

# Generate an edge list (useful for network-based clustering)
skani triangle genome_folder/* -E > ani_edge_list.txt
```

## Expert Tips and Best Practices

- **ANI Thresholds**: By default, skani only outputs results where the Aligned Fraction is >15%, which typically corresponds to ~82% ANI. For lower ANI comparisons, consult advanced parameters in the documentation.
- **MAG Accuracy**: Unlike Mash, skani is robust against genome incompleteness. It is the preferred tool for comparing medium-quality MAGs.
- **Memory Management**: In version 0.3+, `skani sketch` creates a single database file by default. Use `--separate-sketches` only if you need the legacy behavior of individual `.sketch` files.
- **Thread Scaling**: skani scales well with threads (`-t`). For large database searches, increasing threads significantly reduces runtime with a modest memory footprint (~6GB RAM for 65k prokaryotic genomes).
- **Symmetry**: ANI calculations in skani are symmetric; the order of `genome1` and `genome2` does not significantly impact the ANI value.

## Reference documentation
- [skani GitHub Repository](./references/github_com_bluenote-1577_skani.md)
- [skani Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_skani_overview.md)