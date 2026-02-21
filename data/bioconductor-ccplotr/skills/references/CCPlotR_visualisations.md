# Generating visualisations of cell-cell interactions with CCPlotR

Sarah Ennis1, Pilib Ó Broin1 and Eva Szegezdi1

1University of Galway

#### 29 October 2025

# 1 Introduction

This guide provides an overview of the CCPlotR package, a small R package for visualising results from tools that predict cell-cell interactions from scRNA-seq data.

## 1.1 Motivation

Predicting cell-cell interactions from scRNA-seq data is now a common component of a single-cell analysis workflow (Armingol et al. ([2021](#ref-armingol_deciphering_2021)), Almet et al. ([2021](#ref-almet_landscape_2021))). There have been many tools published in recent years specifically for this purpose (Dimitrov et al. ([2022](#ref-dimitrov_comparison_2022)), Efremova et al. ([2020](#ref-efremova_cellphonedb_2020)), Hou et al. ([2020](#ref-hou_predicting_2020)), Jin et al. ([2021](#ref-jin_inference_2021))). These tools typically return a table of predicted interactions that depicts the sending and receiving cell type, the ligand and receptor genes and some sort of score for ranking the interactions. These tables can be quite large and depending on the amount of cell types included in the analysis, this data can get pretty complex and challenging to visualise. Many tools for predicting cell-cell interactions have built-in visualisation methods but some don’t and it can be time consuming and impractical to install some of these methods just for the purpose of visualising the results if you’re using a different tool to predict the interactions. For these reasons, we have developed a lightweight R package that allows the user to easily generate visualisations of cell-cell interactions with minimal code, regardless of which tool was used for predicting the interactions.

## 1.2 Installation

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("CCPlotR")

## or for development version:

devtools::install_github("Sarah145/CCPlotR")
```

# 2 Input

CCPlotR makes generic plots that can be used to visualise results from multiple tools such as Liana, CellPhoneDB, NATMI etc. All it requires as input is a dataframe with columns `source`, `target`, `ligand`, `receptor` and `score`. It should look something like this:

| source | target | ligand | receptor | score |
| --- | --- | --- | --- | --- |
| B | CD8 T | HLA-DQA1 | LAG3 | 7.22 |
| B | CD8 T | HLA-DRA | LAG3 | 5.59 |
| CD8 T | NK | B2M | KIR2DL3 | 5.52 |
| B | CD8 T | HLA-DQA2 | LAG3 | 5.41 |
| NK | B | LGALS1 | CD69 | 4.15 |
| B | CD8 T | ICAM3 | ITGAL | 2.34 |

For some of the plots, there is an option to also show the expression of the ligands and receptors in each cell type. For those plots, a second dataframe is required, which holds the mean expression values for each gene in each cell type and should look something like this:

| cell\_type | gene | mean\_exp |
| --- | --- | --- |
| B | ACTR2 | 0.363 |
| B | ADA | 0.0170 |
| B | ADAM10 | 0.0833 |
| B | ADAM28 | 0.487 |
| B | ADCY7 | 0.0336 |
| B | ADRB2 | 0.0178 |

The package comes with toy datasets (`toy_data`, `toy_exp`) which you can see for examples of input data.

```
library(CCPlotR)
data(toy_data, toy_exp, package = 'CCPlotR')
head(toy_data)
#> # A tibble: 6 × 5
#>   source target ligand   receptor score
#>   <chr>  <chr>  <chr>    <chr>    <dbl>
#> 1 B      CD8 T  HLA-DQA1 LAG3      7.22
#> 2 B      CD8 T  HLA-DRA  LAG3      5.59
#> 3 B      CD8 T  HLA-DQB1 LAG3      5.59
#> 4 B      CD8 T  HLA-DQA2 LAG3      5.41
#> 5 B      CD8 T  HLA-DRB5 LAG3      5.26
#> 6 B      CD8 T  HLA-DRB1 LAG3      5.12
head(toy_exp)
#> # A tibble: 6 × 3
#> # Groups:   cell_type [1]
#>   cell_type gene   mean_exp
#>   <chr>     <chr>     <dbl>
#> 1 B         ACTR2    0.363
#> 2 B         ADA      0.0170
#> 3 B         ADAM10   0.0833
#> 4 B         ADAM28   0.487
#> 5 B         ADCY7    0.0336
#> 6 B         ADRB2    0.0178
```

# 3 Plot types

The package contains functions for making six types of plots: `cc_heatmap`, `cc_dotplot`, `cc_network`, `cc_circos`, `cc_arrow` and `cc_sigmoid`. Below are some examples of each plot type.

## 3.1 Heatmaps

The `cc_heatmap` function can generate heatmaps in four different styles. Option A just displays the total number of interactions between each pair of cell types and option B shows the ligands, receptors and cell types involved in each interaction as well as their score. For option B, only a small portion of top interactions are shown to avoid cluttering the plot. There is also an option to generate heatmaps in the style of popular cell-cell interaction prediction tools such as CellPhoneDB and Liana.

```
cc_heatmap(toy_data)
```

![](data:image/png;base64...)

```
cc_heatmap(toy_data, option = "B", n_top_ints = 10)
```

![](data:image/png;base64...)

```
cc_heatmap(toy_data, option = "CellPhoneDB")
```

![](data:image/png;base64...)

## 3.2 Dotplots

The `cc_dotplot` function can generate dotplots in four different styles. Option A just displays the total number of interactions between each pair of cell types and option B shows the ligands, receptors and cell types involved in each interaction as well as their score. For option B, only a small portion of top interactions are shown to avoid cluttering the plot. There is also an option to generate dotplots in the style of popular cell-cell interaction prediction tools such as CellPhoneDB and Liana.

```
cc_dotplot(toy_data)
```

![](data:image/png;base64...)

```
cc_dotplot(toy_data, option = "B", n_top_ints = 10)
```

![](data:image/png;base64...)

```
cc_dotplot(toy_data, option = "Liana", n_top_ints = 15)
```

![](data:image/png;base64...)

## 3.3 Network

The `cc_network` function can generate two different types of network plots. In option A, the nodes are cell types and the weight of the edges corresponds to the total number of interactions between a given pair of cell types. In option B, the nodes are ligand and receptor genes, coloured by which cell type is expressing them. For option B, only a small portion of top interactions are shown to avoid cluttering the plot.

```
cc_network(toy_data)
#> Warning in geom_node_label(aes(label = name, col = name), size = 6, fontface =
#> "bold", : Ignoring unknown parameters: `label.size`
#> Warning in geom_node_label(aes(label = name), size = 6, fontface = "bold", :
#> Ignoring unknown parameters: `label.size`
```

![](data:image/png;base64...)

```
cc_network(toy_data, colours = c("orange", "cornflowerblue", "hotpink"), option = "B")
```

![](data:image/png;base64...)

## 3.4 Circos plot

The `cc_circos` function can generate three different types of circos plots. Option A generates a circos plot where the width of the links represents the total number of interactions between each pair of cell types. Option B generates a circos plot showing the ligands, receptors and cell types involved in the top portion of interactions. Option C expands on option B by also showing the mean expression of the ligand and receptor genes in each cell type. In options B and C, the weight of the links represents the score of the interaction.

```
cc_circos(toy_data)
```

![](data:image/png;base64...)

```
cc_circos(toy_data, option = "B", n_top_ints = 10, cex = 0.75)
#> Warning: 'gap.degree' can only be modified before `circos.initialize`, or maybe
#> you forgot to call `circos.clear` in your last plot.
```

![](data:image/png;base64...)

```
cc_circos(toy_data, option = "C", n_top_ints = 15, exp_df = toy_exp, cell_cols = c(`B` = "hotpink", `NK` = "orange", `CD8 T` = "cornflowerblue"), palette = "PuRd", cex = 0.75)
```

![](data:image/png;base64...)

## 3.5 Paired arrow plot

The `cc_arrow` function generates plots showing the interactions between a given pair of cell types. Option A just shows which ligands/receptors are interacting between a pair of cell types and option B also shows the expression of the ligand/receptor genes in each cell type. In both options, the weight of the arrow represents the score of the interaction.

```
cc_arrow(toy_data, cell_types = c("B", "CD8 T"), colours = c(`B` = "hotpink", `CD8 T` = "orange"))
```

![](data:image/png;base64...)

```
cc_arrow(toy_data, cell_types = c("NK", "CD8 T"), option = "B", exp_df = toy_exp, n_top_ints = 10, palette = "OrRd")
```

![](data:image/png;base64...)

## 3.6 Sigmoid plot

The `cc_sigmoid` function plots a portion of interactions using the `geom_sigmoid` function from the `ggbump` R package to connect ligands in sender cells to receptors in receiver cells.

```
cc_sigmoid(toy_data)
```

![](data:image/png;base64...)

# 4 Customising plots

By default, CCPlotR uses a colour palette that contains 15 colourblind-friendly colours.

```
scales::show_col(paletteMartin())
```

![](data:image/png;base64...)

Because all plotting functions (with the exception of `cc_circos`) are built on top of ggplot2, it’s easy to customise and modify the plots according to the users preferences. Colours, fonts and themes can easily be updated using the usual ggplot2 syntax.

```
library(ggplot2)
library(patchwork)
p1 <- cc_network(toy_data, option = "B") + labs(title = "Default")
p2 <- cc_network(toy_data, option = "B") + scale_fill_manual(values = rainbow(3)) + labs(title = "Update colours")
#> Scale for fill is already present.
#> Adding another scale for fill, which will replace the existing scale.
p3 <- cc_network(toy_data, option = "B") + theme_grey() + labs(title = "Update theme")
p4 <- cc_network(toy_data, option = "B") + theme(legend.position = "top") + labs(title = "Update legend position")

p1 + p2 + p3 + p4
```

![](data:image/png;base64...)

The `cc_circos` function uses the circlize package to generate to the plots so more information about them can be found [here](https://jokergoo.github.io/circlize_book/book/).

# 5 Session Info

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] patchwork_1.3.2  ggplot2_4.0.0    CCPlotR_1.8.0    BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1      viridisLite_0.4.2     dplyr_1.1.4
#>  [4] farver_2.1.2          viridis_0.6.5         S7_0.2.0
#>  [7] ggraph_2.2.2          fastmap_1.2.0         tweenr_2.0.3
#> [10] digest_0.6.37         lifecycle_1.0.4       cluster_2.1.8.1
#> [13] magrittr_2.0.4        compiler_4.5.1        rlang_1.1.6
#> [16] sass_0.4.10           tools_4.5.1           utf8_1.2.6
#> [19] igraph_2.2.1          yaml_2.3.10           knitr_1.50
#> [22] labeling_0.4.3        graphlayouts_1.2.2    plyr_1.8.9
#> [25] xml2_1.4.1            RColorBrewer_1.1-3    withr_3.0.2
#> [28] purrr_1.1.0           BiocGenerics_0.56.0   grid_4.5.1
#> [31] polyclip_1.10-7       ggh4x_0.3.1           stats4_4.5.1
#> [34] colorspace_2.1-2      scales_1.4.0          iterators_1.0.14
#> [37] MASS_7.3-65           tinytex_0.57          dichromat_2.0-0.1
#> [40] cli_3.6.5             rmarkdown_2.30        crayon_1.5.3
#> [43] generics_0.1.4        rjson_0.2.23          commonmark_2.0.0
#> [46] cachem_1.1.0          ggforce_0.5.0         stringr_1.5.2
#> [49] parallel_4.5.1        BiocManager_1.30.26   matrixStats_1.5.0
#> [52] vctrs_0.6.5           yulab.utils_0.2.1     jsonlite_2.0.0
#> [55] litedown_0.7          bookdown_0.45         IRanges_2.44.0
#> [58] GetoptLong_1.0.5      S4Vectors_0.48.0      ggrepel_0.9.6
#> [61] clue_0.3-66           magick_2.9.0          foreach_1.5.2
#> [64] tidyr_1.3.1           jquerylib_0.1.4       glue_1.8.0
#> [67] codetools_0.2-20      ggtext_0.1.2          stringi_1.8.7
#> [70] shape_1.4.6.1         gtable_0.3.6          ComplexHeatmap_2.26.0
#> [73] tibble_3.3.0          pillar_1.11.1         rappdirs_0.3.3
#> [76] htmltools_0.5.8.1     circlize_0.4.16       R6_2.6.1
#> [79] doParallel_1.0.17     tidygraph_1.3.1       evaluate_1.0.5
#> [82] markdown_2.0          png_0.1-8             gridtext_0.1.5
#> [85] ggbump_0.1.0          memoise_2.0.1         ggfun_0.2.0
#> [88] bslib_0.9.0           Rcpp_1.1.0            gridExtra_2.3
#> [91] scatterpie_0.2.6      xfun_0.53             fs_1.6.6
#> [94] forcats_1.0.1         pkgconfig_2.0.3       GlobalOptions_0.1.2
```

# References

Almet, Axel A., Zixuan Cang, Suoqin Jin, and Qing Nie. 2021. “The Landscape of Cell-Cell Communication Through Single-Cell Transcriptomics.” *Current Opinion in Systems Biology* 26 (June): 12–23. <https://doi.org/10.1016/j.coisb.2021.03.007>.

Armingol, Erick, Adam Officer, Olivier Harismendy, and Nathan E. Lewis. 2021. “Deciphering Cell–Cell Interactions and Communication from Gene Expression.” *Nature Reviews Genetics* 22 (2): 71–88. <https://doi.org/10.1038/s41576-020-00292-x>.

Dimitrov, Daniel, Dénes Türei, Martin Garrido-Rodriguez, Paul L. Burmedi, James S. Nagai, Charlotte Boys, Ricardo O. Ramirez Flores, et al. 2022. “Comparison of Methods and Resources for Cell-Cell Communication Inference from Single-Cell RNA-Seq Data.” *Nature Communications* 13 (1): 3224. <https://doi.org/10.1038/s41467-022-30755-0>.

Efremova, Mirjana, Miquel Vento-Tormo, Sarah A. Teichmann, and Roser Vento-Tormo. 2020. “CellPhoneDB: Inferring Cell–Cell Communication from Combined Expression of Multi-Subunit Ligand–Receptor Complexes.” *Nature Protocols* 15 (4): 1484–1506. <https://doi.org/10.1038/s41596-020-0292-x>.

Hou, Rui, Elena Denisenko, Huan Ting Ong, Jordan A. Ramilowski, and Alistair R. R. Forrest. 2020. “Predicting Cell-to-Cell Communication Networks Using NATMI.” *Nature Communications* 11 (1): 5011. <https://doi.org/10.1038/s41467-020-18873-z>.

Jin, Suoqin, Christian F. Guerrero-Juarez, Lihua Zhang, Ivan Chang, Raul Ramos, Chen-Hsiang Kuan, Peggy Myung, Maksim V. Plikus, and Qing Nie. 2021. “Inference and Analysis of Cell-Cell Communication Using CellChat.” *Nature Communications* 12 (1): 1088. <https://doi.org/10.1038/s41467-021-21246-9>.