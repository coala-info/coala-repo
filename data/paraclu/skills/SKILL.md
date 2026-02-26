---
name: paraclu
description: Paraclu identifies clusters of signal in genomic sequence data by finding regions that are maximal with respect to density. Use when user asks to find transcription start site clusters, identify peaks in CAGE data, or find stable clusters in functional genomics assays.
homepage: http://cbrc3.cbrc.jp/~martin/paraclu/
---


# paraclu

## Overview

Paraclu is a tool for finding clusters in data mapped to genomic sequences. Unlike simple threshold-based peak callers, it identifies clusters that are maximal with respect to a density parameter. This makes it particularly effective for identifying transcription start site (TSS) clusters in CAGE data or localized enrichment in other functional genomics assays. It excels at handling nested clusters and providing a "stability" metric for each identified peak.

## Usage Patterns

### Basic Clustering
The core utility of paraclu is processing a simplified, sorted text file containing genomic coordinates and signal counts.

```bash
paraclu [min_count] [input_file] > [output_clusters]
```

- **min_count**: The minimum total signal required to form a cluster.
- **input_file**: A tab-separated file with four columns: `chromosome`, `strand` (+ or -), `position`, and `count`.

### Data Preparation
Paraclu requires the input to be strictly sorted by chromosome, then strand, then position.
```bash
sort -k1,1 -k2,2 -k3,3n input.txt > input_sorted.txt
```

### Identifying Stable Clusters
Paraclu outputs many overlapping clusters at different density scales. To find the most "robust" clusters, use the `paraclu-cut.sh` utility (often included in the suite) or filter by the stability score (the ratio of the maximum density to the minimum density).

```bash
# Typical workflow: Cluster -> Filter for stability
paraclu 10 sorted_data.txt > all_clusters.txt
paraclu-cut.sh all_clusters.txt > stable_clusters.txt
```

## Expert Tips

- **Density Parameter**: Paraclu calculates a value $d$ for each cluster. A cluster is kept if it is the densest possible grouping for that region.
- **Resolution**: Because paraclu is multi-resolution, it will output nested clusters. If you need a single set of non-overlapping peaks, always use the `paraclu-cut` script or a custom script to select the largest stable cluster in a hierarchy.
- **Memory Efficiency**: Paraclu processes data one chromosome/strand at a time. If working with extremely large datasets, ensure the input is properly sorted to minimize memory overhead.

## Reference documentation

- [Paraclu Overview](./references/anaconda_org_channels_bioconda_packages_paraclu_overview.md)