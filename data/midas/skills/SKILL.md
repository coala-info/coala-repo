---
name: midas
description: MIDAS (Metagenomic Intra-Species Diversity Analysis System) is a specialized pipeline for high-resolution metagenomics.
homepage: https://github.com/snayfach/MIDAS
---

# midas

## Overview
MIDAS (Metagenomic Intra-Species Diversity Analysis System) is a specialized pipeline for high-resolution metagenomics. While many tools stop at species-level classification, MIDAS enables the quantification of strain-level variation, including gene presence/absence and single nucleotide polymorphisms (SNPs). It functions by mapping metagenomic reads against a comprehensive database of reference genomes, making it ideal for longitudinal strain tracking and population genetic studies in microbial ecology.

## Installation and Setup
Install MIDAS via Bioconda for the most stable environment:
```bash
conda install bioconda::midas
```

Before running analyses, you must provide a reference database. You can download the default database or build a custom one using the provided scripts in the `bin/` directory.

## Core CLI Workflows

### 1. Single Sample Analysis
Analysis is typically performed in three stages: species abundance, gene content, and SNP calling.

**Estimate Species Abundance:**
```bash
run_midas.py species <output_dir> -1 <reads_1.fastq.gz> -2 <reads_2.fastq.gz>
```

**Predict Pan-genome Gene Content:**
```bash
run_midas.py genes <output_dir> -1 <reads_1.fastq.gz> -2 <reads_2.fastq.gz>
```

**Call SNPs:**
```bash
run_midas.py snps <output_dir> -1 <reads_1.fastq.gz> -2 <reads_2.fastq.gz>
```

### 2. Merging Results Across Samples
After processing individual samples, use `merge_midas.py` to create a global matrix for comparative analysis.

```bash
# Merge species abundance
merge_midas.py species <merged_dir> -i <sample_dir_1>,<sample_dir_2>,<sample_dir_n>

# Merge gene content
merge_midas.py genes <merged_dir> -i <sample_dir_1>,<sample_dir_2>

# Merge SNPs
merge_midas.py snps <merged_dir> -i <sample_dir_1>,<sample_dir_2>
```

## Expert Tips and Best Practices

- **Resuming Interrupted Runs:** Use the `--resume` flag to pick up where a process left off without re-calculating completed steps.
- **Handling Long Genes:** If encountering issues with VSEARCH during gene content prediction, use the `--max_length` flag to prevent errors associated with exceptionally long sequences.
- **Alignment Filtering:** Use the `--aln_cov` flag to set a minimum alignment coverage threshold, ensuring that only high-quality mappings contribute to SNP and gene calls.
- **SNP Types:** You can specify the type of SNPs to report (e.g., synonymous vs. non-synonymous) using the `--snp_type` flag during the SNP calling or merging phase.
- **Parallelization:** MIDAS supports multi-threading. Always specify the number of available cores to significantly reduce execution time for the mapping steps.

## Reference documentation
- [MIDAS Main Repository](./references/github_com_snayfach_MIDAS.md)
- [Bioconda MIDAS Overview](./references/anaconda_org_channels_bioconda_packages_midas_overview.md)
- [MIDAS Documentation Index](./references/github_com_snayfach_MIDAS_tree_master_docs.md)