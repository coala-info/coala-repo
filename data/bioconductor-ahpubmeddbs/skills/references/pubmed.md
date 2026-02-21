# Provide PubMed sqlite/tibble/data.table datasets for AnnotationHub

Koki Tsuyuzaki

#### 3 April 2024

#### Package

AHPubMedDbs 1.8.0

**Authors**: Koki Tsuyuzaki [aut, cre],
Manabu Ishii [aut],
Itoshi Nikaido [aut]
**Last modified:** 2023-11-22 05:01:24.574254
**Compiled**: Wed Apr 3 06:31:14 2024

# 1 Installation

To install this package, start R (>= 4.1.0) and enter:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("AHPubMedDbs")
```

# 2 Fetch PubMed tibble datasets from `AnnotationHub`

The `AHPubMedDbs` package provides the metadata for all PubMed datasets
, which is preprocessed as tibble format and saved in
*[AnnotationHub](https://bioconductor.org/packages/3.19/AnnotationHub)*.
First we load/update the `AnnotationHub` resource.

```
library(AnnotationHub)
ah <- AnnotationHub()
```

Next we list all PubMed entries from `AnnotationHub`.

```
query(ah, "PubMed")
```

```
## AnnotationHub with 147 records
## # snapshotDate(): 2024-04-02
## # $dataprovider: NCBI
## # $species: NA
## # $rdataclass: data.table, Tibble, SQLiteFile
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH91771"]]'
##
##              title
##   AH91771  | SQLite for PubMed ID
##   AH91772  | SQLite for PubMed Abstract
##   AH91773  | SQLite for PubMed Author Information
##   AH91774  | SQLite for PMC
##   AH91775  | SQLite for MeSH (Descriptor)
##   ...        ...
##   AH116696 | Data.table for PubMed Author Information
##   AH116697 | Data.table for PMC
##   AH116698 | Data.table for MeSH (Descriptor)
##   AH116699 | Data.table for MeSH (Qualifier)
##   AH116700 | Data.table for MeSH (SCR)
```

We can confirm the metadata in AnnotationHub in Bioconductor S3 bucket
with `mcols()`.

```
mcols(query(ah, "PubMed"))
```

```
## DataFrame with 147 rows and 15 columns
##                           title dataprovider     species taxonomyid      genome
##                     <character>  <character> <character>  <integer> <character>
## AH91771    SQLite for PubMed ID         NCBI          NA         NA          NA
## AH91772  SQLite for PubMed Ab..         NCBI          NA         NA          NA
## AH91773  SQLite for PubMed Au..         NCBI          NA         NA          NA
## AH91774          SQLite for PMC         NCBI          NA         NA          NA
## AH91775  SQLite for MeSH (Des..         NCBI          NA         NA          NA
## ...                         ...          ...         ...        ...         ...
## AH116696 Data.table for PubMe..         NCBI          NA         NA          NA
## AH116697     Data.table for PMC         NCBI          NA         NA          NA
## AH116698 Data.table for MeSH ..         NCBI          NA         NA          NA
## AH116699 Data.table for MeSH ..         NCBI          NA         NA          NA
## AH116700 Data.table for MeSH ..         NCBI          NA         NA          NA
##                     description coordinate_1_based             maintainer
##                     <character>          <integer>            <character>
## AH91771                    PMID                  1 Koki Tsuyuzaki <k.t...
## AH91772  Correspondence table..                  1 Koki Tsuyuzaki <k.t...
## AH91773  Correspondence table..                  1 Koki Tsuyuzaki <k.t...
## AH91774  Correspondence table..                  1 Koki Tsuyuzaki <k.t...
## AH91775  Correspondence table..                  1 Koki Tsuyuzaki <k.t...
## ...                         ...                ...                    ...
## AH116696 Correspondence table..                  1 Koki Tsuyuzaki <k.t...
## AH116697 Correspondence table..                  1 Koki Tsuyuzaki <k.t...
## AH116698 Correspondence table..                  1 Koki Tsuyuzaki <k.t...
## AH116699 Correspondence table..                  1 Koki Tsuyuzaki <k.t...
## AH116700 Correspondence table..                  1 Koki Tsuyuzaki <k.t...
##          rdatadateadded preparerclass                           tags
##             <character>   <character>                         <AsIs>
## AH91771      2021-04-19   AHPubMedDbs         NCBI,PubMed,SQLite,...
## AH91772      2021-04-19   AHPubMedDbs         NCBI,PubMed,SQLite,...
## AH91773      2021-04-19   AHPubMedDbs         NCBI,PubMed,SQLite,...
## AH91774      2021-04-19   AHPubMedDbs            NCBI,PMC,SQLite,...
## AH91775      2021-04-19   AHPubMedDbs       Descriptor,MeSH,NCBI,...
## ...                 ...           ...                            ...
## AH116696     2024-03-18   AHPubMedDbs     data.table,NCBI,PubMed,...
## AH116697     2024-03-18   AHPubMedDbs        data.table,NCBI,PMC,...
## AH116698     2024-03-18   AHPubMedDbs data.table,Descriptor,MeSH,...
## AH116699     2024-03-18   AHPubMedDbs       data.table,MeSH,NCBI,...
## AH116700     2024-03-18   AHPubMedDbs       data.table,MeSH,NCBI,...
##           rdataclass              rdatapath              sourceurl  sourcetype
##          <character>            <character>            <character> <character>
## AH91771   SQLiteFile AHPubMedDbs/v001/pub.. https://github.com/r..         XML
## AH91772   SQLiteFile AHPubMedDbs/v001/abs.. https://github.com/r..         XML
## AH91773   SQLiteFile AHPubMedDbs/v001/aut.. https://github.com/r..         XML
## AH91774   SQLiteFile AHPubMedDbs/v001/pmc.. https://github.com/r..         XML
## AH91775   SQLiteFile AHPubMedDbs/v001/des.. https://github.com/r..         XML
## ...              ...                    ...                    ...         ...
## AH116696  data.table AHPubMedDbs/v007/aut.. https://github.com/r..         XML
## AH116697  data.table AHPubMedDbs/v007/pmc.. https://github.com/r..         XML
## AH116698  data.table AHPubMedDbs/v007/des.. https://github.com/r..         XML
## AH116699  data.table AHPubMedDbs/v007/qua.. https://github.com/r..         XML
## AH116700  data.table AHPubMedDbs/v007/scr.. https://github.com/r..         XML
```

We can retrieve only the PubMedDb tibble files as follows.

```
qr <- query(ah, c("PubMedDb"))
# pubmed_tibble <- qr[[1]]
```

# Session information

```
## R Under development (unstable) (2024-03-18 r86148)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 22.04.4 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.19-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.10.0
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
## [1] AnnotationHub_3.11.3 BiocFileCache_2.11.2 dbplyr_2.5.0
## [4] BiocGenerics_0.49.1  BiocStyle_2.31.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3          sass_0.4.9              utf8_1.2.4
##  [4] generics_0.1.3          BiocVersion_3.19.1      RSQLite_2.3.6
##  [7] digest_0.6.35           magrittr_2.0.3          evaluate_0.23
## [10] bookdown_0.38           fastmap_1.1.1           blob_1.2.4
## [13] jsonlite_1.8.8          AnnotationDbi_1.65.2    GenomeInfoDb_1.39.10
## [16] DBI_1.2.2               BiocManager_1.30.22     httr_1.4.7
## [19] purrr_1.0.2             fansi_1.0.6             Biostrings_2.71.5
## [22] jquerylib_0.1.4         cli_3.6.2               crayon_1.5.2
## [25] rlang_1.1.3             XVector_0.43.1          Biobase_2.63.1
## [28] bit64_4.0.5             withr_3.0.0             cachem_1.0.8
## [31] yaml_2.3.8              tools_4.4.0             memoise_2.0.1
## [34] dplyr_1.1.4             GenomeInfoDbData_1.2.12 filelock_1.0.3
## [37] curl_5.2.1              mime_0.12               png_0.1-8
## [40] vctrs_0.6.5             R6_2.5.1                stats4_4.4.0
## [43] lifecycle_1.0.4         zlibbioc_1.49.3         KEGGREST_1.43.0
## [46] IRanges_2.37.1          S4Vectors_0.41.5        bit_4.0.5
## [49] pkgconfig_2.0.3         pillar_1.9.0            bslib_0.7.0
## [52] glue_1.7.0              xfun_0.43               tibble_3.2.1
## [55] tidyselect_1.2.1        knitr_1.45              htmltools_0.5.8
## [58] rmarkdown_2.26          compiler_4.4.0
```