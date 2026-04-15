---
name: pcaone
description: PCAone is a high-performance framework for fast and memory-efficient principal component analysis on large-scale genomic and single-cell datasets. Use when user asks to calculate principal components from PLINK or Beagle files, perform out-of-core PCA for datasets exceeding RAM, or handle biological noise and missingness in sequencing data.
homepage: https://github.com/Zilong-Li/PCAone
metadata:
  docker_image: "quay.io/biocontainers/pcaone:0.6.0--ha628be3_0"
---

# pcaone

## Overview
PCAone is a high-performance C++ framework designed for fast and memory-efficient PCA. It is specifically optimized for large-scale biobank data and single-cell RNA-seq datasets. Unlike general-purpose PCA tools, PCAone provides specialized algorithms for biological noise, such as missingness and low-depth sequencing uncertainty. Its core strength is the ability to switch between in-memory (in-core) and disk-based (out-of-core) processing, allowing users to analyze datasets that exceed physical RAM.

## Installation
The tool is available via Bioconda or as pre-compiled binaries.
```bash
# Via Conda
conda install bioconda::pcaone

# Via Binary (Linux example)
wget https://github.com/Zilong-Li/PCAone/releases/latest/download/PCAone-Linux.zip
unzip PCAone-Linux.zip
```

## Common CLI Patterns

### Basic Genetic Data Analysis
To calculate the top 10 PCs (default) from PLINK files using in-memory mode:
```bash
./PCAone -b data_prefix -n 12
```

### Handling Large Datasets (Out-of-Core)
If the dataset is larger than available RAM, specify the memory limit in GB to trigger out-of-core mode:
```bash
./PCAone -b data_prefix -m 8 -n 16
```

### Algorithm Selection (`--svd`)
Choose the SVD method based on your dataset size and accuracy requirements:
- `--svd 0`: Implicitly Restarted Arnoldi Method (IRAM). Good for general use.
- `--svd 1`: Single-pass Randomized SVD (sSVD). Faster for large data.
- `--svd 2`: Window-based Randomized SVD (winSVD). Recommended for tera-scale datasets.
- `--svd 3`: Full SVD. Only for small datasets in-core.

### Working with Missingness (EMU)
For datasets with a high proportion of missing data, use the EMU algorithm:
```bash
./PCAone -b data_prefix --emu
```

### Low-Coverage Sequencing (PCAngsd)
When working with genotype likelihoods (Beagle format) from low-depth NGS data:
```bash
./PCAone --beagle data.beagle.gz --pcangsd
```

### Non-Genetic Data (CSV)
For scRNA-seq or bulk RNA-seq data in CSV format (supports zstd compression):
```bash
./PCAone --csv data.csv.zst --skip-col 1 --skip-row 1
```

## Output Files
PCAone generates several files by default:
- `pcaone.eigvals`: The eigenvalues.
- `pcaone.eigvecs`: The eigenvectors (PCs) without a header.
- `pcaone.eigvecs2`: The eigenvectors with a header line (useful for R/Python).
- `pcaone.log`: Detailed execution log.

## Expert Tips
- **Backend Performance**: On Linux, building from source with Intel MKL is recommended to maximize threading performance via `libiomp5`.
- **LD Adjustments**: PCAone can account for population structure during LD pruning and clumping. Use the ancestry-adjusted LD statistics for more accurate results in structured populations.
- **Normalization**: For RNA-seq data, use `--scale` options (e.g., `--scale 1` for log1p) to normalize counts before PCA.
- **Threads**: Always specify `-n` to match your CPU cores, as the default may not be optimal for all environments.

## Reference documentation
- [PCAone GitHub Repository](./references/github_com_Zilong-Li_PCAone.md)
- [Bioconda PCAone Overview](./references/anaconda_org_channels_bioconda_packages_pcaone_overview.md)