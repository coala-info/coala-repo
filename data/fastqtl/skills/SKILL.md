---
name: fastqtl
description: FastQTL performs molecular QTL mapping to identify statistical associations between genetic polymorphisms and quantitative traits. Use when user asks to map quantitative trait loci, perform nominal or permutation passes, or calculate empirical p-values for genomic datasets.
homepage: https://github.com/francois-a/fastqtl
metadata:
  docker_image: "biocontainers/fastqtl:v2.184dfsg-5-deb_cv1"
---

# fastqtl

## Overview
FastQTL is a specialized tool for molecular QTL mapping, used to scan for statistical associations between genetic polymorphisms (genotypes) and quantitative traits (phenotypes) such as gene expression or protein levels. This specific version improves upon the original FastQTL by adding filters for minor allele frequency and sample counts, and it includes a Python-based multi-threading wrapper to handle large-scale genomic datasets. Use this skill to construct command-line calls for nominal and permutation passes, manage covariates, and optimize performance through chunking.

## Command Line Usage

### Multi-threaded Execution
The primary way to run this version of FastQTL is through the `run_FastQTL_threaded.py` wrapper. This script automates the process of splitting the genome into chunks and processing them in parallel.

#### Nominal Pass
Use the nominal pass to calculate association statistics for all variant-phenotype pairs within a specified window.

```bash
run_FastQTL_threaded.py \
    [genotypes].vcf.gz \
    [phenotypes].bed.gz \
    [output_prefix] \
    --covariates [covariates].txt.gz \
    --window 1e6 \
    --ma_sample_threshold 10 \
    --maf_threshold 0.01 \
    --chunks 100 \
    --threads 10
```

#### Permutation Pass
Use the permutation pass to calculate empirical p-values, which are necessary for False Discovery Rate (FDR) estimation.

```bash
run_FastQTL_threaded.py \
    [genotypes].vcf.gz \
    [phenotypes].bed.gz \
    [output_prefix] \
    --covariates [covariates].txt.gz \
    --permute 1000 10000 \
    --window 1e6 \
    --ma_sample_threshold 10 \
    --maf_threshold 0.01 \
    --chunks 100 \
    --threads 10
```

### Key Parameters
- `--window`: The cis-window size around the phenotype (e.g., `1e6` for 1Mb).
- `--maf_threshold`: Filters out variants with a Minor Allele Frequency below this value (e.g., `0.01`).
- `--ma_sample_threshold`: Filters out variants where the minor allele is present in fewer than N samples (e.g., `10`).
- `--chunks`: Number of genomic chunks to split the work into; higher numbers reduce memory usage per thread.
- `--threads`: Number of CPU cores to utilize.
- `--permute [min] [max]`: Sets the minimum and maximum number of permutations for empirical p-value calculation.

## Best Practices and Expert Tips

### Data Preparation
- **Indexing**: Both the genotype VCF and the phenotype BED files must be sorted and indexed using `tabix`.
- **Phenotype Format**: Phenotypes must be in a 4-column BED format (Chr, Start, End, ID) followed by sample columns.
- **Covariates**: Ensure covariate IDs exactly match the sample IDs in the VCF and BED files.

### Performance Optimization
- **Memory Management**: If you encounter memory errors, increase the `--chunks` parameter. This reduces the amount of data loaded into memory at any single time.
- **Thread Scaling**: While increasing `--threads` speeds up the run, ensure the I/O bandwidth of your system can handle multiple threads reading from the same compressed files simultaneously.

### Filtering Strategy
- **Rare Variants**: Use `--ma_sample_threshold` in addition to `--maf_threshold`. In small cohorts, a MAF of 0.01 might represent only 1 or 2 individuals, which can lead to unstable association estimates. A threshold of at least 10 samples containing the minor allele is a common standard for robust QTL detection.

### Post-Processing
- **FDR Estimation**: This version of FastQTL supports q-value calculation for FDR. This typically requires R to be installed in the environment to process the permutation results.

## Reference documentation
- [FastQTL Main README](./references/github_com_francois-a_fastqtl.md)