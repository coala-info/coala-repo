---
name: bioconductor-mutationalpatterns
description: "The package covers a wide range of patterns including: mutational signatures, transcriptional and replicative strand bias, lesion segregation, genomic distribution and association with genomic features, which are collectively meaningful for studying the activity of mutational processes. The package works with single nucleotide variants (SNVs), insertions and deletions (Indels), double base substitutions (DBSs) and larger multi base substitutions (MBSs). The package provides functionalities for both extracting mutational signatures de novo and determining the contribution of previously identified mutational signatures on a single sample level. MutationalPatterns integrates with common R genomic analysis workflows and allows easy association with (publicly available) annotation data."
homepage: https://bioconductor.org/packages/release/bioc/html/MutationalPatterns.html
---

# bioconductor-mutationalpatterns

## Overview

Use the Bioconductor R package **MutationalPatterns** for: The package covers a wide range of patterns including: mutational signatures, transcriptional and replicative strand bias, lesion segregation, genomic distribution and association with genomic features, which are collectively meaningful for studying the activity of mutational processes. The package works with single nucleotide variants (SNVs), insertions and deletions (Indels), double base substitutions (DBSs) and larger multi base substitutions (MBSs). The package provides functionalities for both extracting mutational signatures de novo and determining the contribution of previously identified mutational signatures on a single sample level. MutationalPatterns integrates with common R genomic analysis workflows and allows easy association with (publicly available) annotation data.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MutationalPatterns")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.