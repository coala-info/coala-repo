---
name: r-quilt
description: r-quilt performs rapid genotype imputation and calling from low-coverage whole genome sequencing data using large reference panels within an R environment. Use when user asks to impute genotypes from low-coverage sequencing, perform NIPT mother-fetal genome imputation, or call variants from ancient DNA and short or long-read data.
homepage: https://cran.r-project.org/web/packages/quilt/index.html
---

# r-quilt

name: r-quilt
description: Expert guidance for using the QUILT R package for rapid genotype imputation from low-coverage whole genome sequencing (lc-WGS) using large reference panels. Use this skill when performing imputation from short-read, long-read, ancient DNA, or cell-free DNA (NIPT) data within an R environment.

# r-quilt

## Overview

QUILT (and its successor QUILT2) is a fast, memory-efficient R and C++ library designed for genotype calling and imputation from low-coverage sequence data. It is base-quality aware and operates on a per-read basis, making it suitable for diverse sequencing technologies (Illumina, Oxford Nanopore) and specialized applications like ancient DNA or Non-Invasive Prenatal Testing (NIPT).

Key features include:
- **QUILT2 Algorithm**: Uses msPBWT (multi-sample Positional Burrows-Wheeler Transform) and a two-stage strategy for rare and common variants.
- **Versatility**: Supports mother/fetal genome imputation from NIPT cfDNA.
- **Scalability**: Handles reference panels with hundreds of thousands of haplotypes.

## Installation

Install the package and its dependencies from GitHub using `remotes`:

```R
install.packages("remotes")
remotes::install_github("rwdavies/STITCH/STITCH")
remotes::install_github("rwdavies/mspbwt/mspbwt")
remotes::install_github("rwdavies/QUILT/QUILT")
```

## Core Workflow

The primary interface in R is the `QUILT` function. It requires a reference panel (VCF), a list of BAM files, and a genetic map.

### Basic Imputation

```R
library(QUILT)

QUILT(
  outputdir = "quilt_output",
  chr = "chr20",
  regionStart = 2000001,
  regionEnd = 4000000,
  buffer = 500000,
  bamlist = "path/to/bamlist.txt",
  genetic_map_file = "path/to/genetic_map.txt.gz",
  reference_vcf_file = "path/to/reference.vcf.gz",
  nGen = 100,
  save_prepared_reference = TRUE
)
```

### Key Parameters

- `bamlist`: A text file with one path to a BAM/CRAM file per line.
- `reference_vcf_file`: The reference panel in VCF format (required for QUILT2).
- `use_mspbwt`: Set to `TRUE` to enable the QUILT2 algorithm (faster for large panels).
- `impute_rare_common`: Set to `TRUE` for the two-stage imputation strategy.
- `nGen`: Number of generations since the founding of the population (affects recombination scaling).

### NIPT Imputation

To impute mother and fetal genomes from cell-free DNA:

```R
QUILT(
  ...,
  method = "nipt",
  fflist = "path/to/fetal_fractions.txt"
)
```
*Note: `fflist` must be a text file with one fetal fraction value per line, corresponding to the order in `bamlist`.*

## Best Practices

1. **Reference Preparation**: Use `save_prepared_reference = TRUE` during the first run. This saves a processed version of the reference panel, significantly speeding up subsequent runs on the same region.
2. **Memory Management**: For very large reference panels, ensure `use_mspbwt = TRUE` is set to minimize memory footprint.
3. **Region Buffering**: Always include a `buffer` (e.g., 500kb) around your target region to avoid edge effects in imputation accuracy.
4. **Input Validation**: Ensure BAM files are indexed and the chromosome names match exactly between the BAM, VCF, and genetic map.

## Reference documentation

- [QUILT2 README](./references/README.md)
- [QUILT2 Tutorial](./references/README_QUILT2.org.md)
- [QUILT1 README](./references/README_QUILT1.md)
- [QUILT-HLA README](./references/README_QUILT-HLA.md)
- [Package Changelog](./references/CHANGELOG.md)
- [Scientific Articles](./references/articles.md)
- [Project Home Page](./references/home_page.md)