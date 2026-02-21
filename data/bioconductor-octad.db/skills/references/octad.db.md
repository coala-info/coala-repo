# Open Cancer TherApeutic Discovery (OCTAD) database

* [Package overview](#package-overview)
* [Session information](#session-information)

### Evgenii Chekalin, Billy Zeng, Patrick Newbury, Benjamin Glicksberg, Jing Xing, Ke Liu, Dimitri Joseph, Bin Chen

Edited on October 25, 2021; Compiled on October 25, 2021

# Package overview

As the field of precision medicine progresses, we start to tailor treatments for cancer patients classified not only by their clinical, but also by their molecular features. The emerging cancer subtypes defined by these features require dedicated resources to assist the discovery of drug candidates for preclinical evaluation. Voluminous cancer patient gene expression profiles have been accumulated in public databases, enabling the creation of a cancer-specific expression signature. Meanwhile, large-scale gene expression profiles of chemical compounds became available in recent years. By matching the cancer-specific expression signature to compound-induced gene expression profiles from large drug libraries, researchers can prioritize small molecules that present high potency to reverse expression of signature genes for further experimental testing of their efficacy. This approach has proven to be an efficient and cost-effective way to identify efficacious drug candidates. However, the success of this approach requires multiscale procedures, imposing significant challenges to many labs. Therefore, we present OCTAD (<http://octad.org>): an open workspace for virtually screening compounds targeting precise cancer patient groups using gene expression features. We have included 19,127 patient tissue samples covering 50 cancer types, and expression profiles for 12,442 distinct compounds. We will continue to include more tissue samples. We streamline all the procedures including deep-learning based reference tissue selection, disease gene expression signature creation, drug reversal potency scoring, and in silico validation. We release OCTAD as a web portal and a standalone R package to allow experimental and computational scientists to easily navigate the tool. The code and data can also be employed to answer various biological questions.

#Data included within the package.

Package includes all required data for drug repurposing OCTAD pipeline. Initialization of the pipeline starts with listing all available samples:

```
library(octad.db)
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

```
## Welcome to octad.db package. This is a database package, pipeline available via the octad package. If you want to run the pipeline on the webserver, please refer to octad.org
```

```
#select data
suppressMessages(library(octad.db))
phenoDF=get_ExperimentHub_data("EH7274") #load data.frame with samples included in the OCTAD database.
```

```
## see ?octad.db and browseVignettes('octad.db') for documentation
```

```
## loading from cache
```

```
head(phenoDF) #list all data included within the package
```

```
##                  sample.id sample.type                  biopsy.site cancer
## 1 GTEX-1117F-0226-SM-5GZZ7      normal       ADIPOSE - SUBCUTANEOUS normal
## 2 GTEX-1117F-0426-SM-5EGHI      normal            MUSCLE - SKELETAL normal
## 3 GTEX-1117F-0526-SM-5EGHJ      normal              ARTERY - TIBIAL normal
## 4 GTEX-1117F-0626-SM-5N9CS      normal            ARTERY - CORONARY normal
## 5 GTEX-1117F-0726-SM-5GIEN      normal     HEART - ATRIAL APPENDAGE normal
## 6 GTEX-1117F-1326-SM-5EGHH      normal ADIPOSE - VISCERAL (OMENTUM) normal
##   data.source gender read.count.file age_in_year metastatic_site tumor_grade
## 1        GTEX Female      TOIL.RData        <NA>            <NA>        <NA>
## 2        GTEX Female      TOIL.RData        <NA>            <NA>        <NA>
## 3        GTEX Female      TOIL.RData        <NA>            <NA>        <NA>
## 4        GTEX Female      TOIL.RData        <NA>            <NA>        <NA>
## 5        GTEX Female      TOIL.RData        <NA>            <NA>        <NA>
## 6        GTEX Female      TOIL.RData        <NA>            <NA>        <NA>
##   tumor_stage gain_list loss_list mutation_list subtype
## 1        <NA>                              <NA>    <NA>
## 2        <NA>                              <NA>    <NA>
## 3        <NA>                              <NA>    <NA>
## 4        <NA>                              <NA>    <NA>
## 5        <NA>                              <NA>    <NA>
## 6        <NA>                              <NA>    <NA>
```

Besides, the package includes examples of the output from diffExp and runsRGES functions from the octad package along with desctiption of the data:

```
data("res_example",package='octad.db') #load example res from octad.db
```

```
## Warning in data("res_example", package = "octad.db"): data set 'res_example'
## not found
```

```
data("sRGES_example",package='octad.db') #load example sRGES from octad.db
```

```
## Warning in data("sRGES_example", package = "octad.db"): data set
## 'sRGES_example' not found
```

Please note, this is a database-like package for the main package octad which can be obtained [here](https://bioconductor.org/packages/octad) After the package will be accepted to the bioconductor, it will be available on the [bioconductor website](https://bioconductor.org/octad)

# Session information

Here is the output of sessionInfo on the system where this document was compiled:

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
## [1] octad.db_1.12.0     ExperimentHub_3.0.0 AnnotationHub_4.0.0
## [4] BiocFileCache_3.0.0 dbplyr_2.5.1        BiocGenerics_0.56.0
## [7] generics_0.1.4
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3       sass_0.4.10          BiocVersion_3.22.0
##  [4] RSQLite_2.4.3        digest_0.6.37        magrittr_2.0.4
##  [7] evaluate_1.0.5       fastmap_1.2.0        blob_1.2.4
## [10] jsonlite_2.0.0       AnnotationDbi_1.72.0 DBI_1.2.3
## [13] BiocManager_1.30.26  httr_1.4.7           purrr_1.1.0
## [16] Biostrings_2.78.0    httr2_1.2.1          jquerylib_0.1.4
## [19] cli_3.6.5            rlang_1.1.6          crayon_1.5.3
## [22] XVector_0.50.0       Biobase_2.70.0       bit64_4.6.0-1
## [25] withr_3.0.2          cachem_1.1.0         yaml_2.3.10
## [28] tools_4.5.1          memoise_2.0.1        dplyr_1.1.4
## [31] filelock_1.0.3       curl_7.0.0           vctrs_0.6.5
## [34] R6_2.6.1             png_0.1-8            stats4_4.5.1
## [37] lifecycle_1.0.4      Seqinfo_1.0.0        KEGGREST_1.50.0
## [40] S4Vectors_0.48.0     IRanges_2.44.0       bit_4.6.0
## [43] pkgconfig_2.0.3      pillar_1.11.1        bslib_0.9.0
## [46] glue_1.8.0           xfun_0.54            tibble_3.3.0
## [49] tidyselect_1.2.1     knitr_1.50           htmltools_0.5.8.1
## [52] rmarkdown_2.30       compiler_4.5.1
```