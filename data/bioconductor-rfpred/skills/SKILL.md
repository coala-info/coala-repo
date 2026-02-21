---
name: bioconductor-rfpred
description: the package gives rfPred scores to missense variants identified by the chromosome, the position (hg19 version), the referent and alternative nucleotids and the uniprot identifier of the protein. Note that for using the package, the user has to download the TabixFile and index (approximately 3.3 Go).
homepage: https://bioconductor.org/packages/release/bioc/html/rfPred.html
---

# bioconductor-rfpred

## Overview

Use the Bioconductor R package **rfPred** for: the package gives rfPred scores to missense variants identified by the chromosome, the position (hg19 version), the referent and alternative nucleotids and the uniprot identifier of the protein. Note that for using the package, the user has to download the TabixFile and index (approximately 3.3 Go).

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("rfPred")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.