# phantasusLite tutorial

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Loading precomputed RNA-seq counts](#loading-precomputed-rna-seq-counts)
* [4 Inferring sample groups](#inferring-sample-groups)
* [5 Working with GCT files](#working-with-gct-files)
* [6 Session info](#session-info)

# 1 Introduction

The `phantasusLite` package contains a set functions that facilitate working with public
gene expression datasets originally developed for [phantasus package](https://bioconductor.org/packages/phantasus). Unlike `phantasus`, `phantasusLite` aims to limit the amount of dependencies.

The current functionality includes:

* Providing an interface to precomputed RNA-seq gene counts from ARCHS4 and DEE2 projects stored at remote HSDS repositories.
* Inferring sample groups for cases when they are not provided in the original metadata.
* Saving and loading expression matrices from GCT format.

# 2 Installation

It is recommended to install the release version of the package from Bioconductor using the following commands:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("phantasusLite")
```

Alternatively, the most recent version of the package can be installed from the GitHub repository:

```
library(devtools)
install_github("ctlab/phantasusLite")
```

# 3 Loading precomputed RNA-seq counts

```
library(GEOquery)
library(phantasusLite)
```

Let’s load dataset GSE53053 from GEO using `GEOquery` package:

```
ess <- getGEO("GSE53053")
es <- ess[[1]]
```

RNA-seq dataset from GEO do not contain the expression matrix, thus `exprs(es)` is empty:

```
head(exprs(es))
```

```
##      GSM1281300 GSM1281301 GSM1281302 GSM1281303 GSM1281304 GSM1281305
##      GSM1281306 GSM1281307
```

However, a number of precomputed gene count tables are available at HSDS server ‘<https://alserglab.wustl.edu/hsds/>’. It features HDF5 files with counts
from ARCHS4 and DEE2 projects:

```
url <- 'https://alserglab.wustl.edu/hsds/?domain=/counts'
getHSDSFileList(url)
```

```
##  [1] "/counts/archs4/Arabidopsis_thaliana_count_matrix.h5"
##  [2] "/counts/archs4/Bos_taurus_count_matrix.h5"
##  [3] "/counts/archs4/Caenorhabditis_elegans_count_matrix.h5"
##  [4] "/counts/archs4/Danio_rerio_count_matrix.h5"
##  [5] "/counts/archs4/Drosophila_melanogaster_count_matrix.h5"
##  [6] "/counts/archs4/Gallus_gallus_count_matrix.h5"
##  [7] "/counts/archs4/Rattus_norvegicus_count_matrix.h5"
##  [8] "/counts/archs4/Saccharomyces_cerevisiae_count_matrix.h5"
##  [9] "/counts/archs4/human_gene_v2.3.h5"
## [10] "/counts/archs4/meta.h5"
## [11] "/counts/archs4/mouse_gene_v2.3.h5"
## [12] "/counts/dee2/athaliana_star_matrix_20240409.h5"
## [13] "/counts/dee2/celegans_star_matrix_20240409.h5"
## [14] "/counts/dee2/dmelanogaster_star_matrix_20240409.h5"
## [15] "/counts/dee2/drerio_star_matrix_20240409.h5"
## [16] "/counts/dee2/ecoli_star_matrix_20240409.h5"
## [17] "/counts/dee2/hsapiens_star_matrix_20240409.h5"
## [18] "/counts/dee2/meta.h5"
## [19] "/counts/dee2/mmusculus_star_matrix_20240409.h5"
## [20] "/counts/dee2/rnorvegicus_star_matrix_20240409.h5"
## [21] "/counts/dee2/scerevisiae_star_matrix_20240409.h5"
## [22] "/counts/index.h5"
## [23] "/counts/priority.h5"
```

GSE53053 dataset was sequenced from *Mus musculus* and we can get an expression matrix
from the corresponding HDF5-file with DEE2 data:

```
file <- "dee2/mmusculus_star_matrix_20240409.h5"
es <- loadCountsFromH5FileHSDS(es, url, file)
head(exprs(es))
```

```
##                    GSM1281300 GSM1281301 GSM1281302 GSM1281303 GSM1281304
## ENSMUSG00000102693          0          0          0          0          0
## ENSMUSG00000064842          0          0          0          0          0
## ENSMUSG00000051951          0          0        135        120        132
## ENSMUSG00000102851          0          0          0          0          0
## ENSMUSG00000103377          0          0          0          0          1
## ENSMUSG00000104017          0          0          0          0          0
##                    GSM1281305 GSM1281306 GSM1281307
## ENSMUSG00000102693          0          0          0
## ENSMUSG00000064842          0          0          0
## ENSMUSG00000051951          0          0          0
## ENSMUSG00000102851          0          0          0
## ENSMUSG00000103377          0          0          0
## ENSMUSG00000104017          0          0          0
```

Normally `loadCountsFromHSDS` can be used to automatically select the HDF5-file with the largest
number of quantified samples:

```
es <- ess[[1]]
es <- loadCountsFromHSDS(es, url)
head(exprs(es))
```

```
##                    GSM1281300 GSM1281301 GSM1281302 GSM1281303 GSM1281304
## ENSMUSG00000000001       1015        603        561        549        425
## ENSMUSG00000000003          0          0          0          0          0
## ENSMUSG00000000028        109         34          0         14          9
## ENSMUSG00000000031          0         18          0          0          0
## ENSMUSG00000000037          0          0          0          0          0
## ENSMUSG00000000049          0          0          0          0          0
##                    GSM1281305 GSM1281306 GSM1281307
## ENSMUSG00000000001        853        407        479
## ENSMUSG00000000003          0          0          0
## ENSMUSG00000000028        165          0         15
## ENSMUSG00000000031          0          0          0
## ENSMUSG00000000037          0          0          0
## ENSMUSG00000000049          0          0          0
```

The counts are different from the previous values as ARCHS4 counts were used – ARCHS4 is prioritized when there are several files with the same number of samples:

```
preproc(experimentData(es))$gene_counts_source
```

```
## [1] "archs4/mouse_gene_v2.3.h5"
```

Further, gene symbols are also imported from ARCHS4 database and are available as feature data:

```
head(fData(es))
```

```
##                    Gene symbol          ENSEMBLID
## ENSMUSG00000000001       Gnai3 ENSMUSG00000000001
## ENSMUSG00000000003        Pbsn ENSMUSG00000000003
## ENSMUSG00000000028       Cdc45 ENSMUSG00000000028
## ENSMUSG00000000031         H19 ENSMUSG00000000031
## ENSMUSG00000000037       Scml2 ENSMUSG00000000037
## ENSMUSG00000000049        Apoh ENSMUSG00000000049
```

# 4 Inferring sample groups

For some of the GEO datasets, such as GSE53053, the sample annotation is not fully available.
However, frequently sample titles are structured in a way that allows to infer the groups.
For example, for GSE53053 we can see there are three groups: Ctrl, MandIL4, MandLPSandIFNg,
with up to 3 replicates:

```
es$title
```

```
## [1] "Ctrl_1"           "Ctrl_2"           "MandIL4_1"        "MandIL4_2"
## [5] "MandIL4_3"        "MandLPSandIFNg_1" "MandLPSandIFNg_2" "MandLPSandIFNg_3"
```

For such well-structured titles, `inferCondition` function can be used to automatically
identify the sample conditions and replicates:

```
es <- inferCondition(es)
print(es$condition)
```

```
## [1] "Ctrl"           "Ctrl"           "MandIL4"        "MandIL4"
## [5] "MandIL4"        "MandLPSandIFNg" "MandLPSandIFNg" "MandLPSandIFNg"
```

```
print(es$replicate)
```

```
## [1] "1" "2" "1" "2" "3" "1" "2" "3"
```

# 5 Working with GCT files

GCT text format can be used to store annotated gene expression matrices and load them in software
such as [Morpheus](https://software.broadinstitute.org/morpheus/) or [Phantasus](https://ctlab.itmo.ru/phantasus/).

For example, we can save the `ExpressionSet` object that we defined previously:

```
f <- file.path(tempdir(), "GSE53053.gct")
writeGct(es, f)
```

And the load the file back:

```
es2 <- readGct(f)
```

```
## Warning in readGct(f): duplicated row IDs: Gm16364 Pakap Pakap A530058N18Rik
## Snora43 1700030C10Rik; they were renamed
```

```
print(es2)
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 53511 features, 8 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: Ctrl_1 Ctrl_2 ... MandLPSandIFNg_3 (8 total)
##   varLabels: title geo_accession ... replicate (43 total)
##   varMetadata: labelDescription
## featureData
##   featureNames: Gnai3 Pbsn ... ENSMUSG00002076992 (53511 total)
##   fvarLabels: Gene symbol ENSEMBLID
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
```

# 6 Session info

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
## [1] phantasusLite_1.8.0 GEOquery_2.78.0     Biobase_2.70.0
## [4] BiocGenerics_0.56.0 generics_0.1.4      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] SummarizedExperiment_1.40.0 rjson_0.2.23
##  [3] xfun_0.53                   bslib_0.9.0
##  [5] httr2_1.2.1                 lattice_0.22-7
##  [7] tzdb_0.5.0                  vctrs_0.6.5
##  [9] tools_4.5.1                 stats4_4.5.1
## [11] curl_7.0.0                  tibble_3.3.0
## [13] pkgconfig_2.0.3             R.oo_1.27.1
## [15] Matrix_1.7-4                data.table_1.17.8
## [17] rentrez_1.2.4               S4Vectors_0.48.0
## [19] lifecycle_1.0.4             stringr_1.5.2
## [21] compiler_4.5.1              statmod_1.5.1
## [23] Seqinfo_1.0.0               htmltools_0.5.8.1
## [25] sass_0.4.10                 yaml_2.3.10
## [27] pillar_1.11.1               jquerylib_0.1.4
## [29] tidyr_1.3.1                 R.utils_2.13.0
## [31] rhdf5client_1.32.0          DelayedArray_0.36.0
## [33] cachem_1.1.0                limma_3.66.0
## [35] abind_1.4-8                 tidyselect_1.2.1
## [37] digest_0.6.37               stringi_1.8.7
## [39] dplyr_1.1.4                 purrr_1.1.0
## [41] bookdown_0.45               fastmap_1.2.0
## [43] grid_4.5.1                  cli_3.6.5
## [45] SparseArray_1.10.0          magrittr_2.0.4
## [47] S4Arrays_1.10.0             XML_3.99-0.19
## [49] readr_2.1.5                 withr_3.0.2
## [51] rappdirs_0.3.3              rmarkdown_2.30
## [53] XVector_0.50.0              httr_1.4.7
## [55] matrixStats_1.5.0           R.methodsS3_1.8.2
## [57] hms_1.1.4                   evaluate_1.0.5
## [59] knitr_1.50                  GenomicRanges_1.62.0
## [61] IRanges_2.44.0              rlang_1.1.6
## [63] glue_1.8.0                  BiocManager_1.30.26
## [65] xml2_1.4.1                  jsonlite_2.0.0
## [67] R6_2.6.1                    MatrixGenerics_1.22.0
```

```