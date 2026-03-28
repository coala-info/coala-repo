---
name: vcfkit
description: VCF-kit is a suite of utilities designed for the analysis, transformation, and evolutionary interpretation of genomic variant data. Use when user asks to calculate population genetics statistics, generate phylogenetic trees, design primers for variants, or convert VCF files to TSV format.
homepage: https://github.com/AndersenLab/VCF-kit
---

# vcfkit

## Overview
VCF-kit (accessed via the `vk` command) is a specialized suite of utilities designed to simplify the analysis of genomic variant data. While many tools focus on the initial calling of variants, VCF-kit provides high-level functions for evolutionary biology and experimental validation. It excels at transforming raw VCF data into biological insights, such as identifying selective sweeps, visualizing sample relationships through dendrograms, and automating the tedious process of primer design for variant verification.

## Core Workflows and CLI Patterns

### Reference Genome Management
Many `vk` commands require a reference genome. Use the `genome` module to manage these.
- **Setup a reference**: `vk genome location/to/genome.fa`
- **Search/Download**: `vk genome ncbi --search "Caenorhabditis elegans"`

### Population Genetics and Statistics
- **Tajima's D**: Calculate Tajima's D across the genome using a sliding window.
  `vk tajima <window_size> <step_size> input.vcf.gz`
- **Genotype Statistics**: Obtain allele frequencies and genotype counts.
  `vk calc genotypes input.vcf.gz`

### Phylogenetic Analysis
Generate dendrograms directly from VCF files to visualize sample relatedness.
- **Generate a tree**: `vk phylo tree nj input.vcf.gz` (Uses Neighbor-Joining)
- **FastTree integration**: `vk phylo fasttree input.vcf.gz`

### Laboratory Validation (Primer Design)
One of VCF-kit's most powerful features is automating primer design for specific variants.
- **Design primers**: `vk primer design --region chrI:1-10000 input.vcf.gz`
- **Validation**: It uses `primer3` and `blast` internally to ensure primers are unique and effective.

### Data Transformation and Filtering
- **VCF to TSV**: Convert complex VCF fields into a flat, readable TSV format.
  `vk vcf2tsv input.vcf.gz > output.tsv`
- **Sample Renaming**: Quickly modify sample names using prefixes, suffixes, or regex-like substitutions.
  `vk rename --prefix "StudyA_" input.vcf.gz`
- **Genotype Filtering**: Filter variants based on the number of missing calls or specific genotype types (REF, HET, ALT).
  `vk filter --max-missing 0.1 input.vcf.gz`

## Expert Tips
- **Piping**: `vk` is designed to work within Unix pipes. You can pipe output from `bcftools` directly into `vk`:
  `bcftools view -r chrI:1-1000 input.vcf.gz | vk vcf2tsv`
- **Imputation**: Use the `vk hmm` command for imputing genotypes in linkage studies, which is particularly effective for recombinant inbred lines (RILs).
- **Dependencies**: Ensure `bwa`, `samtools`, `bcftools`, `blast`, and `primer3` are in your PATH, as `vk` acts as an orchestrator for these tools during complex operations like primer design.



## Subcommands

| Command | Description |
|---------|-------------|
| vcfkit vk filter | Filter VCF based on genotype counts. |
| vcfkit vk rename | Rename samples in a VCF file. |
| vk | A toolkit for variant calling and analysis. |
| vk calc | Calculate various statistics from VCF files. |
| vk genome | Manage genome data |
| vk phylo | Phylogenetic analysis tools for VCF files. |
| vk tajima | Calculate Tajima's D |
| vk vcf2tsv | Convert VCF to TSV format |

## Reference documentation
- [VCF-kit Main Repository](./references/github_com_AndersenLab_VCF-kit.md)
- [VCF-kit Documentation Overview](./references/github_com_AndersenLab_VCF-kit_tree_master_docs.md)