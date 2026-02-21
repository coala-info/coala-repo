# MassBank Data for AnnotationHub

Johannes Rainer

#### 29 October 2025

#### Package

AHMassBank 1.10.0

**Authors**: Johannes Rainer [cre] (ORCID: <https://orcid.org/0000-0002-6977-7147>)
**Compiled**: Wed Oct 29 22:27:48 2025

# 1 Introduction

MassBank is an open access, community maintained annotation database for small
compounds. Annotations provided by this database comprise names, chemical
formulas, exact masses and other chemical properties for small compounds
(including metabolites, medical treatment agents and others). In addition,
fragment spectra are available which are crucial for the annotation of
untargeted mass spectrometry data. The *[CompoundDb](https://bioconductor.org/packages/3.22/CompoundDb)*
Bioconductor package supports conversion of MassBank data into the `CompDb`
(SQLite) format which enables a simplified distribution of the resource and easy
integration into Bioconductor-based annotation workflows.

# 2 Fetch MassBank `CompDb` Databases from `AnnotationHub`

The `AHMassBank` package provides the metadata for all `CompDb` SQLite databases
with [MassBank](https://massbank.eu/MassBank) annotations in `r Biocpkg("AnnotationHub")`. To get and use MassBank annotations we first we
load/update the `AnnotationHub` resource.

```
library(AnnotationHub)
ah <- AnnotationHub()
```

Next we list all *MassBank* entries from `AnnotationHub`.

```
query(ah, "MassBank")
```

```
## AnnotationHub with 8 records
## # snapshotDate(): 2025-10-28
## # $dataprovider: MassBank
## # $species: NA
## # $rdataclass: CompDb
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH107048"]]'
##
##              title
##   AH107048 | MassBank CompDb for release 2021.03
##   AH107049 | MassBank CompDb for release 2022.06
##   AH111334 | MassBank CompDb for release 2022.12.1
##   AH116164 | MassBank CompDb for release 2023.06
##   AH116165 | MassBank CompDb for release 2023.09
##   AH116166 | MassBank CompDb for release 2023.11
##   AH119518 | MassBank CompDb for release 2024.06
##   AH119519 | MassBank CompDb for release 2024.11
```

We fetch the `CompDb` with MassBank annotations for release *2021.03*.

```
qr <- query(ah, c("MassBank", "2021.03"))
cdb <- qr[[1]]
```

```
## loading from cache
```

```
## require("CompoundDb")
```

# 3 Creating `CompDb` Databases from MassBank

MassBank provides its annotation database as a MySQL dump. To simplify its usage
(also for users not experienced with MySQL or with the specific MassBank
database layout), MassBank annotations can also be converted into the
(SQLite-based) `CompDb` format which can be easily used with the
*[CompoundDb](https://bioconductor.org/packages/3.22/CompoundDb)* package. The steps to convert a MassBank MySQL
database to a `CompDb` SQLite database are described below.

First the MySQL database dump needs to be downloaded from the MassBank [github
page](https://github.com/MassBank/MassBank-data/releases). This database needs
to be installed into a local MySQL/MariaDB database server (using `mysql -h localhost -u <username> -p < MassBank.sql` with `<username>` being the name of
the user with write access to the database server).

To transfer the MassBank data into a `CompDb` database a helper function from
the `CompoundDb` package can be used.

```
library(RMariaDB)
con <- dbConnect(MariaDB(), host = "localhost", user = <username>,
                 pass = <password>, dbname = "MassBank")
source(system.file("scripts", "massbank_to_compdb.R", package = "CompoundDb"))
massbank_to_compdb(con)
```

# 4 Session Information

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] CompoundDb_1.14.0       S4Vectors_0.48.0        AnnotationFilter_1.34.0
## [4] AnnotationHub_4.0.0     BiocFileCache_3.0.0     dbplyr_2.5.1
## [7] BiocGenerics_0.56.0     generics_0.1.4          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1       dplyr_1.1.4            farver_2.1.2
##  [4] blob_1.2.4             filelock_1.0.3         Biostrings_2.78.0
##  [7] S7_0.2.0               bitops_1.0-9           fastmap_1.2.0
## [10] lazyeval_0.2.2         RCurl_1.98-1.17        digest_0.6.37
## [13] lifecycle_1.0.4        cluster_2.1.8.1        ProtGenerics_1.42.0
## [16] rsvg_2.7.0             KEGGREST_1.50.0        RSQLite_2.4.3
## [19] magrittr_2.0.4         compiler_4.5.1         rlang_1.1.6
## [22] sass_0.4.10            tools_4.5.1            yaml_2.3.10
## [25] knitr_1.50             htmlwidgets_1.6.4      bit_4.6.0
## [28] curl_7.0.0             xml2_1.4.1             RColorBrewer_1.1-3
## [31] BiocParallel_1.44.0    withr_3.0.2            purrr_1.1.0
## [34] grid_4.5.1             ggplot2_4.0.0          scales_1.4.0
## [37] MASS_7.3-65            dichromat_2.0-0.1      cli_3.6.5
## [40] rmarkdown_2.30         crayon_1.5.3           httr_1.4.7
## [43] rjson_0.2.23           DBI_1.2.3              cachem_1.1.0
## [46] parallel_4.5.1         AnnotationDbi_1.72.0   BiocManager_1.30.26
## [49] XVector_0.50.0         base64enc_0.1-3        vctrs_0.6.5
## [52] jsonlite_2.0.0         bookdown_0.45          IRanges_2.44.0
## [55] bit64_4.6.0-1          clue_0.3-66            jquerylib_0.1.4
## [58] glue_1.8.0             codetools_0.2-20       DT_0.34.0
## [61] stringi_1.8.7          Spectra_1.20.0         gtable_0.3.6
## [64] BiocVersion_3.22.0     GenomicRanges_1.62.0   tibble_3.3.0
## [67] pillar_1.11.1          rappdirs_0.3.3         htmltools_0.5.8.1
## [70] Seqinfo_1.0.0          R6_2.6.1               httr2_1.2.1
## [73] evaluate_1.0.5         Biobase_2.70.0         png_0.1-8
## [76] memoise_2.0.1          bslib_0.9.0            MetaboCoreUtils_1.18.0
## [79] Rcpp_1.1.0             gridExtra_2.3          ChemmineR_3.62.0
## [82] xfun_0.53              fs_1.6.6               MsCoreUtils_1.22.0
## [85] pkgconfig_2.0.3
```