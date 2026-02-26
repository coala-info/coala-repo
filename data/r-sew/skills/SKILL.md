---
name: r-sew
description: The r-sew tool performs reference panel-free phasing and genotype imputation for long-read sequencing data using an expectation-maximization algorithm. Use when user asks to phase long-read BAM files into haplotypes, output imputed genotypes in VCF format, or perform probabilistic read partitioning without a reference panel.
homepage: https://cran.r-project.org/web/packages/sew/index.html
---


# r-sew

name: r-sew
description: Reference panel-free long-read phasing and genotype imputation for single samples. Use when Claude needs to phase sequencing reads (BAM format) into haplotypes or output imputed genotypes in VCF format using the sew R package.

## Overview

The `sew` package provides an expectation-maximization (EM) algorithm for reference panel-free phasing of long-read sequencing data. It probabilistically partitions reads into two haplotypes and determines model parameters to output phased genotypes. It is particularly effective for high-coverage long-read data (e.g., Oxford Nanopore).

## Installation

Install the package from CRAN:

```R
install.packages("sew")
```

Note: The package depends on several Bioconductor and CRAN packages. Ensure dependencies are satisfied if installing from source.

## Core Workflow

The primary interface is the `SEW()` function. It requires a BAM file, a list of positions to phase, and a phase file.

### Basic Usage

```R
library(sew)

SEW(
  chr = "10",
  bamlist = "bamlist.txt",
  posfile = "posfile.txt",
  phasefile = "phasefile.txt",
  outputdir = "./output/",
  sampleName = "Sample01"
)
```

### Required Inputs
- `chr`: The chromosome to process (string).
- `bamlist`: Path to a text file containing paths to BAM files (one per line).
- `posfile`: Path to a text file with positions to phase (columns: chromosome, position, allele1, allele2).
- `phasefile`: Path to a VCF or similar file containing initial phasing information or sites to be phased.
- `outputdir`: Directory where VCF results and logs will be saved.

## Key Parameters and Heuristics

The EM algorithm can get stuck in local maxima (switch errors). `sew` uses a "flipping" heuristic to improve global reconstruction.

- `unwindIterations`: A vector of iterations at which the heuristic checks for haplotype flips.
  - Example: `unwindIterations = c(30, 60)`
- `maxIterations`: Total number of EM iterations (default is usually sufficient).
- `nCores`: Number of cores for parallel processing.

## Tips for Success

1. **High Coverage**: The algorithm performs best with high-depth long-read data where reads span multiple heterozygous sites.
2. **Local Maxima**: If you observe frequent switch errors, adjust `unwindIterations` to allow the heuristic to run more frequently or at different stages of convergence.
3. **Memory Management**: For large chromosomes, ensure sufficient RAM is available as the package processes read-site overlaps in memory.

## Reference documentation

- [CHANGELOG.md](./references/CHANGELOG.md)
- [Options.md](./references/Options.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)