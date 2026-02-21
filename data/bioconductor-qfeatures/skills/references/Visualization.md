# Data visualization from a QFeatures object

Laurent Gatto

#### 30 October 2025

#### Abstract

This vignette describes how to visualize quantitative mass spectrometry data contained in a QFeatures object. This vignette is distributed under a CC BY-SA license.

#### Package

QFeatures 1.20.0

# 1 Preparing the data

To demonstrate the data visualization of `QFeatures`, we first perform
a quick processing of the `hlpsms` example data. We load the data and
read it as a `QFeautres` object. See the processing
[vignette](https://rformassspectrometry.github.io/QFeatures/articles/Processing.html)
for more details about data processing with `QFeatures`.

```
library("QFeatures")
data(hlpsms)
hl <- readQFeatures(hlpsms, quantCols = 1:10, name = "psms")
```

We then aggregate the psms to peptides, and the peptodes to proteins.

```
hl <- aggregateFeatures(hl, "psms", "Sequence", name = "peptides", fun = colMeans)
```

```
## Your row data contain missing values. Please read the relevant
## section(s) in the aggregateFeatures manual page regarding the effects
## of missing values on data aggregation.
```

```
##
Aggregated: 1/1
```

```
hl <- aggregateFeatures(hl, "peptides", "ProteinGroupAccessions", name = "proteins", fun = colMeans)
```

```
##
Aggregated: 1/1
```

We also add the TMT tags that were used to multiplex the samples. The
data is added to the `colData` of the `QFeatures` object and will
allow us to demonstrate how to plot data from the `colData`.

```
hl$tag <- c("126", "127N", "127C", "128N", "128C", "129N", "129C",
            "130N", "130C", "131")
```

The dataset is now ready for data exploration.

# 2 Exploring the `QFeatures` hierarchy

`QFeatures` objects can contain several assays as the data goes through
the processing workflow. The `plot` function provides an overview of
all the assays present in the dataset, showing also the hierarchical
relationships between the assays as determined by the `AssayLinks`.

```
plot(hl)
```

![](data:image/png;base64...)

This plot is rather simple with only three assays, but some processing
workflows may involve more steps. The `feat3` example data illustrates
the different possible relationships: one parent to one child, multiple
parents to one child and one parent to multiple children.

```
data("feat3")
plot(feat3)
```

![](data:image/png;base64...)

Note that some datasets may contain many assays, for instance because
the MS experiment consists of hundreds of batches. This can lead to an
overcrowded plot. Therefore, you can also explore this hierarchy of
assays through an interactive plot, supported by the `plotly` package
(Sievert ([2020](#ref-Sievert2020))). You can use the viewer panel to zoom in and out and
navigate across the tree(s).

```
plot(hl, interactive = TRUE)
```

# 3 Basic data exploration

The quantitative data is retrieved using `assay()`, the feature
metadata is retrieved using `rowData()` on the assay of interest, and
the sample metadata is retrieved using `colData()`. Once retrieved,
the data can be supplied to the base R data exploration tools. Here
are some examples:

* Plot the intensities for the first protein. These data are available
  from the `proteins` assay.

```
plot(assay(hl, "proteins")[1, ])
```

![](data:image/png;base64...)

* Get the distribution of the number of peptides that were aggregated
  per protein. These data are available in the column `.n` from the
  protein `rowData`.

```
hist(rowData(hl)[["proteins"]]$.n)
```

![](data:image/png;base64...)

* Get the count table of the different tags used for labeling the
  samples. These data are available in the column `tag` from the
  `colData`.

```
table(hl$tag)
```

```
##
##  126 127C 127N 128C 128N 129C 129N 130C 130N  131
##    1    1    1    1    1    1    1    1    1    1
```

# 4 Using `ggplot2`

`ggplot2` is a powerful tool for data visualization in `R` and is part
of the `tidyverse` package ecosystem (Wickham et al. ([2019](#ref-Wickham2019-fz))). It produces
elegant and publication-ready plots in a few lines of code. `ggplot2`
can be used to explore `QFeatures` object, similarly to the base
functions shown above. Note that `ggplot2` expects `data.frame` or
`tibble` objects whereas the quantitative data in `QFeatures` are
encoded as `matrix` (or matrix-like objects, see
`?SummarizedExperiment`) and the `rowData` and `colData` are encoded
as `DataFrame`. This is easily circumvented by converting those
objects to `data.frame`s or `tibble`s. See here how we reproduce the
plot above using `ggplot2`.

```
library("ggplot2")
df <- data.frame(rowData(hl)[["proteins"]])
ggplot(df) +
    aes(x = .n) +
    geom_histogram()
```

![](data:image/png;base64...)

We refer the reader to the `ggplot2`
[package website](https://ggplot2.tidyverse.org/) for more information
about the wide variety of functions that the package offers and for
tutorials and cheatsheets.

Another useful package for quantitative data exploration is
`ComplexHeatmap` (Gu, Eils, and Schlesner ([2016](#ref-Gu2016-ej))). It is part of the Bioconductor project
(Gentleman et al. ([2004](#ref-Gentleman:2004))) and facilitates visualization of matrix objects as
heatmap. See here an example where we plot the protein data.

```
library(ComplexHeatmap)
Heatmap(matrix = assay(hl, "proteins"),
        show_row_names = FALSE)
```

![](data:image/png;base64...)

`ComplexHeatmap` also allows to add row and/or column annotations.
Let’s add the predicted protein location as row annotation.

```
ha <- rowAnnotation(markers = rowData(hl)[["proteins"]]$markers)
Heatmap(matrix = assay(hl, "proteins"),
        show_row_names = FALSE,
        left_annotation = ha)
```

![](data:image/png;base64...)

More advanced usage of `ComplexHeatmap` is described in the package
reference [book](https://jokergoo.github.io/ComplexHeatmap-reference/book/).

# 5 Advanced data exploration

In this section, we show how to combine in a single table different
pieces of information available in a `QFeatures` object, that are
quantitation data, feature metadata and sample metadata. The
`QFeatures` package provides the `longForm()` function that converts a
`QFeatures` object into a long table. Long tables are very useful when
using `ggplot2` for data visualization. For instance, suppose we want
to visualize the distribution of protein quantitation (present in the
`proteins` assay) with respect to the different acquisition tags
(present in the `colData`) for each predicted cell location separately
(present in the `rowData` of the assays). Furthermore, we link the
quantitation values coming from the same protein using lines. This can
all be plotted at once in a few lines of code.

```
lf <- longForm(hl[, , "proteins"],
               rowvars = "markers",
               colvars = "tag")
```

```
## Warning: 'experiments' dropped; see 'drops()'
```

```
## harmonizing input:
##   removing 20 sampleMap rows not in names(experiments)
```

```
ggplot(data.frame(lf)) +
    aes(x = tag,
        y = value,
        group = rowname) +
    geom_line() +
    facet_wrap(~ markers, scales = "free_y", ncol = 3)
```

![](data:image/png;base64...)

`longForm()` allows to retrieve and combine all available data from a
`Qfeatures` object. We here demonstrate the ease to combine different
pieces that could highlight sample specific and/or feature specific
effects on data quantitation.

# 6 Interactive data exploration

Finally, a simply `shiny` app allows to explore and visualise the
respective assays of a `QFeatures` object.

```
display(hl)
```

![`QFeatures` interactive interface: heatmap of the peptide assay data.](data:image/png;base64...)

Figure 1: `QFeatures` interactive interface: heatmap of the peptide assay data

![`QFeatures` interactive interface: quantitative peptide assay data.](data:image/png;base64...)

Figure 2: `QFeatures` interactive interface: quantitative peptide assay data

![`QFeatures` interactive interface: peptide assay row data](data:image/png;base64...)

Figure 3: `QFeatures` interactive interface: peptide assay row data

A dropdown menu in the side bar allows the user to select an assay of
interest, which can then be visualised as a heatmap (figure
[1](#fig:heatmapdisplay)), as a quantitative table (figure
[2](#fig:assaydisplay)) or a row data table (figure
[3](#fig:rowdatadisplay)).

# Session information

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] ComplexHeatmap_2.26.0       gplots_3.2.0
##  [3] dplyr_1.1.4                 ggplot2_4.0.0
##  [5] QFeatures_1.20.0            MultiAssayExperiment_1.36.0
##  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [11] IRanges_2.44.0              S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0         generics_0.1.4
## [15] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [17] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1        farver_2.1.2            S7_0.2.0
##  [4] bitops_1.0-9            fastmap_1.2.0           lazyeval_0.2.2
##  [7] digest_0.6.37           lifecycle_1.0.4         cluster_2.1.8.1
## [10] Cairo_1.7-0             ProtGenerics_1.42.0     statmod_1.5.1
## [13] magrittr_2.0.4          compiler_4.5.1          rlang_1.1.6
## [16] sass_0.4.10             tools_4.5.1             igraph_2.2.1
## [19] yaml_2.3.10             knitr_1.50              S4Arrays_1.10.0
## [22] labeling_0.4.3          DelayedArray_0.36.0     plyr_1.8.9
## [25] RColorBrewer_1.1-3      abind_1.4-8             KernSmooth_2.23-26
## [28] withr_3.0.2             purrr_1.1.0             caTools_1.18.3
## [31] colorspace_2.1-2        iterators_1.0.14        scales_1.4.0
## [34] gtools_3.9.5            MASS_7.3-65             dichromat_2.0-0.1
## [37] tinytex_0.57            cli_3.6.5               crayon_1.5.3
## [40] rmarkdown_2.30          rjson_0.2.23            reshape2_1.4.4
## [43] BiocBaseUtils_1.12.0    cachem_1.1.0            stringr_1.5.2
## [46] parallel_4.5.1          AnnotationFilter_1.34.0 BiocManager_1.30.26
## [49] XVector_0.50.0          vctrs_0.6.5             Matrix_1.7-4
## [52] jsonlite_2.0.0          bookdown_0.45           GetoptLong_1.0.5
## [55] clue_0.3-66             magick_2.9.0            foreach_1.5.2
## [58] limma_3.66.0            tidyr_1.3.1             jquerylib_0.1.4
## [61] glue_1.8.0              codetools_0.2-20        shape_1.4.6.1
## [64] stringi_1.8.7           gtable_0.3.6            tibble_3.3.0
## [67] pillar_1.11.1           htmltools_0.5.8.1       circlize_0.4.16
## [70] R6_2.6.1                doParallel_1.0.17       evaluate_1.0.5
## [73] lattice_0.22-7          png_0.1-8               msdata_0.49.0
## [76] bslib_0.9.0             Rcpp_1.1.0              SparseArray_1.10.0
## [79] xfun_0.53               GlobalOptions_0.1.2     MsCoreUtils_1.22.0
## [82] pkgconfig_2.0.3
```

# License

This vignette is distributed under a
[CC BY-SA license](https://creativecommons.org/licenses/by-sa/2.0/)
license.

# References

Gentleman, Robert C., Vincent J. Carey, Douglas M. Bates, Ben Bolstad, Marcel Dettling, Sandrine Dudoit, Byron Ellis, et al. 2004. “Bioconductor: Open Software Development for Computational Biology and Bioinformatics.” *Genome Biol* 5 (10): –80. <https://doi.org/10.1186/gb-2004-5-10-r80>.

Gu, Zuguang, Roland Eils, and Matthias Schlesner. 2016. “Complex Heatmaps Reveal Patterns and Correlations in Multidimensional Genomic Data.” *Bioinformatics* 32 (18): 2847–9.

Sievert, Carson. 2020. *Interactive Web-Based Data Visualization with R, Plotly, and Shiny*. Chapman; Hall/CRC. <https://plotly-r.com>.

Wickham, Hadley, Mara Averick, Jennifer Bryan, Winston Chang, Lucy McGowan, Romain François, Garrett Grolemund, et al. 2019. “Welcome to the Tidyverse.” *J. Open Source Softw.* 4 (43): 1686.