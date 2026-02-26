---
name: motulizer
description: motulizer is a microbial genomics suite for clustering genomes into taxonomic units and performing likelihood-based pangenome analysis. Use when user asks to cluster genomic assemblies into mOTUs using ANI, estimate core genomes from incomplete metagenomic data, or convert ortholog clusters from other tools for pangenome modeling.
homepage: https://github.com/moritzbuck/mOTUlizer/
---


# motulizer

## Overview

motulizer is a specialized suite of tools for microbial genomics designed to handle the inherent "noise" and incompleteness of metagenomic data. It provides a robust framework for clustering genomic assemblies into metagenomic Operational Taxonomic Units (mOTUs) using Average Nucleotide Identity (ANI) and performing pangenome analysis to identify core genes. Unlike standard pangenome tools, motulizer uses a likelihood-based approach (mOTUpan) to estimate the probability of a gene being part of the core genome while accounting for the completeness of the input genomes.

## Core Workflows

### 1. Genome Clustering (mOTUlize)
Use `mOTUlize.py` to group genomes into mOTUs. It builds a network based on high-quality genomes (MAGs) and then recruits lower-quality genomes (SUBs) to these clusters.

**Basic Clustering:**
```bash
mOTUlize.py --fnas path/to/genomes/*.fna -o clusters.tsv
```

**Advanced Clustering with Quality Control:**
If you have CheckM results, use them to distinguish between high-quality seeds and satellite bins.
```bash
mOTUlize.py --fnas *.fna --checkm checkm_results.txt --MAG-completeness 90 --MAG-contamination 5 --similarity-cutoff 95 -o refined_clusters.tsv
```

**Optimization Tip:**
Clustering large datasets is computationally expensive due to fastANI. Use `--keep-simi-file` to save the similarity matrix. This allows you to re-run the clustering with different cutoffs instantly without recomputing ANI.
```bash
# First run
mOTUlize.py --fnas *.fna --keep-simi-file similarities.txt -o output.tsv

# Subsequent runs with different cutoff
mOTUlize.py --similarities similarities.txt --similarity-cutoff 97 -o output_97.tsv
```

### 2. Pangenome & Core Genome Analysis (mOTUpan)
Use `mOTUpan.py` to determine which gene clusters are "core" to a group. It requires proteomes (.faa files) and benefits from completeness estimates.

**Basic Core Genome Estimation:**
```bash
mOTUpan.py --faas path/to/proteomes/*.faa -o pangenome_stats.tsv
```

**Refining with Bootstrapping:**
To estimate false discovery rates for core gene assignments, use the `--boots` flag.
```bash
mOTUpan.py --faas *.faa --boots 100 -o robust_pangenome.tsv
```

### 3. Format Conversion (mOTUconvert)
If you have already performed ortholog clustering with other tools, use `mOTUconvert.py` to prepare inputs for mOTUpan's likelihood model.

Supported inputs include:
- mmseqs2
- Roary
- PPanGGOLiN
- eggNOG-mapper
- anvi'o pangenome databases

```bash
mOTUconvert.py --mmseqs mmseqs_results.tsv -o motupan_input.json
```

## Expert Tips & Best Practices

- **The 95% Rule**: By default, `mOTUlize.py` uses a 95% ANI cutoff. This is the widely accepted "gold standard" for circumscribing microbial species. Only adjust this if you have specific biological reasons (e.g., focusing on sub-species strains).
- **MAGs vs. SUBs**: Always provide completeness/contamination data if available. `mOTUlize` uses "MAGs" as the stable nodes to build the network and "SUBs" as satellite genomes that get recruited. This prevents low-quality, fragmented genomes from creating spurious links between distinct species clusters.
- **Similarity Matrix Format**: If providing a custom similarity file via `--similarities`, ensure it is a tab-separated file where the first two columns are genome names and the third is a similarity value (0-100).
- **Anvi'o Integration**: For users in the anvi'o ecosystem, use `anvi-run-motupan.py` to run the motulizer logic directly on an anvi'o pangenome database.

## Reference documentation
- [mOTUlizer GitHub Repository](./references/github_com_moritzbuck_mOTUlizer.md)
- [Bioconda motulizer Overview](./references/anaconda_org_channels_bioconda_packages_motulizer_overview.md)