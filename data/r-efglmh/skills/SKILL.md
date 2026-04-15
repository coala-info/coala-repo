---
name: r-efglmh
description: This R package provides specialized functions for manipulating, formatting, and analyzing microhaplotype and genotype data within a tidyverse-compatible framework. Use when user asks to process microhaplotype strings, convert genotype data formats, or perform tidy genetic data manipulation.
homepage: https://cran.r-project.org/web/packages/efglmh/index.html
---

# r-efglmh

name: r-efglmh
description: Specialized R package for manipulating microhaplotype (microhap) and other genotype data. Use this skill when you need to process, format, or analyze microhap data within the R environment, particularly for workflows involving tidyverse-compatible genotype manipulation.

## Overview

The `efglmh` package provides a suite of functions specifically designed for the Eagle Fish Genetics Lab (EFGL) to handle microhaplotype data. It is built with `tidyverse` principles, making it highly compatible with `dplyr` and `tidyr` workflows. It facilitates the conversion, cleaning, and preparation of genotype data for downstream genetic analysis.

## Installation

Install the package directly from GitHub using `devtools`:

```R
# install.packages("devtools")
devtools::install_github("delomast/EFGLmh")
```

To include documentation and vignettes during installation:

```R
devtools::install_github("delomast/EFGLmh", build_vignettes = TRUE)
```

## Core Workflows

### Data Structure
The package typically expects genotype data in a "long" format where each row represents an individual-locus combination, or a "tidy" format compatible with `tidyverse` operations.

### Common Operations
- **Genotype Manipulation**: Functions are provided to split, combine, and reformat microhaplotype strings.
- **Tidyverse Integration**: Use `efglmh` functions within `mutate()` or `summarise()` calls to process large batches of genetic markers.
- **Microhaplotype Specifics**: Handling multi-SNP loci (microhaps) where alleles are represented as concatenated nucleotide strings (e.g., "AT", "GC").

### Viewing Documentation
Since this is a specialized lab package, refer to the built-in vignette for detailed examples:

```R
browseVignettes("EFGLmh")
```

## Tips for Success
- **Check Allele Formats**: Ensure your microhaplotype alleles are consistently formatted (e.g., all uppercase) before using manipulation functions.
- **Pipe Compatibility**: Most functions are designed to work with the `%>%` or `|>` operators.
- **Missing Data**: Be aware of how the package handles `NA` or missing genotype strings (usually "00" or "--") during transformation.

## Reference documentation

- [README](./references/README.md)
- [Articles](./references/articles.md)
- [Home Page](./references/home_page.md)