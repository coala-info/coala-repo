---
name: pastrami
description: Pastrami is a scalable computational framework for high-throughput ancestry estimation using haplotype matching and optimization. Use when user asks to estimate ancestral proportions, build reference copying matrices, or perform haplotype-based population structure analysis.
homepage: https://github.com/healthdisparities/pastrami
---


# pastrami

## Overview

Pastrami is a scalable computational framework designed for high-throughput ancestry estimation. It operates by matching haplotypes between query individuals and a reference database, then applying optimization techniques to determine the most likely ancestral proportions. It is particularly useful for analyzing large-scale genomic datasets where traditional model-based approaches might be computationally prohibitive.

## Core Workflow

The tool follows a five-step process that can be executed via the `all` subcommand for a consolidated run or through individual subcommands for granular control.

### 1. Data Preparation
Pastrami requires genotype data in Plink **TPED/TFAM** format. If starting with VCF files, convert them using Plink:
```bash
plink --vcf input.vcf.gz --recode transpose --out output_prefix
```

### 2. Consolidated Analysis
For a standard one-off ancestry estimation, use the `all` command:
```bash
./pastrami.py all \
    --reference-prefix [REF_FILES] \
    --query-prefix [QUERY_FILES] \
    --pop-group pop2group.txt \
    --haplotypes chrom.hap \
    --out-prefix results_run \
    --threads 20 \
    -v
```

### 3. Modular Subcommands
If the pipeline needs to be broken down (e.g., for debugging or reusing a built reference):
- `hapmake`: Generates the haplotype map file.
- `build`: Constructs the reference database from reference genotypes.
- `query`: Compares query genotypes against the built reference.
- `coanc`: Generates the copying fraction matrix (pairwise comparisons).
- `aggregate`: Performs the final ancestry fraction estimation and grouping.

## Expert Tips and CLI Patterns

### Optimization Parameters
- **SNP Density**: Control the resolution of haplotype blocks using `--min-snps` (default: 7) and `--max-snps`.
- **Genetic Maps**: Use `--map-dir` to point to a directory containing chromosome-specific genetic maps (`chr1.map`, `chr2.map`, etc.) to improve accuracy.
- **Population Mapping**: The `--pop-group` file is critical for aggregating fine-grained results into broader sub-continental categories (e.g., mapping specific tribes to a geographic region).

### Output Interpretation
The tool generates several `.Q` files:
- `<prefix>_estimates.Q`: Primary ancestry estimates.
- `<prefix>_fine_grain_estimates.Q`: Detailed population-level breakdowns.
- `<prefix>_paintings.Q`: Haplotype-level ancestry assignments.

### Performance
Always utilize the `--threads` flag to leverage multi-core processing, as the `coanc` and `query` steps are computationally intensive.



## Subcommands

| Command | Description |
|---------|-------------|
| aggregate | Aggregate Pastrami ancestry estimates based on population groupings |
| all | PASTRAMI tool for haplotype-based population structure analysis |
| build | Build reference copying matrices and pickle files for PASTRAMI |
| coanc | Calculate copying matrices for reference and query haplotypes |
| hapmake | Generate haplotype blocks based on genetic maps and SNP constraints |
| query | Query a reference pickle with TPED/TFAM input files to generate copying matrices. |

## Reference documentation
- [Pastrami README](./references/github_com_healthdisparities_pastrami_blob_master_README.md)
- [Pastrami Main Script](./references/github_com_healthdisparities_pastrami_blob_master_pastrami.py.md)
- [R Optimizer Details](./references/github_com_healthdisparities_pastrami_blob_master_outsourcedOptimizer.R.md)