---
name: skani
description: skani calculates Average Nucleotide Identity and Aligned Fraction between DNA sequences using a fast, approximate mapping method. Use when user asks to compare genomes for evolutionary relatedness, search query genomes against large databases, or generate distance matrices for strain-level clustering.
homepage: https://github.com/bluenote-1577/skani
metadata:
  docker_image: "quay.io/biocontainers/skani:0.3.1--ha6fb395_0"
---

# skani

## Overview

`skani` is a high-performance tool designed for calculating Average Nucleotide Identity (ANI) and Aligned Fraction (AF) between DNA sequences. It uses an approximate mapping method that is significantly faster than BLAST-based tools while maintaining high accuracy, especially for incomplete or medium-quality metagenome-assembled genomes (MAGs). 

Use this skill when you need to:
- Compare two or more genomes to determine evolutionary relatedness.
- Search query genomes against massive databases (e.g., GTDB) in seconds.
- Generate distance matrices or edge lists for strain-level clustering.
- Analyze metagenomic contigs to identify conserved elements.

Note: `skani` is optimized for sequences with >80% ANI. For highly divergent sequences (<80% ANI), consider alternative phylogenetic methods.

## Core Workflows

### 1. Direct Genome Comparison
To compare a small number of genomes directly without pre-indexing:

```bash
# Compare two genomes
skani dist genome1.fa genome2.fa

# Compare multiple queries against multiple references using 8 threads
skani dist -t 8 -q queries/*.fa -r refs/*.fa -o results.txt
```

### 2. Database Sketching and Searching
For large-scale searches (e.g., searching against 50,000+ genomes), use the two-step sketch/search workflow to save time and memory.

```bash
# Step 1: Create a searchable database
skani sketch genomes_folder/* -o my_database

# Step 2: Search queries against the database
skani search query.fa -d my_database -o search_results.tsv
```

### 3. All-to-All Comparisons (Clustering)
Use `triangle` to generate data for heatmaps or clustering.

```bash
# Generate a lower-triangular ANI matrix
skani triangle folder/*.fa > matrix.txt

# Generate an edge list (useful for network analysis/Cytoscape)
skani triangle folder/*.fa -E > edge_list.txt
```

## Expert Tips and Best Practices

- **Contig-Level Analysis**: By default, `skani` treats each file as a single genome. If your file contains multiple independent contigs (e.g., a metagenomic assembly) and you want to search them individually, use the `--qi` (query individual) or `--ri` (reference individual) flags.
  ```bash
  skani search --qi assembly.fasta -d gtdb_database -o results.txt
  ```
- **Memory Efficiency**: In version 0.3+, `skani` uses a single database file by default. If you are working with extremely large datasets and encounter memory issues, ensure you are using the `search` command with a pre-sketched database rather than `dist`.
- **Filtering Results**: `skani` filters out results with an Aligned Fraction (AF) < 15% by default. If you expect low-identity matches, you may need to adjust sensitivity parameters (see Advanced Usage).
- **Symmetry**: Unlike some ANI tools, `skani` calculations are symmetric; the order of query and reference does not significantly affect the ANI score.
- **Thread Scaling**: `skani` scales well with threads (`-t`). For large database searches, increasing threads is the most effective way to reduce wall-clock time.



## Subcommands

| Command | Description |
|---------|-------------|
| skani | skani |
| skani dist | Compute ANI for queries against references fasta files or pre-computed sketch files. |
| skani search | Search queries against a large pre-sketched database of reference genomes in a memory efficient manner. |

## Reference documentation
- [skani basic usage guide](./references/github_com_bluenote-1577_skani_wiki_skani-basic-usage-guide.md)
- [skani cookbook](./references/github_com_bluenote-1577_skani_wiki_skani-cookbook.md)
- [Tutorial: strain and species level clustering](./references/github_com_bluenote-1577_skani_wiki_Tutorial_-strain-and-species-level-clustering-of-MAGs-with-skani-triangle.md)
- [Pre-sketched databases](./references/github_com_bluenote-1577_skani_wiki_Pre_E2_80_90sketched-databases.md)