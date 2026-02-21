# Plotting Functions and Options

In addition to the numerous plotting options available in the original [Domino](https://github.com/Elisseeff-Lab/domino), dominoSignal has added more functionality and new methods to improve visualization and interpretation of analysis results. Here, we will go over the different plotting functions available, as well as different options that can be utilized, and options for customization.

## Setup and Data Load

```
set.seed(42)
library(dominoSignal)
library(patchwork)
```

In this tutorial, we will use the domino object we built on the [Getting Started](https://fertiglab.github.io/dominoSignal/articles/dominoSignal) page. If you have not yet built a domino object, you can do so by following the instructions on the [Getting Started](https://fertiglab.github.io/dominoSignal/articles/dominoSignal) page.

Instructions to load data

```
# BiocFileCache helps with managing files across sessions
bfc <- BiocFileCache::BiocFileCache(ask = FALSE)
data_url <- "https://zenodo.org/records/10951634/files/pbmc_domino_built.rds"
tmp_path <- BiocFileCache::bfcrpath(bfc, data_url)
dom <- readRDS(tmp_path)
```

## Heatmaps

### Correlations between receptors and transcription factors

`cor_heatmap()` can be used to show the correlations calculated between receptors and transcription factors.

```
cor_heatmap(dom, title = "PBMC R-TF Correlations", column_names_gp = grid::gpar(fontsize = 8))
```

![](data:image/png;base64...)

In addition to displaying the scores for the correlations, this function can also be used to identify correlations above a certain value (using the `bool` and `bool_thresh` arguments) or to identify the combinations of receptors and transcription factors (TFs) that are connected (with argument `mark_connections`).

```
cor_heatmap(dom, bool = TRUE, bool_thresh = 0.25)
cor_heatmap(dom, bool = FALSE, mark_connections = TRUE)
```

![](data:image/png;base64...)![](data:image/png;base64...)

If only a subset of receptors or transcription factors are of interest, a vector of either (or both) can be passed to the function.

```
receptors <- c("CSF1R", "CSF3R", "CCR7", "FCER2")
tfs <- c("PAX5", "JUNB", "FOXJ3", "FOSB")
cor_heatmap(dom, feats = tfs, recs = receptors)
```

![](data:image/png;base64...)

The heatmap functions in dominoSignal are based on `ComplexHeatmap::Heatmap()` and will also accept additional arguments meant for that function. For example, while an argument for clustering rows or columns of the heatmap is not explicitly stated, they can still be passed to `ComplexHeatmap::Heatmap()` through `cor_heatmap()`.

```
cor_heatmap(dom, cluster_rows = FALSE, cluster_columns = FALSE, column_title = "Heatmap Without Clustering",
    column_names_gp = grid::gpar(fontsize = 4))
```

![](data:image/png;base64...)

### Heatmap of Transcription Factor Activation Scores

`feat_heatmap()` is used to show the transcription factor activation for features in the signaling network.

```
feat_heatmap(dom, use_raster = FALSE, row_names_gp = grid::gpar(fontsize = 4))
```

![](data:image/png;base64...)

It functions similarly to `cor_heatmap()`, with arguments to select a specific vector of features, to use a boolean view with a threshold, and to pass other arguments to `ComplexHeatmap::Heatmap()`. Specific to this function though are arguments for setting the range of values to be visualized and one to choose to normalize the scores to the max value.

```
feat_heatmap(dom, min_thresh = 0.1, max_thresh = 0.6, norm = TRUE, bool = FALSE,
    use_raster = FALSE)
feat_heatmap(dom, bool = TRUE, use_raster = FALSE)
```

![](data:image/png;base64...)![](data:image/png;base64...)

### Heatmap of Incoming Signaling for a Cluster

`incoming_signaling_heatmap()` can be used to visualize the cluster average expression of the ligands capable of activating the TFs enriched in the cluster. For example, to view the incoming signaling of the CD8 T cells:

```
incoming_signaling_heatmap(dom, "CD8_T_cell")
```

![](data:image/png;base64...)

We can also select for specific clusters of interest that are signaling to the CD8 T cells. If we are only interested in viewing the monocyte signaling:

```
incoming_signaling_heatmap(dom, "CD8_T_cell", clusts = c("CD14_monocyte", "CD16_monocyte"))
```

![](data:image/png;base64...)

As with our other heatmap functions, options are available for a minimum threshold, maximum threshold, whether to scale the values after thresholding, whether to normalize the matrix, and the ability to pass further arguments to `ComplexHeatmap::Heatmap()`.

### Heatmap of Signaling Between Clusters

`signaling_heatmap()` makes a heatmap showing the signaling strength of ligands from each cluster to receptors of each cluster based on averaged expression.

```
signaling_heatmap(dom)
```

![](data:image/png;base64...)

As with other functions, specific clusters can be selected, thresholds can be set, and normalization methods can be selected as well.

```
signaling_heatmap(dom, scale = "sqrt")
signaling_heatmap(dom, normalize = "rec_norm")
```

![](data:image/png;base64...)![](data:image/png;base64...)

## Network Plots

### Network showing L - R - TF signaling between clusters

`gene_network()` makes a network plot to display signaling in selected clusters such that ligands, receptors and features associated with those clusters are displayed as nodes with edges as linkages. To look at signaling to the CD16 Monocytes from the CD14 Monocytes:

```
gene_network(dom, clust = "CD16_monocyte", OutgoingSignalingClust = "CD14_monocyte")
```

![](data:image/png;base64...)

Options to modify this plot include adjusting scaling for the ligands and different layouts (some of which are more legible than others).

```
gene_network(dom, clust = "CD16_monocyte", OutgoingSignalingClust = "CD14_monocyte",
    lig_scale = 25, layout = "sphere")
```

![](data:image/png;base64...)

Additionally, colors can be given for select genes (for example, to highlight a specific signaling path).

```
gene_network(dom, clust = "CD16_monocyte", OutgoingSignalingClust = "CD14_monocyte",
    cols = c(CD1D = "violet", LILRB2 = "violet", FOSB = "violet"), lig_scale = 10)
```

![](data:image/png;base64...)

### Network Showing Interaction Strength Across Data

`signaling_network()` can be used to create a network plot such that nodes are clusters and the edges indicate signaling from one cluster to another.

```
signaling_network(dom)
```

![](data:image/png;base64...)

In addition to changes such as scaling, thresholds, or layouts, this plot can be modified by selecting incoming or outgoing clusters (or both!). An example to view signaling from the CD14 Monocytes to other clusters:

```
signaling_network(dom, showOutgoingSignalingClusts = "CD14_monocyte", scale = "none",
    norm = "none", layout = "fr", scale_by = "none", edge_weight = 2, vert_scale = 10)
```

![](data:image/png;base64...)

## Other Types of Plots

### Chord Diagrams Connecting Ligands and Receptors

A new addition to dominoSignal, `circos_ligand_receptor()` creates a chord plot showing ligands that can activate a specific receptor, displaying mean cluster expression of the ligand with the width of the chord.

```
circos_ligand_receptor(dom, receptor = "CD74")
```

![](data:image/png;base64...)

This function can be given cluster colors to match other plots you may make with your data. In addition, the plot can be adjusted by changing the threshold of ligand expression required for a linkage to be visualized or selecting clusters of interest.

```
cols <- c("red", "orange", "green", "blue", "pink", "purple", "slategrey", "firebrick",
    "hotpink")
names(cols) <- dom_clusters(dom, labels = FALSE)
circos_ligand_receptor(dom, receptor = "CD74", cell_colors = cols)
```

![](data:image/png;base64...)

### Scatter Plot to Visualize Correlation

`cor_scatter()` can be used to plot each cell based on activation of the selected TF and expression of the receptor. This produces a scatter plot as well as a line of best fit to look at receptor - TF correlation.

```
cor_scatter(dom, "FOSB", "CD74")
```

![](data:image/png;base64...)

Do keep in mind that there is an argument for `remove_rec_dropout` that should match the parameter that was used when the domino object was built. In this case, we did not use that build parameter, so we will leave the value in this argument as its default value of FALSE.

## Continued Development

Since dominoSignal is a package still being developed, there are new functions and features that will be implemented in future versions. In the meantime, to view an example analysis, see our [Getting Started](https://fertiglab.github.io/dominoSignal/articles/dominoSignal) page, or see our [domino object structure](https://fertiglab.github.io/dominoSignal/articles/domino_object_vignette) page to get familiar with the object structure. Additionally, if you find any bugs, have further questions, or want to share an idea, please let us know [here](https://github.com/FertigLab/dominoSignal/issues).

Vignette Build Information Date last built and session information:

```
Sys.Date()
#> [1] "2025-10-29"
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
#> [1] grid      stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] patchwork_1.3.2             knitr_1.50
#>  [3] ComplexHeatmap_2.26.0       circlize_0.4.16
#>  [5] plyr_1.8.9                  SingleCellExperiment_1.32.0
#>  [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
#> [11] IRanges_2.44.0              S4Vectors_0.48.0
#> [13] BiocGenerics_0.56.0         generics_0.1.4
#> [15] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [17] dominoSignal_1.4.0
#>
#> loaded via a namespace (and not attached):
#>  [1] DBI_1.2.3            httr2_1.2.1          formatR_1.14
#>  [4] biomaRt_2.66.0       rlang_1.1.6          magrittr_2.0.4
#>  [7] clue_0.3-66          GetoptLong_1.0.5     compiler_4.5.1
#> [10] RSQLite_2.4.3        mgcv_1.9-3           png_0.1-8
#> [13] vctrs_0.6.5          stringr_1.5.2        pkgconfig_2.0.3
#> [16] shape_1.4.6.1        crayon_1.5.3         fastmap_1.2.0
#> [19] magick_2.9.0         backports_1.5.0      dbplyr_2.5.1
#> [22] XVector_0.50.0       labeling_0.4.3       rmarkdown_2.30
#> [25] purrr_1.1.0          bit_4.6.0            xfun_0.53
#> [28] cachem_1.1.0         jsonlite_2.0.0       progress_1.2.3
#> [31] blob_1.2.4           DelayedArray_0.36.0  broom_1.0.10
#> [34] parallel_4.5.1       prettyunits_1.2.0    cluster_2.1.8.1
#> [37] R6_2.6.1             bslib_0.9.0          stringi_1.8.7
#> [40] RColorBrewer_1.1-3   car_3.1-3            jquerylib_0.1.4
#> [43] Rcpp_1.1.0           iterators_1.0.14     splines_4.5.1
#> [46] Matrix_1.7-4         igraph_2.2.1         tidyselect_1.2.1
#> [49] dichromat_2.0-0.1    abind_1.4-8          yaml_2.3.10
#> [52] doParallel_1.0.17    codetools_0.2-20     curl_7.0.0
#> [55] lattice_0.22-7       tibble_3.3.0         withr_3.0.2
#> [58] KEGGREST_1.50.0      S7_0.2.0             evaluate_1.0.5
#> [61] BiocFileCache_3.0.0  Biostrings_2.78.0    pillar_1.11.1
#> [64] ggpubr_0.6.2         filelock_1.0.3       carData_3.0-5
#> [67] foreach_1.5.2        hms_1.1.4            ggplot2_4.0.0
#> [70] scales_1.4.0         glue_1.8.0           tools_4.5.1
#> [73] ggsignif_0.6.4       Cairo_1.7-0          tidyr_1.3.1
#> [76] AnnotationDbi_1.72.0 colorspace_2.1-2     nlme_3.1-168
#> [79] Formula_1.2-5        cli_3.6.5            rappdirs_0.3.3
#> [82] S4Arrays_1.10.0      dplyr_1.1.4          gtable_0.3.6
#> [85] rstatix_0.7.3        sass_0.4.10          digest_0.6.37
#> [88] SparseArray_1.10.0   rjson_0.2.23         farver_2.1.2
#> [91] memoise_2.0.1        htmltools_0.5.8.1    lifecycle_1.0.4
#> [94] httr_1.4.7           GlobalOptions_0.1.2  bit64_4.6.0-1
```