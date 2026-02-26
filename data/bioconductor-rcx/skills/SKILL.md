---
name: bioconductor-rcx
description: The RCX package manages biological networks in the CX format and enables conversions between iGraph and graphNEL objects. Use when user asks to handle CX network data, convert between graph formats, or interface with NDEx and Cytoscape.
homepage: https://bioconductor.org/packages/release/bioc/html/RCX.html
---


# bioconductor-rcx

## Overview

Use the Bioconductor R package **RCX** for: The package also provides conversion to and from objects of iGraph and graphNEL. The CX format is also used by the NDEx platform, a online commons for biological networks, and the network visualization software Cytocape.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("RCX")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.