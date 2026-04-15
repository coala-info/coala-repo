---
name: r-stitch
description: This tool performs reference panel-free, read-aware genotype imputation from low-coverage sequencing data by modeling samples as a mosaic of ancestral haplotypes. Use when user asks to perform genotype imputation without a reference panel, impute genotypes from low-coverage BAM files, or initialize ancestral haplotypes from existing reference data for low-depth sequencing projects.
homepage: https://cran.r-project.org/web/packages/stitch/index.html
---

# r-stitch

name: r-stitch
description: Reference panel-free, read-aware genotype imputation from low-coverage sequencing data using the STITCH R package. Use this skill when you need to perform imputation on BAM files without a reference panel, or when you need to initialize ancestral haplotypes from existing reference data for low-depth sequencing projects.

# r-stitch

## Overview

STITCH (Sequencing To Imputation Through Constructing Haplotypes) is an R package designed for genotype imputation from low-coverage sequencing data without requiring a reference panel. It works by modeling the sequenced samples as a mosaic of $K$ ancestral haplotypes, which are learned directly from the sequencing reads in BAM format. It is particularly effective for diverse populations or species where high-quality reference panels are unavailable.

## Installation

To install the STITCH package from CRAN:

```R
install.packages("STITCH")
```

Note: STITCH requires `bgzip` to be available in your system PATH.

## Core Workflow

The primary function is `STITCH()`. It requires a list of BAM files, a set of positions to genotype, and a chromosome to process.

### Basic Usage

```R
library(STITCH)

STITCH(
  tempdir = tempdir(),
  chr = "chr19",
  bamlist = "bamlist.txt",
  posfile = "pos.txt",
  genfile = "gen.txt",
  outputdir = getwd(),
  K = 4,
  nGen = 100,
  nCores = 1
)
```

### Key Parameters

- `chr`: The chromosome to process (e.g., "chr1").
- `bamlist`: Path to a text file containing paths to BAM files (one per line).
- `posfile`: Path to a file with positions to genotype (format: CHR, POS, REF, ALT).
- `genfile`: Path to a file with sample names (one per line).
- `K`: The number of ancestral haplotypes. Larger $K$ increases accuracy but increases runtime (proportional to $K^2$ for diploid).
- `nGen`: Number of generations since the founding of the population (used to estimate recombination rate).
- `method`: 
    - `"diploid"`: Best accuracy, runtime $O(K^2)$.
    - `"pseudoHaploid"`: Faster for large $K$, runtime $O(K)$.
    - `"diploid-inbred"`: For completely inbred samples, runtime $O(K)$.
- `niterations`: Number of EM iterations (default is 40).

## Optimization and Performance

- **Memory Management**: Set `keepSampleReadsInRAM = FALSE` (default) for large datasets to save RAM. Use `inputBundleBlockSize` to group temporary files.
- **Speed**: 
    - Increase `nCores` for parallel processing.
    - Set `gridWindowSize` (e.g., 10000) to run imputation on physical windows rather than per-SNP, though this may reduce accuracy.
    - Adjust `outputSNPBlockSize` to control how many SNPs are written to disk at once.
- **Quality Control**: STITCH outputs INFO scores in the VCF. Use these to filter low-confidence imputed sites.

## Using Reference Panels

While STITCH is "reference-free," it can use reference haplotypes for initialization:
- If `niterations > 1`, reference haplotypes initialize the EM algorithm.
- If `niterations = 1`, samples are imputed directly from the provided reference.
- Reference files should follow the `.hap.gz` and `.legend.gz` format (similar to QUILT/IMPUTE2).

## Reference documentation

- [CHANGELOG.md](./references/CHANGELOG.md)
- [Options.md](./references/Options.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [plots.md](./references/plots.md)
- [summarize_benchmarking.md](./references/summarize_benchmarking.md)