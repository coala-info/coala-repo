# Introduction

Daniele Ramazzotti, Bo Wang, Luca De Sano and Serafim Batzoglou

#### October 30, 2025

#### Package

SIMLR 1.36.0

## 0.1 Overview

Single-cell RNA-seq technologies enable high throughput gene expression measurement of individual cells, and allow the discovery of
heterogeneity within cell populations. Measurement of cell-to-cell gene expression similarity is critical for the identification,
visualization and analysis of cell populations. However, single-cell data introduce challenges to conventional measures of gene expression
similarity because of the high level of noise, outliers and dropouts. We develop a novel similarity-learning framework, *SIMLR* (Single-cell
Interpretation via Multi-kernel LeaRning), which learns an appropriate distance metric from the data for dimension reduction,
clustering and visualization..

## 0.2 Installing SIMLR

The R version of *SIMLR* can be installed from Github. To do so, we need to install the R packages *SIMLR* depends on and the devtools package.

```
# install SIMLR dependencies
if (!require("Matrix")) install.packages("Matrix")
if (!require("Rcpp")) install.packages("Rcpp")
if (!require("RcppAnnoy")) install.packages("RcppAnnoy")
if (!require("RSpectra")) install.packages("RSpectra")
if (!require("pracma")) install.packages("pracma")

# install SIMLR library
if (!require("devtools")) install.packages("devtools")
library("devtools")
install_github("BatzoglouLabSU/SIMLR", ref = "master")

# load SIMLR library
library("SIMLR")
```

## 0.3 Debug

Please feel free to contact us if you have problems running our tool at daniele.ramazzotti1@gmail.com or wangbo.yunze@gmail.com.