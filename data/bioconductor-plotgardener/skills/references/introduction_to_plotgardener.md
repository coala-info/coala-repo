# Introduction to plotgardener

#### Nicole Kramer, Eric S. Davis, Craig Wenger, Sarah Parker, Erika Deoudes, Michael Love, Douglas H. Phanstiel

# Overview

![](data:image/png;base64...)

`plotgardener` is a coordinate-based, genomic visualization package for R. Using `grid` graphics, `plotgardener` empowers users to programmatically and flexibly generate multi-panel figures. Tailored for genomics for a variety of genomic assemblies, `plotgardener` allows users to visualize large, complex genomic datasets while providing exquisite control over the arrangement of plots.

`plotgardener` functions can be grouped into the following categories:

* **Page layout functions:**

Functions for creating `plotgardener` page layouts, drawing, showing, and hiding guides, as well as placing plots on the page. See [The plotgardener Page](https://phanstiellab.github.io/plotgardener/articles/guides/plotgardener_page.html)

* **Reading functions:**

Functions for quickly reading in large biological datasets. See [Reading Data for plotgardener](https://phanstiellab.github.io/plotgardener/articles/guides/reading_data_for_plotgardener.html)

* **Plotting functions:**

Contains genomic plotting functions, functions for placing `ggplots` and `base` plots, as well as functions for drawing simple shapes. See [Plotting Multi-omic Data](https://phanstiellab.github.io/plotgardener/articles/guides/plotting_multiomic_data.html)

* **Annotation functions:**

Enables users to add annotations to their plots, such as legends, axes, and scales. See [Plot Annotations](https://phanstiellab.github.io/plotgardener/articles/guides/annotations.html)

* **Meta functions:**

Functions that display `plotgardener` properties or operate on other `plotgardener` functions, or constructors for `plotgardener` objects. See [plotgardener Meta Functions](https://phanstiellab.github.io/plotgardener/articles/guides/plotgardener_meta_functions.html)

This vignette provides a quick start guide for utilizing `plotgardener`. For in-depth demonstrations of `plotgardener`’s key features, see the additional articles. For detailed usage of each function, see the function-specific reference examples with `?function()` (e.g. `?plotPairs()`).

All the data included in this vignette can be found in the supplementary package `plotgardenerData`.

# Quick plotting

`plotgardener` plotting functions contain 4 types of arguments:

1. Data reading argument (`data`)
2. Genomic locus arguments (`chrom`, `chromstart`, `chromend`, `assembly`)
3. Placement arguments (`x`, `y`, `width`, `height`, `just`, `default.units`, …) that define where each plot resides on a `page`
4. Attribute arguments that affect the data being plotted or the style of the plot (`norm`, `fill`, `fontcolor`, …) that vary between functions

The quickest way to plot data is to omit the placement arguments. This will generate a `plotgardener` plot that fills up the entire graphics window and cannot be annotated. **These plots are only meant to be used for quick** **genomic data inspection and not as final `plotgardener` plots.** The only arguments that are required are the data arguments and locus arguments. The examples below show how to quickly plot different types of genomic data with plot defaults and included data types. To use your own data, replace the `data` argument with either a path to the file or an R object as described above.

## Hi-C matrices

```
## Load plotgardener
library(plotgardener)

## Load example Hi-C data
library(plotgardenerData)
data("IMR90_HiC_10kb")

## Quick plot Hi-C data
plotHicSquare(
    data = IMR90_HiC_10kb,
    chrom = "chr21", chromstart = 28000000, chromend = 30300000,
    assembly = "hg19"
)
```

![](data:image/png;base64...)

## Signal tracks

```
## Load plotgardener
library(plotgardener)

## Load example signal data
library(plotgardenerData)
data("IMR90_ChIP_H3K27ac_signal")

## Quick plot signal data
plotSignal(
    data = IMR90_ChIP_H3K27ac_signal,
    chrom = "chr21", chromstart = 28000000, chromend = 30300000,
    assembly = "hg19"
)
```

![](data:image/png;base64...)

## Gene tracks

```
## Load plotgardener
library(plotgardener)

## Load hg19 genomic annotation packages
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(org.Hs.eg.db)

## Quick plot genes
plotGenes(
    assembly = "hg19",
    chrom = "chr21", chromstart = 28000000, chromend = 30300000
)
```

![](data:image/png;base64...)

## GWAS Manhattan plots

```
## Load plotgardener
library(plotgardener)

## Load hg19 genomic annotation packages
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

## Load example GWAS data
library(plotgardenerData)
data("hg19_insulin_GWAS")

## Quick plot GWAS data
plotManhattan(
    data = hg19_insulin_GWAS,
    assembly = "hg19",
    fill = c("steel blue", "grey"),
    ymax = 1.1, cex = 0.20
)
```

![](data:image/png;base64...)

# Plotting and annotating on the `plotgardener` page

To build complex, multi-panel `plotgardener` figures with annotations, we must:

1. Create a `plotgardener` coordinate page with `pageCreate()`.

```
pageCreate(width = 3.25, height = 3.25, default.units = "inches")
```

![](data:image/png;base64...)

2. Provide values for the placement arguments (`x`, `y`, `width`, `height`, `just`, `default.units`) in plotting functions and save the output of the plotting function.

```
data("IMR90_HiC_10kb")
hicPlot <- plotHicSquare(
    data = IMR90_HiC_10kb,
    chrom = "chr21", chromstart = 28000000, chromend = 30300000,
    assembly = "hg19",
    x = 0.25, y = 0.25, width = 2.5, height = 2.5, default.units = "inches"
)
```

![](data:image/png;base64...)

3. Annotate `plotgardener` plot objects by passing them into the `plot` argument of annotation functions.

```
annoHeatmapLegend(
    plot = hicPlot,
    x = 2.85, y = 0.25, width = 0.1, height = 1.25, default.units = "inches"
)

annoGenomeLabel(
    plot = hicPlot,
    x = 0.25, y = 2.75, width = 2.5, height = 0.25, default.units = "inches"
)
```

![](data:image/png;base64...)

For more information about how to place plots and annotations on a `plotgardener` page, check out the section [Working with plot objects](https://phanstiellab.github.io/plotgardener/articles/guides/plotgardener_page.html#working-with-plot-objects).

# Exporting plots

When a `plotgardener` plot is ready to be saved and exported, we can first remove all page guides that were made with `pageCreate()`:

```
pageGuideHide()
```

![](data:image/png;base64...)

We can then either use the **Export** toggle in the RStudio plot panel, or save the plot within our R code as follows:

```
pdf(width = 3.25, height = 3.25)

pageCreate(width = 3.25, height = 3.25, default.units = "inches")
data("IMR90_HiC_10kb")
hicPlot <- plotHicSquare(
    data = IMR90_HiC_10kb,
    chrom = "chr21", chromstart = 28000000, chromend = 30300000,
    assembly = "hg19",
    x = 0.25, y = 0.25, width = 2.5, height = 2.5, default.units = "inches"
)
annoHeatmapLegend(
    plot = hicPlot,
    x = 2.85, y = 0.25, width = 0.1, height = 1.25, default.units = "inches"
)

annoGenomeLabel(
    plot = hicPlot,
    x = 0.25, y = 2.75, width = 2.5, height = 0.25, default.units = "inches"
)
pageGuideHide()

dev.off()
```

**Please note that due to the implementation of `grid` removal functions,** **using `pageGuideHide` within a `pdf` call will result in the rendering of a** **separate, new page with the plot guides removed. To avoid this artifact,** **hide guides in the `pageCreate` function call with `showGuides = FALSE`.**

For more detailed usage and examples, please refer to the other available vignettes.

# Future Directions

We still have many ideas to add for a second version of `plotgardener` including, but not limited to: grammar of graphics style plot arguments and plot building, templates, themes, and multi-plotting functions. If you have suggestions for ways we can improve `plotgardener`, please let us know!

# Session Info

```
sessionInfo()
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
## [1] stats4    grid      stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] org.Hs.eg.db_3.22.0
##  [2] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
##  [3] GenomicFeatures_1.62.0
##  [4] AnnotationDbi_1.72.0
##  [5] Biobase_2.70.0
##  [6] GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0
##  [8] IRanges_2.44.0
##  [9] S4Vectors_0.48.0
## [10] BiocGenerics_0.56.0
## [11] generics_0.1.4
## [12] plotgardenerData_1.15.0
## [13] plotgardener_1.16.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] farver_2.1.2                blob_1.2.4
##  [5] Biostrings_2.78.0           S7_0.2.0
##  [7] bitops_1.0-9                fastmap_1.2.0
##  [9] RCurl_1.98-1.17             GenomicAlignments_1.46.0
## [11] XML_3.99-0.19               digest_0.6.37
## [13] lifecycle_1.0.4             plyranges_1.30.0
## [15] KEGGREST_1.50.0             RSQLite_2.4.3
## [17] magrittr_2.0.4              compiler_4.5.1
## [19] rlang_1.1.6                 sass_0.4.10
## [21] tools_4.5.1                 yaml_2.3.10
## [23] data.table_1.17.8           rtracklayer_1.70.0
## [25] knitr_1.50                  S4Arrays_1.10.0
## [27] bit_4.6.0                   curl_7.0.0
## [29] DelayedArray_0.36.0         RColorBrewer_1.1-3
## [31] abind_1.4-8                 BiocParallel_1.44.0
## [33] withr_3.0.2                 purrr_1.1.0
## [35] Rhdf5lib_1.32.0             ggplot2_4.0.0
## [37] scales_1.4.0                dichromat_2.0-0.1
## [39] SummarizedExperiment_1.40.0 cli_3.6.5
## [41] rmarkdown_2.30              crayon_1.5.3
## [43] httr_1.4.7                  rjson_0.2.23
## [45] DBI_1.2.3                   cachem_1.1.0
## [47] rhdf5_2.54.0                parallel_4.5.1
## [49] ggplotify_0.1.3             XVector_0.50.0
## [51] restfulr_0.0.16             matrixStats_1.5.0
## [53] yulab.utils_0.2.1           vctrs_0.6.5
## [55] Matrix_1.7-4                jsonlite_2.0.0
## [57] gridGraphics_0.5-1          bit64_4.6.0-1
## [59] strawr_0.0.92               jquerylib_0.1.4
## [61] glue_1.8.0                  codetools_0.2-20
## [63] gtable_0.3.6                GenomeInfoDb_1.46.0
## [65] BiocIO_1.20.0               UCSC.utils_1.6.0
## [67] tibble_3.3.0                pillar_1.11.1
## [69] rappdirs_0.3.3              htmltools_0.5.8.1
## [71] rhdf5filters_1.22.0         R6_2.6.1
## [73] evaluate_1.0.5              lattice_0.22-7
## [75] png_0.1-8                   Rsamtools_2.26.0
## [77] cigarillo_1.0.0             memoise_2.0.1
## [79] bslib_0.9.0                 Rcpp_1.1.0
## [81] SparseArray_1.10.0          xfun_0.53
## [83] fs_1.6.6                    MatrixGenerics_1.22.0
## [85] pkgconfig_2.0.3
```