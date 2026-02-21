# epimutacionsData: a data repostory for epimutacions package

Leire Abarrategui

#### 6 November 2025

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
  + [2.1 Candidate epimutations](#candidate-epimutations)
  + [2.2 Example datasets](#example-datasets)
    - [2.2.1 Reference panel](#reference-panel)
    - [2.2.2 Control and case samples](#control-and-case-samples)
  + [2.3 IDAT files](#idat-files)
* [3 sessionInfo()](#sessioninfo)
* [References](#references)

# 1 Introduction

The `epimutacionsData` package is a repository of datasets for the
`epimutacions` package. It includes 2 datasets to use as an example:

* **Reference panel**: DNA methylation profiles of
  24 whole cord blood samples from healthy
  children born via caesarian (GEO: GSE127824)
* **Case and control samples**: DNA methylation profiling of
  whole blood samples in healthy children (GSE104812).
  CHARGE and Kabuki syndromes whole blood samples
  DNA methylation profiles (GEO: GSE97362).
* **Candidate regions**: Regions in Illumina 450K array which
  are candidate to be epimutations.

# 2 Installation

The following code explains how to access to the data:

```
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, c("epimutacionsData"))
```

```
## ExperimentHub with 3 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: GEO, Illumina 450k array
## # $species: Homo sapiens
## # $rdataclass: RGChannelSet, GenomicRatioSet, GRanges
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6690"]]'
##
##            title
##   EH6690 | Control and case samples
##   EH6691 | Reference panel
##   EH6692 | Candidate epimutations
```

## 2.1 Candidate epimutations

In Illumina 450K array (Reproducibility [2012](#ref-reproducibilityinfinium)),
probes are unequally distributed along the genome,
limiting the number of regions that can fulfil the requirements
to be considered an epimutation.
So, we have computed a dataset containing
the regions that are candidates to become an epimutation.

To define the candidate epimutations,
we relied on the clustering from bumphunter (Jaffe et al. [2012](#ref-jaffe2012bump)).
We defined a primary dataset with all the CpGs from the Illumina 450K array.
Then, we run bumphunter and selected those regions with at least 3 CpGs.
As a result, we found 40408 candidate epimutations
which are available in the `candRegsGR` dataset.

```
candRegsGR <- eh[["EH6692"]]
```

## 2.2 Example datasets

### 2.2.1 Reference panel

The package includes an `RGChannelSet` class reference panel
(`reference_panel`)
which contains 22 whole cord blood samples from
healthy children born via caesarian from
the GSE127824 cohort (Gervin et al. [2019](#ref-gervin2019systematic)).

The reference panel can be found in `EH6691` record of the `eh` object:

```
reference_panel <- eh[["EH6691"]]
```

### 2.2.2 Control and case samples

The `methy` dataset includes 51 DNA methylation profiling
of whole blood samples. 48 controls from GSE104812 (Shi et al. [2018](#ref-shi2018dna)) cohort
and 3 cases from GSE97362 (Butcher et al. [2017](#ref-butcher2017charge)).
it is a `GenomicRatioSet` class object.

```
methy <- eh[["EH6690"]]
```

## 2.3 IDAT files

The IDAT files contain raw microarray intensities of 4 case samples
from GSE131350 cohort.
The files are located on the external data of `epimutacionsData` package:

```
library(minfi)
baseDir <- system.file("extdata", package = "epimutacionsData")
targets <- read.metharray.sheet(baseDir)
```

# 3 sessionInfo()

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
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] minfi_1.56.0                bumphunter_1.52.0
##  [3] locfit_1.5-9.12             iterators_1.0.14
##  [5] foreach_1.5.2               Biostrings_2.78.0
##  [7] XVector_0.50.0              SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0               IRanges_2.44.0
## [15] S4Vectors_0.48.0            epimutacionsData_1.14.0
## [17] ExperimentHub_3.0.0         AnnotationHub_4.0.0
## [19] BiocFileCache_3.0.0         dbplyr_2.5.1
## [21] BiocGenerics_0.56.0         generics_0.1.4
## [23] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
##   [3] magrittr_2.0.4            GenomicFeatures_1.62.0
##   [5] rmarkdown_2.30            BiocIO_1.20.0
##   [7] vctrs_0.6.5               multtest_2.66.0
##   [9] memoise_2.0.1             Rsamtools_2.26.0
##  [11] DelayedMatrixStats_1.32.0 RCurl_1.98-1.17
##  [13] askpass_1.2.1             htmltools_0.5.8.1
##  [15] S4Arrays_1.10.0           curl_7.0.0
##  [17] Rhdf5lib_1.32.0           SparseArray_1.10.1
##  [19] rhdf5_2.54.0              sass_0.4.10
##  [21] nor1mix_1.3-3             bslib_0.9.0
##  [23] plyr_1.8.9                httr2_1.2.1
##  [25] cachem_1.1.0              GenomicAlignments_1.46.0
##  [27] lifecycle_1.0.4           pkgconfig_2.0.3
##  [29] Matrix_1.7-4              R6_2.6.1
##  [31] fastmap_1.2.0             digest_0.6.37
##  [33] siggenes_1.84.0           reshape_0.8.10
##  [35] AnnotationDbi_1.72.0      RSQLite_2.4.3
##  [37] base64_2.0.2              filelock_1.0.3
##  [39] httr_1.4.7                abind_1.4-8
##  [41] compiler_4.5.1            beanplot_1.3.1
##  [43] rngtools_1.5.2            bit64_4.6.0-1
##  [45] withr_3.0.2               BiocParallel_1.44.0
##  [47] DBI_1.2.3                 HDF5Array_1.38.0
##  [49] MASS_7.3-65               openssl_2.3.4
##  [51] rappdirs_0.3.3            DelayedArray_0.36.0
##  [53] rjson_0.2.23              tools_4.5.1
##  [55] rentrez_1.2.4             glue_1.8.0
##  [57] quadprog_1.5-8            h5mread_1.2.0
##  [59] restfulr_0.0.16           nlme_3.1-168
##  [61] rhdf5filters_1.22.0       grid_4.5.1
##  [63] tzdb_0.5.0                preprocessCore_1.72.0
##  [65] tidyr_1.3.1               data.table_1.17.8
##  [67] hms_1.1.4                 xml2_1.4.1
##  [69] BiocVersion_3.22.0        pillar_1.11.1
##  [71] limma_3.66.0              genefilter_1.92.0
##  [73] splines_4.5.1             dplyr_1.1.4
##  [75] lattice_0.22-7            survival_3.8-3
##  [77] rtracklayer_1.70.0        bit_4.6.0
##  [79] GEOquery_2.78.0           annotate_1.88.0
##  [81] tidyselect_1.2.1          knitr_1.50
##  [83] bookdown_0.45             xfun_0.54
##  [85] scrime_1.3.5              statmod_1.5.1
##  [87] yaml_2.3.10               evaluate_1.0.5
##  [89] codetools_0.2-20          cigarillo_1.0.0
##  [91] tibble_3.3.0              BiocManager_1.30.26
##  [93] cli_3.6.5                 xtable_1.8-4
##  [95] jquerylib_0.1.4           Rcpp_1.1.0
##  [97] png_0.1-8                 XML_3.99-0.19
##  [99] readr_2.1.5               blob_1.2.4
## [101] mclust_6.1.2              doRNG_1.8.6.2
## [103] sparseMatrixStats_1.22.0  bitops_1.0-9
## [105] illuminaio_0.52.0         purrr_1.2.0
## [107] crayon_1.5.3              rlang_1.1.6
## [109] KEGGREST_1.50.0
```

# References

Butcher, Darci T, Cheryl Cytrynbaum, Andrei L Turinsky, Michelle T Siu, Michal Inbar-Feigenberg, Roberto Mendoza-Londono, David Chitayat, et al. 2017. “CHARGE and Kabuki Syndromes: Gene-Specific Dna Methylation Signatures Identify Epigenetic Mechanisms Linking These Clinically Overlapping Conditions.” *The American Journal of Human Genetics* 100 (5): 773–88.

Gervin, Kristina, Lucas A Salas, Kelly M Bakulski, Menno C Van Zelm, Devin C Koestler, John K Wiencke, Liesbeth Duijts, et al. 2019. “Systematic Evaluation and Validation of Reference and Library Selection Methods for Deconvolution of Cord Blood Dna Methylation Data.” *Clinical Epigenetics* 11 (1): 1–15.

Jaffe, Andrew E, Peter Murakami, Hwajin Lee, Jeffrey T Leek, M Daniele Fallin, Andrew P Feinberg, and Rafael A Irizarry. 2012. “Bump Hunting to Identify Differentially Methylated Regions in Epigenetic Epidemiology Studies.” *International Journal of Epidemiology* 41 (1): 200–209.

Reproducibility, Unrivaled Assay. 2012. “Infinium Humanmethylation450 Beadchip.”

Shi, Lei, Fan Jiang, Fengxiu Ouyang, Jun Zhang, Zhimin Wang, and Xiaoming Shen. 2018. “DNA Methylation Markers in Combination with Skeletal and Dental Ages to Improve Age Estimation in Children.” *Forensic Science International: Genetics* 33: 1–9.