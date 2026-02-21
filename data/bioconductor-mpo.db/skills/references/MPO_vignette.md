# MPO\_vignette

## Authors

Erqiang Hu

Department of Bioinformatics, School of Basic Medical Sciences, Southern Medical University.

## Introduction

We have developed the human disease ontology R package HDO.db, which provides the semantic relationship between human diseases. Relying on the DOSE and GOSemSim packages we developed, we can carry out disease enrichment and semantic similarity analyses. Many biological studies are achieved through mouse models,
and a large number of data indicate the association between genotypes and phenotypes or diseases. The study of model organisms can be transformed into useful knowledge about normal human biology and disease to facilitate treatment and early screening for diseases. Organism-specific genotype-phenotypic associations can be applied to cross-species phenotypic studies to clarify previously unknown phenotypic connections in other species. Using the same principle to diseases can identify genetic associations and even help to identify disease associations that are not obvious. Therefore, as a supplement to HDO.db and DOSE, we developed mouse phenotypic ontology R package MPO.db.

MPO.db mainly contains four kinds of annotation information, which come from:

1. Mammalian Phenotype Ontology data

The ontology data contains the id, name, def, and synonym of the ontology, as also as the parent-child relationship between the ontology. The data comes from: MPheno\_OBO.ontology file downloaded from <http://www.informatics.jax.org/downloads/reports/index.html#pheno>.

2. Gene-phenotype association data

These data demonstrate the effect of each genotype on the phenotype. The data come from: MGI database(<http://www.informatics.jax.org/downloads/reports/index.html#pheno>) and IMPC database (<http://ftp.ebi.ac.uk/pub/databases/impc/all-data-releases/> release-18.0/results/).

3. Gene-disease association data

These data demonstrate the effect of each genotype on the disease. The data come from: MGI database(<http://www.informatics.jax.org/downloads/reports/index.html#pheno>), IMPC database(<http://ftp.ebi.ac.uk/pub/databases/impc/all-data-releases/> release-18.0/results/), and alliance of genome resources(<https://www.alliancegenome.org/downloads>).

4. Phenotype-disease association data

These data demonstrate the effect of each phenotype on the disease. The data come from: <https://github.com/DiseaseOntology/HumanDiseaseOntology>, and <https://github.com/mapping-commons/mh_mapping_initiative>.

## :hammer: Installation

The released version from `Bioconductor`

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
## BiocManager::install("BiocUpgrade") ## you may need this
BiocManager::install("MPO.db")
```

```
library(MPO.db)
#> MPO.db version 0.99.8
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
#>     pmin.int, rank, rbind, rownames, sapply, setdiff, table, tapply,
#>     union, unique, unsplit, which.max, which.min
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

MPO.db provide these AnnDbBimap object:

```
ls("package:MPO.db")
#>  [1] "MPO"          "MPO.db"       "MPOALIAS"     "MPOANATOMY"   "MPOANCESTOR"
#>  [6] "MPOCHILDREN"  "MPOMAPCOUNTS" "MPOMGIDO"     "MPOMPDO"      "MPOMPMGI"
#> [11] "MPOOFFSPRING" "MPOPARENTS"   "MPOSYNONYM"   "MPOTERM"      "MPO_dbInfo"
#> [16] "MPO_dbconn"   "MPO_dbfile"   "MPO_dbschema" "MPOmetadata"  "columns"
#> [21] "keys"         "keytypes"     "select"
packageVersion("MPO.db")
#> [1] '0.99.8'
```

You can use `help` function to get their documents: `help(MPOFFSPRING)`

```
toTable(MPOmetadata)
#>              name
#> 1        DBSCHEMA
#> 2 DBSCHEMAVERSION
#> 3   MPOSOURCENAME
#> 4     MPOSOURCURL
#> 5   MPOSOURCEDATE
#> 6         Db type
#>                                                               value
#> 1                                                            MPO_DB
#> 2                                                               2.0
#> 3                                                               MGI
#> 4 http://www.informatics.jax.org/downloads/reports/index.html#pheno
#> 5                                                          20240725
#> 6                                                             MPODb
MPOMAPCOUNTS
#>  MPOANCESTOR  MPOCHILDREN MPOOFFSPRING   MPOPARENTS      MPOTERM
#>     "124741"      "18330"     "124741"      "18330"      "14162"
```

## Fetch whole MP terms

In MPO.db, `MPOTERM` represet the whole MP terms and their names. The users can also get their aliases and synonyms from `MPOALIAS` and `MPOSYNONYM`, respectively.

convert MPOTERM to table

```
doterm <- toTable(MPOTERM)
head(doterm)
#>         mpid                                  term
#> 1 MP:0000001                   mammalian phenotype
#> 2 MP:0000003    abnormal adipose tissue morphology
#> 3 MP:0000005 increased brown adipose tissue amount
#> 4 MP:0000008 increased white adipose tissue amount
#> 5 MP:0000010 abnormal abdominal fat pad morphology
#> 6 MP:0000013  abnormal adipose tissue distribution
```

convert MPOTERM to list

```
dotermlist <- as.list(MPOTERM)
head(dotermlist)
#> $`MP:0000001`
#> [1] "mammalian phenotype"
#>
#> $`MP:0000003`
#> [1] "abnormal adipose tissue morphology"
#>
#> $`MP:0000005`
#> [1] "increased brown adipose tissue amount"
#>
#> $`MP:0000008`
#> [1] "increased white adipose tissue amount"
#>
#> $`MP:0000010`
#> [1] "abnormal abdominal fat pad morphology"
#>
#> $`MP:0000013`
#> [1] "abnormal adipose tissue distribution"
```

get alias of `MP:0000003`

```
doalias <- as.list(MPOALIAS)
doalias[['MP:0000003']]
#> [1] "MP:0000011"
```

get synonym of `MP:0000003`

```
dosynonym <- as.list(MPOSYNONYM)
dosynonym[['MP:0000003']]
#> [1] "\"abnormality of adipose tissue\" BROAD []"
#> [2] "\"adipose tissue abnormalities\" BROAD []"
#> [3] "\"adipose tissue dysplasia\" EXACT []"
```

## Fetch the relationship between MP terms

Similar to `HDO.db`, we provide four Bimap objects to represent relationship between MP terms: MPOANCESTOR,MPOPARENTS,MPOOFFSPRING, and MPOCHILDREN.

### MPOANCESTOR

MPOANCESTOR describes the association between MP terms and their ancestral terms based on a directed acyclic graph (DAG) defined by the Mouse Phenotype Ontology. We can use `toTable` function in `AnnotationDbi` package to get a two-column data.frame: the first column means the MP term ids, and the second column means their ancestor terms.

```
anc_table <- toTable(MPOANCESTOR)
head(anc_table)
#>         mpid   ancestor
#> 1 MP:0000003 MP:0000001
#> 2 MP:0000003 MP:0005375
#> 3 MP:0000005 MP:0000001
#> 4 MP:0000005 MP:0005375
#> 5 MP:0000005 MP:0000003
#> 6 MP:0000005 MP:0002971
```

get ancestor of “MP:0000013”

```
anc_list <- AnnotationDbi::as.list(MPOANCESTOR)
anc_list[["MP:0000013"]]
#> [1] "MP:0000001" "MP:0005375" "MP:0000003"
```

### MPOPARENTS

MPOPARENTS describes the association between MP terms and their direct parent terms based on DAG. We can use `toTable` function in `AnnotationDbi` package to get a two-column data.frame: the first column means the MP term ids, and the second column means their parent terms.

```
parent_table <- toTable(MPOPARENTS)
head(parent_table)
#>         mpid     parent
#> 1 MP:0000003 MP:0005375
#> 2 MP:0000005 MP:0001778
#> 3 MP:0000008 MP:0001781
#> 4 MP:0000010 MP:0005334
#> 5 MP:0000013 MP:0000003
#> 6 MP:0000015 MP:0002095
```

get parent term of “MP:0000013”

```
parent_list <- AnnotationDbi::as.list(MPOPARENTS)
parent_list[["MP:0000013"]]
#> [1] "MP:0000003"
```

### MPOOFFSPRING

MPOPARENTS describes the association between MP terms and their offspring
terms based on DAG. it’s the exact opposite of `MPOANCESTOR`, whose usage is similar to it.

get offspring of “MP:0000010”

```
off_list <- AnnotationDbi::as.list(MPO.db::MPOOFFSPRING)
off_list[["MP:0000010"]]
#>  [1] "MP:0005335" "MP:0005336" "MP:0005337" "MP:0006319" "MP:0008900"
#>  [6] "MP:0008901" "MP:0008902" "MP:0008903" "MP:0008906" "MP:0009283"
#> [11] "MP:0009285" "MP:0009286" "MP:0009287" "MP:0009288" "MP:0009289"
#> [16] "MP:0009292" "MP:0009293" "MP:0009298" "MP:0009299" "MP:0009300"
#> [21] "MP:0009301" "MP:0009302" "MP:0009303" "MP:0009304" "MP:0009305"
#> [26] "MP:0009306" "MP:0009307" "MP:0010044" "MP:0010045" "MP:0010046"
#> [31] "MP:0020998"
```

### MPOCHILDREN

MPOCHILDREN describes the association between MP terms and their direct children terms based on DAG. it’s the exact opposite of `MPOPARENTS`, whose usage is similar to it.

get children of “MP:0000003”

```
child_list <- AnnotationDbi::as.list(MPO.db::MPOCHILDREN)
child_list[["MP:0000003"]]
#>  [1] "MP:0000013" "MP:0002970" "MP:0002971" "MP:0005334" "MP:0005452"
#>  [6] "MP:0005457" "MP:0009115" "MP:0011167" "MP:0011174" "MP:0012320"
#> [11] "MP:0013249" "MP:0030007" "MP:0030993"
```

The MPO.db support the `select()`, `keys()`, `keytypes()`, and `columns` interface.

```
columns(MPO.db)
#>  [1] "alias"     "ancestor"  "children"  "doid"      "mgi"       "mpid"
#>  [7] "offspring" "parent"    "synonym"   "term"
## use mpid keys
dokeys <- keys(MPO.db)[1:100]
res <- select(x = MPO.db, keys = dokeys, keytype = "mpid",
    columns = c("offspring", "term", "doid", "mgi"))
head(na.omit(res))
#>             mpid  offspring                      term         doid    mgi
#> 17277 MP:0000015 MP:0011278 abnormal ear pigmentation DOID:0080105  14572
#> 17278 MP:0000015 MP:0011278 abnormal ear pigmentation DOID:0080105  14910
#> 17279 MP:0000015 MP:0011278 abnormal ear pigmentation DOID:0080105  16590
#> 17280 MP:0000015 MP:0011278 abnormal ear pigmentation DOID:0080105  17918
#> 17281 MP:0000015 MP:0011278 abnormal ear pigmentation DOID:0080105 192232
#> 17282 MP:0000015 MP:0011278 abnormal ear pigmentation DOID:0080105 192236

key <-  keys(MPO.db, "mpid")[1:100]
res <- select(x = MPO.db, keys = key, keytype = "mpid",
    columns = c("mpid", "term", "children"))
head(na.omit(res))
#>         mpid                term   children
#> 1 MP:0000001 mammalian phenotype MP:0001186
#> 2 MP:0000001 mammalian phenotype MP:0002006
#> 3 MP:0000001 mammalian phenotype MP:0002873
#> 4 MP:0000001 mammalian phenotype MP:0003631
#> 5 MP:0000001 mammalian phenotype MP:0005367
#> 6 MP:0000001 mammalian phenotype MP:0005369

## use term keys
# dokeys <- head(keys(MPO.db, keytype = "term"))
# res <- select(x = MPO.db, keys = dokeys, keytype = "term",
#     columns = c("offspring", "mpid", "parent"))
# head(res)

dokeys <- keys(MPO.db, keytype = "term")[1:100]
res <- select(x = MPO.db, keys = dokeys, keytype = "term",
    columns = c("offspring", "mpid", "doid", "mgi"))
head(na.omit(res))
#>             mpid                      term  offspring         doid    mgi
#> 17277 MP:0000015 abnormal ear pigmentation MP:0011278 DOID:0080105  14572
#> 17278 MP:0000015 abnormal ear pigmentation MP:0011278 DOID:0080105  14910
#> 17279 MP:0000015 abnormal ear pigmentation MP:0011278 DOID:0080105  16590
#> 17280 MP:0000015 abnormal ear pigmentation MP:0011278 DOID:0080105  17918
#> 17281 MP:0000015 abnormal ear pigmentation MP:0011278 DOID:0080105 192232
#> 17282 MP:0000015 abnormal ear pigmentation MP:0011278 DOID:0080105 192236

## use mgi keys
key <- keys(MPO.db, "mgi")[1:100]
res <- select(x = MPO.db, keys = key, keytype = "mgi",
    columns = c("mgi", "mpid", "children"))
head(na.omit(res))
#>         mpid   mgi   children
#> 1 MP:0005367 69865 MP:0000516
#> 2 MP:0005367 69865 MP:0005502
#> 3 MP:0005369 69865 MP:0002106
#> 4 MP:0005369 69865 MP:0002108
#> 5 MP:0005370 69865 MP:0002138
#> 6 MP:0005370 69865 MP:0002139

res <- select(x = MPO.db, keys = key, keytype = "mgi",
    columns = c("doid", "mgi"))
head(na.omit(res))
#>     mgi         doid
#> 1 11666   DOID:10588
#> 2 74591 DOID:0060713
#> 3 67469 DOID:0050729
#> 4 18670    DOID:1949
#> 5 18670   DOID:13580
#> 6 11304 DOID:0111013
```

## Semantic similarity analysis

Please go to <https://yulab-smu.top/biomedical-knowledge-mining-book/> for the vignette.

## Disease enrichment analysis

Please go to <https://yulab-smu.top/biomedical-knowledge-mining-book/dose-enrichment.html> for the vignette.

```
sessionInfo()
#> R version 4.4.1 (2024-06-14)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 22.04.4 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.20-bioc/R/lib/libRblas.so
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
#> [1] AnnotationDbi_1.67.0 IRanges_2.39.2       S4Vectors_0.43.2
#> [4] Biobase_2.65.0       BiocGenerics_0.51.0  MPO.db_0.99.8
#>
#> loaded via a namespace (and not attached):
#>  [1] rappdirs_0.3.3          sass_0.4.9              utf8_1.2.4
#>  [4] generics_0.1.3          BiocVersion_3.20.0      RSQLite_2.3.7
#>  [7] digest_0.6.36           magrittr_2.0.3          evaluate_0.24.0
#> [10] fastmap_1.2.0           blob_1.2.4              AnnotationHub_3.13.1
#> [13] jsonlite_1.8.8          GenomeInfoDb_1.41.1     DBI_1.2.3
#> [16] BiocManager_1.30.23     httr_1.4.7              purrr_1.0.2
#> [19] fansi_1.0.6             UCSC.utils_1.1.0        Biostrings_2.73.1
#> [22] jquerylib_0.1.4         cli_3.6.3               rlang_1.1.4
#> [25] crayon_1.5.3            dbplyr_2.5.0            XVector_0.45.0
#> [28] bit64_4.0.5             withr_3.0.1             cachem_1.1.0
#> [31] yaml_2.3.10             tools_4.4.1             memoise_2.0.1
#> [34] dplyr_1.1.4             filelock_1.0.3          GenomeInfoDbData_1.2.12
#> [37] curl_5.2.1              mime_0.12               vctrs_0.6.5
#> [40] R6_2.5.1                png_0.1-8               lifecycle_1.0.4
#> [43] BiocFileCache_2.13.0    zlibbioc_1.51.1         KEGGREST_1.45.1
#> [46] bit_4.0.5               pkgconfig_2.0.3         bslib_0.8.0
#> [49] pillar_1.9.0            glue_1.7.0              tidyselect_1.2.1
#> [52] xfun_0.46               tibble_3.2.1            knitr_1.48
#> [55] htmltools_0.5.8.1       rmarkdown_2.27          compiler_4.4.1
```