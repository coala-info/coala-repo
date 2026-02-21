# JASPAR2022

Damir Baranasic

Imperial College London, Faculty of Medicine, Institute of Clinical Sciences, Hammersmith Campus, Du Cane Road, W12 0NN, London

#### 28 February 2024

# Contents

* [1 Introduction](#introduction)
* [2 Retrieving matrices from JASPAR2022 by ID or name](#retrieving-matrices-from-jaspar2022-by-id-or-name)
* [3 The use of filtering criteria](#the-use-of-filtering-criteria)
* [4 Session Info](#session-info)
* [Bibliography](#bibliography)

# 1 Introduction

JASPAR (<http://jaspar.genereg.net/>) is an open-access database containing manually curated, non-redundant transcription factor (TF) binding profiles for TFs across six taxonomic groups. In this 9th release, we expanded the CORE collection with 341 new profiles (148 for plants, 101 for vertebrates, 85 for urochordates, and 7 for insects), which corresponds to a 19% expansion over the previous release. We added 298 new profiles to the Unvalidated collection when no orthogonal evidence was found in the literature. All the profiles were clustered to provide familial binding profiles for each taxonomic group. Moreover, we revised the structural classification of DNA binding domains to consider plant-specific TFs. This release introduces word clouds to represent the scientific knowledge associated with each TF. We updated the genome tracks of TFBSs predicted with JASPAR profiles in eight organisms; the human and mouse TFBS predictions can be visualized as native tracks in the UCSC Genome Browser. Finally, we provide a new tool to perform JASPAR TFBS enrichment analysis in user-provided genomic regions. All the data is accessible through the JASPAR website, its associated RESTful API, the R/Bioconductor data package, and a new Python package, pyJASPAR, that facilitates serverless access to the data.

The easiest way to use the JASPAR2022 data package (Castro-Mondragon et al. [2021](#ref-10.1093/nar/gkab1113)) is by `TFBSTools` package interface (Tan and Lenhard [2016](#ref-Tan:2016)), which provides functions to retrieve and manipulate data from the JASPAR database. This vignette demonstrates how to use those functions.

```
library(JASPAR2022)
library(TFBSTools)
```

# 2 Retrieving matrices from JASPAR2022 by ID or name

Matrices from JASPAR can be retrieved using either `getMatrixByID` or `getMatrixByName` function by providing a matrix ID or a matrix name from JASPAR, respectively. These functions accept either a single element as the ID/name parameter or a vector of values. The former case returns a `PFMatrix` object, while the later one returns a `PFMatrixList` with multiple `PFMatrix` objects.

```
## the user assigns a single matrix ID to the argument ID
pfm <- getMatrixByID(JASPAR2022, ID = "MA0139.1")
## the function returns a PFMatrix object
pfm
#> An object of class PFMatrix
#> ID: MA0139.1
#> Name: CTCF
#> Matrix Class: C2H2 zinc finger factors
#> strand: +
#> Tags:
#> $comment
#> [1] "TF has several motif variants."
#>
#> $family
#> [1] "More than 3 adjacent zinc fingers"
#>
#> $medline
#> [1] "17512414"
#>
#> $remap_tf_name
#> [1] "CTCF"
#>
#> $tax_group
#> [1] "vertebrates"
#>
#> $tfbs_shape_id
#> [1] "133"
#>
#> $type
#> [1] "ChIP-seq"
#>
#> $collection
#> [1] "CORE"
#>
#> $species
#>           9606
#> "Homo sapiens"
#>
#> $acc
#> [1] "P49711"
#>
#> Background:
#>    A    C    G    T
#> 0.25 0.25 0.25 0.25
#> Matrix:
#>   [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12] [,13] [,14]
#> A   87  167  281   56    8  744   40  107  851     5   333    54    12    56
#> C  291  145   49  800  903   13  528  433   11     0     3    12     0     8
#> G   76  414  449   21    0   65  334   48   32   903   566   504   890   775
#> T  459  187  134   36    2   91   11  324   18     3     9   341     8    71
#>   [,15] [,16] [,17] [,18] [,19]
#> A   104   372    82   117   402
#> C   733    13   482   322   181
#> G     5   507   307    73   266
#> T    67    17    37   396    59
```

The user can utilise the PFMatrix object for further analysis and visualisation. Here is an example of how to plot a sequence logo of a given matrix using functions available in `TFBSTools` package.

```
seqLogo(toICM(pfm))
```

![](data:image/png;base64...)

```
## the user assigns multiple matrix IDs to the argument ID
pfmList <- getMatrixByID(JASPAR2022, ID=c("MA0139.1", "MA1102.1"))
## the function returns a PFMatrix object
pfmList
#> PFMatrixList of length 2
#> names(2): MA0139.1 MA1102.1

## PFMatrixList can be subsetted to extract enclosed PFMatrix objects
pfmList[[2]]
#> An object of class PFMatrix
#> ID: MA1102.1
#> Name: CTCFL
#> Matrix Class: C2H2 zinc finger factors
#> strand: +
#> Tags:
#> $family
#> [1] "More than 3 adjacent zinc fingers"
#>
#> $medline
#> [1] "26268681"
#>
#> $remap_tf_name
#> [1] "CTCFL"
#>
#> $source
#> [1] "29126285"
#>
#> $tax_group
#> [1] "vertebrates"
#>
#> $tfbs_shape_id
#> [1] "1"
#>
#> $type
#> [1] "ChIP-seq"
#>
#> $collection
#> [1] "CORE"
#>
#> $species
#>           9606
#> "Homo sapiens"
#>
#> $acc
#> [1] "Q8NI51"
#>
#> Background:
#>    A    C    G    T
#> 0.25 0.25 0.25 0.25
#> Matrix:
#>   [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12] [,13] [,14]
#> A  627 3344  909  499 8422   76  568  266  123   127   117  4022   714  1329
#> C 6915 1487 4650 6703  166   93  145  325  179   136  8625   730  3772  3392
#> G  860 2520 2898  535  152 8596 8035 7716 8447  8380    37  3702  3448  1810
#> T  423 1474  368 1088   85   60   77  518   76   182    46   371   891  2294
```

`getMatrixByName` retrieves matrices by name. If multiple matrix names are supplied, the function returns a PFMatrixList object.

```
pfm <- getMatrixByName(JASPAR2022, name="Arnt")
pfm
#> An object of class PFMatrix
#> ID: MA0004.1
#> Name: Arnt
#> Matrix Class: Basic helix-loop-helix factors (bHLH)
#> strand: +
#> Tags:
#> $alias
#> [1] "HIF-1beta,bHLHe2"
#>
#> $description
#> [1] "aryl hydrocarbon receptor nuclear translocator"
#>
#> $family
#> [1] "PAS domain factors"
#>
#> $medline
#> [1] "7592839"
#>
#> $remap_tf_name
#> [1] "ARNT"
#>
#> $symbol
#> [1] "ARNT"
#>
#> $tax_group
#> [1] "vertebrates"
#>
#> $tfbs_shape_id
#> [1] "11"
#>
#> $type
#> [1] "SELEX"
#>
#> $unibind
#> [1] "1"
#>
#> $collection
#> [1] "CORE"
#>
#> $species
#>          10090
#> "Mus musculus"
#>
#> $acc
#> [1] "P53762"
#>
#> Background:
#>    A    C    G    T
#> 0.25 0.25 0.25 0.25
#> Matrix:
#>   [,1] [,2] [,3] [,4] [,5] [,6]
#> A    4   19    0    0    0    0
#> C   16    0   20    0    0    0
#> G    0    1    0   20    0   20
#> T    0    0    0    0   20    0

pfmList <- getMatrixByName(JASPAR2022, name=c("Arnt", "Ahr::Arnt"))
pfmList
#> PFMatrixList of length 2
#> names(2): Arnt Ahr::Arnt
```

# 3 The use of filtering criteria

The `getMatrixSet` function fetches all matrices that match criteria defined by the named arguments, and it returns a `PFMatrixList` object.

```
## select all matrices found in a specific species and constructed from the
## SELEX experiment
opts <- list()
opts[["species"]] <- 9606
opts[["type"]] <- "SELEX"
opts[["all_versions"]] <- TRUE
PFMatrixList <- getMatrixSet(JASPAR2022, opts)
PFMatrixList
#> PFMatrixList of length 47
#> names(47): MA0002.1 MA0003.1 MA0018.1 MA0025.1 ... MA0124.1 MA0130.1 MA0131.1

## retrieve all matrices constructed from SELEX experiment
opts2 <- list()
opts2[["type"]] <- "SELEX"
PFMatrixList2 <- getMatrixSet(JASPAR2022, opts2)
PFMatrixList2
#> PFMatrixList of length 156
#> names(156): MA0004.1 MA0006.1 MA0015.1 MA0016.1 ... MA1925.1 MA1926.1 MA1927.1
```

Additional details about TFBS matrix analysis can be found in the [TFBSTools](https://bioconductor.org/packages/release/bioc/html/TFBSTools.html) documantation.

# 4 Session Info

Here is the output of `sessionInfo()` on the system on which this document was compiled:

```
#> R Under development (unstable) (2024-01-16 r85808)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 22.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.19-bioc/R/lib/libRblas.so
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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] TFBSTools_1.41.0     JASPAR2022_0.99.8    BiocFileCache_2.11.1
#> [4] dbplyr_2.4.0         BiocStyle_2.31.0
#>
#> loaded via a namespace (and not attached):
#>   [1] DBI_1.2.2                   bitops_1.0-7
#>   [3] formatR_1.14                rlang_1.1.3
#>   [5] magrittr_2.0.3              matrixStats_1.2.0
#>   [7] compiler_4.4.0              RSQLite_2.3.5
#>   [9] png_0.1-8                   vctrs_0.6.5
#>  [11] reshape2_1.4.4              stringr_1.5.1
#>  [13] pkgconfig_2.0.3             crayon_1.5.2
#>  [15] fastmap_1.1.1               magick_2.8.3
#>  [17] XVector_0.43.1              caTools_1.18.2
#>  [19] utf8_1.2.4                  Rsamtools_2.19.3
#>  [21] rmarkdown_2.25              tzdb_0.4.0
#>  [23] pracma_2.4.4                DirichletMultinomial_1.45.0
#>  [25] purrr_1.0.2                 bit_4.0.5
#>  [27] xfun_0.42                   zlibbioc_1.49.0
#>  [29] cachem_1.0.8                CNEr_1.39.0
#>  [31] GenomeInfoDb_1.39.6         jsonlite_1.8.8
#>  [33] blob_1.2.4                  highr_0.10
#>  [35] DelayedArray_0.29.7         BiocParallel_1.37.0
#>  [37] parallel_4.4.0              R6_2.5.1
#>  [39] bslib_0.6.1                 stringi_1.8.3
#>  [41] rtracklayer_1.63.0          GenomicRanges_1.55.3
#>  [43] jquerylib_0.1.4             Rcpp_1.0.12
#>  [45] bookdown_0.37               SummarizedExperiment_1.33.3
#>  [47] knitr_1.45                  R.utils_2.12.3
#>  [49] readr_2.1.5                 IRanges_2.37.1
#>  [51] Matrix_1.6-5                tidyselect_1.2.0
#>  [53] abind_1.4-5                 yaml_2.3.8
#>  [55] codetools_0.2-19            curl_5.2.0
#>  [57] lattice_0.22-5              tibble_3.2.1
#>  [59] plyr_1.8.9                  KEGGREST_1.43.0
#>  [61] Biobase_2.63.0              withr_3.0.0
#>  [63] evaluate_0.23               Biostrings_2.71.2
#>  [65] pillar_1.9.0                BiocManager_1.30.22
#>  [67] filelock_1.0.3              MatrixGenerics_1.15.0
#>  [69] stats4_4.4.0                generics_0.1.3
#>  [71] RCurl_1.98-1.14             S4Vectors_0.41.3
#>  [73] hms_1.1.3                   ggplot2_3.5.0
#>  [75] munsell_0.5.0               scales_1.3.0
#>  [77] gtools_3.9.5                xtable_1.8-4
#>  [79] glue_1.7.0                  seqLogo_1.69.0
#>  [81] tools_4.4.0                 TFMPvalue_0.0.9
#>  [83] BiocIO_1.13.0               BSgenome_1.71.2
#>  [85] annotate_1.81.2             GenomicAlignments_1.39.4
#>  [87] XML_3.99-0.16.1             poweRlaw_0.80.0
#>  [89] grid_4.4.0                  AnnotationDbi_1.65.2
#>  [91] colorspace_2.1-0            GenomeInfoDbData_1.2.11
#>  [93] restfulr_0.0.15             cli_3.6.2
#>  [95] fansi_1.0.6                 S4Arrays_1.3.4
#>  [97] dplyr_1.1.4                 gtable_0.3.4
#>  [99] R.methodsS3_1.8.2           sass_0.4.8
#> [101] digest_0.6.34               BiocGenerics_0.49.1
#> [103] SparseArray_1.3.4           rjson_0.2.21
#> [105] R.oo_1.26.0                 memoise_2.0.1
#> [107] htmltools_0.5.7             lifecycle_1.0.4
#> [109] httr_1.4.7                  GO.db_3.18.0
#> [111] bit64_4.0.5
```

# Bibliography

Castro-Mondragon, Jaime A, Rafael Riudavets-Puig, Ieva Rauluseviciute, Roza Berhanu Lemma, Laura Turchi, Romain Blanc-Mathieu, Jeremy Lucas, et al. 2021. “JASPAR 2022: the 9th release of the open-access database of transcription factor binding profiles.” *Nucleic Acids Research* 50 (D1): D165–D173. <https://doi.org/10.1093/nar/gkab1113>.

Tan, Ge, and Boris Lenhard. 2016. “TFBSTools: An R/Bioconductor Package for Transcription Factor Binding Site Analysis.” *Bioinformatics* 32: 1555–6.