---
name: bioconductor-sradb
description: "SRAdb is a Bioconductor package for querying Sequence Read Archive metadata and downloading genomic data files using a local SQLite database. Use when user asks to query SRA metadata, download fastq or sra files, or perform high-speed data transfers using Aspera Connect."
homepage: https://bioconductor.org/packages/release/bioc/html/SRAdb.html
---


# bioconductor-sradb

## Overview

Use the Bioconductor R package **SRAdb** for: the package make querying metadata very flexible and powerful.  fastq and sra files can be downloaded for doing alignment locally. Beside ftp protocol, the SRAdb has funcitons supporting fastp protocol (ascp from Aspera Connect) for faster downloading large data files over long distance. The SQLite database is updated regularly as new data is added to SRA and can be downloaded at will for the most up-to-date metadata.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("SRAdb")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.