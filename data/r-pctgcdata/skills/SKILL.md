---
name: r-pctgcdata
description: R package pctgcdata (documentation from project home).
homepage: https://cran.r-project.org/web/packages/pctgcdata/index.html
---

# r-pctgcdata

name: r-pctgcdata
description: Provides GC percentage data for human and mouse genomes to support GC normalization of tumor-normal log-ratios. Use this skill when performing genomic copy number analysis with the 'facets' package or when requiring GC content datasets for specific genome builds (hg18, hg19, hg38, mm9, mm10).

# r-pctgcdata

## Overview

The `pctgcdata` package provides R datasets containing GC percentages for human and mouse genomes. Its primary purpose is to facilitate GC normalization of tumor-normal log-ratios, a critical step in analyzing genomic copy number variations. This package is a required dependency for the `facets` (Fractional Allele-Specific Copy Number Estimates from Tumor Sequencing) package.

## Installation

To install the package from CRAN:

```R
install.packages("r-pctgcdata")
```

## Usage

### Loading the Data
The package is typically loaded alongside `facets` to provide the necessary genomic context for normalization.

```R
library(pctgcdata)
```

### Supported Genome Builds
The package includes pre-computed GC content data for the following builds:
- **Human:** hg18, hg19, hg38
- **Mouse:** mm9, mm10

### User-Defined Genomes
As of version 0.3.0, the package supports a `udef` option for the `gbuild` parameter. This allows users to provide their own GC percentage data for genomes not natively included in the package. This is particularly useful for researchers working with non-standard model organisms or custom assemblies.

### Integration with facets
When using the `facets` workflow, `pctgcdata` works behind the scenes. When you specify a genome build (e.g., `hg19`) in `facets` functions, the corresponding GC data is retrieved from this package to correct for sequencing biases related to GC content.

## Tips
- Ensure the version of `pctgcdata` is at least 0.3.0 if you need to use the `udef` option for custom genomes.
- If you are developing tools for other genomes, you can reference the experimental code at `soccin/mkGCPct` on GitHub to see how the GC percentage data is generated.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)