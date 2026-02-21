# Other single-cell RNA-seq analysis utilities

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: May 3, 2020

#### Package

scuttle 1.20.0

# 1 Introduction

*[scuttle](https://bioconductor.org/packages/3.22/scuttle)* provides various low-level utilities for single-cell RNA-seq data analysis,
typically used at the start of the analysis workflows or within high-level functions in other packages.
This vignette will discuss the use of miscellaneous functions for scRNA-seq data processing.
To demonstrate, we will obtain the classic Zeisel dataset from the *[scRNAseq](https://bioconductor.org/packages/3.22/scRNAseq)* package,
and apply some quick quality control to remove damaged cells.

```
library(scRNAseq)
sce <- ZeiselBrainData()

library(scuttle)
sce <- quickPerCellQC(sce, subsets=list(Mito=grep("mt-", rownames(sce))),
    sub.fields=c("subsets_Mito_percent", "altexps_ERCC_percent"))

sce
```

```
## class: SingleCellExperiment
## dim: 20006 2816
## metadata(0):
## assays(1): counts
## rownames(20006): Tspan12 Tshz1 ... mt-Rnr1 mt-Nd4l
## rowData names(1): featureType
## colnames(2816): 1772071015_C02 1772071017_G12 ... 1772063068_D01
##   1772066098_A12
## colData names(26): tissue group # ... high_altexps_ERCC_percent discard
## reducedDimNames(0):
## mainExpName: gene
## altExpNames(2): repeat ERCC
```

**Note:** A more comprehensive description of the use of *[scuttle](https://bioconductor.org/packages/3.22/scuttle)* functions
(along with other packages) in a scRNA-seq analysis workflow is available at <https://osca.bioconductor.org>.

# 2 Aggregation across groups or clusters

The `aggregateAcrossCells()` function is helpful for aggregating expression values across groups of cells.
For example, we might wish to sum together counts for all cells in the same cluster,
possibly to use as a summary statistic for downstream analyses (e.g., for differential expression with *[edgeR](https://bioconductor.org/packages/3.22/edgeR)*).
This will also perform the courtesy of sensibly aggregating the column metadata for downstream use.

```
library(scuttle)
agg.sce <- aggregateAcrossCells(sce, ids=sce$level1class)
head(assay(agg.sce))
```

```
##          astrocytes_ependymal endothelial-mural interneurons microglia
## Tspan12                    71               120          186        13
## Tshz1                      89                58          335        41
## Fnbp1l                     73               102          689        29
## Adamts15                    2                14           64         0
## Cldn12                     45                23          160         4
## Rxfp1                       0                 3           74         0
##          oligodendrocytes pyramidal CA1 pyramidal SS
## Tspan12                93           269           58
## Tshz1                 293            65          331
## Fnbp1l                230           857         1054
## Adamts15               19            11           15
## Cldn12                206           410          273
## Rxfp1                  13            48           30
```

```
colData(agg.sce)[,c("ids", "ncells")]
```

```
## DataFrame with 7 rows and 2 columns
##                                       ids    ncells
##                               <character> <integer>
## astrocytes_ependymal astrocytes_ependymal       179
## endothelial-mural       endothelial-mural       160
## interneurons                 interneurons       290
## microglia                       microglia        78
## oligodendrocytes         oligodendrocytes       774
## pyramidal CA1               pyramidal CA1       938
## pyramidal SS                 pyramidal SS       397
```

It is similarly possible to sum across multiple factors, as shown below for the cell type and the tissue of origin.
This yields one column per combination of cell type and tissue,
which allows us to conveniently perform downstream analyses with both factors.

```
agg.sce <- aggregateAcrossCells(sce,
    ids=colData(sce)[,c("level1class", "tissue")])
head(assay(agg.sce))
```

```
##          [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12]
## Tspan12    22   49    9  111   52  134    0   13   10    83   269    58
## Tshz1      37   52    7   51   90  245    1   40   50   243    65   331
## Fnbp1l     22   51    6   96  227  462    3   26   18   212   857  1054
## Adamts15    0    2    2   12   15   49    0    0    0    19    11    15
## Cldn12      4   41    0   23   61   99    0    4   22   184   410   273
## Rxfp1       0    0    0    3    3   71    0    0    1    12    48    30
```

```
colData(agg.sce)[,c("level1class", "tissue", "ncells")]
```

```
## DataFrame with 12 rows and 3 columns
##              level1class         tissue    ncells
##              <character>    <character> <integer>
## 1   astrocytes_ependymal ca1hippocampus        71
## 2   astrocytes_ependymal       sscortex       108
## 3      endothelial-mural ca1hippocampus        25
## 4      endothelial-mural       sscortex       135
## 5           interneurons ca1hippocampus       126
## ...                  ...            ...       ...
## 8              microglia       sscortex        64
## 9       oligodendrocytes ca1hippocampus       120
## 10      oligodendrocytes       sscortex       654
## 11         pyramidal CA1 ca1hippocampus       938
## 12          pyramidal SS       sscortex       397
```

Summation across rows may occasionally be useful for obtaining a measure of the activity of a gene set, e.g., in a pathway.
Given a list of gene sets, we can use the `sumCountsAcrossFeatures()` function to aggregate expression values across features.
This is usually best done by averaging the log-expression values as shown below.

```
sce <- logNormCounts(sce)
agg.feat <- sumCountsAcrossFeatures(sce,
    ids=list(GeneSet1=1:10, GeneSet2=11:50, GeneSet3=1:100),
    average=TRUE, exprs_values="logcounts")
agg.feat[,1:10]
```

```
##          1772071015_C02 1772071017_G12 1772071017_A05 1772071014_B06
## GeneSet1      0.7888973      0.2245293      0.7733931      0.5526122
## GeneSet2      1.0788281      1.0130457      1.2797820      1.1705150
## GeneSet3      1.1622245      1.0207948      1.2963940      1.2230518
##          1772067065_H06 1772071017_E02 1772067065_B07 1772067060_B09
## GeneSet1      0.5092772      0.3630931      0.5399704     0.07722382
## GeneSet2      1.2223993      1.3115876      1.3146717     1.20420279
## GeneSet3      1.1451365      1.1792717      1.1287984     1.15725115
##          1772071014_E04 1772071015_D04
## GeneSet1      0.7433737      0.8076824
## GeneSet2      1.1949143      1.3117134
## GeneSet3      1.0300578      1.2069146
```

Similar functions are available to compute the number or proportion of cells with detectable expression in each group.
To wit:

```
agg.n <- summarizeAssayByGroup(sce, statistics="prop.detected",
    ids=colData(sce)[,c("level1class", "tissue")])
head(assay(agg.n))
```

```
##                [,1]       [,2] [,3]       [,4]       [,5]      [,6]       [,7]
## Tspan12  0.21126761 0.17592593 0.20 0.34074074 0.28571429 0.3597561 0.00000000
## Tshz1    0.22535211 0.16666667 0.20 0.17777778 0.36507937 0.4756098 0.07142857
## Fnbp1l   0.16901408 0.18518519 0.16 0.30370370 0.63492063 0.7500000 0.14285714
## Adamts15 0.00000000 0.01851852 0.08 0.04444444 0.04761905 0.1768293 0.00000000
## Cldn12   0.04225352 0.14814815 0.00 0.06666667 0.29365079 0.3658537 0.00000000
## Rxfp1    0.00000000 0.00000000 0.00 0.01481481 0.01587302 0.2134146 0.00000000
##              [,8]        [,9]      [,10]       [,11]      [,12]
## Tspan12  0.109375 0.058333333 0.07492355 0.188699360 0.09068010
## Tshz1    0.171875 0.216666667 0.20336391 0.051172708 0.33753149
## Fnbp1l   0.234375 0.075000000 0.15596330 0.459488273 0.72040302
## Adamts15 0.000000 0.000000000 0.01529052 0.009594883 0.02267003
## Cldn12   0.046875 0.141666667 0.15137615 0.287846482 0.35516373
## Rxfp1    0.000000 0.008333333 0.01223242 0.039445629 0.04785894
```

# 3 Reading in sparse matrices

Normally, sparse matrices are provided in the MatrixMarket (`.mtx`) format,
where they can be read efficiently into memory using the `readMM()` function from the *[Matrix](https://CRAN.R-project.org/package%3DMatrix)* package.
However, for some reason, it has been popular to save these files in dense form as tab- or comma-separate files.
This is an inefficient and inconvenient approach, requiring users to read in the entire dataset in dense form with functions like `read.delim()` or `read.csv()` (and hope that they have enough memory on their machines to do so).

In such cases, *[scuttle](https://bioconductor.org/packages/3.22/scuttle)* provides the `readSparseCounts()` function to overcome excessive memory requirements.
This reads in the dataset in a chunkwise manner, progressively coercing each chunk into a sparse format and combining them into a single sparse matrix to be returned to the user.
In this manner, we never attempt to load the entire dataset in dense format to memory.

```
# Mocking up a dataset to demonstrate:
outfile <- tempfile()
write.table(as.matrix(counts(sce)[1:100,]),
    file=outfile, sep="\t", quote=FALSE)

# Reading it in as a sparse matrix:
output <- readSparseCounts(outfile)
class(output)
```

```
## [1] "dgCMatrix"
## attr(,"package")
## [1] "Matrix"
```

# 4 Making gene symbols unique

When publishing a dataset, the best practice is to provide gene annotations in the form of a stable identifier like those from Ensembl or Entrez.
This provides an unambiguous reference to the identity of the gene, avoiding difficulties with synonynms and making it easier to cross-reference.
However, when working with a dataset, it is more convenient to use the gene symbols as these are easier to remember.

Thus, a common procedure is to replace the stable identifiers in the row names with gene symbols.
However, this is not straightforward as the gene symbols may not exist (`NA`s) or may be duplicated.
To assist this process, *[scuttle](https://bioconductor.org/packages/3.22/scuttle)* provides the `uniquifyFeatureNames()` function that emit gene symbols if they are unique; append the identifier, if they are duplicated; and replace the symbol with the identifier if the former is missing.

```
# Original row names are Ensembl IDs.
sce.ens <- ZeiselBrainData(ensembl=TRUE)
head(rownames(sce.ens))
```

```
## [1] "ENSMUSG00000029669" "ENSMUSG00000046982" "ENSMUSG00000039735"
## [4] "ENSMUSG00000033453" "ENSMUSG00000046798" "ENSMUSG00000034009"
```

```
# Replacing with guaranteed unique and non-missing symbols:
rownames(sce.ens) <- uniquifyFeatureNames(
    rownames(sce.ens), rowData(sce.ens)$originalName
)
head(rownames(sce.ens))
```

```
## [1] "Tspan12"  "Tshz1"    "Fnbp1l"   "Adamts15" "Cldn12"   "Rxfp1"
```

# 5 Creating a `data.frame`

The `makePerCellDF()` and `makePerFeatureDF()` functions create `data.frame`s from the `SingleCellExperiment` object.
In the `makePerCellDF()` case, each row of the output `data.frame` corresponds to a cell and each column represents the expression of a specified feature across cells, a field of the column metadata, or reduced dimensions (if any are available).

```
out <- makePerCellDF(sce, features="Tspan12")
colnames(out)
```

```
##  [1] "tissue"                    "group.."
##  [3] "total.mRNA.mol"            "well"
##  [5] "sex"                       "age"
##  [7] "diameter"                  "level1class"
##  [9] "level2class"               "sum"
## [11] "detected"                  "subsets_Mito_sum"
## [13] "subsets_Mito_detected"     "subsets_Mito_percent"
## [15] "altexps_repeat_sum"        "altexps_repeat_detected"
## [17] "altexps_repeat_percent"    "altexps_ERCC_sum"
## [19] "altexps_ERCC_detected"     "altexps_ERCC_percent"
## [21] "total"                     "low_lib_size"
## [23] "low_n_features"            "high_subsets_Mito_percent"
## [25] "high_altexps_ERCC_percent" "discard"
## [27] "sizeFactor"                "Tspan12"
```

In the `makePerFeatureDF()` case, each row of the output `data.frame` corresponds to a gene and each column represents the expression profile of a specified cell or the values of a row metadata field.

```
out2 <- makePerFeatureDF(sce, cells=c("1772063062_D05",
    "1772063061_D01", "1772060240_F02", "1772062114_F05"))
colnames(out2)
```

```
## [1] "1772063062_D05" "1772063061_D01" "1772060240_F02" "1772062114_F05"
## [5] "featureType"
```

The aim is to enable the data in a `SingleCellExperiment` to be easily used in functions like `model.matrix()` or in `ggplot()`,
without requiring users to manually extract the desired fields from the `SingleCellExperiment` to construct their own `data.frame`.

# Session information

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
##  [1] ensembldb_2.34.0            AnnotationFilter_1.34.0
##  [3] GenomicFeatures_1.62.0      AnnotationDbi_1.72.0
##  [5] scuttle_1.20.0              scRNAseq_2.24.0
##  [7] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0              GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0               IRanges_2.44.0
## [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [15] generics_0.1.4              MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                bitops_1.0-9             httr2_1.2.1
##  [4] rlang_1.1.6              magrittr_2.0.4           gypsum_1.6.0
##  [7] compiler_4.5.1           RSQLite_2.4.3            png_0.1-8
## [10] vctrs_0.6.5              ProtGenerics_1.42.0      pkgconfig_2.0.3
## [13] crayon_1.5.3             fastmap_1.2.0            dbplyr_2.5.1
## [16] XVector_0.50.0           Rsamtools_2.26.0         rmarkdown_2.30
## [19] UCSC.utils_1.6.0         purrr_1.1.0              bit_4.6.0
## [22] xfun_0.54                cachem_1.1.0             beachmat_2.26.0
## [25] cigarillo_1.0.0          GenomeInfoDb_1.46.0      jsonlite_2.0.0
## [28] blob_1.2.4               rhdf5filters_1.22.0      DelayedArray_0.36.0
## [31] Rhdf5lib_1.32.0          BiocParallel_1.44.0      parallel_4.5.1
## [34] R6_2.6.1                 bslib_0.9.0              rtracklayer_1.70.0
## [37] jquerylib_0.1.4          Rcpp_1.1.0               bookdown_0.45
## [40] knitr_1.50               Matrix_1.7-4             tidyselect_1.2.1
## [43] abind_1.4-8              yaml_2.3.10              codetools_0.2-20
## [46] curl_7.0.0               lattice_0.22-7           alabaster.sce_1.10.0
## [49] tibble_3.3.0             withr_3.0.2              KEGGREST_1.50.0
## [52] evaluate_1.0.5           BiocFileCache_3.0.0      alabaster.schemas_1.10.0
## [55] ExperimentHub_3.0.0      Biostrings_2.78.0        pillar_1.11.1
## [58] BiocManager_1.30.26      filelock_1.0.3           RCurl_1.98-1.17
## [61] BiocVersion_3.22.0       alabaster.base_1.10.0    glue_1.8.0
## [64] alabaster.ranges_1.10.0  alabaster.matrix_1.10.0  lazyeval_0.2.2
## [67] tools_4.5.1              AnnotationHub_4.0.0      BiocIO_1.20.0
## [70] GenomicAlignments_1.46.0 XML_3.99-0.19            rhdf5_2.54.0
## [73] grid_4.5.1               HDF5Array_1.38.0         restfulr_0.0.16
## [76] cli_3.6.5                rappdirs_0.3.3           S4Arrays_1.10.0
## [79] dplyr_1.1.4              alabaster.se_1.10.0      sass_0.4.10
## [82] digest_0.6.37            SparseArray_1.10.0       rjson_0.2.23
## [85] memoise_2.0.1            htmltools_0.5.8.1        lifecycle_1.0.4
## [88] h5mread_1.2.0            httr_1.4.7               bit64_4.6.0-1
```