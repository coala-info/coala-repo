---
name: bioconductor-pgxrpi
description: The bioconductor-pgxrpi package provides an R interface for the Progenetix REST API to retrieve and visualize curated oncogenomic data. Use when user asks to access genomic profiles from the Progenetix database, retrieve data using the Beacon v2 protocol, or visualize cancer genomic information.
homepage: https://bioconductor.org/packages/release/bioc/html/pgxRpi.html
---


# bioconductor-pgxrpi

## Overview

Use the Bioconductor R package **pgxRpi** for: The package is an R wrapper for Progenetix REST API built upon the Beacon v2 protocol. Its purpose is to provide a seamless way for retrieving genomic data from Progenetix database—an open resource dedicated to curated oncogenomic profiles. Empowered by this package, users can effortlessly access and visualize data from Progenetix.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pgxRpi")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.