# Overview of the condiments workflow

#### Hector Roux de Bézieux

#### 29 October , 2025

* [Initial pre-processing](#initial-pre-processing)
  + [Generating a synthetic dataset](#generating-a-synthetic-dataset)
  + [Vizualisation](#vizualisation)
* [Differential Topology](#differential-topology)
  + [Exploratory analysis](#exploratory-analysis)
  + [Trajectory Inference](#trajectory-inference)
* [Differential Progression](#differential-progression)
  + [Visualization](#visualization)
  + [Testing for differential progression](#testing-for-differential-progression)
* [Differential fate selection](#differential-fate-selection)
  + [Vizualisation](#vizualisation-1)
  + [Testing for differential fate selection](#testing-for-differential-fate-selection)
* [Differential Expression](#differential-expression)
* [Conclusion](#conclusion)
* [Session Info](#session-info)
* [References](#references)

# Initial pre-processing

## Generating a synthetic dataset

We will use a synthetic dataset to illustrate the functionalities of the *condiments* package. We start directly with a dataset where the following steps are assumed to have been run:

* Obtaining count matrices for each setting (i.e. each condition).
* Integration and normalization between the conditions.
* Reduced Dimension Estimations
* (Clustering)

```
# For analysis
library(condiments)
library(slingshot)
# For data manipulation
library(dplyr)
library(tidyr)
# For visualization
library(ggplot2)
library(RColorBrewer)
library(viridis)
set.seed(2071)
theme_set(theme_classic())
```

```
data("toy_dataset", package = "condiments")
df <- toy_dataset$sd
```

As such, we start with a matrix `df` of metadata for the cells: coordinates in a reduced dimension space `(Dim1, Dim2)`, a vector of conditions assignments `conditions` (A or B) and a lineage assignment.

## Vizualisation

We can first plot the cells on the reduced dimensions

```
p <- ggplot(df, aes(x = Dim1, y = Dim2, col = conditions)) +
  geom_point() +
  scale_color_brewer(type = "qual")
p
```

![](data:image/png;base64...)

We can also visualize the underlying skeleton structure of the two conditions.

```
p <- ggplot(df, aes(x = Dim1, y = Dim2, col = conditions)) +
  geom_point(alpha = .5) +
  geom_point(data = toy_dataset$mst, size = 2) +
  geom_path(data = toy_dataset$mst, aes(group = lineages), size = 1.5) +
  scale_color_brewer(type = "qual") +
  facet_wrap(~conditions) +
  guides(col = FALSE)
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
## of ggplot2 3.3.4.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
p
```

![](data:image/png;base64...)

# Differential Topology

## Exploratory analysis

We can then compute the **imbalance score** of each cell using the *imbalance\_score* function.

```
scores <- imbalance_score(Object = df %>% select(Dim1, Dim2) %>% as.matrix(),
                          conditions = df$conditions)
df$scores <- scores$scores
df$scaled_scores <- scores$scaled_scores
```

There are two types of scores. The raw score is computed on each cell and looks at the condition distribution of its neighbors compared the the overall distribution. The size of the neighborhood can be set using the `k` argument, which specify the number of neighbors to consider. Higher values means more local imbalance.

```
ggplot(df, aes(x = Dim1, y = Dim2, col = scores)) +
  geom_point() +
  scale_color_viridis_c(option = "C")
```

![](data:image/png;base64...)

The local scores are quite noisy so we can then use local smoothers to smooth the scores of individual cells. The smoothness is dictated by the `smooth` argument. Those smoothed scores were also computed using the `imbalance_score` function.

```
ggplot(df, aes(x = Dim1, y = Dim2, col = scaled_scores)) +
  geom_point() +
  scale_color_viridis_c(option = "C")
```

![](data:image/png;base64...)

As could be guessed from the original plot, the bottom lineage shows a lot of imbalance while the top one does not. The imbalance score can be used to check: + If the integration has been successful. In general, some regions should be balanced + To identify the regions of imbalance for further analyses.

## Trajectory Inference

The first step of our workflow is to decide whether or not to infer the trajectories separately or not. On average, it is better to infer a common trajectory, since a) this allow for a wider range of downstream analyses, and b) more cells are used to estimate the trajectory. However, the condition effect might be strong enough to massively disrupt the differentiation process, which would require fitting separate trajectories.

**slingshot**(Street et al. 2018) relies on a reduced dimensionality reduction representation of the data, as well as on cluster labels. We can visualize those below:

```
ggplot(df, aes(x = Dim1, y = Dim2, col = cl)) +
  geom_point()
```

![](data:image/png;base64...) The **topologyTest** assess the quality of the common trajectory inference done by slingshot and test whether we should fit a common or separate trajectory. This test relies on repeated permutations of the conditions followed by trajectory inference so it can take a few seconds.

```
rd <- as.matrix(df[, c("Dim1", "Dim2")])
sds <- slingshot(rd, df$cl)
## Takes ~1m30s to run
top_res <- topologyTest(sds = sds, conditions = df$conditions)
```

```
## Generating permuted trajectories
```

```
## Running KS-mean test
```

```
knitr::kable(top_res)
```

| method | thresh | statistic | p.value |
| --- | --- | --- | --- |
| KS\_mean | 0.01 | 0 | 1 |

The test clearly fails to reject the null that we can fit a common trajectory so we can continue with the `sds` object. This will facilitate downstream analysis. For an example of how to proceed if the **topologyTest** reject the null, we invite the user to refer to [relevant case study used in our paper](https://hectorrdb.github.io/condimentsPaper/articles/KRAS.html).

We can thus visualize the trajectory

```
ggplot(df, aes(x = Dim1, y = Dim2, col = cl)) +
  geom_point() +
  geom_path(data =  slingCurves(sds, as.df = TRUE) %>% arrange(Order),
            aes(group = Lineage), col = "black", size = 2)
```

![](data:image/png;base64...)

# Differential Progression

Even though we can fit a common trajectory, it does not mean that the cells will differentiate similarly between the conditions. The first question we can ask is: for a given lineage, are cells equally represented along pseudotime between conditions?

```
psts <- slingPseudotime(sds) %>%
  as.data.frame() %>%
  mutate(cells = rownames(.),
         conditions = df$conditions) %>%
  pivot_longer(starts_with("Lineage"), values_to = "pseudotime", names_to = "lineages")
```

## Visualization

```
ggplot(psts, aes(x = pseudotime, fill = conditions)) +
  geom_density(alpha = .5) +
  scale_fill_brewer(type = "qual") +
  facet_wrap(~lineages) +
  theme(legend.position = "bottom")
```

![](data:image/png;base64...)

The pseudotime distributions are identical across conditions for the first lineage but there are clear differences between the two conditions in the second lineage.

## Testing for differential progression

To test for differential progression, we use the **progressionTest**. The test can be run with `global = TRUE` to test when pooling all lineages, or `lineages = TRUE` to test every lineage independently, or both. Several tests are implemented in the **progressionTest**. function. Here, we will use the default, the custom KS test (Smirnov 1939).

```
prog_res <- progressionTest(sds, conditions = df$conditions, global = TRUE, lineages = TRUE)
knitr::kable(prog_res)
```

| lineage | statistic | p.value |
| --- | --- | --- |
| All | 5.5041722 | 0.0000000 |
| 1 | 0.0344552 | 0.9938908 |
| 2 | 0.4699323 | 0.0000000 |

As expected, there is a global difference over all lineages, which is driven by differences of distribution across lineage 2 (i.e. the bottom one).

# Differential fate selection

Even though we can fit a common trajectory, it does not mean that the cells will differentiate similarly between the conditions. The first question we can ask is: for a given lineage, are cells equally between the two lineages for the two conditions?

## Vizualisation

Visualizing differences 2D distributions can be somewhat tricky. However, it is important to note that the sum of all lineage weights should sum to 1. As such, we can only plot the weights for the first lineage.

```
df$weight_1 <- slingCurveWeights(sds, as.probs = TRUE)[, 1]
ggplot(df, aes(x = weight_1, fill = conditions)) +
  geom_density(alpha = .5) +
  scale_fill_brewer(type = "qual") +
  labs(x = "Curve weight for the first lineage")
```

![](data:image/png;base64...)

The distribution has tri modes, which is very often the case for two lineages: + A weight around 0 represent a cell that is mostly assigned to the other lineage (i.e. lineage 2 here) + A weight around .5 represent a cell that is equally assigned to both lineages, i.e. before the bifurcation. + A weight around 1 represent a cell that is mostly assigned to this lineage (i.e. lineage 1 here)

In condition A, we have many more cells with a weight of 0 and, since those are density plots, fewer cells with weights around .5 and 1. Visually, we can guess that cells in condition B differentiate preferentially along lineage 1.

## Testing for differential fate selection

To test for differential fate selection, we use the **fateSelectionTest**. The test can be run with `global = TRUE` to test when pooling all pairs of lineages, or `pairwise = TRUE` to test every pair independently, or both. Here, there is only one pair so the options are equivalent. Several tests are implemented in the **fateSelectionTest**. function. Here, we will use the default, the classifier test(Lopez-Paz and Oquab 2016).

```
set.seed(12)
dif_res <- fateSelectionTest(sds, conditions = df$conditions, global = FALSE, pairwise = TRUE)
```

```
## note: only 1 unique complexity parameters in default grid. Truncating the grid to 1 .
```

```
## Loading required package: lattice
```

```
##
## Attaching package: 'caret'
```

```
## The following object is masked from 'package:generics':
##
##     train
```

```
## note: only 1 unique complexity parameters in default grid. Truncating the grid to 1 .
```

```
knitr::kable(dif_res)
```

| pair | statistic | p.value |
| --- | --- | --- |
| 1vs2 | 0.6521622 | 2.9e-06 |

As could be guessed from the plot, we have clear differential fate selection.

# Differential Expression

The workflow above focus on global differences, looking at broad patterns of differentiation. While this is a necessary first step, gene-level information is also quite meaningful.

To do so requires **tradeSeq**(Van den Berge et al. 2020) > 1.3.0. Considering that we have a count matrix `counts`, the basic workflow is:s

```
library(tradeSeq)
sce <- fitGAM(counts = counts, sds = sds, conditions = df$conditions)
cond_genes <- conditionTest(sds)
```

For more details on fitting the smoothers, we refer users to [the tradeSeq website](http://statomics.github.io/tradeSeq) and to the accompanying [Bioconductor workshop](https://kstreet13.github.io/bioc2020trajectories/articles/workshopTrajectories.html#differential-expression-1).

# Conclusion

For both of the above procedures, it is important to note that we are making multiple comparisons (in this case, 5). The p-values we obtain from these tests should be corrected for multiple testing, especially for trajectories with a large number of lineages.

That said, trajectory inference is often one of the last computational methods in a very long analysis pipeline (generally including gene-level quantification, gene filtering / feature selection, and dimensionality reduction). Hence, we strongly discourage the reader from putting too much faith in any p-value that comes out of this analysis. Such values may be useful suggestions, indicating particular features or cells for follow-up study, but should generally not be treated as meaningful statistical quantities.

# Session Info

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] caret_7.0-1                 lattice_0.22-7
##  [3] viridis_0.6.5               viridisLite_0.4.2
##  [5] RColorBrewer_1.1-3          ggplot2_4.0.0
##  [7] tidyr_1.3.1                 dplyr_1.1.4
##  [9] slingshot_2.18.0            TrajectoryUtils_1.18.0
## [11] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
## [13] Biobase_2.70.0              GenomicRanges_1.62.0
## [15] Seqinfo_1.0.0               IRanges_2.44.0
## [17] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [19] generics_0.1.4              MatrixGenerics_1.22.0
## [21] matrixStats_1.5.0           princurve_2.1.6
## [23] condiments_1.18.0           knitr_1.50
##
## loaded via a namespace (and not attached):
##   [1] jsonlite_2.0.0            magrittr_2.0.4
##   [3] spatstat.utils_3.2-0      ggbeeswarm_0.7.2
##   [5] farver_2.1.2              rmarkdown_2.30
##   [7] vctrs_0.6.5               DelayedMatrixStats_1.32.0
##   [9] htmltools_0.5.8.1         S4Arrays_1.10.0
##  [11] BiocNeighbors_2.4.0       SparseArray_1.10.0
##  [13] pROC_1.19.0.1             sass_0.4.10
##  [15] parallelly_1.45.1         bslib_0.9.0
##  [17] plyr_1.8.9                lubridate_1.9.4
##  [19] cachem_1.1.0              igraph_2.2.1
##  [21] lifecycle_1.0.4           iterators_1.0.14
##  [23] pkgconfig_2.0.3           rsvd_1.0.5
##  [25] Matrix_1.7-4              R6_2.6.1
##  [27] fastmap_1.2.0             future_1.67.0
##  [29] digest_0.6.37             scater_1.38.0
##  [31] irlba_2.3.5.1             beachmat_2.26.0
##  [33] labeling_0.4.3            randomForest_4.7-1.2
##  [35] timechange_0.3.0          abind_1.4-8
##  [37] mgcv_1.9-3                compiler_4.5.1
##  [39] rngtools_1.5.2            proxy_0.4-27
##  [41] withr_3.0.2               doParallel_1.0.17
##  [43] S7_0.2.0                  BiocParallel_1.44.0
##  [45] MASS_7.3-65               lava_1.8.1
##  [47] DelayedArray_0.36.0       ModelMetrics_1.2.2.2
##  [49] tools_4.5.1               vipor_0.4.7
##  [51] beeswarm_0.4.0            future.apply_1.20.0
##  [53] nnet_7.3-20               glue_1.8.0
##  [55] nlme_3.1-168              grid_4.5.1
##  [57] reshape2_1.4.4            recipes_1.3.1
##  [59] gtable_0.3.6              class_7.3-23
##  [61] data.table_1.17.8         BiocSingular_1.26.0
##  [63] ScaledMatrix_1.18.0       XVector_0.50.0
##  [65] ggrepel_0.9.6             RANN_2.6.2
##  [67] foreach_1.5.2             pillar_1.11.1
##  [69] stringr_1.5.2             limma_3.66.0
##  [71] Ecume_0.9.2               splines_4.5.1
##  [73] survival_3.8-3            tidyselect_1.2.1
##  [75] scuttle_1.20.0            pbapply_1.7-4
##  [77] transport_0.15-4          gridExtra_2.3
##  [79] xfun_0.53                 statmod_1.5.1
##  [81] hardhat_1.4.2             distinct_1.22.0
##  [83] timeDate_4051.111         stringi_1.8.7
##  [85] yaml_2.3.10               evaluate_1.0.5
##  [87] codetools_0.2-20          kernlab_0.9-33
##  [89] tibble_3.3.0              cli_3.6.5
##  [91] rpart_4.1.24              jquerylib_0.1.4
##  [93] dichromat_2.0-0.1         Rcpp_1.1.0
##  [95] globals_0.18.0            spatstat.univar_3.1-4
##  [97] parallel_4.5.1            gower_1.0.2
##  [99] doRNG_1.8.6.2             sparseMatrixStats_1.22.0
## [101] listenv_0.9.1             ipred_0.9-15
## [103] scales_1.4.0              prodlim_2025.04.28
## [105] e1071_1.7-16              purrr_1.1.0
## [107] crayon_1.5.3              rlang_1.1.6
```

# References

Lopez-Paz, David, and Maxime Oquab. 2016. “Revisiting Classifier Two-Sample Tests.” *Arxiv*, October, 1–15. <http://arxiv.org/abs/1610.06545>.

Smirnov, Nikolai V. 1939. “On the Estimation of the Discrepancy Between Empirical Curves of Distribution for Two Independent Samples.” *Bull. Math. Univ. Moscou* 2 (2): 3–14.

Street, Kelly, Davide Risso, Russell B. Fletcher, Diya Das, John Ngai, Nir Yosef, Elizabeth Purdom, and Sandrine Dudoit. 2018. “Slingshot: cell lineage and pseudotime inference for single-cell transcriptomics.” *BMC Genomics* 19 (1): 477. <https://doi.org/10.1186/s12864-018-4772-0>.

Van den Berge, Koen, Hector Roux de Bézieux, Kelly Street, Wouter Saelens, Robrecht Cannoodt, Yvan Saeys, Sandrine Dudoit, and Lieven Clement. 2020. “Trajectory-based differential expression analysis for single-cell sequencing data.” *Nature Communications* 11 (1): 1201. <https://doi.org/10.1038/s41467-020-14766-3>.