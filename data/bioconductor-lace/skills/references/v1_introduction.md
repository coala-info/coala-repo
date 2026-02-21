# Introduction

Daniele Ramazzotti, Fabrizio Angaroni, Davide Maspero, Alex Graudenxi, Luca De Sano and Gianluca Ascolani

#### October 30, 2025

#### Package

LACE 2.14.0

## 0.1 Overview

*LACE* is an algorithmic framework that processes single-cell somatic mutation profiles from cancer samples collected at different
time points and in distinct experimental settings, to produce longitudinal models of cancer evolution. The approach solves a Boolean Matrix
Factorization problem with phylogenetic constraints, by maximizing a weighted likelihood function computed on multiple time points.

## 0.2 Installing LACE

The R version of *LACE* can be installed from BioConductor. To do so, we need to install the R packages *LACE* depends on and the devtools package.

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("LACE")
```

## 0.3 Debug

Please feel free to contact us if you have problems running our tool at daniele.ramazzotti1@gmail.com or d.maspero@campus.unimib.it.