# Quality control and visualisation with SPIAT

Yuzhou Feng

#### 2026-02-03

#### Package

SPIAT 1.12.1

First we load the SPIAT library.

```
library(SPIAT)
```

Here we present some quality control steps implemented in SPIAT to check
for the quality of phenotyping, help detect uneven staining, and other
potential technical artefacts.

In this vignette we will use an inForm data file that’s already been
formatted for SPIAT with `format_image_to_spe()`, which we can load with
`data()`. We will use `define_celltypes()` to define the cells with certain
combinations of markers.

```
data("simulated_image")

# define cell types
formatted_image <- define_celltypes(
    simulated_image,
    categories = c("Tumour_marker","Immune_marker1,Immune_marker2",
                   "Immune_marker1,Immune_marker3",
                   "Immune_marker1,Immune_marker2,Immune_marker4", "OTHER"),
    category_colname = "Phenotype",
    names = c("Tumour", "Immune1", "Immune2", "Immune3", "Others"),
    new_colname = "Cell.Type")
```

# 1 Visualise marker levels

## 1.1 Boxplots of marker intensities

Phenotyping of cells can be verified comparing marker intensities of
cells labelled positive and negative for a marker. Cells positive for a
marker should have high levels of the marker. An unclear separation of
marker intensities between positive and negative cells would suggest
phenotypes have not been accurately assigned. We can use
`marker_intensity_boxplot()` to produce a boxplot for cells phenotyped as
being positive or negative for a marker.

```
marker_intensity_boxplot(formatted_image, "Immune_marker1")
```

![](data:image/png;base64...)

Note that if phenotypes were obtained from software that uses machine
learning to determine positive cells, which generally also take into
account properties such as cell shape, nucleus size etc., rather than a
strict threshold, some negative cells will have high marker intensities,
and vice versa. In general, a limited overlap of whiskers or outlier
points is tolerated and expected. However, overlapping boxplots suggests
unreliable phenotyping.

## 1.2 Scatter plots of marker levels

Uneven marker staining or high background intensity can be identified
with `plot_cell_marker_levels()`. This produces a scatter plot of the
intensity of a marker in each cell. This should be relatively even
across the image and all phenotyped cells. Cells that were not
phenotyped as being positive for the particular marker are excluded.

```
plot_cell_marker_levels(formatted_image, "Immune_marker1")
```

![](data:image/png;base64...)

## 1.3 Heatmaps of marker levels

For large images, there is also the option of ‘blurring’ the image,
where the image is split into multiple small areas, and marker
intensities are averaged within each. The image is blurred based on the
`num_splits` parameter.

```
plot_marker_level_heatmap(formatted_image, num_splits = 100, "Tumour_marker")
```

![](data:image/png;base64...)

# 2 Identifying incorrect phenotypes

We may see cells with biologically implausible combination of markers
present in the input data when using `unique(spe_object$Phenotype)`.
For example, cells might be incorrectly typed as positive for two markers known
to not co-occur in a single cell type. Incorrect cell phenotypes may be present
due to low cell segmentation quality, antibody ‘bleeding’ from one cell
to another or inadequate marker thresholding.

If the number of incorrectly phenotyped cells is small (<5%), we advise
simply removing these cells (see below). If it is a higher proportion,
we recommend checking the cell segmentation and phenotyping methods, as
a more systematic problem might be present.

## 2.1 Removing cells with incorrect phenotypes

If you identify incorrect phenotypes or have any properties (columns) that you
want to exclude you can use `select_celltypes()`. Set `celltypes` the values
that you want to keep or exclude for a column (`feature_colname`). Set `keep`
as `TRUE` to include these cells and `FALSE` to exclude them.

```
data_subset <- select_celltypes(
  formatted_image, keep=TRUE,
  celltypes = c("Tumour_marker","Immune_marker1,Immune_marker3",
                "Immune_marker1,Immune_marker2",
                "Immune_marker1,Immune_marker2,Immune_marker4"),
  feature_colname = "Phenotype")
# have a look at what phenotypes are present
unique(data_subset$Phenotype)
```

```
## [1] "Immune_marker1,Immune_marker2"
## [2] "Tumour_marker"
## [3] "Immune_marker1,Immune_marker2,Immune_marker4"
## [4] "Immune_marker1,Immune_marker3"
```

In this vignette we will work with all the original phenotypes present
in `formatted_image`.

## 2.2 Dimensionality reduction to identify misclassified cells

We can also check for specific misclassified cells using dimensionality
reduction. SPIAT offers tSNE and UMAPs based on marker intensities to
visualise cells. Cells of distinct types should be forming clearly
different clusters.

The generated dimensionality reduction plots are interactive, and users
can hover over each cell and obtain the cell ID. Users can then remove
specific misclassified cells.

```
# First predict the phenotypes (this is for generating not 100% accurate phenotypes)
predicted_image2 <- predict_phenotypes(spe_object = simulated_image,
                                      thresholds = NULL,
                                      tumour_marker = "Tumour_marker",
                                      baseline_markers = c("Immune_marker1",
                                                           "Immune_marker2",
                                                           "Immune_marker3",
                                                           "Immune_marker4"),
                                      reference_phenotypes = FALSE)
```

```
## [1] "Tumour_marker  threshold intensity:  0.445450443784465"
```

![](data:image/png;base64...)

```
## [1] "Immune_marker1  threshold intensity:  0.116980867970434"
```

![](data:image/png;base64...)

```
## [1] "Immune_marker2  threshold intensity:  0.124283809517202"
```

![](data:image/png;base64...)

```
## [1] "Immune_marker3  threshold intensity:  0.0166413130263845"
```

![](data:image/png;base64...)

```
## [1] "Immune_marker4  threshold intensity:  0.00989731350898589"
```

![](data:image/png;base64...)

```
# Then define the cell types based on predicted phenotypes
predicted_image2 <- define_celltypes(
  predicted_image2,
  categories = c("Tumour_marker", "Immune_marker1,Immune_marker2",
                 "Immune_marker1,Immune_marker3",
                 "Immune_marker1,Immune_marker2,Immune_marker4"),
  category_colname = "Phenotype",
  names = c("Tumour", "Immune1", "Immune2",  "Immune3"),
  new_colname = "Cell.Type")

# Delete cells with unrealistic marker combinations from the dataset
predicted_image2 <-
  select_celltypes(predicted_image2, "Undefined", feature_colname = "Cell.Type",
                   keep = FALSE)

# TSNE plot
g <- dimensionality_reduction_plot(predicted_image2, plot_type = "TSNE",
                                   feature_colname = "Cell.Type")
```

Note that `dimensionality_reduction_plot()` only prints a static version
of the UMAP or tSNE plot. If the user wants to interact with this plot,
they can pass the result to the `ggplotly()` function from the `plotly`
package. Due to the file size restriction, we only show a screenshot of
the interactive tSNE plot.

```
plotly::ggplotly(g)
```

![](data:image/jpeg;base64...)

The plot shows that there are four clear clusters based on marker
intensities. This is consistent with the cell definition from the marker
combinations from the “Phenotype” column. (The interactive t-SNE plot
would allow users to hover the cursor on the misclassified cells and see
their cell IDs.) In this example, Cell\_3302, Cell\_4917, Cell\_2297,
Cell\_488, Cell\_4362, Cell\_4801, Cell\_2220, Cell\_3431, Cell\_533,
Cell\_4925, Cell\_4719, Cell\_469, Cell\_1929, Cell\_310, Cell\_2536,
Cell\_321, and Cell\_4195 are obviously misclassified according to this
plot.

We can use `select_celltypes()` to delete the misclassified cells.

```
predicted_image2 <-
  select_celltypes(predicted_image2, c("Cell_3302", "Cell_4917", "Cell_2297",
                                       "Cell_488", "Cell_4362", "Cell_4801",
                                       "Cell_2220", "Cell_3431", "Cell_533",
                                       "Cell_4925", "Cell_4719", "Cell_469",
                                       "Cell_1929", "Cell_310", "Cell_2536",
                                       "Cell_321", "Cell_4195"),
                   feature_colname = "Cell.ID", keep = FALSE)
```

Then plot the TSNE again (not interactive). This time we see there are
fewer misclassified cells.

```
# TSNE plot
g <- dimensionality_reduction_plot(predicted_image2, plot_type = "TSNE", feature_colname = "Cell.Type")

# plotly::ggplotly(g) # uncomment this code to interact with the plot
```

![](data:image/jpeg;base64...)

# 3 Visualising tissues

In addition to the marker level tissue plots for QC, SPIAT has other
methods for visualising markers and phenotypes in tissues.

## 3.1 Categorical dot plot

We can see the location of all cell types (or any column in the data) in
the tissue with `plot_cell_categories()`. Each dot in the plot corresponds
to a cell and cells are coloured by cell type. Any cell types present in
the data but not in the cell types of interest will be put in the
category “OTHER” and coloured lightgrey.

```
my_colors <- c("red", "blue", "darkcyan", "darkgreen")

plot_cell_categories(spe_object = formatted_image,
                     categories_of_interest =
                       c("Tumour", "Immune1", "Immune2", "Immune3"),
                     colour_vector = my_colors, feature_colname = "Cell.Type")
```

![](data:image/png;base64...)

`plot_cell_categories()` also allows the users to plot the categories layer by
layer when there are too many cells by setting `layered` parameter as `TRUE`.
Then the cells will be plotted in the order of `categories_of_interest` layer
by layer. Users can also use `cex` parameter to change the size of the points.

## 3.2 3D surface plot

We can visualise a selected marker in 3D with `marker_surface_plot()`. The
image is blurred based on the `num_splits` parameter.

```
marker_surface_plot(formatted_image, num_splits=15, marker="Immune_marker1")
```

Due to the restriction of the file size, we have disabled the
interactive plot in this vignette. Here only shows a screen shot. (You
can interactively move the plot around to obtain a better view with the
same code).

![](data:image/jpeg;base64...)

## 3.3 3D stacked surface plot

To visualise multiple markers in 3D in a single plot we can use
`marker_surface_plot_stack()`. This shows normalised intensity level of
specified markers and enables the identification of co-occurring and
mutually exclusive markers.

```
marker_surface_plot_stack(formatted_image, num_splits=15, markers=c("Tumour_marker", "Immune_marker1"))
```

![](data:image/jpeg;base64...)

The stacked surface plots of the Tumour\_marker and Immune\_marker1 cells
in this example shows how Tumour\_marker and Immune\_marker1 are mutually
exclusive as the peaks and valleys are opposite. Similar to the previous
plot, we have disabled the interactive plot in the vignette. (You can
interactively move the plot around to obtain a better view with the same
code.)

# 4 You can access the vignettes for other modules of SPIAT here:

* [Overview of SPIAT](SPIAT.html)
* [Data reading and formatting](data_reading-formatting.html)
* [Basic analysis](basic_analysis.html)
* [Cell colocalisation](cell-colocalisation.html)
* [Spatial heterogeneity](spatial-heterogeneity.html)
* [Tissue structure](tissue-structure.html)
* [Cellular neighborhood](neighborhood.html)

# 5 Reproducibility

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
##  [1] SPIAT_1.12.1                SpatialExperiment_1.20.0
##  [3] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.1
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] deldir_2.0-4           gridExtra_2.3          rlang_1.1.7
##   [4] magrittr_2.0.4         clue_0.3-66            GetoptLong_1.1.0
##   [7] otel_0.2.0             ggridges_0.5.7         compiler_4.5.2
##  [10] spatstat.geom_3.7-0    png_0.1-8              vctrs_0.7.1
##  [13] reshape2_1.4.5         stringr_1.6.0          shape_1.4.6.1
##  [16] pkgconfig_2.0.3        crayon_1.5.3           fastmap_1.2.0
##  [19] magick_2.9.0           XVector_0.50.0         labeling_0.4.3
##  [22] rmarkdown_2.30         tzdb_0.5.0             pracma_2.4.6
##  [25] purrr_1.2.1            tinytex_0.58           bit_4.6.0
##  [28] xfun_0.56              cachem_1.1.0           jsonlite_2.0.0
##  [31] goftest_1.2-3          DelayedArray_0.36.0    spatstat.utils_3.2-1
##  [34] cluster_2.1.8.1        parallel_4.5.2         R6_2.6.1
##  [37] bslib_0.10.0           stringi_1.8.7          RColorBrewer_1.1-3
##  [40] spatstat.data_3.1-9    spatstat.univar_3.1-6  jquerylib_0.1.4
##  [43] iterators_1.0.14       Rcpp_1.1.1             bookdown_0.46
##  [46] knitr_1.51             tensor_1.5.1           Matrix_1.7-4
##  [49] tidyselect_1.2.1       dichromat_2.0-0.1      abind_1.4-8
##  [52] yaml_2.3.12            codetools_0.2-20       doParallel_1.0.17
##  [55] spatstat.random_3.4-4  spatstat.explore_3.7-0 lattice_0.22-7
##  [58] tibble_3.3.1           plyr_1.8.9             withr_3.0.2
##  [61] S7_0.2.1               Rtsne_0.17             evaluate_1.0.5
##  [64] polyclip_1.10-7        circlize_0.4.17        pillar_1.11.1
##  [67] BiocManager_1.30.27    foreach_1.5.2          plotly_4.12.0
##  [70] dbscan_1.2.4           vroom_1.7.0            ggplot2_4.0.2
##  [73] scales_1.4.0           gtools_3.9.5           apcluster_1.4.14
##  [76] glue_1.8.0             lazyeval_0.2.2         pheatmap_1.0.13
##  [79] tools_4.5.2            data.table_1.18.2.1    dittoSeq_1.22.0
##  [82] RANN_2.6.2             Cairo_1.7-0            cowplot_1.2.0
##  [85] grid_4.5.2             tidyr_1.3.2            crosstalk_1.2.2
##  [88] colorspace_2.1-2       nlme_3.1-168           mmand_1.6.3
##  [91] cli_3.6.5              spatstat.sparse_3.1-0  S4Arrays_1.10.1
##  [94] viridisLite_0.4.2      ComplexHeatmap_2.26.1  dplyr_1.2.0
##  [97] gtable_0.3.6           sass_0.4.10            digest_0.6.39
## [100] SparseArray_1.10.8     ggrepel_0.9.6          htmlwidgets_1.6.4
## [103] rjson_0.2.23           farver_2.1.2           htmltools_0.5.9
## [106] lifecycle_1.0.5        httr_1.4.7             GlobalOptions_0.1.3
## [109] bit64_4.6.0-1
```

# 6 Author Contributions

AT, YF, TY, ML, JZ, VO, MD are authors of the package code. MD and YF
wrote the vignette. AT, YF and TY designed the package.