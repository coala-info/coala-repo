# Introduction

Luca De Sano, Carlo Gambacorti Passerini, Rocco Piazza, Daniele Ramazzotti and Roberta Spinelli

#### October 30, 2025

#### Package

OncoScore 1.38.0

## 0.1 Overview

*OncoScore* is a tool to measure the association of genes to cancer based on citation
frequency in biomedical literature. The score is evaluated from PubMed literature by
dynamically updatable web queries.

## 0.2 Installing OncoScore

The R version of *OncoScore* can be installed from Github. To do so, we need to install the R packages *OncoScore* depends on and the devtools package.

```
# install OncoScore dependencies
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("biomaRt")

# install OncoScore library
if (!require("devtools")) install.packages("devtools")
library("devtools")
install_github("danro9685/OncoScore", ref = "master")

# load OncoScore library
library("OncoScore")
```

## 0.3 Debug

Please feel free to contact us if you have problems running our tool at daniele.ramazzotti1@gmail.com.