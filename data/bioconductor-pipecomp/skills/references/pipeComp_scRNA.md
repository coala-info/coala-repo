# The scRNA PipelineDefinition

Pierre-Luc Germain1,2, Anthony Sonrel1 and Mark D. Robinson1

1DMLS, University of Zürich
2D-HEST Institute for Neuroscience, ETH Zürich

#### 30 October 2025

#### Abstract

A description of the PipelineDefinition for scRNAseq clustering and its evaluation metrics.

#### Package

pipeComp 1.20.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 The PipelineDefinition](#the-pipelinedefinition)
  + [1.2 Example run](#example-run)
* [2 Exploring the metrics](#exploring-the-metrics)
  + [2.1 Doublet detection and cell filtering](#doublet-detection-and-cell-filtering)
  + [2.2 Evaluation based on the reduced space](#evaluation-based-on-the-reduced-space)
    - [2.2.1 Subpopulation silhouette](#subpopulation-silhouette)
    - [2.2.2 Variance in the PCs explained by the subpopulations](#variance-in-the-pcs-explained-by-the-subpopulations)
    - [2.2.3 Correlation with covariates](#correlation-with-covariates)
  + [2.3 Clustering](#clustering)
    - [2.3.1 Metrics](#metrics)
    - [2.3.2 Plotting](#plotting)
  + [2.4 Computing time](#computing-time)
* [3 Extension and reuse](#extension-and-reuse)
* [4 Datasets](#datasets)
  + [4.1 scRNAseq benchmark datasets used in the paper](#scrnaseq-benchmark-datasets-used-in-the-paper)
  + [4.2 Using new datasets](#using-new-datasets)

# 1 Introduction

This vignette is centered around the application of *pipeComp* to scRNA-seq clustering pipelines, and assumes a general understanding of *pipeComp* (for an overview, see the [pipeComp vignette](pipeComp.html)).

The scRNAseq `PipelineDefinition` comes in two variants determined by the object used as a backbone, either *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* (SCE) or *[seurat](https://github.com/satijalab.org/seurat)* (see `?scrna_pipeline`). Both use the same evaluation metrics, and most method wrappers included in the package have been made so that they are compatible with both. For simplicity, we will therefore stick to just one variant here, and will focus on few very basic comparisons to illustrate the main functionalities, metrics and evaluation plots. For more detailed benchmarks, refer to our preprint:

*pipeComp, a general framework for the evaluation of computational pipelines, reveals performant single-cell RNA-seq preprocessing tools*

## 1.1 The PipelineDefinition

The `PipelineDefinition` can be obtained with the following function:

```
library(pipeComp)
# we use the variant of the pipeline used in the paper
pipDef <- scrna_pipeline(pipeClass = "seurat")
pipDef
```

```
## A PipelineDefinition object with the following steps:
##   - doublet(x, doubletmethod) *
## Takes a SCE object with the `phenoid` colData column, passes it through the
## function `doubletmethod`, and outputs a filtered SCE.
##   - filtering(x, filt) *
## Takes a SCE object, passes it through the function `filt`, and outputs a
## filtered Seurat object.
##   - normalization(x, norm) *
## Passes the object through function `norm` and returns it with the normalized and scale data slots filled.
##   - selection(x, sel, selnb=2000)
## Returns a Seurat object with the VariableFeatures filled with `selnb` features
##  using the function `sel`.
##   - dimreduction(x, dr, maxdim=50) *
## Returns a Seurat object with the PCA reduction with up to `maxdim` components
## using the `dr` function.
##   - clustering(x, clustmethod, dims=20, k=20, steps=8, resolution=c(0.01, 0.1, 0.5, 0.8, 1), min.size=50) *
## Uses function `clustmethod` to return a named vector of cell clusters.
```

## 1.2 Example run

To illustrate the use of the pipeline, we will run a basic comparison using wrappers that are included in the package. However, in order for *pipeComp* not to systematically require the installation of all dependencies related to all methods for which there are wrappers, they were not included in the package code but rather as source files, which can be loaded in the following way:

```
source(system.file("extdata", "scrna_alternatives.R", package="pipeComp"))
```

(To know which packages are required by the set of wrappers you intend to use, see `?checkPipelinePackages`)

Any function that has been loaded in the environment can then be used as alternative. We define a small set of alternatives to test:

```
alternatives <- list(
  doubletmethod=c("none"),
  filt=c("filt.lenient", "filt.stringent"),
  norm=c("norm.seurat", "norm.sctransform", "norm.scran"),
  sel=c("sel.vst"),
  selnb=2000,
  dr=c("seurat.pca"),
  clustmethod=c("clust.seurat"),
  dims=c(10, 15, 20, 30),
  resolution=c(0.01, 0.1, 0.2, 0.3, 0.5, 0.8, 1, 1.2, 2)
)
```

We also assume three datasets in (SCE) format (not included in the package - see the last section of this vignette) and run the pipeline:

```
# available on https://doi.org/10.6084/m9.figshare.11787210.v1
datasets <- c( mixology10x5cl="/path/to/mixology10x5cl.SCE.rds",
               simMix2="/path/to/simMix2.SCE.rds",
               Zhengmix8eq="/path/to/Zhengmix8eq.SCE.rds" )
# not run
res <- runPipeline( datasets, alternatives, pipDef, nthreads=3)
```

Instead of running the analyses here, we will load the final example results:

```
data("exampleResults", package = "pipeComp")
res <- exampleResults
```

# 2 Exploring the metrics

Benchmark metrics are organized according to the step at which they are computed, and will be presented here in this fashion. This does not mean that they are relevant only for that step: alternative parameters at a given step can also be evaluated with respect to the metrics defined in all downstream steps.

## 2.1 Doublet detection and cell filtering

The evaluation performed after the first two steps (doublet detection and filtering) is the same:

```
head(res$evaluation$filtering)
```

```
##          dataset doubletmethod           filt subpopulation N.before N.lost
## 1 mixology10x5cl          none   filt.lenient          A549     1244      0
## 2 mixology10x5cl          none   filt.lenient         H1975      515      1
## 3 mixology10x5cl          none   filt.lenient         H2228      751      0
## 4 mixology10x5cl          none   filt.lenient          H838      840      0
## 5 mixology10x5cl          none   filt.lenient        HCC827      568      0
## 6 mixology10x5cl          none filt.stringent          A549     1244     40
##   pc.lost
## 1   0.000
## 2   0.194
## 3   0.000
## 4   0.000
## 5   0.000
## 6   3.215
```

For each method and subpopulation, we report:

* `N.before` the number of cells before the step
* `N.lost` the number of cells excluded by the step
* `pc.lost` the percentage of cells lost (relative to the supopulation)

As noted in [our manuscript](https://doi.org/10.1101/2020.02.02.930578), stringent filtering can lead to strong bias against certain supopulations. We therefore especially monitor the max `pc.lost` of different methods in relation to the impact on clustering accuracy (privileging, at this step, metrics that are not dependent on the relative abundances of the subpopulations, such as the mean F1 score per subpopulation). This can conveniently be done using the following function:

```
scrna_evalPlot_filtering(res)
```

![](data:image/png;base64...)

## 2.2 Evaluation based on the reduced space

Evaluations based on the reduced space are much more varied:

```
names(res$evaluation$dimreduction)
```

```
## [1] "silhouette"             "varExpl.subpops"        "corr.covariate"
## [4] "meanAbsCorr.covariate2" "PC1.covar.adjR2"
```

### 2.2.1 Subpopulation silhouette

The `silhouette` slot contains information about the silhouettes width of true subpopulations. Depending on the methods used for dimensionality (i.e. fixed vs estimated number of dimensions), there will be a single output or outputs for different sets of dimensions, as it is the case in our example:

```
names(res$evaluation$dimreduction$silhouette)
```

```
## [1] "top_10_dims" "top_20_dims" "all_50_dims"
```

For each of them we have a data.frame including, for each subpopulation in each analysis (i.e. combination of parameters), the minimum, maximum, median and mean silhouette width:

```
head(res$evaluation$dimreduction$silhouette$top_10_dims)
```

```
##          dataset doubletmethod         filt             norm     sel selnb
## 1 mixology10x5cl          none filt.lenient      norm.seurat sel.vst  2000
## 2 mixology10x5cl          none filt.lenient      norm.seurat sel.vst  2000
## 3 mixology10x5cl          none filt.lenient      norm.seurat sel.vst  2000
## 4 mixology10x5cl          none filt.lenient      norm.seurat sel.vst  2000
## 5 mixology10x5cl          none filt.lenient      norm.seurat sel.vst  2000
## 6 mixology10x5cl          none filt.lenient norm.sctransform sel.vst  2000
##           dr maxdim subpopulation minSilWidth meanSilWidth medianSilWidth
## 1 seurat.pca     50          A549   0.3723309    0.6396069      0.6516611
## 2 seurat.pca     50         H1975  -0.6114923    0.1949538      0.2873076
## 3 seurat.pca     50         H2228  -0.1413490    0.4832060      0.4954937
## 4 seurat.pca     50          H838   0.3459593    0.5961926      0.6059980
## 5 seurat.pca     50        HCC827   0.2384042    0.5800197      0.5967093
## 6 seurat.pca     50          A549   0.1339476    0.6333684      0.6518073
##   maxSilWidth
## 1   0.7367229
## 2   0.4217019
## 3   0.6130284
## 4   0.7056178
## 5   0.6876504
## 6   0.7326905
```

This information can be plotted using the function `scrna_evalPlot_silh`; the function outputs a *[ComplexHeatmap](https://CRAN.R-project.org/package%3DComplexHeatmap)*, which means that many arguments of that package and options can be used, for instance:

```
library(ComplexHeatmap)
```

```
## Loading required package: grid
```

```
## ========================================
## ComplexHeatmap version 2.26.0
## Bioconductor page: http://bioconductor.org/packages/ComplexHeatmap/
## Github page: https://github.com/jokergoo/ComplexHeatmap
## Documentation: http://jokergoo.github.io/ComplexHeatmap-reference
##
## If you use it in published research, please cite either one:
## - Gu, Z. Complex Heatmap Visualization. iMeta 2022.
## - Gu, Z. Complex heatmaps reveal patterns and correlations in multidimensional
##     genomic data. Bioinformatics 2016.
##
##
## The new InteractiveComplexHeatmap package can directly export static
## complex heatmaps into an interactive Shiny app with zero effort. Have a try!
##
## This message can be suppressed by:
##   suppressPackageStartupMessages(library(ComplexHeatmap))
## ========================================
```

```
scrna_evalPlot_silh( res )
```

![](data:image/png;base64...)

```
h <- scrna_evalPlot_silh( res, heatmap_legend_param=list(direction="horizontal") )
draw(h, heatmap_legend_side="bottom", annotation_legend_side = "bottom", merge_legend=TRUE)
```

![](data:image/png;base64...)

See `?scrna_evalPlot_silh` for more options.

### 2.2.2 Variance in the PCs explained by the subpopulations

The slot `varExpl.subpops` indicates, for each analysis, the proportion of variance of each principal component explained by the true supopulations.

```
res$evaluation$dimreduction$varExpl.subpops[1:5,1:15]
```

```
##          dataset doubletmethod           filt             norm     sel selnb
## 1 mixology10x5cl          none   filt.lenient      norm.seurat sel.vst  2000
## 2 mixology10x5cl          none   filt.lenient norm.sctransform sel.vst  2000
## 3 mixology10x5cl          none   filt.lenient       norm.scran sel.vst  2000
## 4 mixology10x5cl          none filt.stringent      norm.seurat sel.vst  2000
## 5 mixology10x5cl          none filt.stringent norm.sctransform sel.vst  2000
##           dr maxdim      PC_1       PC_10       PC_11        PC_12        PC_13
## 1 seurat.pca     50 0.9631018 0.007716938 0.001831543 0.0015462150 0.0022304080
## 2 seurat.pca     50 0.9511425 0.007395324 0.002717310 0.0006250593 0.0118729485
## 3 seurat.pca     50 0.2369999 0.005925415 0.009554253 0.0055803311 0.0002206834
## 4 seurat.pca     50 0.9643754 0.007433402 0.002014857 0.0017917112 0.0026884483
## 5 seurat.pca     50 0.9586863 0.008118786 0.003153175 0.0005636794 0.0124421034
##          PC_14       PC_15
## 1 0.0007939924 0.002998006
## 2 0.0044840040 0.004285101
## 3 0.0006480071 0.000983346
## 4 0.0008178260 0.003457408
## 5 0.0033090652 0.003800675
```

### 2.2.3 Correlation with covariates

The following slots in `res$evaluation$dimreduction` track the correlation between principal components (PCs) and predefined cell-level covariates such as library size and number of detected genes:
\* `corr.covariate` contains the pearson correlation between the covariates and each PC; however, since there are major differences in library sizes between subpopulations, we advise against using this directly.
\* `meanAbsCorr.covariate2` circumvents this bias by computing the mean absolute correlation (among the first 5 components) for each subpopulation, and averaging them.
\* `PC1.covar.adjR2` gives the difference in adjusted *R^2* between a model fit on PC1 containing the covariate along with subpopulations (PC1~subpopulation+covariate) and one without the covariate (PC1~subpopulation).

These metrics, as well as the following ones, can be plotted using generic `pipeComp` plotting functions, for example:

```
evalHeatmap(res, step="dimreduction", what="log10_total_features",
            what2="meanAbsCorr.covariate2")
```

![](data:image/png;base64...)

Since the output of these plotting functions are of class *[ComplexHeatmap](https://CRAN.R-project.org/package%3DComplexHeatmap)*, they can be combined:

```
evalHeatmap(res, step="dimreduction", what="log10_total_features",
            what2="meanAbsCorr.covariate2") +
  evalHeatmap(res, step="dimreduction", what="log10_total_counts",
            what2="meanAbsCorr.covariate2")
```

Alternatively, when the other arguments are shared, the following construction can
also be used:

```
evalHeatmap( res, step="dimreduction", what2="meanAbsCorr.covariate2",
             what=c("log10_total_features","log10_total_counts"),
             row_title="mean(abs(correlation))\nwith covariate" )
```

![](data:image/png;base64...)

We see here for instance that *[sctransform](https://github.com/ChristophH/sctransform)* successfully reduces the correlation with covariates, and that *[scran](https://bioconductor.org/packages/3.22/scran)* is somewhat in the middle.

## 2.3 Clustering

### 2.3.1 Metrics

We compute several metrics comparing the clustering to the true cell labels:

```
colnames(res$evaluation$clustering)
```

```
##  [1] "doubletmethod" "filt"          "norm"          "sel"
##  [5] "selnb"         "dr"            "maxdim"        "clustmethod"
##  [9] "dims"          "k"             "steps"         "resolution"
## [13] "min.size"      "dataset"       "n_clus"        "mean_pr"
## [17] "mean_re"       "mean_F1"       "RI"            "ARI"
## [21] "MI"            "AMI"           "VI"            "NVI"
## [25] "ID"            "NID"           "NMI"           "min_pr"
## [29] "min_re"        "min_F1"        "true.nbClusts"
```

The first columns represent the parameters, while the others are evaluation metrics:

* `n_clus`: the number of clusters produced by the method
* `mean_pr`, `mean_re`, and `mean_F1`: respectively the mean precision, recall and F1 score (harmonic mean of precision and recall) per (true) subpopulation, using the Hungarian algorithm for label matching (see `?match_evaluate_multiple`).
* `min_pr`, `min_re` and `min_F1`: the minimum precision/recall/F1 per (true) subpopulation
* `RI` and `ARI`: the Rand index and adjusted Rand index.
* `MI` and `AMI`: the mutual information and adjusted mutual information, respectively.
* `ID`, `NID`, `VI`, `NVI`: the information difference, variation of information, and their normalized counterparts; these decrease with increasing clustering accuracy. See the *[aricode](https://CRAN.R-project.org/package%3Daricode)* package for more information.

There is a high redundancy between some of these metrics, and their relationship across a vast number of scRNAseq clusterings is represented here (see [our preprint](https://doi.org/10.1101/2020.02.02.930578) for more detail):

```
data("clustMetricsCorr", package="pipeComp")
ComplexHeatmap::Heatmap(clustMetricsCorr$pearson, name = "Pearson\ncorr")
```

![](data:image/png;base64...)

We also included, here, the deviation (`nbClust.diff`) and absolute deviation (`nbClust.absDiff`) from the true number of clusters. This shows that, for instance, most metrics (including the commonly-used ARI) are highly correlated (or anti-correlated) with the absolute deviation from the true number of clusters (`nbClust.absDiff`), making the number of clusters called the primary determinant of the score. Instead, mutual information (MI) is considerably less sensitive to this, but does tend to increase when the number of clusters is increased (positive correlation with `nbClust.diff`). We therefore recommend using a combination of MI, ARI, and ARI at the right number of clusters.

### 2.3.2 Plotting

Plotting all combinations is undesirable with the parameters such as resolution, which can take very many values. We therefore need to aggregate by parameters of interest:

```
evalHeatmap(res, step="clustering", what=c("MI","ARI"), agg.by=c("filt","norm"))
```

![](data:image/png;base64...)

Steps for which there was a single alternative (after aggregation) are not included in the labels.
We could investigate the joint impact of the normalization method and of the number of dimensions included using:

```
evalHeatmap(res, step = "clustering", what=c("MI","ARI"),
            agg.by=c("norm", "dims"), row_split=norm)
```

![](data:image/png;base64...)

Here, we’ve used the `row_split` argument to improve the clarity of the figure. The argument can accept either the name of a parameter, or any expression using them (e.g. `row_split=norm!="norm.scran"`).

We can also filter the analyses before aggregation. For instance, if we wish to plot the ARI only at the true number of clusters, we can filter to those analyses where the detected number of clusters (`n_clus`) is equal to the true one (`true.nbClusts`):

```
evalHeatmap(res, step = "clustering", what=c("MI","ARI"), agg.by=c("filt","norm")) +
  evalHeatmap(res, step = "clustering", what="ARI", agg.by=c("filt", "norm"),
              filter=n_clus==true.nbClusts, title="ARI at\ntrue k")
```

```
## Warning: Heatmap/annotation names are duplicated: ARI
```

![](data:image/png;base64...)

Finally, a pipeline-specific plotting function enables overview heatmaps across steps:

```
h <- scrna_evalPlot_overall(res)
draw(h, heatmap_legend_side="bottom")
```

![](data:image/png;base64...)

## 2.4 Computing time

There is nothing specific to the scRNAseq pipeline about computing times, but the default `pipeComp` functionalities are available: the timings are accessible in `res$elapsed`, and can be plotted either manually or using:

```
plotElapsed(res, agg.by="norm")
```

![](data:image/png;base64...)

# 3 Extension and reuse

The scRNAseq `PipelineDefinition` can be modified or extented with new steps or arguments like any other objects of that class (see the [pipeComp vignette](pipeComp.html)). For instance, in the paper we included tests on an additional step that filtered out classes of genes, which we implemented in the following way:

```
pipDef <- addPipelineStep(pipDef, "featureExcl", after="filtering")
# once the step has been added, we can set its function:
stepFn(pipDef, "featureExcl", type="function") <- function(x, classes){
  if(classes!="all"){
    classes <- strsplit(classes, ",")[[1]]
    x <- x[subsetFeatureByType(row.names(x), classes=classes),]
  }
  x
}
pipDef
```

```
## A PipelineDefinition object with the following steps:
##   - doublet(x, doubletmethod) *
## Takes a SCE object with the `phenoid` colData column, passes it through the
## function `doubletmethod`, and outputs a filtered SCE.
##   - filtering(x, filt) *
## Takes a SCE object, passes it through the function `filt`, and outputs a
## filtered Seurat object.
##   - featureExcl(x, classes)
##   - normalization(x, norm) *
## Passes the object through function `norm` and returns it with the normalized and scale data slots filled.
##   - selection(x, sel, selnb=2000)
## Returns a Seurat object with the VariableFeatures filled with `selnb` features
##  using the function `sel`.
##   - dimreduction(x, dr, maxdim=50) *
## Returns a Seurat object with the PCA reduction with up to `maxdim` components
## using the `dr` function.
##   - clustering(x, clustmethod, dims=20, k=20, steps=8, resolution=c(0.01, 0.1, 0.5, 0.8, 1), min.size=50) *
## Uses function `clustmethod` to return a named vector of cell clusters.
```

Then we can simply add alternatives for this new parameter:

```
alternatives$classes <- c("all","Mt","ribo")
# runPipeline...
```

In addition, the evaluation functions used at each step can be accessed from the package’s namespace and use for other purposes. See in particular `?evaluateDimRed` and `?evaluateClustering`. If you feel like other metrics should be included, please contact us!

# 4 Datasets

## 4.1 scRNAseq benchmark datasets used in the paper

The scRNAseq datasets used in the paper can be downloaded from [figshare](https://doi.org/10.6084/m9.figshare.11787210.v1), for instance in the following way:

```
download.file("https://ndownloader.figshare.com/articles/11787210/versions/1", "datasets.zip")
unzip("datasets.zip", exdir="datasets")
datasets <- list.files("datasets", pattern="SCE\\.rds", full.names=TRUE)
names(datasets) <- sapply(strsplit(basename(datasets),"\\."),FUN=function(x) x[1])
```

## 4.2 Using new datasets

In order to use new datasets with this pipeline, you need to have them in *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* format, with the true subpopulations stored in the `phenoid` column of `colData`. In addition, if you wish to use some of the wrappers included in the package, some cell- and gene-statistics should be generated using the following function:

```
source(system.file("extdata", "scrna_alternatives.R", package="pipeComp"))
sce <- add_meta(sce)
# requires the variancePartition packages installed:
sce <- compute_all_gene_info(sce)
```