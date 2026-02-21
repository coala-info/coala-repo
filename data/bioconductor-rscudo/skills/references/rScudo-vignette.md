# An introduction to rScudo

Matteo Ciciani1\*, Thomas Cantore1 and Mario Lauria2,3

1Centre for Integrative Biology (CIBIO), University of Trento, Italy
2Department of Mathematics, University of Trento, Italy
3The Microsoft Research-University of Trento Centre for Computational and Systems Biology (COSBI), Rovereto, Italy

\*matteo.ciciani@gmail.com

#### 2025-10-30

# 1 Introduction

This package implements in R the SCUDO rank-based signature identification
method111 Lauria M. Rank-based transcriptional signatures. Systems Biomedicine.
2013; 1(4):228-239.
. SCUDO (Signature-based Clustering for
Diagnostic Purposes) is a method for the analysis and classification of gene
expression profiles for diagnostic and classification purposes. The `rScudo`
package implements the very same algorithm that participated in the SBV IMPROVER
Diagnostic Signature Challenge, an open international competition designed to
assess and verify computational approaches for classifying clinical samples
based on gene expression. SCUDO earned second place overall in the competition,
and first in the Multiple Sclerosis sub-challenge, out of 54 submissions222 Tarca
AL, Lauria M, Unger M, Bilal E, Boue S, Kumar Dey K, Hoeng J, Koeppl H, Martin
F, Meyer P, et al. IMPROVER DSC Collaborators. Strengths and limitations of
microarray-based phenotype prediction: lessons learned from the IMPROVER
Diagnostic Signature Challenge. Bioinformatics. 2013; 29:2892–2899..

The method is based on the identification of sample-specific gene signatures and
their subsequent analysis using a measure of signature-to-signature similarity.
The computation of a similarity matrix is then used to draw a map of the
signatures in the form of a graph, where each node corresponds to a sample and a
connecting edge, if any, encodes the level of similarity between the connected
nodes (short edge = high similarity; no edge = negligible similarity). The
expected result is the emergence of a partitioning of the set of samples in
separate and homogeneous clusters on the basis of signature similarity (clusters
are also sometimes referred to as communities).

The package has been designed with the double purpose of facilitating
experimentation on different aspects of the SCUDO approach to classification,
and enabling performance comparisons with other methods. Given the novelty
of the method, a lot of work remain to be done in order to fully optimize it,
and to fully characterize its classification performance. For this purpose the
package includes features that allow the user to implement his/her own signature
similarity function, and/or clustering and classification methods. It also adds
functions to implement steps that were previously performed manually, such as
determining optimal signature length and computing classification performance
indices, in order to facilitate the application and the evaluation of the
method.

# 2 Method in brief

Starting from gene expression data, the functions `scudoTrain` and
`scudoNetwork` perform the basic SCUDO pipeline, which can be
summarized in 4 steps:

1. First, fold-changes are computed for each gene. Then, a feature selection
   step is performed. The user can specify whether to use a parametric or a non
   parametric test. The test used also depends on the number of groups present in
   the dataset. This step can be optionally skipped.
2. The subsequent operations include single sample gene ranking and the
   extraction of signatures formed by up-regulated and down-regulated genes. The
   length of the signatures are customizable. Consensus signtures are then
   computed, both for up- and down-regulated genes and for each group. The
   computation of consensus signatures is performed aggregating the ranks of the
   genes in each sample and ranking again the genes.
3. An all-to-all distance matrix is then computed using a distance similar to
   the GSEA333 Subramanian A, Tamayo P, Mootha VK, Mukherjee S, Ebert BL, Gillette
   MA, Paulovich A, Pomeroy SL, Golub TR, Lander ES, Mesirov JP. Gene set
   enrichment analysis: A knowledge-based approach for interpreting genome-wide
   expression profiles. PNAS. 2005; 102(43):15545-15550. (Gene Set Enrichment
   Analysis): the distance between two samples is computed as the mean of the
   enrichment scores (ES) of the signatures of each sample in the expression
   profile of the other sample. The distance function used is customizable.
4. Finally, a user-defined threshold N is used to generate a network of samples.
   The distance matrix is treated as an adjacency matrix, but only the distances
   that fall below the Nth quantile of distances are used to draw edges in the
   network. This is performed by the function `scudoNetwork`. The network
   can then be displayed in R or using Cytoscape.

The function `scudoTrain` returns an object of class `scudoResults`,
which contains sample-specific gene signatures, consensus gene signatures for
each group and the sample distance matrix.

After the identification of a list of genes that can be used to partition the
samples in separated communities, the same procedure can be applied to a testing
dataset. The function `scudoTest` performs steps 2 and 3 on a testing
dataset, taking into account only the genes selected in the training phase.

Alteranatively, the function `scudoClassify` can be used to perform
supervised classification. This function takes as input a training set,
containing samples with known classification, and a testing set of samples with
unknown classification. For each sample in the testing set, the function
computes a network formed by all the samples in the training set and a single
sample from the training set. Then, classification scores are computed for each
sample in the testing set looking at the neighbors of that sample in the
network. See the documentation of the function for a detailed description of the
computation of the classification scores.

# 3 Example workflow

## 3.1 Data preparation

In this example we will use the *[ALL](https://bioconductor.org/packages/3.22/ALL)* dataset, containing gene
expression data from T- and B-cells acute lymphoblastic leukemia patients. In
this first part, we are interested in distinguishing B-cells and T-cells
samples, based on gene expression profiles. We begin by loading relevant
libraries and subsetting the dataset, dividing it in a training and a testing
set, using the function `createDataPartition` from the package
*[caret](https://CRAN.R-project.org/package%3Dcaret)*.

```
library(rScudo)
library(ALL)
data(ALL)

bt <- as.factor(stringr::str_extract(pData(ALL)$BT, "^."))

set.seed(123)
inTrain <- caret::createDataPartition(bt, list = FALSE)
trainData <- ALL[, inTrain]
testData <- ALL[, -inTrain]
```

## 3.2 Analysis of the training set

We start by analyzing the training set. We first run `scudoTrain`,
which returns an object of class `ScudoResults`. This function computes the
all-to-all distance matrix, which is a potentially computationally intensive
operation, however its implementation has been carefully optimized for speed. As
a result, the function can handle relatively large data sets; the execution of
the code below takes only about 3 seconds on a PC equipped with a Intel Core
i7-8700T 2.40GHz CPU and 16GB of RAM running Windows 10 Pro.

```
trainRes <- scudoTrain(trainData, groups = bt[inTrain], nTop = 100,
    nBottom = 100, alpha = 0.1)
trainRes
#> Object of class ScudoResults
#> Result of scudoTrain
#>
#> Number of samples      :  65
#> Number of groups       :  2
#>     B :  48 samples
#>     T :  17 samples
#> upSignatures length    :  100
#> downSignatures length  :  100
#> Fold-changes           :  computed
#>     grouped            :  No
#> Feature selection      :  performed
#>     Test               :  Wilcoxon rank sum test
#>     p-value cutoff     :  0.1
#>     p.adjust method    :  none
#>     Selected features  :  4286
```

From this object we can extract the signatures for each sample and the consensus
signatures for each group.

```
upSignatures(trainRes)[1:5,1:5]
#>      04007      04010    04016     06002    08012
#> 1 36638_at 33273_f_at 36575_at  38355_at 38604_at
#> 2 34362_at 33274_f_at 40511_at  37283_at  1857_at
#> 3 37006_at   38514_at 37623_at  40456_at 878_s_at
#> 4  1113_at   39318_at 547_s_at  41273_at 38355_at
#> 5 40367_at 35530_f_at 37187_at 2036_s_at 37921_at
consensusUpSignatures(trainRes)[1:5, ]
#>            B         T
#> 1   37039_at  38319_at
#> 2   35016_at  33238_at
#> 3   39839_at  38147_at
#> 4 38095_i_at  37078_at
#> 5 38096_f_at 2059_s_at
```

The function `scudoNetwork` can be used to generate a network of
samples from the object `trainRes`. This function returns an
*[igraph](https://CRAN.R-project.org/package%3Digraph)* object. The parameter `N` controls the percentage of edges
to keep in the network. We can plot this network using the function
`scudoPlot`.

```
trainNet <- scudoNetwork(trainRes, N = 0.25)
scudoPlot(trainNet, vertex.label = NA)
```

![](data:image/png;base64...)

You can also render the network in Cytoscape, using the function
`scudoCytoscape`. Note that Cytoscape has to be open when running this
function.

```
scudoCytoscape(trainNet)
```

Since we obtained a very good separation of the two groups, we proceed to
analyze the testing set.

## 3.3 Analysis of the testing set

We can use a `ScudoResults` object and the function `scudoTest` to
analyze the testing set. The feature selection is not performed in the testing
set. Instead, only the features selected in the training step are used in the
analysis of the testing set.

```
testRes <- scudoTest(trainRes, testData, bt[-inTrain], nTop = 100,
    nBottom = 100)
testRes
#> Object of class ScudoResults
#> Result of scudoTest
#>
#> Number of samples      :  63
#> Number of groups       :  2
#>     B :  47 samples
#>     T :  16 samples
#> upSignatures length    :  100
#> downSignatures length  :  100
#> Fold-changes           :  computed
#>     grouped            :  No
```

We can generate a network of samples and plot it.

```
testNet <- scudoNetwork(testRes, N = 0.25)
scudoPlot(testNet, vertex.label = NA)
```

![](data:image/png;base64...)

We can use a community clustering algorithm to identify clusters of samples. In
the following example we use the function `cluster spinglass` from
the package *[igraph](https://CRAN.R-project.org/package%3Digraph)* to perform clustering of our network. In
Cytoscape we can perform a similar analysis using clustering functions from the
clusterMaker app.

```
testClust <- igraph::cluster_spinglass(testNet, spins = 2)
plot(testClust, testNet, vertex.label = NA)
```

![](data:image/png;base64...)

### 3.3.1 Supervised classification

`scudoClassify` performs supervised classification of sample in a
testing set using a model built from samples in a training set. It uses a method
based on neighbors in the graph to assign a class label to each sample in the
testing set. We suggest to use the same `N`, `nTop`, `nBottom` and `alpha` that
were used in the training step.

```
classRes <- scudoClassify(trainData, testData, N = 0.25, nTop = 100,
    nBottom = 100, trainGroups = bt[inTrain], alpha = 0.1)
```

Classification performances can be explored using the
`confusionMatrix` function from *[caret](https://CRAN.R-project.org/package%3Dcaret)*.

```
caret::confusionMatrix(classRes$predicted, bt[-inTrain])
#> Confusion Matrix and Statistics
#>
#>           Reference
#> Prediction  B  T
#>          B 47  0
#>          T  0 16
#>
#>                Accuracy : 1
#>                  95% CI : (0.9431, 1)
#>     No Information Rate : 0.746
#>     P-Value [Acc > NIR] : 9.632e-09
#>
#>                   Kappa : 1
#>
#>  Mcnemar's Test P-Value : NA
#>
#>             Sensitivity : 1.000
#>             Specificity : 1.000
#>          Pos Pred Value : 1.000
#>          Neg Pred Value : 1.000
#>              Prevalence : 0.746
#>          Detection Rate : 0.746
#>    Detection Prevalence : 0.746
#>       Balanced Accuracy : 1.000
#>
#>        'Positive' Class : B
#>
```

## 3.4 Example of multigroup analysis

The analysis can also be performed on more than two groups. In this section, we
try to predict the stage of B-cells ALL using gene expression data. We focus
only on stages B1, B2 and B3, since they have a suitable sample size.

```
isB <- which(as.character(ALL$BT) %in% c("B1", "B2", "B3"))
ALLB <- ALL[, isB]
stage <- ALLB$BT[, drop = TRUE]
table(stage)
#> stage
#> B1 B2 B3
#> 19 36 23
```

We divide the dataset in a training and a testing set and we apply
`scudoTrain`, identifying suitable parameter values. Then, we perform
supervised classification of the samples in the testing set using the function
`scudoClassify`.

```
inTrain <- as.vector(caret::createDataPartition(stage, p = 0.6, list = FALSE))

stageRes <- scudoTrain(ALLB[, inTrain], stage[inTrain], 100, 100, 0.01)
stageNet <- scudoNetwork(stageRes, 0.2)
scudoPlot(stageNet, vertex.label = NA)
```

![](data:image/png;base64...)

```
classStage <- scudoClassify(ALLB[, inTrain], ALLB[, -inTrain], 0.25, 100, 100,
    stage[inTrain], alpha = 0.01)
caret::confusionMatrix(classStage$predicted, stage[-inTrain])
#> Confusion Matrix and Statistics
#>
#>           Reference
#> Prediction B1 B2 B3
#>         B1  5  2  1
#>         B2  2 11  1
#>         B3  0  1  7
#>
#> Overall Statistics
#>
#>                Accuracy : 0.7667
#>                  95% CI : (0.5772, 0.9007)
#>     No Information Rate : 0.4667
#>     P-Value [Acc > NIR] : 0.0008038
#>
#>                   Kappa : 0.6354
#>
#>  Mcnemar's Test P-Value : 0.8012520
#>
#> Statistics by Class:
#>
#>                      Class: B1 Class: B2 Class: B3
#> Sensitivity             0.7143    0.7857    0.7778
#> Specificity             0.8696    0.8125    0.9524
#> Pos Pred Value          0.6250    0.7857    0.8750
#> Neg Pred Value          0.9091    0.8125    0.9091
#> Prevalence              0.2333    0.4667    0.3000
#> Detection Rate          0.1667    0.3667    0.2333
#> Detection Prevalence    0.2667    0.4667    0.2667
#> Balanced Accuracy       0.7919    0.7991    0.8651
```

## 3.5 Increasing performance through parameter tuning

Parameters such as `nTop` and `nBottom` can be optimally tuned using techniques
such as cross-validation. The package *[caret](https://CRAN.R-project.org/package%3Dcaret)* offers a framework to
perform grid search for parameters tuning. Here we report an example of
cross-validation, in the context of the multigroup analysis previously
performed. Since feature selection represents a performance bottleneck, we
perform it before the cross-validation. Notice that we also transpose the
dataset, since functions in *[caret](https://CRAN.R-project.org/package%3Dcaret)* expect features on columns and
samples on rows.

```
trainData <- exprs(ALLB[, inTrain])
virtControl <- rowMeans(trainData)
trainDataNorm <- trainData / virtControl
pVals <- apply(trainDataNorm, 1, function(x) {
    stats::kruskal.test(x, stage[inTrain])$p.value})
trainDataNorm <- t(trainDataNorm[pVals <= 0.01, ])
```

We use the function `scudoModel` to generate a suitable input model
for `train`. `scudoModel` takes as input the parameter
values that have to be explored and generates all possible parameter
combinations. We then call the function `trainControl` to specify
control parameters for the training procedure and perform it using
`train`. Then we run `scudoClassify` on the testing set
using the best tuning parameters found by the cross-validation. We use
parallelization to speed up the cross-validation.

```
cl <- parallel::makePSOCKcluster(2)
doParallel::registerDoParallel(cl)

model <- scudoModel(nTop = (2:6)*20, nBottom = (2:6)*20, N = 0.25)
control <- caret::trainControl(method = "cv", number = 5,
    summaryFunction = caret::multiClassSummary)
cvRes <- caret::train(x = trainDataNorm, y = stage[inTrain], method = model,
    trControl = control)
#> Warning in nominalTrainWorkflow(x = x, y = y, wts = weights, info = trainInfo,
#> : There were missing values in resampled performance measures.

parallel::stopCluster(cl)

classStage <- scudoClassify(ALLB[, inTrain], ALLB[, -inTrain], 0.25,
    cvRes$bestTune$nTop, cvRes$bestTune$nBottom, stage[inTrain], alpha = 0.01)
caret::confusionMatrix(classStage$predicted, stage[-inTrain])
#> Confusion Matrix and Statistics
#>
#>           Reference
#> Prediction B1 B2 B3
#>         B1  6  2  1
#>         B2  1 12  0
#>         B3  0  0  8
#>
#> Overall Statistics
#>
#>                Accuracy : 0.8667
#>                  95% CI : (0.6928, 0.9624)
#>     No Information Rate : 0.4667
#>     P-Value [Acc > NIR] : 6.279e-06
#>
#>                   Kappa : 0.7942
#>
#>  Mcnemar's Test P-Value : NA
#>
#> Statistics by Class:
#>
#>                      Class: B1 Class: B2 Class: B3
#> Sensitivity             0.8571    0.8571    0.8889
#> Specificity             0.8696    0.9375    1.0000
#> Pos Pred Value          0.6667    0.9231    1.0000
#> Neg Pred Value          0.9524    0.8824    0.9545
#> Prevalence              0.2333    0.4667    0.3000
#> Detection Rate          0.2000    0.4000    0.2667
#> Detection Prevalence    0.3000    0.4333    0.2667
#> Balanced Accuracy       0.8634    0.8973    0.9444
```

# 4 Session info

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
#> [1] ALL_1.51.0          Biobase_2.70.0      BiocGenerics_0.56.0
#> [4] generics_0.1.4      rScudo_1.26.0       BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1     timeDate_4051.111    dplyr_1.1.4
#>  [4] farver_2.1.2         S7_0.2.0             fastmap_1.2.0
#>  [7] pROC_1.19.0.1        caret_7.0-1          digest_0.6.37
#> [10] rpart_4.1.24         timechange_0.3.0     lifecycle_1.0.4
#> [13] survival_3.8-3       magrittr_2.0.4       compiler_4.5.1
#> [16] rlang_1.1.6          sass_0.4.10          tools_4.5.1
#> [19] igraph_2.2.1         yaml_2.3.10          data.table_1.17.8
#> [22] knitr_1.50           plyr_1.8.9           RColorBrewer_1.1-3
#> [25] withr_3.0.2          purrr_1.1.0          nnet_7.3-20
#> [28] grid_4.5.1           stats4_4.5.1         e1071_1.7-16
#> [31] future_1.67.0        ggplot2_4.0.0        globals_0.18.0
#> [34] scales_1.4.0         iterators_1.0.14     MASS_7.3-65
#> [37] dichromat_2.0-0.1    tinytex_0.57         cli_3.6.5
#> [40] rmarkdown_2.30       future.apply_1.20.0  reshape2_1.4.4
#> [43] proxy_0.4-27         cachem_1.1.0         stringr_1.5.2
#> [46] splines_4.5.1        parallel_4.5.1       BiocManager_1.30.26
#> [49] vctrs_0.6.5          hardhat_1.4.2        Matrix_1.7-4
#> [52] jsonlite_2.0.0       bookdown_0.45        S4Vectors_0.48.0
#> [55] listenv_0.9.1        magick_2.9.0         foreach_1.5.2
#> [58] gower_1.0.2          jquerylib_0.1.4      recipes_1.3.1
#> [61] glue_1.8.0           parallelly_1.45.1    codetools_0.2-20
#> [64] lubridate_1.9.4      stringi_1.8.7        gtable_0.3.6
#> [67] tibble_3.3.0         pillar_1.11.1        htmltools_0.5.8.1
#> [70] ipred_0.9-15         lava_1.8.1           R6_2.6.1
#> [73] doParallel_1.0.17    evaluate_1.0.5       lattice_0.22-7
#> [76] bslib_0.9.0          class_7.3-23         Rcpp_1.1.0
#> [79] nlme_3.1-168         prodlim_2025.04.28   xfun_0.53
#> [82] pkgconfig_2.0.3      ModelMetrics_1.2.2.2
```