# Accessing CellMiner Data

#### 4 November 2025

# Contents

* [1 Overview](#overview)
* [2 Data Sources](#data-sources)
* [3 Basics](#basics)
  + [3.1 Installation](#installation)
  + [3.2 Getting Started](#getting-started)
* [4 Data Structure](#data-structure)
  + [4.1 Molecular Data](#molecular-data)
    - [4.1.1 Accessing sampleData](#accessing-sampledata)
    - [4.1.2 Adding additional data to a MolData object’s eSetList](#adding-additional-data-to-a-moldata-objects-esetlist)
  + [4.2 Drug Data](#drug-data)
    - [4.2.1 featureData for Drug Activities](#featuredata-for-drug-activities)
    - [4.2.2 sampleData for DrugData Objects](#sampledata-for-drugdata-objects)
* [5 Session Information](#session-information)
* [6 References](#references)
* **Appendix**

# 1 Overview

The NCI-60 cancer cell line panel has been used over the course of several decades as an anti-cancer drug screen. This panel was developed as part of the Developmental Therapeutics Program (DTP, <http://dtp.nci.nih.gov/>) of the U.S. National Cancer Institute (NCI). Thousands of compounds have been tested on the NCI-60, which have been extensively characterized by many platforms for gene and protein expression, copy number, mutation, and others (Reinhold, et al., 2012). The purpose of the CellMiner project (<http://discover.nci.nih.gov/cellminer>) has been to integrate data from multiple platforms used to analyze the NCI-60 and to provide a powerful suite of tools for exploration of NCI-60 data.

# 2 Data Sources

All data in the rcellminerData package has been retrieved directly from the CellMiner project (<http://discover.nci.nih.gov/cellminer>) website. CellMiner uses the public drugs from the Developmental Therapeutics Program (DTP, <https://dtp.nci.nih.gov>), who generates the data. For those who wish to access activity data that has failed our quality control, it is available at the CellMiner Download Data Sets page (<https://discover.nci.nih.gov/cellminer/loadDownload.do>) by downloading the **Raw Data Set: Compound activity:DTP NCI-60**. Activities quality control fails if there is minimal range across cell lines, or the experiments are irreproducible. Both the data downloaded and the scripts used to generate this data package are contained within the **inst/extdata** folder of the package.

# 3 Basics

## 3.1 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("rcellminer")
BiocManager::install("rcellminerData")
```

## 3.2 Getting Started

Load **rcellminer** and **rcellminerData** packages:

```
library(rcellminer)
library(rcellminerData)
```

A list of all accessible vignettes and methods is available with the following command.

```
help.search("rcellminerData")
```

Specific information about the drug data or the molecular profiling data can also be retrieved

```
help("drugData")
help("molData")
```

# 4 Data Structure

Data **rcellminerData** exists as two S4 class objects: molData and drugData. molData contains results for molecular assays (e.g. genomics, proteomics, etc) that have been performed on the NCI-60 and drugData contains results for drug response assays (Reinhold, et al., 2012).

## 4.1 Molecular Data

**molData** is an instance of the MolData S4 class composed of 2 slots: eSetList and sampleData. eSetList is a list of eSet objects that can be of different dimensions; **NOTE:** in concept this is similar to eSet objects, but differs in that the eSet assayData slot requires that matrices have equal dimensions. The second slot, sampleData, is a MIAxE class instance, but its accessor, getSampleData(), returns a data.frame containing information for each sample. Below are examples of possible operations that can be performed on the MolData object.

```
# Get the types of feature data in a MolData object.
names(getAllFeatureData(molData))
```

An eSetList list member within a MolData object can be referenced directly using the double square bracket operator, as with a normal list and the operation returns an eSet object. In the case of rcellminerData, an ExpressionSet is returned which is derived from eSet. Any eSet derived class can potentially be added to the eSetList; adding objects to the eSetList will be described in a later section.

```
class(molData[["exp"]])

geneExpMat <- exprs(molData[["exp"]])
```

### 4.1.1 Accessing sampleData

Sample information about a MolData object can be accessed using getSampleData(), which returns a data.frame. For the NCI-60, we provide information the tissue of origin for each cell line.

```
getSampleData(molData)[1:10, "TissueType"]
```

### 4.1.2 Adding additional data to a MolData object’s eSetList

It is possible to add additional datasets into MolData objects, as shown below, where the protein data provided in rcellminerData is copied as “test”. This provides users flexibility for wider usage of the MolData class.

```
# Add data
molData[["test"]] <- molData[["pro"]]

names(getAllFeatureData(molData))
```

## 4.2 Drug Data

Drug activity (response) data is provided in the **rcellminerData** package for the NCI-60. **drugData** is an instance of the DrugData S4 class that is composed of 3 slots: act, repeatAct, and sampleData. Both act (summarized data across multiple repeats) and repeatAct (row repeat data) are activity data slots are provided as ExpressionSet objects. In the example below, the drugActMat has fewer rows than drugRepeatActMat since the data across multiple repeats has been summarized, but the same number of columns (samples).

```
drugActMat <- exprs(getAct(drugData))
dim(drugActMat)

drugRepeatActMat <- exprs(getRepeatAct(drugData))
dim(drugRepeatActMat)
```

### 4.2.1 featureData for Drug Activities

**rcellminerData** provides a large amount of information on drugs tested on the NCI-60, including structure information, clinical testing status, etc. This data can be extracted using into a data.frame as shown below:

```
drugAnnotDf <- as(featureData(getAct(drugData)), "data.frame")

colnames(drugAnnotDf)
```

### 4.2.2 sampleData for DrugData Objects

DrugData objects can contain sample data in the same manner as with MolData objects. In the case of **rcellminerData**, the sample data provided for the the drugData object will be identical to that provided for the molData object.

```
identical(getSampleData(molData), getSampleData(drugData))
```

# 5 Session Information

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] knitr_1.50       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.54           cachem_1.1.0
##  [7] htmltools_0.5.8.1   rmarkdown_2.30      lifecycle_1.0.4
## [10] cli_3.6.5           sass_0.4.10         jquerylib_0.1.4
## [13] compiler_4.5.1      tools_4.5.1         evaluate_1.0.5
## [16] bslib_0.9.0         yaml_2.3.10         formatR_1.14
## [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```

# 6 References

# Appendix

* Reinhold, W.C., et al. (2012) CellMiner: a web-based suite of genomic and pharmacologic tools to explore transcript and drug patterns in the NCI-60 cell line set, Cancer research, 72, 3499-3511