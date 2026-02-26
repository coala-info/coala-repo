---
name: bioconductor-procoil
description: This package predicts whether a coiled coil sequence is more likely to form a dimer or a trimer and generates associated prediction profiles. Use when user asks to predict coiled coil oligomerization states, calculate residue-specific prediction profiles, or visualize prediction results as curves and heatmaps.
homepage: https://bioconductor.org/packages/release/bioc/html/procoil.html
---


# bioconductor-procoil

## Overview

Use the Bioconductor R package **procoil** for: The package allows for predicting whether a coiled coil sequence (amino acid sequence plus heptad register) is more likely to form a dimer or more likely to form a trimer. Additionally to the prediction itself, a prediction profile is computed which allows for determining the strengths to which the individual residues are indicative for either class. Prediction profiles can also be visualized as curves or heatmaps.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("procoil")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.