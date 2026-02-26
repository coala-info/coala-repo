---
name: ntsm
description: "ntsm detects sample swaps and verifies sample identity by generating and comparing k-mer fingerprints from raw sequencing data. Use when user asks to detect sample swaps, verify sample identity, estimate sequencing error rates, or generate k-mer count fingerprints from FASTQ files."
homepage: https://github.com/JustinChu/ntsm
---


# ntsm

## Overview

ntsm (Nucleotide Sequence/Sample Matcher) is a specialized tool designed to detect sample swaps and verify sample identity by counting specific k-mers at known variant sites. Instead of performing full alignment or variant calling, it generates a k-mer "fingerprint" from raw sequencing data (FASTQ) and compares these fingerprints across samples to calculate the probability of a shared origin. It is highly efficient for QC, providing sequencing error rate estimates and relatedness inference.

## Core Workflow

### 1. Site Generation
If you are not working with human data (where defaults are provided), you must first define the sites to be used for fingerprinting.

```bash
# Generate site fasta files from a VCF and reference genome
ntsmSiteGen generate-sites name=my_project ref=genome.fa vcf=variants.vcf
```
*   **Key Parameter `n`**: The output files (e.g., `prefix_n10.fa`) indicate the number of missing sub-k-mers allowed. Lower `n` values handle sequencing errors better but require more sites. Aim for ~10^5 sites for optimal statistical power.
*   **Defaults**: For human samples, use the pre-computed `data/human_sites_n10.fa`.

### 2. PCA Rotation (Optional)
To accelerate the evaluation of large cohorts, generate a PCA rotation matrix.

```bash
ntsmSiteGen generate-pca-rot-mat name=my_project ref=genome.fa multivcf=background_samples.vcf sites=my_project_n10.fa
```

### 3. K-mer Counting
Run this for every individual sample (FASTQ) to generate count files.

```bash
# Count k-mers using 8 threads
ntsmCount -t 8 -s sites.fa sample_R1.fq.gz sample_R2.fq.gz > sample_counts.txt
```
*   **Efficiency Tip**: For high-coverage data, use `-m 10` to stop counting once 10x average site coverage is reached. This significantly reduces runtime without sacrificing accuracy.

### 4. Sample Evaluation
Compare the generated count files to determine identity.

```bash
# Basic evaluation
ntsmEval sample1_counts.txt sample2_counts.txt sample3_counts.txt > results.tsv

# Fast evaluation using PCA heuristic
ntsmEval -a -t 16 -n human_sites_center.txt -p human_sites_rotationalMatrix.tsv *.txt > results.tsv
```

## Expert Tips and Best Practices

*   **Sample Swap Detection**: In the `ntsmEval` output, look at the `score` and `same` columns. A `same` value of 1 indicates the samples likely share the same origin.
*   **Error Rate Estimation**: The header lines (`#@TK` and `#@KS`) in the `ntsmCount` output are used by `ntsmEval` to estimate the sequencing error rate for each library.
*   **Relatedness Inference**: While primarily for identity matching, you can use the `-a` parameter for relatedness; however, do not rely on the PCA-based heuristic for fine-grained kinship analysis.
*   **Resource Management**: `ntsmCount` is thread-efficient. Use the `-t` flag to match your available CPU cores, especially when processing gzipped FASTQ files.

## Reference documentation
- [ntsm Main Documentation](./references/github_com_JustinChu_ntsm.md)
- [ntsm Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ntsm_overview.md)