# ClustAll User’s Guide

Asier Ortega-Legarreta and Sara Palomino-Echeverria

#### 29 October 2025

#### Package

ClustAll 1.6.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 ClustAll key features:](#clustall-key-features)
  + [1.2 Interpreting ClustAll Stratification Output](#interpreting-clustall-stratification-output)
* [2 Installation](#installation)
* [3 ClustAll Application Example](#clustall-application-example)
  + [3.1 Get data from example](#get-data-from-example)
  + [3.2 Create the ClustAll object](#create-the-clustall-object)
  + [3.3 Execute the ClustAll algorithm](#execute-the-clustall-algorithm)
  + [3.4 Represent the Jaccard Distance between population-robust stratifications](#represent-the-jaccard-distance-between-population-robust-stratifications)
  + [3.5 Retrieve stratification representatives](#retrieve-stratification-representatives)
  + [3.6 Generate Sankey diagrams comparing pairs of stratifications, or a stratification with the ground truth](#generate-sankey-diagrams-comparing-pairs-of-stratifications-or-a-stratification-with-the-ground-truth)
  + [3.7 Retrieve the original dataset with the selected ClustAll stratification(s)](#retrieve-the-original-dataset-with-the-selected-clustall-stratifications)
  + [3.8 Assess the results the sensitivity and specifity of the selected ClustAll stratifications against ground truth (if available)](#assess-the-results-the-sensitivity-and-specifity-of-the-selected-clustall-stratifications-against-ground-truth-if-available)
* [4 Session Info](#session-info)

# 1 Introduction

ClustAll is an R package designed for patient stratification in complex diseases. It addresses common challenges encountered in clinical data analysis and provides a versatile framework for identifying patient subgroups.

Patient stratification is essential in biomedical research for understanding disease heterogeneity, identifying prognostic factors, and guiding personalized treatment strategies. The ClustAll underlying concept is that a robust stratification should be reproducible through various clustering methods. ClustAll employs diverse distance metrics (Correlation-based distance and Gower distance) and clustering methods (K-Means, K-Medoids, and H-Clust).

## 1.1 ClustAll key features:

* **Handles Diverse Data Types**, including missing values, mixed data, and correlated variables.
* **Provides Multiple Stratification Solutions**, enabling exploration of different clustering algorithms and parameters.
* **Robustness Analysis**, to identify stable and reproducible clusters.
* **Validation** , for assessing the reliability of clustering results using clinical phenotypes (ground truth) if available.
* **Visualization** functions for interpreting clustering results and comparing different stratifications.

## 1.2 Interpreting ClustAll Stratification Output

The names of ClustAll stratification outputs consist of a letter followed by a number, such as *cuts\_a\_9*. The letter denotes the combination of distance metric and clustering method utilized to generate the particular stratification, while the number corresponds to the embedding derived from the depth at which the dendrogram with grouped variables was cut.

Table 1: ClustAll Stratification Output Interpretation

| Nomenclature | Distance.Metric | Clustering.Method |
| --- | --- | --- |
| a | Correlation | K-means |
| b | Correlation | Hierarchical Clustering |
| c | Gower | K-medoids |
| d | Gower | Hierarchical-Clustering |

![](data:image/jpeg;base64...)

Schematic representation of the ClustAll pipeline

# 2 Installation

ClustAll is developed using S4 object-oriented programming, and requires R (>=4.2.0). It utilizes other R packages that are currently available from CRAN and Bioconductor.

You can find the package repository on GitHub, [ClustAll](https://github.com/translationalBioinformaticsUnit/ClustAll).

The ClustAll package can be downloaded and installed by running the following code within R:

```
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager ")

BiocManager::install("ClustAll")
```

After installation, load the ClustAll package:

```
library(ClustAll)
```

# 3 ClustAll Application Example

We will use the data provided in the data package [ClustAll](https://github.com/translationalBioinformaticsUnit/ClustAll) to demonstrate how to stratify a population using clinical data.

**Breast Cancer Wisconsin (Diagnostic)** ClustAll includes a real dataset of breast cancer, described at [doi: 10.24432/C5DW2B](https://doi.org/10.24432/C5DW2B). This dataset comprises two types of features —categorical and numerical— derived from a digitized image of a fine needle aspirate (FNA) of a breast mass from 659 patients. Each patient is characterized by 30 features (10x3) and belongs to one of two target classes: ‘malignant’ or ‘benign’. To showcase ClustAll’s when dealing with missing data, a modification with random missing values was applied to the dataset, demonstrating the package’s resilience in handling missing data. The breast cancer dataset includes the following features:

1. **radius:** Mean of distances from the center to points on the perimeter.
2. **texture:** Standard deviation of gray-scale values.
3. **perimeter:** Perimeter of the breast mass affected by the cancer.
4. **area:** Area of the breast mass affected by the cancer
5. **smoothness:** Local variation in radius lengths.
6. **compactness:** (Perimeter^2 / Area) - 1.0.
7. **concavity:** Severity of concave portions of the contour.
8. **concave points:** Number of concave portions of the contour.
9. **symmetry:** Degree of symmetry in the shape and structure of the breast mass, with higher values indicating greater symmetry and lower values indicating asymmetry.
10. **fractal dimension:** “Coastline approximation” - 1.

The dataset also includes the patient ID and diagnosis (M = malignant, B = benign).

We denote the data set as BreastCancerWisconsin (wdbc).

## 3.1 Get data from example

We load the breast cancer dataset, which is available in [Kaggle](https://www.kaggle.com/datasets/uciml/breast-cancer-wisconsin-data). The data set can be loaded with the following code:

```
data("BreastCancerWisconsin", package = "ClustAll")

data_use <- subset(wdbc, select=-ID)
```

An initial exploration reveals the absence of missing values. The dataset comprises 30 numerical features and one categorical feature (the ground truth). As the initial data does not contain missing values we will apply the ClustAll workflow accordingly.

```
sum(is.na(data_use))
#> [1] 0
dim(data_use)
#> [1] 569  31
```

## 3.2 Create the ClustAll object

First, the ClustAllObject is created and stored. In this step, we indicate if there is a feature that contains the ground truth (true labels) in the argument `colValidation`. This feature is not consider to compute the stratification. In this specific case, it corresponds to “Diagnosis”.

```
obj_noNA <- createClustAll(data = data_use, nImputation = NULL,
                           dataImputed = NULL, colValidation = "Diagnosis")
#> The dataset contains character values.
#> They will be transformed into categorical (more than one class) or binary (one class).
#> Before continuing, check that the transformation has been processed correctly.
#>
#> ClustALL object was created successfully. You can run runClustAll.
```

## 3.3 Execute the ClustAll algorithm

Next, we apply the ClustAll algorithm. The output is stored in a ClustAllObject, which contains the clustering results.

```
obj_noNA1 <- runClustAll(Object = obj_noNA, threads = 2, simplify = FALSE)
#>       ______ __              __   ___     __     __
#>      / ____// /__  __ _____ / /_ /   |   / /    / /
#>     / /    / // / / // ___// __// /| |  / /    / /
#>    / /___ / // /_/ /(__  )/ /_ / ___ | / /___ / /___
#>   /_____//_/ |__,_//____/ |__//_/  |_|/_____//_____/
#> Running Data Complexity Reduction and Stratification Process.
#> This step may take some time...
#>
#>
#> Calculating the correlation distance matrix of the stratifications...
#>
#>
#> Filtering non-robust stratifications...
#>
#> ClustAll pipeline finished successfully!
```

We show the object:

```
obj_noNA1
#> ClustAllObject
#> Data: Number of variables: 30. Number of patients: 569
#> Imputated: NO.
#> Number of imputations: 0
#> Processed: TRUE
#> Number of stratifications: 72
```

## 3.4 Represent the Jaccard Distance between population-robust stratifications

To display population-robust stratifications (>85% bootstrapping stability), we call `plotJaccard`, using the ClustAllObject as input. In addition, we specify the threshold to consider similar a pair of stratifications in the `stratification_similarity` argument.

In this specific case, a similarity of 0.9 reveals three different groups of alternatives for stratifying the population, indicated by the the red rectangles:

```
plotJACCARD(Object = obj_noNA1, stratification_similarity = 0.9, paint = TRUE)
```

![Correlation matrix heatmap. It depcits the similarity between population-robust stratifications. The discontinuous red rectangles highlight alternative stratifications solutions based on those stratifications that exhibit certain level of similarity. The heatmap row annotation describes the combination of parameters —distance metric, clustering method, and embedding number— from which each stratification is derived.](data:image/png;base64...)

Figure 1: Correlation matrix heatmap
It depcits the similarity between population-robust stratifications. The discontinuous red rectangles highlight alternative stratifications solutions based on those stratifications that exhibit certain level of similarity. The heatmap row annotation describes the combination of parameters —distance metric, clustering method, and embedding number— from which each stratification is derived.

## 3.5 Retrieve stratification representatives

We can displayed the centroids (a representative) from each group of alternative stratification solutions (highlighted in red squares in the previous step) using `resStratification`. Each representative stratification illustrates the number of clusters and the patients belonging to each cluster.

In this case, the alternative stratifications have been computed with the following specifications:

* cuts\_a\_28: This stratification was generated using Embedding 28 with the correlation distance metric and the kmeans clustering algorithm. It consists of two clusters, with 183 and 386 patients, respectively.
* cuts\_c\_9: This stratification was generated using Embedding 9 with the gower distance metric and the kmedoids clustering algorithm. It consists of two clusters, with 197 and 372 patients, respectively.
* cuts\_c\_4: This stratification was generated using Embedding 4 with the Gower distance metric and the kmedoids algorithm. It consists of two clusters, with 199 and 370 patients, respectively.

```
resStratification(Object = obj_noNA1, population = 0.05,
                  stratification_similarity = 0.9, all = FALSE)
#> $cuts_a_28
#> $cuts_a_28[[1]]
#>
#>   1   2
#> 183 386
#>
#>
#> $cuts_c_9
#> $cuts_c_9[[1]]
#>
#>   1   2
#> 197 372
#>
#>
#> $cuts_c_4
#> $cuts_c_4[[1]]
#>
#>   1   2
#> 199 370
```

## 3.6 Generate Sankey diagrams comparing pairs of stratifications, or a stratification with the ground truth

In order to compare two sets of representative stratifications, `plotSankey` was implemented. The ClustAllObject is used as input. In addition, we specify the pairs of stratifications we want to compare in the `clusters` argument.

In this case, the first Sankey plot illustrates patient transitions between two sets of representative stratifications (cuts\_c\_9 and cuts\_a\_28), revealing the flow and distribution of patients across the clusters. The second Sankey plot illustrates patient transitions between a representative stratifications (cuts\_a\_28) and the ground truth, revealing the flow and distribution of patients across the clusters.

Figure 2: Flow and distribution of patients across clusters
Patient transitions between representative stratifications cuts\_c\_3 and cuts\_a\_9.

Figure 3: Flow and distribution of patients across clusters
Patient transitions between representative stratifications cuts\_c\_9 and the ground truth.

## 3.7 Retrieve the original dataset with the selected ClustAll stratification(s)

The stratification representatives can be added to the initial dataset to facilitate further exploration.

In this case, we add the three stratification representatives to the dataset. For simplicity, we show the two top rows of the dataset:

```
df <- cluster2data(Object = obj_noNA1,
                   stratificationName = c("cuts_c_9","cuts_a_28","cuts_c_4"))
head(df,3)
#>   radius1 texture1 perimeter1 area1 smoothness1 compactness1 concavity1
#> 1   17.99    10.38      122.8  1001     0.11840      0.27760     0.3001
#> 2   20.57    17.77      132.9  1326     0.08474      0.07864     0.0869
#> 3   19.69    21.25      130.0  1203     0.10960      0.15990     0.1974
#>   concave_points1 symmetry1 fractal_dimension1 radius2 texture2 perimeter2
#> 1         0.14710    0.2419            0.07871  1.0950   0.9053      8.589
#> 2         0.07017    0.1812            0.05667  0.5435   0.7339      3.398
#> 3         0.12790    0.2069            0.05999  0.7456   0.7869      4.585
#>    area2 smoothness2 compactness2 concavity2 concave_points2 symmetry2
#> 1 153.40    0.006399      0.04904    0.05373         0.01587   0.03003
#> 2  74.08    0.005225      0.01308    0.01860         0.01340   0.01389
#> 3  94.03    0.006150      0.04006    0.03832         0.02058   0.02250
#>   fractal_dimension2 radius3 texture3 perimeter3 area3 smoothness3 compactness3
#> 1           0.006193   25.38    17.33      184.6  2019      0.1622       0.6656
#> 2           0.003532   24.99    23.41      158.8  1956      0.1238       0.1866
#> 3           0.004571   23.57    25.53      152.5  1709      0.1444       0.4245
#>   concavity3 concave_points3 symmetry3 fractal_dimension3 cuts_c_9 cuts_a_28
#> 1     0.7119          0.2654    0.4601            0.11890        1         1
#> 2     0.2416          0.1860    0.2750            0.08902        1         1
#> 3     0.4504          0.2430    0.3613            0.08758        1         1
#>   cuts_c_4
#> 1        1
#> 2        1
#> 3        1
```

## 3.8 Assess the results the sensitivity and specifity of the selected ClustAll stratifications against ground truth (if available)

To evaluate the performance of the selected ClustAll stratifications against ground truth, sensitivity and specificity can be assessed using `validateStratification`. Higher values indicate greater precision in the stratification process.

In this particular case, our method retrieves three stratification representatives with a sensitivity and specificity exceeding 80% and 90%, respectively, despite being computed using different methods. These results underscore the notion that a robust stratification should be consistent across diverse clustering methods.

```
# STRATIFICATION 1
validateStratification(obj_noNA1, "cuts_a_28")
#> sensitivity specificity
#>   0.8207547   0.9747899
# STRATIFICATION 2
validateStratification(obj_noNA1, "cuts_c_9")
#> sensitivity specificity
#>   0.8584906   0.9579832
# STRATIFICATION 3
validateStratification(obj_noNA1, "cuts_c_4")
#> sensitivity specificity
#>   0.8820755   0.9663866
```

# 4 Session Info

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
#> [1] ClustAll_1.6.0   BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3    jsonlite_2.0.0        shape_1.4.6.1
#>   [4] magrittr_2.0.4        magick_2.9.0          TH.data_1.1-4
#>   [7] estimability_1.5.1    modeltools_0.2-24     jomo_2.7-6
#>  [10] farver_2.1.2          nloptr_2.2.1          rmarkdown_2.30
#>  [13] GlobalOptions_0.1.2   vctrs_0.6.5           Cairo_1.7-0
#>  [16] minqa_1.2.8           tinytex_0.57          htmltools_0.5.8.1
#>  [19] broom_1.0.10          mitml_0.4-5           sass_0.4.10
#>  [22] bslib_0.9.0           htmlwidgets_1.6.4     sandwich_3.1-1
#>  [25] emmeans_2.0.0         zoo_1.8-14            cachem_1.1.0
#>  [28] networkD3_0.4.1       igraph_2.2.1          lifecycle_1.0.4
#>  [31] iterators_1.0.14      pkgconfig_2.0.3       Matrix_1.7-4
#>  [34] R6_2.6.1              fastmap_1.2.0         rbibutils_2.3
#>  [37] clue_0.3-66           digest_0.6.37         colorspace_2.1-2
#>  [40] spatial_7.3-18        ps_1.9.1              S4Vectors_0.48.0
#>  [43] rmio_0.4.0            compiler_4.5.1        doParallel_1.0.17
#>  [46] S7_0.2.0              backports_1.5.0       bigassertr_0.1.7
#>  [49] pan_1.9               MASS_7.3-65           rjson_0.2.23
#>  [52] scatterplot3d_0.3-44  fBasics_4041.97       flashClust_1.01-2
#>  [55] tools_4.5.1           bigstatsr_1.6.2       prabclus_2.3-4
#>  [58] FactoMineR_2.12       nnet_7.3-20           glue_1.8.0
#>  [61] stabledist_0.7-2      nlme_3.1-168          bigparallelr_0.3.2
#>  [64] grid_4.5.1            cluster_2.1.8.1       generics_0.1.4
#>  [67] snow_0.4-4            gtable_0.3.6          flock_0.7
#>  [70] class_7.3-23          tidyr_1.3.1           rmutil_1.1.10
#>  [73] flexmix_2.3-20        BiocGenerics_0.56.0   ggrepel_0.9.6
#>  [76] foreach_1.5.2         pillar_1.11.1         clValid_0.7
#>  [79] robustbase_0.99-6     circlize_0.4.16       splines_4.5.1
#>  [82] dplyr_1.1.4           lattice_0.22-7        bit_4.6.0
#>  [85] survival_3.8-3        tidyselect_1.2.1      ComplexHeatmap_2.26.0
#>  [88] pbapply_1.7-4         knitr_1.50            reformulas_0.4.2
#>  [91] bookdown_0.45         IRanges_2.44.0        stats4_4.5.1
#>  [94] xfun_0.53             diptest_0.77-2        timeDate_4051.111
#>  [97] matrixStats_1.5.0     DEoptimR_1.1-4        DT_0.34.0
#> [100] stringi_1.8.7         yaml_2.3.10           boot_1.3-32
#> [103] evaluate_1.0.5        codetools_0.2-20      kernlab_0.9-33
#> [106] timeSeries_4041.111   data.tree_1.2.0       tibble_3.3.0
#> [109] BiocManager_1.30.26   multcompView_0.1-10   cli_3.6.5
#> [112] rpart_4.1.24          xtable_1.8-4          Rdpack_2.6.4
#> [115] jquerylib_0.1.4       dichromat_2.0-0.1     Rcpp_1.1.0
#> [118] doSNOW_1.0.20         stable_1.1.6          coda_0.19-4.1
#> [121] png_0.1-8             parallel_4.5.1        modeest_2.4.0
#> [124] leaps_3.2             ggplot2_4.0.0         mclust_6.1.1
#> [127] ff_4.5.2              lme4_1.1-37           glmnet_4.1-10
#> [130] mvtnorm_1.3-3         scales_1.4.0          statip_0.2.3
#> [133] purrr_1.1.0           crayon_1.5.3          fpc_2.2-13
#> [136] GetoptLong_1.0.5      rlang_1.1.6           cowplot_1.2.0
#> [139] multcomp_1.4-29       mice_3.18.0
```