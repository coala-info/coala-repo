# Analysing single-cell RNA-sequencing Data

#### Johannes Griss

#### 2026-01-29

## Introduction

The ReactomeGSA package is a client to the web-based Reactome Analysis System. Essentially, it performs a gene set analysis using the latest version of the Reactome pathway database as a backend.

This vignette shows how the ReactomeGSA package can be used to perform a pathway analysis of cell clusters in single-cell RNA-sequencing data.

### Citation

To cite this package, use

```
Griss J. ReactomeGSA, https://github.com/reactome/ReactomeGSA (2019)
```

## Installation

The `ReactomeGSA` package can be directly installed from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

if (!require(ReactomeGSA))
  BiocManager::install("ReactomeGSA")

# install the ReactomeGSA.data package for the example data
if (!require(ReactomeGSA.data))
  BiocManager::install("ReactomeGSA.data")
```

For more information, see <https://bioconductor.org/install/>.

## Example data

As an example we load single-cell RNA-sequencing data of B cells extracted from the dataset published by Jerby-Arnon *et al.* (Cell, 2018).

**Note**: This is not a complete Seurat object. To decrease the size, the object only contains gene expression values and cluster annotations.

```
library(ReactomeGSA.data)
#> Loading required package: limma
#> Loading required package: edgeR
#> Loading required package: ReactomeGSA
#> Loading required package: Seurat
#> Loading required package: SeuratObject
#> Loading required package: sp
#>
#> Attaching package: 'SeuratObject'
#> The following objects are masked from 'package:base':
#>
#>     intersect, t
data(jerby_b_cells)

jerby_b_cells
#> An object of class Seurat
#> 23686 features across 920 samples within 1 assay
#> Active assay: RNA (23686 features, 0 variable features)
#>  2 layers present: counts, data
```

## Types of analyses

There are two methods to analyse scRNA-seq data using ReactomeGSA:

ReactomeGSA can generate pseudo-bulk data from scRNA-seq data and then analyse this data using the classical quantitative pathway analysis algorithms. Thereby, it is possible to directly compare, f.e. two cell types with each other or two treatment approaches. The result is a classical pathway analysis result with p-values and fold-changes attributed to each pathway.

The `analyse_sc_clusters` function offers a second approach using the gene set variation algorithm `ssGSEA` to derive pathway-level quantitative values for each cluster or cell type in the dataset. This is helpful to visualize the “expression level” of pathways accross the dataset. Statistical analyses have to be performed separately.

## Comparative pathway analysis (pseudo-bulk approach)

The pathway analysis is at the very end of a scRNA-seq workflow. This means, that any Q/C was already performed, the data was normalized and cells were already clustered.

In this example we are going to compare `Cluster 1` against `Cluster 2`.

```
# store the Idents as a meta.data field - this was
# removed while compressing the object as an example
jerby_b_cells$clusters <- Idents(jerby_b_cells)

table(jerby_b_cells$clusters)
#>
#>  Cluster 4  Cluster 8  Cluster 1 Cluster 11  Cluster 3  Cluster 6  Cluster 2
#>        106         54        140         31        109         85        114
#>  Cluster 7  Cluster 9 Cluster 13  Cluster 5 Cluster 12 Cluster 10
#>         55         47         24         90         25         40
```

As a next step, we need to create the pseudo-bulk data for the analysis. This is achieved through the `generate_pseudo_bulk_data` function.

```
library(ReactomeGSA)

# This creates a pseudo-bulk object by splitting each cluster in 4
# random bulks of data. This approach can be changed through the
# split_by and k_variable parameter.
pseudo_bulk_data <- generate_pseudo_bulk_data(jerby_b_cells, group_by = "clusters")
#> Centering and scaling data matrix

# we can immediately create the metadata data.frame for this data
pseudo_metadata <- generate_metadata(pseudo_bulk_data)
```

This pseudo-bulk data is directly compatible with the existing algorithms for quantitative pathway analysis and can be processed using the respective ReactomeGSA methods.

```
# Create a new request object using 'Camera' for the gene set analysis
my_request <- ReactomeAnalysisRequest(method = "Camera")

# set the maximum number of allowed missing values to 50%
my_request <- set_parameters(request = my_request, max_missing_values = 0.5)

# add the pseudo-bulk data as a dataset
my_request <- add_dataset(request = my_request,
                          expression_values = pseudo_bulk_data,
                          sample_data = pseudo_metadata,
                          name = "Pseudo-bulk",
                          type = "rnaseq_counts",
                          comparison_factor = "Group",
                          comparison_group_1 = "Cluster 1",
                          comparison_group_2 = "Cluster 2")
#> Converting expression data to string... (This may take a moment)
#> Conversion complete

my_request
#> ReactomeAnalysisRequestObject
#>   Method = Camera
#>   Parameters:
#>   - max_missing_values: 0.5
#>   Datasets:
#>   - Pseudo-bulk (rnaseq_counts)
#>     No parameters set.
#> ReactomeAnalysisRequest
```

This request object can be directly submitted to the ReactomeGSA analysis.

```
quant_result <- perform_reactome_analysis(my_request, compress = FALSE)
#> Submitting request to Reactome API...
#> Reactome Analysis submitted succesfully
#> Converting dataset Pseudo-bulk...
#> Mapping identifiers...
#> Performing gene set analysis using Camera
#> Analysing dataset 'Pseudo-bulk' using Camera
#> Creating REACTOME visualization
#> Retrieving result...
quant_result
#> ReactomeAnalysisResult object
#>   Reactome Release: 95
#>   Results:
#>   - Pseudo-bulk:
#>     2671 pathways
#>     10609 fold changes for genes
#>   Reactome visualizations:
#>   - Gene Set Analysis Summary
#> ReactomeAnalysisResult
```

This object can be used in the same fashion as any ReactomeGSA result object.

```
# get the pathway-level results
quant_pathways <- pathways(quant_result)
head(quant_pathways)
#>                                                                                       Name
#> R-HSA-156842                                             Eukaryotic Translation Elongation
#> R-HSA-192823                                                        Viral mRNA Translation
#> R-HSA-156902                                                      Peptide chain elongation
#> R-HSA-9954714                PELO:HBS1L and ABCE1 dissociate a ribosome on a non-stop mRNA
#> R-HSA-72764                                             Eukaryotic Translation Termination
#> R-HSA-975956  Nonsense Mediated Decay (NMD) independent of the Exon Junction Complex (EJC)
#>               Direction.Pseudo-bulk FDR.Pseudo-bulk PValue.Pseudo-bulk
#> R-HSA-156842                     Up    1.402708e-24       7.083913e-28
#> R-HSA-192823                     Up    1.402708e-24       1.050324e-27
#> R-HSA-156902                     Up    4.147053e-24       5.086681e-27
#> R-HSA-9954714                    Up    4.147053e-24       6.210488e-27
#> R-HSA-72764                      Up    2.175802e-23       4.073010e-26
#> R-HSA-975956                     Up    6.750206e-23       1.516332e-25
#>               NGenes.Pseudo-bulk av_foldchange.Pseudo-bulk sig.Pseudo-bulk
#> R-HSA-156842                  84                 0.3451738            TRUE
#> R-HSA-192823                  81                 0.3666908            TRUE
#> R-HSA-156902                  81                 0.3430918            TRUE
#> R-HSA-9954714                 82                 0.3811345            TRUE
#> R-HSA-72764                   84                 0.3405284            TRUE
#> R-HSA-975956                  86                 0.3411271            TRUE
```

```
# get the top pathways to label them
library(tidyr)
library(dplyr)
#>
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#>
#>     filter, lag
#> The following objects are masked from 'package:base':
#>
#>     intersect, setdiff, setequal, union

top_pathways <- quant_pathways %>%
  tibble::rownames_to_column(var = "Id") %>%
  filter(`FDR.Pseudo-bulk` < 0.001) %>%
  arrange(desc(`av_foldchange.Pseudo-bulk`))

# limit to a few pathway for aesthetic reasons
top_pathways <- top_pathways[c(1,5,6), ]

# create a simple volcano plot of the pathway results
library(ggplot2)
ggplot(quant_pathways,
       aes(x = `av_foldchange.Pseudo-bulk`,
           y = -log10(`FDR.Pseudo-bulk`))) +
  geom_vline(xintercept = c(log2(0.5), log2(2)), colour="grey", linetype = "longdash") +
  geom_hline(yintercept = -log10(0.05), colour="grey", linetype = "longdash") +
  geom_point() +
  geom_label(data = top_pathways, aes(label = Name), nudge_y = 1, check_overlap = TRUE)
#> Warning in geom_label(data = top_pathways, aes(label = Name), nudge_y = 1, :
#> Ignoring unknown parameters: `check_overlap`
```

![](data:image/png;base64...)

## Pathway analysis of cell clusters (analyse\_sc\_clusters)

The ReactomeGSA package can now be used to get pathway-level expression values for every cell cluster. This is achieved by calculating the mean gene expression for every cluster and then submitting this data to a gene set variation analysis.

All of this is wrapped in the single `analyse_sc_clusters` function.

```
gsva_result <- analyse_sc_clusters(jerby_b_cells, verbose = TRUE)
#> Calculating average cluster expression...
#> Converting expression data to string... (This may take a moment)
#> Conversion complete
#> Submitting request to Reactome API...
#> Compressing request data...
#> Reactome Analysis submitted succesfully
#> Converting dataset Seurat...
#> Mapping identifiers...
#> Performing gene set analysis using ssGSEA
#> Analysing dataset 'Seurat' using ssGSEA
#> Retrieving result...
```

The resulting object is a standard `ReactomeAnalysisResult` object.

```
gsva_result
#> ReactomeAnalysisResult object
#>   Reactome Release: 95
#>   Results:
#>   - Seurat:
#>     1755 pathways
#>     11972 fold changes for genes
#>   No Reactome visualizations available
#> ReactomeAnalysisResult
```

`pathways` returns the pathway-level expression values per cell cluster:

```
pathway_expression <- pathways(gsva_result)

# simplify the column names by removing the default dataset identifier
colnames(pathway_expression) <- gsub("\\.Seurat", "", colnames(pathway_expression))

pathway_expression[1:3,]
#>                                  Name   Cluster_1  Cluster_10 Cluster_11
#> R-HSA-1059683 Interleukin-6 signaling -0.02180749 -0.06010233 0.10508271
#> R-HSA-109703      PKB-mediated events  0.31952116 -0.29441682 0.03255988
#> R-HSA-109704             PI3K Cascade -0.07090109 -0.10433201 0.13671832
#>                Cluster_12 Cluster_13   Cluster_2   Cluster_3   Cluster_4
#> R-HSA-1059683  0.05791394 0.01114615  0.15621728 -0.06201346 -0.11144838
#> R-HSA-109703   0.08586850 0.03101142 -0.03419021  0.27025973 -0.09886192
#> R-HSA-109704  -0.00660632 0.04172215  0.06920137  0.06697775 -0.05765056
#>                 Cluster_5   Cluster_6   Cluster_7  Cluster_8   Cluster_9
#> R-HSA-1059683 -0.15212980 -0.07841848 -0.06881635 0.15800661 -0.02634280
#> R-HSA-109703   0.09626583 -0.06122479 -0.37339648 0.05814402 -0.26570238
#> R-HSA-109704  -0.02103187 -0.07717510 -0.03594186 0.12229649 -0.08838658
```

A simple approach to find the most relevant pathways is to assess the maximum difference in expression for every pathway:

```
# find the maximum differently expressed pathway
max_difference <- do.call(rbind, apply(pathway_expression, 1, function(row) {
    values <- as.numeric(row[2:length(row)])
    return(data.frame(name = row[1], min = min(values), max = max(values)))
}))

max_difference$diff <- max_difference$max - max_difference$min

# sort based on the difference
max_difference <- max_difference[order(max_difference$diff, decreasing = T), ]

head(max_difference)
#>                                                                    name
#> R-HSA-140180                                              COX reactions
#> R-HSA-1296067                              Potassium transport channels
#> R-HSA-392023  Adrenaline signalling through Alpha-2 adrenergic receptor
#> R-HSA-8964540                                        Alanine metabolism
#> R-HSA-3248023                                       Regulation by TREX1
#> R-HSA-350864                     Regulation of thyroid hormone activity
#>                      min       max     diff
#> R-HSA-140180  -0.9647481 0.9836271 1.948375
#> R-HSA-1296067 -1.0000000 0.8857238 1.885724
#> R-HSA-392023  -0.9009272 0.9739370 1.874864
#> R-HSA-8964540 -0.8731936 0.9936513 1.866845
#> R-HSA-3248023 -0.9189708 0.9425278 1.861499
#> R-HSA-350864  -0.9136246 0.9398546 1.853479
```

### Plotting the results

The ReactomeGSA package contains two functions to visualize these pathway results. The first simply plots the expression for a selected pathway:

```
plot_gsva_pathway(gsva_result, pathway_id = rownames(max_difference)[1])
```

![](data:image/png;base64...)

For a better overview, the expression of multiple pathways can be shown as a heatmap using `gplots` `heatmap.2` function:

```
# Additional parameters are directly passed to gplots heatmap.2 function
plot_gsva_heatmap(gsva_result, max_pathways = 15, margins = c(6,20))
```

![](data:image/png;base64...)

The `plot_gsva_heatmap` function can also be used to only display specific pahtways:

```
# limit to selected B cell related pathways
relevant_pathways <- c("R-HSA-983170", "R-HSA-388841", "R-HSA-2132295", "R-HSA-983705", "R-HSA-5690714")
plot_gsva_heatmap(gsva_result,
                  pathway_ids = relevant_pathways, # limit to these pathways
                  margins = c(6,30), # adapt the figure margins in heatmap.2
                  dendrogram = "col", # only plot column dendrogram
                  scale = "row", # scale for each pathway
                  key = FALSE, # don't display the color key
                  lwid=c(0.1,4)) # remove the white space on the left
#> Warning in plot_gsva_heatmap(gsva_result, pathway_ids = relevant_pathways, :
#> Warning: No results for the following pathways: R-HSA-388841, R-HSA-983705
```

![](data:image/png;base64...)

This analysis shows us that cluster 8 has a marked up-regulation of B Cell receptor signalling, which is linked to a co-stimulation of the CD28 family. Additionally, there is a gradient among the cluster with respect to genes releated to antigen presentation.

Therefore, we are able to further classify the observed B cell subtypes based on their pathway activity.

### Pathway-level PCA

The pathway-level expression analysis can also be used to run a Principal Component Analysis on the samples. This is simplified through the function `plot_gsva_pca`:

```
plot_gsva_pca(gsva_result)
```

![](data:image/png;base64...)

In this analysis, cluster 11 is a clear outlier from the other B cell subtypes and therefore might be prioritised for further evaluation.

## Session Info

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
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
#>  [1] ggplot2_4.0.1           dplyr_1.1.4             tidyr_1.3.2
#>  [4] ReactomeGSA.data_1.24.0 Seurat_5.4.0            SeuratObject_5.3.0
#>  [7] sp_2.2-0                ReactomeGSA_1.24.1      edgeR_4.8.2
#> [10] limma_3.66.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3     jsonlite_2.0.0         magrittr_2.0.4
#>   [4] spatstat.utils_3.2-1   farver_2.1.2           rmarkdown_2.30
#>   [7] vctrs_0.7.1            ROCR_1.0-12            spatstat.explore_3.7-0
#>  [10] progress_1.2.3         htmltools_0.5.9        curl_7.0.0
#>  [13] sass_0.4.10            sctransform_0.4.3      parallelly_1.46.1
#>  [16] KernSmooth_2.23-26     bslib_0.10.0           htmlwidgets_1.6.4
#>  [19] ica_1.0-3              plyr_1.8.9             plotly_4.12.0
#>  [22] zoo_1.8-15             cachem_1.1.0           igraph_2.2.1
#>  [25] mime_0.13              lifecycle_1.0.5        pkgconfig_2.0.3
#>  [28] Matrix_1.7-4           R6_2.6.1               fastmap_1.2.0
#>  [31] fitdistrplus_1.2-6     future_1.69.0          shiny_1.12.1
#>  [34] digest_0.6.39          patchwork_1.3.2        tensor_1.5.1
#>  [37] RSpectra_0.16-2        irlba_2.3.5.1          labeling_0.4.3
#>  [40] progressr_0.18.0       spatstat.sparse_3.1-0  httr_1.4.7
#>  [43] polyclip_1.10-7        abind_1.4-8            compiler_4.5.2
#>  [46] withr_3.0.2            S7_0.2.1               fastDummies_1.7.5
#>  [49] gplots_3.3.0           MASS_7.3-65            gtools_3.9.5
#>  [52] caTools_1.18.3         tools_4.5.2            lmtest_0.9-40
#>  [55] otel_0.2.0             httpuv_1.6.16          future.apply_1.20.1
#>  [58] goftest_1.2-3          glue_1.8.0             nlme_3.1-168
#>  [61] promises_1.5.0         grid_4.5.2             Rtsne_0.17
#>  [64] cluster_2.1.8.1        reshape2_1.4.5         generics_0.1.4
#>  [67] gtable_0.3.6           spatstat.data_3.1-9    hms_1.1.4
#>  [70] data.table_1.18.2.1    BiocGenerics_0.56.0    spatstat.geom_3.7-0
#>  [73] RcppAnnoy_0.0.23       ggrepel_0.9.6          RANN_2.6.2
#>  [76] pillar_1.11.1          stringr_1.6.0          spam_2.11-3
#>  [79] RcppHNSW_0.6.0         later_1.4.5            splines_4.5.2
#>  [82] lattice_0.22-7         survival_3.8-6         deldir_2.0-4
#>  [85] tidyselect_1.2.1       locfit_1.5-9.12        miniUI_0.1.2
#>  [88] pbapply_1.7-4          knitr_1.51             gridExtra_2.3
#>  [91] scattermore_1.2        xfun_0.56              Biobase_2.70.0
#>  [94] statmod_1.5.1          matrixStats_1.5.0      stringi_1.8.7
#>  [97] lazyeval_0.2.2         yaml_2.3.12            evaluate_1.0.5
#> [100] codetools_0.2-20       tibble_3.3.1           cli_3.6.5
#> [103] uwot_0.2.4             xtable_1.8-4           reticulate_1.44.1
#> [106] jquerylib_0.1.4        dichromat_2.0-0.1      Rcpp_1.1.1
#> [109] globals_0.18.0         spatstat.random_3.4-4  png_0.1-8
#> [112] spatstat.univar_3.1-6  parallel_4.5.2         prettyunits_1.2.0
#> [115] dotCall64_1.2          bitops_1.0-9           listenv_0.10.0
#> [118] viridisLite_0.4.2      scales_1.4.0           ggridges_0.5.7
#> [121] crayon_1.5.3           purrr_1.2.1            rlang_1.1.7
#> [124] cowplot_1.2.0
```