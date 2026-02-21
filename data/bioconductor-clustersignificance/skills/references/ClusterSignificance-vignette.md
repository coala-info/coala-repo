# ClusterSignificance Vignette

#### Jesper Robert Gådin and Jason T. Serviss

#### 2025-10-29

* [Introduction](#introduction)
* [Assumptions](#assumptions)
* [Methods](#methods)
  + [Projection](#projection)
  + [Seperation classification](#seperation-classification)
  + [Score permutation](#score-permutation)
* [Choosing a projection method](#choosing-a-projection-method)
  + [Pcp](#pcp)
  + [Mlp](#mlp)
* [Examples](#examples)
  + [Demonstration data](#demonstration-data)
  + [Pcp method](#pcp-method)
    - [Projection](#projection-1)
    - [Seperation classification](#seperation-classification-1)
    - [Score permuation](#score-permuation)
  + [Mlp method](#mlp-method)
    - [Projection](#projection-2)
    - [Separation classification](#separation-classification)
    - [Score permutation](#score-permutation-1)
* [Principal Component Analysis](#principal-component-analysis)
* [Common questions](#common-questions)
* [Advanced usage](#advanced-usage)
  + [Concatenate permutation results](#concatenate-permutation-results)
  + [User defined permutation matrix](#user-defined-permutation-matrix)
* [Conclusion](#conclusion)
* [Session info](#session-info)

# Introduction

The ClusterSignificance package provides tools to assess if “class clusters” in dimensionality reduced data representations have a separation different from permuted data. The term “class clusters” here refers to, clusters of points representing known classes in the data. This is particularly useful to determine if a subset of the variables, e.g. genes in a specific pathway, alone can separate samples into these established classes. Evaluation of this is accomplished in a three stage process *Projection*, *Separation classification*, and *Score permutation*. To be able to compare class cluster separations, we give them a score based on this separation. First, all data points are projected onto a line (*Projection*), after which the best separation for two groups at a time is identified and scored (*Separation classification*). Finally, to get a p-value for the separation, we compare the separation score for our real data to the separation score for permuted data (*Score permutation*).

The package includes 2 different methods for accomplishing the Projection step outlined above, *Mean line projection* (**Mlp**) and *Principal curve projection* (**Pcp**). Here we will first underline the assumptions made by the ClusterSignificance method, followed by a description of the similarities of the three stages of ClusterSignificance independent of which Projection method is used. This is followed by an example of the Mlp and Pcp methods and a description of the unique features of each. Furthermore, we provide an example where ClusterSignificance is used to examine the separation between 2 class clusters downsteam of a principal component analysis (PCA).

# Assumptions

The ClusterSignificance package operates based on three simple assumptions shown below:

1. The dimensionality reduction method was sufficiently capable of detecting the dissimilarities, characterised by features in high-dimensional space, that correspond to the class separations under investigation.
2. The obtained principal curve accurately depicts the data with respect to the class separations under consideration.
3. Under the null hypothesis, the joint distribution remains invariant under all rearrangements of the subscripts.

# Methods

## Projection

The inputs to the Projection methods are a matrix of the data representation after dimensionality reduction and the class labels. (Dimensionality reduction is not strictly necessary which is discussed further in [common questions](#common-questions)) The input matrix should be constructed with data points (or samples) on the rows, and dimensions (or principal components) in the columns. For the method to know which rows are in the same class, the class argument must be specified. The class argument should be a character vector without NA’s. The projection step utilises either the Mlp or Pcp method to project all data points onto a line, after which they are moved into a single dimension.

## Seperation classification

Now that all of the points are in one dimension, it allows us to easily define a perpendicular line that best separates the two classes. This is accomplished by utilising the user defined classes to calculate the sensitivity and specificity at each possible separation of the projected data. The score for each possible separation is then calculated based on the formula below which measures the complement of the Euclidean distance from each seperation to the ROC curves operating point:

\[score = 1 - \sqrt{(1-specificity)^2 + (1-sensitivity)^2}\]

In addition to the separation scores, the Separation classification stage also outputs the area under the curve (AUC) for each class separation under investigation. AUC serves as an intuitive measure of the class separation in the projected space.

## Score permutation

The null-hypothesis of the permutation stage is that the class labels are independent of the features and, thus rejection of the null indicates a dependence of these variables and consequently, a separation between classes. Permutation is performed by randomly sampling the input matrix, with replacement, and assigning the data points to the groups. The projection and classification steps are then run for the sampled matrix. The max separation score is recorded and the next permutation is performed. The p-value can subsequently be calculated with the following formula:

\[p.value=\frac{count\ of\ permuted\ scores >= real\ score}{iterations}\]

If none of the permuted scores are greater that the real score the p-value is instead calculated as:

\[p.value < 10^{-log10(iterations)}\]

Due to the fact that the score permutation stage will typically be a monte carlo test, rather that a permutation test, the p-value is actually a p-value estimate with a confidence interval. A discussion concerning this and the number of permutations necessary can be found [here](#common-questions).

# Choosing a projection method

As previously mentioned, there are two projection methods provided with the ClusterSignificance package; *Principal curve projection* (**Pcp**) and *Mean line projection* (**Mlp**) . These are outlined below together with the situations where each can be used.

## Pcp

The Pcp method is suitable in situations where more than 2 dimensions need to be considered simultaneously (although Pcp works with only 2 dimensions) and/or more than 2 class separations should be analysed. It is limited by the fact that, the Pcp method will not work for < 5 data points per class and must have > 5 unique values per dimension. The Pcp method utilises the principal\_curve method from the princurve package to fit a principal curve to the data points utilising all the dimensions input by the user. A principal curve can be described as a “smooth curve that passes through the middle of the data in an orthogonal sense”. All data points are then projected onto the principal curve and transferred into one dimension for scoring.

## Mlp

The Mlp method is suitable for comparing clusters in a maximum of 2 dimensions when the separation between a maximum of 2 classes will be evaluated at a time. Briefly, Mlp functions by drawing a regression line through the means of the two classes and then projects all points onto that line. To project the points into one dimension, the points are then rotated onto the x-axis. A detailed description and graphical representation of the individual steps can be seen in the Mlp example below. It should be noted that, despite the fact that the Mlp method will work with as low as 2 data points per class, it may not be advisable to perform an analysis with such a small amount of data.

# Examples

```
library(ClusterSignificance)
```

## Demonstration data

The ClusterSignificance package includes 2 small example data matrices, one used for demonstrating the Mlp method and one used for demonstrating the Pcp method. The Mlp demo matrix has 2 dimensions whereas, the Pcp demo matrix has 4. In addition, the class variable has been added as the rownames of each matrix, with the Mlp demo matrix having 2 classes and the Pcp demo matrix having 3 classes. Finally, colnames, indicating the dimension number, were also added to each matrix. Neither colnames or rownames are needed for the input matrix to ClusterSignificance functions and we have only added them here only for clarity.

```
data(mlpMatrix)
```

Head; Mlp matrix.

|  | dim1 | dim2 |
| --- | --- | --- |
| class1 | 0.42 | 0.50 |
| class1 | 0.86 | 0.85 |
| class1 | 0.57 | 0.42 |

Rownames table; Mlp matrix.

| classes | Freq |
| --- | --- |
| class1 | 20 |
| class2 | 20 |

```
data(pcpMatrix)
```

Head; Pcp matrix.

|  | dim1 | dim2 | dim3 |
| --- | --- | --- | --- |
| class1 | 0.17 | 0.82 | 0.72 |
| class1 | 0.81 | 0.06 | 0.82 |
| class1 | 0.38 | 0.80 | 0.82 |

Rownames table; Pcp matrix.

| classes | Freq |
| --- | --- |
| class1 | 20 |
| class2 | 20 |
| class3 | 20 |

## Pcp method

### Projection

To provide the readers with an easy to follow example, we generated *in silico* data representative of output from a dimensionality reduction algorithm. The demonstration data was simulated so that one cluster has a visible separation from the two other clusters, whereas two of the clusters are largely overlapping. Therefore, we can imagine that ClusterSignificance will find 2 separations to be significant where as the other will be insignificant.

```
## Create the group variable.
classes <- rownames(pcpMatrix)

## Run Pcp and plot.
prj <- pcp(pcpMatrix, classes)
plot(prj)
```

![](data:image/png;base64...)

The following steps take place during Pcp projection:

1. The input matrix.
2. Drawing the principal curve.
3. Projection of points onto the principal curve.
4. The points after projection onto the principal curve.
5. Projection of points into one dimension.
6. The final projection of points.

### Seperation classification

The classification function works in the same manner for both the Mlp and Pcp methods and is previously described in the [Classification][] section. The lines perpendicular to the x-axis in the classification plot represent the separation scores for all possible separations. The highest scoring separation of the two classes is represented by the highest perpendicular line. Due to the fact that the Pcp method can perform several class comparisons at once, when > 2 classes are used all possible separations are automatically analysed and plotted.

```
cl <- classify(prj)
plot(cl)
```

![](data:image/png;base64...)

Furthermore, as a measure of effect size we can examine the AUC for each separation.

```
getData(cl, "AUC")
```

```
## class1 vs. class3 class2 vs. class3 class1 vs. class2
##           0.61250           0.95750           0.96875
```

### Score permuation

```
#permute matrix
iterations <- 100 ## Set the number of iterations.

## Permute and plot.
pe <- permute(
    mat = pcpMatrix,
    iter = iterations,
    classes = classes,
    projmethod = "pcp"
)

plot(pe)
```

![](data:image/png;base64...)

```
pvalue(pe)
```

```
## class1 vs class2 class1 vs class3 class2 vs class3
##             0.01             0.11             0.01
```

The permutation plot shows a histogram of the max separation scores from all permutations with the vertical red line representing the max score from the real data. The p-values can be obtained using `pvalue(pe)`. The results from the permutation indicate that ClusterSignificance performed as we would expect. The separation for class1 vs class3 is not significant at alpha = 0.05, whereas the separations for both class1 vs class2 and class2 vs class3 are significant.

We can also calculate a confidence interval for the p-value estimates using the following command:

```
conf.int(pe, conf.level = .99)
```

```
##            class1 vs class2 class1 vs class3 class2 vs class3
## CI99%-low        0.00000000       0.04450171       0.00000000
## CI99%-high       0.05160403       0.21454670       0.05160403
```

If it is unclear why these are p-value estimates or why we would want a confidence interval for them, please refer to [Common questions](#common-questions).

## Mlp method

### Projection

The Mlp method is suitable for comparing clusters in a maximum of 2 dimensions when the separation between a maximum of 2 classes will be evaluated at a time. Briefly, Mlp functions by drawing a regression line through the means of the two classes and then projects all points onto that line. To project the points into one dimension, the points are then rotated onto the x-axis. A detailed description and graphical representation of the individual steps can be seen in the example below. It should be noted that, despite the fact that the Mlp method will work with as low as 2 data points per group, it may not be advisable to perform an analysis with such a small amount of data.

We use the demonstration data included with the package to demonstrate the Mlp function.

```
## Create the group variable.
classes <- rownames(mlpMatrix)

## Run Mlp and plot.
prj <- mlp(mlpMatrix, classes)
plot(prj)
```

![](data:image/png;base64...)

The plot above shows the 6 steps Mlp takes to project the points into one dimension.

1. The input matrix.
2. Finding the mean of each class.
3. Regression line and move to origo.
   1. The regression line is drawn through the mean of each class.
   2. Adjustment of the line and points so the line passes through origo.
      1. Arrows show the move from the original position to new position.
4. Orthogonal projection onto the regression line.
5. Points shown after projection.
6. The final rotation of points into one dimension.

### Separation classification

```
## Classify and plot.
cl <- classify(prj)
plot(cl)
```

![](data:image/png;base64...)

The classification function works in the same manner for both the Mlp and Pcp methods and is previously described in the [Classification][] section.

### Score permutation

```
## Set the seed and number of iterations.
iterations <- 500

## Permute and plot.
pe <- permute(
    mat = mlpMatrix,
    iter = iterations,
    classes = classes,
    projmethod = "mlp"
)

plot(pe)
```

![](data:image/png;base64...)

```
## class1 vs class2
##            0.002
```

```
##            class1 vs class2
## CI99%-low        0.00000000
## CI99%-high       0.01054069
```

From the permutation plot can see that when comparing the separation of class1 vs. class2 the permuted data, using 100 iterations, never scores higher than the real data. Thus, the separation thus has a p-value < 0.01.

# Principal Component Analysis

One probable application for ClusterSignificance would be the analysis of cluster separation post-PCA. Here we use the leukemia dataset from the plsgenomics package to demonstrate how this may be done. The dataset includes “gene expression data (3051 genes and 38 leukemia samples) from the leukemia microarray study of Golub et al. (1999)”. The tumor samples are from both acute lymphoblastic leukemia (ALL) and acute myeloid leukemia (AML) patients. Due to the inherent differences in the transcriptome of these two cancer types, we hypothesise that they would form separate clusters post-PCA and that we can use ClusterSignificance to examine if this separation is significant.

```
## The leukemia dataset is provided as a list with 3 elements.
## An explaination of these can be found using the command:
## help(leukemia)

library(plsgenomics, quietly = TRUE)
data(leukemia)

## Extract the expression matrix.
expression <- leukemia$X

## Run PCA and extract the principal components.
pca <- prcomp(expression, scale = TRUE)
mat <- pca$x

## Extract the grouping variable (coded as 1 (ALL) and 2 (AML)).
classes <- ifelse(leukemia$Y == 1, "ALL", "AML")
```

Classes argument table.

| classes | Freq |
| --- | --- |
| ALL | 27 |
| AML | 11 |

```
ob <- pcp(mat, classes, normalize = TRUE)
plot(ob)
```

![](data:image/png;base64...)

```
cl <- classify(ob)
plot(cl)
```

![](data:image/png;base64...)

```
iterations <- 100
pe <- permute(mat = mat, iter = iterations, classes = classes, projmethod = "pcp")
pvalue(pe)
```

```
## ALL vs AML
##       0.01
```

```
conf.int(pe)
```

```
##            ALL vs AML
## CI99%-low  0.00000000
## CI99%-high 0.05160403
```

As we can see from the results, at alpha 0.05, we would reject the null hypothesis concluding that there is a separation between the AML and ALL class clusters. Despite this, by examining the confidence interval, we see that the upper limit is greater than 0.05 which should give us pause before rejecting the null at alpha = 0.05. Although not run here, 10000 iterations results in p = < 1e-04 with the confidence interval of CI99%-low = 0.00000 and CI99%-high = 0.00052 giving us greater confidence to reject the null.

# Common questions

***Do I have to use dimensionality reduced data as input to ClusterSignificance.***

Well, technically no, although ClusterSignificance was designed to function downstream of dimensionality reduction algorithms and we see this being the most frequent use-case for ClusterSignificance. One of the reasons for this is, it is often the case that datasets containing a large number of features, such as those originating from high throughput experiments, will often contain features that cannot discriminate between the class separations of interest. This is often accompanied by “background noise” arising during the sample preparation Dimensionality reduction thus serves here as a feature selection method, identifying sources of large variation within the data. Despite this, there are some potential pitfalls with dimensionality reduction which are highlighted in the next question.

***What does the assumption “The obtained principal curve accurately depicts the data with respect to the class separations under consideration” mean?***

We believe the principal curve method to be a robust method that will perform well in the majority of situations we predict ClusterSignificance to be used in. Despite this, the principal curve method is an unsupervised method and therefore, it is not necessarily the case that it will be drawn in an optimal way to access the class separations of interest. We currently have some functionality allowing the user to regulate the smoothness of the principal curve. This can be accomplished using the `df` argument to the `pcp` function **BUT** you must supply the same argument to the `permute` function or your results will not be valid. We recommend altering the `df` argument as a last resort and to only be used under situations where no other alternative is available.

***What does the assumption “The dimensionality reduction method was sufficiently capable of detecting the dissimilarities, characterised by features in high-dimensional space, that correspond to the class separations under investigation” mean?***

Dimensionality reduction can be said to detect dissimilarities, characterised by features in high-dimensional space although, there is no guarantee that the dissimilarities it detects will be those discriminating the class separations you are interested in. In addition, linear dimensionality reduction methods, such as PCA, may not provide a useful representation of the data when the discriminatory features between classes under investigation vary in a non-linear fashion.

***What does the assumption “The joint distribution remains invariant under all rearrangements of the subscripts.” mean?***

This is a standard assumption for permutation tests which means that the data must exhibit “exchangeability”. A basic description of exchangeability can be found [here](https://en.wikipedia.org/wiki/Exchangeable_random_variables). *Extensions Of The Concept Of Exchangeability And Their Applications* Good (2012) provides a detailed discussion on this topic.

***Does ClusterSignificance actually perform a permutation test?***

Despite the name of one of ClusterSignificance’s stages being *permutation*, strictly speaking, ClusterSignificance is not designed to perform a permutation test. Due to the fact that a real permutation test tests all possible combinations without replacement, which is often infeasible, most users will actually be performing a monte carlo test. Instead of permuting all possible combinations to form the null distribution (or permutation distribution), a monte carlo test samples the permutation distribution and uses this sample as the null distribution. For this reason, a p-value from a monte carlo test is actually a estimate of the true p-value. For this reason we provide the `conf.int` function that will calculate the confidence interval for the p-value estimate. It is theoretically, possible to perform a permutation test with ClusterSignificance by providing your own permutation matrix instead of letting ClusterSignificance calculate one for you which we discuss in the [Advanced usage](#advanced-usage) section.

***How many permutations should I run?***

The complete answer to this question is too in-depth to answer here. We would recommend 10^4 permutations as a starting point. Ideally, the permutation test returns a exact p-value (i.e. not p-value < X), which means that at least one permuted max score was greater than the max score for the real data, although this is not always possible. Furthermore, it is unnecessary to run more permutations than possible class combinations, which provides one concrete way to calculate the number of ideal permutations. Despite this, it will often challenge your computers memory to calculate this number if many combinations are possible. Under such circumstances, it is common that the permutation distribution is randomly sampled and the more times this sampling occurs, the nearer your estimate of the p-value will come to the true p-value (see the question above). A confidence interval can be calculated for the reported p-value using the `conf.int` function.

***Why does the principal curve change shape between steps 3 and 4 of the projection phase?***

The line is actually the same shape, it is the scale of the X-axis that changes. This is necessary due to the fact that as the points move to one dimension more space is needed on the x-axis to show all the points.

***Why are the points projected diagonally onto the line in step 4 of the Mlp projection?***

Step 4 shows the orthogonal projection onto the regression line and appears visually to not be perpendicular to the line. This is due to the automatic scaling of the y-axis which is necessary when large differences in proportions between the x and y dimensions would otherwise cause data to disappear outside of the margins.

# Advanced usage

## Concatenate permutation results

When running the permutation step of the Pcp method, it is possible that all iterations are not successfully completed, as can be seen with the message upon permutation completion. Due to the fact that, the p-value is calculated not by the number of iterations input by the user but, instead, with the number of iterations that successfully complete, this will not be an issue for most users. However, if it is the case that a specific number of iterations is required by the user it is possible to concatenate multiple permutation runs.

```
mat <- mlpMatrix
classes <- rownames(mlpMatrix)
iterations <- 10

pe1 <- permute(mat=mat, iter=iterations, classes=classes, projmethod="pcp")
pe2 <- permute(mat=mat, iter=iterations, classes=classes, projmethod="pcp")
pe3 <- permute(mat=mat, iter=iterations, classes=classes, projmethod="pcp")
pvalue(pe1)
```

```
## class1 vs class2
##              0.1
```

```
pe <- c(pe1, pe2, pe3)
pvalue(pe)
```

```
## class1 vs class2
##       0.03333333
```

## User defined permutation matrix

In some cases, e.g. PCA, it may be desirable to define a permutation matrix rather than allowing ClusterSignificance to do this automatically. For example, when determining the separation of clusters post-PCA, a more valid approach may be to perform PCA on a sampled matrix of the original values, after which this is provided to ClusterSignificance, rather than allowing ClusterSignificance to randomly sample the principal components. This can be accomplished by providing the *user.permutations* argument to the permute method.

```
##define permMatrix function
.pca <- function(y, classes, uniq.groups, mat) {
    pca <- prcomp(
        sapply(1:ncol(mat[classes %in% uniq.groups[, y], ]),
            function(i)
                mat[classes %in% uniq.groups[, y], i] <-
                    sample(
                        mat[classes %in% uniq.groups[, y], i],
                        replace=FALSE
                    )
        ), scale=TRUE
    )
    return(pca$x)
}

permMatrix <- function(iterations, classes, mat) {
    uniq.groups <- combn(unique(classes), 2)
    permats <- lapply(1:ncol(uniq.groups),
        function(y)
            lapply(1:iterations,
                function(x)
                    .pca(y, classes, uniq.groups, mat)
            )
    )
    return(permats)
}

set.seed(3)
mat <- pcpMatrix
classes <- rownames(pcpMatrix)
iterations = 100
permats <- permMatrix(iterations, classes, mat)
```

The permutation matrix is a list (we can call this list 1) with one element per comparison. Each of the elements in list 1 holds another list (we can call this list 2). The number of elements in list 2 is equal to the number of iterations and, thus, each element in list 2 is a permuted matrix. We can then provide this permutation matrix to ClusterSignificance in the following manner:

```
pe <- permute(
    mat = mat,
    iter=100,
    classes=classes,
    projmethod="pcp",
    userPermats=permats
)
```

# Conclusion

The ClusterSignificance package can estimate a p-value for a separation projected on a line. Typically, the package might be used post-PCA-analysis, but clusters coming from other sources can also be tested.

# Session info

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] plsgenomics_1.5-3          ClusterSignificance_1.38.0
## [3] ggplot2_4.0.0              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6         jsonlite_2.0.0       dplyr_1.1.4
##  [4] compiler_4.5.1       BiocManager_1.30.26  maps_3.4.3
##  [7] tidyselect_1.2.1     Rcpp_1.1.0           stringr_1.5.2
## [10] parallel_4.5.1       dichromat_2.0-0.1    jquerylib_0.1.4
## [13] scales_1.4.0         RhpcBLASctl_0.23-42  boot_1.3-32
## [16] yaml_2.3.10          fastmap_1.2.0        plyr_1.8.9
## [19] R6_2.6.1             generics_0.1.4       knitr_1.50
## [22] MASS_7.3-65          dotCall64_1.2        tibble_3.3.0
## [25] bslib_0.9.0          pillar_1.11.1        RColorBrewer_1.1-3
## [28] rlang_1.1.6          stringi_1.8.7        cachem_1.1.0
## [31] xfun_0.53            sass_0.4.10          S7_0.2.0
## [34] viridisLite_0.4.2    cli_3.6.5            withr_3.0.2
## [37] magrittr_2.0.4       digest_0.6.37        grid_4.5.1
## [40] spam_2.11-1          lifecycle_1.0.4      princurve_2.1.6
## [43] fields_17.1          vctrs_0.6.5          scatterplot3d_0.3-44
## [46] evaluate_1.0.5       pracma_2.4.6         glue_1.8.0
## [49] farver_2.1.2         reshape2_1.4.4       rmarkdown_2.30
## [52] tools_4.5.1          pkgconfig_2.0.3      htmltools_0.5.8.1
```