---
name: isonclust3
description: isONclust3 clusters long transcript reads into gene-family groups without requiring a reference genome. Use when user asks to cluster Oxford Nanopore or PacBio reads, group transcript sequences by gene family, or partition large transcriptomic datasets into gene-specific subsets.
homepage: https://github.com/aljpetri/isONclust3
metadata:
  docker_image: "quay.io/biocontainers/isonclust3:0.3.0--h4349ce8_0"
---

# isonclust3

## Overview
isONclust3 is a high-performance Rust implementation for clustering long transcript reads. It groups reads that originate from the same gene family into distinct clusters without requiring a reference genome. This tool is essential for partitioning large datasets into manageable, gene-specific subsets, providing both a cluster assignment table and individual FASTQ files for every generated cluster.

## Installation
The most efficient way to install isONclust3 is via Bioconda:
```bash
conda install bioconda::isonclust3
```
Alternatively, if a Rust environment is available:
```bash
cargo install isONclust3
```

## Common CLI Patterns

### Oxford Nanopore (ONT) Reads
For ONT data, use the `ont` mode which automatically optimizes k-mer size (k=13) and window size (w=21) for higher error rates.
```bash
isONclust3 --fastq input.fastq --mode ont --outfolder output_dir --post-cluster
```

### PacBio Iso-Seq Reads
For PacBio data, use the `pacbio` mode (k=15, w=51) to account for the different error profile and higher accuracy.
```bash
isONclust3 --fastq input.fastq --mode pacbio --outfolder output_dir --post-cluster
```

### Manual Parameter Tuning
If the presets are insufficient, you can manually define the minimizer parameters:
```bash
isONclust3 --fastq input.fastq --k 14 --w 30 --outfolder output_dir --seeding minimizer
```

## Expert Tips and Best Practices

*   **Post-Clustering:** Always include the `--post-cluster` flag for production runs. This step refines the initial clusters and significantly improves the quality of the gene-family groupings.
*   **Output Structure:** 
    *   `final_clusters.tsv`: A two-column file (Cluster ID, Read Accession). Use this for lightweight downstream filtering.
    *   `fastq_files/`: A directory containing one FASTQ file per cluster. Ensure you have adequate disk space, as this effectively duplicates the input data size across the cluster files.
*   **Memory and Performance:** isONclust3 is written in Rust and is highly efficient. However, for extremely large datasets, ensure the `--outfolder` is located on a high-speed I/O drive to handle the creation of thousands of individual FASTQ files.
*   **Seeding Strategy:** Use `--seeding minimizer` to ensure the tool uses the most robust algorithm for identifying shared sequences between reads.

## Reference documentation
- [isONclust3 GitHub Repository](./references/github_com_aljpetri_isONclust3.md)
- [isONclust3 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_isonclust3_overview.md)