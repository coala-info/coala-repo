# Provide MeSHDb databases for AnnotationHub

Koki Tsuyuzaki

#### 3 April 2024

#### Package

AHMeSHDbs 1.8.0

**Authors**: Koki Tsuyuzaki [aut, cre],
Manabu Ishii [aut],
Itoshi Nikaido [aut]
**Last modified:** 2023-11-22 05:01:24.166254
**Compiled**: Wed Apr 3 06:31:14 2024

# 1 Installation

To install this package, start R (>= 4.1.0) and enter:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("AHMeSHDbs")
```

# 2 Fetch `MeSHDb` databases from `AnnotationHub`

The `AHMeSHDbs` package provides the metadata for all `MeSHDb` SQLite databases
in *[AnnotationHub](https://bioconductor.org/packages/3.19/AnnotationHub)*.
First we load/update the `AnnotationHub` resource.

```
library(AnnotationHub)
ah <- AnnotationHub()
```

Next we list all `MeSHDb` entries from `AnnotationHub`.

```
query(ah, "MeSHDb")
```

```
## AnnotationHub with 639 records
## # snapshotDate(): 2024-04-02
## # $dataprovider: NCBI,DBCLS, FANTOM5,DLRP,IUPHAR,HPRD,STRING,SWISSPROT,TREMB...
## # $species: Xenopus tropicalis, Taeniopygia guttata, Sus scrofa, Strongyloce...
## # $rdataclass: SQLiteFile
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH91572"]]'
##
##
##   AH91572  |
##   AH91573  |
##   AH91574  |
##   AH91575  |
##   AH91576  |
##   ...
##   AH116675 |
##   AH116676 |
##   AH116677 |
##   AH116678 |
##   AH116679 |
##            title
##   AH91572  MeSHDb for Anolis carolinensis (Anole lizard, v001)
##   AH91573  MeSHDb for Anopheles gambiae str. PEST (Anopheline, v001)
##   AH91574  MeSHDb for Ailuropoda melanoleuca (Panda, v001)
##   AH91575  MeSHDb for Apis mellifera (Honey bee, v001)
##   AH91576  MeSHDb for Aspergillus nidulans FGSC A4 (Filamentous ascomycete,...
##   ...      ...
##   AH116675 MeSHDb for Xenopus tropicalis (Tropical clawed frog, v007)
##   AH116676 MeSHDb for Zea mays (Corn, v007)
##   AH116677 MeSHDb for MeSH.db (v007)
##   AH116678 MeSHDb for MeSH.AOR.db (v007)
##   AH116679 MeSHDb for MeSH.PCR.db (v007)
```

We can confirm the metadata in AnnotationHub in Bioconductor S3 bucket
with `mcols()`.

```
mcols(query(ah, "MeSHDb"))
```

```
## DataFrame with 639 rows and 15 columns
##                           title dataprovider                species taxonomyid
##                     <character>  <character>            <character>  <integer>
## AH91572  MeSHDb for Anolis ca..   NCBI,DBCLS    Anolis carolinensis      28377
## AH91573  MeSHDb for Anopheles..   NCBI,DBCLS Anopheles gambiae st..     180454
## AH91574  MeSHDb for Ailuropod..   NCBI,DBCLS Ailuropoda melanoleuca       9646
## AH91575  MeSHDb for Apis mell..   NCBI,DBCLS         Apis mellifera       7460
## AH91576  MeSHDb for Aspergill..   NCBI,DBCLS Aspergillus nidulans..     227321
## ...                         ...          ...                    ...        ...
## AH116675 MeSHDb for Xenopus t..   NCBI,DBCLS     Xenopus tropicalis       8364
## AH116676 MeSHDb for Zea mays ..   NCBI,DBCLS               Zea mays       4577
## AH116677 MeSHDb for MeSH.db (..   NCBI,DBCLS                     NA         NA
## AH116678 MeSHDb for MeSH.AOR...   NCBI,DBCLS                     NA         NA
## AH116679 MeSHDb for MeSH.PCR...   NCBI,DBCLS                     NA         NA
##               genome            description coordinate_1_based
##          <character>            <character>          <integer>
## AH91572           NA Correspondence table..                  1
## AH91573           NA Correspondence table..                  1
## AH91574           NA Correspondence table..                  1
## AH91575           NA Correspondence table..                  1
## AH91576           NA Correspondence table..                  1
## ...              ...                    ...                ...
## AH116675          NA Correspondence table..                  1
## AH116676          NA Correspondence table..                  1
## AH116677          NA Correspondence table..                  1
## AH116678          NA MeSH Hierarchical st..                  1
## AH116679          NA MeSH Hierarchical st..                  1
##                      maintainer rdatadateadded preparerclass
##                     <character>    <character>   <character>
## AH91572  Koki Tsuyuzaki <k.t...     2021-04-19     AHMeSHDbs
## AH91573  Koki Tsuyuzaki <k.t...     2021-04-19     AHMeSHDbs
## AH91574  Koki Tsuyuzaki <k.t...     2021-04-19     AHMeSHDbs
## AH91575  Koki Tsuyuzaki <k.t...     2021-04-19     AHMeSHDbs
## AH91576  Koki Tsuyuzaki <k.t...     2021-04-19     AHMeSHDbs
## ...                         ...            ...           ...
## AH116675 Koki Tsuyuzaki <k.t...     2024-03-18     AHMeSHDbs
## AH116676 Koki Tsuyuzaki <k.t...     2024-03-18     AHMeSHDbs
## AH116677 Koki Tsuyuzaki <k.t...     2024-03-18     AHMeSHDbs
## AH116678 Koki Tsuyuzaki <k.t...     2024-03-18     AHMeSHDbs
## AH116679 Koki Tsuyuzaki <k.t...     2024-03-18     AHMeSHDbs
##                                                      tags  rdataclass
##                                                    <AsIs> <character>
## AH91572   Annotation,Anole lizard,Anolis carolinensis,...  SQLiteFile
## AH91573  Annotation,Anopheles gambiae st..,Anopheline,...  SQLiteFile
## AH91574       Ailuropoda melanoleuca,Annotation,DBCLS,...  SQLiteFile
## AH91575               Annotation,Apis mellifera,DBCLS,...  SQLiteFile
## AH91576       Annotation,Aspergillus nidulans..,DBCLS,...  SQLiteFile
## ...                                                   ...         ...
## AH116675        Annotation,DBCLS,FunctionalAnnotation,...  SQLiteFile
## AH116676                        Annotation,Corn,DBCLS,...  SQLiteFile
## AH116677        Annotation,DBCLS,FunctionalAnnotation,...  SQLiteFile
## AH116678        Annotation,DBCLS,FunctionalAnnotation,...  SQLiteFile
## AH116679        Annotation,DBCLS,FunctionalAnnotation,...  SQLiteFile
##                       rdatapath              sourceurl  sourcetype
##                     <character>            <character> <character>
## AH91572  AHMeSHDbs/v001/MeSH... https://github.com/r..         TSV
## AH91573  AHMeSHDbs/v001/MeSH... https://github.com/r..         TSV
## AH91574  AHMeSHDbs/v001/MeSH... https://github.com/r..         TSV
## AH91575  AHMeSHDbs/v001/MeSH... https://github.com/r..         TSV
## AH91576  AHMeSHDbs/v001/MeSH... https://github.com/r..         TSV
## ...                         ...                    ...         ...
## AH116675 AHMeSHDbs/v007/MeSH... https://github.com/r..         TSV
## AH116676 AHMeSHDbs/v007/MeSH... https://github.com/r..         TSV
## AH116677 AHMeSHDbs/v007/MeSH... https://github.com/r..         TSV
## AH116678 AHMeSHDbs/v007/MeSH... https://github.com/r..         TSV
## AH116679 AHMeSHDbs/v007/MeSH... https://github.com/r..         TSV
```

We can query only the MeSHDb SQLite files for species *Mus musculus*.

```
qr <- query(ah, c("MeSHDb", "Mus musculus"))
# filepath_mmu <- qr[[1]]
```

This filepath is can be specified with the argument of `RSQLite::dbConnect` and
`MeSHDbi::MeSHDb` and also used as the argument of `meshr`, which is an
R/Bioconductor package for MeSH enrichment analysis.

For the details, check the vignettes of `RSQLite`, `MeSHDbi`, and `meshr`.

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