# SimBenchData: a collection of 35 single-cell RNA-seq data covering a wide range of data characteristics

Yue Cao1\*, Pengyi Yang2\*\* and Jean Yee Hwa Yang1\*\*\*

1School of Mathematics and Statistics, University of Sydney; Charles Perkins Centre, University of Sydney, Sydney, NSW, Australia
2School of Mathematics and Statistics, University of Sydney, Sydney, NSW, Australia; Charles Perkins Centre, University of Sydney, Sydney, NSW, Australia; Computational Systems Biology Group, Children's Medical Research Institute, University of Sydney, Westmead, NSW, Australia

\*yue.cao@sydney.edu.au
\*\*pengyi.yang@sydney.edu.au
\*\*\*jean.yang@sydney.edu.au

#### 4 November 2025

#### Package

SimBenchData 1.18.0

# Contents

* [1 Introduction](#introduction)
* [2 The SimBenchData dataset](#the-simbenchdata-dataset)
* [Session info](#session-info)

# 1 Introduction

The SimBenchData package contains a total of 35 single-cell RNA-seq datasets covering a wide range of data characteristics, including major sequencing protocols, multiple tissue types, and both human and mouse sources. This package serves as a key resource for performance benchmark of single-cell simulation methods, and was used to comprehensively assess the performance of 12 single-cell simulation methods in retaining key data properties of single-cell sequencing data, including gene-wise and cell-wise properties, as well as biological signals such as differential expression and differential proportion of genes. This data package is a valuable resource for the single-cell community for future development and benchmarking of new single-cell simulation methods and other applications.

# 2 The SimBenchData dataset

The data stored in this package can be retrieved using ExperimentHub.

```
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
#
# BiocManager::install("ExperimentHub")

library(ExperimentHub)
eh <- ExperimentHub()
alldata <- query(eh, "SimBenchData")
alldata
```

```
## ExperimentHub with 35 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Broad Institute of MIT & Harvard, Cambridge, MA USA, Peking...
## # $species: Homo sapiens, Mus musculus
## # $rdataclass: SeuratObject
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH5384"]]'
##
##            title
##   EH5384 | 293T cell line
##   EH5385 | Jurkat and 293T
##   EH5386 | BC01 blood
##   EH5387 | BC01 normal
##   EH5388 | BC02 lymph
##   ...      ...
##   EH5414 | Soumillon
##   EH5415 | stem cell
##   EH5416 | Tabula Muris
##   EH5417 | Tung ipsc
##   EH5418 | Yang liver
```

Each dataset can be downloaded using its ID.

```
data_1 <- alldata[["EH5384"]]
```

Information about each dataset such as its description and source URL can be found in the metadata files under the `inst/extdata` directory. It can also be explored using the function `showMetaData`. Additional details on each dataset can be explored using the function `showAdditionalDetail()`. The information on the first three datasets is shown as an example.

```
library(SimBenchData)

metadata <- showMetaData()
metadata[1:3, ]
```

```
##              Name                                      Description BiocVersion
## 1  293T cell line                                   293T cell line        3.13
## 2 Jurkat and 293T mixture of Jurkat (human T lymphocyte)  and 293T        3.13
## 3      BC01 blood            PBMC of breast cancer patient ID BC01        3.13
##   Genome SourceType
## 1   hg19     tar.gz
## 2   hg19     tar.gz
## 3   hg19        Zip
##                                                                           SourceUrl
## 1   https://support.10xgenomics.com/single-cell-gene-expression/datasets/1.1.0/293t
## 2 https://support.10xgenomics.com/single-cell-gene-expression/datasets/1.1.0/jurkat
## 3                      https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE114725
##                             SourceVersion      Species TaxonomyId
## 1   293t_filtered_gene_bc_matrices.tar.gz Homo sapiens       9606
## 2 jurkat_filtered_gene_bc_matrices.tar.gz Homo sapiens       9606
## 3                       GSE114725_RAW.tar Homo sapiens       9606
##   Coordinate_1_based
## 1                 NA
## 2                 NA
## 3                 NA
##                                                                              DataProvider
## 1                                                                            10x genomics
## 2                                                                            10x genomics
## 3 Memorial Sloan Kettering Cancer Center,\tComputational and Systems Biology Program, SKI
##                        Maintainer   RDataClass DispatchClass
## 1 Yue Cao <yue.cao@sydney.edu.au> SeuratObject           Rds
## 2 Yue Cao <yue.cao@sydney.edu.au> SeuratObject           Rds
## 3 Yue Cao <yue.cao@sydney.edu.au> SeuratObject           Rds
##                        RDataPath ExperimentHub_ID
## 1 SimBenchData/293t_cellline.rds           EH5384
## 2   SimBenchData/293t_jurkat.rds           EH5385
## 3    SimBenchData/BC01_blood.rds           EH5386
```

```
additionaldetail <- showAdditionalDetail()
additionaldetail[1:3, ]
```

```
##   ExperimentHub_ID            Name Species     Protocol Number_of_cells
## 1           EH5384  293T cell line   Human 10x Genomics            2885
## 2           EH5385 Jurkat and 293T   Human 10x Genomics            6143
## 3           EH5386      BC01 blood   Human      inDrops            3034
##   Multiple_celltypes_or_conditions
## 1                               No
## 2                              Yes
## 3                               No
```

The data processing script for each dataset can be found under the `inst/scripts` directory.

# Session info

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
## [1] SimBenchData_1.18.0 ExperimentHub_3.0.0 AnnotationHub_4.0.0
## [4] BiocFileCache_3.0.0 dbplyr_2.5.1        BiocGenerics_0.56.0
## [7] generics_0.1.4      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3       sass_0.4.10          BiocVersion_3.22.0
##  [4] RSQLite_2.4.3        digest_0.6.37        magrittr_2.0.4
##  [7] evaluate_1.0.5       bookdown_0.45        fastmap_1.2.0
## [10] blob_1.2.4           jsonlite_2.0.0       AnnotationDbi_1.72.0
## [13] DBI_1.2.3            BiocManager_1.30.26  httr_1.4.7
## [16] purrr_1.1.0          Biostrings_2.78.0    httr2_1.2.1
## [19] jquerylib_0.1.4      cli_3.6.5            crayon_1.5.3
## [22] rlang_1.1.6          XVector_0.50.0       Biobase_2.70.0
## [25] bit64_4.6.0-1        withr_3.0.2          cachem_1.1.0
## [28] yaml_2.3.10          tools_4.5.1          memoise_2.0.1
## [31] dplyr_1.1.4          filelock_1.0.3       curl_7.0.0
## [34] vctrs_0.6.5          R6_2.6.1             png_0.1-8
## [37] stats4_4.5.1         lifecycle_1.0.4      Seqinfo_1.0.0
## [40] KEGGREST_1.50.0      S4Vectors_0.48.0     IRanges_2.44.0
## [43] bit_4.6.0            pkgconfig_2.0.3      pillar_1.11.1
## [46] bslib_0.9.0          glue_1.8.0           xfun_0.54
## [49] tibble_3.3.0         tidyselect_1.2.1     knitr_1.50
## [52] htmltools_0.5.8.1    rmarkdown_2.30       compiler_4.5.1
```