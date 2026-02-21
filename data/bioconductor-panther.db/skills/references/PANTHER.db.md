# PANTHER.db vignette

### PANTHER.db: An annotation package to access the PANTHER Classification System

Julius Muller

#### 11 October 2023

#### Package

PANTHER.db 1.0.12

# Introduction to `PANTHER.db`

The *[PANTHER.db](https://bioconductor.org/packages/3.18/PANTHER.db)* package provides a `select` interface to the compiled PANTHER ontology residing within a SQLite database.

*[PANTHER.db](https://bioconductor.org/packages/3.18/PANTHER.db)* can be installed from Bioconductor using

```
if (!requireNamespace("BiocManager")) install.packages("BiocManager")
BiocManager::install("PANTHER.db")
```

The size of the underlying SQLite database is currently about 500MB and has to be pre downloaded using AnnotationHub as follows

```
if (!requireNamespace("AnnotationHub")) BiocManager::install("AnnotationHub")
library(AnnotationHub)
ah <- AnnotationHub()
query(ah, "PANTHER.db")[[1]]
```

Finally *[PANTHER.db](https://bioconductor.org/packages/3.18/PANTHER.db)* can be loaded with

```
library(PANTHER.db)
```

If you already know about the select interface, you can immediately
learn about the various methods for this object by just looking at the
help page.

```
help("PANTHER.db")
```

When you load the *[PANTHER.db](https://bioconductor.org/packages/3.18/PANTHER.db)* package, it creates a *[PANTHER.db](https://bioconductor.org/packages/3.18/PANTHER.db)* object. If you look at the object you will see
some helpful information about it.

```
PANTHER.db
```

```
## PANTHER.db object:
## | ORGANISMS: AMBTC|ANOCA|ANOPHELES|AQUAE|ARABIDOPSIS|ASHGO|ASPFU|BACCR|BACSU|BACTN|BATDJ|BOVINE|BRADI|BRADU|BRAFL|BRANA|BRARP|CAEBR|CANAL|CANINE|CAPAN|CHICKEN|CHIMP|CHLAA|CHLRE|CHLTR|CIOIN|CITSI|CLOBH|COELICOLOR|COXBU|CRYNJ|CUCSA|DAPPU|DEIRA|DICDI|DICPU|DICTD|ECOLI|EMENI|ERYGU|EUCGR|FELCA|FLY|FUSNN|GEOSL|GIAIC|GLOVI|GORGO|GOSHI|HAEIN|HALSA|HELAN|HELPY|HELRO|HORSE|HORVV|HUMAN|IXOSC|JUGRE|KORCO|LACSA|LEIMA|LEPIN|LEPOC|LISMO|MAIZE|MALARIA|MANES|MARPO|MEDTR|METAC|METJA|MONBE|MONDO|MOUSE|MUSAM|MYCGE|MYCTU|NEIMB|NELNU|NEMVE|NEUCR|NITMS|ORNAN|ORYLA|ORYSJ|PARTE|PHANO|PHYPA|PHYRM|PIG|POPTR|PRIPA|PRUPE|PSEAE|PUCGT|PYRAE|RAT|RHESUS|RHOBA|RICCO|SACS2|SALTY|SCHJY|SCHPO|SCLS1|SELML|SETIT|SHEON|SOLLC|SOLTU|SORBI|SOYBN|SPIOL|STAA8|STRPU|STRR6|SYNY3|THAPS|THECC|THEKO|THEMA|THEYD|TOBAC|TRIAD|TRICA|TRIVA|TRYB2|USTMA|VIBCH|VITVI|WHEAT|WORM|XANCP|XENOPUS|YARLI|YEAST|YERPE|ZEBRAFISH|ZOSMR
## | PANTHERVERSION: 18.0
## | PANTHERSOURCEURL: ftp.pantherdb.org
## | PANTHERSOURCEDATE: 2023-Sep20
## | package: AnnotationDbi
## | Db type: PANTHER.db
## | DBSCHEMA: PANTHER_DB
## | DBSCHEMAVERSION: 2.1
## | UNIPROT to ENTREZ mapping: 2023-Sep20
```

By default, you can see that the *[PANTHER.db](https://bioconductor.org/packages/3.18/PANTHER.db)* object is set to
retrieve records from the various organisms supported by <http://pantherdb.org>.
Methods are provided to restrict all queries to a specific organism.
In order to change it, you first need to look up the appropriate organism
identifier for the organism that you are interested in.
The PANTHER gene ontology is based on the Uniprot reference proteome set.
In order to display the choices, we have provided the helper function
`availablePthOrganisms` which will list all the supported
organisms along with their Uniprot organism name and taxonomy ids:

```
availablePthOrganisms(PANTHER.db)[1:5,]
```

```
##   AnnotationDbi Species PANTHER Species              Genome Source Genome Date
## 1                 HUMAN           HUMAN Reference Proteome 2022_02       20592
## 2                 MOUSE           MOUSE Reference Proteome 2022_02       21983
## 3                   RAT             RAT Reference Proteome 2022_02       22825
## 4               CHICKEN           CHICK Reference Proteome 2022_02       18108
## 5             ZEBRAFISH           DANRE Reference Proteome 2022_02       26353
##   UNIPROT Species ID UNIPROT Species Name UNIPROT Taxon ID
## 1              HUMAN         Homo sapiens             9606
## 2              MOUSE         Mus musculus            10090
## 3                RAT    Rattus norvegicus            10116
## 4              CHICK        Gallus gallus             9031
## 5              DANRE          Danio rerio             7955
```

Once you have learned the PANTHER organism name for the organism of interest, you
can then change the organism for the *[PANTHER.db](https://bioconductor.org/packages/3.18/PANTHER.db)* object:

```
pthOrganisms(PANTHER.db) <- "HUMAN"
PANTHER.db
```

```
## PANTHER.db object:
## | ORGANISMS: HUMAN
## | PANTHERVERSION: 18.0
## | PANTHERSOURCEURL: ftp.pantherdb.org
## | PANTHERSOURCEDATE: 2023-Sep20
## | package: AnnotationDbi
## | Db type: PANTHER.db
## | DBSCHEMA: PANTHER_DB
## | DBSCHEMAVERSION: 2.1
## | UNIPROT to ENTREZ mapping: 2023-Sep20
```

```
resetPthOrganisms(PANTHER.db)
PANTHER.db
```

```
## PANTHER.db object:
## | ORGANISMS: AMBTC|ANOCA|ANOPHELES|AQUAE|ARABIDOPSIS|ASHGO|ASPFU|BACCR|BACSU|BACTN|BATDJ|BOVINE|BRADI|BRADU|BRAFL|BRANA|BRARP|CAEBR|CANAL|CANINE|CAPAN|CHICKEN|CHIMP|CHLAA|CHLRE|CHLTR|CIOIN|CITSI|CLOBH|COELICOLOR|COXBU|CRYNJ|CUCSA|DAPPU|DEIRA|DICDI|DICPU|DICTD|ECOLI|EMENI|ERYGU|EUCGR|FELCA|FLY|FUSNN|GEOSL|GIAIC|GLOVI|GORGO|GOSHI|HAEIN|HALSA|HELAN|HELPY|HELRO|HORSE|HORVV|HUMAN|IXOSC|JUGRE|KORCO|LACSA|LEIMA|LEPIN|LEPOC|LISMO|MAIZE|MALARIA|MANES|MARPO|MEDTR|METAC|METJA|MONBE|MONDO|MOUSE|MUSAM|MYCGE|MYCTU|NEIMB|NELNU|NEMVE|NEUCR|NITMS|ORNAN|ORYLA|ORYSJ|PARTE|PHANO|PHYPA|PHYRM|PIG|POPTR|PRIPA|PRUPE|PSEAE|PUCGT|PYRAE|RAT|RHESUS|RHOBA|RICCO|SACS2|SALTY|SCHJY|SCHPO|SCLS1|SELML|SETIT|SHEON|SOLLC|SOLTU|SORBI|SOYBN|SPIOL|STAA8|STRPU|STRR6|SYNY3|THAPS|THECC|THEKO|THEMA|THEYD|TOBAC|TRIAD|TRICA|TRIVA|TRYB2|USTMA|VIBCH|VITVI|WHEAT|WORM|XANCP|XENOPUS|YARLI|YEAST|YERPE|ZEBRAFISH|ZOSMR
## | PANTHERVERSION: 18.0
## | PANTHERSOURCEURL: ftp.pantherdb.org
## | PANTHERSOURCEDATE: 2023-Sep20
## | package: AnnotationDbi
## | Db type: PANTHER.db
## | DBSCHEMA: PANTHER_DB
## | DBSCHEMAVERSION: 2.1
## | UNIPROT to ENTREZ mapping: 2023-Sep20
```

As you can see, organisms are now restricted to Homo sapiens.
To display all data which can be returned from a select query,
the columns method can be used:

```
columns(PANTHER.db)
```

```
##  [1] "CLASS_ID"        "CLASS_TERM"      "COMPONENT_ID"    "COMPONENT_TERM"
##  [5] "CONFIDENCE_CODE" "ENTREZ"          "EVIDENCE"        "EVIDENCE_TYPE"
##  [9] "FAMILY_ID"       "FAMILY_TERM"     "GOSLIM_ID"       "GOSLIM_TERM"
## [13] "PATHWAY_ID"      "PATHWAY_TERM"    "SPECIES"         "SUBFAMILY_TERM"
## [17] "UNIPROT"
```

Some of these fields can also be used as keytypes:

```
keytypes(PANTHER.db)
```

```
## [1] "CLASS_ID"     "COMPONENT_ID" "ENTREZ"       "FAMILY_ID"    "GOSLIM_ID"
## [6] "PATHWAY_ID"   "SPECIES"      "UNIPROT"
```

It is also possible to display all possible keys of a table for
any keytype. If keytype is unspecified, the `FAMILY_ID` will be returned.

```
go_ids <- head(keys(PANTHER.db,keytype="GOSLIM_ID"))
go_ids
```

```
## [1] "GO:0000002" "GO:0000003" "GO:0000018" "GO:0000027" "GO:0000030"
## [6] "GO:0000038"
```

Finally, you can loop up whatever combinations of columns, keytypes and keys
that you need when using `select` or `mapIds`.

```
cols <- "CLASS_ID"
res <- mapIds(PANTHER.db, keys=go_ids, column=cols, keytype="GOSLIM_ID", multiVals="list")
lengths(res)
```

```
## GO:0000002 GO:0000003 GO:0000018 GO:0000027 GO:0000030 GO:0000038
##          8         52          8          6          4          8
```

```
res_inner <- select(PANTHER.db, keys=go_ids, columns=cols, keytype="GOSLIM_ID")
nrow(res_inner)
```

```
## [1] 86
```

```
tail(res_inner)
```

```
##       GOSLIM_ID CLASS_ID
## 952  GO:0000038  PC00091
## 953  GO:0000038  PC00144
## 976  GO:0000038  PC00042
## 1035 GO:0000038  PC00003
## 1036 GO:0000038  PC00227
## 1057 GO:0000038  PC00258
```

By default, all tables will be joined using the central table with PANTHER family IDs by an inner join. Therefore all rows without an associated PANTHER family ID will be removed from the output. To include all results with an associated PANTHER family ID, the argument `jointype` of the `select` function must be set to `left`.

```
res_left <- select(PANTHER.db, keys=go_ids, columns=cols,keytype="GOSLIM_ID", jointype="left")
nrow(res_left)
```

```
## [1] 1475
```

```
tail(res_left)
```

```
##       GOSLIM_ID      FAMILY_ID CLASS_ID
## 1470 GO:0000038 PTHR43107:SF11  PC00258
## 1471 GO:0000038 PTHR43107:SF11  PC00227
## 1472 GO:0000038 PTHR43107:SF20  PC00258
## 1473 GO:0000038 PTHR43107:SF20  PC00227
## 1474 GO:0000038  PTHR43107:SF6  PC00258
## 1475 GO:0000038  PTHR43107:SF6  PC00227
```

To access the PANTHER Protein Class ontology tree structure, the
method `traverseClassTree` can be used:

```
term <- "PC00209"
select(PANTHER.db,term, "CLASS_TERM","CLASS_ID")
```

```
## [1] CLASS_ID   CLASS_TERM
## <0 rows> (or 0-length row.names)
```

```
ancestors <- traverseClassTree(PANTHER.db,term,scope="ANCESTOR")
select(PANTHER.db,ancestors, "CLASS_TERM","CLASS_ID")
```

```
## [1] CLASS_ID   CLASS_TERM
## <0 rows> (or 0-length row.names)
```

```
parents <- traverseClassTree(PANTHER.db,term,scope="PARENT")
select(PANTHER.db,parents, "CLASS_TERM","CLASS_ID")
```

```
## [1] CLASS_ID   CLASS_TERM
## <0 rows> (or 0-length row.names)
```

```
children <- traverseClassTree(PANTHER.db,term,scope="CHILD")
select(PANTHER.db,children, "CLASS_TERM","CLASS_ID")
```

```
## [1] CLASS_ID   CLASS_TERM
## <0 rows> (or 0-length row.names)
```

```
offspring <- traverseClassTree(PANTHER.db,term,scope="OFFSPRING")
select(PANTHER.db,offspring, "CLASS_TERM","CLASS_ID")
```

```
## [1] CLASS_ID   CLASS_TERM
## <0 rows> (or 0-length row.names)
```

# SessionInfo

```
sessionInfo()
```

```
## R version 4.3.1 (2023-06-16)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 22.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.18-bioc/R/lib/libRblas.so
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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] PANTHER.db_1.0.12    RSQLite_2.3.1        AnnotationHub_3.9.2
##  [4] BiocFileCache_2.9.1  dbplyr_2.3.4         AnnotationDbi_1.63.2
##  [7] IRanges_2.35.2       S4Vectors_0.39.2     Biobase_2.61.0
## [10] BiocGenerics_0.47.0  BiocStyle_2.29.2
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.41.4               xfun_0.40
##  [3] bslib_0.5.1                   vctrs_0.6.3
##  [5] tools_4.3.1                   bitops_1.0-7
##  [7] generics_0.1.3                curl_5.1.0
##  [9] tibble_3.2.1                  fansi_1.0.5
## [11] blob_1.2.4                    pkgconfig_2.0.3
## [13] lifecycle_1.0.3               GenomeInfoDbData_1.2.10
## [15] compiler_4.3.1                Biostrings_2.69.2
## [17] httpuv_1.6.11                 GenomeInfoDb_1.37.6
## [19] htmltools_0.5.6.1             sass_0.4.7
## [21] RCurl_1.98-1.12               yaml_2.3.7
## [23] interactiveDisplayBase_1.39.0 pillar_1.9.0
## [25] later_1.3.1                   crayon_1.5.2
## [27] jquerylib_0.1.4               ellipsis_0.3.2
## [29] cachem_1.0.8                  mime_0.12
## [31] tidyselect_1.2.0              digest_0.6.33
## [33] purrr_1.0.2                   dplyr_1.1.3
## [35] bookdown_0.35                 BiocVersion_3.18.0
## [37] fastmap_1.1.1                 cli_3.6.1
## [39] magrittr_2.0.3                utf8_1.2.3
## [41] withr_2.5.1                   promises_1.2.1
## [43] filelock_1.0.2                rappdirs_0.3.3
## [45] bit64_4.0.5                   rmarkdown_2.25
## [47] XVector_0.41.1                httr_1.4.7
## [49] bit_4.0.5                     png_0.1-8
## [51] memoise_2.0.1                 shiny_1.7.5
## [53] evaluate_0.22                 knitr_1.44
## [55] rlang_1.1.1                   Rcpp_1.0.11
## [57] xtable_1.8-4                  glue_1.6.2
## [59] DBI_1.1.3                     BiocManager_1.30.22
## [61] jsonlite_1.8.7                R6_2.5.1
## [63] zlibbioc_1.47.0
```