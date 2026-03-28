---
name: vcontact3
description: vContact3 is a computational tool used for the systematic classification and clustering of viral sequences into genus-level taxonomic groups using protein-sharing networks. Use when user asks to classify viral genomes, cluster viral sequences into viral clusters, or generate protein-sharing networks for viral taxonomic analysis.
homepage: https://bitbucket.org/MAVERICLab/vcontact3
---


# vcontact3

## Overview
vContact3 is a computational tool used for the systematic classification of viral sequences. It builds upon previous iterations by using protein-sharing networks to cluster viral genomes into viral clusters (VCs), which roughly correspond to genus-level taxonomic groups. This skill provides the necessary command-line patterns to process viral protein sequences, calculate similarity scores, and generate network files compatible with visualization software like Cytoscape.

## Core Workflow
The standard vContact3 pipeline involves three primary stages: database preparation, protein similarity calculation, and network clustering.

### 1. Database Preparation
Before running an analysis, ensure you have the reference database (typically RefSeq or a custom database) indexed.
- Use `vcontact3-index` to prepare reference genomes.
- Ensure input files are in FASTA format (proteins) with a corresponding mapping file (CSV/TSV) linking proteins to their parent contigs.

### 2. Running the Pipeline
The main execution is handled via the `vcontact3` command. 

**Basic Clustering Command:**
```bash
vcontact3 --input_genes <genes.faa> --input_proteins <protein_map.csv> --db <database_path> --outdir <output_directory>
```

**Key Arguments:**
- `--input_genes`: FASTA file containing the protein sequences of the viral contigs.
- `--input_proteins`: A CSV file mapping protein IDs to genome/contig IDs.
- `--db`: Path to the vContact3 reference database.
- `--pcs-mode`: Defines how Protein Clusters (PCs) are generated (e.g., using Diamond or MMseqs2).
- `--threads`: Number of CPU cores to allocate.

### 3. Network Analysis and Output
vContact3 generates several output files in the specified directory:
- `genome_cluster.csv`: Contains the assignment of each input contig to a Viral Cluster (VC).
- `network.ntw`: An edge list representing the similarity network between genomes.
- `protein_clusters.csv`: The membership of proteins within specific PCs.

## Expert Tips
- **Contig Length**: For reliable clustering, it is recommended to use contigs longer than 10kb or those containing at least 5-10 proteins.
- **Custom Databases**: You can supplement the default RefSeq database with your own high-quality genomes to improve classification resolution in specific ecological niches.
- **Memory Management**: For large metagenomic datasets, use the `--low-memory` flag if available or increase the memory allocation for the Diamond/MMseqs2 alignment step.



## Subcommands

| Command | Description |
|---------|-------------|
| prepare_databases | Prepare vContact2 databases |
| run | vcontact3 run |

## Reference documentation
- [vContact3 Bitbucket Repository](./references/bitbucket_org_MAVERICLab_vcontact3.md)
- [vContact3 Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_vcontact3_overview.md)