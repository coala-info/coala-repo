# Deploying custom panels in the iSEE interface

Kevin Rue-Albrecht1\*, Federico Marini2,3\*\*, Charlotte Soneson4,5\*\*\* and Aaron Lun6\*\*\*\*

1MRC WIMM Centre for Computational Biology, University of Oxford, Oxford, OX3 9DS, UK
2Institute of Medical Biostatistics, Epidemiology and Informatics (IMBEI), Mainz
3Center for Thrombosis and Hemostasis (CTH), Mainz
4Friedrich Miescher Institute for Biomedical Research, Basel, Switzerland
5SIB Swiss Institute of Bioinformatics
6Cancer Research UK Cambridge Institute, University of Cambridge

\*kevinrue67@gmail.com
\*\*marinif@uni-mainz.de
\*\*\*charlottesoneson@gmail.com
\*\*\*\*infinite.monkeys.with.keyboards@gmail.com

#### 30 October 2025

#### Package

iSEE 2.22.0

**Compiled date**: 2025-10-30

**Last edited**: 2020-04-20

**License**: MIT + file LICENSE

# 1 Background

Users can define their own custom plots or tables to include in the `iSEE` interface (Rue-Albrecht et al. [2018](#ref-kra2018iSEE)).
These custom panels are intended to receive subsets of rows and/or columns from other transmitting panels in the interface.
The values in the custom panels are then recomputed on the fly by user-defined functions using the transmitted subset.
This provides a flexible and convenient framework for lightweight interactive analysis during data exploration.
For example, selection of a particular subset of samples can be transmitted to a custom plot panel that performs dimensionality reduction on that subset.
Alternatively, the subset can be transmitted to a custom table that performs a differential expression analysis between that subset and all other samples.

# 2 Defining custom functions

## 2.1 Minimum requirements

Recalculations in custom panels are performed using user-defined functions that are supplied to the `iSEE()` call.
The only requirements are that the function must accept:

* A `SummarizedExperiment` object or its derivatives as the first argument.
* A list of character vectors containing row names as the *second* argument.
  Each vector specifies the rows that are currently selected in the transmitting *row-based* panel,
  as an active selection or as one of the saved selection.
  This may be `NULL` if no transmitting panel was selected or if no selections are available.
* A list of character vectors containing column names as the *third* argument.
  Each vector specifies the columns that are currently selected in the transmitting *column-based* panel,
  as an active selection or as one of the saved selection.
  This may be `NULL` if no transmitting panel was selected or if no selections are available.

The output of the function should be:

* A `ggplot` object for functions used in *custom plot panels*.
* A `data.frame` for functions used in *custom table panels*.

## 2.2 Example of custom plot panel

To demonstrate the use of *custom plot panels*, we define an example function `CUSTOM_DIMRED` that takes a subset of features and cells in a `SingleCellExperiment` object and performs dimensionality reduction on that subset with *[scater](https://bioconductor.org/packages/3.22/scater)* function (McCarthy et al. [2017](#ref-mccarthy2017scater)).

```
library(scater)
CUSTOM_DIMRED <- function(se, rows, columns, ntop=500, scale=TRUE,
    mode=c("PCA", "TSNE", "UMAP"))
{
    print(columns)
    if (is.null(columns)) {
        return(
            ggplot() + theme_void() + geom_text(
                aes(x, y, label=label),
                data.frame(x=0, y=0, label="No column data selected."),
                size=5)
            )
    }

    mode <- match.arg(mode)
    if (mode=="PCA") {
        calcFUN <- runPCA
    } else if (mode=="TSNE") {
        calcFUN <- runTSNE
    } else if (mode=="UMAP") {
        calcFUN <- runUMAP
    }

    set.seed(1000)
    kept <- se[, unique(unlist(columns))]
    kept <- calcFUN(kept, ncomponents=2, ntop=ntop,
        scale=scale, subset_row=unique(unlist(rows)))
    plotReducedDim(kept, mode)
}
```

As mentioned above, `rows` and `columns` may be `NULL` if no selection was made in the respective transmitting panels.
How these should be treated is up to the user-defined function.
In this example, an empty *ggplot* is returned if there is no selection on the columns, while the default behaviour of `runPCA`, `runTSNE`, etc. is used if `rows=NULL`.

To create instances of our panel, we call the `createCustomPlot()` function with `CUSTOM_DIMRED` to set up the custom plot class and its methods.
This returns a constructor function that can be directly used to generate an instance of our custom plot.

```
library(iSEE)
GENERATOR <- createCustomPlot(CUSTOM_DIMRED)
custom_panel <- GENERATOR()
class(custom_panel)
#> [1] "CustomPlot"
#> attr(,"package")
#> [1] ".GlobalEnv"
```

We can now easily supply instances of our new custom plot class to `iSEE()` like any other `Panel` instance.
The example below creates an application where a column data plot transmits a selection to our custom plot,
the latter of which is initialized in \(t\)-SNE mode with the top 1000 most variable genes.

```
# NOTE: as mentioned before, you don't have to create 'BrushData' manually;
# just open an app, make a brush and copy it from the panel settings.
cdp <- ColumnDataPlot(
    XAxis="Column data",
    XAxisColumnData="Primary.Type",
    PanelId=1L,
    BrushData=list(
        xmin = 10.1, xmax = 15.0, ymin = 5106720.6, ymax = 28600906.0,
        coords_css = list(xmin = 271.0, xmax = 380.0, ymin = 143.0, ymax = 363.0),
        coords_img = list(xmin = 352.3, xmax = 494.0, ymin = 185.9, ymax = 471.9),
        img_css_ratio = list(x = 1.3, y = 1.2),
        mapping = list(x = "X", y = "Y", group = "GroupBy"),
        domain = list(
            left = 0.4, right = 17.6, bottom = -569772L, top = 41149532L,
            discrete_limits = list(
                x = list("L4 Arf5", "L4 Ctxn3", "L4 Scnn1a",
                    "L5 Ucma", "L5a Batf3", "L5a Hsd11b1", "L5a Pde1c",
                    "L5a Tcerg1l", "L5b Cdh13", "L5b Chrna6", "L5b Tph2",
                    "L6a Car12", "L6a Mgp", "L6a Sla", "L6a Syt17",
                    "Pvalb Tacr3", "Sst Myh8")
            )
        ),
        range = list(
            left = 68.986301369863, right = 566.922374429224,
            bottom = 541.013698630137, top = 33.1552511415525
        ),
        log = list(x = NULL, y = NULL),
        direction = "xy",
        brushId = "ColumnDataPlot1_Brush",
        outputId = "ColumnDataPlot1"
    )
)

custom.p <- GENERATOR(mode="TSNE", ntop=1000,
    ColumnSelectionSource="ColumnDataPlot1")

app <- iSEE(sce, initial=list(cdp, custom.p))
```

![](data:image/png;base64...)

The most interesting aspect of `createCustomPlot()` is that the UI elements for modifying the optional arguments in `CUSTOM_DIMRED` are also automatically generated.
This provides a convenient way to generate a reasonably intuitive UI for rapid prototyping, though there are limitations - see the documentation for more details.

## 2.3 Example of custom table panel

To demonstrate the use of *custom table panels*, we define an example function `CUSTOM_SUMMARY` below.
This takes a subset of features and cells in a `SingleCellExperiment` object and creates dataframe that details the `mean`, `variance` and count of samples with expression above a given cut-off within the selection.
If either `rows` or `columns` are `NULL`, all rows or columns are used, respectively.

```
CUSTOM_SUMMARY <- function(se, ri, ci, assay="logcounts", min_exprs=0) {
    if (is.null(ri)) {
        ri <- rownames(se)
    } else {
        ri <- unique(unlist(ri))
    }
    if (is.null(ci)) {
        ci <- colnames(se)
    } else {
        ci <- unique(unlist(ci))
    }

    assayMatrix <- assay(se, assay)[ri, ci, drop=FALSE]

    data.frame(
        Mean = rowMeans(assayMatrix),
        Var = rowVars(assayMatrix),
        Sum = rowSums(assayMatrix),
        n_detected = rowSums(assayMatrix > min_exprs),
        row.names = ri
    )
}
```

To create instances of our panel, we call the `createCustomTable()` function with `CUSTOM_SUMMARY`,
which again returns a constructor function that can be used directly in `iSEE()`.
Again, the function will attempt to auto-pick an appropriate UI element for each optional argument in `CUSTOM_SUMMARY`.

```
library(iSEE)
GENERATOR <- createCustomTable(CUSTOM_SUMMARY)
custom.t <- GENERATOR(PanelWidth=8L,
    ColumnSelectionSource="ReducedDimensionPlot1",
    SearchColumns=c("", "17.8 ... 10000", "", "") # filtering for HVGs.
)
class(custom.t)
#> [1] "CustomTable"
#> attr(,"package")
#> [1] ".GlobalEnv"

# Preselecting some points in the reduced dimension plot.
# Again, you don't have to manually create the 'BrushData'!
rdp <- ReducedDimensionPlot(
    PanelId=1L,
    BrushData = list(
        xmin = -44.8, xmax = -14.3, ymin = 7.5, ymax = 47.1,
        coords_css = list(xmin = 55.0, xmax = 169.0, ymin = 48.0, ymax = 188.0),
        coords_img = list(xmin = 71.5, xmax = 219.7, ymin = 62.4, ymax = 244.4),
        img_css_ratio = list(x = 1.3, y = 1.29),
        mapping = list(x = "X", y = "Y"),
        domain = list(left = -49.1, right = 57.2, bottom = -70.3, top = 53.5),
        range = list(left = 50.9, right = 566.9, bottom = 603.0, top = 33.1),
        log = list(x = NULL, y = NULL),
        direction = "xy",
        brushId = "ReducedDimensionPlot1_Brush",
        outputId = "ReducedDimensionPlot1"
    )
)

app <- iSEE(sce, initial=list(rdp, custom.t))
```

![](data:image/png;base64...)

# 3 Handling active and saved selections

Recall that the second and third arguments are actually lists containing both active and saved selections from the transmitter.
More advanced custom panels can take advantage of these multiple selections to perform more sophisticated data processing.
For example, we can write a function that computes log-fold changes between the samples in the active selection and the samples in each saved selection.
(It would be trivial to extend this to obtain actual differential expression statistics, e.g., using `scran::findMarkers()` or functions from packages like *[limma](https://bioconductor.org/packages/3.22/limma)*.)

```
CUSTOM_DIFFEXP <- function(se, ri, ci, assay="logcounts") {
    ri <- ri$active
    if (is.null(ri)) {
        ri <- rownames(se)
    }
    assayMatrix <- assay(se, assay)[ri, , drop=FALSE]

    if (is.null(ci$active) || length(ci)<2L) {
        return(data.frame(row.names=character(0), LogFC=integer(0))) # dummy value.
    }
    active <- rowMeans(assayMatrix[,ci$active,drop=FALSE])

    all_saved <- ci[grep("saved", names(ci))]
    lfcs <- vector("list", length(all_saved))
    for (i in seq_along(lfcs)) {
        saved <- rowMeans(assayMatrix[,all_saved[[i]],drop=FALSE])
        lfcs[[i]] <- active - saved
    }

    names(lfcs) <- sprintf("LogFC/%i", seq_along(lfcs))
    do.call(data.frame, lfcs)
}
```

We also re-use these statistics to visualize some of the genes with the largest log-fold changes:

```
CUSTOM_HEAT <- function(se, ri, ci, assay="logcounts") {
    everything <- CUSTOM_DIFFEXP(se, ri, ci, assay=assay)
    if (nrow(everything) == 0L) {
        return(ggplot()) # empty ggplot if no genes reported.
    }

    everything <- as.matrix(everything)
    top <- head(order(rowMeans(abs(everything)), decreasing=TRUE), 50)
    topFC <- everything[top, , drop=FALSE]
    dfFC <- data.frame(
        gene=rep(rownames(topFC), ncol(topFC)),
        contrast=rep(colnames(topFC), each=nrow(topFC)),
        value=as.vector(topFC)
    )
    ggplot(dfFC, aes(contrast, gene)) + geom_raster(aes(fill = value))
}
```

We test this out as shown below.
Note that each saved selection is also the active selection when it is first generated, hence the log-fold changes of zero in the last column of the heat map until a new active selection is drawn.

```
TAB_GEN <- createCustomTable(CUSTOM_DIFFEXP)
HEAT_GEN <- createCustomPlot(CUSTOM_HEAT)

rdp[["SelectionHistory"]] <- list(
    list(lasso = NULL, closed = TRUE, panelvar1 = NULL, panelvar2 = NULL,
        mapping = list(x = "X", y = "Y"),
        coord = structure(c(-44.3, -23.7, -13.5, -19.6,
            -33.8, -48.6, -44.3, -33.9, -55.4, -43.0,
            -19.5, -4.0, -22.6, -33.9), .Dim = c(7L, 2L)
        )
    )
)

app <- iSEE(sce, initial=list(rdp,
    TAB_GEN(ColumnSelectionSource="ReducedDimensionPlot1"),
    HEAT_GEN(ColumnSelectionSource="ReducedDimensionPlot1"))
)
```

![](data:image/png;base64...)

# 4 Advanced extensions

The system described above is rather limited and is only provided for quick-and-dirty customizations.
For more serious extensions, we provide a S4 framework for native integration of user-created panels into the application.
This allows specification of custom interface elements and observers and transmission of multiple selections to other panels.
Prospective panel developers are advised to [read the book](https://isee.github.io/iSEE-book),
as there are too many cool things that will not fit into this vignette.

# Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
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
#>  [1] TENxPBMCData_1.27.0         HDF5Array_1.38.0
#>  [3] h5mread_1.2.0               rhdf5_2.54.0
#>  [5] DelayedArray_0.36.0         SparseArray_1.10.0
#>  [7] S4Arrays_1.10.0             abind_1.4-8
#>  [9] Matrix_1.7-4                scater_1.38.0
#> [11] ggplot2_4.0.0               scuttle_1.20.0
#> [13] scRNAseq_2.23.1             iSEE_2.22.0
#> [15] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#> [17] Biobase_2.70.0              GenomicRanges_1.62.0
#> [19] Seqinfo_1.0.0               IRanges_2.44.0
#> [21] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [23] generics_0.1.4              MatrixGenerics_1.22.0
#> [25] matrixStats_1.5.0           BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] splines_4.5.1            later_1.4.4              BiocIO_1.20.0
#>   [4] bitops_1.0-9             filelock_1.0.3           tibble_3.3.0
#>   [7] XML_3.99-0.19            lifecycle_1.0.4          httr2_1.2.1
#>  [10] doParallel_1.0.17        lattice_0.22-7           ensembldb_2.34.0
#>  [13] alabaster.base_1.10.0    magrittr_2.0.4           sass_0.4.10
#>  [16] rmarkdown_2.30           jquerylib_0.1.4          yaml_2.3.10
#>  [19] httpuv_1.6.16            otel_0.2.0               DBI_1.2.3
#>  [22] RColorBrewer_1.1-3       Rtsne_0.17               purrr_1.1.0
#>  [25] AnnotationFilter_1.34.0  RCurl_1.98-1.17          rappdirs_0.3.3
#>  [28] circlize_0.4.16          ggrepel_0.9.6            irlba_2.3.5.1
#>  [31] alabaster.sce_1.10.0     codetools_0.2-20         DT_0.34.0
#>  [34] tidyselect_1.2.1         shape_1.4.6.1            UCSC.utils_1.6.0
#>  [37] farver_2.1.2             viridis_0.6.5            ScaledMatrix_1.18.0
#>  [40] shinyWidgets_0.9.0       BiocFileCache_3.0.0      GenomicAlignments_1.46.0
#>  [43] jsonlite_2.0.0           GetoptLong_1.0.5         BiocNeighbors_2.4.0
#>  [46] iterators_1.0.14         foreach_1.5.2            tools_4.5.1
#>  [49] Rcpp_1.1.0               glue_1.8.0               gridExtra_2.3
#>  [52] xfun_0.53                mgcv_1.9-3               GenomeInfoDb_1.46.0
#>  [55] dplyr_1.1.4              gypsum_1.6.0             shinydashboard_0.7.3
#>  [58] withr_3.0.2              BiocManager_1.30.26      fastmap_1.2.0
#>  [61] rhdf5filters_1.22.0      shinyjs_2.1.0            digest_0.6.37
#>  [64] rsvd_1.0.5               R6_2.6.1                 mime_0.13
#>  [67] colorspace_2.1-2         listviewer_4.0.0         dichromat_2.0-0.1
#>  [70] RSQLite_2.4.3            cigarillo_1.0.0          rtracklayer_1.70.0
#>  [73] httr_1.4.7               htmlwidgets_1.6.4        pkgconfig_2.0.3
#>  [76] gtable_0.3.6             blob_1.2.4               ComplexHeatmap_2.26.0
#>  [79] S7_0.2.0                 XVector_0.50.0           htmltools_0.5.8.1
#>  [82] bookdown_0.45            ProtGenerics_1.42.0      rintrojs_0.3.4
#>  [85] clue_0.3-66              scales_1.4.0             alabaster.matrix_1.10.0
#>  [88] png_0.1-8                knitr_1.50               rjson_0.2.23
#>  [91] nlme_3.1-168             curl_7.0.0               shinyAce_0.4.4
#>  [94] cachem_1.1.0             GlobalOptions_0.1.2      BiocVersion_3.22.0
#>  [97] parallel_4.5.1           miniUI_0.1.2             vipor_0.4.7
#> [100] AnnotationDbi_1.72.0     restfulr_0.0.16          pillar_1.11.1
#> [103] grid_4.5.1               alabaster.schemas_1.10.0 vctrs_0.6.5
#> [106] promises_1.4.0           BiocSingular_1.26.0      dbplyr_2.5.1
#> [109] beachmat_2.26.0          xtable_1.8-4             cluster_2.1.8.1
#> [112] beeswarm_0.4.0           evaluate_1.0.5           GenomicFeatures_1.62.0
#> [115] cli_3.6.5                compiler_4.5.1           Rsamtools_2.26.0
#> [118] rlang_1.1.6              crayon_1.5.3             ggbeeswarm_0.7.2
#> [121] viridisLite_0.4.2        alabaster.se_1.10.0      BiocParallel_1.44.0
#> [124] Biostrings_2.78.0        lazyeval_0.2.2           colourpicker_1.3.0
#> [127] ExperimentHub_3.0.0      bit64_4.6.0-1            Rhdf5lib_1.32.0
#> [130] KEGGREST_1.50.0          shiny_1.11.1             alabaster.ranges_1.10.0
#> [133] AnnotationHub_4.0.0      fontawesome_0.5.3        igraph_2.2.1
#> [136] memoise_2.0.1            bslib_0.9.0              bit_4.6.0
# devtools::session_info()
```

# References

McCarthy, D. J., K. R. Campbell, A. T. Lun, and Q. F. Wills. 2017. “Scater: pre-processing, quality control, normalization and visualization of single-cell RNA-seq data in R.” *Bioinformatics* 33 (8): 1179–86.

Rue-Albrecht, K., F. Marini, C. Soneson, and A. T. L. Lun. 2018. “ISEE: Interactive Summarizedexperiment Explorer.” *F1000Research* 7 (June): 741.