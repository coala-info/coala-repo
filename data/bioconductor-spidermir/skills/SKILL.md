---
name: bioconductor-spidermir
description: "SpidermiR queries, downloads, and integrates gene network data with validated and predicted miRNA-target interactions. Use when user asks to download GeneMania network data, integrate miRNA-target interactions from various databases, or perform network analysis and visualization."
homepage: https://bioconductor.org/packages/3.6/bioc/html/SpidermiR.html
---


# bioconductor-spidermir

## Overview

Use the Bioconductor R package **SpidermiR** for: the package provides multiple methods for query, prepare and download network data (GeneMania), and the integration with validated and predicted miRNA data (mirWalk, miR2Disease,miRTar, miRTarBase, miRandola,Pharmaco-miR,DIANA, Miranda, PicTar and TargetScan) and the use of standard analysis (igraph) and visualization methods (networkD3).

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("SpidermiR")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.