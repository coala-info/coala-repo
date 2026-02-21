# Introduction

Daniele Ramazzotti, Fabrizio Angaroni, Davide Maspero, Alex Graudenxi, Luca De Sano and Gianluca Ascolani

#### October 30, 2025

#### Package

VERSO 1.20.0

## 0.1 Overview

*VERSO* is an algorithmic framework that processes variants profiles from viral samples, to produce phylogenetic models of viral evolution
from clonal variants and to subsequently quantify the intra-host genomic diversity of samples. *VERSO* includes two separate and subsequent
steps; in this repository we provide an R implementation of VERSO STEP 1.

## 0.2 Installing VERSO

The R version of *VERSO* can be installed from Bioconductor. To do so, we need to install the R packages *VERSO* depends on and the devtools package.

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("VERSO")
```

## 0.3 Debug

Please feel free to contact us if you have problems running our tool at daniele.ramazzotti1@gmail.com or d.maspero@campus.unimib.it.