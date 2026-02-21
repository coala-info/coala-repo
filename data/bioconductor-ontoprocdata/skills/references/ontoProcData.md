# ontoProcData: Data Storage for the package ontoProc

Sara Stankiewicz, Sara.Stankiewicz@channing.harvard.edu

#### October 19, 2022

This package defines an AnnotationHub resource
representing multiple ontologies.

```
library(AnnotationHub)
```

```
## Loading required package: BiocGenerics
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
##     duplicated, eval, evalq, get, grep, grepl, intersect, is.unsorted,
##     lapply, mapply, match, mget, order, paste, pmax, pmax.int, pmin,
##     pmin.int, rank, rbind, rownames, sapply, setdiff, sort, table,
##     tapply, union, unique, unsplit, which.max, which.min
```

```
## Loading required package: BiocFileCache
```

```
## Loading required package: dbplyr
```

```
ahub = AnnotationHub()
```

```
## snapshotDate(): 2022-10-18
```

```
mymeta <- query(ahub , "ontoProcData")
mymeta
```

```
## AnnotationHub with 29 records
## # snapshotDate(): 2022-10-18
## # $dataprovider: NA
## # $species: NA
## # $rdataclass: Rda
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH97934"]]'
##
##              title
##   AH97934  | caro
##   AH97935  | cellLineOnto
##   AH97936  | cellOnto
##   AH97937  | cellosaurusOnto
##   AH97938  | chebi_full
##   ...        ...
##   AH107277 | hcaoOnto_2022.07.19
##   AH107278 | mondo_2022.08.01
##   AH107279 | patoOnto_2022.08.10
##   AH107280 | PROnto_67
##   AH107281 | uberon_2022.06.30
```

```
tag = names(mymeta)[1]
tag
```

```
## [1] "AH97934"
```

Session information

```
sessionInfo()
```

```
## R version 4.2.1 (2022-06-23)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.5 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.16-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.16-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] AnnotationHub_3.5.2 BiocFileCache_2.5.2 dbplyr_2.2.1
## [4] BiocGenerics_0.43.4 BiocStyle_2.25.0
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.9                    png_0.1-7
##  [3] Biostrings_2.65.6             assertthat_0.2.1
##  [5] digest_0.6.30                 utf8_1.2.2
##  [7] mime_0.12                     R6_2.5.1
##  [9] GenomeInfoDb_1.33.12          stats4_4.2.1
## [11] RSQLite_2.2.18                evaluate_0.17
## [13] httr_1.4.4                    pillar_1.8.1
## [15] zlibbioc_1.43.0               rlang_1.0.6
## [17] curl_4.3.3                    jquerylib_0.1.4
## [19] blob_1.2.3                    S4Vectors_0.35.4
## [21] rmarkdown_2.17                stringr_1.4.1
## [23] RCurl_1.98-1.9                bit_4.0.4
## [25] shiny_1.7.2                   compiler_4.2.1
## [27] httpuv_1.6.6                  xfun_0.33
## [29] pkgconfig_2.0.3               htmltools_0.5.3
## [31] tidyselect_1.2.0              KEGGREST_1.37.3
## [33] GenomeInfoDbData_1.2.9        tibble_3.1.8
## [35] interactiveDisplayBase_1.35.1 bookdown_0.29
## [37] IRanges_2.31.2                fansi_1.0.3
## [39] withr_2.5.0                   crayon_1.5.2
## [41] dplyr_1.0.10                  later_1.3.0
## [43] bitops_1.0-7                  rappdirs_0.3.3
## [45] jsonlite_1.8.2                xtable_1.8-4
## [47] lifecycle_1.0.3               DBI_1.1.3
## [49] magrittr_2.0.3                cli_3.4.1
## [51] stringi_1.7.8                 cachem_1.0.6
## [53] XVector_0.37.1                promises_1.2.0.1
## [55] bslib_0.4.0                   ellipsis_0.3.2
## [57] filelock_1.0.2                generics_0.1.3
## [59] vctrs_0.4.2                   tools_4.2.1
## [61] bit64_4.0.5                   Biobase_2.57.1
## [63] glue_1.6.2                    purrr_0.3.5
## [65] BiocVersion_3.16.0            fastmap_1.1.0
## [67] yaml_2.3.6                    AnnotationDbi_1.59.1
## [69] BiocManager_1.30.18           memoise_2.0.1
## [71] knitr_1.40                    sass_0.4.2
```