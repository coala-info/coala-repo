# crisprScoreData

Jean-Philippe Fortin1\*

1Data Science and Statistical Computing, gRED, Genentech

\*fortin946@gmail.com

#### 2025-11-04

# 1 Installation from Bioconductor

`crisprScoreData` can be installed from the Bioconductor devel
branch using the following commands in a fresh R session:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install(version="devel")
BiocManager::install("crisprScoreData")
```

# 2 Exploring the different data in crisprScoreData

We first load the `crisprScoreData` package:

```
library(crisprScoreData)
```

```
## Loading required package: ExperimentHub
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: AnnotationHub
```

```
## Loading required package: BiocFileCache
```

```
## Loading required package: dbplyr
```

This package contains several pre-trained models for different
on-target activity prediction algorithms to be used
in the package *crisprScore*.

We can access the file paths of the different
pre-trained models directly with named functions:

```
# For DeepHF model:
DeepWt.hdf5()
```

```
## see ?crisprScoreData and browseVignettes('crisprScoreData') for documentation
```

```
## loading from cache
```

```
##                                                       EH6123
## "/home/biocbuild/.cache/R/ExperimentHub/1809241215c7c5_6166"
```

```
DeepWt_T7.hdf5()
```

```
## see ?crisprScoreData and browseVignettes('crisprScoreData') for documentation
## loading from cache
```

```
##                                                       EH6124
## "/home/biocbuild/.cache/R/ExperimentHub/1809243e5bbf9d_6167"
```

```
DeepWt_U6.hdf5()
```

```
## see ?crisprScoreData and browseVignettes('crisprScoreData') for documentation
## loading from cache
```

```
##                                                       EH6125
## "/home/biocbuild/.cache/R/ExperimentHub/1809245ff0060a_6168"
```

```
esp_rnn_model.hdf5()
```

```
## see ?crisprScoreData and browseVignettes('crisprScoreData') for documentation
## loading from cache
```

```
##                                                       EH6126
## "/home/biocbuild/.cache/R/ExperimentHub/180924791a57c6_6169"
```

```
hf_rnn_model.hdf5()
```

```
## see ?crisprScoreData and browseVignettes('crisprScoreData') for documentation
## loading from cache
```

```
##                                                      EH6127
## "/home/biocbuild/.cache/R/ExperimentHub/1809249c0b4d1_6170"
```

```
# For Lindel model:
Model_weights.pkl()
```

```
## see ?crisprScoreData and browseVignettes('crisprScoreData') for documentation
## loading from cache
```

```
##                                                       EH6128
## "/home/biocbuild/.cache/R/ExperimentHub/180924682407fd_6171"
```

Or we can access them using the *ExperimentHub* interface:

```
eh <- ExperimentHub()
query(eh, "crisprScoreData")
```

```
## ExperimentHub with 9 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Fudan University, UCSF, University of Washington, New York ...
## # $species: NA
## # $rdataclass: character
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH6123"]]'
##
##            title
##   EH6123 | DeepWt.hdf5
##   EH6124 | DeepWt_T7.hdf5
##   EH6125 | DeepWt_U6.hdf5
##   EH6126 | esp_rnn_model.hdf5
##   EH6127 | hf_rnn_model.hdf5
##   EH6128 | Model_weights.pkl
##   EH7304 | CRISPRa_model.pkl
##   EH7305 | CRISPRi_model.pkl
##   EH7356 | RFcombined.rds
```

```
eh[["EH6127"]]
```

```
## see ?crisprScoreData and browseVignettes('crisprScoreData') for documentation
```

```
## loading from cache
```

```
##                                                      EH6127
## "/home/biocbuild/.cache/R/ExperimentHub/1809249c0b4d1_6170"
```

For details on the source of these files, and on their construction
see `?crisprScoreData` and the scripts:

* `inst/scripts/make-metadata.R`
* `inst/scripts/make-data.Rmd`

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
## [1] crisprScoreData_1.14.0 ExperimentHub_3.0.0    AnnotationHub_4.0.0
## [4] BiocFileCache_3.0.0    dbplyr_2.5.1           BiocGenerics_0.56.0
## [7] generics_0.1.4         BiocStyle_2.38.0
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