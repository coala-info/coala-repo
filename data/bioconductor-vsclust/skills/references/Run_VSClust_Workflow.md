# VSClust workflow

Veit Schwämmle

#### 30 October 2025

#### Abstract

Here, we describe the workflow to run variance-sensitive clustering on data from a quantitative omics experiments. In principle, this can be any multi-dimensional data set containing quantitative and optionally replicated values. This vignette is distributed under a CC BY-SA license.

#### Package

vsclust 1.12.0

# 1 Introduction

Clustering is a method to identify common pattern in highly dimensional data.
This can be for example genes or proteins with similar quantitative changes,
thus providing insights into the affected biological pathways.

Despite of numerous clustering algorithms, they do not account for feature
variance, i.e. the uncertainty in the measurements across the different
experimental conditions.
VSClust determines the characteristic patterns in high-dimensional data
while accounting for feature variance that is given through replicated
measurements.

Here, we present an example script to run the full clustering analysis using
the `vsclust` library. The same can be done by running the Shiny app (e.g. via
its docker image or on ), or the
corresponding command line script. For the source code, see
.

# 2 Installation and additional packages

Use the common Bioconductor commands for installation:

```
# Uncomment in case you have not installed vsclust yet
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("vsclust")
library(vsclust)
```

The full functionality of this vignette can be obtained by additionally
installing and loading the packages `matrixStats` and `clusterProfiler`

# 3 Initialization

Here, we define the different parameters for the example data set
`protein_expressions`. In the command-line version of VSClust (“runVSClust.R”),
they can be given via yaml file.

**Comments:**

A. Data sets with different numbers of replicates per condition need to be
adapted to contain the same number of columns per condition. These can be done
by either removing excess replicates or adding empty columns.

B. We assume the input data to be of the following format: A1, B1, C1, …, A2,
B2, C2, …, where letters denote sample type and numbers are the different
replicates.

C. If you prefer to estimate feature variance different, use averages and add
an estimate for the standard deviation as last column. You will need to set the
last option of `PreparedForVSClust` to `FALSE`.

D. If you don’t have replicates, use the same format as in C. and set the
standard deviations to 1.

```
library(vsclust)
#### Input parameters, only read when now parameter file was provided
## All principal parameters for running VSClust can be defined as in the
## shinyapp at computproteomics.bmb.sdu.dk/Apps/VSClust
# name of study
Experiment <- "ProtExample"
# Number of replicates/sample per different experimental condition (sample
# type)
NumReps <- 3
# Number of different experimental conditions (e.g. time points or sample
# types)
NumCond <- 4
# Paired or unpaired statistical tests when carrying out LIMMA for
# statistical testing
isPaired <- FALSE
# Number of threads to accelerate the calculation (use 1 in doubt)
cores <- 1

# If 0 (default), then automatically estimate the cluster number for the
# vsclust
# run from the Minimum Centroid Distance
PreSetNumClustVSClust <- 0
# If 0 (default), then automatically estimate the cluster number for the
# original fuzzy c-means from the Minimum Centroid Distance
PreSetNumClustStand <- 0

# max. number of clusters when estimating the number of clusters. Higher
# numbers can drastically extend the computation time.
maxClust <- 10
```

# 4 Statistics and data preprocessing

At first, we load the example proteomics data set and carry out statistical
testing of all conditions version the first based on the LIMMA moderated t-test.
The data consists of mice fed with four different diets (high fat, TTA, fish oil
and TTA\(+\)fish oil).
Understand more about the data set with `?protein_expressions`

This will calculate the false discovery rates for the differentially regulated
features (pairwise comparisons versus the first “high fat” condition) and most
importantly, their expected individual variances, to be used in the
variance-sensitive clustering. These variances can also be uploaded separately
via a last column containing them as individual standard deviations.

The `PrepareForVSClust` function also creates a PCA plot to assess variability
and control whether the samples have been loaded correctly (replicated samples
should form groups).

After estimating the standard deviations, the matrix consists of the averaged
quantitative feature values and a last column for the standard deviations of the
features.

```
data(protein_expressions)
dat <- protein_expressions

#### running statistical analysis and estimation of individual variances
statOut <- PrepareForVSClust(dat, NumReps, NumCond, isPaired, TRUE)
```

![](data:image/png;base64...)

```
dat <- statOut$dat
Sds <- dat[,ncol(dat)]
cat(paste("Features:",nrow(dat),"\nMissing values:",
            sum(is.na(dat)),"\nMedian standard deviations:",
            round(median(Sds,na.rm=TRUE),digits=3)))
```

```
## Features: 574
## Missing values: 0
## Median standard deviations: 0.221
```

```
## Write output into file
write.csv(statOut$statFileOut,
          paste("",Experiment,"statFileOut.csv",sep=""))
```

# 5 Estimation of cluster number

There is no simple way to find the optimal number of clusters in a data set. For
obtaining this number, we run the clustering for different cluster numbers and
evaluate them via so-called validity indices, which provide information about
suitable cluster numbers. VSClust uses mainly the “Maximum centroid distances”
that denotes the shortest distance between any of the centroids. Alternatively,
one can inspect the Xie Beni index.

The output of `estimClustNum` contains the suggestion for the number of clusters.

We further visualize the outcome.

```
#### Estimate number of clusters with maxClust as maximum number clusters
#### to run the estimation with
ClustInd <- estimClustNum(dat, maxClust=maxClust, scaling="standardize", cores=cores)
```

```
## Running cluster number 3
```

```
## Running cluster number 4
```

```
## Running cluster number 5
```

```
## Running cluster number 6
```

```
## Running cluster number 7
```

```
## Running cluster number 8
```

```
## Running cluster number 9
```

```
## Running cluster number 10
```

```
#### Use estimate cluster number or use own
if (PreSetNumClustVSClust == 0)
  PreSetNumClustVSClust <- optimalClustNum(ClustInd)
if (PreSetNumClustStand == 0)
  PreSetNumClustStand <- optimalClustNum(ClustInd, method="FCM")
#### Visualize
  estimClust.plot(ClustInd)
```

![](data:image/png;base64...)

# 6 Run final clustering

Now we run the clustering again with the optimal parameters from the estimation.
One can
take alternative numbers of clusters corresponding to large decays in the
Minimum Centroid Distance or low values of the Xie Beni index.

First, we carry out the variance-sensitive method

```
#### Run clustering (VSClust and standard fcm clustering
ClustOut <- runClustWrapper(dat,
                            PreSetNumClustVSClust,
                            NULL,
                            VSClust=TRUE,
                            scaling="standardize",
                            cores=cores)
Bestcl <- ClustOut$Bestcl
VSClust_cl <- Bestcl
#ClustOut$p
## Write clustering results (VSClust)
write.csv(data.frame(cluster=Bestcl$cluster,
                     ClustOut$outFileClust,
                     isClusterMember=rowMaxs(Bestcl$membership)>0.5,
                     maxMembership=rowMaxs(Bestcl$membership),
                     Bestcl$membership),
          paste(Experiment,
                "FCMVarMResults",
                Sys.Date(),
                ".csv",
                sep=""))
## Write coordinates of cluster centroids
write.csv(Bestcl$centers,
          paste(Experiment,
                "FCMVarMResultsCentroids",
                Sys.Date(),
                ".csv",
                sep=""))
```

![](data:image/png;base64...)

We see that most of the difference are between TTA diets and the rest. This
shows that the TTA fatty acids have strong impact on
the organisms. Cluster three shows the proteins that a commonly lower abundant
in mice fed with fish oil and thus are related to
biological processes affected this particular diet.

For comparison, this is the clustering using standard fuzzy c-means of the means
over the replicates.

```
ClustOut <- runClustWrapper(dat, PreSetNumClustStand, NULL, VSClust=FALSE,
                            scaling="standardize", cores=cores)
Bestcl2 <- ClustOut$Bestcl
## Write clustering results (standard fcm)
write.csv(data.frame(cluster=Bestcl2$cluster,
                     ClustOut$outFileClust,
                     isClusterMember=rowMaxs(Bestcl2$membership)>0.5,
                     maxMembership=rowMaxs(Bestcl2$membership),
                     Bestcl2$membership),
          paste(Experiment,
                "FCMResults",
                Sys.Date(),
                ".csv",
                sep=""))
## Write coordinates of cluster centroids
write.csv(Bestcl2$centers, paste(Experiment,
                                "FCMResultsCentroids",
                                Sys.Date(),
                                ".csv",
                                sep=""))
```

![](data:image/png;base64...)

Here, the clusters look rather similar. VSClust best performs for larger numbers
of different experimental conditions (one finds major improvements for \(D>6\)).
For a 4-dimensional data set, the algorithm mostly filters out features with
very high variance levels, making them unsuitable for belonging to
a particular cluster.

This analysis is then followed by evaluating the features (here proteins) of
each cluster for their biological relevance. This can be done by functional
analysis with e.g. the `clusterProfiler` package.

You can use the `runFuncEnrich` function to visualize the results. It retrieves
the functional enrichment from [STRING](https://string-db.org). The `infosource`
argument can be anny category of of the ones given by the *category IDs*
described in the table of the
[STRING API](https://string-db.org/help/api/#retrieving-enrichment-figure).
The given feature IDs are converted in STRING without specifying the species,
which can lead to inconsistencies when using generic gene names.

The output object is a `compareCluster` object from `clusterProfiler` that
can be further analyzed or visualized as done in this vignette. Note that STRING
does not provide a `geneRatio`. We use the gene `Count` instead.

```
# Functional enrichment
ClustEnriched <- runFuncEnrich(VSClust_cl, infosource = "KEGG")
```

```
## $identifiers
## [1] "P29418%0dQ6PDU7%0dP23693%0dQ3T1K5%0dP68035%0dP15651%0dP00406%0dQ5RKI0%0dP41562%0dP68511%0dP97541%0dQ5I0C3%0dQ68FS4%0dP62853%0dP62198%0dQ5U300%0dQ9JM53%0dO35878%0dQ63704%0dP50753%0dP18266%0dP62076%0dP0CG51%0dQ5XIT9%0dP29117%0dP07871%0dP50399%0dP80432%0dP62268%0dQ8VID1%0dP62898%0dQ5XIG4%0dP24049%0dQ5XHZ0%0dP56741%0dQ9EQX9%0dP62703%0dP23514%0dP62836%0dQ704S8%0dP46462%0dQ9WVK7%0dP11915%0dP11250%0dP11608%0dP83732%0dP16409%0dP17702%0dQ99NA5%0dP06761%0dP13221%0dP04762%0dP13086%0dP18886%0dP81155%0dQ02253%0dQ2TA68%0dQ62651%0dP29314%0dP10860%0dP02401%0dP56571%0dP48721%0dP31399%0dQ9JJW3%0dO35413%0dP62494%0dQ8VHF5%0dP11232%0dP42930%0dP04166%0dB0K020%0dQ7TQ16%0dQ07969%0dP21396%0dQ5XIM5%0dP12075%0dP15800%0dP35171%0dQ4QQV3%0dQ6AXV4%0dQ5XIN6%0dP62260%0dP60868%0dQ9Z1Y3%0dP11884%0dP14604%0dP38983%0dP29419%0dQ811A2%0dO35303%0dQ05962%0dQ5XIF6%0dP42123%0dP04636%0dQ5XIC0%0dQ6UPE1%0dP80254%0dQ6P6R2%0dP63039%0dP63018%0dO88761%0dP41123%0dB4F7A1%0dP32551%0dB2GV54%0dP07872%0dP26772%0dP56574%0dP62963%0dP24268%0dP18163%0dP13697%0dD3ZAF6%0dP36201%0dP11240%0dP10888%0dP12847%0dQ03344%0dQ9Z1N4%0dP04906%0dP08503%0dO55171%0dQ9Z0W7%0dQ3KR86%0dQ2PQA9%0dQ2PS20%0dP23928%0dQ9Z0J5%0dQ64591%0dO35077%0dP62919%0dP41565%0dP67779%0dP13437%0dP05065%0dP15999%0dO70351%0dP10536%0dP04764%0dP97852%0dQ9R063%0dP85834%0dP45592%0dD3Z9R8%0dP49242%0dP61016%0dP62907%0dP19511%0dP12001%0dP57093%0dP10719%0dP34058%0dP04904%0dO89049%0dP35434%0dQ60587%0dQ06647%0dP15650%0dQ68FY0%0dQ6P0K8%0dQ920F5%0dP00507%0dP14668%0dQ9ER34%0dA1A5Q0%0dP20788%0dQ01205%0dP35565%0dQ64428%0dP07483%0dQ5PPN7%0dP14408%0dP11442%0dQ68FR6%0dP11030%0dQ5XIH7%0dP61983%0dP23965%0dP48500%0dQ641Z6%0dP35435%0dP13803%0dP48675%0dQ68FU3%0dQ62920"
##
## $caller_identity
## [1] "VSClust_enrichSTRING_API"
##
## $identifiers
## [1] "P10959%0dP07335%0dQ63799%0dP11517%0dP63245%0dQ6P747%0dP07150%0dQ9Z1P2%0dO88600%0dP62856%0dP12007%0dP08010%0dP61206%0dQ4G069%0dP35704%0dQ6RUV5%0dP04639%0dP62083%0dB0LPN4%0dQ9QWN8%0dP11507%0dP05508%0dP26644%0dQ78P75%0dP97532%0dQ5XIM9%0dP06399%0dP14882%0dP14480%0dP20059%0dP23562%0dP30009%0dP34064%0dQ63065%0dP27139%0dP50878%0dP04276%0dP19804%0dQ99PS8%0dB0BNE5%0dQ62736%0dP48679%0dP62890%0dQ66H98%0dP62271%0dP38718%0dQ4QQT4%0dP31000%0dP01026%0dP02680%0dP09006%0dP02651%0dB0BNN3%0dQ68FT1%0dQ5BJQ0%0dP13635%0dQ9QX79%0dP20759%0dP47853%0dQ07936%0dP01946%0dP23764%0dP61980%0dQ63041%0dQ8K4G6%0dQ63798%0dQ01129%0dP20761%0dP31232%0dP47858%0dP18418%0dP08649%0dP07340%0dQ01177%0dQ68FP1%0dP06866%0dP01836%0dP58775%0dP62250%0dQ9WTT6%0dQ6NYB7%0dQ64560%0dP04937%0dP47875%0dP02466%0dP12346%0dP62243%0dQ9WUS0%0dP51886%0dP40307%0dQ63081%0dP29457%0dO08557%0dO35115%0dP14046%0dQ66HD0%0dQ8VIF7%0dP20280%0dP70623%0dP11762%0dQ63862%0dQ63797%0dQ9EQP5%0dP02650%0dP27321%0dQ9Z1H9%0dP35738%0dP48037%0dP15429%0dP02454%0dQ5XFX0%0dO35264%0dQ5U216%0dP05545%0dP05544%0dP24090%0dP86252%0dP16303%0dP85125%0dP21913%0dP53534%0dQ03626%0dP02767"
##
## $caller_identity
## [1] "VSClust_enrichSTRING_API"
##
## $identifiers
## [1] "P04785%0dQ924S5%0dP63029%0dQ7TPB1%0dQ9JLJ3%0dP27952%0dQ68FX0%0dP62282%0dQ07439%0dP25886%0dQ5XI73"
##
## $caller_identity
## [1] "VSClust_enrichSTRING_API"
```

```
## got data from STRINGdb
```

```
## Reducing number of STRINGdb results
```

```
# Take the reduce version of the enrichment (redFuncs), not the full one
# (fullFuncs)
redClustEnriched <- ClustEnriched$redFuncs

# Load the clusterProfiler package
library(clusterProfiler)

# Plot the top 10 most enriched KEGG pathways
dotplot(redClustEnriched, showCategory=10, title="KEGG enrichment", size = "count")
```

![](data:image/png;base64...)

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
##  [1] clusterProfiler_4.18.0      MultiAssayExperiment_1.36.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] BiocGenerics_0.56.0         generics_0.1.4
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] vsclust_1.12.0              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3      jsonlite_2.0.0          magrittr_2.0.4
##   [4] ggtangle_0.0.7          magick_2.9.0            farver_2.1.2
##   [7] rmarkdown_2.30          fs_1.6.6                vctrs_0.6.5
##  [10] memoise_2.0.1           ggtree_4.0.0            tinytex_0.57
##  [13] htmltools_0.5.8.1       S4Arrays_1.10.0         BiocBaseUtils_1.12.0
##  [16] curl_7.0.0              SparseArray_1.10.0      gridGraphics_0.5-1
##  [19] sass_0.4.10             bslib_0.9.0             htmlwidgets_1.6.4
##  [22] plyr_1.8.9              cachem_1.1.0            igraph_2.2.1
##  [25] mime_0.13               lifecycle_1.0.4         pkgconfig_2.0.3
##  [28] Matrix_1.7-4            R6_2.6.1                fastmap_1.2.0
##  [31] gson_0.1.0              shiny_1.11.1            digest_0.6.37
##  [34] aplot_0.2.9             enrichplot_1.30.0       patchwork_1.3.2
##  [37] AnnotationDbi_1.72.0    RSQLite_2.4.3           labeling_0.4.3
##  [40] httr_1.4.7              abind_1.4-8             compiler_4.5.1
##  [43] bit64_4.6.0-1           fontquiver_0.2.1        withr_3.0.2
##  [46] S7_0.2.0                BiocParallel_1.44.0     DBI_1.2.3
##  [49] R.utils_2.13.0          rappdirs_0.3.3          DelayedArray_0.36.0
##  [52] tools_4.5.1             otel_0.2.0              ape_5.8-1
##  [55] httpuv_1.6.16           R.oo_1.27.1             glue_1.8.0
##  [58] nlme_3.1-168            GOSemSim_2.36.0         promises_1.4.0
##  [61] grid_4.5.1              reshape2_1.4.4          fgsea_1.36.0
##  [64] gtable_0.3.6            R.methodsS3_1.8.2       tidyr_1.3.1
##  [67] data.table_1.17.8       XVector_0.50.0          ggrepel_0.9.6
##  [70] pillar_1.11.1           stringr_1.5.2           yulab.utils_0.2.1
##  [73] limma_3.66.0            later_1.4.4             splines_4.5.1
##  [76] dplyr_1.1.4             treeio_1.34.0           lattice_0.22-7
##  [79] bit_4.6.0               tidyselect_1.2.1        fontLiberation_0.1.0
##  [82] GO.db_3.22.0            Biostrings_2.78.0       knitr_1.50
##  [85] fontBitstreamVera_0.1.1 bookdown_0.45           xfun_0.53
##  [88] statmod_1.5.1           stringi_1.8.7           lazyeval_0.2.2
##  [91] ggfun_0.2.0             yaml_2.3.10             evaluate_1.0.5
##  [94] codetools_0.2-20        gdtools_0.4.4           tibble_3.3.0
##  [97] qvalue_2.42.0           BiocManager_1.30.26     ggplotify_0.1.3
## [100] cli_3.6.5               xtable_1.8-4            systemfonts_1.3.1
## [103] jquerylib_0.1.4         dichromat_2.0-0.1       Rcpp_1.1.0
## [106] png_0.1-8               parallel_4.5.1          ggplot2_4.0.0
## [109] blob_1.2.4              DOSE_4.4.0              tidytree_0.4.6
## [112] ggiraph_0.9.2           scales_1.4.0            purrr_1.1.0
## [115] crayon_1.5.3            rlang_1.1.6             cowplot_1.2.0
## [118] fastmatch_1.1-6         KEGGREST_1.50.0
```