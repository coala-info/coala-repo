---
name: r-rrbgen
description: rrbgen is an R package for reading and writing BGEN v1.3 files containing bi-allelic SNPs and diploid samples. Use when user asks to load sample names, extract variant information, read genotype probabilities, or write BGEN files.
homepage: https://cran.r-project.org/web/packages/rrbgen/index.html
---


# r-rrbgen

## Overview
`rrbgen` is a lightweight R package designed for reading and writing BGEN files. It specifically supports BGEN v1.3 (Layout 2, Compressed SNP Blocks) for bi-allelic SNPs with diploid samples. It is optimized for performance and minimal dependencies, often used as an alternative to `rbgen` for specific workflows like those in the STITCH package.

## Installation
To install the package from CRAN:
```R
install.packages("rrbgen")
```

To install the development version from GitHub:
```R
# Requires devtools
devtools::install_github("rwdavies/rrbgen")
```

## Core Functions

### Loading Data
The package provides three main levels of data extraction from BGEN files:

1. **Load Sample Names Only**
   ```R
   samples <- rrbgen_load_samples("path/to/file.bgen")
   ```

2. **Load Variant Information Only**
   ```R
   variants <- rrbgen_load_variant_info("path/to/file.bgen")
   ```

3. **Load Full Data (Samples, Variants, and Probabilities)**
   ```R
   data <- rrbgen_load("path/to/file.bgen")
   ```

### Subset Loading
You can load specific subsets of data by providing variant IDs or sample names. Note that this still performs a full pass over the file but avoids unnecessary decompressions.
```R
subset_data <- rrbgen_load("path/to/file.bgen",
    vars_to_get = c("SNPID_1", "SNPID_5"),
    samples_to_get = c("sample_01", "sample_05")
)
```

## Workflows and Constraints

### Supported Format Specifications
The package is highly specialized. To avoid crashes, ensure the BGEN files meet these criteria:
- **BGEN Version**: v1.3
- **Layout**: 2
- **Compression**: CompressedSNPBlocks = 1 (zlib/zstd)
- **Genetics**: Bi-allelic SNPs only
- **Ploidy**: Diploid (ploidy 2)
- **Bit Depth**: Supports 8, 16, 24, or 32 bits per probability

### Writing BGEN Files
`rrbgen` is frequently used to write BGEN output from imputation or phasing workflows. Ensure that the input matrices for probabilities match the expected dimensions (Samples x Genotypes) for the variants being written.

## Reference documentation
- [README.md](./references/README.md)
- [CHANGELOG.md](./references/CHANGELOG.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)