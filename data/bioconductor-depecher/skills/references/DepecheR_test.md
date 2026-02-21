# Example of a cytometry data analysis with DepecheR

Jakob Theorell1,2

1Oxford Autoimmune Neurology Group, Nuffield Department of Clinical Neurosciences, University of Oxford, Oxford, United Kingdom
2Department of Clinical Neurosciences, Karolinska Institutet, Stockholm, Sweden

#### 2025-10-29

# 1 Introduction

In this document, the user is presented with an analysis that DepecheR
has been written to perform. There are lots of tweaks to this general outline,
so the user is encouraged to read the help files for each function individually
in addition. In cases where bugs are identified, feedback is most welcome,
primarily on the github site github.com/theorell/DepecheR. Now let us get
started.

# 2 Installation

This is how to install the package, if that has not already been done:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("DepecheR")
```

# 3 Example data description

The data used in this example is a semi-simulated dataset, consisting of 1000
cytotoxic lymphocytes from each of 20 individuals. These have been categorized
into two groups, and after this, alterations have been added to the sizes of
some cell populations in both groups. This means that the groups can be
separated based onthe sizes of certain cell types in the data. And this
excersize will show how to identify these, and tell us what markers that define
the separating cell types in question.

Importantly, DepecheR does not provide any pre-processing tools, such as for
compensation/spectral unmixing of flow cytometry files. The clustering function
does have an internal algorithm to detect data with extreme tails, but this does
not circumvent the need to transform flow- or mass cytometry data. This can be
done using either commercially available software or with R packages, such as
Biocpkg(“flowSpecs”), Biocpkg(“flowCore”) or Biocpkg(“flowVS”).

```
library(DepecheR)
data('testData')
str(testData)
```

```
## 'data.frame':    20000 obs. of  16 variables:
##  $ ids   : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ SYK   : num  11.2 21.3 23.7 22.1 24.8 ...
##  $ FcER1g: num  15.4 19.8 18.7 17.9 28.2 ...
##  $ CD16  : num  27.4 23.7 17.9 19.2 19.8 ...
##  $ CD57  : num  6.45 5.55 9.65 17.41 86.38 ...
##  $ EAT.2 : num  21.2 18.2 23.6 39.6 25.9 ...
##  $ CD4   : num  80.7 82.6 88.2 89.6 12.7 ...
##  $ TCRgd : num  17.5 21.6 20.2 29 14.3 ...
##  $ CD8   : num  21.2 17.6 16.4 -11.4 78.3 ...
##  $ iCD3  : num  88.9 86.7 82.7 90.6 87.6 ...
##  $ NKG2C : num  21.2 56.3 36.5 62.9 21.5 ...
##  $ CD2   : num  43.2 64.6 73.6 14.7 75.6 ...
##  $ CD45RO: num  34.9 34.1 27.3 59.5 22.5 ...
##  $ CD3   : num  83.3 90.7 91.5 103.4 76.2 ...
##  $ CD56  : num  21.1 39.7 28.3 15.5 69.5 ...
##  $ label : int  0 0 0 0 0 0 0 0 0 0 ...
```

As can be noted here, the expected input format is either a
dataframe or a matrix with cells as rows and markers/variables as columns. This
is in accordance with the .fcs file convention. In this case, however, the
different samples (coming from donors) should be added to the same dataframe,
and a donor column should specify which cells that belong to which donor.
If you have .fcs files, you can do this conversion easily using the
“flowSet2LongDf” function in Biocpkg(“flowSpecs”).

# 4 depeche clustering

With the depeche clustering function, all necessary scaling and parameter
selection is performed under the hood, so all we have to do, when we have the
file of interest in the right format, is to run the function on the variables
that we want to cluster on.

```
testDataDepeche <- depeche(testData[, 2:15])
```

```
## [1] "Files will be saved to ~/Desktop"
## [1] "As the dataset has less than 100 columns, peak centering is applied."
## [1] "Set 1 with 7 iterations completed in 14 seconds."
## [1] "Set 2 with 7 iterations completed in 6 seconds."
## [1] "Set 3 with 7 iterations completed in 6 seconds."
## [1] "The optimization was iterated 21 times."
```

```
str(testDataDepeche)
```

```
## List of 4
##  $ clusterVector     : int [1:20000] 2 2 2 2 6 3 5 2 1 1 ...
##  $ clusterCenters    : num [1:8, 1:14] 0 0 0 40.2 0 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : chr [1:8] "1" "2" "3" "4" ...
##   .. ..$ : chr [1:14] "SYK" "FcER1g" "CD16" "CD57" ...
##  $ essenceElementList:List of 8
##   ..$ 1: chr [1:3] "CD4" "NKG2C" "CD45RO"
##   ..$ 2: chr [1:5] "CD4" "iCD3" "NKG2C" "CD2" ...
##   ..$ 3: chr [1:3] "CD57" "CD8" "CD2"
##   ..$ 4: chr [1:10] "SYK" "FcER1g" "CD16" "CD57" ...
##   ..$ 5: chr [1:3] "CD57" "CD8" "CD45RO"
##   ..$ 6: chr [1:4] "CD57" "CD8" "CD2" "CD56"
##   ..$ 7: chr [1:6] "SYK" "FcER1g" "iCD3" "CD2" ...
##   ..$ 8: chr [1:4] "TCRgd" "CD2" "CD45RO" "CD56"
##  $ penaltyOptList    :List of 2
##   ..$ :'data.frame': 1 obs. of  2 variables:
##   .. ..$ bestPenalty: num 16
##   .. ..$ k          : num 30
##   ..$ :'data.frame': 11 obs. of  2 variables:
##   .. ..$ ARI   : num [1:11] 0.59 0.581 0.683 0.689 0.857 ...
##   .. ..$ nClust: num [1:11] 29.4 28 27.1 24.3 20.4 ...
```

As can be seen above, the output from the function is a relatively complex list.
If the names of each list element is not suficiently self explanatory, see
(?depeche) for information about each slot.

## 4.1 depeche function output graphs

Two graphs are part of the output from the depeche function.

### 4.1.1 Adjusted Rand Index as a function of penalty values

This graph shows
how internally reproducible the results were for each of the tested penalties.
An Adjusted Rand Index of 1 shows that if any random subset of observations is
clustered two times, each observation will be assigned to the same cluster both
times. Conversely, an Adjusted Rand Index of 0 indicates the opposite, i.e.
totally random distribution. The adjustment in “Adjusted” Rand index takes the
divering probabilities of ending up with a high or low overlap in the special
cases of very few and very many clusters into consideration.

![](data:image/png;base64...)

Adjusted Rand Index as a function of penalty values. Each value is based on at least 7 clustering pairs (DepecheR standard in a 8 core machine).

### 4.1.2 Cluster centers

This graph shows in a heatmap format where the cluster center is located for
each of the markers that are defined for the cluster in question. A light color
indicates a high expression, whereas a dark color indicates low or absent
expression. Grey color, on the other hand, indicates that the cluster in
question did not contribute to defining the cluster in question. In some cases,
the results might seem strange, as a cluster might have an expression very close
to the center of the full dataset, but this expression still defined the
cluster. This is due to an internal, and for stability reasons necessary, effect
of the algotihm: a specific penalty will have a larger effect on a cluster with
fewer observations, than on a cluster with many observations.

![](data:image/png;base64...)

Cluster center heatmap. Marker names on the x-axis, cluster numbers on the y-axis.

# 5 tSNE/umap generation

To be able to visualize the results, we need to generate a two-dimensional
representation of the data used to generate the depeche clustering. Any
sutiable method, such as tSNE or UMAP can be used for this purpose. I would
today use uwot::umap, mainly as it in its R implementation is considerably
faster than tSNE, but we will keep the tSNE here, as it well represents the
data.

```
library(Rtsne)
testDataSNE <- Rtsne(testData[,2:15], pca=FALSE)
```

# 6 Visualization of depeche clusters on 2D representation

Now, we want to evaluate how the different clusters are distributed on the 2D
representation.
To do this, we need to generate a color vector from the cluster vector in the
testDataDepeche. This cluster vector is then overlayed over the tSNE,
and to make things easier to interpret, a separate legend is included as well.
The reason that the legend is in a separate plot is for making it easier to use
the plots for publication purposes. For file size reasons, it has namely been
necessary to use PNG and not PDF for the plot files.

NB! The resolution of the files normally generated by DepecheR is considerably
higher than in this vinjette, due to size restrictions.

```
dColorPlot(colorData = testDataDepeche$clusterVector, xYData = testDataSNE$Y,
           colorScale = "dark_rainbow", plotName = "Cluster")
```

```
## png
##   2
```

![](data:image/png;base64...)

Cluster distribution over the tSNE field.

# 7 Visualization of markers on tSNE

Here, we once again use the dColorPlot function, with different settings. Note
that titles are included in this case. As they are then becoming embedded in the
png picture, this is not the standard, for publication reasons. It is also worth
noting, that nothing is printed to screen, but rather all graphics are saved as
separate files. This is done to save some computational time and effort.

```
dColorPlot(colorData = testData[2], xYData = testDataSNE$Y)
```

```
## png
##   2
```

![](data:image/png;base64...)

Example of one marker (SYK) distributed over the tSNE field.

# 8 Density distribution of groups

Now, we are getting into separating the groups from each other. The first thing
we want to do is to visually compare the densities of the groups. This is done
in the following way. First, the density for all events are plotted. This is
followed by plotting of the first and second group of individuals, but keeping
the density contours from the full dataset.

```
densContour <- dContours(testDataSNE$Y)

dDensityPlot(xYData = testDataSNE$Y, plotName = 'All_events',
             colorScale="purple3", densContour = densContour)
```

```
## png
##   2
```

```
#Here the data for the first group is plotted
dDensityPlot(xYData = testDataSNE$Y[testData$label==0,], plotName = 'Group_0',
             colorScale="blue", densContour = densContour)
```

```
## png
##   2
```

```
#And here comes the second group
dDensityPlot(xYData = testDataSNE$Y[testData$label==1,], plotName = 'Group_1',
             colorScale="red", densContour = densContour)
```

```
## png
##   2
```

![](data:image/png;base64...)

Distribution of events in the different groups.

# 9 Separating groups from each other

Now, we have arrived at a crucial point: we are now going to see which
clusters that separate the two groups from each other. There are three functions
in the DepecheR package that can help us do this. The first one is the
dResidualPlot.

```
dResidualPlot(
    xYData = testDataSNE$Y, groupVector = testData$label,
    clusterVector = testDataDepeche$clusterVector)
```

```
## png
##   2
```

This function shows the difference on a
per-group/per-cluster basis. This means that it is non-statistical, and thus
applicable even if the groups consist of only one or a few samples each.
However, it cannot distinguish between a rare but very pronounced phenotype and
a common difference: i.e., an individual donor can be responsible for the full
difference noted. To circumvent this, and to get some statistical inferences,
two other functions are available: the dWilcox and the dSplsda. These functions
have identical input, but where the former performs a Wilcoxon rank-sum test
(also called Mann-whitney U test) on a per-cluster basis and thus results in
multiple comparisons, the latter (based on sparse projection to latent
structures (aka partial least squares) discriminant analysis) instead identifies
the angle through the multi-dimensional datacloud created by the individual
donor frequencies in each cluster that most optimally separates the groups. It
then internally checks how well the groups are separated along this vector, and
plots the clusters that contribute to this separation with colors relative to
how well the groups are separated. As this method is a sparse version of the
method, it, like depeche, only identifies clusters that contribute robustly to
separating the clusters, and has its internal tuning algorithm to define how the
penalty term should be set. For both methods, there are paired alternatives. In
this case, however, the data is not paired, and thus, the normal methods will be
used. The standard use of the methods are:

```
dWilcoxResult <- dWilcox(
    xYData = testDataSNE$Y, idsVector = testData$ids,
    groupVector = testData$label, clusterVector = testDataDepeche$clusterVector)
```

```
sPLSDAObject <- dSplsda(xYData = testDataSNE$Y, idsVector = testData$ids,
                        groupVector = testData$label,
                        clusterVector = testDataDepeche$clusterVector)
## Saving 3 x 3 in image

## [1] "The separation of the datasets was perfect, with no overlap between
## the groups"

## [1] "Files were saved at /Users/jakthe/Labbet/GitHub/DepecheR/vignettes"
```

The object rendered by the dSplsda function is inherited from the
[mixOmics](https://bioconductor.org/packages/release/bioc/html/mixOmics.html)
package. The object rendered by the dWilcox function is a matrix containing
information about the cluster number, the median in each group, the Wilcoxon
statistic, the p-value and a p-value corrected for multiple comparisons.
In addition to the graphs, the dWilcox and the dSplsda functions also output
result files. See ?dSplsda and ?dWilcox for more information.

![](data:image/png;base64...)

Residual, Wilcoxon, sPLS-DA plots.

When investigating the results from the sPLS-DA or the dWilcox analysis, it was
clear that half of the clusters were highly significantly different between the
groups in this case.

# 10 Visualization of defining markers for clusters.

This function is especially useful to view the cluster distributions for
specific clusters of interest, such as the significant clusters from the
previousstep. dViolins serves as a compliment to the cluster center heatmap
(see step 2).
In this function, the sparsityMatrix from the depeche run is used. The function
will in addition to producing all the graphs also produce a hierarchy of folders
where the graphs are placed.
EDIT 2019-09-12: This function currently does not support most CyTOF data, as
the zero-peak is so dominant, which would make the interpretation of the plots
impossible. This will be fixed in the near future, by reducing the negative
population.

```
dViolins(testDataDepeche$clusterVector, inDataFrame = testData,
         plotClusters = 3, plotElements = testDataDepeche$essenceElementList)
```

```
## [[1]]
## png
##   2
```

![](data:image/png;base64...)

Example of the distribution of events in the four markers defining cluster 3.

# 11 Summary

In this document, a typical analysis of a cytometry dataset is shown. There are
however very many other possibilities with this package. One of the major ones
is that it accuratly classifies scRNAseq data, and in that process reduces
the complexity of the data up to 1000-fold, as very few transcripts actually
define each cluster. For further information on how to do this, the reader
is currently encouraged to read the publication connected to this package:
<https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0203247>.

# 12 Session information

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
## [1] DepecheR_1.26.0  knitr_1.50       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        ellipse_0.5.0       xfun_0.53
##  [4] bslib_0.9.0         ggplot2_4.0.0       gmodels_2.19.1
##  [7] caTools_1.18.3      ggrepel_0.9.6       collapse_2.1.4
## [10] lattice_0.22-7      vctrs_0.6.5         tools_4.5.1
## [13] doSNOW_1.0.20       bitops_1.0-9        generics_0.1.4
## [16] parallel_4.5.1      tibble_3.3.0        DEoptimR_1.1-4
## [19] rARPACK_0.11-0      pkgconfig_2.0.3     Matrix_1.7-4
## [22] KernSmooth_2.23-26  RColorBrewer_1.1-3  S7_0.2.0
## [25] mixOmics_6.34.0     lifecycle_1.0.4     compiler_4.5.1
## [28] farver_2.1.2        stringr_1.5.2       FNN_1.1.4.1
## [31] gplots_3.2.0        codetools_0.2-20    snow_0.4-4
## [34] htmltools_0.5.8.1   sass_0.4.10         yaml_2.3.10
## [37] beanplot_1.3.1      gmp_0.7-5           tidyr_1.3.1
## [40] pillar_1.11.1       jquerylib_0.1.4     MASS_7.3-65
## [43] BiocParallel_1.44.0 gdata_3.0.1         cachem_1.1.0
## [46] viridis_0.6.5       iterators_1.0.14    foreach_1.5.2
## [49] robustbase_0.99-6   RSpectra_0.16-2     gtools_3.9.5
## [52] tidyselect_1.2.1    digest_0.6.37       stringi_1.8.7
## [55] purrr_1.1.0         dplyr_1.1.4         reshape2_1.4.4
## [58] bookdown_0.45       fastmap_1.2.0       grid_4.5.1
## [61] cli_3.6.5           magrittr_2.0.4      dichromat_2.0-0.1
## [64] corpcor_1.6.10      scales_1.4.0        rmarkdown_2.30
## [67] matrixStats_1.5.0   igraph_2.2.1        gridExtra_2.3
## [70] moments_0.14.1      evaluate_1.0.5      viridisLite_0.4.2
## [73] rlang_1.1.6         Rcpp_1.1.0          glue_1.8.0
## [76] BiocManager_1.30.26 jsonlite_2.0.0      R6_2.6.1
## [79] ClusterR_1.3.5      plyr_1.8.9
```