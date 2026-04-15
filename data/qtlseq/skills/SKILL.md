---
name: qtlseq
description: qtlseq identifies genomic regions associated with specific traits by calculating SNP-indices from bulked segregant analysis data. Use when user asks to map reads to a reference, calculate SNP-indices for bulked populations, perform statistical simulations to identify QTLs, or predict SNP impacts using SnpEff.
homepage: https://github.com/YuSugihara/QTL-seq
metadata:
  docker_image: "quay.io/biocontainers/qtlseq:2.2.9--pyhdfd78af_0"
---

# qtlseq

## Overview
The `qtlseq` skill provides a streamlined workflow for identifying genomic regions associated with specific traits. It automates the process of mapping reads to a reference genome, calculating SNP-indices for bulked populations, and performing statistical simulations to determine significant QTLs. This tool is particularly effective for crop science and plant breeding applications where researchers need to move from phenotype to causative mutation using pooled sequencing data.

## Core Command Usage

### Basic Workflow (FASTQ Input)
To run the pipeline starting from paired-end FASTQ files, use the following structure. Note that paired-end files must be separated by a comma without spaces.

```bash
qtlseq -r reference.fasta \
       -p parent_R1.fq.gz,parent_R2.fq.gz \
       -b1 bulk1_R1.fq.gz,bulk1_R2.fq.gz \
       -b2 bulk2_R1.fq.gz,bulk2_R2.fq.gz \
       -n1 20 -n2 20 \
       -o output_directory
```

### Running from BAM Files
If you have already aligned your reads, you can skip the mapping step by providing BAM files directly:

```bash
qtlseq -r reference.fasta \
       -p parent.bam \
       -b1 bulk1.bam \
       -b2 bulk2.bam \
       -n1 20 -n2 20 \
       -o output_directory
```

## Key Parameters and Optimization

### Population and Generation Settings
- **`-n1`, `-n2`**: Always specify the exact number of individuals pooled in each bulk to ensure accurate statistical simulation of the null distribution.
- **`-F`**: Set the filial generation (default is 2). For advanced generations (e.g., F7), increasing this value is critical for correct SNP-index modeling.

### Filtering and Quality Control
- **`-d` / `-D`**: Set the minimum and maximum depth. The default minimum is 8; increasing this (e.g., `-d 15`) can reduce noise from low-confidence SNPs.
- **`-q` / `-Q`**: Adjust mapping quality (default 40) and base quality (default 18) filters for `mpileup` to suit your sequencing platform's characteristics.
- **`--mem`**: If running on a high-performance cluster, adjust the memory per thread (e.g., `--mem 4G`) to speed up BAM sorting.

### Sliding Window Analysis
- **`-w`**: Window size in kb (default 2000). Smaller windows provide higher resolution but more noise.
- **`-s`**: Step size in kb (default 100).

### Functional Annotation
- **`-e`**: Integrate SnpEff by providing the database name (e.g., `-e Osativa_v7.0`). This allows the pipeline to predict the impact of SNPs within the identified QTL regions.

## Expert Tips
- **Output Directory**: The directory specified with `-o` must not exist prior to running the command; the tool will fail if the folder is already present.
- **Contig Handling**: If your reference genome is highly fragmented (many contigs), `qtlseq` will only plot the 50 longest contigs. Consider filtering your reference FASTA if you are interested in specific smaller scaffolds.
- **Trimming**: Use the `-T` flag to enable automatic trimming via Trimmomatic. You must provide an adapter file with `--adapter` if you wish to remove Illumina-specific sequences.
- **Multiple Inputs**: You can specify the `-p`, `-b1`, and `-b2` options multiple times if you have data spread across several sequencing lanes or libraries.

## Reference documentation
- [QTL-seq GitHub Repository](./references/github_com_YuSugihara_QTL-seq.md)
- [QTL-seq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_qtlseq_overview.md)