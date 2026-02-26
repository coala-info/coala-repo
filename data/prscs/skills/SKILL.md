---
name: prscs
description: PRS-CS is a Bayesian regression tool that estimates SNP effect sizes for polygenic prediction by integrating GWAS summary statistics with LD reference panels. Use when user asks to calculate polygenic risk scores, estimate posterior SNP effect sizes, or perform polygenic prediction using continuous shrinkage priors.
homepage: https://github.com/getian107/PRScs
---


# prscs

## Overview
PRS-CS is a Python-based command-line tool designed for polygenic prediction. It utilizes a Bayesian regression framework with continuous shrinkage priors to estimate SNP effect sizes. By integrating GWAS summary data with external LD reference panels (such as those from the 1000 Genomes Project or UK Biobank), it provides a more sophisticated alternative to traditional clumping and thresholding methods. The tool is particularly effective because it can adapt to different genetic architectures by learning the global shrinkage parameter from the data.

## Installation and Setup
The most reliable way to install PRS-CS is via Bioconda:
```bash
conda install bioconda::prscs
```
Alternatively, clone the repository and ensure `scipy` and `h5py` are installed in your environment.

## Core Command Line Usage
The basic execution pattern requires specifying the reference panel, the target dataset's variant list, and the GWAS summary statistics.

```bash
python PRScs.py \
    --ref_dir=PATH_TO_LD_REFERENCE \
    --bim_prefix=TARGET_BIM_PREFIX \
    --sst_file=GWAS_SUMSTATS_FILE \
    --n_gwas=SAMPLE_SIZE \
    --out_dir=OUTPUT_PATH
```

### Key Arguments
- `--ref_dir`: Path to the directory containing the LD reference panel (e.g., `ldblk_1kg_eur`). The ancestry of the reference panel must match the ancestry of the GWAS sample.
- `--bim_prefix`: The prefix of the `.bim` file for the target/validation dataset. PRS-CS uses this to identify which SNPs are available in your specific study.
- `--sst_file`: The GWAS summary statistics file.
- `--n_gwas`: The total sample size of the GWAS.

## Data Format Requirements
PRS-CS is sensitive to input formatting. Following the 2023 updates, specific formats are recommended for accuracy.

### Recommended Format (BETA/OR + SE)
Using Standard Error (SE) is preferred over P-values to avoid accuracy loss due to p-value truncation (at 1e-323).
- **Columns**: `SNP`, `A1` (effect allele), `A2` (alternative allele), `BETA` (or `OR`), and `SE`.
- **Example**:
  ```text
  SNP          A1   A2   BETA      SE
  rs4970383    C    A    -0.0064   0.0090
  ```

### Alternative Format (BETA/OR + P)
If SE is unavailable, use P-values, but be aware that highly significant loci may have their effects underestimated if p-values are extremely small.

## Expert Tips and Best Practices

### Choosing the Global Shrinkage Parameter (--phi)
- **Auto Mode (Default)**: If `--phi` is not specified, PRS-CS learns the parameter from the data. This is generally recommended for most traits.
- **Fixed Phi**: If the GWAS sample size is small, the "auto" estimation may be unstable. In such cases, testing a range of fixed values (e.g., `1e-2`, `1e-4`, `1e-6`) in a validation set is advisable.

### Computational Efficiency
PRS-CS can be computationally intensive. To prevent the tool from consuming all available CPU resources via `scipy`/`mkl` threading, set environment variables before running the script:
```bash
export MKL_NUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
export OMP_NUM_THREADS=1
```

### Chromosome-Specific Processing
For large datasets, use the `--chrom` flag to run the analysis one chromosome at a time. This allows for parallelization across a compute cluster.
```bash
--chrom=22
```

### Reproducibility
Always use the `--seed` flag when running MCMC-based inferences to ensure that results can be replicated exactly.

## Reference documentation
- [prscs - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_prscs_overview.md)
- [GitHub - getian107/PRScs: Polygenic prediction via continuous shrinkage priors](./references/github_com_getian107_PRScs.md)