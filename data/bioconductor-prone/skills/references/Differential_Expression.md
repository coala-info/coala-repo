# Differential Expression Analysis

#### Lis Arend

* [1 Load PRONE Package](#load-prone-package)
* [2 Load Data (TMT)](#load-data-tmt)
* [3 Normalize Data](#normalize-data)
* [4 Differential Expression Analysis](#differential-expression-analysis)
  + [4.1 Run DE Analysis](#run-de-analysis)
  + [4.2 Visualize DE Results](#visualize-de-results)
* [5 Functional enrichment analysis](#functional-enrichment-analysis)
* [6 Session Info](#session-info)
* [References](#references)

# 1 Load PRONE Package

```
library(PRONE)
```

# 2 Load Data (TMT)

Here, we are directly working with the [SummarizedExperiment](https://bioconductor.org/packages/release/bioc/html/SummarizedExperiment.html) data. For more information on how to create the SummarizedExperiment from a proteomics data set, please refer to the [“Get Started”](PRONE.html) vignette.

The example TMT data set originates from (Biadglegne et al. 2022).

```
data("tuberculosis_TMT_se")
se <- tuberculosis_TMT_se
```

# 3 Normalize Data

In order to compare the performance of different normalization methods on their ability to detect differentially expressed proteins, we performed some normalization with batch effect correction technqiues here. For more details about how to normalize data and evaluate the normalization approaches quantitatively and qualitatively using PRONE, please refer to the [“Normalization”](Normalization.html) vignette.

```
se_norm <- normalize_se(se, c("IRS_on_RobNorm", "IRS_on_Median",
                              "IRS_on_LoessF", "IRS_on_Quantile"),
                        combination_pattern = "_on_")
#> IRS normalization performed on RobNorm-normalized data completed.
#> IRS normalization performed on Median-normalized data completed.
#> LoessF normalization not yet performed. Single LoessF normalization performed now.
#> LoessF completed.
#> IRS normalization performed on LoessF-normalized data completed.
#> Quantile normalization not yet performed. Single Quantile normalization performed now.
#> Quantile completed.
#> IRS normalization performed on Quantile-normalized data completed.
```

# 4 Differential Expression Analysis

After having performed normalization and evaluated the different normalization methods via qualitative and quantitative analysis, differential expression analysis can be used to further analyze the differences of the normalization methods and assess the impact of normalization on downstream analyses.

However before, you need to remove the reference samples in case of a TMT experiment. This can be easily done with the function `remove_reference_samples()`.

```
se_norm <- remove_reference_samples(se_norm)
#> 2 reference samples removed from the SummarizedExperiment object.
```

## 4.1 Run DE Analysis

### 4.1.1 Specific Comparisons

First, you need to specify the comparisons you want to perform in DE analysis. For this, the function `specify_comparisons()` was developed which helps to build the right comparison strings.

However, you can also just simply create a vector of comparisons to ensure the correct order and handle this vector over to the DE analysis method.

```
comparisons <- specify_comparisons(se_norm, condition = "Group",
                                   sep = NULL, control = NULL)

comparisons <- c("PTB-HC", "TBL-HC", "TBL-PTB", "Rx-PTB")
```

The function `specify_comparisons()` becomes handy when having a lot of sample groups and foremost samples of multiple conditions (not the case for this dataset).

For instance, you have a data set with diabetic and healthy samples (condition) that were measured at day 3 (3d), day 7 (7d), and day 17 (d14) after operation (timepoints. In DE analysis, you want to perform comparisons between the diabetic and healthy samples at each time point but also between the different time points for a fixed condition (e.g. diabetic). Instead of writing all comparisons manually, the function helps to build the right comparison strings by only considering comparisons where at least one of the groups (timepoint or condition) remains static. For this you only need to have a column in your metadata named for instance “Condition” that combines the two groups by “*", with values diabetic\_3d, diabetic\_7d, diabetic\_14d, etc. And in the function you specify the column name "Condition" and the separator (sep = "*”).

To ensure clarity, a comparison in the form of Condition-Reference, where the logFC is positive, signifies that the protein intensity is greater in the Condition compared to the Reference.

### 4.1.2 Perform DE Analysis

The function `run_DE()` performs the DE analysis on the selected SummarizedExperiment and comparisons. A novel feature of PRONE is to compare the DE results of different normalization methods as it has been shown that normalization has an impact on downstream analyses.

Therefore, DE analysis can be performed on multiple assays (normalization methods) at once using the already known “ain” parameter.

In the following, a more detailed explanation of the other parameters is given:

* The condition of the SummarizedExperiment object, specified at the beginning, can be used (condition = NULL) or any other column of the meta data can specified.
* Three methods are available for DE analysis: limma (Ritchie et al. 2015), DEqMS (Zhu et al. 2020), and ROTS (Suomi et al. 2017).
* The logFC parameter specifies if the log2 fold change should be calculated.
* The logFC\_up and logFC\_down parameters specify the log2 fold change thresholds for up- and down-regulated proteins.
* The p\_adj parameter specifies if the p-values should be adjusted.
* The alpha parameter specifies the significance level for the p-values.

In addition, the following parameters are specific for the DE analysis methods:

* Limma (DOI: 10.18129/B9.bioc.limma):
  + The covariate parameter can be used to include a covariate in the DE analysis in case limma is performed. This can be any column of the meta data.
  + The trend parameter specifies if the trend test should be performed in case limma is used.
  + The robust parameter specifies if the robust method should be used in case limma is used.
* ROTS (DOI: 10.18129/B9.bioc.ROTS):
  + B is the number of bootstrapping and K is the number of top-ranked features for reproducibility optimization.
* DEqMS (DOI: 10.18129/B9.bioc.DEqMS)
  + The DEqMS\_PSMs\_column need to be specified. This can be any column in the `rowData(se)` that represents the number of quantified peptides or PSMs. It is used in DEqMS to estimate prior variance for proteins quantified by different number of PSMs.

```
de_res <- run_DE(se = se_norm,
                     comparisons = comparisons,
                     ain = NULL,
                     condition = NULL,
                     DE_method = "limma",
                     logFC = TRUE,
                     logFC_up = 1,
                     logFC_down = -1,
                     p_adj = TRUE,
                     alpha = 0.05,
                     covariate = NULL,
                     trend = TRUE,
                     robust = TRUE,
                     B = 100,
                     K = 500
                 )
#> Condition of SummarizedExperiment used!
#> All assays of the SummarizedExperiment will be used.
#> DE Analysis will not be performed on raw data.
#> log2: DE analysis completed.
#> RobNorm: DE analysis completed.
#> IRS_on_RobNorm: DE analysis completed.
#> Median: DE analysis completed.
#> IRS_on_Median: DE analysis completed.
#> LoessF: DE analysis completed.
#> IRS_on_LoessF: DE analysis completed.
#> Quantile: DE analysis completed.
#> IRS_on_Quantile: DE analysis completed.
```

If you want to apply other logFC or p-value threshold, there is no need to re-run the DE analysis again. With `apply_thresholds()`, you can simply change the threshold values.

For instance, if you want to not apply a logFC threshold and only consider proteins with an adjusted p-value of 0.05 as DE, just set the logFC parameter to FALSE. In this case, the proteins are not classified into up- and down-regulated but only as significant change or no change.

```
new_de_res <- apply_thresholds(de_res = de_res, logFC = FALSE, p_adj = TRUE,
                               alpha = 0.05)
```

However, if you still want to see if a protein has a positive or negative logFC, you can set the logFC parameter to TRUE with the logFC\_up and logFC\_down parameters to 0.

```
new_de_res <- apply_thresholds(de_res = de_res, logFC = TRUE,
                               logFC_up = 0, logFC_down = 0,
                               p_adj = TRUE, alpha = 0.05)
```

## 4.2 Visualize DE Results

### 4.2.1 Barplot

To get an overview of the DE results of the different normalization methods, you can visualize the number of significant DE proteins per normalization method in a barplot using `plot_overview_DE_bar()`. This plot can be generated in different ways by specifying the “plot\_type” parameter:

* single: plot a single barplot for each comparison (default)
* facet\_comp: facet the barplot by comparison
* stacked: stack the number of DE per comparison
* facet\_regulation: stack the number of DE per comparison but facet by up- and down-regulated

```
plot_overview_DE_bar(de_res, ain = NULL, comparisons = comparisons,
                     plot_type = "facet_regulation")
#> All normalization methods of de_res will be visualized.
```

![Barplot showing the number of DE proteins per normalization method colored by comparison and facetted by up- and down-regulation.](data:image/png;base64...)

Figure 4.1: Barplot showing the number of DE proteins per normalization method colored by comparison and facetted by up- and down-regulation.

You can also just visualize two specific comparisons:

```
plot_overview_DE_bar(de_res, ain = NULL, comparisons = comparisons[seq_len(2)],
                     plot_type = "facet_comp")
#> All normalization methods of de_res will be visualized.
```

![Barplot showing the number of DE proteins per normalization method faceted by comparison.](data:image/png;base64...)

Figure 4.2: Barplot showing the number of DE proteins per normalization method faceted by comparison.

#### 4.2.1.1 Tile Plot

You can also get an overview of the DE results in form of a heatmap using the `plot_overview_DE_tile()`.

```
plot_overview_DE_tile(de_res)
#> All comparisons of de_res will be visualized.
#> All normalization methods of de_res will be visualized.
```

![Heatmap showing the number of DE proteins per comparison and per normalization method.](data:image/png;base64...)

Figure 4.3: Heatmap showing the number of DE proteins per comparison and per normalization method.

#### 4.2.1.2 Volcano Plots

Another option is to generate volcano plots for each comparison. The function `plot_volcano_DE()` generates a grid of volcano plots for each normalization techniques (facet\_norm = TRUE) or for each comparison (facet\_comparison = TRUE). A list of volcano plots is returned.

```
plot_volcano_DE(de_res, ain = NULL, comparisons = comparisons[1],
                facet_norm = TRUE)
#> All normalization methods of de_res will be visualized.
#> $`PTB-HC`
```

![Volcano plots per normalization method for a single comparison.](data:image/png;base64...)

Figure 4.4: Volcano plots per normalization method for a single comparison.

#### 4.2.1.3 Heatmap of DE Results

Furthermore, you can visualize the DE results in form of a heatmap. The function `plot_heatmap_DE()` generates a heatmap of the DE results for a specific comparison and normalization method.

```
plot_heatmap_DE(se_norm, de_res, ain = c("RobNorm", "IRS_on_RobNorm"),
                comparison = "PTB-HC", condition = NULL, label_by = NULL,
                pvalue_column = "adj.P.Val")
#> Label of SummarizedExperiment used!
#> Condition of SummarizedExperiment used!
#> <simpleError in stats::hclust(stats::dist(as.matrix(data))): NA/NaN/Inf in foreign function call (arg 10)>
#> <simpleError in stats::hclust(stats::dist(as.matrix(data))): NA/NaN/Inf in foreign function call (arg 10)>
#> $RobNorm
```

![Individual heatmap of the DE results for a specific comparison and a selection of normalization methods. The adjusted p-values are added as row annotation, while the condition of each sample is shown as column annotation.](data:image/png;base64...)

Figure 4.5: Individual heatmap of the DE results for a specific comparison and a selection of normalization methods. The adjusted p-values are added as row annotation, while the condition of each sample is shown as column annotation.

```
#>
#> $IRS_on_RobNorm
```

![Individual heatmap of the DE results for a specific comparison and a selection of normalization methods. The adjusted p-values are added as row annotation, while the condition of each sample is shown as column annotation.](data:image/png;base64...)

Figure 4.6: Individual heatmap of the DE results for a specific comparison and a selection of normalization methods. The adjusted p-values are added as row annotation, while the condition of each sample is shown as column annotation.

### 4.2.2 Intersection Analysis of DE Results

Moreover, you can also intersect the DE results of different normalization methods to see how many DE proteins overlap. You can either plot for each requested comparison an individual upset plot (plot\_type = “single”) or stack the number of overlapping DE proteins per comparison (“stacked”). Not only the upset plot(s) are returned, but also a table with the intersections is provided by the `plot_upset_DE()`function.

```
intersections <- plot_upset_DE(de_res, ain = NULL,
                               comparisons = comparisons[seq_len(3)],
                               min_degree = 6, plot_type = "stacked")
#> NOTE: The installed version of ComplexUpset package is not yetcompatible with ggplot2 >= v4.0.0.Please downgrade to ggplot2 v3 to use this feature.EpiCompare will proceed without generating upset plot.
#>
if(!is.null(intersections)){
  # put legend on top due to very long comparisons
intersections$upset[[2]] <- intersections$upset[[2]] +
  ggplot2::theme(legend.position = "top", legend.direction = "vertical")
intersections$upset
}
```

Additionally, the Jaccard similarity index can be calculated to quantify the similarity of the DE results between the different normalization methods. A individual heatmap can be generated for each comparison (“plot\_type = single”), a single heatmap facetted by comparison (“facet\_comp”) or a single heatmap taking all comparisons into account (“all”) can be generated.

```
plot_jaccard_heatmap(de_res, ain = NULL, comparisons = comparisons,
                     plot_type = "all")
#> All normalization methods of de_res will be visualized.
```

![Heatmap showing the Jaccard similarity indices of the DE results between different normalization methods for all comparisons.](data:image/png;base64...)

Figure 4.7: Heatmap showing the Jaccard similarity indices of the DE results between different normalization methods for all comparisons.

PRONE offers the functionality to extract a consensus set of DEPs based on a selection of normalization methods and a threshold for the number of methods that need to agree on the DE status of a protein. The function `get_consensus_DE()` returns a list of consensus DE proteins for either each comparison separately or for all comparisons combined.

```
DT::datatable(extract_consensus_DE_candidates(de_res, ain = NULL,
                                              comparisons = comparisons,
                                              norm_thr = 0.8,
                                              per_comparison = TRUE),
              options = list(scrollX = TRUE))
```

# 5 Functional enrichment analysis

Finally, to biologically interpret the DE results of the different normalization methods, PRONE offers the ability to perform functional enrichment on the different sets of DE proteins originating from different normalization methods. The function `plot_intersection_enrichment()` can be used to visualize the functional enrichment results of the DE proteins of different normalization methods. This function returns two types of plot: a heatmap of enriched terms visualizing whether a term in enriched in the DE set of a specific normalization method and a heatmap showing Jaccard similarity coefficients to quantify the similarity of the enriched terms between the different normalization methods.

For this analysis, the `gprofiler2` package is used to perform the functional enrichment analysis. The following parameters are required:

* se: SummarizedExperiment object
* de\_res: DE results
* comparison: Specific comparison
* ain: Vector of normalization methods to perform functional enrichment
* id\_column: Column name of the rowData of the SummarizedExperiment object which includes the gene names. If MaxQuant data is provided with multiple gene names per protein group, the entries in the id\_column are split by “;”.
* organism: Organism name (gprofiler parameter, example: hsapiens, mmusculus)
* source: Data source to use (gprofiler parameter, example: KEGG, GO:BP, GO:MF, GO:CC, REAC, HP, …)

```
enrich_results <- plot_intersection_enrichment(se, de_res, comparison = "PTB-HC",
                             ain = c("IRS_on_Median", "IRS_on_RobNorm", "RobNorm"),
                             id_column = "Gene.Names", organism = "hsapiens",
                             source = "KEGG", signif_thr = 0.05)
```

```
enrich_results$enrichment_term_plot
```

![Heatmap showing enriched terms of the DE sets between different normalization methods for a specific comparison.](data:image/png;base64...)

Figure 5.1: Heatmap showing enriched terms of the DE sets between different normalization methods for a specific comparison.

```
enrich_results$jaccard_intersection_plot
```

![Heatmap showing the Jaccard similarity indices of the enriched terms between different normalization methods for a specific comparison.](data:image/png;base64...)

Figure 5.2: Heatmap showing the Jaccard similarity indices of the enriched terms between different normalization methods for a specific comparison.

# 6 Session Info

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
#>   [1] bitops_1.0-9                permute_0.9-8
#>   [3] rlang_1.1.6                 magrittr_2.0.4
#>   [5] GetoptLong_1.0.5            clue_0.3-66
#>   [7] compiler_4.5.1              mgcv_1.9-3
#>   [9] gprofiler2_0.2.3            png_0.1-8
#>  [11] vctrs_0.6.5                 reshape2_1.4.4
#>  [13] stringr_1.5.2               ProtGenerics_1.42.0
#>  [15] shape_1.4.6.1               crayon_1.5.3
#>  [17] pkgconfig_2.0.3             MetaboCoreUtils_1.18.0
#>  [19] fastmap_1.2.0               magick_2.9.0
#>  [21] XVector_0.50.0              labeling_0.4.3
#>  [23] rmarkdown_2.30              preprocessCore_1.72.0
#>  [25] purrr_1.1.0                 xfun_0.53
#>  [27] MultiAssayExperiment_1.36.0 cachem_1.1.0
#>  [29] jsonlite_2.0.0              DelayedArray_0.36.0
#>  [31] BiocParallel_1.44.0         parallel_4.5.1
#>  [33] cluster_2.1.8.1             R6_2.6.1
#>  [35] bslib_0.9.0                 stringi_1.8.7
#>  [37] RColorBrewer_1.1-3          limma_3.66.0
#>  [39] jquerylib_0.1.4             Rcpp_1.1.0
#>  [41] bookdown_0.45               iterators_1.0.14
#>  [43] knitr_1.50                  BiocBaseUtils_1.12.0
#>  [45] splines_4.5.1               Matrix_1.7-4
#>  [47] igraph_2.2.1                tidyselect_1.2.1
#>  [49] dichromat_2.0-0.1           abind_1.4-8
#>  [51] yaml_2.3.10                 vegan_2.7-2
#>  [53] doParallel_1.0.17           ggtext_0.1.2
#>  [55] codetools_0.2-20            affy_1.88.0
#>  [57] lattice_0.22-7              tibble_3.3.0
#>  [59] plyr_1.8.9                  withr_3.0.2
#>  [61] S7_0.2.0                    evaluate_1.0.5
#>  [63] Spectra_1.20.0              xml2_1.4.1
#>  [65] circlize_0.4.16             pillar_1.11.1
#>  [67] affyio_1.80.0               BiocManager_1.30.26
#>  [69] DT_0.34.0                   foreach_1.5.2
#>  [71] plotly_4.11.0               MSnbase_2.36.0
#>  [73] MALDIquant_1.22.3           ncdf4_1.24
#>  [75] RCurl_1.98-1.17             ggplot2_4.0.0
#>  [77] scales_1.4.0                glue_1.8.0
#>  [79] lazyeval_0.2.2              tools_4.5.1
#>  [81] mzID_1.48.0                 data.table_1.17.8
#>  [83] QFeatures_1.20.0            vsn_3.78.0
#>  [85] mzR_2.44.0                  fs_1.6.6
#>  [87] XML_3.99-0.19               Cairo_1.7-0
#>  [89] grid_4.5.1                  impute_1.84.0
#>  [91] tidyr_1.3.1                 crosstalk_1.2.2
#>  [93] colorspace_2.1-2            MsCoreUtils_1.22.0
#>  [95] nlme_3.1-168                PSMatch_1.14.0
#>  [97] cli_3.6.5                   viridisLite_0.4.2
#>  [99] S4Arrays_1.10.0             ComplexHeatmap_2.26.0
#> [101] dplyr_1.1.4                 AnnotationFilter_1.34.0
#> [103] pcaMethods_2.2.0            gtable_0.3.6
#> [105] sass_0.4.10                 digest_0.6.37
#> [107] SparseArray_1.10.0          htmlwidgets_1.6.4
#> [109] rjson_0.2.23                farver_2.1.2
#> [111] htmltools_0.5.8.1           lifecycle_1.0.4
#> [113] httr_1.4.7                  GlobalOptions_0.1.2
#> [115] statmod_1.5.1               gridtext_0.1.5
#> [117] MASS_7.3-65
```

# References

Biadglegne, Fantahun, Johannes R. Schmidt, Kathrin M. Engel, Jörg Lehmann, Robert T. Lehmann, Anja Reinert, Brigitte König, Jürgen Schiller, Stefan Kalkhof, and Ulrich Sack. 2022. “Mycobacterium Tuberculosis Affects Protein and Lipid Content of Circulating Exosomes in Infected Patients Depending on Tuberculosis Disease State.” *Biomedicines* 10 (4): 783. <https://doi.org/10.3390/biomedicines10040783>.

Ritchie, Matthew E., Belinda Phipson, Di Wu, Yifang Hu, Charity W. Law, Wei Shi, and Gordon K. Smyth. 2015. “Limma Powers Differential Expression Analyses for Rna-Sequencing and Microarray Studies.” *Nucleic Acids Research* 43 (7): e47–e47. <https://doi.org/10.1093/nar/gkv007>.

Suomi, Tomi, Fatemeh Seyednasrollah, Maria K. Jaakkola, Thomas Faux, and Laura L. Elo. 2017. “ROTS: An R Package for Reproducibility-Optimized Statistical Testing.” Edited by Timothée Poisot. *PLOS Computational Biology* 13 (5): e1005562. <https://doi.org/10.1371/journal.pcbi.1005562>.

Zhu, Yafeng, Lukas M. Orre, Yan Zhou Tran, Georgios Mermelekas, Henrik J. Johansson, Alina Malyutina, Simon Anders, and Janne Lehtiö. 2020. “Deqms: A Method for Accurate Variance Estimation in Differential Protein Expression Analysis.” *Molecular & Cellular Proteomics* 19 (6): 1047–57. <https://doi.org/10.1074/mcp.TIR119.001646>.