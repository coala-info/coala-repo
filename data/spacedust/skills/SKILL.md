---
name: spacedust
description: Spacedust discovers and identifies conserved gene clusters and homologous gene neighborhoods across multiple microbial genomes using sequence or structural homology. Use when user asks to analyze microbial genomes for conserved synteny, identify homologous gene blocks, or perform large-scale comparative genomics using MMseqs2 or Foldseek.
homepage: https://github.com/soedinglab/spacedust
metadata:
  docker_image: "quay.io/biocontainers/spacedust:2.e56c505--hd6d6fdc_0"
---

# spacedust

thinkname: spacedust
description: Discovery and identification of conserved gene clusters across multiple genomes. Use this skill when you need to analyze microbial genomes for homologous gene neighborhoods, identify conserved synteny, or perform large-scale comparative genomics using sequence (MMseqs2) or structural (Foldseek) homology.

## Overview

Spacedust is a specialized toolkit designed to find "gene blocks" or clusters that are preserved across different organisms. Unlike simple homology searches that look at individual genes, Spacedust identifies groups of genes that stay together in the same neighborhood across multiple genomes. It leverages MMseqs2 for fast sequence comparison and Foldseek for structure-based comparison, making it highly effective for discovering functionally related gene clusters even when sequence identity is low.

## Core Workflow

### 1. Database Creation
Before searching, you must convert your genomic data into a Spacedust `setDB`.

**From Nucleotide FASTA + GFF3:**
Use this for prokaryotic genomes where you have contigs and coordinate annotations.
```bash
# Create a list of GFF files
ls *.gff3 > gff_list.txt

# Initialize the database
spacedust createsetdb genome1.fna [genome2.fna ...] setDB tmp --gff-dir gff_list.txt --gff-type CDS
```

**From Protein FASTA (Prodigal format):**
If your protein headers already contain genomic coordinates (standard Prodigal output), you can skip the GFF requirement.
```bash
spacedust createsetdb proteins.faa setDB tmp
```

### 2. Searching for Conserved Clusters
The `clustersearch` module is the primary engine for identifying conserved neighborhoods.

**Basic Sequence Search:**
```bash
spacedust clustersearch querySetDB targetSetDB resultDB tmp
```

**Structural Homology Search (High Sensitivity):**
Use this when looking for distantly related clusters where sequence identity is low but structure is conserved. Requires Foldseek.
```bash
spacedust clustersearch querySetDB targetSetDB resultDB tmp --search-mode 1 --foldseek-path /path/to/foldseek
```

## Expert Tips and Parameters

### Tuning Cluster Detection
*   **`--cluster-size`**: Default is 2. Increase this (e.g., 3 or 4) to reduce noise and find larger, more robust operons or biosynthetic gene clusters (BGCs).
*   **`--max-gene-gap`**: Default is 3. If your genomes are highly fragmented or have frequent insertions, increase this to allow Spacedust to "jump" over non-conserved genes within a cluster.
*   **`--num-iterations`**: For sensitive profile-based searches (similar to PSI-BLAST), set this to 2 or 3.

### Search Modes
| Mode | Engine | Best Use Case |
| :--- | :--- | :--- |
| `0` | MMseqs2 | Fast, standard sequence-based conservation. |
| `1` | Foldseek | Detecting remote homologs via 3D structure. |
| `2` | Foldseek + ProstT5 | Maximum sensitivity using protein language models. |

### Self-Match Filtering
When searching a database against itself to find internal duplications or paralogous clusters, use `--filter-self-match` to remove trivial hits between identical genomic locations.



## Subcommands

| Command | Description |
|---------|-------------|
| spacedust aa2foldseek | By Ruoshi Zhang <ruoshi.zhang@mpinat.mpg.de> & Milot Mirdita <milot@mirdita.de> |
| spacedust clusterdb | By Ruoshi Zhang <ruoshi.zhang@mpinat.mpg.de> & Milot Mirdita <milot@mirdita.de> |
| spacedust clustersearch | By Ruoshi Zhang <ruoshi.zhang@mpinat.mpg.de> & Milot Mirdita <milot@mirdita.de> |
| spacedust_createsetdb | Creates a database for spacedust. |

## Reference documentation
- [Spacedust GitHub README](./references/github_com_soedinglab_spacedust_blob_master_README.md)
- [Spacedust Main Repository Overview](./references/github_com_soedinglab_spacedust.md)