---
name: anvio
description: Anvi’o is an advanced analysis and visualization platform for integrating and exploring microbial 'omics data. Use when user asks to generate contigs databases, profile mapping results, perform pangenomic analysis, or interactively refine metagenome-assembled genomes.
homepage: http://merenlab.org/software/anvio/
metadata:
  docker_image: "quay.io/biocontainers/anvio:7--hdfd78af_1"
---

# anvio

## Overview
anvi'o is an advanced analysis and visualization platform designed for microbial 'omics. It excels at integrating diverse data types—such as metagenomes, metatranscriptomes, and pangenomes—into a unified environment. Use this skill to guide the construction of contigs databases, the profiling of mapping results, and the interactive refinement of metagenome-assembled genomes (MAGs).

## Core Workflow Patterns

### 1. Metagenomic Assembly Processing
To begin an analysis, you must convert a FASTA file into an anvi'o contigs database.
- **Generate Contigs DB**: `anvi-gen-contigs-database -f contigs.fa -o contigs.db -n "Project Name"`
- **Run HMMs**: Identify single-copy core genes to estimate completion/redundancy.
  `anvi-run-hmms -c contigs.db`
- **Setup NCBI COGs**: Annotate genes with functional categories.
  `anvi-setup-ncbi-cogs`
  `anvi-run-ncbi-cogs -c contigs.db`

### 2. Profiling and Merging
After mapping reads to contigs, process the BAM files to calculate coverage and variation.
- **Profile a BAM file**: `anvi-profile -i sample.bam -c contigs.db -o PROFILE_DIR`
- **Merge Profiles**: Combine multiple samples into a single merged profile for comparative analysis.
  `anvi-merge PROFILE_1/PROFILE.db PROFILE_2/PROFILE.db -c contigs.db -o MERGED_PROFILE`

### 3. Pangenomics
Analyze the genetic diversity across multiple genomes or MAGs.
- **Generate Genomes Storage**: `anvi-gen-genomes-storage -e external-genomes.txt -o GENOMES.db`
- **Compute Pangenome**: `anvi-pan-genome -g GENOMES.db -n "Project_Pan" --mcl-inflation 2`
- **Display Pangenome**: `anvi-display-pan -g GENOMES.db -p Project_Pan/PAN.db`

### 4. Interactive Visualization and Refinement
anvi'o provides a powerful interface for manual binning and data exploration.
- **Launch Interactive Interface**: `anvi-interactive -p MERGED_PROFILE/PROFILE.db -c contigs.db`
- **Refine a Specific Bin**: `anvi-refine -p MERGED_PROFILE/PROFILE.db -c contigs.db -b bin_name`

## Expert Tips
- **Database Integrity**: Always run `anvi-migrate` on older `.db` files if you have updated your anvi'o version.
- **Resource Management**: For large pangenomes, use the `--num-threads` flag in `anvi-pan-genome` to speed up the BLAST/Diamond step.
- **Filtering**: Use `anvi-export-splits-and-coverages` to extract specific data for downstream custom R or Python scripts.

## Reference documentation
- [anvi'o Software Home](./references/merenlab_org_software_anvio.md)
- [Bioconda anvi'o Package Overview](./references/anaconda_org_channels_bioconda_packages_anvio_overview.md)