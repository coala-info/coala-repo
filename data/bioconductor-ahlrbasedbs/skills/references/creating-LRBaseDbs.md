# Provide LRBaseDb databases for AnnotationHub

Koki Tsuyuzaki

#### 3 April 2024

#### Package

AHLRBaseDbs 1.8.0

**Authors**: Koki Tsuyuzaki [aut, cre],
Manabu Ishii [aut],
Itoshi Nikaido [aut]
**Last modified:** 2023-11-22 05:01:24.998254
**Compiled**: Wed Apr 3 06:31:14 2024

# 1 Installation

To install this package, start R (>= 4.1.0) and enter:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("AHLRBaseDbs")
```

# 2 Fetch `LRBaseDb` databases from `AnnotationHub`

The `AHLRBaseDbs` package provides the metadata for all `LRBaseDb` SQLite
databases in *[AnnotationHub](https://bioconductor.org/packages/3.19/AnnotationHub)*.
First we load/update the `AnnotationHub` resource.

```
library(AnnotationHub)
ah <- AnnotationHub()
```

Next we list all `LRBaseDb` entries from `AnnotationHub`.

```
query(ah, "LRBaseDb")
```

```
## AnnotationHub with 872 records
## # snapshotDate(): 2024-04-02
## # $dataprovider: FANTOM5,DLRP,IUPHAR,HPRD,STRING,SWISSPROT,TREMBL,ENSEMBL,CE...
## # $species: Xenopus tropicalis, Vulpes vulpes, Ursus maritimus, Takifugu rub...
## # $rdataclass: SQLiteFile
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH91646"]]'
##
##              title
##   AH91646  | LRBaseDb for Anolis carolinensis (Anole lizard, v001)
##   AH91647  | LRBaseDb for Aquila chrysaetos chrysaetos (Golden eagle, v001)
##   AH91648  | LRBaseDb for Astatotilapia calliptera (Eastern happy, v001)
##   AH91649  | LRBaseDb for Anopheles gambiae str. PEST (Anopheline, v001)
##   AH91650  | LRBaseDb for Ailuropoda melanoleuca (Panda, v001)
##   ...        ...
##   AH116603 | LRBaseDb for Taeniopygia guttata (Zebra finch, v007)
##   AH116604 | LRBaseDb for Takifugu rubripes (Fugu, v007)
##   AH116605 | LRBaseDb for Ursus maritimus (Polar bear, v007)
##   AH116606 | LRBaseDb for Vulpes vulpes (Red fox, v007)
##   AH116607 | LRBaseDb for Xenopus tropicalis (Tropical clawed frog, v007)
```

We can confirm the metadata in AnnotationHub in Bioconductor S3 bucket
with `mcols()`.

```
mcols(query(ah, "LRBaseDb"))
```

```
## DataFrame with 872 rows and 15 columns
##                           title           dataprovider                species
##                     <character>            <character>            <character>
## AH91646  LRBaseDb for Anolis .. FANTOM5,DLRP,IUPHAR,..    Anolis carolinensis
## AH91647  LRBaseDb for Aquila .. FANTOM5,DLRP,IUPHAR,.. Aquila chrysaetos ch..
## AH91648  LRBaseDb for Astatot.. FANTOM5,DLRP,IUPHAR,.. Astatotilapia callip..
## AH91649  LRBaseDb for Anophel.. FANTOM5,DLRP,IUPHAR,.. Anopheles gambiae st..
## AH91650  LRBaseDb for Ailurop.. FANTOM5,DLRP,IUPHAR,.. Ailuropoda melanoleuca
## ...                         ...                    ...                    ...
## AH116603 LRBaseDb for Taeniop.. FANTOM5,DLRP,IUPHAR,..    Taeniopygia guttata
## AH116604 LRBaseDb for Takifug.. FANTOM5,DLRP,IUPHAR,..      Takifugu rubripes
## AH116605 LRBaseDb for Ursus m.. FANTOM5,DLRP,IUPHAR,..        Ursus maritimus
## AH116606 LRBaseDb for Vulpes .. FANTOM5,DLRP,IUPHAR,..          Vulpes vulpes
## AH116607 LRBaseDb for Xenopus.. FANTOM5,DLRP,IUPHAR,..     Xenopus tropicalis
##          taxonomyid      genome            description coordinate_1_based
##           <integer> <character>            <character>          <integer>
## AH91646       28377          NA Correspondence table..                  1
## AH91647      223781          NA Correspondence table..                  1
## AH91648        8154          NA Correspondence table..                  1
## AH91649      180454          NA Correspondence table..                  1
## AH91650        9646          NA Correspondence table..                  1
## ...             ...         ...                    ...                ...
## AH116603      59729          NA Correspondence table..                  1
## AH116604      31033          NA Correspondence table..                  1
## AH116605      29073          NA Correspondence table..                  1
## AH116606       9627          NA Correspondence table..                  1
## AH116607       8364          NA Correspondence table..                  1
##                      maintainer rdatadateadded preparerclass
##                     <character>    <character>   <character>
## AH91646  Koki Tsuyuzaki <k.t...     2021-04-19   AHLRBaseDbs
## AH91647  Koki Tsuyuzaki <k.t...     2021-04-19   AHLRBaseDbs
## AH91648  Koki Tsuyuzaki <k.t...     2021-04-19   AHLRBaseDbs
## AH91649  Koki Tsuyuzaki <k.t...     2021-04-19   AHLRBaseDbs
## AH91650  Koki Tsuyuzaki <k.t...     2021-04-19   AHLRBaseDbs
## ...                         ...            ...           ...
## AH116603 Koki Tsuyuzaki <k.t...     2024-03-18   AHLRBaseDbs
## AH116604 Koki Tsuyuzaki <k.t...     2024-03-18   AHLRBaseDbs
## AH116605 Koki Tsuyuzaki <k.t...     2024-03-18   AHLRBaseDbs
## AH116606 Koki Tsuyuzaki <k.t...     2024-03-18   AHLRBaseDbs
## AH116607 Koki Tsuyuzaki <k.t...     2024-03-18   AHLRBaseDbs
##                                                      tags  rdataclass
##                                                    <AsIs> <character>
## AH91646   Annotation,Anole lizard,Anolis carolinensis,...  SQLiteFile
## AH91647    Annotation,Aquila chrysaetos ch..,BADERLAB,...  SQLiteFile
## AH91648    Annotation,Astatotilapia callip..,BADERLAB,...  SQLiteFile
## AH91649  Annotation,Anopheles gambiae st..,Anopheline,...  SQLiteFile
## AH91650    Ailuropoda melanoleuca,Annotation,BADERLAB,...  SQLiteFile
## ...                                                   ...         ...
## AH116603                  Annotation,BADERLAB,BIOMART,...  SQLiteFile
## AH116604                  Annotation,BADERLAB,BIOMART,...  SQLiteFile
## AH116605                  Annotation,BADERLAB,BIOMART,...  SQLiteFile
## AH116606                  Annotation,BADERLAB,BIOMART,...  SQLiteFile
## AH116607                  Annotation,BADERLAB,BIOMART,...  SQLiteFile
##                       rdatapath              sourceurl  sourcetype
##                     <character>            <character> <character>
## AH91646  AHLRBaseDbs/v001/LRB.. https://github.com/r..         CSV
## AH91647  AHLRBaseDbs/v001/LRB.. https://github.com/r..         CSV
## AH91648  AHLRBaseDbs/v001/LRB.. https://github.com/r..         CSV
## AH91649  AHLRBaseDbs/v001/LRB.. https://github.com/r..         CSV
## AH91650  AHLRBaseDbs/v001/LRB.. https://github.com/r..         CSV
## ...                         ...                    ...         ...
## AH116603 AHLRBaseDbs/v007/LRB.. https://github.com/r..         CSV
## AH116604 AHLRBaseDbs/v007/LRB.. https://github.com/r..         CSV
## AH116605 AHLRBaseDbs/v007/LRB.. https://github.com/r..         CSV
## AH116606 AHLRBaseDbs/v007/LRB.. https://github.com/r..         CSV
## AH116607 AHLRBaseDbs/v007/LRB.. https://github.com/r..         CSV
```

We can query only the LRBaseDb SQLite files for species *Mus musculus*.

```
qr <- query(ah, c("LRBaseDb", "Mus musculus"))
# filepath_mmu <- qr[[1]]
```

This filepath is can be specified with the argument of `RSQLite::dbConnect` and
`LRBaseDbi::LRBaseDb` and also used as the argument of `scTensor`, which is an
R/Bioconductor package for the detection of cell-cell interaction detection.

For the details, check the vignettes of `RSQLite`, `LRBaseDbi`, and `scTensor`.

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