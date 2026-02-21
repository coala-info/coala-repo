# Loading and re-analysing public data through ReactomeGSA

#### Johannes Griss

#### 2026-01-29

## Introduction

Since October 2023, ReactomeGSA was extended to simplify the reuse of public data. As key features, ReactomeGSA can now directly load data from **EBI’s ExpressionAtlas**, and **NCBI’s GREIN**. Both of these resources reprocess available public datasets using consistent pipelines.

Additionally, a search function was integrated into ReactomeGSA that can search for datasets simultaneously in all of these supported resources.

The ReactomeGSA R package now also has all required functions to directly access this web-based service. It is thereby possible to search for public datasets directly and download them as **ExpressionSet** objects.

## Installation

The `ReactomeGSA` package can be directly installed from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

if (!require(ReactomeGSA))
  BiocManager::install("ReactomeGSA")
```

For more information, see <https://bioconductor.org/install/>.

## Searching for Public Datasets

The `find_public_datasets` function uses ReactomeGSA’s web service to search for public datasets in all supported resources.

By default, the datasets are limited to human studies. This can be changed by setting the `species` parameter. The complete list of available species is returned by the `get_public_species` function.

```
library(ReactomeGSA)

# get all available species found in the datasets
all_species <- get_public_species()

head(all_species)
#> [1] "Aegilops tauschii"                "Anas platyrhynchos"
#> [3] "Anolis carolinensis"              "Anopheles gambiae"
#> [5] "Arabidopsis lyrata"               "Arabidopsis lyrata subsp. lyrata"
```

The `search_term` parameter takes a single string as an argument. Words separated by a space are logically combined using an **AND**.

```
# search for datasets on BRAF and melanoma
datasets <- find_public_datasets("melanoma BRAF")

# the function returns the found datasets as a data.frame
datasets[1:4, c("id", "title")]
#>          id
#> 1  GSE83592
#> 2 GSE110054
#> 3 GSE100066
#> 4 GSE107370
#>                                                                           title
#> 1                            JQ1 +/- Vemurafenib in BRAF mutant melanoma (A375)
#> 2                Transcriptional responses of melanoma cells to BRAF inhibition
#> 3         Transcriptome sequencing analysis of BRAF-mutant melanoma metastases.
#> 4 Concomitant BCORL1 and BRAF mutations in vemurafenib-resistant melanoma cells
```

## Load a public dataset

Datasets found through the `find_public_datasets` function can subsequently loaded using the `load_public_dataset` function.

```
# find the correct entry in the search result
# this must be the complete row of the data.frame returned
# by the find_public_datasets function
dataset_search_entry <- datasets[datasets$id == "E-MTAB-7453", ]

str(dataset_search_entry)
#> 'data.frame':    1 obs. of  7 variables:
#>  $ title              : chr "RNA-seq of the human melanoma cell-line A375P treated with the BRAF inhibitor PLX4720 and a DMSO control"
#>  $ id                 : chr "E-MTAB-7453"
#>  $ resource_name      : chr "EBI Expression Atlas"
#>  $ description        : chr ""
#>  $ resource_loading_id: chr "ebi_gxa"
#>  $ loading_parameters :List of 1
#>   ..$ :'data.frame': 1 obs. of  2 variables:
#>   .. ..$ name : chr "dataset_id"
#>   .. ..$ value: chr "E-MTAB-7453"
#>  $ web_link           : chr "https://www.ebi.ac.uk/gxa/experiments/E-MTAB-7453/Results"
```

The selected dataset can now be loaded through the `load_public_dataset` function.

```
# this function only takes one argument, which must be
# a single row from the data.frame returned by the
# find_public_datasets function
mel_cells_braf <- load_public_dataset(dataset_search_entry, verbose = TRUE)
#> Dataset E-MTAB-7453 available.
```

The returned object is an `ExpressionSet` object that already contains all available metada.

```
# use the biobase functions to access the metadata
library(Biobase)
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following object is masked from 'package:dplyr':
#>
#>     explain
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following object is masked from 'package:dplyr':
#>
#>     combine
#> The following object is masked from 'package:limma':
#>
#>     plotMA
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.

# basic metadata
pData(mel_cells_braf)
#>             Sample.Id AtlasAssayGroup     organism cell_line organism_part
#> ERR2950741 ERR2950741              g2 Homo sapiens    A375-P          skin
#> ERR2950742 ERR2950742              g2 Homo sapiens    A375-P          skin
#> ERR2950743 ERR2950743              g2 Homo sapiens    A375-P          skin
#> ERR2950744 ERR2950744              g1 Homo sapiens    A375-P          skin
#> ERR2950745 ERR2950745              g1 Homo sapiens    A375-P          skin
#> ERR2950746 ERR2950746              g1 Homo sapiens    A375-P          skin
#>                  cell_type  disease compound         dose
#> ERR2950741 epithelial cell melanoma     none
#> ERR2950742 epithelial cell melanoma     none
#> ERR2950743 epithelial cell melanoma     none
#> ERR2950744 epithelial cell melanoma  PLX4720 1 micromolar
#> ERR2950745 epithelial cell melanoma  PLX4720 1 micromolar
#> ERR2950746 epithelial cell melanoma  PLX4720 1 micromolar
```

Detailed descriptions of the loaded study are further stored in the metadata slot.

```
# access the stored metadata using the experimentData function
experimentData(mel_cells_braf)
#> Experiment data
#>   Experimenter name: E-MTAB-7453
#>   Laboratory:
#>   Contact information:
#>   Title: RNA-seq of the human melanoma cell-line A375P treated with the BRAF inhibitor PLX4720 and a DMSO control
#>   URL: https://www.ebi.ac.uk/gxa/experiments/E-MTAB-7453/Results
#>   PMIDs:
#>   No abstract available.
#>   notes:
#>    notes:
#>       Public dataset loaded from EBI Expression Atlas through ReactomeGSA.

# for some datasets, longer descriptions are available. These
# can be accessed using the abstract function
abstract(mel_cells_braf)
#> [1] ""
```

Additionally, you can use the `table` function to quickly get the number of available samples for a specific metadata field.

```
table(mel_cells_braf$compound)
#>
#> PLX4720    none
#>       3       3
```

## Perform the pathway analysis using ReactomeGSA

This object is now directly compatible with ReactomeGSA’s pathway analysis functions. A detailed explanation of how to perform this analysis, please have a look at the respective vignette.

```
# create the analysis request
my_request <-ReactomeAnalysisRequest(method = "Camera")

# do not create a visualization for this example
my_request <- set_parameters(request = my_request, create_reactome_visualization = FALSE)

# add the dataset using the loaded object
my_request <- add_dataset(request = my_request,
                          expression_values = mel_cells_braf,
                          name = "E-MTAB-7453",
                          type = "rnaseq_counts",
                          comparison_factor = "compound",
                          comparison_group_1 = "PLX4720",
                          comparison_group_2 = "none")
#> Converting expression data to string... (This may take a moment)
#> Conversion complete

my_request
#> ReactomeAnalysisRequestObject
#>   Method = Camera
#>   Parameters:
#>   - create_reactome_visualization: FALSE
#>   Datasets:
#>   - E-MTAB-7453 (rnaseq_counts)
#>     No parameters set.
#> ReactomeAnalysisRequest
```

The analysis can now started using the standard workflow:

```
# perform the analysis using ReactomeGSA
res <- perform_reactome_analysis(my_request)
#> Submitting request to Reactome API...
#> Compressing request data...
#> Reactome Analysis submitted succesfully
#> Converting dataset E-MTAB-7453...
#> Mapping identifiers...
#> Performing gene set analysis using Camera
#> Analysing dataset 'E-MTAB-7453' using Camera
#> Retrieving result...

# basic overview of the result
print(res)
#> ReactomeAnalysisResult object
#>   Reactome Release: 95
#>   Results:
#>   - E-MTAB-7453:
#>     2732 pathways
#>     9485 fold changes for genes
#>   No Reactome visualizations available
#> [1] "ReactomeAnalysisResult"
#> attr(,"package")
#> [1] "ReactomeGSA"

# key pathways
res_pathways <- pathways(res)

head(res_pathways)
#>                                                       Name
#> R-HSA-69239                               Synthesis of DNA
#> R-HSA-69620                         Cell Cycle Checkpoints
#> R-HSA-69242                                        S Phase
#> R-HSA-69206                                G1/S Transition
#> R-HSA-68962      Activation of the pre-replicative complex
#> R-HSA-141424 Amplification of signal from the kinetochores
#>              Direction.E-MTAB-7453 FDR.E-MTAB-7453 PValue.E-MTAB-7453
#> R-HSA-69239                     Up    3.366667e-14       1.232308e-17
#> R-HSA-69620                     Up    5.492942e-14       4.021187e-17
#> R-HSA-69242                     Up    1.994734e-13       2.190410e-16
#> R-HSA-69206                     Up    3.623345e-13       5.305043e-16
#> R-HSA-68962                     Up    7.598922e-13       1.873064e-15
#> R-HSA-141424                    Up    7.598922e-13       1.947015e-15
#>              NGenes.E-MTAB-7453 av_foldchange.E-MTAB-7453 sig.E-MTAB-7453
#> R-HSA-69239                 108                  1.583376            TRUE
#> R-HSA-69620                 268                  1.480720            TRUE
#> R-HSA-69242                 150                  1.435501            TRUE
#> R-HSA-69206                 121                  1.599839            TRUE
#> R-HSA-68962                  33                  2.559335            TRUE
#> R-HSA-141424                 93                  2.015514            TRUE
```

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
#>  [1] Biobase_2.70.0          BiocGenerics_0.56.0     generics_0.1.4
#>  [4] ggplot2_4.0.1           dplyr_1.1.4             tidyr_1.3.2
#>  [7] ReactomeGSA.data_1.24.0 Seurat_5.4.0            SeuratObject_5.3.0
#> [10] sp_2.2-0                ReactomeGSA_1.24.1      edgeR_4.8.2
#> [13] limma_3.66.0
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
#>  [64] cluster_2.1.8.1        reshape2_1.4.5         gtable_0.3.6
#>  [67] spatstat.data_3.1-9    hms_1.1.4              data.table_1.18.2.1
#>  [70] spatstat.geom_3.7-0    RcppAnnoy_0.0.23       ggrepel_0.9.6
#>  [73] RANN_2.6.2             pillar_1.11.1          stringr_1.6.0
#>  [76] spam_2.11-3            RcppHNSW_0.6.0         later_1.4.5
#>  [79] splines_4.5.2          lattice_0.22-7         survival_3.8-6
#>  [82] deldir_2.0-4           tidyselect_1.2.1       locfit_1.5-9.12
#>  [85] miniUI_0.1.2           pbapply_1.7-4          knitr_1.51
#>  [88] gridExtra_2.3          scattermore_1.2        xfun_0.56
#>  [91] statmod_1.5.1          matrixStats_1.5.0      stringi_1.8.7
#>  [94] lazyeval_0.2.2         yaml_2.3.12            evaluate_1.0.5
#>  [97] codetools_0.2-20       tibble_3.3.1           cli_3.6.5
#> [100] uwot_0.2.4             xtable_1.8-4           reticulate_1.44.1
#> [103] jquerylib_0.1.4        dichromat_2.0-0.1      Rcpp_1.1.1
#> [106] globals_0.18.0         spatstat.random_3.4-4  png_0.1-8
#> [109] spatstat.univar_3.1-6  parallel_4.5.2         prettyunits_1.2.0
#> [112] dotCall64_1.2          bitops_1.0-9           listenv_0.10.0
#> [115] viridisLite_0.4.2      scales_1.4.0           ggridges_0.5.7
#> [118] crayon_1.5.3           purrr_1.2.1            rlang_1.1.7
#> [121] cowplot_1.2.0
```