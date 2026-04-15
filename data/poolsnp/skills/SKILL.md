---
name: poolsnp
description: PoolSNP is a heuristic SNP calling pipeline optimized for identifying polymorphisms and allele frequencies in pooled sequencing data. Use when user asks to call SNPs from MPILEUP files, analyze allele frequencies in Pool-seq libraries, or filter variants based on coverage and frequency thresholds.
homepage: https://github.com/capoony/PoolSNP
metadata:
  docker_image: "quay.io/biocontainers/poolsnp:1.0.1--py312h7e72e81_0"
---

# poolsnp

## Overview

PoolSNP is a heuristic SNP calling pipeline specifically optimized for pooled sequencing (Pool-seq) data. Unlike traditional callers that focus on individual genotypes, PoolSNP analyzes allele counts and frequencies across multiple libraries to identify polymorphisms. It processes MPILEUP files and reference genomes to produce VCF files containing allele frequencies, making it an essential tool for population genomics where individual-level data is unavailable.

## Installation

The recommended way to install PoolSNP is via Bioconda:

```bash
conda install bioconda::poolsnp
```

## Core Command Line Usage

PoolSNP is executed as a shell script that accepts parameters in a `key=value` format.

### Basic Execution Pattern
```bash
bash PoolSNP.sh \
  mpileup=input.mpileup.gz \
  reference=reference.fasta \
  names=Sample1,Sample2,Sample3 \
  max-cov=0.98 \
  min-cov=10 \
  min-count=10 \
  min-freq=0.01 \
  miss-frac=0.2 \
  jobs=12 \
  output=my_snps
```

### Key Parameters

| Parameter | Description | Example |
| :--- | :--- | :--- |
| `mpileup` | Path to the input MPILEUP file (can be gzipped). | `data.mpileup.gz` |
| `reference` | Path to the reference genome in FASTA format. | `ref.fasta` |
| `names` | Comma-separated list of library names. | `PoolA,PoolB` |
| `min-cov` | Minimum coverage required across all libraries. | `10` |
| `max-cov` | Coverage percentile (0-1) or path to a custom max-cov file. | `0.98` |
| `min-count` | Minimum cumulative count of a minor allele across all pools. | `10` |
| `min-freq` | Minimum cumulative frequency of a minor allele. | `0.01` |
| `miss-frac` | Max fraction of libraries allowed to fail coverage criteria. | `0.2` |
| `jobs` | Number of parallel threads (requires GNU parallel). | `8` |
| `badsites` | Set to `1` to output a list of sites failing criteria. | `1` |
| `allsites` | Set to `1` to report all sites (polymorphic and invariant). | `0` |

## Expert Tips and Best Practices

### Reference Genome Preparation
* **Header Sanitization**: Ensure FASTA headers do not contain special characters such as `/`, `|`, `:`, or `,`. PoolSNP may ignore sequences with these characters in the header.
* **Indexing**: While the script handles the FASTA, ensure the reference matches the one used to generate the MPILEUP.

### Coverage Filtering
* **Percentile vs. Absolute**: Using a percentile (e.g., `max-cov=0.98`) is generally safer for filtering out repetitive regions or copy number variants that show abnormally high coverage.
* **Custom Max-Cov**: For advanced users, you can provide a tab-delimited file where the first column is the chromosome and the second is a comma-separated list of thresholds for each sample.

### Handling Missing Data
* The `miss-frac` parameter is crucial for large datasets. For example, `miss-frac=0.2` with 10 samples allows a site to be called even if 2 samples do not meet the `min-cov` or `max-cov` thresholds.
* **Note**: Setting `allsites=1` automatically disables the `miss-frac` filter.

### Performance Optimization
* PoolSNP relies on **GNU parallel**. Ensure it is installed and in your `$PATH`.
* Adjust the `jobs` parameter to match your available CPU cores to significantly speed up the processing of large MPILEUP files.

### Output Files
* **VCF**: The primary output (v4.2) containing allele counts and frequencies.
* **Max-coverage file**: Records the calculated thresholds used for the run.
* **Bad-sites file**: Useful for downstream population genetic estimators (like PoolGEN_var) to weight windows correctly.

## Reference documentation
- [PoolSNP GitHub Repository](./references/github_com_capoony_PoolSNP.md)
- [Bioconda PoolSNP Overview](./references/anaconda_org_channels_bioconda_packages_poolsnp_overview.md)