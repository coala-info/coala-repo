# Using the ReactomeGSA package

#### Johannes Griss

#### 2026-01-29

## Introduction

The ReactomeGSA package is a client to the web-based Reactome Analysis System. Essentially, it performs a gene set analysis using the latest version of the Reactome pathway database as a backend.

The main advantages of using the Reactome Analysis System are:

* Simultaneous analysis and visualization of different types of ’omics data
* Support for direct comparison across different species
* Directly linked with Reactome’s powerful pathway browser producing publication-ready figures of your gene set analysis

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
```

For more information, see <https://bioconductor.org/install/>.

## Getting available methods

The Reactome Analysis System will be continuously updated. Before starting your analysis it is therefore a good approach to check which methods are available.

This can simply be done by using:

```
library(ReactomeGSA)

available_methods <- get_reactome_methods(print_methods = FALSE, return_result = TRUE)

# only show the names of the available methods
available_methods$name
#> [1] "PADOG"     "Camera"    "ssGSEA"    "terapadog"
```

To get more information about a specific method, set `print_details` to `TRUE` and specify the `method`:

```
# Use this command to print the description of the specific method to the console
# get_reactome_methods(print_methods = TRUE, print_details = TRUE, method = "PADOG", return_result = FALSE)

# show the parameter names for the method
padog_params <- available_methods$parameters[available_methods$name == "PADOG"][[1]]

paste0(padog_params$name, " (", padog_params$type, ", ", padog_params$default, ")")
#>  [1] "use_interactors (bool, False)"
#>  [2] "include_disease_pathways (bool, True)"
#>  [3] "max_missing_values (float, 0.5)"
#>  [4] "create_reactome_visualization (bool, True)"
#>  [5] "create_reports (bool, False)"
#>  [6] "email (string, )"
#>  [7] "reactome_server (string, production)"
#>  [8] "sample_groups (string, )"
#>  [9] "discrete_norm_function (string, TMM)"
#> [10] "continuous_norm_function (string, none)"
```

## Creating an analysis request

To start a gene set analysis, you first have to create an analysis request. This is a simple S4 class that takes care of submitting multiple datasets simultaneously to the analysis system.

When creating the request object, you already have to specify the analysis method you want to use:

```
# Create a new request object using 'Camera' for the gene set analysis
my_request <-ReactomeAnalysisRequest(method = "Camera")

my_request
#> ReactomeAnalysisRequestObject
#>   Method = Camera
#>   No request data stored
#> ReactomeAnalysisRequest
```

## Setting parameters

To get a list of supported parameters for each method, use the `get_reactome_methods` function (see above).

Parameters are simply set using the `set_parameters` function:

```
# set the maximum number of allowed missing values to 50%
my_request <- set_parameters(request = my_request, max_missing_values = 0.5)

my_request
#> ReactomeAnalysisRequestObject
#>   Method = Camera
#>   Parameters:
#>   - max_missing_values: 0.5
#>   Datasets: none
#> ReactomeAnalysisRequest
```

Multiple parameters can by set simulataneously by simply adding more name-value pairs to the function call.

## Adding datasets

One analysis request can contain multiple datasets. This can be used to, for example, visualize the results of an RNA-seq and Proteomics experiment (of the same / similar samples) side by side:

```
library(ReactomeGSA.data)
data("griss_melanoma_proteomics")
```

This is a limma `EList` object with the sample data already added

```
class(griss_melanoma_proteomics)
#> [1] "EList"
#> attr(,"package")
#> [1] "limma"
head(griss_melanoma_proteomics$samples)
#>                patient.id condition cell.type
#> M-D MOCK PBMCB         P3      MOCK     PBMCB
#> M-D MCM PBMCB          P3       MCM     PBMCB
#> M-K MOCK PBMCB         P4      MOCK     PBMCB
#> M-K MCM PBMCB          P4       MCM     PBMCB
#> P-A MOCK PBMCB         P1      MOCK     PBMCB
#> P-A MCM PBMCB          P1       MCM     PBMCB
```

The dataset can now simply be added to the request using the `add_dataset` function:

```
my_request <- add_dataset(request = my_request,
                          expression_values = griss_melanoma_proteomics,
                          name = "Proteomics",
                          type = "proteomics_int",
                          comparison_factor = "condition",
                          comparison_group_1 = "MOCK",
                          comparison_group_2 = "MCM",
                          additional_factors = c("cell.type", "patient.id"))
my_request
#> ReactomeAnalysisRequestObject
#>   Method = Camera
#>   Parameters:
#>   - max_missing_values: 0.5
#>   Datasets:
#>   - Proteomics (proteomics_int)
#>     No parameters set.
#> ReactomeAnalysisRequest
```

Several datasets (of the same experiment) can be added to one request. This RNA-seq data is stored as an `edgeR` `DGEList` object:

```
data("griss_melanoma_rnaseq")

# only keep genes with >= 100 reads in total
total_reads <- rowSums(griss_melanoma_rnaseq$counts)
griss_melanoma_rnaseq <- griss_melanoma_rnaseq[total_reads >= 100, ]

# this is a edgeR DGEList object
class(griss_melanoma_rnaseq)
#> [1] "DGEList"
#> attr(,"package")
#> [1] "edgeR"
head(griss_melanoma_rnaseq$samples)
#>        group lib.size norm.factors patient cell_type treatment
#> 195-13  MOCK 29907534    1.0629977      P1      TIBC      MOCK
#> 195-14   MCM 26397322    0.9927768      P1      TIBC       MCM
#> 195-19  MOCK 18194834    1.0077827      P2     PBMCB      MOCK
#> 195-20   MCM 24282215    1.0041410      P2     PBMCB       MCM
#> 197-11  MOCK 22628117    0.9522869      P1     PBMCB      MOCK
#> 197-12   MCM 23319849    1.0115732      P1     PBMCB       MCM
```

Again, the dataset can simply be added using `add_dataset`. Here, we added an additional parameter to the `add_dataset` call. Such additional parameters are treated as additional dataset-level parameters.

```
# add the dataset
my_request <- add_dataset(request = my_request,
                          expression_values = griss_melanoma_rnaseq,
                          name = "RNA-seq",
                          type = "rnaseq_counts",
                          comparison_factor = "treatment",
                          comparison_group_1 = "MOCK",
                          comparison_group_2 = "MCM",
                          additional_factors = c("cell_type", "patient"),
                          # This adds the dataset-level parameter 'discrete_norm_function' to the request
                          discrete_norm_function = "TMM")
#> Converting expression data to string... (This may take a moment)
#> Conversion complete
my_request
#> ReactomeAnalysisRequestObject
#>   Method = Camera
#>   Parameters:
#>   - max_missing_values: 0.5
#>   Datasets:
#>   - Proteomics (proteomics_int)
#>     No parameters set.
#>   - RNA-seq (rnaseq_counts)
#>     discrete_norm_function: TMM
#> ReactomeAnalysisRequest
```

### Sample annotations

Datasets can be passed as limma `EList`, edgeR `DGEList`, any implementation of the Bioconductor `ExpressionSet`, or simply a `data.frame`.

For the first three, sample annotations are simply read from the respective slot. When supplying the expression values as a `data.frame`, the `sample_data` parameter has to be set using a `data.frame` where each row represents one sample and each column one proptery. If the the `sample_data` option is set while providing the expression data as an `EList`, `DGEList`, or `ExpressionSet`, the data in `sample_data` will be used instead of the sample annotations in the expression data object.

### Name

Each dataset has to have a name. This can be anything but has to be unique within one analysis request.

### Type

The ReactomeAnalysisSystem supports different types of ’omics data. To get a list of supported types, use the `get_reactome_data_types` function:

```
get_reactome_data_types()
#> rnaseq_counts:
#>    RNA-seq (raw counts)
#>    Raw RNA-seq based read counts per gene (recommended).
#> rnaseq_norm:
#>    RNA-seq (normalized)
#>    log2 transformed, normalized RNA-seq based read counts per gene (f.e. RPKM, TPM)
#> proteomics_int:
#>    Proteomics (intensity)
#>    Intensity-based quantitative proteomics data (for example, iTRAQ/TMT or intensity-based label-free quantitation). Values must be log2 transformed.
#> proteomics_sc:
#>    Proteomics (spectral counts)
#>    Raw spectral-counts of label-free proteomics experiments
#> microarray_norm:
#>    Microarray (normalized)
#>    Normalized and log2 transformed microarray-based gene expression values.
#> ribo_rna_seq:
#>    Combined Ribo-seq and RNA-seq
#>    Simultaneous analysis of the same samples using Ribo-seq and RNA-seq.
```

### Defining the experimental design

Defining the experimental design for a `ReactomeAnalysisRequest` is very simple. Basically, it only takes three parameters:

* `comparison_factor`: Name of the property within the sample data to use
* `comparison_group_1`: The first group to compare
* `comparison_group_2`: The second group to compare

The value set in `comparison_factor` must match a column name in the sample data (either the slot in an `Elist`, `DGEList`, or `ExpressionSet` object or in the `sample_data` parameter).

Additionally, it is possible to define blocking factors. These are supported by all methods that rely on linear models in the backend. Some methods though might simply ignore this parameter. For more information on whether a method supports blocking factors, please use `get_reactome_methods`.

Blocking factors can simply be set `additional_factors` to a vector of names. These should again reference properties (or columns) in the sample data.

## Submitting the request

Once the `ReactomeAnalysisRequest` is created, the complete analysis can be run using `perform_reactome_analysis`:

```
result <- perform_reactome_analysis(request = my_request, compress = F)
#> Submitting request to Reactome API...
#> Reactome Analysis submitted succesfully
#> Converting dataset Proteomics...
#> Converting dataset RNA-seq...
#> Mapping identifiers...
#> Performing gene set analysis using Camera
#> Analysing dataset 'Proteomics' using Camera
#> Analysing dataset 'RNA-seq' using Camera
#> Creating REACTOME visualization
#> Retrieving result...
```

## Investigating the result

The result object is a `ReactomeAnalysisResult` S4 class with several helper functions to access the data.

To retrieve the names of all available results (generally one per dataset), use the `names` function:

```
names(result)
#> [1] "Proteomics" "RNA-seq"
```

For every dataset, different result types may be available. These can be shown using the `result_types` function:

```
result_types(result)
#> [1] "pathways"     "fold_changes"
```

The `Camera` analysis method returns two types of results, pathway-level data and gene- / protein-level fold changes.

A specific result can be retrieved using the `get_result` method:

```
# retrieve the fold-change data for the proteomics dataset
proteomics_fc <- get_result(result, type = "fold_changes", name = "Proteomics")
head(proteomics_fc)
#>   Identifier      logFC   AveExpr         t      P.Value    adj.P.Val         B
#> 1     Q14526  0.4937650 -3.346909 14.505063 1.487672e-10 8.988511e-07 13.983436
#> 2     Q6VY07  0.2981411 -3.330347 13.507233 4.241322e-10 1.281303e-06 13.089407
#> 3     P07093  1.7950301 -3.648968 12.297751 1.655331e-09 3.333837e-06 11.895849
#> 4     P10124  1.0758634 -3.436961 10.333499 1.944516e-08 2.937191e-05  9.658747
#> 5     P55210  0.5018522 -3.347932  9.513998 6.053350e-08 7.314868e-05  8.599314
#> 6     O43683 -0.4754083 -3.345551 -9.364835 7.500288e-08 7.552790e-05  8.397648
```

Additionally, it is possible to directly merge the pathway level data for all result sets using the `pathways` function:

```
combined_pathways <- pathways(result)

head(combined_pathways)
#>                                                                                                                 Name
#> R-HSA-1428517                                                 Aerobic respiration and respiratory electron transport
#> R-HSA-611105                                                                          Respiratory electron transport
#> R-HSA-6799198                                                                                   Complex I biogenesis
#> R-HSA-72649                                                                 Translation initiation complex formation
#> R-HSA-72662   Activation of the mRNA upon binding of the cap-binding complex and eIFs, and subsequent binding to 43S
#> R-HSA-72702                                                           Ribosomal scanning and start codon recognition
#>               Direction.Proteomics FDR.Proteomics PValue.Proteomics
#> R-HSA-1428517                   Up   3.272762e-10      1.987949e-13
#> R-HSA-611105                    Up   3.272762e-10      2.775879e-13
#> R-HSA-6799198                   Up   1.211373e-08      1.541188e-11
#> R-HSA-72649                   Down   8.395710e-08      1.424209e-10
#> R-HSA-72662                   Down   1.586921e-07      3.364973e-10
#> R-HSA-72702                   Down   1.749011e-07      5.061942e-10
#>               NGenes.Proteomics av_foldchange.Proteomics sig.Proteomics
#> R-HSA-1428517               199               0.10614760           TRUE
#> R-HSA-611105                131               0.11620244           TRUE
#> R-HSA-6799198                64               0.12741142           TRUE
#> R-HSA-72649                  57              -0.09502561           TRUE
#> R-HSA-72662                  58              -0.09089517           TRUE
#> R-HSA-72702                  57              -0.09160251           TRUE
#>               Direction.RNA-seq  FDR.RNA-seq PValue.RNA-seq NGenes.RNA-seq
#> R-HSA-1428517              Down 6.906874e-05   2.703755e-06            240
#> R-HSA-611105               Down 5.600072e-04   3.307881e-05            149
#> R-HSA-6799198              Down 4.624362e-03   3.974745e-04             68
#> R-HSA-72649                Down 1.062344e-01   2.111816e-02             58
#> R-HSA-72662                Down 1.379418e-01   3.042845e-02             59
#> R-HSA-72702                Down 1.049244e-01   2.065911e-02             58
#>               av_foldchange.RNA-seq sig.RNA-seq
#> R-HSA-1428517           -0.15094389        TRUE
#> R-HSA-611105            -0.15376460        TRUE
#> R-HSA-6799198           -0.15651521        TRUE
#> R-HSA-72649             -0.10969231       FALSE
#> R-HSA-72662             -0.08354921       FALSE
#> R-HSA-72702             -0.10990703       FALSE
```

## Visualising results

The ReactomeGSA package includes several basic plotting functions to visualise the pathway results. For comparative gene set analysis like the one presented here, two functions are available: `plot_correlations` and `plot_volcano`.

`plot_correlations` can be used to quickly assess how similar two datasets are on the pathway level:

```
plot_correlations(result)
#> Comparing 1 vs 2
#> [[1]]
#> Warning: Removed 289 rows containing missing values or values outside the scale range
#> (`geom_point()`).
```

![](data:image/png;base64...)

Individual datasets can further be visualised using volcano plots of the pathway data:

```
plot_volcano(result, 2)
```

![](data:image/png;base64...)

Finally, it is possible to view the result as a heatmap:

```
plot_heatmap(result) +
  # reduce text size to create a better HTML rendering
  ggplot2::theme(text = ggplot2::element_text(size = 6))
```

![](data:image/png;base64...)

By default, only 30 pathways are shown in the heatmap. It is also possible to easily manually select pathways of interest to plot:

```
# get the data ready to plot with ggplot2
plot_data <- plot_heatmap(result, return_data = TRUE)

# select the pathways of interest - here all pathways
# with "Interleukin" in their name
interleukin_pathways <- grepl("Interleukin", plot_data$Name)

interesting_data <- plot_data[interleukin_pathways, ]

# create the heatmap
ggplot2::ggplot(interesting_data, ggplot2::aes(x = dataset, y = Name, fill = direction)) +
    ggplot2::geom_tile() +
    ggplot2::scale_fill_brewer(palette = "RdYlBu") +
    ggplot2::labs(x = "Dataset", fill = "Direction") +
    ggplot2::theme(text = ggplot2::element_text(size = 6))
```

![](data:image/png;base64...)

### Opening web-based visualization

Additionally, it is possible to open the analysis in Reactome’s web interface using the `open_reactome` command:

```
# Note: This command is not execute in the vignette, since it tries
# to open the default web browser

# open_reactome(result)
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