# PRONE with Spike-In Data

#### Lis Arend

* [1 Load PRONE Package](#load-prone-package)
* [2 Example Spike-in Data Set](#example-spike-in-data-set)
* [3 Load Data](#load-data)
* [4 Overview of the Data](#overview-of-the-data)
* [5 Preprocessing, Normalization, & Imputation](#preprocessing-normalization-imputation)
* [6 Differential Expression Analysis](#differential-expression-analysis)
  + [6.1 Run DE Analysis](#run-de-analysis)
  + [6.2 Evaluate DE Results with Performance Metrics](#evaluate-de-results-with-performance-metrics)
  + [6.3 Log Fold Change Distributions](#log-fold-change-distributions)
  + [6.4 P-Value Distributions](#p-value-distributions)
  + [6.5 Log Fold Change Thresholds](#log-fold-change-thresholds)
* [7 Session Info](#session-info)
* [References](#references)

# 1 Load PRONE Package

```
library(PRONE)
```

# 2 Example Spike-in Data Set

PRONE also offers some additional functionalities for the evaluation of normalization techniques on spike-in data sets with a known ground truth. These functionalities will be delineated subsequently. Additionally, all functionalities detailed in the context of real-world data sets remain applicable to the SummarizedExperiment object associated with spike-in data sets.

The example spike-in data set is from (Cox et al. 2014). For the illustration of the package functionality, a smaller subset of the data consisting of 1500 proteins was used. For the complete data set, please refer to the original publication.

```
data_path <- readPRONE_example("Ecoli_human_MaxLFQ_protein_intensities.csv")
md_path <- readPRONE_example("Ecoli_human_MaxLFQ_metadata.csv")

data <- read.csv(data_path)
md <- read.csv(md_path)
```

# 3 Load Data

Before loading the data into a SummarizedExperiment object, it is important to check the organism of the protein groups. Proteins should be uniquely assigned to either the spike-in organism or the background organism. If some protein groups are mixed, they should be removed from the data since these can’t be used for classification into true positives, false positives, etc.

In our example, we can extract the information from the “Fasta.headers” column:

```
# Check if some protein groups are mixed
mixed <- grepl("Homo sapiens.*Escherichia|Escherichia.*Homo sapiens",data$Fasta.headers)
data <- data[!mixed,]

table(mixed)
#> mixed
#> FALSE
#>  1000
```

In this case, all proteins were assigned either as a spike-in or background protein. Hence, a SummarizedExperiment container of the data can be created. However, before we need to add a column of the actual organism that can be used to calculate true positives, false positives, etc.

```
data$Spiked <- rep("HUMAN", nrow(data))
data$Spiked[grepl("ECOLI", data$Fasta.headers)] <- "ECOLI"
```

In contrast to the real-world data sets, you need to specify the “spike\_column”, “spike\_value”, “spike\_concentration”, and utilize the `load_spike_data()` function for this purpose.

Here, the “spike\_column” denotes the column in the protein intensity data file encompassing information whether a proteins is classified as spike-in or background protein. The “spike\_value” determines the value/identifier that is used to identify the spike-in proteins in the “spike\_column”, and the “spike\_concentration” identifies the column containing the concentration values of the spike-in proteins (in this case the different conditions that will be tested in DE analysis).

```
se <- load_spike_data(data,
                      md,
                      spike_column = "Spiked",
                      spike_value = "ECOLI",
                      spike_concentration = "Concentration",
                      protein_column = "Protein.IDs",
                      gene_column = "Gene.names",
                      ref_samples = NULL,
                      batch_column = NULL,
                      condition_column = "Condition",
                      label_column = "Label")
```

# 4 Overview of the Data

To get an overview on the number of identified (non-NA) spike-in proteins per sample, you can use the `plot_identified_spiked_proteins()` function.

```
plot_identified_spiked_proteins(se)
#> Condition of SummarizedExperiment used!
#> Label of SummarizedExperiment used!
```

![Overview of the number of identified spike-in proteins per sample, colored by condition. In this data set, the conditions were labeled with H and L. H indicates the sample group with high concentrations of spike-in proteins added to the background proteome, while L represents the sample group with low concentrations.](data:image/png;base64...)

Figure 4.1: Overview of the number of identified spike-in proteins per sample, colored by condition. In this data set, the conditions were labeled with H and L. H indicates the sample group with high concentrations of spike-in proteins added to the background proteome, while L represents the sample group with low concentrations.

To compare the distributions of spike-in and human proteins in the different sample groups (here high-low), use the function `plot_histogram_spiked()`. Again, “condition = NULL” means that the condition specified by loading the data is used, but you can also specify any other column of the meta data.

```
plot_histogram_spiked(se, condition = NULL)
#> Condition of SummarizedExperiment used!
```

![Histogram of the protein intensities of the spike-in proteins (ECOLI) and the background proteins (HUMAN) in the different conditions. This plot helps to compare the distributions of spike-in (red) and background proteins (grey) for the different spike-in levels.](data:image/png;base64...)

Figure 4.2: Histogram of the protein intensities of the spike-in proteins (ECOLI) and the background proteins (HUMAN) in the different conditions. This plot helps to compare the distributions of spike-in (red) and background proteins (grey) for the different spike-in levels.

If you want to have a look at the amount of actual measure spike-in, you can use the `plot_profiles_spiked()` function. Moreover, you can analyze whether the intensities of the background proteins, here HUMAN proteins, are constant across the different spike-in concentrations.

```
plot_profiles_spiked(se, xlab = "Concentration")
```

![Profiles of the spike-in proteins (ECOLI) and the background proteins (HUMAN) in the different conditions. This plot helps to analyze whether the intensities of the background proteins are constant across the different spike-in concentrations. Spike-in proteins (red) should increase in intensity with increasing spike-in concentrations, while background proteins (grey) should remain constant.](data:image/png;base64...)

Figure 4.3: Profiles of the spike-in proteins (ECOLI) and the background proteins (HUMAN) in the different conditions. This plot helps to analyze whether the intensities of the background proteins are constant across the different spike-in concentrations. Spike-in proteins (red) should increase in intensity with increasing spike-in concentrations, while background proteins (grey) should remain constant.

# 5 Preprocessing, Normalization, & Imputation

Given that the preprocessing (including filtering of proteins and samples), normalization, and imputation operations remain invariant for spike-in data sets compared to real-world data sets, the same methodologies can be employed across both types. In this context, normalization will only be demonstrated here as the performance of the methods will be evaluated in DE analysis, while detailed descriptions of the other functionalities are available in preceding sections.

```
se_norm <- normalize_se(se, c("Median", "Mean", "MAD", "LoessF"),
                        combination_pattern = NULL)
#> Median completed.
#> Mean completed.
#> MAD completed.
#> LoessF completed.
```

# 6 Differential Expression Analysis

Due to the known spike-in concentrations, the normalization methods can be evaluated based on their ability to detect DE proteins. The DE analysis can be conducted using the same methodology as for real-world data sets. However, other visualization options are available and performance metrics can be calculated for spike-in data sets.

## 6.1 Run DE Analysis

First, you need to specify the comparisons you want to perform in DE analysis. For this, a special function was developed which helps to build the right comparison strings.

```
comparisons <- specify_comparisons(se_norm, condition = "Condition",
                                   sep = NULL, control = NULL)
```

Then you can run DE analysis:

```
de_res <- run_DE(se = se_norm,
                     comparisons = comparisons,
                     ain = NULL,
                     condition = NULL,
                     DE_method = "limma",
                     covariate = NULL,
                     logFC = TRUE,
                     logFC_up = 1,
                     logFC_down = -1,
                     p_adj = TRUE,
                     alpha = 0.05,
                     B = 100,
                     K = 500)
#> Condition of SummarizedExperiment used!
#> All assays of the SummarizedExperiment will be used.
#> DE Analysis will not be performed on raw data.
#> log2: DE analysis completed.
#> Median: DE analysis completed.
#> Mean: DE analysis completed.
#> MAD: DE analysis completed.
#> LoessF: DE analysis completed.
```

## 6.2 Evaluate DE Results with Performance Metrics

Before being able to visualize the DE results, you need to run `get_spiked_stats_DE()` to calculate multiple performance metrics, such as the number of true positives, number fo false positives, etc.

```
stats <- get_spiked_stats_DE(se_norm, de_res)

# Show tp, fp, fn, tn, with F1 score
knitr::kable(stats[,c("Assay", "Comparison", "TP", "FP", "FN", "TN", "F1Score")], caption = "Performance metrics for the different normalization methods and pairwise comparisons.", digits = 2)
```

Table 6.1: Performance metrics for the different normalization methods and pairwise comparisons.

| Assay | Comparison | TP | FP | FN | TN | F1Score |
| --- | --- | --- | --- | --- | --- | --- |
| LoessF | L-H | 170 | 27 | 92 | 711 | 0.74 |
| MAD | L-H | 0 | 1 | 262 | 737 | 0.00 |
| Mean | L-H | 141 | 65 | 121 | 673 | 0.60 |
| Median | L-H | 160 | 46 | 102 | 692 | 0.68 |
| log2 | L-H | 163 | 40 | 99 | 698 | 0.70 |

You have different options to visualize the amount of true and false positives for the different normalization techniques and pairwise comparisons. For all these functions, you can specify a subset of normalization methods and comparisons. If you do not specify anything, all normalization methods and comparisons of the “stats” data frame are used.

The `plot_TP_FP_spiked_bar()` function generates a barplot showing the number of false positives and true positives for each normalization method and is facetted by pairwise comparison.

```
plot_TP_FP_spiked_bar(stats, ain = c("Median", "Mean", "MAD", "LoessF"),
                      comparisons = NULL)
#> All comparisons of stats will be visualized.
```

![Barplot showing the number of false positives (FP) and true positives (TP) for each normalization method and is facetted by pairwise comparison. This plot shows the impact of normalization on DE results.](data:image/png;base64...)

Figure 6.1: Barplot showing the number of false positives (FP) and true positives (TP) for each normalization method and is facetted by pairwise comparison. This plot shows the impact of normalization on DE results.

If many pairwise comparisons were performed, the `plot_TP_FP_spiked_box()` function can be used to visualize the distribution of true and false positives for all pairwise comparisons in a boxplot.

Given that the data set encompasses merely two distinct spike-in concentrations and therefore only one pairwise comparison has been conducted in DE analysis, a barplot would be more appropriate. Nonetheless, for demonstration purposes, a boxplot will be used here.

```
plot_TP_FP_spiked_box(stats, ain = c("Median", "Mean", "MAD", "LoessF"),
                      comparisons = NULL)
#> All comparisons of stats will be visualized.
```

![Boxplot showing the distribution of true positives (TP) and false positives (FP) for each normalization method across all pairwise comparisons. This plot helps to visualize the distribution of TP and FP for each normalization method. Since in this dataset, only two conditions are available, hence a single pairwise comparison, this plot is not very informative.](data:image/png;base64...)

Figure 6.2: Boxplot showing the distribution of true positives (TP) and false positives (FP) for each normalization method across all pairwise comparisons. This plot helps to visualize the distribution of TP and FP for each normalization method. Since in this dataset, only two conditions are available, hence a single pairwise comparison, this plot is not very informative.

Furthermore, similarly the `plot_TP_FP_spiked_scatter()` function can be used to visualize the true and false positives in a scatter plot. Here, a scatterplot of the median true positives and false positives is calculated across all comparisons and displayed for each normalization method with errorbars showing the Q1 and Q3. Here again, this plot is more suitable for data sets with multiple pairwise comparisons.

```
plot_TP_FP_spiked_scatter(stats, ain = NULL, comparisons = NULL)
#> All comparisons of stats will be visualized.
#> All normalization methods of de_res will be visualized.
```

![Scatter plot showing the median true positives (TP) and false positives (FP) for each normalization method across all pairwise comparisons.](data:image/png;base64...)

Figure 6.3: Scatter plot showing the median true positives (TP) and false positives (FP) for each normalization method across all pairwise comparisons.

Furthermore, other performance metrics that the number of true positives and false positives can be visualized using the `plot_stats_spiked_heatmap()` function. Here, currently, the sensitivity, specificity, precision, FPR, F1 score, and accuracy can be visualized for the different normalization methods and pairwise comparisons.

```
plot_stats_spiked_heatmap(stats, ain = c("Median", "Mean", "MAD"),
                          metrics = c("Precision", "F1Score"))
#> All comparisons of stats will be visualized.
```

![Heatmap showing a selection of performance metrics for the different normalization methods and pairwise comparisons.](data:image/png;base64...)

Figure 6.4: Heatmap showing a selection of performance metrics for the different normalization methods and pairwise comparisons.

Finally, receiver operating characteristic (ROC) curves and AUC values can be calculated and visualized using the `plot_ROC_AUC_spiked()` function. This function returns a plot showing the ROC curves, a bar plot with the AUC values for each comparison, and a boxplot with the distributions of AUC values across all comparisons.

```
plot_ROC_AUC_spiked(se_norm, de_res, ain = c("Median", "Mean", "LoessF"),
                    comparisons = NULL)
#> All comparisons of de_res will be visualized.
#> $ROC
```

![ROC curves and AUC barplots and boxplots for the different normalization methods and pairwise comparisons. AUC barplots are shown for each pairwise comparison, while the boxplot shows the distribution of AUC values across all comparisons.](data:image/png;base64...)

Figure 6.5: ROC curves and AUC barplots and boxplots for the different normalization methods and pairwise comparisons. AUC barplots are shown for each pairwise comparison, while the boxplot shows the distribution of AUC values across all comparisons.

```
#>
#> $AUC_bars
```

![ROC curves and AUC barplots and boxplots for the different normalization methods and pairwise comparisons. AUC barplots are shown for each pairwise comparison, while the boxplot shows the distribution of AUC values across all comparisons.](data:image/png;base64...)

Figure 6.6: ROC curves and AUC barplots and boxplots for the different normalization methods and pairwise comparisons. AUC barplots are shown for each pairwise comparison, while the boxplot shows the distribution of AUC values across all comparisons.

```
#>
#> $AUC_box
```

![ROC curves and AUC barplots and boxplots for the different normalization methods and pairwise comparisons. AUC barplots are shown for each pairwise comparison, while the boxplot shows the distribution of AUC values across all comparisons.](data:image/png;base64...)

Figure 6.7: ROC curves and AUC barplots and boxplots for the different normalization methods and pairwise comparisons. AUC barplots are shown for each pairwise comparison, while the boxplot shows the distribution of AUC values across all comparisons.

```
#>
#> $AUC_dt
#>   PANEL Comparison COORD group  Assay       AUC
#> 1     1        L-H     1     1 LoessF 0.8784788
#> 2     1        L-H     1     2   Mean 0.7851968
#> 3     1        L-H     1     3 Median 0.8792709
```

## 6.3 Log Fold Change Distributions

Furthermore, you can visualize the distribution of log fold changes for the different conditions using the `plot_fold_changes_spiked()` function. The fold changes of the background proteins should be centered around zero, while the spike-in proteins should be centered around the actual log fold change calculated based on the spike-in concentrations.

```
plot_fold_changes_spiked(se_norm, de_res, condition = "Condition",
                         ain = c("Median", "Mean", "MAD"), comparisons = NULL)
#> All comparisons of de_res will be visualized.
```

![Boxplot showing the distribution of log fold changes for the different normalization methods and pairwise comparisons. The dotted blue line is at y = 0 because logFC values of the background proteins should be centered around 0, while the dotted red line shows the expected logFC value based on the spike-in concentrations of both sample groups.](data:image/png;base64...)

Figure 6.8: Boxplot showing the distribution of log fold changes for the different normalization methods and pairwise comparisons. The dotted blue line is at y = 0 because logFC values of the background proteins should be centered around 0, while the dotted red line shows the expected logFC value based on the spike-in concentrations of both sample groups.

## 6.4 P-Value Distributions

Similarly, the distributions of the p-values can be visualized using the `plot_pvalues_spiked()` function.

```
plot_pvalues_spiked(se_norm, de_res, ain = c("Median", "Mean", "MAD"),
                    comparisons = NULL)
#> All comparisons of de_res will be visualized.
```

![Boxplot showing the distribution of p-values for the different normalization methods and pairwise comparisons.](data:image/png;base64...)

Figure 6.9: Boxplot showing the distribution of p-values for the different normalization methods and pairwise comparisons.

## 6.5 Log Fold Change Thresholds

Due to the high amount of false positives encountered in spike-in data sets, we provided a function to test for different log fold change thresholds to try to reduce the amount of false positives. The function `plot_logFC_thresholds_spiked()` can be used to visualize the number of true positives and false positives for different log fold change thresholds.

```
plots <- plot_logFC_thresholds_spiked(se_norm, de_res, condition = NULL,
                                      ain = c("Median", "Mean", "MAD"),
                                      nrow = 1, alpha = 0.05)
#> All comparisons of de_res will be visualized.
#> Condition of SummarizedExperiment used!
```

```
plots[[1]]
```

![Barplot showing the number of true positives for each normalization method and pairwise comparison for different log fold change thresholds. This plot helps to analyze the impact of different log fold change thresholds on the number of true positives. The dotted line in the plot shows the expected logFC value based on the spike-in concentrations of both sample groups.](data:image/png;base64...)

Figure 6.10: Barplot showing the number of true positives for each normalization method and pairwise comparison for different log fold change thresholds. This plot helps to analyze the impact of different log fold change thresholds on the number of true positives. The dotted line in the plot shows the expected logFC value based on the spike-in concentrations of both sample groups.

```
plots[[2]]
```

![Barplot showing the number of false positives for each normalization method and pairwise comparison for different log fold change thresholds. This plot helps to analyze the impact of different log fold change thresholds on the number of false positives. The dotted line in the plot shows the expected logFC value based on the spike-in concentrations of both sample groups.](data:image/png;base64...)

Figure 6.11: Barplot showing the number of false positives for each normalization method and pairwise comparison for different log fold change thresholds. This plot helps to analyze the impact of different log fold change thresholds on the number of false positives. The dotted line in the plot shows the expected logFC value based on the spike-in concentrations of both sample groups.

# 7 Session Info

```
utils::sessionInfo()
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
#>  [1] PRONE_1.4.0                 SummarizedExperiment_1.40.0
#>  [3] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [5] Seqinfo_1.0.0               IRanges_2.44.0
#>  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
#>  [9] generics_0.1.4              MatrixGenerics_1.22.0
#> [11] matrixStats_1.5.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
#>   [3] shape_1.4.6.1               MultiAssayExperiment_1.36.0
#>   [5] magrittr_2.0.4              magick_2.9.0
#>   [7] farver_2.1.2                MALDIquant_1.22.3
#>   [9] rmarkdown_2.30              GlobalOptions_0.1.2
#>  [11] fs_1.6.6                    vctrs_0.6.5
#>  [13] Cairo_1.7-0                 RCurl_1.98-1.17
#>  [15] htmltools_0.5.8.1           S4Arrays_1.10.0
#>  [17] BiocBaseUtils_1.12.0        SparseArray_1.10.0
#>  [19] mzID_1.48.0                 sass_0.4.10
#>  [21] bslib_0.9.0                 htmlwidgets_1.6.4
#>  [23] plyr_1.8.9                  impute_1.84.0
#>  [25] plotly_4.11.0               cachem_1.1.0
#>  [27] igraph_2.2.1                lifecycle_1.0.4
#>  [29] iterators_1.0.14            pkgconfig_2.0.3
#>  [31] Matrix_1.7-4                R6_2.6.1
#>  [33] fastmap_1.2.0               clue_0.3-66
#>  [35] digest_0.6.37               pcaMethods_2.2.0
#>  [37] colorspace_2.1-2            crosstalk_1.2.2
#>  [39] vegan_2.7-2                 Spectra_1.20.0
#>  [41] labeling_0.4.3              httr_1.4.7
#>  [43] abind_1.4-8                 mgcv_1.9-3
#>  [45] compiler_4.5.1              withr_3.0.2
#>  [47] doParallel_1.0.17           S7_0.2.0
#>  [49] BiocParallel_1.44.0         UpSetR_1.4.0
#>  [51] MASS_7.3-65                 DelayedArray_0.36.0
#>  [53] rjson_0.2.23                permute_0.9-8
#>  [55] mzR_2.44.0                  tools_4.5.1
#>  [57] PSMatch_1.14.0              glue_1.8.0
#>  [59] nlme_3.1-168                QFeatures_1.20.0
#>  [61] gridtext_0.1.5              grid_4.5.1
#>  [63] cluster_2.1.8.1             reshape2_1.4.4
#>  [65] gtable_0.3.6                preprocessCore_1.72.0
#>  [67] tidyr_1.3.1                 data.table_1.17.8
#>  [69] MetaboCoreUtils_1.18.0      xml2_1.4.1
#>  [71] XVector_0.50.0              foreach_1.5.2
#>  [73] pillar_1.11.1               stringr_1.5.2
#>  [75] limma_3.66.0                circlize_0.4.16
#>  [77] splines_4.5.1               dplyr_1.1.4
#>  [79] ggtext_0.1.2                lattice_0.22-7
#>  [81] tidyselect_1.2.1            ComplexHeatmap_2.26.0
#>  [83] knitr_1.50                  gridExtra_2.3
#>  [85] bookdown_0.45               ProtGenerics_1.42.0
#>  [87] xfun_0.53                   statmod_1.5.1
#>  [89] plotROC_2.3.3               MSnbase_2.36.0
#>  [91] DT_0.34.0                   stringi_1.8.7
#>  [93] lazyeval_0.2.2              yaml_2.3.10
#>  [95] NormalyzerDE_1.28.0         evaluate_1.0.5
#>  [97] codetools_0.2-20            MsCoreUtils_1.22.0
#>  [99] tibble_3.3.0                BiocManager_1.30.26
#> [101] cli_3.6.5                   affyio_1.80.0
#> [103] jquerylib_0.1.4             dichromat_2.0-0.1
#> [105] Rcpp_1.1.0                  gprofiler2_0.2.3
#> [107] png_0.1-8                   XML_3.99-0.19
#> [109] parallel_4.5.1              ggplot2_4.0.0
#> [111] dendsort_0.3.4              AnnotationFilter_1.34.0
#> [113] bitops_1.0-9                viridisLite_0.4.2
#> [115] scales_1.4.0                affy_1.88.0
#> [117] ncdf4_1.24                  purrr_1.1.0
#> [119] crayon_1.5.3                POMA_1.20.0
#> [121] GetoptLong_1.0.5            rlang_1.1.6
#> [123] vsn_3.78.0
```

# References

Cox, Jürgen, Marco Y. Hein, Christian A. Luber, Igor Paron, Nagarjuna Nagaraj, and Matthias Mann. 2014. “Accurate Proteome-Wide Label-Free Quantification by Delayed Normalization and Maximal Peptide Ratio Extraction, Termed Maxlfq.” *Molecular & Cellular Proteomics* 13 (9): 2513–26. <https://doi.org/10.1074/mcp.M113.031591>.