---
name: bioconductor-paxtoolsr
description: This R package provides functions to interact with BioPAX files and query the Pathway Commons molecular interaction database. Use when user asks to process BioPAX OWL files, query the Pathway Commons database, or retrieve molecular interaction data from sources like Reactome and BioGRID.
homepage: https://bioconductor.org/packages/3.8/bioc/html/paxtoolsr.html
---


# bioconductor-paxtoolsr

## Overview

Use the Bioconductor R package **paxtoolsr** for: The package provides a set of R functions for interacting with BioPAX OWL files using Paxtools and the querying Pathway Commons (PC) molecular interaction database that are hosted by the Computational Biology Center at Memorial Sloan-Kettering Cancer Center (MSKCC). Pathway Commons databases include: BIND, BioGRID, CORUM, CTD, DIP, DrugBank, HPRD, HumanCyc, IntAct, KEGG, MirTarBase, Panther, PhosphoSitePlus, Reactome, RECON, TRANSFAC.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("paxtoolsr")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.