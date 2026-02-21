---
name: vcontact2
description: vcontact2 (Viral Contig Automatic Clustering and Taxonomy) is a computational tool designed to classify viral sequences by analyzing their protein content.
homepage: https://bitbucket.org/MAVERICLab/vcontact2
---

# vcontact2

## Overview

vcontact2 (Viral Contig Automatic Clustering and Taxonomy) is a computational tool designed to classify viral sequences by analyzing their protein content. It constructs a protein-sharing network where nodes represent genomes (contigs) and edges represent the significance of shared protein clusters. By applying network clustering algorithms, it groups sequences into Viral Clusters (VCs) that approximately correspond to genus-level taxonomy. This tool is essential for characterizing the "viral dark matter" in metagenomic samples and providing taxonomic context to unknown viral fragments.

## Installation

Install vcontact2 via Bioconda:
```bash
conda install -c bioconda vcontact2
```

## Core Workflow and CLI Usage

### 1. Data Preparation
vcontact2 requires two primary input files:
- **Protein FASTA**: A file containing all protein sequences predicted from your contigs.
- **Gene-to-Genome Mapping**: A CSV file (no header) mapping each protein ID to its parent contig ID.
  - Format: `protein_id,contig_id,keywords` (keywords are optional).

### 2. Standard Execution
Run the basic clustering pipeline using Diamond for protein alignment (recommended for speed):
```bash
vcontact2 -i <input_protein_fasta> --rel-mode Diamond --db <database_name> --vcs-mode ClusterOne
```

### 3. Key Parameters and Optimization
- **--rel-mode**: Choose between `Diamond` (fast) or `Blast` (sensitive but slow). Use Diamond for large metagenomic datasets.
- **--db**: Specify the reference database (e.g., `RefSeq-V85`, `ProkaryoticVirusesV85`).
- **--vcs-mode**: Defines the clustering algorithm. `ClusterOne` is the default and generally more robust for overlapping clusters; `CCL` (Connected Components) is an alternative for distinct groupings.
- **--pcs-mode**: Method for protein clustering. `MCL` is the standard.
- **--threads**: Increase the number of CPU cores to speed up the alignment and clustering phases.

### 4. Output Interpretation
The tool generates several files in the output directory:
- **genome_cluster_clusters.csv**: Contains the final assignment of contigs to Viral Clusters (VCs).
- **c1.ntw**: The network file (nodes and edges) which can be imported into Cytoscape for visualization.
- **vcontact_stats.csv**: Summary statistics of the clustering run.

## Expert Tips and Best Practices

- **Header Consistency**: Ensure that the protein IDs in your FASTA file match the IDs in your gene-to-genome mapping file exactly. Discrepancies will cause the tool to ignore those sequences.
- **Reference Integration**: Always include reference genomes (e.g., from RefSeq) in your run to provide taxonomic anchors for your environmental contigs.
- **Memory Management**: For very large datasets (>50,000 contigs), vcontact2 can be memory-intensive during the network construction phase. Ensure your environment has sufficient RAM or subset your data if necessary.
- **Visualization**: Use the `.ntw` output files to visualize the protein-sharing network in Cytoscape. This helps identify "singleton" contigs that do not cluster with any known viruses.
- **Sensitivity**: If your contigs are short or have few predicted genes, consider lowering the significance thresholds, though this may increase the false-positive clustering rate.

## Reference documentation
- [Anaconda Overview](./references/anaconda_org_channels_bioconda_packages_vcontact2_overview.md)
- [Bitbucket Documentation](./references/bitbucket_org_MAVERICLab_vcontact2.md)