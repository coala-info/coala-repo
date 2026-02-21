# The database manager in OmnipathR

Denes Turei1\*

1Institute for Computational Biomedicine, Heidelberg University

\*turei.denes@gmail.com

#### 29 January 2026

#### Abstract

The database manager is an API within OmnipathR which is able to load
various datasets, keep track of their usage and remove them after an
expiry period. Currently it supports a few Gene Ontology and UniProt
datasets, but easily can be extended to cover all datasets in the
package.

#### Package

OmnipathR 3.18.4

# Contents

* [1 Available datasets](#available-datasets)
* [2 Access a dataset](#access-a-dataset)
* [3 Where are the loaded datasets?](#where-are-the-loaded-datasets)
* [4 How to extend the expiry period?](#how-to-extend-the-expiry-period)
* [5 Where are the datasets defined?](#where-are-the-datasets-defined)
* [6 How to add custom datasets?](#how-to-add-custom-datasets)
* [7 Session information](#session-information)

1 Institute for Computational Biomedicine, Heidelberg University

# 1 Available datasets

To see a full list of datasets call the `omnipath_show_db` function:

```
library(OmnipathR)
omnipath_show_db()
```

```
## # A tibble: 24 × 10
##    name               last_used lifetime package   loader         loader_param latest_param loaded db    key
##  * <chr>              <dttm>       <dbl> <chr>     <chr>          <list>       <lgl>        <lgl>  <lis> <chr>
##  1 Gene Ontology (ba… NA             300 OmnipathR go_ontology_d… <named list> NA           FALSE  <lgl> go_b…
##  2 Gene Ontology (fu… NA             300 OmnipathR go_ontology_d… <named list> NA           FALSE  <lgl> go_f…
##  3 Gene Ontology (AG… NA             300 OmnipathR go_ontology_d… <named list> NA           FALSE  <lgl> go_a…
##  4 Gene Ontology (As… NA             300 OmnipathR go_ontology_d… <named list> NA           FALSE  <lgl> go_a…
##  5 Gene Ontology (ge… NA             300 OmnipathR go_ontology_d… <named list> NA           FALSE  <lgl> go_s…
##  6 Gene Ontology (Ca… NA             300 OmnipathR go_ontology_d… <named list> NA           FALSE  <lgl> go_c…
##  7 Gene Ontology (Dr… NA             300 OmnipathR go_ontology_d… <named list> NA           FALSE  <lgl> go_d…
##  8 Gene Ontology (Ch… NA             300 OmnipathR go_ontology_d… <named list> NA           FALSE  <lgl> go_c…
##  9 Gene Ontology (me… NA             300 OmnipathR go_ontology_d… <named list> NA           FALSE  <lgl> go_m…
## 10 Gene Ontology (pl… NA             300 OmnipathR go_ontology_d… <named list> NA           FALSE  <lgl> go_p…
## # ℹ 14 more rows
```

It returns a tibble where each dataset has a human readable name and a key
which can be used to refer to it. We can also check here if the dataset is
currently loaded, the time it’s been last used, the loader function and its
arguments.

# 2 Access a dataset

Datasets can be accessed by the `get_db` function. Ideally you should call
this function every time you use the dataset. The first time it will be
loaded, the subsequent times the already loaded dataset will be returned.
This way each access is registered and extends the expiry time. Let’s load
the human UniProt-GeneSymbol table. Above we see its key is `up_gs`.

```
up_gs <- get_db('up_gs')
up_gs
```

```
## # A tibble: 20,476 × 2
##    From       To
##    <chr>      <chr>
##  1 A0A087X1C5 CYP2D7
##  2 A0A096LP01 SMIM26
##  3 A0A0B4J2F0 PIGBOS1
##  4 A0A0C5B5G6 MT-RNR1
##  5 A0A0K2S4Q6 CD300H
##  6 A0A0U1RRE5 NBDY
##  7 A0A1B0GTW7 CIROP
##  8 A0A2R8Y7D0 TINCR
##  9 A0A8I5KQE6 RPSA2
## 10 A0AV02     SLC12A8
## # ℹ 20,466 more rows
```

This dataset is a two columns data frame of SwissProt IDs and Gene Symbols.
Looking again at the datasets, we find that this dataset is loaded now and
the `last_used` timestamp is set to the time we called `get_db`:

```
omnipath_show_db()
```

```
## # A tibble: 24 × 10
##    name               last_used lifetime package   loader         loader_param latest_param loaded db    key
##  * <chr>              <dttm>       <dbl> <chr>     <chr>          <list>       <list>       <lgl>  <lis> <chr>
##  1 Gene Ontology (ba… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_b…
##  2 Gene Ontology (fu… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_f…
##  3 Gene Ontology (AG… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_a…
##  4 Gene Ontology (As… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_a…
##  5 Gene Ontology (ge… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_s…
##  6 Gene Ontology (Ca… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_c…
##  7 Gene Ontology (Dr… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_d…
##  8 Gene Ontology (Ch… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_c…
##  9 Gene Ontology (me… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_m…
## 10 Gene Ontology (pl… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_p…
## # ℹ 14 more rows
```

The above table contains also a reference to the dataset, and the arguments
passed to the loader function:

```
d <- omnipath_show_db()
d %>% dplyr::pull(db) %>% magrittr::extract2(16)
```

```
## # A tibble: 20,476 × 2
##    From       To
##    <chr>      <chr>
##  1 A0A087X1C5 CYP2D7
##  2 A0A096LP01 SMIM26
##  3 A0A0B4J2F0 PIGBOS1
##  4 A0A0C5B5G6 MT-RNR1
##  5 A0A0K2S4Q6 CD300H
##  6 A0A0U1RRE5 NBDY
##  7 A0A1B0GTW7 CIROP
##  8 A0A2R8Y7D0 TINCR
##  9 A0A8I5KQE6 RPSA2
## 10 A0AV02     SLC12A8
## # ℹ 20,466 more rows
```

```
d %>% dplyr::pull(latest_param) %>% magrittr::extract2(16)
```

```
## $to
## [1] "genesymbol"
##
## $organism
## [1] 9606
```

If we call `get_db` again, the timestamp is updated, resetting the expiry
counter:

```
up_gs <- get_db('up_gs')
omnipath_show_db()
```

```
## # A tibble: 24 × 10
##    name               last_used lifetime package   loader         loader_param latest_param loaded db    key
##  * <chr>              <dttm>       <dbl> <chr>     <chr>          <list>       <list>       <lgl>  <lis> <chr>
##  1 Gene Ontology (ba… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_b…
##  2 Gene Ontology (fu… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_f…
##  3 Gene Ontology (AG… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_a…
##  4 Gene Ontology (As… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_a…
##  5 Gene Ontology (ge… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_s…
##  6 Gene Ontology (Ca… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_c…
##  7 Gene Ontology (Dr… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_d…
##  8 Gene Ontology (Ch… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_c…
##  9 Gene Ontology (me… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_m…
## 10 Gene Ontology (pl… NA             300 OmnipathR go_ontology_d… <named list> <lgl [1]>    FALSE  <lgl> go_p…
## # ℹ 14 more rows
```

# 3 Where are the loaded datasets?

The loaded datasets live in an environment which belong to the OmnipathR
package. Normally users don’t need to access this environment. As we see
below, `omnipath_show_db` presents us all information availble by directly
looking at the environment:

```
OmnipathR:::omnipathr.env$db$up_gs
```

```
## $name
## [1] "UniProt-GeneSymbol table"
##
## $last_used
## [1] "2026-01-29 20:12:06 EST"
##
## $lifetime
## [1] 300
##
## $package
## [1] "OmnipathR"
##
## $loader
## [1] "uniprot_full_id_mapping_table"
##
## $loader_param
## $loader_param$to
## [1] "genesymbol"
##
## $loader_param$organism
## [1] 9606
##
##
## $latest_param
## $latest_param$to
## [1] "genesymbol"
##
## $latest_param$organism
## [1] 9606
##
##
## $loaded
## [1] TRUE
##
## $db
## # A tibble: 20,476 × 2
##    From       To
##    <chr>      <chr>
##  1 A0A087X1C5 CYP2D7
##  2 A0A096LP01 SMIM26
##  3 A0A0B4J2F0 PIGBOS1
##  4 A0A0C5B5G6 MT-RNR1
##  5 A0A0K2S4Q6 CD300H
##  6 A0A0U1RRE5 NBDY
##  7 A0A1B0GTW7 CIROP
##  8 A0A2R8Y7D0 TINCR
##  9 A0A8I5KQE6 RPSA2
## 10 A0AV02     SLC12A8
## # ℹ 20,466 more rows
```

# 4 How to extend the expiry period?

The default expiry of datasets is given by the option `omnipath.db_lifetime`.
By calling `omnipath_save_config` this option is saved to the default config
file and will be valid in all subsequent sessions. Otherwise it’s valid only
in the current session.

```
options(omnipath.db_lifetime = 600)
omnipath_save_config()
```

# 5 Where are the datasets defined?

The built-in dataset definitions are in a JSON file shipped with the package.
Easiest way to see it is by [the git web interface](https://github.com/saezlab/OmnipathR/blob/master/inst/db/db_def.json).

# 6 How to add custom datasets?

Currently no API available for this, but it would be super easy to implement.
It would be matter of providing a JSON similar to the above, or calling a
function. Please open an issue if you are interested in this feature.

# 7 Session information

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] OmnipathR_3.18.4 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] xfun_0.56           bslib_0.10.0        httr2_1.2.2         websocket_1.4.4     processx_3.8.6
##  [6] tzdb_0.5.0          vctrs_0.7.1         tools_4.5.2         ps_1.9.1            generics_0.1.4
## [11] parallel_4.5.2      curl_7.0.0          tibble_3.3.1        RSQLite_2.4.5       blob_1.3.0
## [16] pkgconfig_2.0.3     R.oo_1.27.1         checkmate_2.3.3     readxl_1.4.5        lifecycle_1.0.5
## [21] compiler_4.5.2      stringr_1.6.0       progress_1.2.3      chromote_0.5.1      htmltools_0.5.9
## [26] sass_0.4.10         yaml_2.3.12         tidyr_1.3.2         later_1.4.5         pillar_1.11.1
## [31] crayon_1.5.3        jquerylib_0.1.4     R.utils_2.13.0      cachem_1.1.0        sessioninfo_1.2.3
## [36] zip_2.3.3           tidyselect_1.2.1    rvest_1.0.5         digest_0.6.39       stringi_1.8.7
## [41] dplyr_1.1.4         purrr_1.2.1         bookdown_0.46       fastmap_1.2.0       cli_3.6.5
## [46] logger_0.4.1        magrittr_2.0.4      utf8_1.2.6          XML_3.99-0.20       withr_3.0.2
## [51] readr_2.1.6         prettyunits_1.2.0   promises_1.5.0      backports_1.5.0     rappdirs_0.3.4
## [56] bit64_4.6.0-1       lubridate_1.9.4     timechange_0.3.0    rmarkdown_2.30      httr_1.4.7
## [61] igraph_2.2.1        bit_4.6.0           otel_0.2.0          cellranger_1.1.0    R.methodsS3_1.8.2
## [66] hms_1.1.4           memoise_2.0.1       evaluate_1.0.5      knitr_1.51          tcltk_4.5.2
## [71] rlang_1.1.7         Rcpp_1.1.1          glue_1.8.0          DBI_1.2.3           selectr_0.5-1
## [76] BiocManager_1.30.27 xml2_1.5.2          vroom_1.7.0         jsonlite_2.0.0      R6_2.6.1
## [81] fs_1.6.6
```