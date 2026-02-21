[Skip to contents](#main)

[Cellosaurus](../index.html)
0.8.2

* [Get started](../articles/Cellosaurus.html)
* [Reference](../reference/index.html)
* [Changelog](../news/index.html)

![]()

# Cellosaurus

#### Michael Steinbaugh

#### 2024-03-11

Source: [`vignettes/Cellosaurus.Rmd`](https://github.com/acidgenomics/r-cellosaurus/blob/HEAD/vignettes/Cellosaurus.Rmd)

`Cellosaurus.Rmd`

```
## nolint start
suppressPackageStartupMessages({
    library(DT)
    library(Cellosaurus)
})
## nolint end
```

## Introduction

The package is designed to import [Cellosaurus](https://www.cellosaurus.org/) annotations and
serve as a cell line identifier mapping toolkit. The main
`[Cellosaurus()](../reference/Cellosaurus.html)` generator function returns a
`Cellosaurus` object, which extends the S4
`DFrame` class from [Bioconductor](https://bioconductor.org/). Additional functions
are defined to work with the `Cellosaurus` object, notably
`[mapCells()](../reference/mapCells.html)`, which provides mapping support to Cellosaurus
identifiers directly from cell line names, [DepMap](https://depmap.org/) identifiers, and [ATCC](https://www.atcc.org/ "American Type Culture Collection") identifiers.

## Cellosaurus table

The primary generator functions imports annotations from the
`cellosaurus.txt` file on the [FTP server](https://ftp.expasy.org/databases/cellosaurus/).

```
object <- Cellosaurus()
print(object)
```

```
## Cellosaurus 0.8.2 with 152231 rows and 36 columns
## cells(152231): CVCL_0001 CVCL_0002 ... CVCL_ZZ98 CVCL_ZZ99
## date: 2024-03-11
## release: 48
```

The object is structured as cells in rows, metadata in columns.

```
print(colnames(object))
```

```
##  [1] "accession"                   "ageAtSampling"
##  [3] "atccId"                      "category"
##  [5] "cellLineName"                "comments"
##  [7] "crossReferences"             "date"
##  [9] "depmapId"                    "diseases"
## [11] "hierarchy"                   "isCancer"
## [13] "isContaminated"              "isProblematic"
## [15] "misspellings"                "msiStatus"
## [17] "ncbiTaxonomyId"              "ncitDiseaseId"
## [19] "ncitDiseaseName"             "oncotreeCode"
## [21] "oncotreeLevel"               "oncotreeMainType"
## [23] "oncotreeName"                "oncotreeParent"
## [25] "oncotreeTissue"              "organism"
## [27] "originateFromSameIndividual" "population"
## [29] "referencesIdentifiers"       "samplingSite"
## [31] "sangerModelId"               "secondaryAccession"
## [33] "sexOfCell"                   "strProfileData"
## [35] "synonyms"                    "webPages"
```

Data is encoded using run-length encoding (`Rle` from [S4Vectors](https://bioconductor.org/packages/S4Vectors/)) to
lower memory overhead.

This approach provides simple spreadsheet-like access to Cellosaurus
annotations, which are more intuitive to users than nested JSON-style
lists.

```
i <- seq(from = 1L, to = 10L)
j <- which(vapply(
    X = as.data.frame(object),
    FUN = is.atomic,
    FUN.VALUE = logical(1L)
))
datatable(
    data = as.data.frame(object)[i, j],
    options = list(scrollX = TRUE)
)
```

## Mapping cell lines

It remains a common problem in cancer research that cell line
inventories are only maintained by cell line name, without any
systematic standardization against a reference database, such as
Cellosaurus, ATCC, or DepMap. The advantage of standardizing upon
Cellosaurus identifiers as the primary [research resource identifier](https://www.rrids.org/ "Research Resource Identifier") is
that the Cellosaurus database is a superset of cells that include all
cells in ATCC and DepMap. The Cellosaurus database also provides nicely
curated metadata on problematic cell lines, notably contamination, and
common misspellings of cell line names that persist across a number of
commercial vendor databases.

The `[mapCells()](../reference/mapCells.html)` function in the package aims to simplify
mapping of cell line names and identifiers from other databases, notably
DepMap and ATCC, to Cellosaurus identifiers. The function is designed to
be as simple as possible and support mixed input in a single call.

```
cells <- c("ACH-000551", "CCL-240", "Duadi", "THP1", "RAW 264.7")
i <- mapCells(object, cells = cells)
print(i)
```

```
##  ACH-000551     CCL-240       Duadi        THP1   RAW 264.7
## "CVCL_0004" "CVCL_0002" "CVCL_0008" "CVCL_0006" "CVCL_0493"
```

```
datatable(
    data = as.data.frame(object)[i, j],
    options = list(scrollX = TRUE)
)
```

## Excluding problematic cell lines

The Cellosaurus database nicely keeps track of known issues with cell
lines, which can be broken down roughly into two classes: “problematic”
and “contaminated”. It can be useful for downstream analysis to exclude
these cell lines – in particular, we recommend generally excluding any
contaminated cell lines but not necessarily all problematic cell
lines.

```
subset <- excludeProblematicCells(object)
print(nrow(subset))
```

```
## [1] 150923
```

```
print(any(subset[["isProblematic"]]))
```

```
## [1] FALSE
```

```
print(any(subset[["isContaminated"]]))
```

```
## [1] FALSE
```

Note that “contaminated” cell lines are a subset of “problematic”
cell lines in the database. These in general should be avoided in
downstream workflows.

```
subset <- excludeContaminatedCells(object)
print(nrow(subset))
```

```
## [1] 151465
```

```
print(any(subset[["isContaminated"]]))
```

```
## [1] FALSE
```

```
print(any(subset[["isProblematic"]]))
```

```
## [1] TRUE
```

For reference, search the website for “problematic” cell lines with
`"Problematic cell line"` and “contaminated” cell lines with
`"Problematic cell line: Contaminated"`.

## R session information

```
utils::sessionInfo()
```

```
## R version 4.3.3 (2024-02-29)
## Platform: x86_64-apple-darwin20 (64-bit)
## Running under: macOS Sonoma 14.4
##
## Matrix products: default
## BLAS:   /Library/Frameworks/R.framework/Versions/4.3-x86_64/Resources/lib/libRblas.0.dylib
## LAPACK: /Library/Frameworks/R.framework/Versions/4.3-x86_64/Resources/lib/libRlapack.dylib;  LAPACK version 3.11.0
##
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
##
## time zone: America/New_York
## tzcode source: internal
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] Cellosaurus_0.8.2 DT_0.32
##
## loaded via a namespace (and not attached):
##  [1] xfun_0.42               bslib_0.6.1             htmlwidgets_1.6.4
##  [4] lattice_0.22-5          crosstalk_1.2.1         vctrs_0.6.5
##  [7] tools_4.3.3             bitops_1.0-7            generics_0.1.3
## [10] curl_5.2.1              stats4_4.3.3            parallel_4.3.3
## [13] tibble_3.2.1            fansi_1.0.6             RSQLite_2.3.5
## [16] blob_1.2.4              pkgconfig_2.0.3         syntactic_0.7.1
## [19] Matrix_1.6-5            AcidCLI_0.3.0           dbplyr_2.4.0
## [22] desc_1.4.3              S4Vectors_0.40.2        lifecycle_1.0.4
## [25] GenomeInfoDbData_1.2.11 compiler_4.3.3          textshaping_0.3.7
## [28] GenomeInfoDb_1.38.7     htmltools_0.5.7         sass_0.4.8
## [31] RCurl_1.98-1.14         yaml_2.3.8              pipette_0.15.2
## [34] pkgdown_2.0.7           pillar_1.9.0            crayon_1.5.2
## [37] jquerylib_0.1.4         ellipsis_0.3.2          cachem_1.0.8
## [40] AcidGenerics_0.7.7.9000 AcidBase_0.7.3          goalie_0.7.7
## [43] tidyselect_1.2.0        digest_0.6.34           stringi_1.8.3
## [46] dplyr_1.1.4             purrr_1.0.2             fastmap_1.1.1
## [49] grid_4.3.3              cli_3.6.2               magrittr_2.0.3
## [52] utf8_1.2.4              withr_3.0.0             filelock_1.0.3
## [55] bit64_4.0.5             httr_1.4.7              rmarkdown_2.26
## [58] XVector_0.42.0          bit_4.0.5               ragg_1.2.7
## [61] memoise_2.0.1           evaluate_0.23           knitr_1.45
## [64] GenomicRanges_1.54.1    IRanges_2.36.0          BiocFileCache_2.10.1
## [67] rlang_1.1.3             glue_1.7.0              DBI_1.2.2
## [70] AcidPlyr_0.5.4.9000     BiocGenerics_0.48.1     jsonlite_1.8.8
## [73] R6_2.5.1                systemfonts_1.0.6       fs_1.6.3
## [76] zlibbioc_1.48.0
```

## On this page

Developed by [Michael Steinbaugh](https://mike.steinbaugh.com/), [Acid Genomics](https://acidgenomics.com/).

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.0.7.