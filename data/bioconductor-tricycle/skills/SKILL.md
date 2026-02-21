---
name: bioconductor-tricycle
description: The package contains functions to infer and visualize cell cycle process using Single Cell RNASeq data. It exploits the idea of transfer learning, projecting new data to the previous learned biologically interpretable space. We provide a pre-learned cell cycle space, which could be used to infer cell cycle time of human and mouse single cell samples. In addition, we also offer functions to visualize cell cycle time on different embeddings and functions to build new reference.
homepage: https://bioconductor.org/packages/release/bioc/html/tricycle.html
---

# bioconductor-tricycle

## Overview

Use the Bioconductor R package **tricycle** for: The package contains functions to infer and visualize cell cycle process using Single Cell RNASeq data. It exploits the idea of transfer learning, projecting new data to the previous learned biologically interpretable space. We provide a pre-learned cell cycle space, which could be used to infer cell cycle time of human and mouse single cell samples. In addition, we also offer functions to visualize cell cycle time on different embeddings and functions to build new reference.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("tricycle")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.