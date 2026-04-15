---
name: galah
description: Galah is a high-performance tool for the dereplication and clustering of microbial genomes based on genetic similarity. Use when user asks to dereplicate genomes, cluster Metagenome Assembled Genomes, or select high-quality representative genomes from a dataset.
homepage: https://github.com/wwood/galah
metadata:
  docker_image: "quay.io/biocontainers/galah:0.4.2--hc1c3326_2"
---

# galah

## Overview

Galah is a high-performance tool designed for the dereplication of microbial genomes. It addresses the challenge of managing large sets of Metagenome Assembled Genomes (MAGs) by clustering them into groups based on their genetic similarity (ANI) and selecting the highest-quality genome from each cluster to serve as a representative. It utilizes a greedy clustering algorithm that is significantly faster than traditional methods, especially when dealing with highly similar genomes (e.g., >95% ANI).

## Core Workflows

### Genome Dereplication
The primary use case for galah is clustering a set of FASTA files to find unique representatives.

```bash
galah cluster --genome-fasta-files /path/to/*.fna --output-cluster-definition clusters.tsv
```

### Quality-Based Selection
Galah can use genome quality metrics to ensure the "best" genome is chosen as the cluster representative. It uses a scoring formula: `completeness - 5*contamination - 5*(num_contigs/100) - 5*(num_ambiguous_bases/100000)`.

To use this, provide a quality file (typically from CheckM):
```bash
galah cluster --genome-fasta-files *.fna --checkm-tab-table quality.tsv --output-cluster-definition clusters.tsv
```

### Contig Clustering
For smaller genomic fragments or contig-level dereplication:
```bash
galah cluster --cluster-contigs --small-genomes --genome-fasta-files contigs.fna --output-cluster-definition clusters.tsv
```

## Expert Tips and Best Practices

- **ANI Thresholds**: By default, galah uses a 95% ANI pre-clustering threshold (using finch or skani) and a 99% ANI final clustering threshold. You can adjust these to be more or less stringent depending on your definition of a "species" or "strain."
- **Dependencies**: Ensure `skani` (v0.2.2+) or `FastANI` (v1.34+) are in your PATH, as galah relies on these for calculating identity between genome pairs.
- **Memory Management**: For very large datasets, use the `--low-memory` flag (available in recent versions) to reduce the RAM footprint during the clustering process.
- **Greedy Approach**: Remember that galah's greedy algorithm selects representatives based on quality first. If no quality information is provided, it defaults to the order in which genomes were provided in the command line.
- **Output Interpretation**: The `clusters.tsv` file provides a mapping of every input genome to its assigned representative, allowing you to easily filter your dataset for downstream analysis.



## Subcommands

| Command | Description |
|---------|-------------|
| galah cluster | Cluster (dereplicate) genomes |
| galah cluster-validate | Verify clustering results |

## Reference documentation
- [Galah GitHub Repository](./references/github_com_wwood_galah.md)
- [Galah README](./references/github_com_wwood_galah_blob_main_README.md)