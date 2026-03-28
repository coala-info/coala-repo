---
name: ntsm
description: ntsm is a quality control toolset that determines if genomic samples originate from the same individual by comparing k-mer frequencies at known variant sites. Use when user asks to identify sample swaps, generate k-mer fingerprints from reference genomes, count k-mers at SNP sites, or evaluate the similarity and relatedness between sequencing samples.
homepage: https://github.com/JustinChu/ntsm
---

# ntsm

## Overview

ntsm (Nucleotide Sequence/Sample Matcher) is a quality control toolset used to determine if genomic samples originate from the same individual. It works by counting specific k-mers at known variant sites and performing statistical comparisons between samples. This process allows researchers to identify incongruent samples or sample swaps before proceeding with computationally expensive downstream analysis. The tool can also provide metadata such as sequencing error rates and can be extended for relatedness inference.

## Core Workflow

### 1. Site Generation
Generate a k-mer "fingerprint" template from a reference genome and a VCF file containing known variants.

```bash
ntsmSiteGen generate-sites name=my_project ref=genome.fa vcf=variants.vcf
```
*   **Key Parameters**: `w=31` (window size), `k=19` (k-mer size), `t=4` (threads).
*   **Output**: Creates `prefix_n{missing_kmers}.fa`. For human samples, use the pre-computed `data/human_sites_n10.fa` provided with the tool.

### 2. Counting k-mers
Extract k-mer frequencies from raw FASTQ data. This must be run for each sample individually.

```bash
ntsmCount -t 8 -s sites.fa sample_R1.fq.gz sample_R2.fq.gz > sample_counts.txt
```
*   **Efficiency Tip**: For high-coverage data, use `-m 10` to stop counting once average site coverage reaches 10x. This significantly reduces runtime without sacrificing accuracy for identity matching.

### 3. Sample Evaluation
Compare count files to compute the probability of shared origin.

```bash
# Basic comparison
ntsmEval sample1_counts.txt sample2_counts.txt > results.tsv

# Comparison with PCA-based heuristic for speed
ntsmEval -a -t 16 -n human_sites_center.txt -p human_sites_rotationalMatrix.tsv *.txt > summary.tsv
```
*   **Relatedness**: Use the `-a` parameter to enable relatedness inference, but note that the PCA-based heuristic should generally be avoided for this specific use case.

## Expert Tips and Best Practices

*   **Site Selection**: Aim for approximately 10^5 sites for optimal statistical power. If using custom sites, ensure they are filtered for repetitive k-mers.
*   **Error Rate Estimation**: Check the header lines (`#@`) in the `ntsmCount` output; these values are used by `ntsmEval` to estimate the sequencing error rate for each sample.
*   **PCA Acceleration**: When comparing a large number of samples, always generate or use a rotation matrix (`ntsmSiteGen generate-pca-rot-mat`) to speed up the evaluation phase.
*   **Input Handling**: `ntsmCount` natively supports gzipped FASTQ files and can accept multiple input files per sample (e.g., different lanes).



## Subcommands

| Command | Description |
|---------|-------------|
| make | GNU Make is a tool which controls the generation of programs and other non-source files from a description file. |
| ntsmCount | Count k-mers for SNP sites |
| ntsmEval | Processes sets of counts files and compares their similarity. If only a single file is provided general QC information returned. |

## Reference documentation
- [ntsm README](./references/github_com_JustinChu_ntsm_blob_main_README.md)
- [ntsmSiteGen Documentation](./references/github_com_JustinChu_ntsm_blob_main_ntsmSiteGen.md)