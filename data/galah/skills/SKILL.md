---
name: galah
description: Galah is a high-performance tool designed to de-duplicate and cluster microbial genomes.
homepage: https://github.com/wwood/galah
---

# galah

## Overview
Galah is a high-performance tool designed to de-duplicate and cluster microbial genomes. Unlike traditional methods that can struggle with scale, Galah uses a greedy clustering algorithm that is optimized for datasets with many closely related genomes (typically >95% ANI). It operates in two stages: a fast pre-clustering step to identify potential matches, followed by a precise ANI calculation to define final clusters. By default, it prioritizes genome quality (completeness and contamination) when selecting the representative for each cluster.

## Core Workflows

### Standard Genome Dereplication
To cluster a set of genomes at the default 99% ANI:
```bash
galah cluster --genome-fasta-files /path/to/*.fna --output-cluster-definition clusters.tsv
```

### Contig-Level Clustering
For clustering individual contigs or very small genomic fragments:
```bash
galah cluster --cluster-contigs --small-genomes --genome-fasta-files contigs.fna --output-cluster-definition clusters.tsv
```

### Quality-Aware Selection
Galah automatically calculates a quality score to pick the best representative. The formula used is:
`completeness - 5*contamination - 5*(num_contigs/100) - 5*(num_ambiguous_bases/100000)`

To utilize this, ensure you provide genome quality information (e.g., from CheckM or CheckM2) if the specific subcommand supports it, otherwise, Galah defaults to the order of files provided.

## Expert Tips and Best Practices

- **Pre-clustering Thresholds**: By default, Galah uses a 95% ANI pre-cluster threshold and a 99% final threshold. If your target ANI is lower (e.g., 95%), you must lower the pre-cluster threshold accordingly to avoid missing potential matches.
- **Scalability**: Galah is significantly faster than dRep when dealing with highly redundant datasets. Use it as a primary filter before more computationally expensive downstream analyses.
- **Dependencies**: Ensure `skani` (v0.2.2+) or `FastANI` (v1.34) are in your PATH, as Galah relies on these external tools for the heavy lifting of nucleotide identity calculations.
- **Full Documentation**: For a complete list of arguments including ANI cutoffs and thread management, use:
```bash
galah cluster --full-help
```

## Reference documentation
- [GitHub README](./references/github_com_wwood_galah.md)
- [Anaconda Package Overview](./references/anaconda_org_channels_bioconda_packages_galah_overview.md)