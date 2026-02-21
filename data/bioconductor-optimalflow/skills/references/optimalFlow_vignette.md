# optimalFlow: optimal-transport approach to Flow Cytometry analysis

Hristo Inouzhe1\*

1Universidad de Valladolid, Spain

\*hristo.inouzhe@gmail.com

#### 30 October, 2025

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 optimalFlowTemplates](#optimalflowtemplates)
* [4 optimalFlowClassification](#optimalflowclassification)
* [References](#references)

# 1 Introduction

*optimalFlow* is a package dedicated to applying optimal-transport techniques to supervised flow cytometry gating based on the results in del Barrio et al. ([2019](#ref-optimalFlow)).

We provide novel methods for grouping (clustering) gated cytometries. By clustering a set of cytometries we are producing groups (clusters) of cytometries that have lower variability than the whole collection. This in turn allows to improve greatly the performance of any supervised learning procedure. Once we have a partition (clustering) of a collection of cytometries, we provide several methods for obtaining an artificial cytometry (prototype, template) that represents in some optimal way the cytometries in each respective group. These prototypes can be used, among other things, for matching populations between different cytometries. Even more, a procedure able to group similar cytometries could help to detect individuals with a common particular condition, for instance some kind of disease.

*optimalFlowTemplates* is our procedure for clustering cytometries and obtaining templates. It is based on recent developments in the field of optimal transport such as a *similarity distance* between clusterings and a *barycenter* (Frechet mean) and *k-barycenters* of probability distributions.

We introduce *optimalFlowClassification*, a supervised classification tool for the case when a database of gated cytometries is available. The procedure uses the prototypes obtained by *optimalFlowTemplates* on the database. These are used to initialize *tclust*, a robust extension of k-means that allows for non-spherical shapes, for gating a new cytometry (see Garcia-Escudero et al. ([2008](#ref-tclust))). By using a similarity distance between the best clustering obtained by *tclust* and the artificial cytometries provided by *optimalFlowTemplates* we can assign the new cytometry to the most similar template (and the respective group of cytometries). We provide several options of how to assign cell types to the new cytometry using the most relevant information, represented by the assigned template and the respective cluster of cytometries.

# 2 Installation

Installation procedure:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("optimalFLow")
```

# 3 optimalFlowTemplates

```
library(optimalFlowData)
library(optimalFlow)
library(ellipse)
```

We start by providing a database of gated cytometries. In this case we select as a learning set 15 cytometries of healthy individuals, from the data provided in optimalFlowData. We will use Cytometry1 to test the results of our procedures. For simplicity and for the sake of a good visualisation we will select only some of the cell types, in particular a subset of 4 cell types.

```
database <- buildDatabase(
 dataset_names = paste0('Cytometry', c(2:5, 7:9, 12:17, 19, 21)),
   population_ids = c('Monocytes', 'CD4+CD8-', 'Mature SIg Kappa', 'TCRgd-'))
```

Then we apply optimalFlowTemplates to obtain a clustering of the database and a template cytometry for each group.

```
templates.optimalFlow <-
  optimalFlowTemplates(
    database = database
    )
```

When running the default mode for optimalFlowTemplates we obtain a plot as in the figure bellow and then we are asked how many clusters we want to look for.
![Figure 0: learning clustering](data:image/png;base64...)
From the plot it seems reasonable to look for 5 clusters of cytometries and we could introduce 5 and press enter, and the procedure will give us a clustering of the learning database and the respective templates. Since this is hard to show in a vignette, an equivalent way of doing this procedure is to execute the command bellow, where we ask for 5 clusters directly.

```
templates.optimalFlow <-
  optimalFlowTemplates(
    database = database, templates.number = 5, cl.paral = 1
    )
```

```
## [1] "step 1: 7.16510438919067 secs"
## [1] "step 2: 3.54712629318237 secs"
## [1] "Execution time: 10.7125630378723 secs"
```

Now let us understand what does optimalFlowTemplates return. In the entry templates we have the artificial cytometries, viewed as mixtures of multivariate normal distributions, corresponding to the clustering of the cytometries in the database argument.

```
length(templates.optimalFlow$templates) # The number of clusters, and, hence, of templates
```

```
## [1] 5
```

```
length(templates.optimalFlow$templates[[1]]) # The number of elements of the first template, it contains four cell types
```

```
## [1] 4
```

```
templates.optimalFlow$templates[[1]][[1]] # The first element of the first template
```

```
## $mean
##  [1] 2192.494 3810.563 6952.128 5639.010 5384.128 2326.237 5922.809 2433.990
##  [9] 1616.252 1213.455
##
## $cov
##              [,1]      [,2]        [,3]        [,4]       [,5]       [,6]
##  [1,] 266639.3056 -22292.14   -239.0103    535.9492   1567.078   6667.185
##  [2,] -22292.1405 836892.17 139258.7108 -11083.0852 -26847.414 -85912.718
##  [3,]   -239.0103 139258.71  84833.6993   2831.9085  -1760.811 -19372.852
##  [4,]    535.9492 -11083.09   2831.9085  16117.5771   9840.944   9733.887
##  [5,]   1567.0780 -26847.41  -1760.8109   9840.9437  17040.123  19173.990
##  [6,]   6667.1845 -85912.72 -19372.8521   9733.8866  19173.990 260893.832
##  [7,] -10530.5174 -12155.85 -12970.2311   8010.5743  11112.547  24739.592
##  [8,]   6396.7471 -53880.87 -11968.9063   7805.0819  10494.816  63602.554
##  [9,]   3686.7700 -83687.89 -17876.9602  13542.7236  17424.683  43574.279
## [10,]   2391.6170 -61685.80 -13296.8699  13933.2564  17777.541  40569.455
##             [,7]       [,8]      [,9]      [,10]
##  [1,] -10530.517   6396.747   3686.77   2391.617
##  [2,] -12155.854 -53880.868 -83687.89 -61685.795
##  [3,] -12970.231 -11968.906 -17876.96 -13296.870
##  [4,]   8010.574   7805.082  13542.72  13933.256
##  [5,]  11112.547  10494.816  17424.68  17777.541
##  [6,]  24739.592  63602.554  43574.28  40569.455
##  [7,] 135789.172   7525.035  21765.08  20272.826
##  [8,]   7525.035 153027.526  25157.58  26236.325
##  [9,]  21765.079  25157.581  76070.14  43082.883
## [10,]  20272.826  26236.325  43082.88  51273.104
##
## $weight
## [1] 0.5845872
##
## $type
## [1] "CD4+CD8-"
```

In the argument clustering we have the clustering of the cytometries in the database argument.

```
templates.optimalFlow$clustering
```

```
##  [1] 1 2 3 3 3 3 4 4 4 1 2 3 5 5 5
```

In the argument database.elliptical we have a list containing each cytometry in the database viewed as a mixture distribution. Each element of the list is a cytometry viewed as a mixture.

```
length(templates.optimalFlow$database.elliptical) # the number of elements in the database
```

```
## [1] 15
```

```
length(templates.optimalFlow$database.elliptical[[1]]) # the number of cell types in the first element of the database
```

```
## [1] 4
```

```
templates.optimalFlow$database.elliptical[[1]][[1]] # the parameters corresponding to the first cell type in the first cytometry of the database
```

```
## $mean
## CD19/TCRgd:PE Cy7-A LOGICAL       CD38:APC H7-A LOGICAL
##                    2143.244                    3769.941
##           CD3:APC-A LOGICAL       CD4+CD20:PB-A LOGICAL
##                    6912.857                    5613.595
##           CD45:PO-A LOGICAL       CD56+IgK:PE-A LOGICAL
##                    5404.314                    2068.134
##   CD5:PerCP Cy5-5-A LOGICAL      CD8+IgL:FITC-A LOGICAL
##                    5784.786                    2403.888
##                FSC-A LINEAR           SSC-A Exp-SSC Low
##                    1578.943                    1226.318
##
## $cov
##                             CD19/TCRgd:PE Cy7-A LOGICAL CD38:APC H7-A LOGICAL
## CD19/TCRgd:PE Cy7-A LOGICAL                 304347.8532            -31430.672
## CD38:APC H7-A LOGICAL                       -31430.6717            786050.701
## CD3:APC-A LOGICAL                            -2056.8937            150481.538
## CD4+CD20:PB-A LOGICAL                          666.2252            -10919.205
## CD45:PO-A LOGICAL                             2933.2678            -34008.120
## CD56+IgK:PE-A LOGICAL                         7953.3654            -68622.841
## CD5:PerCP Cy5-5-A LOGICAL                    -7811.8852              5441.639
## CD8+IgL:FITC-A LOGICAL                        4737.6958            -42476.068
## FSC-A LINEAR                                  3825.7518            -87894.919
## SSC-A Exp-SSC Low                             3422.1236            -72960.311
##                             CD3:APC-A LOGICAL CD4+CD20:PB-A LOGICAL
## CD19/TCRgd:PE Cy7-A LOGICAL         -2056.894              666.2252
## CD38:APC H7-A LOGICAL              150481.538           -10919.2047
## CD3:APC-A LOGICAL                   93068.194             2462.9102
## CD4+CD20:PB-A LOGICAL                2462.910            15537.7342
## CD45:PO-A LOGICAL                   -4062.620             9567.5234
## CD56+IgK:PE-A LOGICAL              -11052.254             8858.6946
## CD5:PerCP Cy5-5-A LOGICAL           -6831.220             8039.8935
## CD8+IgL:FITC-A LOGICAL              -8281.683             7577.5080
## FSC-A LINEAR                       -21798.893            14235.2106
## SSC-A Exp-SSC Low                  -17098.563            15356.9021
##                             CD45:PO-A LOGICAL CD56+IgK:PE-A LOGICAL
## CD19/TCRgd:PE Cy7-A LOGICAL          2933.268              7953.365
## CD38:APC H7-A LOGICAL              -34008.120            -68622.841
## CD3:APC-A LOGICAL                   -4062.620            -11052.254
## CD4+CD20:PB-A LOGICAL                9567.523              8858.695
## CD45:PO-A LOGICAL                   18350.645             23190.956
## CD56+IgK:PE-A LOGICAL               23190.956            305557.028
## CD5:PerCP Cy5-5-A LOGICAL           10778.661             25521.650
## CD8+IgL:FITC-A LOGICAL              10729.306             36294.993
## FSC-A LINEAR                        20416.550             42905.671
## SSC-A Exp-SSC Low                   22260.189             46700.463
##                             CD5:PerCP Cy5-5-A LOGICAL CD8+IgL:FITC-A LOGICAL
## CD19/TCRgd:PE Cy7-A LOGICAL                 -7811.885               4737.696
## CD38:APC H7-A LOGICAL                        5441.639             -42476.068
## CD3:APC-A LOGICAL                           -6831.220              -8281.683
## CD4+CD20:PB-A LOGICAL                        8039.894               7577.508
## CD45:PO-A LOGICAL                           10778.661              10729.306
## CD56+IgK:PE-A LOGICAL                       25521.650              36294.993
## CD5:PerCP Cy5-5-A LOGICAL                  132092.612               2550.771
## CD8+IgL:FITC-A LOGICAL                       2550.771             152836.556
## FSC-A LINEAR                                22131.202              20286.385
## SSC-A Exp-SSC Low                           21582.260              25351.863
##                             FSC-A LINEAR SSC-A Exp-SSC Low
## CD19/TCRgd:PE Cy7-A LOGICAL     3825.752          3422.124
## CD38:APC H7-A LOGICAL         -87894.919        -72960.311
## CD3:APC-A LOGICAL             -21798.893        -17098.563
## CD4+CD20:PB-A LOGICAL          14235.211         15356.902
## CD45:PO-A LOGICAL              20416.550         22260.189
## CD56+IgK:PE-A LOGICAL          42905.671         46700.463
## CD5:PerCP Cy5-5-A LOGICAL      22131.202         21582.260
## CD8+IgL:FITC-A LOGICAL         20286.385         25351.863
## FSC-A LINEAR                   73060.828         50515.337
## SSC-A Exp-SSC Low              50515.337         59919.397
##
## $weight
## [1] 0.6898461
##
## $type
## [1] "CD4+CD8-"
```

In order to get some intuition about our methodology we are going to give some visual examples. Users can do it for their own data once they have applied optimalFlowTemplates.

We start with a two-dimensional representation of the cytometries of the cluster labelled as 3. As we have gated cytometries in the database we know every cell type, and, even more, we can consider every cytometry as a mixture of multivariate Gaussian distributions and this is stored in templates.optimalFlow$database.elliptical. The user just has to select the variables in which to project the cytometries through the variable dimensions.

```
cytoPlotDatabase(templates.optimalFlow$database.elliptical[which(templates.optimalFlow$clustering == 3)], dimensions = c(4,3), xlim = c(0, 8000), ylim = c(0, 8000), xlab = "", ylab = "")
```

![](data:image/png;base64...)
Black ellipses correspond to the cell type CD4+CD8- in each cytometry and enclose 95% of the probability for the respective multivariate normal distributions. Red ellipses correspond to Mature Sig Kappa and so on.

A three-dimensional plot of the same case is provided as a static image and can be obtained using the following code.

```
cytoPlotDatabase3d(templates.optimalFlow$database.elliptical[which(templates.optimalFlow$clustering == 3)], dimensions = c(4, 3, 9), xlim = c(0, 8000), ylim = c(0, 8000), zlim = c(0, 8000))
```

![](data:image/png;base64...)

Figure 1: pooling database

optimalFlowTemplates provides a template cytometry for each cluster, stored in the entry templates. We present here how to visualize in 2d the consensus cytometry, the template, corresponding to cluster 3. Recall that the cytometries belonging to cluster 3 have been plotted above. The code is straightforward, we access templates in templates.optimalFlow and select the third element of the list, since we are interested in cluster 3.

```
cytoPlot(templates.optimalFlow$templates[[3]], dimensions = c(4,3), xlim = c(0, 8000), ylim = c(0, 8000), xlab = "", ylab = "")
```

![](data:image/png;base64...)
A three dimensional plot of the same case is provided as a static image and can be obtained using the following code.

```
cytoPlot3d(templates.optimalFlow$templates[[3]], dimensions = c(4, 3, 9), xlim = c(0, 8000), ylim = c(0, 8000), zlim = c(0, 8000))
```

![](data:image/png;base64...)

cosa

It is clear that the prototype cytometry represents well the geometric information of the respective group of cytometries. This visualisation schemes allow users to check by themselves if the templates that they are obtaining are satisfying and if their clusters are really homogenous.

Another relevant situation in flow cytometry is when gatings of cytometries are available but without the identification of each cell type. For the cytometries of cluster 3 it is like we forgot about the colour, since now we do not have cell types identified.

```
cytoPlotDatabase(templates.optimalFlow$database.elliptical[which(templates.optimalFlow$clustering == 3)], dimensions = c(4,3), xlim = c(0, 8000), ylim = c(0, 8000), xlab = "", ylab = "", colour = FALSE)
```

![](data:image/png;base64...)
The respective 3d static image can be obtained using the following code.

```
cytoPlotDatabase3d(templates.optimalFlow$database.elliptical[which(templates.optimalFlow$clustering == 3)], dimensions = c(4, 3, 9), xlim = c(0, 8000), ylim = c(0, 8000), zlim = c(0, 8000), colour = FALSE)
```

![Figure 2: normal database](data:image/png;base64...)
From a visual inspection there is enough geometrical information that allows us to differentiate the cel types. It is just a matter of how to capture it.

Indeed, using some unsupervised procedure to obtain the consensus element (the prototype cytometry) should be enough to capture the relevant cluster structure. This can be achieved using *otpimalFlowTemplates* as follows.

In the following chunk of code we are using optimalFlowTemplates on our database, we are again looking for 5 clusters with the default clustering procedure which is hierarchical complete-linkage but now we vary the consensus.method variable. We are selecting to obtain the template cytometry using k-barycenters in the Wasserstein space, where k is set to be 4.

```
templates.optimalFlow.barycenter <-
  optimalFlowTemplates(
    database = database, templates.number = 5, consensus.method = "k-barycenter",
    barycenters.number = 4, bar.repetitions = 10, alpha.bar = 0.05, cl.paral = 1
    )
```

```
## [1] "step 1: 7.31687355041504 secs"
## [1] "step 2: 2.11634618441264 mins"
## [1] "Execution time: 2.23829854726791 mins"
```

A different way of obtaining the consensus cytometry is to use density based hierarchical clustering, in this case hdbscan, setting consensus.method = “hierarchical”. The advantage of this is that the number of cell types in the template cytometry is selected automatically.

```
templates.optimalFlow.hdbscan <-
  optimalFlowTemplates(
    database = database, templates.number = 5, consensus.method = "hierarchical",
    cl.paral = 1
    )
```

```
## [1] "step 1: 14.5850536823273 secs"
## [1] "step 2: 1.24240525563558 mins"
## [1] "Execution time: 1.48549712101618 mins"
```

As before, we can check how well the prototypes represent the group of cytometries. Again, we work with cluster 3. A 2d plot of the prototype cytometry obtained when using a 4-barycenter is provided, where colours represent different groups.

```
cytoPlot(templates.optimalFlow.barycenter$templates[[3]], dimensions = c(4,3), xlim = c(0, 8000), ylim = c(0, 8000), xlab = "", ylab = "")
```

![](data:image/png;base64...)
A three dimensional plot of the same case is provided as a static image and can be obtained using the following code.

```
cytoPlot3d(templates.optimalFlow.barycenter$templates[[3]], dimensions = c(4, 3, 9), xlim = c(0, 8000), ylim = c(0, 8000), zlim = c(0, 8000))
```

![](data:image/png;base64...)

cosa

We do the same for the density based hierarchical clustering.

```
cytoPlot(templates.optimalFlow.hdbscan$templates[[3]], dimensions = c(4,3), xlim = c(0, 8000), ylim = c(0, 8000), xlab = "", ylab = "")
```

![](data:image/png;base64...)

```
cytoPlot3d(templates.optimalFlow.hdbscan$templates[[3]], dimensions = c(4, 3, 9), xlim = c(0, 8000), ylim = c(0, 8000), zlim = c(0, 8000))
```

![cosa](data:image/png;base64...)
From the visual representations of above we see that the different methods for obtaining a prototype cytometry for the cluster of cytometries labelled as 3 are returning similar results. Even more, results do seem to summarize in a reasonable way the information contained in the cytometries of cluster 3. Hence, doing some 2 or 3-dimensional visual inspection of the results is advisable for the user and it allows for an informed inspection of our procedures.

A totally unsupervised way of obtaining groups and templates is given by using density-based hierarchical clustering both when clustering the database of cytometries and when obtaining the prototype cytometry.

```
templates.optimalFlow.unsup <-
  optimalFlowTemplates(
    database = database, hclust.method = "hdbscan", cl.paral = 1, consensus.method = "hierarchical"
    )
```

```
## [1] "step 1: 7.70220828056335 secs"
## [1] "step 2: 1.48413153886795 mins"
## [1] "Execution time: 1.61250737110774 mins"
```

```
print(templates.optimalFlow.unsup$clustering)
```

```
##  [1] 7 2 6 6 5 5 4 4 4 7 2 5 3 1 3
```

```
print(templates.optimalFlow$clustering)
```

```
##  [1] 1 2 3 3 3 3 4 4 4 1 2 3 5 5 5
```

```
cytoPlot(templates.optimalFlow.unsup$templates[[5]], dimensions = c(4,3), xlim = c(0, 8000), ylim = c(0, 8000), xlab = "", ylab = "")
```

![](data:image/png;base64...)

# 4 optimalFlowClassification

Once we have a grouped database with prototype cytometries for each group we can apply different supervised classification procedures to classify a new ungated cytometry.

We start by selecting a test cytometry which we will treat as a cytometry that we want to classify in order to see how our supervised classification methods work.

```
test.cytometry <- Cytometry1[which(match(Cytometry1$`Population ID (name)`, c("Monocytes", "CD4+CD8-", "Mature SIg Kappa", "TCRgd-"), nomatch = 0) > 0), ]
```

Let us begin with, essentially, the default method for using optimalFlowClassification. It consists in doing quadratic discriminant analysis using the most similar template.

```
classification.optimalFlow <-
  optimalFlowClassification(
    test.cytometry[, 1:10], database, templates.optimalFlow,
    consensus.method = "pooling", cl.paral = 1
    )
```

```
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.779782295227051 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.692036628723145 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.500674724578857 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.471200227737427 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.497829675674438 secs"
##
## [1] "step 1: 2.95156645774841 secs"
## [1] "Similarity distances to templates:"
##           [,1]      [,2]      [,3]      [,4]      [,5]
## [1,] 0.1480501 0.2994856 0.2598811 0.3117271 0.3368663
## [1] "step 2: 0.287295341491699 secs"
## [1] "step 3: 0.0249440670013428 secs"
## Time difference of 3.264596 secs
```

In order to execute properly our supervised classifications we need to provide the new cytometry we want to classify, in our case it is test.cytometry without the label information. Then we need to provide the database in which we have applied optimalFlowTemplates, the object returned by optimalFlowTemplates and the consensus.method that we have used in optimalFlowTemplates. This is necesary in order to be able to perform correctly the classification task.

The result we obtain is a list that we will analyse here to make the user familiar with it. The first argument is a clustering of the cytometry of interest.

```
head(classification.optimalFlow$cluster)
```

```
## [1] CD4+CD8- CD4+CD8- CD4+CD8- CD4+CD8- CD4+CD8- CD4+CD8-
## Levels: CD4+CD8- Mature SIg Kappa Monocytes TCRgd-
```

```
table(classification.optimalFlow$cluster)
```

```
##
##         CD4+CD8- Mature SIg Kappa        Monocytes           TCRgd-
##             7697             1577             6430              123
```

The argument clusterings contains the initial unsupervized or semi-supervized clusterings of the cytometry of interest. It is itself a list that can have as much entries as the number of templates in the semi-supervized case, or only one entry in the case of initial.method = “unsupervized”. The relevant argument for the clusterings is cluster.

```
length(classification.optimalFlow$clusterings)
```

```
## [1] 5
```

```
table(classification.optimalFlow$clusterings[[1]]$cluster)
```

```
##
##    1    2    3    4
## 7697 1577 6430  123
```

As we see the initial clustering is not the same as the final result.

Finally, we have an entry that indicates which prototype is the closest to the new cytometry. This information is relevant since it is the prototype used for classifying in the default execution of optimalFlowClassification.

```
classification.optimalFlow$assigned.template.index
```

```
## [1] 1
```

```
templates.optimalFlow$clustering
```

```
##  [1] 1 2 3 3 3 3 4 4 4 1 2 3 5 5 5
```

In this case test.cytometry is closest to the template corresponding to cluster 1 in templates.optimalFlow$clustering.

As we are performing supervised classification, a measure of how well our procedure works is in order. We have provided simple functions to calculate the median F-measure (see del Barrio et al. ([2019](#ref-optimalFlow)) for details).

```
scoreF1.optimalFlow <- optimalFlow::f1Score(classification.optimalFlow$cluster,
                                            test.cytometry, noise.types)
print(scoreF1.optimalFlow)
```

```
##           CD4+CD8- Mature SIg Kappa Monocytes TCRgd-
## F1-score         1                1         1      1
## Precision        1                1         1      1
## Recall           1                1         1      1
```

We see that median F1-score, the first row in the table is close to 1 for each cell type, reflecting that classification is good for each cell type.

When using a consensus method that is not pooling, the default in optimalFlowTemplates, we have to assign cell types to the clusters in the prototype cytometries. This is done by voting, since our database is formed by gated cytometries and we have assigned cell types.

```
classification.optimalFlow.barycenter <-
  optimalFlowClassification(
    test.cytometry[, 1:10],
    database, templates.optimalFlow.barycenter, consensus.method = "k-barycenter", cl.paral = 1
    )
```

```
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.320643663406372 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "1.17231702804565 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "1.24845480918884 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "1.38593053817749 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.677572727203369 secs"
##
## [1] "step 1: 4.82768511772156 secs"
```

```
## Weights do not add to 1. A normalization will be applied.
## Weights do not add to 1. A normalization will be applied.
## Weights do not add to 1. A normalization will be applied.
## Weights do not add to 1. A normalization will be applied.
```

```
## [1] "Similarity distances to templates:"
##          [,1]      [,2]      [,3]      [,4]      [,5]
## [1,] 0.151584 0.2999437 0.2614572 0.3032183 0.3426324
## [1] "step 2: 0.227657079696655 secs"
## [1] "step 3: 0.0491392612457275 secs"
## Time difference of 5.105431 secs
```

```
table(classification.optimalFlow.barycenter$cluster)
```

```
##
##    1    2    3    4
##  123 6430 7697 1577
```

```
classification.optimalFlow.barycenter$cluster.vote
```

```
## $`1`
##     cell simple.proportion
## 1 TCRgd-                 1
##
## $`2`
##        cell simple.proportion
## 1 Monocytes                 1
##
## $`3`
##       cell simple.proportion
## 1 CD4+CD8-                 1
##
## $`4`
##               cell simple.proportion
## 1 Mature SIg Kappa                 1
```

In this case the fuzzy classification is a hard one, since values of simple.proportion are all one. This means that label 1 is assigned to the entry in cell and so on.

```
classification.optimalFlow.barycenter$assigned.template.index
```

```
## [1] 1
```

```
templates.optimalFlow.barycenter$clustering
```

```
##  [1] 1 2 3 3 3 3 4 4 4 1 2 3 5 5 5
```

Since usually the relabelling in classification.optimalFlow.barycenter$cluster.vote is fuzzy, we need to convert it to a hard clustering and then apply our median F-measure criteria. This is done as follows.

```
scoreF1.optimalFlow.barycenter <-
  f1ScoreVoting(
    classification.optimalFlow.barycenter$cluster.vote, classification.optimalFlow.barycenter$cluster,
    test.cytometry,
    1.01, noise.types
    )
print(scoreF1.optimalFlow.barycenter$F1_score)
```

```
##           TCRgd- Monocytes CD4+CD8- Mature SIg Kappa
## F1-score       1         1        1                1
## Precision      1         1        1                1
## Recall         1         1        1                1
```

Exactly the same applies for the case of templates.optimalFlow.hdbscan.

```
classification.optimalFlow.hdbscan <-
  optimalFlowClassification(
    test.cytometry[, 1:10],
    database, templates.optimalFlow.hdbscan, consensus.method = "hierarchical", cl.paral = 1
    )
```

```
## [1] "tclust looking for k = 2"
## [1] "tclust found k = 1"
## [1] "1.25091695785522 secs"
##
## [1] "tclust looking for k = 2"
## [1] "tclust found k = 1"
## [1] "0.748151063919067 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "1.15526223182678 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.57896614074707 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.999785184860229 secs"
##
## [1] "step 1: 4.74512910842896 secs"
```

```
## Weights do not add to 1. A normalization will be applied.
## Weights do not add to 1. A normalization will be applied.
```

```
## [1] "Similarity distances to templates:"
##           [,1]      [,2]      [,3]      [,4]      [,5]
## [1,] 0.5278954 0.5701123 0.2598811 0.3117271 0.3368663
## [1] "step 2: 0.101136684417725 secs"
## [1] "step 3: 0.0336449146270752 secs"
## Time difference of 4.880531 secs
```

```
table(classification.optimalFlow.hdbscan$cluster)
```

```
##
##    1    2    3    4
## 1577 6430  124 7696
```

```
classification.optimalFlow.hdbscan$cluster.vote
```

```
## $`1`
##               cell simple.proportion
## 1 Mature SIg Kappa                 1
##
## $`2`
##        cell simple.proportion
## 1 Monocytes                 1
##
## $`3`
##     cell simple.proportion
## 1 TCRgd-                 1
##
## $`4`
##       cell simple.proportion
## 1 CD4+CD8-                 1
```

```
classification.optimalFlow.hdbscan$assigned.template.index
```

```
## [1] 3
```

```
templates.optimalFlow.hdbscan$clustering
```

```
##  [1] 1 2 3 3 3 3 4 4 4 1 2 3 5 5 5
```

```
scoreF1.optimalFlow.hdbscan <-
  f1ScoreVoting(
    classification.optimalFlow.hdbscan$cluster.vote, classification.optimalFlow.hdbscan$cluster,
   test.cytometry,
    1.01, noise.types
  )
print(scoreF1.optimalFlow.hdbscan$F1_score)
```

```
##           Mature SIg Kappa Monocytes    TCRgd-  CD4+CD8-
## F1-score                 1         1 0.9959514 0.9999350
## Precision                1         1 0.9919355 1.0000000
## Recall                   1         1 1.0000000 0.9998701
```

Another way of doing classification is to relabel the initial clustering that we obtain using the most similar template obtained by optimalFlowTemplates. This is called label-transfer and is further explained in del Barrio et al. ([2019](#ref-optimalFlow)).

```
classification.optimalFlow.2 <-
  optimalFlowClassification(
    test.cytometry[, 1:10],
    database, templates.optimalFlow, consensus.method = "pooling", classif.method = "matching",
    cost.function = "ellipses", cl.paral = 1
    )
```

```
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.301858425140381 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.461310148239136 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.462541580200195 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.318001985549927 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.303356647491455 secs"
##
## [1] "step 1: 1.85338354110718 secs"
## [1] "Similarity distances to templates:"
##           [,1]      [,2]      [,3]      [,4]      [,5]
## [1,] 0.1480501 0.2994856 0.2598811 0.3117271 0.3368663
## [1] "step 2: 0.138597965240479 secs"
## [1] "0.024369478225708 secs"
## [1] "step 3: 0.063474178314209 secs"
## Time difference of 2.05591 secs
```

```
table(classification.optimalFlow.2$cluster)
```

```
##
##    1    2    3    4
## 7697 1577 6430  123
```

```
table(classification.optimalFlow.2$clusterings[[1]]$cluster)
```

```
##
##    1    2    3    4
## 7697 1577 6430  123
```

```
classification.optimalFlow.2$cluster.vote
```

```
## $`1`
##       cell compound.proportion simple.proportion
## 1 CD4+CD8-                   1                 1
##
## $`2`
##               cell compound.proportion simple.proportion
## 1 Mature SIg Kappa                   1                 1
##
## $`3`
##        cell compound.proportion simple.proportion
## 1 Monocytes                   1                 1
##
## $`4`
##     cell compound.proportion simple.proportion
## 1 TCRgd-                   1                 1
```

```
classification.optimalFlow.2$assigned.template.index
```

```
## [1] 1
```

```
templates.optimalFlow$clustering
```

```
##  [1] 1 2 3 3 3 3 4 4 4 1 2 3 5 5 5
```

```
scoreF1.optimalFlow.2 <-
  f1ScoreVoting(
    classification.optimalFlow.2$cluster.vote, classification.optimalFlow.2$cluster,
    test.cytometry,
    1.01, noise.types
    )
print(scoreF1.optimalFlow.2$F1_score)
```

```
##           CD4+CD8- Mature SIg Kappa Monocytes TCRgd-
## F1-score         1                1         1      1
## Precision        1                1         1      1
## Recall           1                1         1      1
```

Also, classical techniques as random forest are available.

```
classification.optimalFlow.3 <-
  optimalFlowClassification(
    test.cytometry[, 1:10],
    database, templates.optimalFlow, consensus.method = "pooling",
    classif.method = "random forest", cl.paral = 1
    )
```

```
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.339166879653931 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.47374153137207 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.443386793136597 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.338804244995117 secs"
##
## [1] "tclust looking for k = 4"
## [1] "tclust found k = 3"
## [1] "0.313246011734009 secs"
##
## [1] "step 1: 1.91469359397888 secs"
## [1] "Similarity distances to templates:"
##           [,1]      [,2]      [,3]      [,4]      [,5]
## [1,] 0.1480501 0.2994856 0.2598811 0.3117271 0.3368663
## [1] "step 2: 0.120708227157593 secs"
## [1] "step 3: 15.5304040908813 secs"
## Time difference of 17.56634 secs
```

```
table(classification.optimalFlow.3$cluster)
```

```
##
##         CD4+CD8- Mature SIg Kappa        Monocytes           TCRgd-
##             7697             1577             6430              123
```

```
classification.optimalFlow.3$assigned.template.index # the cytometry used for learning belongs to the cluster labelled as 1 and is the first of the cytometries in that cluster, hence it is the first cytometry in the database.
```

```
## [1] 1 1
```

```
templates.optimalFlow$clustering
```

```
##  [1] 1 2 3 3 3 3 4 4 4 1 2 3 5 5 5
```

```
scoreF1.optimalFlow.3 <-
  optimalFlow::f1Score(classification.optimalFlow.3$cluster,
    test.cytometry,
    noise.types
    )
print(scoreF1.optimalFlow.3)
```

```
##           CD4+CD8- Mature SIg Kappa Monocytes TCRgd-
## F1-score         1                1         1      1
## Precision        1                1         1      1
## Recall           1                1         1      1
```

# References

del Barrio, Eustasio, Hristo Inouzhe, Jean-Michel Loubes, Agustin Mayo-Iscar, and Carlos Matran. 2019. “optimalFlow: Optimal-Transport Approach to Flow Cytometry Analysis,” July. <https://arxiv.org/abs/1907.08006>.

Garcia-Escudero, Luis-Angel, Alfonso Gordaliza, Carlos Matran, and Agustin Mayo-Iscar. 2008. “A General Trimming Approach to Robust Cluster Analysis.” *The Annals of Statistics* 36: 1324–45.