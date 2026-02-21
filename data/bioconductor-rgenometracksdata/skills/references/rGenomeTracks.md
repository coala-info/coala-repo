# rGenomeTracksData

#### Omar Elashkar

rGenomeTracksData is a collection of sample genomic and epigenomic data for demonstrating rGenomeTracks package.

## Data Source

This data is provided by [pyGenomeTracks](https://github.com/deeptools/pyGenomeTracks) project.

## File types

| Name | Type |
| --- | --- |
| bigwig2\_X\_2.5e6\_3.5e6.bw | bigwig |
| dm3\_genes.bed.gz" | bed12 |
| dm3\_genes.bed4.gz" | bed4 |
| dm3\_genes.bed6.gz" | bed6 |
| dm3\_subset\_BDGP5.78.gtf.gz" | gtf |
| epilog.qcat.bgz" | qcat |
| GSM3182416\_E12DHL\_WT\_Hoxd11vp.bedgraph.gz" | bedGraph |
| HoxD\_cluster\_regulatory\_regions\_mm10.bed" | bed |
| Li\_et\_al\_2015.cool | HDF5 compressed sparse (cool) |
| Li\_et\_al\_2015.h5 | HDF5 |
| links2.links | bed links |
| tad\_classification.bed | bed |
| test.arcs | bed links |
| test2.narrowPeak | narrowPeak |

## Installation and loading of libraries

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ObMiTi")
```

```
# loading required libraries
library(rGenomeTracksData)
#> Loading required package: AnnotationHub
#> Loading required package: BiocGenerics
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, intersect, is.unsorted,
#>     lapply, mapply, match, mget, order, paste, pmax, pmax.int, pmin,
#>     pmin.int, rank, rbind, rownames, sapply, setdiff, sort, table,
#>     tapply, union, unique, unsplit, which.max, which.min
#> Loading required package: BiocFileCache
#> Loading required package: dbplyr
library(AnnotationHub)
```

## Query AnnotationHub

```
ah <- AnnotationHub()
#> snapshotDate(): 2021-09-10
query(ah, "rGenomeTracksData")
#> AnnotationHub with 16 records
#> # snapshotDate(): 2021-09-10
#> # $dataprovider: pyGenomeTracks
#> # $species: Drosophila melanogaster, Mus musculus
#> # $rdataclass: String
#> # additional mcols(): taxonomyid, genome, description,
#> #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#> #   rdatapath, sourceurl, sourcetype
#> # retrieve records with, e.g., 'object[["AH95890"]]'
#>
#>             title
#>   AH95890 | bedgraph_chrx_2e6_5e6.bg.bgz
#>   AH95891 | bigwig2_X_2.5e6_3.5e6.bw
#>   AH95892 | chromatinStates_kc.bed.gz
#>   AH95893 | dm3_genes.bed.gz
#>   AH95894 | dm3_genes.bed4.gz
#>   ...       ...
#>   AH95901 | Li_et_al_2015.h5
#>   AH95902 | links2.links
#>   AH95903 | tad_classification.bed
#>   AH95904 | test.arcs
#>   AH95905 | test2.narrowPeak
```

## Fetch Data

After saving the query object, you can access the file you want like that:

```
# locate the file you want for loading from the track
bigwig_file <-  ah[["AH95891"]]
#> downloading 1 resources
#> retrieving 1 resource
#> loading from cache
```

The object is a path to the local directory to the downloaded file.

## Session Info

```
sessionInfo()
#> R version 4.1.1 Patched (2021-09-10 r80880)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 18.04.5 LTS
#>
#> Matrix products: default
#> BLAS:   /home/shepherd/R-Installs/bin/R-4-1-branch/lib/libRblas.so
#> LAPACK: /home/shepherd/R-Installs/bin/R-4-1-branch/lib/libRlapack.so
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] rGenomeTracksData_0.99.0 AnnotationHub_3.1.5      BiocFileCache_2.1.1
#> [4] dbplyr_2.1.1             BiocGenerics_0.39.2
#>
#> loaded via a namespace (and not attached):
#>  [1] Rcpp_1.0.7                    png_0.1-7
#>  [3] Biostrings_2.61.2             assertthat_0.2.1
#>  [5] digest_0.6.27                 utf8_1.2.2
#>  [7] mime_0.11                     R6_2.5.1
#>  [9] GenomeInfoDb_1.29.8           stats4_4.1.1
#> [11] RSQLite_2.2.8                 evaluate_0.14
#> [13] httr_1.4.2                    pillar_1.6.2
#> [15] zlibbioc_1.39.0               rlang_0.4.11
#> [17] curl_4.3.2                    jquerylib_0.1.4
#> [19] blob_1.2.2                    S4Vectors_0.31.3
#> [21] rmarkdown_2.11                stringr_1.4.0
#> [23] RCurl_1.98-1.5                bit_4.0.4
#> [25] shiny_1.7.0                   compiler_4.1.1
#> [27] httpuv_1.6.3                  xfun_0.26
#> [29] pkgconfig_2.0.3               htmltools_0.5.2
#> [31] tidyselect_1.1.1              KEGGREST_1.33.0
#> [33] tibble_3.1.4                  GenomeInfoDbData_1.2.6
#> [35] interactiveDisplayBase_1.31.2 IRanges_2.27.2
#> [37] fansi_0.5.0                   withr_2.4.2
#> [39] crayon_1.4.1                  dplyr_1.0.7
#> [41] later_1.3.0                   bitops_1.0-7
#> [43] rappdirs_0.3.3                jsonlite_1.7.2
#> [45] xtable_1.8-4                  lifecycle_1.0.0
#> [47] DBI_1.1.1                     magrittr_2.0.1
#> [49] stringi_1.7.4                 cachem_1.0.6
#> [51] XVector_0.33.0                promises_1.2.0.1
#> [53] bslib_0.3.0                   ellipsis_0.3.2
#> [55] filelock_1.0.2                generics_0.1.0
#> [57] vctrs_0.3.8                   tools_4.1.1
#> [59] bit64_4.0.5                   Biobase_2.53.0
#> [61] glue_1.4.2                    purrr_0.3.4
#> [63] BiocVersion_3.14.0            fastmap_1.1.0
#> [65] yaml_2.2.1                    AnnotationDbi_1.55.1
#> [67] BiocManager_1.30.16           memoise_2.0.0
#> [69] knitr_1.34                    sass_0.4.0
```