# JASPAR2020

Damir Baranasic

Imperial College London, Faculty of Medicine, Institute of Clinical Sciences, Hammersmith Campus, Du Cane Road, W12 0NN, London

#### 4 June 2020

# Contents

* [1 Introduction](#introduction)
* [2 Retrieving matrices from JASPAR2020 by ID or name](#retrieving-matrices-from-jaspar2020-by-id-or-name)
* [3 The use of filtering criteria](#the-use-of-filtering-criteria)
* [4 Session Info](#session-info)
* [Bibliography](#bibliography)

# 1 Introduction

JASPAR (<http://jaspar.genereg.net>) is an open-access database of curated, non-redundant
transcription factor (TF)-binding profiles stored as position frequency matrices (PFMs) for TFs
across multiple species in six taxonomic groups. In this 8th release of JASPAR, the CORE
collection has been expanded with 245 new PFMs (169 for vertebrates, 42 for plants, 17 for
nematodes, 10 for insects, and 7 for fungi), and 157 PFMs were updated (125 for vertebrates,
28 for plants, and 3 for insects). These new profiles represent an 18% expansion compared to
the previous release. JASPAR 2020 comes with a novel collection of unvalidated TF-binding
profiles for which our curators did not find orthogonal supporting evidence in the literature. This
collection has a dedicated web form to engage the community in the curation of unvalidated TF-binding
profiles.

The easiest way to use the JASPAR2020 data package (Fornes et al. 2019) is by `TFBSTools` package interface (Tan and Lenhard 2016), which provides functions to retrieve and manipulate data from the JASPAR database. This vignette demonstrates how to use those functions.

```
library(JASPAR2020)
library(TFBSTools)
```

# 2 Retrieving matrices from JASPAR2020 by ID or name

Matrices from JASPAR can be retrieved using either `getMatrixByID` or `getMatrixByName` function by providing a matrix ID or a matrix name from JASPAR, respectively. These functions accept either a single element as the ID/name parameter or a vector of values. The former case returns a `PFMatrix` object, while the later one returns a `PFMatrixList` with multiple `PFMatrix` objects.

```
## the user assigns a single matrix ID to the argument ID
pfm <- getMatrixByID(JASPAR2020, ID = "MA0139.1")
## the function returns a PFMatrix object
pfm
#> An object of class PFMatrix
#> ID: MA0139.1
#> Name: CTCF
#> Matrix Class: C2H2 zinc finger factors
#> strand: +
#> Tags:
#> $alias
#> [1] "-"
#>
#> $description
#> [1] "CCCTC-binding factor (zinc finger protein)"
#>
#> $family
#> [1] "More than 3 adjacent zinc finger factors"
#>
#> $medline
#> [1] "17512414"
#>
#> $remap_tf_name
#> [1] "CTCF"
#>
#> $symbol
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
#> $unibind
#> [1] "1"
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
pfmList <- getMatrixByID(JASPAR2020, ID=c("MA0139.1", "MA1102.1"))
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
#> $centrality_logp
#> [1] "-7211.51"
#>
#> $family
#> [1] "More than 3 adjacent zinc finger factors"
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
#> $unibind
#> [1] "1"
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
pfm <- getMatrixByName(JASPAR2020, name="Arnt")
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

pfmList <- getMatrixByName(JASPAR2020, name=c("Arnt", "Ahr::Arnt"))
pfmList
#> PFMatrixList of length 2
#> names(2): Arnt Ahr::Arnt
```

# 3 The use of filtering criteria

The `getMatrixSet` function fetches all matrices that match criteria defined by the named arguments, and it returns a `PFMatrixList` object.

```
## select all matrices found in a specific species and constructed from the SELEX
## experiment
opts <- list()
opts[["species"]] <- 9606
opts[["type"]] <- "SELEX"
opts[["all_versions"]] <- TRUE
PFMatrixList <- getMatrixSet(JASPAR2020, opts)
PFMatrixList
#> PFMatrixList of length 48
#> names(48): MA0002.1 MA0003.1 MA0018.1 MA0025.1 ... MA0124.1 MA0130.1 MA0131.1

## retrieve all matrices constructed from SELEX experiment
opts2 <- list()
opts2[["type"]] <- "SELEX"
PFMatrixList2 <- getMatrixSet(JASPAR2020, opts2)
PFMatrixList2
#> PFMatrixList of length 82
#> names(82): MA0004.1 MA0006.1 MA0015.1 MA0016.1 ... MA0588.1 MA0589.1 MA0590.1
```

Additional details about TFBS matrix analysis can be found in the [TFBSTools](https://bioconductor.org/packages/release/bioc/html/TFBSTools.html) documantation.

# 4 Session Info

Here is the output of `sessionInfo()` on the system on which this document was compiled:

```
#> R version 4.0.0 alpha (2020-04-07 r78171)
#> Platform: x86_64-apple-darwin17.7.0 (64-bit)
#> Running under: macOS High Sierra 10.13.6
#>
#> Matrix products: default
#> BLAS:   /Users/ka36530_ca/R-stuff/bin/R-4-0/lib/libRblas.dylib
#> LAPACK: /Users/ka36530_ca/R-stuff/bin/R-4-0/lib/libRlapack.dylib
#>
#> locale:
#> [1] C/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] TFBSTools_1.27.0   JASPAR2020_0.99.10 BiocStyle_2.17.0
#>
#> loaded via a namespace (and not attached):
#>  [1] httr_1.4.1                  Biobase_2.49.0
#>  [3] bit64_0.9-7                 R.utils_2.9.2
#>  [5] gtools_3.8.2                BiocManager_1.30.10
#>  [7] stats4_4.0.0                blob_1.2.1
#>  [9] BSgenome_1.57.0             GenomeInfoDbData_1.2.3
#> [11] Rsamtools_2.5.1             yaml_2.2.1
#> [13] DirichletMultinomial_1.31.0 pillar_1.4.4
#> [15] RSQLite_2.2.0               lattice_0.20-41
#> [17] glue_1.4.1                  digest_0.6.25
#> [19] GenomicRanges_1.41.1        XVector_0.29.1
#> [21] colorspace_1.4-1            R.oo_1.23.0
#> [23] htmltools_0.4.0             Matrix_1.2-18
#> [25] plyr_1.8.6                  XML_3.99-0.3
#> [27] pkgconfig_2.0.3             bookdown_0.19
#> [29] zlibbioc_1.35.0             GO.db_3.11.4
#> [31] xtable_1.8-4                purrr_0.3.4
#> [33] scales_1.1.1                pracma_2.2.9
#> [35] BiocParallel_1.23.0         annotate_1.67.0
#> [37] tibble_3.0.1                KEGGREST_1.29.0
#> [39] generics_0.0.2              IRanges_2.23.6
#> [41] ggplot2_3.3.1               ellipsis_0.3.1
#> [43] SummarizedExperiment_1.19.4 TFMPvalue_0.0.8
#> [45] BiocGenerics_0.35.2         magrittr_1.5
#> [47] crayon_1.3.4                poweRlaw_0.70.6
#> [49] memoise_1.1.0               evaluate_0.14
#> [51] R.methodsS3_1.8.0           CNEr_1.25.0
#> [53] tools_4.0.0                 hms_0.5.3
#> [55] formatR_1.7                 lifecycle_0.2.0
#> [57] matrixStats_0.56.0          stringr_1.4.0
#> [59] S4Vectors_0.27.9            munsell_0.5.0
#> [61] DelayedArray_0.15.1         AnnotationDbi_1.51.0
#> [63] Biostrings_2.57.1           compiler_4.0.0
#> [65] GenomeInfoDb_1.25.0         caTools_1.18.0
#> [67] rlang_0.4.6                 grid_4.0.0
#> [69] RCurl_1.98-1.2              bitops_1.0-6
#> [71] rmarkdown_2.2               gtable_0.3.0
#> [73] DBI_1.1.0                   reshape2_1.4.4
#> [75] R6_2.4.1                    GenomicAlignments_1.25.1
#> [77] knitr_1.28                  dplyr_1.0.0
#> [79] seqLogo_1.55.4              rtracklayer_1.49.2
#> [81] bit_1.1-15.2                readr_1.3.1
#> [83] stringi_1.4.6               parallel_4.0.0
#> [85] Rcpp_1.0.4.6                png_0.1-7
#> [87] vctrs_0.3.0                 tidyselect_1.1.0
#> [89] xfun_0.14
```

# Bibliography

Fornes, Oriol, Jaime A. Castro-Mondragon, Aziz Khan, Robin van der Lee, Xi Zhang, Richmond Phillip, Bhavi P. Modi, et al. 2019. “JASPAR 2020: update of the open-access database of transcription factor binding profiles.” *Nucleic Acid Research*. <https://doi.org/10.1093/nar/gkz1001>.

Tan, Ge, and Boris Lenhard. 2016. “FBSTools: An R/Bioconductor Package for Transcription Factor Binding Site Analysis.” *Bioinformatics* 32: 1555–6.