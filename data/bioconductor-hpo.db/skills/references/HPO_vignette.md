# HPO\_vignette

#### Erqiang Hu

Department of Bioinformatics, School of Basic Medical Sciences, Southern Medical University
13766876214@163.com

#### 2023-06-28

```
library(HPO.db)
#> HPO.db version 0.99.2
```

## Introduction

Human Phenotype Ontology (HPO) was developed to create a consistent description of gene products with disease perspectives, and is essential for supporting functional genomics in disease context. Accurate disease descriptions can discover new relationships between genes and disease, and new functions for previous uncharacteried genes and alleles.We have developed the [DOSE](https://bioconductor.org/packages/DOSE/) package for semantic similarity analysis and disease enrichment analysis, and `DOSE` import an Bioconductor package ‘DO.db’ to get the relationship(such as parent and child) between DO terms. But `DO.db` hasn’t been updated for years, and a lot of semantic information is [missing](https://github.com/YuLab-SMU/DOSE/issues/57). So we developed the new package `HPO.db` for Human Human Phenotype Ontology annotation.

## :hammer: Installation

The released version from `Bioconductor`

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
## BiocManager::install("BiocUpgrade") ## you may need this
BiocManager::install("HPO.db")
```

## Overview

```
library(AnnotationDbi)
#> Loading required package: stats4
#> Loading required package: BiocGenerics
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, intersect, is.unsorted,
#>     lapply, mapply, match, mget, order, paste, pmax, pmax.int, pmin,
#>     pmin.int, rank, rbind, rownames, sapply, setdiff, sort, table,
#>     tapply, union, unique, unsplit, which.max, which.min
#> Loading required package: Biobase
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#> Loading required package: IRanges
#> Loading required package: S4Vectors
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
```

The annotation data comes from <https://github.com/DiseaseOntology/HumanDiseaseOntology/tree/main/src/ontology>, and HPO.db provide these AnnDbBimap object:

```
ls("package:HPO.db")
#>  [1] "HPO"          "HPO.db"       "HPOALIAS"     "HPOANCESTOR"  "HPOCHILDREN"
#>  [6] "HPODO"        "HPOGENE"      "HPOMAPCOUNTS" "HPOMPO"       "HPOOFFSPRING"
#> [11] "HPOPARENTS"   "HPOSYNONYM"   "HPOTERM"      "HPO_dbInfo"   "HPO_dbconn"
#> [16] "HPO_dbfile"   "HPO_dbschema" "HPOmetadata"  "columns"      "keys"
#> [21] "keytypes"     "select"
packageVersion("HPO.db")
#> [1] '0.99.2'
```

You can use `help` function to get their documents: `help(HPOOFFSPRING)`

```
toTable(HPOmetadata)
#>              name
#> 1        DBSCHEMA
#> 2 DBSCHEMAVERSION
#> 3   HPOSOURCENAME
#> 4     HPOSOURCURL
#> 5   HPOSOURCEDATE
#> 6         Db type
#>                                                                                        value
#> 1                                                                                     HPO_DB
#> 2                                                                                        1.0
#> 3                                                                   Human Phenotype Ontology
#> 4 https://github.com/DiseaseOntology/HumanDiseaseOntology/blob/main/src/ontology/HumanDO.obo
#> 5                                                                                   20230405
#> 6                                                                                      HPODb
HPOMAPCOUNTS
#>  HPOANCESTOR  HPOCHILDREN        HPODO      HPOGENE       HPOMPO HPOOFFSPRING
#>     "178071"      "21139"      "46027"     "415767"       "2282"     "178071"
#>   HPOPARENTS      HPOTERM
#>      "21139"      "16874"
```

## Fetch whole HPO terms

In HPO.db, `HPOTERM` represet the whole HPO terms and their names. The users can also get their aliases and synonyms from `HPOALIAS` and `HPOSYNONYM`, respectively.

convert HPOTERM to table

```
doterm <- toTable(HPOTERM)
head(doterm)
#>        hpoid                            term
#> 1 HP:0000001                             All
#> 2 HP:0000002      Abnormality of body height
#> 3 HP:0000003    Multicystic kidney dysplasia
#> 4 HP:0000005             Mode of inheritance
#> 5 HP:0000006  Autosomal dominant inheritance
#> 6 HP:0000007 Autosomal recessive inheritance
```

convert HPOTERM to list

```
dotermlist <- as.list(HPOTERM)
head(dotermlist)
#> $`HP:0000001`
#> [1] "All"
#>
#> $`HP:0000002`
#> [1] "Abnormality of body height"
#>
#> $`HP:0000003`
#> [1] "Multicystic kidney dysplasia"
#>
#> $`HP:0000005`
#> [1] "Mode of inheritance"
#>
#> $`HP:0000006`
#> [1] "Autosomal dominant inheritance"
#>
#> $`HP:0000007`
#> [1] "Autosomal recessive inheritance"
```

get alias of `HP:0000006`

```
doalias <- as.list(HPOALIAS)
doalias[['HP:0000006']]
#> [1] "HP:0001415" "HP:0001447" "HP:0001448" "HP:0001451" "HP:0001452"
#> [6] "HP:0001455" "HP:0001456" "HP:0001463"
```

get synonym of `HP:0000006`

```
dosynonym <- as.list(HPOSYNONYM)
dosynonym[['HP:0000006']]
#> [1] "\"Autosomal dominant\" EXACT []"
#> [2] "\"Autosomal dominant form\" RELATED [HPO:skoehler]"
#> [3] "\"Autosomal dominant type\" RELATED [HPO:skoehler]"
#> [4] "\"monoallelic_autosomal\" EXACT HP:0034334 []"
```

## Fetch the relationship between HPO terms

Similar to `HPO.db`, we provide four Bimap objects to represent relationship between HPO terms: HPOANCESTOR,HPOPARENTS,HPOOFFSPRING, and HPOCHILDREN.

### HPOANCESTOR

HPOANCESTOR describes the association between HPO terms and their ancestral terms based on a directed acyclic graph (DAG) defined by the Human Phenotype Ontology. We can use `toTable` function in `AnnotationDbi` package to get a two-column data.frame: the first column means the HPO term ids, and the second column means their ancestor terms.

```
anc_table <- toTable(HPOANCESTOR)
head(anc_table)
#>        hpoid   ancestor
#> 1 HP:0000002 HP:0001507
#> 2 HP:0000002 HP:0000118
#> 3 HP:0000002 HP:0000001
#> 4 HP:0000003 HP:0000107
#> 5 HP:0000003 HP:0012210
#> 6 HP:0000003 HP:0000077
```

get ancestor of “HP:0000006”

```
anc_list <- AnnotationDbi::as.list(HPOANCESTOR)
anc_list[["HP:0000006"]]
#> [1] "HP:0034345" "HP:0000005" "HP:0000001"
```

### HPOPARENTS

HPOPARENTS describes the association between HPO terms and their direct parent terms based on DAG. We can use `toTable` function in `AnnotationDbi` package to get a two-column data.frame: the first column means the HPO term ids, and the second column means their parent terms.

```
parent_table <- toTable(HPOPARENTS)
head(parent_table)
#>        hpoid     parent
#> 1 HP:0000002 HP:0001507
#> 2 HP:0000003 HP:0000107
#> 3 HP:0000005 HP:0000001
#> 4 HP:0000006 HP:0034345
#> 5 HP:0000007 HP:0034345
#> 6 HP:0000008 HP:0000812
```

get parent term of “HP:0000006”

```
parent_list <- AnnotationDbi::as.list(HPOPARENTS)
parent_list[["HP:0000006"]]
#> [1] "HP:0034345"
```

### HPOOFFSPRING

HPOPARENTS describes the association between HPO terms and their offspring

get offspring of “HP:0000002”

```
off_list <- AnnotationDbi::as.list(HPO.db::HPOOFFSPRING)
off_list[["HP:0000002"]]
#>  [1] "HP:0000098" "HP:0000839" "HP:0001519" "HP:0001533" "HP:0001548"
#>  [6] "HP:0003498" "HP:0003502" "HP:0003508" "HP:0003510" "HP:0003517"
#> [11] "HP:0003521" "HP:0003561" "HP:0004322" "HP:0004991" "HP:0005026"
#> [16] "HP:0005069" "HP:0008845" "HP:0008848" "HP:0008857" "HP:0008873"
#> [21] "HP:0008890" "HP:0008905" "HP:0008909" "HP:0008921" "HP:0008922"
#> [26] "HP:0008929" "HP:0011404" "HP:0011405" "HP:0011406" "HP:0011407"
#> [31] "HP:0012106" "HP:0012772" "HP:0012773" "HP:0012774"
```

### HPOCHILDREN

HPOCHILDREN describes the association between HPO terms and their direct children terms based on DAG. it’s the exact opposite of `HPOPARENTS`, whose usage is similar to it.

get children of “HP:0000002”

```
child_list <- AnnotationDbi::as.list(HPO.db::HPOCHILDREN)
child_list[["HP:0000002"]]
#> [1] "HP:0000098" "HP:0004322" "HP:0012772"
```

The HPO.db support the `select()`, `keys()`, `keytypes()`, and `columns` interface.

```
columns(HPO.db)
#> [1] "alias"     "ancestor"  "children"  "hpoid"     "offspring" "parent"
#> [7] "synonym"   "term"
## use hpoid keys
dokeys <- head(keys(HPO.db))
res <- select(x = HPO.db, keys = dokeys, keytype = "hpoid",
    columns = c("offspring", "term", "parent"))
head(res)
#>        hpoid  offspring term parent
#> 1 HP:0000001 HP:0000002  All   <NA>
#> 2 HP:0000001 HP:0000003  All   <NA>
#> 3 HP:0000001 HP:0000005  All   <NA>
#> 4 HP:0000001 HP:0000006  All   <NA>
#> 5 HP:0000001 HP:0000007  All   <NA>
#> 6 HP:0000001 HP:0000008  All   <NA>
## use term keys
dokeys <- head(keys(HPO.db, keytype = "term"))
res <- select(x = HPO.db, keys = dokeys, keytype = "term",
    columns = c("offspring", "hpoid", "parent"))
head(res)
#>        hpoid  offspring parent
#> 1 HP:0000001 HP:0000002   <NA>
#> 2 HP:0000001 HP:0000003   <NA>
#> 3 HP:0000001 HP:0000005   <NA>
#> 4 HP:0000001 HP:0000006   <NA>
#> 5 HP:0000001 HP:0000007   <NA>
#> 6 HP:0000001 HP:0000008   <NA>
```

## Semantic similarity analysis

Please go to <https://yulab-smu.top/biomedical-knowledge-mining-book/> for the vignette.

## Disease enrichment analysis

Please go to <https://yulab-smu.top/biomedical-knowledge-mining-book/dose-enrichment.html> for the vignette.

```
sessionInfo()
#> R version 4.3.1 (2023-06-16)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 22.04.2 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.18-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.10.0
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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#> [1] AnnotationDbi_1.63.1 IRanges_2.35.2       S4Vectors_0.39.1
#> [4] Biobase_2.61.0       BiocGenerics_0.47.0  HPO.db_0.99.2
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.41.0               xfun_0.39
#>  [3] bslib_0.5.0                   vctrs_0.6.3
#>  [5] tools_4.3.1                   bitops_1.0-7
#>  [7] generics_0.1.3                curl_5.0.1
#>  [9] tibble_3.2.1                  fansi_1.0.4
#> [11] RSQLite_2.3.1                 blob_1.2.4
#> [13] pkgconfig_2.0.3               dbplyr_2.3.2
#> [15] lifecycle_1.0.3               GenomeInfoDbData_1.2.10
#> [17] compiler_4.3.1                Biostrings_2.69.1
#> [19] httpuv_1.6.11                 GenomeInfoDb_1.37.2
#> [21] htmltools_0.5.5               sass_0.4.6
#> [23] RCurl_1.98-1.12               yaml_2.3.7
#> [25] interactiveDisplayBase_1.39.0 pillar_1.9.0
#> [27] later_1.3.1                   crayon_1.5.2
#> [29] jquerylib_0.1.4               ellipsis_0.3.2
#> [31] cachem_1.0.8                  mime_0.12
#> [33] AnnotationHub_3.9.1           tidyselect_1.2.0
#> [35] digest_0.6.32                 purrr_1.0.1
#> [37] dplyr_1.1.2                   BiocVersion_3.18.0
#> [39] fastmap_1.1.1                 cli_3.6.1
#> [41] magrittr_2.0.3                utf8_1.2.3
#> [43] withr_2.5.0                   filelock_1.0.2
#> [45] promises_1.2.0.1              rappdirs_0.3.3
#> [47] bit64_4.0.5                   rmarkdown_2.22
#> [49] XVector_0.41.1                httr_1.4.6
#> [51] bit_4.0.5                     png_0.1-8
#> [53] memoise_2.0.1                 shiny_1.7.4
#> [55] evaluate_0.21                 knitr_1.43
#> [57] BiocFileCache_2.9.0           rlang_1.1.1
#> [59] Rcpp_1.0.10                   xtable_1.8-4
#> [61] glue_1.6.2                    DBI_1.1.3
#> [63] BiocManager_1.30.21           jsonlite_1.8.5
#> [65] R6_2.5.1                      zlibbioc_1.47.0
```