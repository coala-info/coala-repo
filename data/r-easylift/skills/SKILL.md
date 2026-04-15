---
name: r-easylift
description: This tool performs genomic coordinate liftover between different genome builds using the easylift R package. Use when user asks to convert GRanges objects or BED files between assembly versions like hg19, hg38, mm9, or mm10.
homepage: https://cran.r-project.org/web/packages/easylift/index.html
---

# r-easylift

name: r-easylift
description: Genomic coordinate liftover between genome builds (hg19, hg38, mm9, mm10) using the easylift R package. Use this skill when you need to convert GRanges objects or BED files between different assembly versions in R.

# r-easylift

## Overview
The `easylift` package provides a streamlined interface for performing genomic liftover (coordinate conversion) between common human and mouse genome builds. It simplifies the process of moving data between hg19/hg38 and mm9/mm10 by bundling the necessary chain files and providing a high-level wrapper for `GRanges` objects.

## Installation
To install the package from GitHub:
```R
devtools::install_github("caleblareau/easyLift")
```

## Core Functions

### easyLiftOver
The primary function for coordinate conversion. It can handle `GRanges` objects or file paths.

**Arguments:**
- `from`: A `GRanges` object or a path to a BED-like file (e.g., `.bed`, `.narrowPeak`).
- `map`: A string specifying the conversion or a path to a custom `.chain` file. Supported shortcuts:
  - `hg19_hg38`
  - `hg38_hg19`
  - `mm9_mm10`
  - `mm10_mm9`
- `to`: (Optional) Output file path if `from` is a file.

## Workflows

### Lifting over GRanges in R
```R
library(easyLift)
library(GenomicRanges)

# Create example GRanges in hg19
gr_hg19 <- GRanges(seqnames = "chr1", ranges = IRanges(start = 10000, end = 11000))

# Lift over to hg38
gr_hg38 <- easyLiftOver(gr_hg19, "hg19_hg38")
```

### Processing BED files
```R
# Converts the file and writes to "my_peaks.bedover" by default
easyLiftOver("my_peaks.bed", "mm9_mm10")

# Specify a custom output name
easyLiftOver("input.bed", "hg19_hg38", to = "output_hg38.bed")
```

### Using Custom Chain Files
If you need to perform liftover for builds not natively supported by the shortcuts (e.g., cross-species), provide the path to the `.chain` file:
```R
easyLiftOver(my_granges, map = "path/to/hg38ToMm10.over.chain")
```

## Tips
- **File Formats**: While `.bed` is standard, the function works on any file that resembles a BED format (tab-delimited with chromosome, start, and end in the first three columns).
- **Chain Files**: The package bundles common human and mouse chains, so no external downloads are required for hg19/hg38 or mm9/mm10 conversions.
- **Output**: When using files as input, the function returns a message confirming the write location. When using `GRanges`, it returns a new `GRanges` object.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)