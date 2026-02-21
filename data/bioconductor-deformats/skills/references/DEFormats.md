# Differential gene expression data formats converter

Andrzej Oleś

#### 29 October 2025

#### Abstract

*DEFormats* facilitates data conversion between the most widely used tools for differential gene expression analysis; currently, the Bioconductor packages *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* and *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* are supported. It provides converter functions of the form `as.<class>(object)`, where `<class>` is the name of the class to which `object` should be coerced. Additionally, *DEFormats* extends the original packages by offering constructors for common count data input formats, e.g. *SummarizedExperiment* objects.

#### Package

DEFormats 1.38.0

# Contents

* [1 Convert between *DESeqDataSet* and *DGEList* objects](#convert-between-deseqdataset-and-dgelist-objects)
  + [1.1 *DGEList* to *DESeqDataSet*](#dgelist-to-deseqdataset)
  + [1.2 *DESeqDataSet* to *DGEList*](#deseqdataset-to-dgelist)
* [2 Create *DGEList* objects from *SummarizedExperiment*](#create-dgelist-objects-from-summarizedexperiment)
* [3 FAQ](#faq)
  + [3.1 Coerce *DGEList* to *RangedSummarizedExperiment*](#coerce-dgelist-to-rangedsummarizedexperiment)
* [4 Session info](#session-info)

# 1 Convert between *DESeqDataSet* and *DGEList* objects

The following examples demonstrate how to shuttle data between *DESeqDataSet*
and *DGEList* containers. Before we start, let’s first load the required
packages.

```
library(DESeq2)
library(edgeR)
library(DEFormats)
```

## 1.1 *DGEList* to *DESeqDataSet*

We will illustrate the functionality of the package on a mock expression
data set of an RNA-seq experiment. The sample counts table can be generated
using the function provided by *DEFormats*:

```
counts = simulateRnaSeqData()
```

The resulting object is a matrix with rows corresponding to genomic features
and columns to samples.

```
head(counts)
```

```
##       sample1 sample2 sample3 sample4 sample5 sample6
## gene1      85      76     103     107     140     124
## gene2       1       6      11       6       1       4
## gene3      80      98      39      82      97     113
## gene4      92      83      59      85     100      98
## gene5      36      24      18      50      22      15
## gene6       0       0       1       4       2       3
```

In order to construct a *DGEList* object we need to provide, apart from the
counts matrix, the sample grouping.

```
group = rep(c("A", "B"), each = 3)

dge = DGEList(counts, group = group)
dge
```

```
## An object of class "DGEList"
## $counts
##       sample1 sample2 sample3 sample4 sample5 sample6
## gene1      85      76     103     107     140     124
## gene2       1       6      11       6       1       4
## gene3      80      98      39      82      97     113
## gene4      92      83      59      85     100      98
## gene5      36      24      18      50      22      15
## 995 more rows ...
##
## $samples
##         group lib.size norm.factors
## sample1     A    42832            1
## sample2     A    40511            1
## sample3     A    39299            1
## sample4     B    43451            1
## sample5     B    40613            1
## sample6     B    43662            1
```

A *DGEList* object can be easily converted to a *DESeqDataSet* object with the
help of the function `as.DESeqDataSet`.

```
dds = as.DESeqDataSet(dge)
dds
```

```
## class: DESeqDataSet
## dim: 1000 6
## metadata(1): version
## assays(1): counts
## rownames(1000): gene1 gene2 ... gene999 gene1000
## rowData names(0):
## colnames(6): sample1 sample2 ... sample5 sample6
## colData names(3): group lib.size norm.factors
```

Just to make sure that the coercions conserve the data and metadata, we now
convert `dds` back to a *DGEList* and compare the result to the original `dge`
object.

```
identical(dge, as.DGEList(dds))
```

```
## [1] TRUE
```

Note that because of the use of reference classes in the *SummarizedExperiment*
class which *DESeqDataSet* extends, `identical` will return `FALSE` for any two
*DESeqDataSet* instances, even for ones constructed from the same input:

```
dds1 = DESeqDataSetFromMatrix(counts, data.frame(condition=group), ~ condition)
```

```
## Warning in DESeqDataSet(se, design = design, ignoreRank): some variables in
## design formula are characters, converting to factors
```

```
dds2 = DESeqDataSetFromMatrix(counts, data.frame(condition=group), ~ condition)
```

```
## Warning in DESeqDataSet(se, design = design, ignoreRank): some variables in
## design formula are characters, converting to factors
```

```
identical(dds1, dds2)
```

```
## [1] TRUE
```

## 1.2 *DESeqDataSet* to *DGEList*

Instead of a count matrix, `simulateRnaSeqData` can also return an
annotated *RangedSummarizedExperiment* object. The advantage of such an object
is that, apart from the counts matrix stored in the `assay` slot, it also
contains sample description in `colData`, and gene information stored in
`rowRanges` as a `GRanges` object.

```
se = simulateRnaSeqData(output = "RangedSummarizedExperiment")
se
```

```
## class: RangedSummarizedExperiment
## dim: 1000 6
## metadata(1): version
## assays(1): counts
## rownames(1000): gene1 gene2 ... gene999 gene1000
## rowData names(3): trueIntercept trueBeta trueDisp
## colnames(6): sample1 sample2 ... sample5 sample6
## colData names(1): condition
```

The `se` object can be readily used to construct a *DESeqDataSet* object,

```
dds = DESeqDataSet(se, design = ~ condition)
```

which can be converted to a *DGEList* using the familiar method.

```
dge = as.DGEList(dds)
dge
```

```
## An object of class "DGEList"
## $counts
##       sample1 sample2 sample3 sample4 sample5 sample6
## gene1      85      76     103     107     140     124
## gene2       1       6      11       6       1       4
## gene3      80      98      39      82      97     113
## gene4      92      83      59      85     100      98
## gene5      36      24      18      50      22      15
## 995 more rows ...
##
## $samples
##         group lib.size norm.factors
## sample1     A    42832            1
## sample2     A    40511            1
## sample3     A    39299            1
## sample4     B    43451            1
## sample5     B    40613            1
## sample6     B    43662            1
##
## $genes
##       seqnames start end width strand trueIntercept trueBeta  trueDisp
## gene1        1     1 100   100      *      6.525909        0 0.1434076
## gene2        1   101 200   100      *      3.347533        0 0.4929634
## gene3        1   201 300   100      *      6.659599        0 0.1395659
## gene4        1   301 400   100      *      6.544859        0 0.1428412
## gene5        1   401 500   100      *      4.829283        0 0.2407022
## 995 more rows ...
```

Note the additional `genes` element on the `dge` list compared to the object
from the [previous section](#DGEList-to-DESeqDataSet).

# 2 Create *DGEList* objects from *SummarizedExperiment*

Similarly as for the `DESeqDataSet` constructor from *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*,
it is possible to directly use *RangedSummarizedExperiment* objects as input to
the generic `DGEList` constructor defined in *DEFormats*. This
allows you to use common input objects regardless of whether you are applying
*DESeq2* or *edgeR* to perform your analysis, or to
easily switch between these two tools in your pipeline.

```
names(colData(se)) = "group"
dge = DGEList(se)
dge
```

```
## An object of class "DGEList"
## $counts
##       sample1 sample2 sample3 sample4 sample5 sample6
## gene1      85      76     103     107     140     124
## gene2       1       6      11       6       1       4
## gene3      80      98      39      82      97     113
## gene4      92      83      59      85     100      98
## gene5      36      24      18      50      22      15
## 995 more rows ...
##
## $samples
##         group lib.size norm.factors
## sample1     A    42832            1
## sample2     A    40511            1
## sample3     A    39299            1
## sample4     B    43451            1
## sample5     B    40613            1
## sample6     B    43662            1
##
## $genes
##       seqnames start end width strand trueIntercept trueBeta  trueDisp
## gene1        1     1 100   100      *      6.525909        0 0.1434076
## gene2        1   101 200   100      *      3.347533        0 0.4929634
## gene3        1   201 300   100      *      6.659599        0 0.1395659
## gene4        1   301 400   100      *      6.544859        0 0.1428412
## gene5        1   401 500   100      *      4.829283        0 0.2407022
## 995 more rows ...
```

We renamed the `condition` column of `colData(se)` to `group` in order to allow
*edgeR* to automatically pick up the correct sample grouping.
Another way of specifying this is through the argument `group` to `DGEList`.

# 3 FAQ

## 3.1 Coerce *DGEList* to *RangedSummarizedExperiment*

Even though there is no direct method to go from a *DGEList* to a
*RangedSummarizedExperiment*, the coercion can be easily performed by first
converting the object to a *DESeqDataSet*, which is a subclass of
*RangedSummarizedExperiment*, and then coercing the resulting object to its
superclass.

```
dds = as.DESeqDataSet(dge)
rse = as(dds, "RangedSummarizedExperiment")
rse
```

```
## class: RangedSummarizedExperiment
## dim: 1000 6
## metadata(1): version
## assays(1): counts
## rownames(1000): gene1 gene2 ... gene999 gene1000
## rowData names(3): trueIntercept trueBeta trueDisp
## colnames(6): sample1 sample2 ... sample5 sample6
## colData names(3): group lib.size norm.factors
```

# 4 Session info

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
##  [1] DEFormats_1.38.0            edgeR_4.8.0
##  [3] limma_3.66.0                DESeq2_1.50.0
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] MatrixGenerics_1.22.0       matrixStats_1.5.0
##  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [11] IRanges_2.44.0              S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0         generics_0.1.4
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         SparseArray_1.10.0  lattice_0.22-7
##  [4] magrittr_2.0.4      digest_0.6.37       evaluate_1.0.5
##  [7] grid_4.5.1          RColorBrewer_1.1-3  bookdown_0.45
## [10] fastmap_1.2.0       jsonlite_2.0.0      Matrix_1.7-4
## [13] backports_1.5.0     BiocManager_1.30.26 scales_1.4.0
## [16] codetools_0.2-20    jquerylib_0.1.4     abind_1.4-8
## [19] cli_3.6.5           rlang_1.1.6         XVector_0.50.0
## [22] cachem_1.1.0        DelayedArray_0.36.0 yaml_2.3.10
## [25] S4Arrays_1.10.0     tools_4.5.1         parallel_4.5.1
## [28] BiocParallel_1.44.0 checkmate_2.3.3     dplyr_1.1.4
## [31] ggplot2_4.0.0       locfit_1.5-9.12     vctrs_0.6.5
## [34] R6_2.6.1            lifecycle_1.0.4     pkgconfig_2.0.3
## [37] pillar_1.11.1       bslib_0.9.0         gtable_0.3.6
## [40] data.table_1.17.8   glue_1.8.0          Rcpp_1.1.0
## [43] statmod_1.5.1       tidyselect_1.2.1    tibble_3.3.0
## [46] xfun_0.53           knitr_1.50          dichromat_2.0-0.1
## [49] farver_2.1.2        htmltools_0.5.8.1   rmarkdown_2.30
## [52] compiler_4.5.1      S7_0.2.0
```