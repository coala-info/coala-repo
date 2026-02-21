---
name: bioconductor-crisprseek
description: The package encompasses functions to find potential guide RNAs for the CRISPR-based genome-editing systems including the Base Editors and the Prime Editors when supplied with target sequences as input. Users have the flexibility to filter resulting guide RNAs based on parameters such as the absence of restriction enzyme cut sites or the lack of paired guide RNAs. The package also facilitates genome-wide exploration for off-targets, offering features to score and rank off-targets, retrieve flanking sequences, and indicate whether the hits are located within exon regions. All detected guide RNAs are annotated with the cumulative scores of the top5 and topN off-targets together with the detailed information such as mismatch sites and restrictuion enzyme cut sites. The package also outputs INDELs and their frequencies for Cas9 targeted sites.
homepage: https://bioconductor.org/packages/release/bioc/html/CRISPRseek.html
---

# bioconductor-crisprseek

## Overview

Use the Bioconductor R package **CRISPRseek** for: The package encompasses functions to find potential guide RNAs for the CRISPR-based genome-editing systems including the Base Editors and the Prime Editors when supplied with target sequences as input. Users have the flexibility to filter resulting guide RNAs based on parameters such as the absence of restriction enzyme cut sites or the lack of paired guide RNAs. The package also facilitates genome-wide exploration for off-targets, offering features to score and rank off-targets, retrieve flanking sequences, and indicate whether the hits are located within exon regions. All detected guide RNAs are annotated with the cumulative scores of the top5 and topN off-targets together with the detailed information such as mismatch sites and restrictuion enzyme cut sites. The package also outputs INDELs and their frequencies for Cas9 targeted sites.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("CRISPRseek")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.