# Motif Comparison using TomTom

# See package website for full vignette

The Bioconductor build system does not have the MEME Suite installed, therefore these vignettes will not contain any R output. To view the full vignette, visit this article page on the memes website [at this link](https://snystrom.github.io/memes-manual/articles/core_tomtom.html)

# Introduction

TomTom is a tool for comparing motifs to a known set of motifs. It takes as input a set of motifs and a database of known motifs to return a ranked list of the significance of the match between the input and known motifs. TomTom can be run using the `runTomTom()` function.

```
library(memes)
library(magrittr)
```

## Accepted database formats

`runTomTom()` can accept a variety of inputs to use as the “known” motif database. The formats are as follows: - a path to a .meme format file (eg `"fly_factor_survey.meme"`) - a list of universalmotifs - the output object from `runDreme()` - a `list()` of all the above. If entries are named, `runTomTom()` will use those names as the database identifier

### Setting a default database

memes can be configured to use a default .meme format file as the query database, which it will use if the user does not provide a value to `database` when calling `runTomTom()`. The following locations will be searched in order:

1. The `meme_db` option, defined using `options(meme_db = "path/to/database.meme")`

* The `meme_db` option can also be set to an R object, like a universalmotif list.

2. The `MEME_DB` environment variable defined in `.Renviron`

* The `MEME_DB` variable will only accept a path to a .meme file

**NOTE:** if an invalid location is found at one option, `runTomTom()` will fall back to the next location if valid (eg if the `meme_db` option is set to an invalid file, but the `MEME_DB` environment variable is a valid file, the `MEME_DB` path will be used.

```
options(meme_db = system.file("extdata/flyFactorSurvey_cleaned.meme", package = "memes", mustWork = TRUE))
```

## Input types

To use TomTom on existing motifs, `runTomTom()` will accept any motifs in `universalmotif` format. The `universalmotif` package provides several utilities for importing data from various sources.

```
library(universalmotif)
example_motif <- create_motif("CCRAAAW")
runTomTom(example_motif)
```

`runTomTom()` can also take the output of `runDreme` as input. This allows users to easily discover denovo motifs, then match them to as set of known motifs. When run on the output of `runDreme`, all `runTomTom()` output columns will be appended to the `runDreme()` output data.frame, so no information will be lost.

```
data("dreme_example")
runTomTom(dreme_example)
```

## Output data

```
# This is a pre-build dataset packaged with memes
# that mirrors running:
# options(meme_db = system.file("inst/extdata/db/fly_factor_survey_id.meme", package = "memes"))
# example_motif <- create_motif("CCRAAAW")
# example_tomtom <- runTomTom(example_motif)
data("example_tomtom")
```

When run using a `universalmotif` object as input, `runTomTom` returns the following columns:

```
names(example_tomtom)
#>  [1] "motif"              "name"               "altname"
#>  [4] "family"             "organism"           "consensus"
#>  [7] "alphabet"           "strand"             "icscore"
#> [10] "nsites"             "bkgsites"           "pval"
#> [13] "qval"               "eval"               "type"
#> [16] "bkg"                "best_match_name"    "best_match_altname"
#> [19] "best_db_name"       "best_match_offset"  "best_match_pval"
#> [22] "best_match_eval"    "best_match_qval"    "best_match_strand"
#> [25] "best_match_motif"   "tomtom"
```

Columns preappended with `best_` indicate the data corresponding to the best match to the motif listed in `name`.

The `tomtom` column is a special column which contains a nested `data.frame` of the rank-order list of TomTom hits for the motif listed in `name`.

```
names(example_tomtom$tomtom[[1]])
#> [1] "match_name"    "match_altname" "match_motif"   "db_name"
#> [5] "match_offset"  "match_pval"    "match_eval"    "match_qval"
#> [9] "match_strand"
```

The `best_match_motif` column contains the universalmotif representation of the best match motif.

```
library(universalmotif)
view_motifs(example_tomtom$best_match_motif)
```

![](data:image/png;base64...)

The `match_motif` column of `tomtom` contains the universalmotif format motif from the database corresponding to each match in descending order.

```
example_tomtom$tomtom[[1]]$match_motif[1:2] %>%
  view_motifs()
```

![](data:image/png;base64...)

The `drop_best_match()` function drops all the `best_match_*` columns from the `runTomTom()` output.

```
example_tomtom %>%
  drop_best_match() %>%
  names
#>  [1] "motif"     "name"      "altname"   "family"    "organism"  "consensus"
#>  [7] "alphabet"  "strand"    "icscore"   "nsites"    "bkgsites"  "pval"
#> [13] "qval"      "eval"      "type"      "bkg"       "tomtom"
```

To unnest the `tomtom` data.frame column, use `tidyr::unnest()`. The `drop_best_match()` function can be useful when doing this to clean up the unnested data.frame.

```
unnested <- example_tomtom %>%
  drop_best_match() %>%
  tidyr::unnest(tomtom)
names(unnested)
#>  [1] "motif"         "name"          "altname"       "family"
#>  [5] "organism"      "consensus"     "alphabet"      "strand"
#>  [9] "icscore"       "nsites"        "bkgsites"      "pval"
#> [13] "qval"          "eval"          "type"          "bkg"
#> [17] "match_name"    "match_altname" "match_motif"   "db_name"
#> [21] "match_offset"  "match_pval"    "match_eval"    "match_qval"
#> [25] "match_strand"
```

To re-nest the tomtom results, use `nest_tomtom()` (Note: that `best_match_` columns will be automatically updated based on the rank-order of the `tomtom` data.frame)

```
unnested %>%
  nest_tomtom() %>%
  names
#>  [1] "name"               "altname"            "family"
#>  [4] "organism"           "consensus"          "alphabet"
#>  [7] "strand"             "icscore"            "nsites"
#> [10] "bkgsites"           "pval"               "qval"
#> [13] "eval"               "type"               "bkg"
#> [16] "\"name\""           "\"altname\""        "best_match_name"
#> [19] "best_match_altname" "best_match_motif"   "best_db_name"
#> [22] "best_match_offset"  "best_match_pval"    "best_match_eval"
#> [25] "best_match_qval"    "best_match_strand"  "motif"
#> [28] "tomtom"
```

### Manipulating the assigned best match

While TomTom can be useful for limiting the search-space for potential true motif matches, often times the default “best match” is not the correct assignment. Users should use their domain-specific knowledge in conjunction with the data returned by TomTom to make this judgement (see below for more details). memes provides a few convenience functions for reassigning these values.

First, the `update_best_match()` function will update the values of the `best_match*` columns to reflect the values stored in the first row of the `tomtom` data.frame entry. This means that **the rank of the `tomtom` data is meaningful**, and users should only manipulate it if intending to create side-effects.

If the user can force motifs to contain a certain motif as their best match using the `force_best_match()` function. `force_best_match()` takes a named vector as input, where the name corresponds to the input motif `name`, and the value corresponds to a `match_name` found in the `tomtom` list data (**NOTE:** this means that users cannot force the best match to be a motif that TomTom did not return as a potential match).

For example, below the example motif could match either “Eip93F\_SANGER\_10”, or “Lag1\_Cell”.

```
example_tomtom$tomtom[[1]] %>% head(3)
#>         match_name match_altname  match_motif                 db_name
#> 1 Eip93F_SANGER_10        Eip93F <mot:Eip9..> flyFactorSurvey_cleaned
#> 2        Lag1_Cell       schlank <mot:Lag1..> flyFactorSurvey_cleaned
#> 3     pho_SOLEXA_5           pho <mot:pho_..> flyFactorSurvey_cleaned
#>   match_offset match_pval match_eval match_qval match_strand
#> 1            4   8.26e-07   0.000459   0.000919            +
#> 2            3   1.85e-03   1.030000   0.781000            +
#> 3            1   2.54e-03   1.410000   0.781000            +
```

The current best match is listed as “Eip93F\_SANGER\_10”.

```
example_tomtom %>%
  dplyr::select(name, best_match_name)
#>            name  best_match_name
#> 1 example_motif Eip93F_SANGER_10
#>
#> [Note: incomplete universalmotif_df object.]
```

To force “example\_motif” to have the best match as “Lag1\_Cell”, do the following:

```
new_tomtom <- example_tomtom %>%
  # multiple motifs can be updated at a time by passing additional name-value pairs.
  force_best_match(c("example_motif" = "Lag1_Cell"))
```

The `best_match_*` columns will be updated to reflect the modifications.

```
# original best match:
example_tomtom$best_match_name
#> [1] "Eip93F_SANGER_10"
# new best match after forcing:
new_tomtom$best_match_name
#> [1] "Lag1_Cell"
```

## Visualize data

`view_tomtom_hits()` can be used to compare the hits from tomtom to each input motif. Hits are shown in descending order by rank. By default, all hits are shown, or the user can pass an integer to `top_n` to view the top number of motifs. This can be a useful plot for determining which of the matches appear to be the “best” hit.

For example, it appears that indeed “Eip93F\_SANGER\_10” is the best of the top 3 hits, as most of the matching sequences in the “Lag1\_Cell” and “pho\_SOLEXA\_5” motifs correspond to low information-content regions of the matched motifs.

```
example_tomtom %>%
  view_tomtom_hits(top_n = 3)
#> [[1]]
```

![](data:image/png;base64...)

## Importing previous data

`importTomTomXML()` can be used to import a `tomtom.xml` file from a previous run on the MEME server or on the commandline. Details for how to save data from the TomTom webserver are below.

### Saving data from TomTom Web Server

To download XML data from the MEME Server, right-click the TomTom XML output link and “Save Target As” or “Save Link As” (see example image below), and save as `<filename>.xml`. This file can be read using `importTomTomXML()`

![](data:image/png;base64...)

# Citation

memes is a wrapper for a select few tools from the MEME Suite, which were developed by another group. In addition to citing memes, please cite the MEME Suite tools corresponding to the tools you use.

If you use `runTomTom()` in your analysis, please cite:

Shobhit Gupta, JA Stamatoyannopolous, Timothy Bailey and William Stafford Noble, “Quantifying similarity between motifs”, Genome Biology, 8(2):R24, 2007. [full text](http://genomebiology.com/2007/8/2/R24)

## Licensing Restrictions

The MEME Suite is free for non-profit use, but for-profit users should purchase a license. See the [MEME Suite Copyright Page](http://meme-suite.org/doc/copyright.html) for details.

# Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] universalmotif_1.28.0 magrittr_2.0.4        memes_1.18.0
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10           generics_0.1.4        tidyr_1.3.1
#>  [4] hms_1.1.4             digest_0.6.37         evaluate_1.0.5
#>  [7] grid_4.5.1            RColorBrewer_1.1-3    pkgload_1.4.1
#> [10] fastmap_1.2.0         R.oo_1.27.1           rprojroot_2.1.1
#> [13] jsonlite_2.0.0        R.utils_2.13.0        brio_1.1.5
#> [16] purrr_1.1.0           scales_1.4.0          Biostrings_2.78.0
#> [19] jquerylib_0.1.4       cli_3.6.5             rlang_1.1.6
#> [22] crayon_1.5.3          XVector_0.50.0        R.methodsS3_1.8.2
#> [25] withr_3.0.2           cachem_1.1.0          yaml_2.3.10
#> [28] cmdfun_1.0.2          tools_4.5.1           ggseqlogo_0.2
#> [31] tzdb_0.5.0            dplyr_1.1.4           ggplot2_4.0.0
#> [34] BiocGenerics_0.56.0   vctrs_0.6.5           R6_2.6.1
#> [37] matrixStats_1.5.0     stats4_4.5.1          lifecycle_1.0.4
#> [40] Seqinfo_1.0.0         S4Vectors_0.48.0      IRanges_2.44.0
#> [43] MASS_7.3-65           waldo_0.6.2           pkgconfig_2.0.3
#> [46] desc_1.4.3            pillar_1.11.1         bslib_0.9.0
#> [49] gtable_0.3.6          Rcpp_1.1.0            glue_1.8.0
#> [52] xfun_0.53             tibble_3.3.0          GenomicRanges_1.62.0
#> [55] tidyselect_1.2.1      MatrixGenerics_1.22.0 knitr_1.50
#> [58] dichromat_2.0-0.1     farver_2.1.2          htmltools_0.5.8.1
#> [61] rmarkdown_2.30        testthat_3.2.3        readr_2.1.5
#> [64] compiler_4.5.1        S7_0.2.0
```