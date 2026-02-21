# gg4way

Ben Laufer

#### 30 October 2025

#### Package

gg4way 1.8.0

# 1 Introduction

4way plots enable a comparison of the logFC values from two contrasts of differential gene expression (Friedman and Maniatis [2011](#ref-Friedman)). The gg4way package creates 4way plots using the ggplot2 framework and supports popular Bioconductor objects. The package also provides information about the correlation between contrasts and significant genes of interest.

# 2 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("gg4way")
```

To install the development version directly from GitHub:

```
if (!requireNamespace("remotes", quietly = TRUE)) {
    install.packages("remotes")
}

remotes::install_github("ben-laufer/gg4way")
```

# 3 Quick start: limma

This example involves testing a popular RNA-seq dataset using limma-voom.

## 3.1 Prepare data

First the [airway](https://doi.org/doi%3A10.18129/B9.bioc.airway) data package is loaded, gene symbols are added, and then for the purpose of this vignette only genes with symbols are kept.

```
library("airway")
data("airway")
se <- airway

library("org.Hs.eg.db")
rowData(se)$symbol <- mapIds(org.Hs.eg.db,
                             keys = rownames(se),
                             column = "SYMBOL",
                             keytype = "ENSEMBL")

rowData(se)$ID <- rownames(se)

se <- se[!is.na(rowData(se)$symbol)]
```

## 3.2 limma-voom

The output from `limma::eBayes()` and `limma::treat()` is supported; however, only the former is shown for this example.

```
library("edgeR")
library("limma")

dge <- se |>
    SE2DGEList()

design <- model.matrix(~ 0 + cell + dex, data = dge$samples)
colnames(design) <- gsub("cell", "", colnames(design))

contr.matrix <- makeContrasts(N61311 - N052611,
                              N061011 - N052611,
                              levels = c("N052611", "N061011",
                                         "N080611", "N61311",
                                         "dexuntrt"))

keep <- filterByExpr(dge, design)
dge <- dge[keep, ]

efit <- dge |>
    calcNormFactors() |>
    voom(design) |>
    lmFit(design) |>
    contrasts.fit(contrasts = contr.matrix) |>
    eBayes()
```

## 3.3 Plot

Finally, we create a 4way plot comparing the logFC for all genes in the two contrasts.

```
library("gg4way")

p1 <- efit |>
    gg4way(x = "N61311 vs N052611",
           y = "N061011 vs N052611")

p1
```

![gg4way from limma](data:image/png;base64...)

Figure 1: gg4way from limma

The legend title at the bottom shows that there is a correlation of r = 0.43, which is exemplified by more shared DEGs (blue dots) going in the same direction (upper right and bottom left) than opposite direction (upper left and bottom right). The numbers in the plot give the totals for the different quadrants of the 4way plot. If you look at the bottom left quadrant, the blue text shows that there are 61 DEGs where N052611 has significantly increased expression relative to both N61311 and N061011. The red text shows that there are 234 DEGs where N052611 has significantly increased expression relative to N61311 only, while the green text shows that there are 42 DEGs where N052611 has significantly increased expression relative to N061011 only.

# 4 Add gene labels

## 4.1 Table for labels

The genes that are significant in both contrasts can be obtained in a table through `getShared()`.

```
p1 |>
    getShared() |>
    head()
## # A tibble: 6 × 12
##   ID              symbol   `N61311 vs N052611 LogFC` `N061011 vs N052611 LogFC`
##   <chr>           <chr>                        <dbl>                      <dbl>
## 1 ENSG00000204941 PSG5                         -4.61                      -5.24
## 2 ENSG00000164308 ERAP2                         3.45                       3.77
## 3 ENSG00000018625 ATP1A2                       -2.81                      -2.17
## 4 ENSG00000262902 MTCO1P40                     -6.72                      -6.78
## 5 ENSG00000180914 OXTR                         -3.78                      -3.18
## 6 ENSG00000078018 MAP2                         -3.09                      -1.35
## # ℹ 8 more variables: `N61311 vs N052611 FDR` <dbl>,
## #   `N061011 vs N052611 FDR` <dbl>, `N61311 vs N052611 FDRpass` <lgl>,
## #   `N061011 vs N052611 FDRpass` <lgl>, `N61311 vs N052611 Direction` <chr>,
## #   `N061011 vs N052611 Direction` <chr>, Significant <fct>, alpha <dbl>
```

## 4.2 Plotting labels

Gene symbols can be added to the plot through the `label` argument. Setting it to `TRUE` will plot all the genes colored blue, while specific genes can be labelled by providing their symbol. Below, two of the genes from the above table are labelled in the plot.

```
efit |>
    gg4way(x = "N61311 vs N052611",
           y = "N061011 vs N052611",
           label = c("PSG5", "ERAP2"))
```

![gg4way with labels](data:image/png;base64...)

Figure 2: gg4way with labels

# 5 Advanced options

## 5.1 Axis titles

The axis titles can be further customized through ggplot2.

```
p1 +
    xlab(expression(atop(
        paste("Higher in Line 2" %<->% "Higher in Line 1"),
        paste("Line 1 vs 2 LogFC")))) +
    ylab(expression(atop(
        paste("Line 3 vs 2"),
        paste("Higher in Line 2" %<->% "Higher in Line 3"))))
```

![gg4way with custom axis titles](data:image/png;base64...)

Figure 3: gg4way with custom axis titles

## 5.2 Correlation only

The Pearson correlation coefficient can be obtained from `getCor()`. Advanced users can apply this in their own functions to compare across pairs in a heatmap.

```
p1 |>
    getCor()
## [1] 0.43
```

# 6 edgeR

In addition to the output of limma, the functions are also compatible with edgeR and DESeq2. If a user is starting here, they will first have to run the [Prepare data](#prepare-data) and [limma-voom](#limma-voom) subsections in the Quick start: limma section. The output from `edgeR::glmQLFTest()`, `edgeR::glmTreat()`, and `edgeR::glmLRT()` is supported.

```
library("purrr")

rfit <- dge |>
    calcNormFactors() |>
    estimateDisp() |>
    glmQLFit(design)

rfit <- contr.matrix |>
    colnames() |>
    set_names() |>
    map(~ rfit |>
            glmQLFTest(contrast = contr.matrix[,.x]))

rfit |>
    gg4way(x = "N61311 vs N052611",
           y = "N061011 vs N052611")
```

![gg4way from edgeR](data:image/png;base64...)

Figure 4: gg4way from edgeR

# 7 DESeq2

If a user is starting here, they will first have to run the [Prepare data](#prepare-data) subsection in the Quick start: limma section.

## 7.1 DESeq analysis

For the purpose of this vignette, we filter the object to remove the [difference](https://support.bioconductor.org/p/122825/) between the results name and contrast approaches shown below.

```
library("DESeq2")

ddsSE <- se |>
    DESeqDataSet(design = ~ cell + dex)

keep <- ddsSE |>
    counts() |>
    apply(1, function(gene) {
        all(gene != 0)
    })

ddsSE <- ddsSE[keep, ]

dds <- ddsSE |>
    DESeq()
```

## 7.2 Plot by results name

```
dds |>
    gg4way(x = "N61311 vs N052611",
           y = "N061011 vs N052611")
```

![gg4way from DESeq2](data:image/png;base64...)

Figure 5: gg4way from DESeq2

## 7.3 Plot by contrast

The same result as above can be obtained through the `contrast` argument of `DESeq2::results()`, where you can also specify the `lfcThreshold`.

```
list("N61311 vs N052611" = c("cell", "N61311", "N052611"),
     "N061011 vs N052611" = c("cell", "N061011", "N052611")) |>
    map(~ results(dds, contrast = .x)) |>
    gg4way(x = "N61311 vs N052611",
           y = "N061011 vs N052611")
```

![gg4way from DESeq2 contrast](data:image/png;base64...)

Figure 6: gg4way from DESeq2 contrast

## 7.4 Plot by lfcShrink

Finally, the output of `DESeq2::lfcShrink()` can also be plotted.

```
list("N61311 vs N052611" = c("cell", "N61311", "N052611"),
     "N061011 vs N052611" = c("cell", "N061011", "N052611")) |>
    map(~ dds |>
        results(contrast = .x) |>
        lfcShrink(dds, contrast = .x, res = _, type = "normal")) |>
    gg4way(x = "N61311 vs N052611",
           y = "N061011 vs N052611")
```

![gg4way from DESeq2 lfcShrink](data:image/png;base64...)

Figure 7: gg4way from DESeq2 lfcShrink

# 8 Other packages

gg4way is not limited to input from limma, edgeR, or DESeq2. It also works with a named list of data.frames, where the names correspond to the `x` and `y` arguments. The separator between groups in the names of the list can be specified using the `sep` argument. Each data.frame should have columns corresponding to values provided to the `ID`, `logFC`, and `FDR` arguments. The `symbol` column is optional and used for the plot labels. This enables cases where not every feature has a (unique) gene ID. If the `symbol` column is not present then the argument should be given the `ID` column. The default values for the arguments can be seen in the documentation through `?gg4way()`.

# 9 Package support

The [Bioconductor support site](https://support.bioconductor.org/) is the preferred method to ask for help. Before posting, it’s recommended to check [previous posts](https://support.bioconductor.org/tag/gg4way/) for the answer and look over the [posting guide](http://www.bioconductor.org/help/support/posting-guide/). For the post, it’s important to use the `gg4way` tag and provide both a minimal reproducible example and session information.

# 10 Session info

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
##  [1] DESeq2_1.50.0               purrr_1.1.0
##  [3] gg4way_1.8.0                ggplot2_4.0.0
##  [5] edgeR_4.8.0                 limma_3.66.0
##  [7] org.Hs.eg.db_3.22.0         AnnotationDbi_1.72.0
##  [9] airway_1.29.0               SummarizedExperiment_1.40.0
## [11] Biobase_2.70.0              GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0               IRanges_2.44.0
## [15] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [17] generics_0.1.4              MatrixGenerics_1.22.0
## [19] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1    dplyr_1.1.4         farver_2.1.2
##  [4] blob_1.2.4          Biostrings_2.78.0   S7_0.2.0
##  [7] fastmap_1.2.0       janitor_2.2.1       digest_0.6.37
## [10] timechange_0.3.0    lifecycle_1.0.4     statmod_1.5.1
## [13] KEGGREST_1.50.0     RSQLite_2.4.3       magrittr_2.0.4
## [16] compiler_4.5.1      rlang_1.1.6         sass_0.4.10
## [19] tools_4.5.1         utf8_1.2.6          yaml_2.3.10
## [22] knitr_1.50          labeling_0.4.3      S4Arrays_1.10.0
## [25] bit_4.6.0           DelayedArray_0.36.0 RColorBrewer_1.1-3
## [28] abind_1.4-8         BiocParallel_1.44.0 withr_3.0.2
## [31] grid_4.5.1          scales_1.4.0        dichromat_2.0-0.1
## [34] cli_3.6.5           rmarkdown_2.30      crayon_1.5.3
## [37] httr_1.4.7          DBI_1.2.3           cachem_1.1.0
## [40] stringr_1.5.2       splines_4.5.1       parallel_4.5.1
## [43] BiocManager_1.30.26 XVector_0.50.0      vctrs_0.6.5
## [46] Matrix_1.7-4        jsonlite_2.0.0      bookdown_0.45
## [49] bit64_4.6.0-1       ggrepel_0.9.6       locfit_1.5-9.12
## [52] tidyr_1.3.1         jquerylib_0.1.4     glue_1.8.0
## [55] codetools_0.2-20    lubridate_1.9.4     stringi_1.8.7
## [58] gtable_0.3.6        tibble_3.3.0        pillar_1.11.1
## [61] htmltools_0.5.8.1   R6_2.6.1            evaluate_1.0.5
## [64] lattice_0.22-7      png_0.1-8           memoise_2.0.1
## [67] snakecase_0.11.1    bslib_0.9.0         Rcpp_1.1.0
## [70] SparseArray_1.10.0  xfun_0.53           pkgconfig_2.0.3
```

# References

Friedman, B. A., and T. Maniatis. 2011. “ExpressionPlot: a web-based framework for analysis of RNA-Seq and microarray gene expression data.” *Genome Biol* 12 (7): R69.