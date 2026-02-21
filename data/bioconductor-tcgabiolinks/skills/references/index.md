[[![](data:image/png;base64...)](http://bioconductor.org/packages/TCGAbiolinks/)](index.html)

* [Introduction](index.html)
* Data

  + Molecular data
  + [Query](query.html)
  + [Download & Prepare](download_prepare.html)
  + Other data
  + [Clinical data](clinical.html)
  + [Mutation data](mutation.html)
  + [Molecular subtypes](subtypes.html)
  + [ATAC-seq](http://rpubs.com/tiagochst/atac_seq_workshop)
* Analysis

  + [Analysis functions](analysis.html)
  + [Other functions](extension.html)
  + [Importing data to DESeq2](http://rpubs.com/tiagochst/TCGAbiolinks_to_DESEq2)
  + [Glioma classsifier](classifiers.html)
* [Case Study](casestudy.html)

* Workshops
  + TCGA workshop
  + [Workshop - TCGA data analysis](http://rpubs.com/tiagochst/TCGAworkshop)
  + ELMER workshop
  + [Workshop for multi-omics analysis with ELMER](http://rpubs.com/tiagochst/ELMER_workshop)
  + ATAC-Seq workshop
  + [Workshop for ATAC-Seq analysis](http://rpubs.com/tiagochst/atac_seq_workshop)
  + Bioc2017 workshop
  + [Github ELMER/TCGAbiolinks](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER)
* + TCGAbiolinks package
  + [Github](https://github.com/BioinformaticsFMRP/TCGAbiolinks)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/TCGAbiolinks.html)
  + TCGAbiolinksGUI package
  + [Github](https://github.com/BioinformaticsFMRP/TCGAbiolinksGUI)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/TCGAbiolinksGUI.html)
  + ELMER package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
  + ELMER.data package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
* + University of São Paulo (USP)
  + [fmrp.usp.br](http://www.fmrp.usp.br/?lang=en)
  + Fundings
  + [FAPESP (16/10436-9)](http://www.bv.fapesp.br/en/pesquisa/?sort=-data_inicio&q2=%28instituicao%3A%22Cedars-Sinai+Medical+Center%22%29+AND+%28%28bolsa_en_exact%3A%22Scholarships+abroad%22+AND+situacao_en_exact%3A%22Ongoing%22%29%29)
  + [FAPESP (16/01389-7)](http://bv.fapesp.br/en/pesquisa/?sort=-data_inicio&q2=%28id_pesquisador_exact%3A679917%29+AND+%28%28bolsa_en_exact%3A%22Scholarships+in+Brazil%22+AND+situacao_en_exact%3A%22Ongoing%22%29%29)

# Introduction

#### 30 October 2025

---

TCGAbiolinks is able to access The National Cancer Institute (NCI) Genomic Data Commons (GDC) thorough its
[GDC Application Programming Interface (API)](https://gdc.cancer.gov/developers/gdc-application-programming-interface-api) to search, download and prepare relevant data for analysis in R.

# News

---

* April 2022:
  + Started to add support for GENCODE v36 pipelines
  + Add stemness score functions
* December 2019:
  + Added support to non TCGA/TARGET projects - <https://rpubs.com/tiagochst/TCGAbiolinks_RNA-seq_new_projects>
  + Added support to linked Omics data retrieval - <https://rpubs.com/tiagochst/linkedOmics>
  + Included Glioma classifier from GUI to the main package - <https://bioconductor.org/packages/devel/bioc/vignettes/TCGAbiolinks/inst/doc/classifiers.html>
* Added support to BCR Biotab clinical files
* Workshop materials (ATAC-seq, ELMER and TCGAbiolinks) were added to vignette (<https://bioconductor.org/packages/devel/bioc/vignettes/TCGAbiolinks/inst/doc/index.html>)

# Citation

---

If you use TCGAbiolinks, please cite:

* Colaprico, Antonio, et al. “TCGAbiolinks: an R/Bioconductor package for integrative analysis of TCGA data.” Nucleic acids research 44.8 (2015): e71-e71.
* Silva, Tiago C., et al. “TCGA Workflow: Analyze cancer genomics and epigenomics data using Bioconductor packages.” F1000Research 5 (2016). (<https://f1000research.com/articles/5-1542/v2>)
* Mounir, Mohamed, et al. “New functionalities in the TCGAbiolinks package for the study and integration of cancer data from GDC and GTEx.” PLoS computational biology 15.3 (2019): e1006701. (<https://doi.org/10.1371/journal.pcbi.1006701>)

# Other useful links

---

* Gao, Galen F., et al. “Before and After: Comparison of Legacy and Harmonized TCGA Genomic Data Commons’ Data.” Cell systems 9.1 (2019): 24-34. (<https://doi.org/10.1016/j.cels.2019.06.006>)
* TCGA Workflow Analyze cancer genomics and epigenomics data using Bioconductor packages: <http://bioconductor.org/packages/TCGAWorkflow/>

# Installation

---

You can install the stable version from [Bioconductor](http://bioconductor.org/packages/release/bioc/html/TCGAbiolinks.html). If you are having issues with the stable version, try using the development version.

* Stable version:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("TCGAbiolinks")
```

* Development version:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("BioinformaticsFMRP/TCGAbiolinksGUI.data")
BiocManager::install("BioinformaticsFMRP/TCGAbiolinks")
```

# Question and issues

---

Please use [Github issues](https://github.com/BioinformaticsFMRP/TCGAbiolinks/issues) if you want to file bug reports or feature requests.

# Required libraries

---

The examples in this tutorial use the following libraries:

```
library(TCGAbiolinks)
library(dplyr)
library(DT)
```

# Session info

---

```
version
```

```
##                _
## platform       x86_64-pc-linux-gnu
## arch           x86_64
## os             linux-gnu
## system         x86_64, linux-gnu
## status         Patched
## major          4
## minor          5.1
## year           2025
## month          08
## day            23
## svn rev        88802
## language       R
## version.string R version 4.5.1 Patched (2025-08-23 r88802)
## nickname       Great Square Root
```

```
packageVersion("TCGAbiolinks")
```

```
## [1] '2.38.0'
```