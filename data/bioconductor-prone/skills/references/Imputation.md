# Imputation

#### Lis Arend

* [1 Load PRONE Package](#load-prone-package)
* [2 Load Data (TMT)](#load-data-tmt)
* [3 Preprocessing](#preprocessing)
* [4 Missigness in Proteomics Data](#missigness-in-proteomics-data)
* [5 Impute Data](#impute-data)
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

# 3 Preprocessing

As we have seen in the Preprocessing phase, that samples “1.HC\_Pool1” and “1.HC\_Pool2” have been removed from the data set due to their high amount of missing values (more than 80% of NAs per sample), before imputing the data we will here remove these two samples.

```
se <- remove_samples_manually(se, "Label", c("1.HC_Pool1", "1.HC_Pool2"))
#> 2 samples removed.
```

# 4 Missigness in Proteomics Data

Since proteomics data is often affected by missing values and some statistical tests do not allow a high amount of missingness in the data, people have to options to reduce the amount of missingness in the data: (1) remove proteins with missing values or (2) impute missing values.

(1): this point is already shown in the Preprocessing tutorial, where we removed samples with a high amount of missing values using a predefined threshold.

(2): this point will be discussed here.

# 5 Impute Data

Since the initial focus of PRONE was on the evaluation of the performance of normalization methods and a selection of methods was made based on an extensive literature review, the imputation methods are currently still limited. However, to ensure that PRONE offers all steps of a typical proteomics analysis workflow, we have included a basic imputation method since in some cases imputation is favored over removing a high amount of proteins.

So currently, there is only a mixed imputation method available in PRONE: k-nearest neighbor imputation for proteins with missing values at random and a left-shifted Gaussian distribution for proteins with missing values not at random. Imputation can be performed on a selection of normalized data sets using the “ain” parameter in the `impute_SE` function. The default is to impute all assays (ain = NULL).

```
se <- impute_se(se, ain = NULL)
#> Condition of SummarizedExperiment used!
#> All assays of the SummarizedExperiment will be used.
#> Imputing along margin 1 (features/rows).
#> Imputing along margin 1 (features/rows).
#> Imputing along margin 1 (features/rows).
#> Imputing along margin 1 (features/rows).
#> Imputing along margin 1 (features/rows).
#> Imputing along margin 1 (features/rows).
```

ATTENTION:

Please note that imputation can introduce bias in the data and should be used with caution. After imputing your data, have a look at the exploratory data analysis plots (such as boxplots, PCA plots, etc.) to see if the imputation method has skewed the distributions of your samples and introduced biases in your data. These visualizations options are already shown in the [“Normalization”](Normalization.html) tutorial.

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