# proteoQC: an R package for proteomics data quality assessment

#### Bo Wen and Laurent Gatto

#### 2019-01-04

* [Introduction](#introduction)
* [Example data](#example-data)
* [Running `proteoQC`](#running-proteoqc)
  + [Preparing the QC](#preparing-the-qc)
  + [Running the QC](#running-the-qc)
    - [Set MS/MS searching parameters](#set-msms-searching-parameters)
  + [Generating the QC report](#generating-the-qc-report)
* [The QC report](#the-qc-report)
* [Some useful functions](#some-useful-functions)
  + [Protein inference](#protein-inference)
  + [Isobaric tagging reagent labeling efficiency](#isobaric-tagging-reagent-labeling-efficiency)
  + [Precusor charge distribution](#precusor-charge-distribution)
* [Session information](#session-information)
* [References](#references)

# Introduction

The `proteoQC` package provides a integrated pipeline for mass spectrometry-based proteomics quality control. It allows to generate a dynamic report starting from a set of **mgf** or **mz[X]ML** format peak list files, a protein database file and a description file of the experimental design. It performs an MS/MS search against the protein data base using the **X!Tandem** search engine (Craig and Beavis 2004) and the `rTANDEM` package (Fournier et al. 2013). The results are then summarised and compiled into an interactive html report using the `Nozzle.R1` package (Nils Gehlenborg 2013,N Gehlenborg et al. (2013)).

# Example data

We are going to use parts a dataset from the ProteomeXchange repository (<http://www.proteomexchange.org/>). We will use the `rpx` package to accessed and downloaded the data.

```
library("rpx")
px <- PXDataset("PXD000864")
px
```

```
## Object of class "PXDataset"
##  Id: PXD000864 with 219 files
##  [1] 'README.txt' ... [219] 'generated'
##  Use 'pxfiles(.)' to see all files.
```

There are a total of 219 files available from the ProteomeXchange repository, including raw data files (**raw**), result files (**-pride.xml.gz**), (compressed) peak list files (**.mgf.gz**) and, the fasta database file (**TTE2010.zip**) and one **README.txt** file.

```
head(pxfiles(px))
```

```
## [1] "README.txt"                     "TTE-55-1-01-1.dat-pride.xml.gz"
## [3] "TTE-55-1-01-1.mgf.gz"           "TTE-55-1-01-1.raw"
## [5] "TTE-55-1-01-2.dat-pride.xml.gz" "TTE-55-1-01-2.mgf.gz"
```

```
tail(pxfiles(px))
```

```
## [1] "TTE-75-1-12-2.raw"              "TTE-75-1-12-3.dat-pride.xml.gz"
## [3] "TTE-75-1-12-3.mgf.gz"           "TTE-75-1-12-3.raw"
## [5] "TTE2010.zip"                    "generated"
```

The files, in particular the **mgf** files that will be used in the rest of this document are named as follows **TTE-CC-B-FR-R** where **CC** takes values 55 or 75 and stands for the bacteria culture temperature in degree Celsius, **B** stands for the biological replicate (only 1 here), **FR** represents the fraction number from 01 to 12 and the leading **R** documents one of three technical replicates. (See also <http://www.ebi.ac.uk/pride/archive/projects/PXD000864> for details). Here, we will make use of a limited number of samples below. First, we create a vector that stores the file names of interest.

```
mgfs <- grep("mgf", pxfiles(px), value = TRUE)
mgfs <- grep("-0[5-6]-[1|2]", mgfs, value=TRUE)
mgfs
```

```
## [1] "TTE-55-1-05-1.mgf.gz" "TTE-55-1-05-2.mgf.gz" "TTE-55-1-06-1.mgf.gz"
## [4] "TTE-55-1-06-2.mgf.gz" "TTE-75-1-05-1.mgf.gz" "TTE-75-1-05-2.mgf.gz"
## [7] "TTE-75-1-06-1.mgf.gz" "TTE-75-1-06-2.mgf.gz"
```

These files can be downloaded[1](#fn1) using the `pxget`, providing the relevant data object (here `px`) and file names to be downloaded (see `?pxget` for details). We also need to uncompress (using `gunzip`) the files.

```
mgffiles <- pxget(px, mgfs)
library("R.utils")
mgffiles <- sapply(mgffiles, gunzip)
```

To reduce the file size of the demonstration data included for this package, we have trimmed the peak lists to 1/10 of the original number of spectra. All the details are provided in the vignette source.

Similarly, below we download the database file and unzip it.

```
fas <- pxget(px, "TTE2010.zip")
fas <- unzip(fas)
fas
```

# Running `proteoQC`

## Preparing the QC

The first step in the `proteoQC` pipeline is the definition of a design file, that provides the **mgf** file names, **sample** numbers, biological **biocRep**) and technical (**techRep**) replicates and **fraction** numbers in a simple space-separated tabular format. We provide such a design file for our 8 files of interest.

```
design <- system.file("extdata/PXD000864-design.txt", package = "proteoQC")
design
```

```
## [1] "/tmp/RtmpdEXPZJ/Rinst5ebb430ac211/proteoQC/extdata/PXD000864-design.txt"
```

```
read.table(design, header = TRUE)
```

```
##                file sample bioRep techRep fraction
## 1 TTE-55-1-05-1.mgf     55      1       1        5
## 2 TTE-55-1-05-2.mgf     55      1       2        5
## 3 TTE-55-1-06-1.mgf     55      1       1        6
## 4 TTE-55-1-06-2.mgf     55      1       2        6
## 5 TTE-75-1-05-1.mgf     75      1       1        5
## 6 TTE-75-1-05-2.mgf     75      1       2        5
## 7 TTE-75-1-06-1.mgf     75      1       1        6
## 8 TTE-75-1-06-2.mgf     75      1       2        6
```

## Running the QC

We need to load the `proteoQC` package and call the **msQCpipe** function, providing appropriate input parameters, in particular the **design** file, the **fasta** protein database, the **outdir** output directory that will contain the final quality report and various other peptide spectrum matching parameters that will be passed to the `rTANDEM` package. See `?msQCpipe` for a more in-depth description of all its arguments. Please note that if you take mz[X]ML format files as input, you must make sure that you have installed the rTANDEM that the version is greater than 1.5.1.

```
qcres <- msQCpipe(spectralist = design,
fasta = fas,
outdir = "./qc",
miss  = 0,
enzyme = 1, varmod = 2, fixmod = 1,
tol = 10, itol = 0.6, cpu = 2,
mode = "identification")
```

The `msQCpipe` function will run each mgf input file documented in the design file and search it against the fasta database using the **tandem** function from the `rTANDEM`. This might take some time depending on the number of files to be searched and the search parameters. The code chunk above takes about 3 minutes using 2 cores (**cpu = 2** above) on a modern laptop.

You can load the pre-computed quality control directory and result data that a shipped with `proteoQC` as shown below:

```
zpqc <- system.file("extdata/qc.zip", package = "proteoQC")
unzip(zpqc)
qcres <- loadmsQCres("./qc")
```

```
print(qcres)
```

```
## An msQC results:
##  Results stored in ./qc
##  Database: TTE2010.fasta
##  Run on Wed Apr 23 14:38:04 2014
##  Design with 8 samples:
##                 mgf sample bioRep techRep fraction
## 1 TTE-55-1-05-1.mgf     55      1       1        5
## 2 TTE-55-1-05-2.mgf     55      1       2        5
##   ...
##                 mgf sample bioRep techRep fraction
## 8 TTE-75-1-06-2.mgf     75      1       2        6
##
## You can now run reportHTML() to generate the QC report.
```

### Set MS/MS searching parameters

When we perform the QC analysis, we need to set several parameters for MS/MS searching. `proteoQC` provides a table about modifications. Users can select modifications using this table. Please use function **showMods** to print the available modifications. For the enzyme setting, please use function **showEnzyme** to print the available enzyme.

```
showMods()
```

```
##    index    modstring                name
## 1      1  57.021464@C Carbamidomethyl (C)
## 2      2  15.994915@M       Oxidation (M)
## 3      3   0.984016@N      Deamidated (N)
## 4      4   0.984016@Q      Deamidated (Q)
## 5      5 304.205360@K      iTRAQ8plex (K)
## 6      6 304.205360@[ iTRAQ8plex (N-term)
## 7      7 304.205360@Y      iTRAQ8plex (Y)
## 8      8 144.102063@K      iTRAQ4plex (K)
## 9      9 144.102063@[ iTRAQ4plex (N-term)
## 10    10 144.102063@Y      iTRAQ4plex (Y)
## 11    11 229.162932@K       TMT10plex (K)
## 12    12 229.162932@[  TMT10plex (N-term)
## 13    13  79.966331@Y               PhosY
## 14    14  79.966331@S               PhosS
## 15    15  79.966331@T               PhosT
```

## Generating the QC report

The final quality report can be generated with the **reportHTML**, passing the **qcres** object produced by the **msQCpipe** function above or the directory storing the QC data, as defined as parameter to the **msQCpipe**.

```
html <- reportHTML(qcres)
```

or

```
html <- reportHTML("./qc")
```

The report can then be opened by opening the **qc/qc\_report.html** file in a web browser or directly with **browseURL(html)**.

# The QC report

The dynamic html report is composed of 3 sections: an introduction, a methods and data section and a result part. The former are purely descriptive and summarise the design matrix and analysis parameters, as passed to **msQCpipe**.

The respective sections and sub-sections can be expanded and collapsed and each figure in the report can be zoomed in. While the dynamic html report is most useful for interactive inspection, it is also possible to print the complete report for archiving.

The results section provides tables and graphics that summarise

* Summaries of identification results for individual files as well as technical and biological replicates at the protein, peptide and spectrum levels.
* Summary overview charts that describe number of missed cleavages, peptide charge distributions, peptide length, precursor and fragment ion mass deviations, number of unique spectra/peptides per proteins and protein mass distributions for each sample.
* A contamination summary table generated using the common Repository of Adventitious Proteins ().
* Reproducibility summaries that compare fractions, replicates and samples, representing total number of spectra, number of identified spectra, number of peptides and proteins and overlap of peptides and proteins across replicates.
* Summary histograms of mass accuracies for fragment and precursor ions.
* A summary of the separation efficiency showing the effect of accumulating fractions for all samples.
* A summary of identification-independent QC metrics.

# Some useful functions

## Protein inference

Protein inference from peptide identifications in shotgun proteomics is a very important task. We provide a function **proteinGroup** for this purpose. This function is based on the method used in our another package `sapFinder` (Wen et al. 2014). You can use the function as below:

```
pep.zip <- system.file("extdata/pep.zip", package = "proteoQC")
unzip(pep.zip)
proteinGroup(file = "pep.txt", outfile = "pg.txt")
```

## Isobaric tagging reagent labeling efficiency

The labeling efficiency of the isobaric tag reagents to peptides, such as iTRAQ and TMT, is a very important experiment quality metrics. We provide a function **labelRatio** to calculate this metrics. You can use the function as below:

```
mgf.zip <- system.file("extdata/mgf.zip", package = "proteoQC")
unzip(mgf.zip)
a <- labelRatio("test.mgf",reporter = 2)
```

```
## ........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................
```

![](data:image/png;base64...)![](data:image/png;base64...)

## Precusor charge distribution

Given an MGF file, **chargeStat** function can be used to get the precusor charge distribution.

```
library(dplyr)
library(plotly)
mgf.zip <- system.file("extdata/mgf.zip", package = "proteoQC")
unzip(mgf.zip)
charge <- chargeStat("test.mgf")
```

```
## ........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................
```

```
pp <- plot_ly(charge, labels = ~Charge, values = ~Number, type = 'pie') %>%
layout(title = 'Charge distribution',
xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
pp
```

# Session information

All software and respective versions used to produce this document are listed below.

```
## R version 3.5.2 (2018-12-20)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
##  [1] stats4    parallel  grid      stats     graphics  grDevices utils
##  [8] datasets  methods   base
##
## other attached packages:
##  [1] plotly_4.8.0        ggplot2_3.1.0       dplyr_0.7.8
##  [4] bindrcpp_0.2.2      rpx_1.18.1          R.utils_2.7.0
##  [7] R.oo_1.22.0         R.methodsS3_1.7.1   proteoQC_1.18.1
## [10] MSnbase_2.8.3       ProtGenerics_1.14.0 S4Vectors_0.20.1
## [13] mzR_2.16.1          Rcpp_1.0.0          Biobase_2.42.0
## [16] BiocGenerics_0.28.0 VennDiagram_1.6.20  futile.logger_1.4.3
## [19] XML_3.98-1.16       BiocStyle_2.10.0
##
## loaded via a namespace (and not attached):
##  [1] bitops_1.0-6          doParallel_1.0.14     httr_1.4.0
##  [4] tools_3.5.2           R6_2.3.0              affyio_1.52.0
##  [7] lazyeval_0.2.1        colorspace_1.3-2      ade4_1.7-13
## [10] withr_2.1.2           tidyselect_0.2.5      Nozzle.R1_1.1-1
## [13] curl_3.2              compiler_3.5.2        preprocessCore_1.44.0
## [16] formatR_1.5           rTANDEM_1.22.1        xml2_1.2.0
## [19] labeling_0.3          scales_1.0.0          affy_1.60.0
## [22] stringr_1.3.1         digest_0.6.18         rmarkdown_1.11
## [25] pkgconfig_2.0.2       htmltools_0.3.6       limma_3.38.3
## [28] htmlwidgets_1.3       rlang_0.3.0.1         impute_1.56.0
## [31] shiny_1.2.0           prettydoc_0.2.1       bindr_0.1.1
## [34] jsonlite_1.6          crosstalk_1.0.0       mzID_1.20.1
## [37] BiocParallel_1.16.5   RCurl_1.95-4.11       magrittr_1.5
## [40] MALDIquant_1.18       munsell_0.5.0         vsn_3.50.0
## [43] stringi_1.2.4         yaml_2.2.0            MASS_7.3-51.1
## [46] zlibbioc_1.28.0       plyr_1.8.4            promises_1.0.1
## [49] crayon_1.3.4          lattice_0.20-38       knitr_1.21
## [52] pillar_1.3.1          seqinr_3.4-5          reshape2_1.4.3
## [55] codetools_0.2-16      futile.options_1.0.1  glue_1.3.0
## [58] evaluate_0.12         pcaMethods_1.74.0     lambda.r_1.2.3
## [61] data.table_1.11.8     BiocManager_1.30.4    httpuv_1.4.5.1
## [64] foreach_1.4.4         gtable_0.2.0          purrr_0.2.5
## [67] tidyr_0.8.2           assertthat_0.2.0      xfun_0.4
## [70] mime_0.6              xtable_1.8-3          later_0.7.5
## [73] ncdf4_1.16            viridisLite_0.3.0     tibble_2.0.0
## [76] iterators_1.0.10      IRanges_2.16.0
```

# References

Craig, R, and R C Beavis. 2004. “TANDEM: Matching Proteins with Tandem Mass Spectra.” *Bioinformatics* 20 (9):1466–7. <https://doi.org/10.1093/bioinformatics/bth092>.

Fournier, Frederic, Charles Joly Beauparlant, Rene Paradis, and Arnaud Droit. 2013. *rTANDEM: Encapsulates X!Tandem in R.*

Gehlenborg, Nils. 2013. *Nozzle.R1: Nozzle Reports*. [http://CRAN.R-project.org/package=Nozzle.R1](http://CRAN.R-project.org/package%3DNozzle.R1).

Gehlenborg, N, M S Noble, G Getz, L Chin, and P J Park. 2013. “Nozzle: A Report Generation Toolkit for Data Analysis Pipelines.” *Bioinformatics* 29 (8):1089–91. <https://doi.org/10.1093/bioinformatics/btt085>.

Wen, Bo, Shaohang Xu, Gloria Sheynkman, Qiang Feng, Liang Lin, Quanhui Wang, Xun Xu, Jun Wang, and Siqi Liu. 2014. “SapFinder: An R/Bioconductor Package for Detection of Variant Peptides in Shotgun Proteomics Experiments.” *Bioinformatics*. Oxford Univ Press, btu397.

---

1. In the interest of time, the files are not downloaded when this vignette is compiled and the quality metrics are pre-computed (see details below). These following code chunks can nevertheless be executed to reproduce the complete pipeline.}[↩](#fnref1)