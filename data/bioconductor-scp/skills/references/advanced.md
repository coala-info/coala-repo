Code

* Show All Code
* Hide All Code

# Advanced usage of `scp`

Laurent Gatto and Christophe Vanderaa

#### 30 October 2025

#### Package

scp 1.20.0

# 1 About this vignette

This vignette is dedicated to advanced users and to method developers.
It assumes that you are already familiar with `QFeatures` and `scp`
and that you are looking for more flexibility in the analysis of your
single-cell proteomics (SCP) data. In fact, `scp` provides wrapper
functions around generic functions and metrics. However, advanced
users may want to apply or develop their own features. The `QFeatures`
class offers a flexible data container while guaranteeing data
consistency.

In this vignette, you will learn how to:

* Modify the quantitative data
* Modify the sample annotations
* Modify the feature annotations
* Create a new function for `scp`

As a general guideline, you can add/remove/update data in a
`QFeatures` in 4 main steps:

1. Gather the data to change and other required data involved in the
   processing.
2. Apply the transformation/computation.
3. Insert the changes in the `QFeatures` object.
4. Make sure the updated `QFeatures` object is still valid.

To illustrate the different topics, we will load the `scp1` example
data.

```
library(scp)
data("scp1")
scp1
#> An instance of class QFeatures (type: bulk) with 5 sets:
#>
#>  [1] 190321S_LCA10_X_FP97AG: SummarizedExperiment with 166 rows and 11 columns
#>  [2] 190222S_LCA9_X_FP94BM: SummarizedExperiment with 176 rows and 11 columns
#>  [3] 190914S_LCB3_X_16plex_Set_21: SummarizedExperiment with 215 rows and 16 columns
#>  [4] peptides: SummarizedExperiment with 539 rows and 38 columns
#>  [5] proteins: SummarizedExperiment with 292 rows and 38 columns
```

# 2 Modify the quantitative data

To illustrate how to modify quantitative data, we will implement a
`normByType` function that will normalize the feature (row) for each
cell type separately. This function is probably not relevant for a
real case analysis, but it provides a good example of a custom data
processing. The process presented in this section is applicable to any
custom function that takes at least a **matrix-like object** as input
and returns a matrix-like object as output.

```
normByType <- function(x, type) {
    ## Check argument
    stopifnot(length(type) == ncol(x))
    ## Normalize for each type separately
    for (i in unique(type)) {
        ## Get normalization factor
        nf <- rowMedians(x[, type == i], na.rm = TRUE)
        ## Perform normalization
        x[, type == i] <- x[, type == i] / nf
    }
    ## Return normalized data
    x
}
```

Suppose we want to apply the function to the `proteins` assay, we need
to first extract that assay. We here need to transfer the sample
annotations from the `QFeatures` object to the extracted
`SingleCellExperiment` in order to get the sample types required by
the `normByType` function. We therefore use `getWithColData`.

```
sce <- getWithColData(scp1, "proteins")
sce
#> class: SummarizedExperiment
#> dim: 292 38
#> metadata(0):
#> assays(2): assay aggcounts
#> rownames(292): A1A519 A5D8V6 ... REV__CON__Q32PI4 REV__CON__Q3MHN5
#> rowData names(9): protein Match.time.difference ...
#>   Potential.contaminant .n
#> colnames(38): 190321S_LCA10_X_FP97AGRI1 190321S_LCA10_X_FP97AGRI2 ...
#>   190914S_LCB3_X_16plex_Set_21RI15 190914S_LCB3_X_16plex_Set_21RI16
#> colData names(7): Set Channel ... sortday digest
```

Next, we can apply the data transformation to the quantitative data.
As mentioned above, our function expects a matrix-like object as an
input, so we use the `assay` function. We then update the
`SingleCellExperiment` object.

```
mnorm <- normByType(assay(sce), type = sce$SampleType)
assay(sce) <- mnorm
```

We are now faced with 2 possibilities: either we want to create a new
assay or we want to overwrite an existing assay. In both cases we need
to make sure your data is still valid after data transformation.

## 2.1 Create a new assay

Creating a new assay has the advantage that you don’t modify an
existing assay and hence limit the risk of introducing inconsistency
in the data and avoid losing intermediate steps of the data
processing.

We add the transformed assay using the `addAssay` function, then link
the parent assay to the transformed assay using `addAssayLinkOneToOne`.
Note that if each row name in the parent assay does not match exactly
one row in the child assay, you can also use `addAssayLink` that will
require a linking variable in the `rowData`.

```
scp1 <- addAssay(scp1, sce, name = "proteinsNorm")
scp1 <- addAssayLinkOneToOne(scp1, from = "proteins", to = "proteinsNorm")
scp1
#> An instance of class QFeatures (type: bulk) with 6 sets:
#>
#>  [1] 190321S_LCA10_X_FP97AG: SummarizedExperiment with 166 rows and 11 columns
#>  [2] 190222S_LCA9_X_FP94BM: SummarizedExperiment with 176 rows and 11 columns
#>  [3] 190914S_LCB3_X_16plex_Set_21: SummarizedExperiment with 215 rows and 16 columns
#>  [4] peptides: SummarizedExperiment with 539 rows and 38 columns
#>  [5] proteins: SummarizedExperiment with 292 rows and 38 columns
#>  [6] proteinsNorm: SummarizedExperiment with 292 rows and 38 columns
```

## 2.2 Overwrite an existing assay

Overwriting an existing assay has the advantage to limit the memory
consumption as compared to adding a new assay. You can overwrite an
assay simply by replacing the target assay in its corresponding slot.

```
scp1[["proteins"]] <- sce
```

## 2.3 Check for validity

Applying custom changes to the data increases the risk for data
inconsistencies. You can however verify that a `QFeatures` object is
still valid after some processing thanks to the `validObject` function.

```
validObject(scp1)
#> [1] TRUE
```

If the function detects no issues in the data, it will return `TRUE`.
Otherwise the function will throw an informative error that should
guide the user to identifying the issue.

# 3 Modify the sample annotations

To illustrate how to modify the sample annotations, we will compute the
average expression in each sample and include to the `colData` of the
`QFeatures` object. This is typically performed when computing QC
metrics for sample filtering. So, we first extract the required data,
in this case the quantitative values, and compute the sample-wise
average protein expression.

```
m <- assay(scp1, "proteins")
meanExprs <- colMeans(m, na.rm = TRUE)
meanExprs
#>        190321S_LCA10_X_FP97AGRI1        190321S_LCA10_X_FP97AGRI2
#>                       45368.3628                        7566.8782
#>        190321S_LCA10_X_FP97AGRI3        190321S_LCA10_X_FP97AGRI4
#>                        3271.0402                        2158.4230
#>        190321S_LCA10_X_FP97AGRI5        190321S_LCA10_X_FP97AGRI6
#>                        1162.3936                        1835.7939
#>        190321S_LCA10_X_FP97AGRI7        190321S_LCA10_X_FP97AGRI8
#>                        1293.4738                        1415.4205
#>        190321S_LCA10_X_FP97AGRI9       190321S_LCA10_X_FP97AGRI10
#>                        1965.6531                        1264.4064
#>       190321S_LCA10_X_FP97AGRI11         190222S_LCA9_X_FP94BMRI1
#>                        1238.5979                       48901.4654
#>         190222S_LCA9_X_FP94BMRI2         190222S_LCA9_X_FP94BMRI3
#>                        5189.5912                        2802.1850
#>         190222S_LCA9_X_FP94BMRI4         190222S_LCA9_X_FP94BMRI5
#>                        1204.2350                         715.7667
#>         190222S_LCA9_X_FP94BMRI6         190222S_LCA9_X_FP94BMRI7
#>                        1032.7122                         403.8267
#>         190222S_LCA9_X_FP94BMRI8         190222S_LCA9_X_FP94BMRI9
#>                        1089.0548                        1076.2613
#>        190222S_LCA9_X_FP94BMRI10        190222S_LCA9_X_FP94BMRI11
#>                        1572.3337                        1186.4431
#>  190914S_LCB3_X_16plex_Set_21RI1  190914S_LCB3_X_16plex_Set_21RI2
#>                       96881.8350                        2731.9430
#>  190914S_LCB3_X_16plex_Set_21RI3  190914S_LCB3_X_16plex_Set_21RI4
#>                        8208.1958                         208.2857
#>  190914S_LCB3_X_16plex_Set_21RI5  190914S_LCB3_X_16plex_Set_21RI6
#>                        3209.7730                        2014.4889
#>  190914S_LCB3_X_16plex_Set_21RI7  190914S_LCB3_X_16plex_Set_21RI8
#>                        2897.1103                        3006.6741
#>  190914S_LCB3_X_16plex_Set_21RI9 190914S_LCB3_X_16plex_Set_21RI10
#>                        2760.8564                        2549.9348
#> 190914S_LCB3_X_16plex_Set_21RI11 190914S_LCB3_X_16plex_Set_21RI12
#>                        2388.5289                        2533.8006
#> 190914S_LCB3_X_16plex_Set_21RI13 190914S_LCB3_X_16plex_Set_21RI14
#>                        2134.5615                        3125.1980
#> 190914S_LCB3_X_16plex_Set_21RI15 190914S_LCB3_X_16plex_Set_21RI16
#>                        3276.5618                        3195.8827
```

Next, we insert the computed averages into the `colData`. You need to
make sure to match sample names because an extracted assay may not
contain all samples and may be in a different order compared to the
`colData`.

```
colData(scp1)[names(meanExprs), "meanProtExprs"] <- meanExprs
```

The new sample variable `meanProtExprs` is now accessible for filtering
or plotting. The `$` operator makes it straightforward to access the
new data.

```
hist(log2(scp1$meanProtExprs))
```

![](data:image/png;base64...)

To make sure that the process did not corrupt the `colData`, we advise
to verify the data is still valid.

```
validObject(scp1)
#> [1] TRUE
```

# 4 Modify the feature annotations

We will again illustrate how to modify the feature annotations with an
example. We here demonstrate how to add the number of samples in which
each feature is detected for the three first assays (PSM assays). The
challenge here is that the metric needs to be computed for each assay
separately and inserted in the corresponding assay.

We will take advantage of the replacement function for `rowData` as
implemented in `QFeatures`. It expects a list-like object where names
indicate in which assays we want to modify the `rowData` and each
element contains a table with the replacement values.

We therefore compute the metrics for each assay separately and store
the results in a named `List`.

```
## Initialize the List object that will store the computed values
res <- List()
## We compute the metric for the first 3 assays
for (i in 1:3) {
    ## We get the quantitative values for the current assay
    m <- assay(scp1[[i]])
    ## We compute the number of samples in which each features is detected
    n <- rowSums(!is.na(m) & m != 0)
    ## We store the result as a DataFrame in the List
    res[[i]] <- DataFrame(nbSamples = n)
}
names(res) <- names(scp1)[1:3]
res
#> List of length 3
#> names(3): 190321S_LCA10_X_FP97AG 190222S_LCA9_X_FP94BM 190914S_LCB3_X_16plex_Set_21
res[[1]]
#> DataFrame with 166 rows and 1 column
#>           nbSamples
#>           <numeric>
#> PSM3773          11
#> PSM9078          11
#> PSM9858          11
#> PSM11744         11
#> PSM21752          0
#> ...             ...
#> PSM732069        11
#> PSM735396        11
#> PSM744756        10
#> PSM745037        11
#> PSM745130        11
```

Now that we have a `List` of `DataFrame`s, we can update the object.

```
rowData(scp1) <- res
```

The new feature variable `nbSamples` is now accessible for filtering
or plotting. The `rbindRowData` function facilitates the access the
new data.

```
library("ggplot2")
rd <- rbindRowData(scp1, i = 1:3)
ggplot(data.frame(rd)) +
    aes(x = nbSamples) +
    geom_histogram(bins = 16) +
    facet_wrap(~ assay)
```

![](data:image/png;base64...)

To make sure that the process did not corrupt the `rowData` in any
assay, we advise to verify the data is still valid.

```
validObject(scp1)
#> [1] TRUE
```

# 5 Create a new function for `scp`

The modifying data in a `QFeatures` involves a multiple-step process.
Creating a wrapper function that would take care of those different
steps in a single line of code is a good habit to reduce the length of
analysis scripts and hence making it easier to understand and less
error-prone.

We will wrap the last example in a new function that we call
`computeNbDetectedSamples`.

```
computeNbDetectedSamples <- function(object, i) {
    res <- List()
    for (ii in i) {
        m <- assay(object[[ii]])
        n <- rowSums(!is.na(m) & m != 0)
        res[[ii]] <- DataFrame(nbSamples = n)
    }
    names(res) <- names(object)[i]
    rowData(object) <- res
    stopifnot(validObject(object))
    object
}
```

Thanks to this new function, the previous section now simply boils
down to running:

```
scp1 <- computeNbDetectedSamples(scp1, i = 1:3)
```

Keep in mind a few recommendations when creating a new function for
`scp`:

* The function should take a `QFeatures` object as input (and more
  arguments if needed) and return a `QFeatures` object as output. This
  will make workflows much easier to understand.
* Allow user to select assays (if required) either as numeric, character,
  or logical.
* Use conventional argument names: when naming an argument, try to
  match the names that already exist. For instance, selecting assays
  is passed through the `i` argument, selecting `rowData` variables is
  passed through `rowvars` and selecting `colData` variables is passed
  through `colvars`.
* Follow the `rformassspectrometry`
  [coding style](https://rformassspectrometry.github.io/RforMassSpectrometry/articles/RforMassSpectrometry.html#coding-style)

# 6 What’s next?

So you developed a new metric or method and believe it might benefit
the community? We would love to hear about your improvements and
eventually include your new functionality into `scp` or associate your
new package to our documentation. Please, raise an
[issue](https://github.com/UCLouvain-CBIO/scp/issues/new/choose) in
our Github repository to suggest your improvements or, better, submit
your code as a
[pull request](https://github.com/UCLouvain-CBIO/scp/compare).

# Session information

```
R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats4    stats     graphics  grDevices utils     datasets  methods
[8] base

other attached packages:
 [1] ggplot2_4.0.0               scp_1.20.0
 [3] QFeatures_1.20.0            MultiAssayExperiment_1.36.0
 [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
 [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
 [9] IRanges_2.44.0              S4Vectors_0.48.0
[11] BiocGenerics_0.56.0         generics_0.1.4
[13] MatrixGenerics_1.22.0       matrixStats_1.5.0
[15] BiocStyle_2.38.0

loaded via a namespace (and not attached):
 [1] impute_1.84.0               gtable_0.3.6
 [3] xfun_0.53                   bslib_0.9.0
 [5] ggrepel_0.9.6               lattice_0.22-7
 [7] vctrs_0.6.5                 tools_4.5.1
 [9] tibble_3.3.0                cluster_2.1.8.1
[11] nipals_1.0                  pkgconfig_2.0.3
[13] BiocBaseUtils_1.12.0        Matrix_1.7-4
[15] RColorBrewer_1.1-3          IHW_1.38.0
[17] S7_0.2.0                    lpsymphony_1.38.0
[19] lifecycle_1.0.4             farver_2.1.2
[21] compiler_4.5.1              stringr_1.5.2
[23] clue_0.3-66                 htmltools_0.5.8.1
[25] sass_0.4.10                 fdrtool_1.2.18
[27] yaml_2.3.10                 lazyeval_0.2.2
[29] pillar_1.11.1               jquerylib_0.1.4
[31] tidyr_1.3.1                 MASS_7.3-65
[33] SingleCellExperiment_1.32.0 DelayedArray_0.36.0
[35] cachem_1.1.0                abind_1.4-8
[37] metapod_1.18.0              tidyselect_1.2.1
[39] digest_0.6.37               slam_0.1-55
[41] stringi_1.8.7               dplyr_1.1.4
[43] reshape2_1.4.4              purrr_1.1.0
[45] bookdown_0.45               labeling_0.4.3
[47] fastmap_1.2.0               grid_4.5.1
[49] cli_3.6.5                   SparseArray_1.10.0
[51] magrittr_2.0.4              S4Arrays_1.10.0
[53] dichromat_2.0-0.1           withr_3.0.2
[55] scales_1.4.0                rmarkdown_2.30
[57] XVector_0.50.0              igraph_2.2.1
[59] evaluate_1.0.5              knitr_1.50
[61] rlang_1.1.6                 Rcpp_1.1.0
[63] glue_1.8.0                  BiocManager_1.30.26
[65] jsonlite_2.0.0              AnnotationFilter_1.34.0
[67] R6_2.6.1                    plyr_1.8.9
[69] ProtGenerics_1.42.0         MsCoreUtils_1.22.0
```

# License

This vignette is distributed under a
[CC BY-SA license](https://creativecommons.org/licenses/by-sa/2.0/)
license.