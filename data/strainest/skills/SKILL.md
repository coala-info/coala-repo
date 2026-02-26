---
name: strainest
description: StrainEst determines the identity and relative abundance of coexisting microbial strains in metagenomic samples by leveraging species-specific SNV profiles. Use when user asks to identify specific microbial strains, estimate strain-level relative abundance, or profile metagenomic reads against a reference SNV database.
homepage: https://github.com/compmetagen/strainest
---


# strainest

## Overview
StrainEst is a reference-based computational method used to determine the identity and relative abundance of coexisting microbial strains in metagenomic samples. By leveraging SNV profiles of available genomes for a selected species, it provides higher resolution than standard species-level profiling. Use this skill when you need to move beyond "who is there" at a high taxonomic level to "which specific strains are present" and "at what percentage" for a target species.

## Installation and Setup
The most reliable way to use strainest is via Conda or Docker to ensure all dependencies (Sickle, Bowtie2, samtools) are correctly configured.

```bash
# Conda installation
conda install bioconda::strainest

# Docker usage
docker pull compmetagen/strainest
```

## Standard Workflow
The strainest pipeline requires several external tools to prepare the data before the final estimation step.

### 1. Read Preprocessing
Trim raw Illumina paired-end reads to ensure high-quality input.
```bash
sickle pe -f reads1.fastq -r reads2.fastq -t sanger \
  -o reads1.trim.fastq -p reads2.trim.fastq -s reads.singles.fastq -q 20
```

### 2. Reference Alignment
Align the trimmed metagenomic reads against a species-specific Bowtie2 database.
```bash
# Align reads
bowtie2 --very-fast --no-unal -x species_db/bowtie/align \
  -1 reads1.trim.fastq -2 reads2.trim.fastq -S reads.sam

# Convert, sort, and index
samtools view -b reads.sam > reads.bam
samtools sort reads.bam -o reads.sorted.bam
samtools index reads.sorted.bam
```

### 3. Abundance Estimation
Run the core `strainest est` command using the species SNV profile and the processed BAM file.
```bash
strainest est snp_clust.dgrp reads.sorted.bam output_dir
```

## Interpreting Results
The output directory contains several files critical for evaluating the strain profile:
- **abund.txt**: The primary output containing predicted relative abundances for each reference genome.
- **info.txt**: Contains the Pearson R correlation coefficient; a higher value indicates a more confident prediction.
- **max_ident.txt**: Shows the percentage of alleles present in the metagenome for each reference.
- **mse.pdf**: A Lasso cross-validation plot used to visualize the shrinkage coefficient performance.

## Expert Tips and Best Practices
- **Database Selection**: Precomputed databases for common species (e.g., *E. coli*, *B. fragilis*, *P. acnes*) are available via the project's FTP. Always ensure your `snp_clust.dgrp` file matches the reference genome used for Bowtie2 alignment.
- **Alignment Sensitivity**: While the tutorial suggests `--very-fast`, use more sensitive Bowtie2 settings if you suspect low-abundance strains or have highly divergent references.
- **Validation**: Always check the `info.txt` file. If the Pearson R value is low, the predicted abundances may not be reliable, potentially due to the presence of a strain not represented in your reference SNV profile.
- **Custom Databases**: If a pre-built database is not available, you must build a custom SNV profile using a representative set of genomes for your species of interest.

## Reference documentation
- [StrainEst GitHub Repository](./references/github_com_compmetagen_strainest.md)
- [Bioconda StrainEst Package](./references/anaconda_org_channels_bioconda_packages_strainest_overview.md)