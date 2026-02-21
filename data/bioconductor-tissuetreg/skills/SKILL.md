---
name: bioconductor-tissuetreg
description: "The package provides ready to use epigenomes (obtained from TWGBS) and transcriptomes (RNA-seq) from various tissues as obtained in the study (Delacher and Imbusch 2017, PMID: 28783152). Regulatory T cells (Treg cells) perform two distinct functions: they maintain self-tolerance, and they support organ homeostasis by differentiating into specialized tissue Treg cells. The underlying dataset characterises the epigenetic and transcriptomic modifications for specialized tissue Treg cells."
homepage: https://bioconductor.org/packages/release/data/experiment/html/tissueTreg.html
---

# bioconductor-tissuetreg

## Overview

Use the Bioconductor R package **tissueTreg** for: The package provides ready to use epigenomes (obtained from TWGBS) and transcriptomes (RNA-seq) from various tissues as obtained in the study (Delacher and Imbusch 2017, PMID: 28783152). Regulatory T cells (Treg cells) perform two distinct functions: they maintain self-tolerance, and they support organ homeostasis by differentiating into specialized tissue Treg cells. The underlying dataset characterises the epigenetic and transcriptomic modifications for specialized tissue Treg cells.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("tissueTreg")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.