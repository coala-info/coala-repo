---
name: metaphlan
description: "MetaPhlAn profiles the taxonomic composition of microbial communities from shotgun metagenomic data by mapping reads to clade-specific marker genes. Use when user asks to profile taxonomic abundances, generate species-level compositions from FastQ files, or merge multiple metagenomic profiles into a single table."
homepage: https://github.com/biobakery/metaphlan
---

# metaphlan

## Overview

MetaPhlAn (Metagenomic Phylogenetic Analysis) is a computational tool designed to profile the composition of microbial communities (bacteria, archaea, eukaryotes, and viruses) from shotgun metagenomic data. It works by mapping reads against a pre-computed database of clade-specific marker genes, allowing for unambiguous taxonomic assignment and accurate estimation of relative abundances at the species level or higher. Use this skill to execute profiling workflows, handle intermediate alignment files, and aggregate results across multiple samples.

## Installation and Database Management

Install MetaPhlAn via Bioconda to ensure all dependencies (like Bowtie2) are correctly configured.

```bash
# Install via conda
conda install -c bioconda metaphlan

# Download/Update the latest marker database
metaphlan --install
```

## Common CLI Patterns

### Basic Taxonomic Profiling
The most common use case is converting raw FastQ files into a tab-separated taxonomic profile.

```bash
# Profile a single FastQ file
metaphlan input.fastq --input_type fastq -o profiled_metagenome.txt

# Profile paired-end data (provide as comma-separated list)
metaphlan forward.fastq,reverse.fastq --input_type fastq --nproc 8 -o profiled_metagenome.txt
```

### Efficient Re-processing
To avoid re-running the computationally expensive Bowtie2 alignment, always save the intermediate alignment file.

```bash
# Step 1: Profile and save Bowtie2 output
metaphlan sample.fastq --input_type fastq --bowtie2out sample.bowtie2.bz2 -o profile.txt

# Step 2: Re-generate profile with different parameters using the intermediate file
metaphlan sample.bowtie2.bz2 --input_type bowtie2out -o new_profile.txt
```

### Merging Multiple Samples
After profiling individual samples, merge them into a single abundance matrix for statistical analysis.

```bash
merge_metaphlan_tables.py sample1.txt sample2.txt sample3.txt > merged_abundance_table.txt
```

## Expert Tips and Best Practices

- **Resource Allocation**: Always use the `--nproc` parameter to match the available CPU cores, as the Bowtie2 alignment step is highly parallelizable.
- **Taxonomic Resolution**: MetaPhlAn 4 introduces Species-level Genome Bins (SGBs). If you require traditional NCBI taxonomy, ensure your database version is compatible with your downstream analysis tools.
- **Viral Profiling**: When specifically interested in viruses, ensure you are using MetaPhlAn 4+ which includes a significantly expanded viral module.
- **Strain-Level Analysis**: If the user requires strain-level genomics, pivot to using **StrainPhlAn**, which is bundled within the MetaPhlAn installation but requires a different workflow (extracting markers first).
- **Unknowns**: Use the `--unclassified_estimation` flag if you need to account for the fraction of reads that do not map to any known reference markers in the database.



## Subcommands

| Command | Description |
|---------|-------------|
| metaphlan | METAgenomic PHyLogenetic ANalysis for metagenomic taxonomic profiling. |
| strainphlan | StrainPhlAn is a tool for the reconstruction of bacterial strains and their phylogenetic analysis. |

## Reference documentation

- [MetaPhlAn GitHub Repository](./references/github_com_biobakery_metaphlan.md)
- [MetaPhlAn Wiki](./references/github_com_biobakery_metaphlan_wiki.md)
- [Segata Lab MetaPhlAn Page](./references/segatalab_cibio_unitn_it_tools_metaphlan_index.html.md)