# Normalization

#### Lis Arend

* [1 Load PRONE Package](#load-prone-package)
* [2 Load Data (TMT)](#load-data-tmt)
* [3 Normalization](#normalization)
* [4 Qualitative and Quantitative Evaluation](#qualitative-and-quantitative-evaluation)
  + [4.1 Visual Inspection](#visual-inspection)
  + [4.2 Intragroup Variation](#intragroup-variation)
* [5 Subset SummarizedExperiment](#subset-summarizedexperiment)
* [6 Session Info](#session-info)
* [References](#references)

# 1 Load PRONE Package

```
# Load and attach PRONE
library(PRONE)
```

# 2 Load Data (TMT)

Here, we are directly working with the [SummarizedExperiment](https://bioconductor.org/packages/release/bioc/html/SummarizedExperiment.html) data. For more information on how to create the SummarizedExperiment from a proteomics data set, please refer to the [“Get Started”](PRONE.html) vignette.

The example TMT data set originates from (Biadglegne et al. 2022).

```
data("tuberculosis_TMT_se")
se <- tuberculosis_TMT_se
```

This SummarizedExperiment object already includes data of different normalization methods. Since this vignette should show you how to use the PRONE workflow for novel proteomics data, we will remove the normalized data and only keep the raw and log2 data that are available after loading the data accordingly.

```
se <- subset_SE_by_norm(se, ain = c("raw", "log2"))
```

# 3 Normalization

For normalization, there are multiple functions available which can be used to normalize the data. First of all, to know which normalization methods can be applied:

```
get_normalization_methods()
#>  [1] "GlobalMean"    "GlobalMedian"  "Median"        "Mean"
#>  [5] "IRS"           "Quantile"      "VSN"           "LoessF"
#>  [9] "LoessCyc"      "RLR"           "RlrMA"         "RlrMACyc"
#> [13] "EigenMS"       "MAD"           "RobNorm"       "TMM"
#> [17] "limBE"         "NormicsVSN"    "NormicsMedian"
```

You can use `normalize_se()` by specifying all normalization methods you want to apply on the data. For instance, if you want to perform RobNorm, median, and mean normalization, just execute this line:

```
se_norm <- normalize_se(se, c("RobNorm", "Mean", "Median"),
                        combination_pattern = NULL)
#> RobNorm completed.
#> Mean completed.
#> Median completed.
```

Tandem mass tag (TMT), a chemical labeling method that enables the simultaneous MS-analysis of up to 18 samples pooled together, is increasingly being applied in large-scale proteomic studies. Since the integration of multiple TMT batches within a single analysis leads to high batch variation and affects data quality, a batch effect correction method, such as internal reference scaling (IRS) or the `limma::removeBatchEffects` method (in PRONE: limBE), is required to adjust for these systematic biases. Commonly, batch effect correction is applied after basic normalization. However, the order of normalization and batch effect correction can be changed in PRONE.

For instance, if you want to perform IRS to reduce the batch effects on top of the previously normalized data, you can use the combination pattern “*on*”.

```
se_norm <- normalize_se(se, c("RobNorm", "Mean", "Median", "IRS_on_RobNorm",
                        "IRS_on_Mean", "IRS_on_Median"),
                        combination_pattern = "_on_")
#> RobNorm completed.
#> Mean completed.
#> Median completed.
#> IRS normalization performed on RobNorm-normalized data completed.
#> IRS normalization performed on Mean-normalized data completed.
#> IRS normalization performed on Median-normalized data completed.
```

Finally, you can also normalize your data by applying the specific normalization method. This makes it possible to design the parameters of an individual function more specifically. For instance, if you want to normalize the data by the median, you can use the function `medianNorm()`. By default, median normalization is performed on raw-data. Using the individual normalization functions, you can easily specify

```
se_norm <- medianNorm(se_norm, ain = "log2", aout = "Median")
```

All normalized intensities are stored in the SummarizedExperiment object and you can check the already performed normalization techniques using:

```
names(assays(se_norm))
#> [1] "raw"            "log2"           "RobNorm"        "Mean"
#> [5] "Median"         "IRS_on_RobNorm" "IRS_on_Mean"    "IRS_on_Median"
```

We suggest using the default value of the on\_raw parameter. This parameter specifies whether the data should be normalized on raw or log2-transformed data. The default value of the “on\_raw” parameters was made for each normalization method individually based on publications.

# 4 Qualitative and Quantitative Evaluation

Sample distributions are often skewed due to the systematic biases introduced throughout all steps of an MS-experiment. To evaluate the performance of the normalization methods, the distribution of the normalized data can be visualized using boxplots. One would expect to align the sample distributions more closely after normalization.

Moreover, since normalization tries to remove the technical bias while keeping the biological variation, PCA plots of the log2-transformed data should be used to analyze if the technical bias is more prominent than the biological variation. After normalization, the samples should cluster according to the biological groups rather than the technical biases. So it may be helpful to analyze the PCA plots of the different normalization techniques to see which normalization method mostly reduced the technical bias.

Finally, the assessment of the normalization methods is commonly centered on their ability to decrease intragroup variation between samples, using intragroup pooled coefficient of variation (PCV), pooled estimate of variance (PEV), and pooled median absolute deviation (PMAD) as measures of variability. Furthermore, the Pearson correlation between samples is used to measure the similarity of the samples within the same group. A normalization method should reduce intragroup variation between samples and increases the correlation between samples within the same group. However, please do not focus solely on intragroup variation, but also consider the other evaluation methods and perform differential expression analysis to further evaluate the methods and analyze the impact of normalization on the downstream results. More details on how to evaluate the performance of the normalization techniques are coming along with our paper. Once it is published, it will be referenced here.

Hence, PRONE offers many functions to comparatively evaluate the performance of the normalization methods. Notably, the parameter “ain” can always be set. By specifying “ain = NULL”, all normalization methods that were previously performed and are saved in the SummarizedExperiment object are considered. If you want to evaluate only a selection of normalization methods, you can specify them in the “ain” parameter. For instance, if you want to evaluate only the IRS\_on\_RobNorm and Mean normalization methods, you can set “ain = c(”IRS\_on\_RobNorm“,”Mean“)”.

## 4.1 Visual Inspection

You can comparatively visualize the normalized data by using the function `plot_boxplots()`, `plot_densities()`, and `plot_pca()`.

### 4.1.1 Boxplots of Normalized Data

```
plot_boxplots(se_norm, ain = NULL, color_by = NULL,
              label_by = NULL, ncol = 3, facet_norm = TRUE) +
  ggplot2::theme(legend.position = "bottom", legend.direction = "horizontal")
#> All assays of the SummarizedExperiment will be used.
#> Condition of SummarizedExperiment used!
#> Label of SummarizedExperiment used!
```

![Boxplots of protein intensities of all normalization methods of the SummarizedExperiment object. This plot shows the protein distributions across samples.](data:image/png;base64...)

Figure 4.1: Boxplots of protein intensities of all normalization methods of the SummarizedExperiment object. This plot shows the protein distributions across samples.

But you can also just plot a selection of normalization methods and color for instance by batch:

```
plot_boxplots(se_norm, ain = c("IRS_on_RobNorm", "IRS_on_Median"),
              color_by = "Pool", label_by = NULL, facet_norm = TRUE)
#> Label of SummarizedExperiment used!
```

![Boxplots of protein intensities of a selection of normalization methods and colored by batch. This plot shows the protein distributions across samples.](data:image/png;base64...)

Figure 4.2: Boxplots of protein intensities of a selection of normalization methods and colored by batch. This plot shows the protein distributions across samples.

Another option that you have is to return the boxplots for each normalized data independently as a single ggplot object. For this, you need to set facet = FALSE:

```
plot_boxplots(se_norm, ain = c("IRS_on_RobNorm", "IRS_on_Median"),
              color_by = "Pool", label_by = NULL, facet_norm = FALSE)
#> Label of SummarizedExperiment used!
#> $IRS_on_RobNorm
```

![Single boxplot of protein intensities per selected normalization method and colored by batch .This plot shows the protein distributions across samples.](data:image/png;base64...)

Figure 4.3: Single boxplot of protein intensities per selected normalization method and colored by batch .This plot shows the protein distributions across samples.

```
#>
#> $IRS_on_Median
```

![Single boxplot of protein intensities per selected normalization method and colored by batch .This plot shows the protein distributions across samples.](data:image/png;base64...)

Figure 4.4: Single boxplot of protein intensities per selected normalization method and colored by batch .This plot shows the protein distributions across samples.

### 4.1.2 Densities of Normalized Data

Similarly you can visualize the densities of the normalized data.

```
plot_densities(se_norm, ain = c("IRS_on_RobNorm", "IRS_on_Median"),
               color_by = NULL, facet_norm = TRUE)
#> Condition of SummarizedExperiment used!
```

![Density plot of protein intensities of for a selection of normalization method.](data:image/png;base64...)

Figure 4.5: Density plot of protein intensities of for a selection of normalization method.

### 4.1.3 PCA of Normalized Data

Furthermore, you can visualize the normalized data in a PCA plot. Here you have some more arguments that can be specified If you decide to visualize the methods in independent plots (facet\_norm = FALSE), then a list of ggplot objects is returned. However, you have the additional option to facet by any other column of the metadata (using the facet\_by parameter). Here an example:

```
plot_PCA(se_norm, ain = c("IRS_on_RobNorm", "IRS_on_Median"),
         color_by = "Group", label_by = "No", shape_by = "Pool",
         facet_norm = FALSE, facet_by = "Group")
#> No labeling of samples.
#> $IRS_on_RobNorm
```

![Single PCA plot per normalization method, colored and faceted by condition, and shaped by batch effect. This plot helps to identify batch effects.](data:image/png;base64...)

Figure 4.6: Single PCA plot per normalization method, colored and faceted by condition, and shaped by batch effect. This plot helps to identify batch effects.

```
#>
#> $IRS_on_Median
```

![Single PCA plot per normalization method, colored and faceted by condition, and shaped by batch effect. This plot helps to identify batch effects.](data:image/png;base64...)

Figure 4.7: Single PCA plot per normalization method, colored and faceted by condition, and shaped by batch effect. This plot helps to identify batch effects.

Or you can simply plot the PCA of the normalized data next to each other. However, the facet\_by argument can then not be used. Reminder, by setting color\_by = NULL, it will be first checked if a condition has been set in the SummarizedExperiment during loading the data.

```
plot_PCA(se_norm, ain = c("IRS_on_RobNorm", "IRS_on_Median"),
         color_by = "Group", label_by = "No", shape_by = "Pool",
         facet_norm = TRUE)
#> No labeling of samples.
```

![Combined PCA plot of a selection of normalization methods, colored by condition and shaped by batch effect. This plot helps to identify batch effects.](data:image/png;base64...)

Figure 4.8: Combined PCA plot of a selection of normalization methods, colored by condition and shaped by batch effect. This plot helps to identify batch effects.

## 4.2 Intragroup Variation

In PRONE, you can evaluate the intragroup variation of the normalized data by using the functions `plot_intragroup_correlation()`, `plot_intragroup_PCV()`, `plot_intragroup_PMAD()`, and `plot_intragroup_PEV()`.

```
plot_intragroup_correlation(se_norm, ain = NULL, condition = NULL,
                            method = "pearson")
#> All assays of the SummarizedExperiment will be used.
#> Condition of SummarizedExperiment used!
```

![Intragroup similarity measured by Pearson correlation for all normalization methods of the SummarizedExperiment object. The correlation between samples within the same group was calculated for all normalization methods and sample groups..](data:image/png;base64...)

Figure 4.9: Intragroup similarity measured by Pearson correlation for all normalization methods of the SummarizedExperiment object. The correlation between samples within the same group was calculated for all normalization methods and sample groups..

You have two options to visualize intragroup PCV, PEV, and PMAD. You can either simply generate boxplots of intragroup variation of each normalization method (diff = FALSE), or you can visualize the reduction of intragroup variation of each normalization method compared to log2 (diff = TRUE).

```
plot_intragroup_PCV(se_norm, ain = NULL, condition = NULL, diff = FALSE)
#> All assays of the SummarizedExperiment will be used.
#> Condition of SummarizedExperiment used!
```

![Intragroup variation by calculation of the pooled coefficient of variation (PCV) for all normalization methods of the SummarizedExperiment object. The PCV was calculated for all normalization methods and sample groups.](data:image/png;base64...)

Figure 4.10: Intragroup variation by calculation of the pooled coefficient of variation (PCV) for all normalization methods of the SummarizedExperiment object. The PCV was calculated for all normalization methods and sample groups.

```
plot_intragroup_PEV(se_norm, ain = NULL, condition = NULL, diff = FALSE)
#> All assays of the SummarizedExperiment will be used.
#> Condition of SummarizedExperiment used!
```

![Intragroup variation by calculation of the pooled estimate of variance (PEV) for all normalization methods of the SummarizedExperiment object. The PEV was calculated for all normalization methods and sample groups.](data:image/png;base64...)

Figure 4.11: Intragroup variation by calculation of the pooled estimate of variance (PEV) for all normalization methods of the SummarizedExperiment object. The PEV was calculated for all normalization methods and sample groups.

```
plot_intragroup_PMAD(se_norm, ain = NULL, condition = NULL, diff = FALSE)
#> All assays of the SummarizedExperiment will be used.
#> Condition of SummarizedExperiment used!
```

![Intragroup variation by calculation of the pooled median absolute deviation (PMAD) for all normalization methods of the SummarizedExperiment object. The PMAD was calculated for all normalization methods and sample groups.](data:image/png;base64...)

Figure 4.12: Intragroup variation by calculation of the pooled median absolute deviation (PMAD) for all normalization methods of the SummarizedExperiment object. The PMAD was calculated for all normalization methods and sample groups.

```
plot_intragroup_PCV(se_norm, ain = NULL, condition = NULL, diff = TRUE)
#> All assays of the SummarizedExperiment will be used.
#> Condition of SummarizedExperiment used!
```

![Reduction of intragroup variation, here using PCV, for all normalization methods of the SummarizedExperiment object compared to log2.](data:image/png;base64...)

Figure 4.13: Reduction of intragroup variation, here using PCV, for all normalization methods of the SummarizedExperiment object compared to log2.

```
plot_intragroup_PEV(se_norm, ain = NULL, condition = NULL, diff = TRUE)
#> All assays of the SummarizedExperiment will be used.
#> Condition of SummarizedExperiment used!
```

![Reduction of intragroup variation, here using PEV, for all normalization methods of the SummarizedExperiment object compared to log2.](data:image/png;base64...)

Figure 4.14: Reduction of intragroup variation, here using PEV, for all normalization methods of the SummarizedExperiment object compared to log2.

```
plot_intragroup_PMAD(se_norm, ain = NULL, condition = NULL, diff = TRUE)
#> All assays of the SummarizedExperiment will be used.
#> Condition of SummarizedExperiment used!
```

![Reduction of intragroup variation, here using PMAD, for all normalization methods of the SummarizedExperiment object compared to log2.](data:image/png;base64...)

Figure 4.15: Reduction of intragroup variation, here using PMAD, for all normalization methods of the SummarizedExperiment object compared to log2.

# 5 Subset SummarizedExperiment

After the qualitative and quantitative evaluation, you may have noticed that some normalization techniques are not appropriate for the specific real-world data set. For further analysis, you want to remove them and not evaluate the specific normalization methods furthermore. For this, the `remove_assays_from_SE()` method can be used.

```
se_no_MAD <- remove_assays_from_SE(se_norm, assays_to_remove = c("Mean"))
```

In contrast, you can also subset the SummarizedExperiment object to only include specific normalization techniques using the `subset_SE_by_norm()`method.

```
se_subset <- subset_SE_by_norm(se_norm,
                               ain = c("IRS_on_RobNorm", "IRS_on_Median"))
```

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
#> [113] httr_1.4.7                  NormalyzerDE_1.28.0
#> [115] GlobalOptions_0.1.2         statmod_1.5.1
#> [117] gridtext_0.1.5              MASS_7.3-65
```

# References

Biadglegne, Fantahun, Johannes R. Schmidt, Kathrin M. Engel, Jörg Lehmann, Robert T. Lehmann, Anja Reinert, Brigitte König, Jürgen Schiller, Stefan Kalkhof, and Ulrich Sack. 2022. “Mycobacterium Tuberculosis Affects Protein and Lipid Content of Circulating Exosomes in Infected Patients Depending on Tuberculosis Disease State.” *Biomedicines* 10 (4): 783. <https://doi.org/10.3390/biomedicines10040783>.