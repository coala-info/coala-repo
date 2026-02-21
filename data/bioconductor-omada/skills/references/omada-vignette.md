# Omada, An unsupervised machine learning toolkit for automated sample clustering of gene expression profiles

#### Sokratis Kariotis

University of Sheffield, Agency for Science, Technology and Research (A\*STAR)

Abstract

Symptomatic heterogeneity in complex diseases reveals differences in molecular states that need to be investigated. However, selecting the numerous parameters of an exploratory clustering analysis in RNA profiling studies requires deep understanding of machine learning and extensive computational experimentation. Tools that assist with such decisions without prior field knowledge are nonexistent and further gene association analyses need to be performed independently. We have developed a suite of tools to automate these processes and make robust unsupervised clustering of transcriptomic data more accessible through automated machine learning based functions. The efficiency of each tool was tested with four datasets characterised by different expression signal strengths. Our toolkit’s decisions reflected the real number of stable partitions in datasets where the subgroups are discernible. Even in datasets with less clear biological distinctions, stable subgroups with different expression profiles and clinical associations were found.

### Loading the library

Loading the library to access the functions and the two toy datasets: gene expressions and cluster memberships.

```
library(omada)
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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] omada_1.12.0     dplyr_1.1.4      glmnet_4.1-10    Matrix_1.7-4
##  [5] clValid_0.7      cluster_2.1.8.1  genieclust_1.2.0 reshape_0.8.10
##  [9] ggplot2_4.0.0    diceR_3.1.0      Rcpp_1.1.0       fpc_2.2-13
## [13] kernlab_0.9-33   pdfCluster_1.0-4
##
## loaded via a namespace (and not attached):
##  [1] magic_1.6-1        sass_0.4.10        generics_0.1.4     class_7.3-23
##  [5] robustbase_0.99-6  shape_1.4.6.1      quitefastmst_0.9.0 lattice_0.22-7
##  [9] digest_0.6.37      magrittr_2.0.4     evaluate_1.0.5     grid_4.5.1
## [13] RColorBrewer_1.1-3 iterators_1.0.14   fastmap_1.2.0      foreach_1.5.2
## [17] plyr_1.8.9         jsonlite_2.0.0     nnet_7.3-20        survival_3.8-3
## [21] mclust_6.1.1       purrr_1.1.0        scales_1.4.0       codetools_0.2-20
## [25] modeltools_0.2-24  jquerylib_0.1.4    abind_1.4-8        cli_3.6.5
## [29] rlang_1.1.6        splines_4.5.1      withr_3.0.2        cachem_1.1.0
## [33] yaml_2.3.10        geometry_0.5.2     tools_4.5.1        flexmix_2.3-20
## [37] parallel_4.5.1     vctrs_0.6.5        R6_2.6.1           stats4_4.5.1
## [41] lifecycle_1.0.4    MASS_7.3-65        pkgconfig_2.0.3    bslib_0.9.0
## [45] pillar_1.11.1      gtable_0.3.6       glue_1.8.0         DEoptimR_1.1-4
## [49] xfun_0.53          tibble_3.3.0       tidyselect_1.2.1   prabclus_2.3-4
## [53] knitr_1.50         dichromat_2.0-0.1  farver_2.1.2       htmltools_0.5.8.1
## [57] rmarkdown_2.30     compiler_4.5.1     S7_0.2.0           diptest_0.77-2
```

### Investigating feasibility of a dataset based on its dimensions (sample and feature sizes)

To investigate the clustering feasibility of a dataset this package provides two simulating functions of stability assessment that simulate a dataset of specific dimensions and calculate the dataset’s stabilities for a range of clusters. `feasibilityAnalysis()` generates an idependent dataset for specific number of classes, samples and features while `feasibilityAnalysisDataBased()` accepts an existing dataset extracting statistics(means and standard deviations) for a specific number of clusters. Note that these estimations only serve as an indication of the datasets fitness for the dowstream analysis and not as the actual measure of quality as they do not account for the actual signal in the data but only the relation between the number of samples, features and clusters.

```
# Selecting dimensions and number of clusters
new.dataset.analysis <- feasibilityAnalysis(classes = 4, samples = 50,
                                            features = 15)

# Basing the simulation on an existing dataset and selecting the number of clusters
existing.dataset.analysis <- feasibilityAnalysisDataBased(data = toy_genes,
                                                          classes = 3)

# Extract results of either function
average.sts.k <- get_average_stabilities_per_k(new.dataset.analysis)
maximum.st <- get_max_stability(new.dataset.analysis)
average.st <- get_average_stability(new.dataset.analysis)
generated.ds <- get_generated_dataset(new.dataset.analysis)
```

### Automated clustering analysis: Omada

Using `omada()` along with a gene expression dataframe and an upper k (number of clusters to be considered) we can run the whole analysis toolkit to automate clustering decision making and produce the estimated optimal clusters. Removal or imputation of NA values is required before running the any of the tools.

```
# Running the whole cascade of tools inputting an expression dataset
# and the upper k (number of clusters) to be investigated
omada.analysis <- omada(toy_genes, method.upper.k = 6)

# Extract results
pa.scores <- get_partition_agreement_scores(omada.analysis)
fs.scores <- get_feature_selection_scores(omada.analysis)
fs.optimal.features <-
  get_feature_selection_optimal_features(omada.analysis)
fs.optimal.number.of.features <-
  get_feature_selection_optimal_number_of_features(omada.analysis)

cv.scores <- get_cluster_voting_scores(omada.analysis)
cv.memberships <- get_cluster_voting_memberships(omada.analysis)
cv.metrics.votes <- get_cluster_voting_metric_votes(omada.analysis)
cv.k.votes <- get_cluster_voting_k_votes(omada.analysis)
sample.memberships <- get_sample_memberships(omada.analysis)

# Plot results
plot_partition_agreement(omada.analysis)
```

![](data:image/png;base64...)

```
plot_feature_selection(omada.analysis)
```

![](data:image/png;base64...)

```
plot_cluster_voting(omada.analysis)
```

![](data:image/png;base64...)

### Selecting the most appropriate clustering approach based on a dataset

To select the most appropriate clustering technique for our dataset we compare the internal partition agreement of three different approaches, namely spectral, k-means and hierarchical clustering using the `clusteringMethodSelection()` function. We define the upper k to be considered as well as the number of internal comparisons per approach. Increased number of comparisons introduces more robustness and highest run times.

```
# Selecting the upper k limit and number of comparisons
method.results <- clusteringMethodSelection(toy_genes, method.upper.k = 3,
                                            number.of.comparisons = 2)

# Extract results
pa.scores <- get_partition_agreement_scores(method.results)

# Plot results
plot_partition_agreement(method.results)
```

![](data:image/png;base64...)

This suite also provides the function to individually calculate the partition agreement between two specific clustering approaches and parameter sets by utilizing function `partitionAgreement()` which requires the selection of the 2 algorithms, measures and number of clusters.

```
# Selecting algorithms, measures and number of clusters
agreement.results <- partitionAgreement(toy_genes, algorithm.1 = "spectral",
                                        measure.1 = "rbfdot",
                                        algorithm.2 = "kmeans",
                                        measure.2 = "Lloyd",
                                        number.of.clusters = 3)

# Extract results
pa.scores <- get_agreement_scores(agreement.results)
```

### Selecting the most appropriate features

To select the features that provide the most stable clusters the function `featureSelection()` requires the minimum and maximum number of clusters(k) and the feature step that dictates the rate of each feature set’s increase. It is advised to use the algorithm the previous tools provide.

```
# Selecting minimum and maximum number of clusters and feature step
feature.selection.results <-  featureSelection(toy_genes, min.k = 3, max.k = 6,
                                               step = 3)

# Extract results
feature.selection.scores <- get_average_feature_k_stabilities(feature.selection.results)
optimal.number.of.features <- get_optimal_number_of_features
optimal.features <- get_optimal_features(feature.selection.results)

# Plot results
plot_average_stabilities(feature.selection.results)
```

![](data:image/png;base64...)

### Estimating the most appropriate number of clusters

To estimate the most appropriate number of clusters based on an ensemble of internal metrics function `clusterVoting()` accepts the minimum and maximum number of clusters to be considered as well as the algorithm of choice (“sc” for spectral, “km” for kmeans and “hr” for hierachical clustering). It is advised to use the feature set and algorithm the previous tools provide.

```
# Selecting minimum and maximum number of clusters and algorithm to be used
cluster.voting.results <- clusterVoting(toy_genes, 4,8,"sc")

# Extract results
internal.metric.scores <- get_internal_metric_scores(cluster.voting.results)
cluster.memberships.k <- get_cluster_memberships_k(cluster.voting.results)
metric.votes.k <- get_metric_votes_k(cluster.voting.results)
vote.frequencies.k <- get_vote_frequencies_k(cluster.voting.results)

# Plot results
plot_vote_frequencies(cluster.voting.results)
```

![](data:image/png;base64...)

### Running the optimal clustering

Previous steps have provided every clustering parameter needed to go through with the partitioning utilising `optimalClustering()`. This tool is using the dataset with the most stable feature set, number of clusters(k) and appropriate algorithm. This tool additionally runs through the possible algorithm parameters to retain the one with the highest stability.

```
# Running the clustering with specific number of clusters(k) and algorithm
sample.memberships <- optimalClustering(toy_genes, 4, "spectral")

# Extract results
memberships <- get_optimal_memberships(sample.memberships)
optimal.stability <- get_optimal_stability_score(sample.memberships)
optimal.parameter <- get_optimal_parameter_used(sample.memberships)
```