# Anatomy of the `methyvimData` package

Nima Hejazi

#### *2018-11-01*

# Contents

* [0.1 Introduction](#introduction)
* [0.2 Data](#data)

## 0.1 Introduction

This package is designed to accompany the `methyvim` analysis package by
providing example data for use with the statistical routines made available in
that package. Generally speaking, this package will likely be useless to you
without the `methyvim` package. Please consider consulting the vignettes that
accompany `methyvim`.

---

## 0.2 Data

This package contains a single data set. The data object is of class
`GenomicRatioSet`, an extension of the `SummarizedExperiment` container class
provided by the package `minfi`.

We can load and view the data set like so

```
library(methyvimData)
data(grsExample)
grsExample
```

```
## class: GenomicRatioSet
## dim: 400 210
## metadata(0):
## assays(2): Beta M
## rownames(400): cg23578515 cg06747907 ... cg01715842 cg09895959
## rowData names(0):
## colnames(210): V2 V3 ... V397 V398
## colData names(2): exp outcome
## Annotation
##   array: IlluminaHumanMethylationEPIC
## Preprocessing
##   Method: NA
##   minfi version: NA
##   Manifest version: NA
```