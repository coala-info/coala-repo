---
name: ngscheckmate
description: NGSCheckMate verifies the identity of human sequencing samples by analyzing allele fractions of known SNPs to detect sample swaps or mislabeling. Use when user asks to verify sample identity, detect sample swaps, or compare sequencing data from different modalities like RNA-seq and WGS to confirm they belong to the same individual.
homepage: https://github.com/parklab/NGSCheckMate
metadata:
  docker_image: "quay.io/biocontainers/ngscheckmate:1.0.1--py312pl5321h577a1d6_4"
---

# ngscheckmate

## Overview
NGSCheckMate is a forensic-style tool designed to verify the identity of human sequencing samples. It works by analyzing the allele fractions of a predefined set of known single-nucleotide polymorphisms (SNPs). By calculating correlations between these fractions, it can determine if two files—even from different data types like RNA-seq and WGS—belong to the same person. This is particularly useful for large-scale projects where sample mislabeling or swaps are a risk.

## Core Workflows

### 1. BAM/VCF Mode
Use this mode for aligned reads or called variants. BAM files must be coordinate-sorted and indexed.

```bash
python ncm.py -B -d <input_dir> -bed <snp_bed_file> -O <output_dir>
```

**Key Arguments:**
- `-B` or `-V`: Specify input type (BAM or VCF).
- `-l <file>`: Use a text file listing paths and sample names instead of a directory.
- `-bed <file>`: Use `SNP/SNP_GRCh37_hg19_wChr.bed` if your reference uses "chr" prefixes, otherwise use `SNP/SNP_GRCh37_hg19_woChr.bed`.
- `-f`: Recommended for datasets containing related individuals (e.g., trios) to apply stricter correlation cutoffs.

### 2. FASTQ Mode (Alignment-Free)
The fastest method for initial QC before alignment. It uses a binary pattern file to scan unaligned reads.

```bash
python ncm_fastq.py -p <pattern_file> -l <fastq_list> -O <output_dir>
```

### 3. High-Performance Optimization for Large BAM Sets
To avoid the overhead of running the full pipeline on dozens of large BAM files, convert them to VCF first using a targeted mpileup:

```bash
# Step 1: Generate targeted VCF
samtools mpileup -I -uf <ref.fasta> -l <snp.bed> <sample.bam> | bcftools call -c - > <sample.vcf>

# Step 2: Run NGSCheckMate on the resulting VCFs
python ncm.py -V -d <vcf_dir> -bed <snp.bed> -O <output_dir>
```

## Configuration and Setup
Before running the BAM module, ensure `ncm.conf` is updated with the correct paths:
- `REF`: Path to your human reference FASTA.
- `SAMTOOLS`: Path to the samtools executable.
- `BCFTOOLS`: Path to the bcftools executable.

## Interpreting Results
- **Correlation Matrix**: Check the output text files for correlation coefficients. High correlation indicates the same individual.
- **Dendrogram**: If R is installed, the tool generates a PDF dendrogram (`output_all.pdf`) visualizing sample clusters.
- **Matched Pairs**: Look for the `.matched` file for a summary of identified pairs.

## Expert Tips
- **Reference Consistency**: Always ensure the BED file chromosome naming (chr1 vs 1) matches your BAM/VCF headers.
- **Mixed Data Types**: You can compare WES and RNA-seq samples directly; the tool is designed to handle the different depth profiles of these technologies.
- **Low Depth Samples**: Use the `-nz` flag to calculate reference depth based only on non-zero SNP positions, which can improve accuracy for low-coverage data.



## Subcommands

| Command | Description |
|---------|-------------|
| ncm.py | Ensuring Sample Identity v1.0.1. Input = the absolute path list of vcf files (samtools mpileup and bcftools). Output = Matched samples List |
| ncm_fastq.py | NGSCheckMate v1.0 |

## Reference documentation
- [NGSCheckMate README](./references/github_com_parklab_NGSCheckMate_blob_master_README.md)
- [Configuration Guide](./references/github_com_parklab_NGSCheckMate_blob_master_ncm.conf.md)
- [Fastq Module Installation](./references/github_com_parklab_NGSCheckMate_blob_master_install_ncmfastq.sh.md)