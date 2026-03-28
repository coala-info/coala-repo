---
name: midas
description: MIDAS is a pipeline for high-resolution metagenomics that quantifies species abundance, gene content, and strain-level genetic variation from shotgun sequencing data. Use when user asks to estimate species-level abundance, quantify pangenome gene presence, or call single-nucleotide polymorphisms within bacterial populations.
homepage: https://github.com/snayfach/MIDAS
---

# midas

## Overview

MIDAS (Metagenomic Intra-species Diversity Analysis System) is a specialized pipeline for high-resolution metagenomics. While many tools stop at taxonomic classification, MIDAS enables the study of bacterial population genetics directly from shotgun sequencing data. It leverages a massive database of reference genomes to provide three primary types of data: species-level abundance, gene-level presence/absence within a species' pangenome, and strain-level SNP calling. This allows for advanced workflows like strain tracking between hosts, biogeography studies, and analyzing the evolutionary dynamics of microbial communities.

## Core Workflow

The MIDAS pipeline typically follows a two-stage process: per-sample processing followed by multi-sample merging.

### 1. Per-Sample Analysis
Run the primary script `run_midas.py` for each metagenomic sample.

*   **Species Abundance**: Estimates the relative abundance of species.
    `run_midas.py species <output_dir> -1 <reads_1.fq.gz> -2 <reads_2.fq.gz>`
*   **Gene Content**: Quantifies the coverage of pangenome genes for specific species.
    `run_midas.py genes <output_dir> -1 <reads_1.fq.gz> -2 <reads_2.fq.gz>`
*   **SNP Calling**: Identifies single-nucleotide polymorphisms within species.
    `run_midas.py snps <output_dir> -1 <reads_1.fq.gz> -2 <reads_2.fq.gz>`

### 2. Merging Results
After processing individual samples, use `merge_midas.py` to create a unified dataset for comparative analysis.

*   **Merge Species**: `merge_midas.py species <merged_dir> -i <sample_dir1,sample_dir2,...>`
*   **Merge Genes**: `merge_midas.py genes <merged_dir> -i <sample_dir1,sample_dir2,...>`
*   **Merge SNPs**: `merge_midas.py snps <merged_dir> -i <sample_dir1,sample_dir2,...>`

## CLI Best Practices and Expert Tips

*   **Resuming Jobs**: Metagenomic pipelines are computationally intensive. Use the `--resume` flag to restart a failed or interrupted run without re-processing completed steps.
*   **Alignment Filtering**: To improve the quality of SNP calls and gene content estimation, use the `--aln_cov` flag to set a minimum alignment coverage threshold.
*   **Handling Long Genes**: If working with assemblies or specific pangenomes containing exceptionally long sequences, use `--max_length` to prevent issues with underlying aligners like VSEARCH.
*   **SNP Type Selection**: Use the `--snp_type` flag to restrict analysis to specific categories of SNPs (e.g., synonymous vs. non-synonymous) depending on the downstream evolutionary analysis.
*   **Database Management**: MIDAS requires a reference database. While a default database of ~30,000 genomes is available, you can build a custom database using `build_midas_db.py` if your environment (e.g., soil or seawater) is poorly represented in standard human microbiome sets.
*   **Parallelization**: MIDAS supports multi-threading. Always specify the number of available cores to significantly reduce runtime for the alignment and SNP calling phases.

## Common Downstream Analyses

Once results are merged, the output files (typically tab-delimited) can be used for:
*   **Strain Tracking**: Using rare SNPs to identify identical strains across different samples or time points.
*   **Phylogenetic Trees**: Building core-genome trees from the merged SNP data.
*   **Pangenome Dynamics**: Analyzing gene gain/loss events across different environments or host conditions.



## Subcommands

| Command | Description |
|---------|-------------|
| merge_midas.py | merge MIDAS results across metagenomic samples |
| run_midas.py | Estimate species abundance and intra-species genomic variation from an individual metagenome |

## Reference documentation
- [An integrated metagenomics pipeline for strain profiling reveals novel patterns of bacterial transmission and biogeography](./references/genome_cshlp_org_content_26_11_1612.md)
- [MIDAS GitHub Repository Overview](./references/github_com_snayfach_MIDAS.md)
- [MIDAS Commit History and Flag Updates](./references/github_com_snayfach_MIDAS_commits_master.md)