---
name: humann2
description: HUMAnN2 (HMP Unified Metabolic Analysis Network 2) is a pipeline for efficiently and accurately profiling the presence and abundance of microbial pathways in a community.
homepage: http://huttenhower.sph.harvard.edu/humann2
---

# humann2

## Overview
HUMAnN2 (HMP Unified Metabolic Analysis Network 2) is a pipeline for efficiently and accurately profiling the presence and abundance of microbial pathways in a community. It works by mapping reads to species-specific pangenomes when possible, and falling back to translated search against a protein database for unclassified reads. This skill provides the necessary CLI patterns to execute the tiered functional profiling workflow, normalize results, and join multiple samples for comparative analysis.

## Core Workflow and CLI Patterns

### 1. Functional Profiling
The primary command processes a single sample. It requires a quality-controlled metagenome (FastQ) or an alignment file.

```bash
# Basic functional profiling from FastQ
humann2 --input sample.fastq --output output_dir

# Profiling from an existing alignment (faster if already mapped)
humann2 --input sample.sam --output output_dir
```

### 2. Normalizing Abundances
HUMAnN2 outputs are in "RPKs" (Reads Per Kilobase) by default. To compare across samples, normalize to relative abundance or copies per million (CPM).

```bash
# Normalize gene families to relative abundance
humann2_renorm_table --input genes.tsv --output genes_relab.tsv --units relab

# Normalize to Copies Per Million (CPM)
humann2_renorm_table --input pathways.tsv --output pathways_cpm.tsv --units cpm
```

### 3. Joining and Regrouping Tables
When processing multiple samples, use these utilities to create a single feature table and map IDs to different functional categories (e.g., mapping UniRef50 to GO terms).

```bash
# Merge multiple sample outputs into one table
humann2_join_tables --input output_dir --output joined_pathways.tsv

# Regroup gene families into higher-level categories (e.g., EggNOG, GO)
humann2_regroup_table --input genes.tsv --groups uniref50_eggnog --output genes_eggnog.tsv
```

## Expert Tips
- **Database Selection**: Ensure the `--nucleotide-db` (ChocoPhlAn) and `--protein-db` (UniRef) paths are correctly set if not in the default location.
- **Bypass Nucleotide Search**: If you know the species are not in the pangenome database, use `--bypass-nucleotide-index` to save time, though this increases the computational load on the translated search.
- **Thread Optimization**: Use `--threads` to scale performance, but monitor memory usage during the translated search phase (Diamond/Rapsearch2).
- **Tiered Mapping**: Remember that HUMAnN2 first attempts a fast nucleotide mapping; only unmapped reads proceed to the slower translated search.

## Reference documentation
- [humann2 - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_humann2_overview.md)