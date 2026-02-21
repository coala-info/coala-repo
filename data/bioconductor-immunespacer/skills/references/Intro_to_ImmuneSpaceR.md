# An Introduction to the ImmuneSpaceR Package

#### Renan Sauteraud

#### 2019-03-27

* [1 Configuration](#configuration)
* [2 Instantiate a connection](#instantiate-a-connection)
* [3 Fetching datasets](#fetching-datasets)
* [4 Fetching expression matrices](#fetching-expression-matrices)
* [5 Plotting](#plotting)
* [6 Cross study connections](#cross-study-connections)
* [7 Session info](#session-info)

This package provides a *thin* wrapper around [`Rlabkey`](https://cran.r-project.org/web/packages/Rlabkey/index.html) and connects to the [ImmuneSpace](https://www.immunespace.org) database, making it easier to fetch datasets, including gene expression data, HAI, and so forth, from specific studies.

# 1 Configuration

In order to connect to ImmuneSpace, you will need a `.netrc` file in your home directory that will contain a `machine` name (hostname of ImmuneSpace), and `login` and `password`. See [here](https://www.labkey.org/wiki/home/Documentation/page.view?name=netrc) for more information.

A netrc file may look like this:

```
machine www.immunespace.org
login myuser@domain.com
password supersecretpassword
```

**Set up your netrc file now!**

Put it in your home directory. If you type:

```
ls ~/.netrc
```

at the command prompt, you should see it there. If it’s not there, create one now. Make sure you have a valid login and password. If you don’t have one, go to [ImmuneSpace](http://www.immunespace.org) now and set yourself up with an account.

# 2 Instantiate a connection

We’ll be looking at study `SDY269`. If you want to use a different study, change that string. The connections have state, so you can instantiate multiple connections to different studies simultaneously.

```
library(ImmuneSpaceR)
sdy269 <- CreateConnection(study = "SDY269")
sdy269
```

```
## <ImmuneSpaceConnection>
##   Study: SDY269
##   URL: https://www.immunespace.org/Studies/SDY269
##   User: unknown_user at not_a_domain.com
##   9 Available Datasets
##     - gene_expression_files
##     - fcs_sample_files
##     - demographics
##     - elispot
##     - hai
##     - elisa
##     - pcr
##     - cohort_membership
##     - fcs_analyzed_result
##   2 Available Expression Matrices
```

The call to `CreateConnection` instantiates the connection. Printing the object shows where it’s connected, to what study, and the available data sets and gene expression matrices.

Note that when a script is running on ImmuneSpace, some variables set in the global environments will automatically indicate which study should be used and the `study` argument can be skipped.

# 3 Fetching datasets

We can grab any of the datasets listed in the connection.

```
sdy269$getDataset("hai")
```

```
##      participant_id age_reported gender  race          cohort
##   1:  SUB112829.269           26   Male White LAIV group 2008
##   2:  SUB112829.269           26   Male White LAIV group 2008
##   3:  SUB112867.269           37   Male White LAIV group 2008
##   4:  SUB112850.269           41   Male White LAIV group 2008
##   5:  SUB112862.269           21 Female Asian LAIV group 2008
##  ---
## 332:  SUB112863.269           29 Female White  TIV Group 2008
## 333:  SUB112872.269           39 Female White  TIV Group 2008
## 334:  SUB112874.269           23 Female White  TIV Group 2008
## 335:  SUB112875.269           25 Female White  TIV Group 2008
## 336:  SUB112884.269           27   Male White  TIV Group 2008
##      study_time_collected study_time_collected_unit              virus
##   1:                   28                      Days   B/Florida/4/2006
##   2:                   28                      Days A/Uruguay/716/2007
##   3:                   28                      Days   B/Florida/4/2006
##   4:                   28                      Days A/Uruguay/716/2007
##   5:                   28                      Days A/Uruguay/716/2007
##  ---
## 332:                    0                      Days A/Brisbane/59/2007
## 333:                    0                      Days A/Uruguay/716/2007
## 334:                    0                      Days A/Uruguay/716/2007
## 335:                    0                      Days A/Uruguay/716/2007
## 336:                    0                      Days B/Brisbane/03/2007
##      value_preferred
##   1:              40
##   2:              40
##   3:               5
##   4:              10
##   5:              20
##  ---
## 332:              40
## 333:              20
## 334:               5
## 335:               5
## 336:              20
```

The *sdy269* object is an **R6** class, so it behaves like a true object. Methods (like `getDataset`) are members of the object, thus the `$` semantics to access member functions.

The first time you retrieve a dataset, it will contact the database. The data is cached in the object, so the next time you call `getDataset` on the same dataset, it will retrieve the cached local copy. This is much faster.

To get only a subset of the data and speed up the download, filters can be passed to `getDataset`. The filters are created using the `makeFilter` function of the `Rlabkey` package.

```
library(Rlabkey)
myFilter <- makeFilter(c("gender", "EQUAL", "Female"))
hai <- sdy269$getDataset("hai", colFilter = myFilter)
```

See `?Rlabkey::makeFilter` for more information on the syntax.

For more information about `getDataset`’s options, refer to the dedicated vignette.

# 4 Fetching expression matrices

We can also grab a gene expression matrix

```
sdy269$getGEMatrix("SDY269_PBMC_LAIV_Geo")
```

```
## Downloading matrix..
```

```
## Constructing ExpressionSet
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 16442 features, 83 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: BS586100 BS586156 ... BS586239 (83 total)
##   varLabels: participant_id study_time_collected ...
##     exposure_process_preferred (8 total)
##   varMetadata: labelDescription
## featureData
##   featureNames: DDR1 RFC2 ... NUS1P3 (16442 total)
##   fvarLabels: FeatureId gene_symbol
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
```

The object contacts the database and downloads the matrix file. This is stored and cached locally as a `data.table`. The next time you access it, it will be much faster since it won’t need to contact the database again.

It is also possible to call this function using multiple matrix names. In this case, all the matrices are downloaded and combined into a single `ExpressionSet`.

```
sdy269$getGEMatrix(c("SDY269_PBMC_TIV_Geo", "SDY269_PBMC_LAIV_Geo"))
```

```
## Downloading matrix..
```

```
## returning summary matrix from cache
```

```
## returning latest annotation from cache
```

```
## Constructing ExpressionSet
## Constructing ExpressionSet
```

```
## Combining ExpressionSets
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 16442 features, 163 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: BS586128 BS586240 ... BS586239 (163 total)
##   varLabels: participant_id study_time_collected ...
##     exposure_process_preferred (8 total)
##   varMetadata: labelDescription
## featureData
##   featureNames: 1 2 ... 16442 (16442 total)
##   fvarLabels: FeatureId gene_symbol
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
```

Finally, the summary argument will let you download the matrix with gene symbols in place of probe ids.

```
gs <- sdy269$getGEMatrix("SDY269_PBMC_TIV_Geo", outputType = "summary", annotation = "latest")
```

```
## returning SDY269_PBMC_TIV_Geo_sum_eset from cache
```

If the connection was created with `verbose = TRUE`, some methods will display additional informations such as the valid dataset names.

# 5 Plotting

A plot of a dataset can be generated using the `plot` method which automatically chooses the type of plot depending on the selected dataset.

```
sdy269$plot("hai")
```

![](data:image/png;base64...)

```
sdy269$plot("elisa")
```

![](data:image/png;base64...)

However, the `type` argument can be used to manually select from “boxplot”, “heatmap”, “violin” and “line”.

# 6 Cross study connections

To fetch data from multiple studies, simply create a connection at the project level.

```
con <- CreateConnection("")
```

This will instantiate a connection at the `Studies` level. Most functions work cross study connections just like they do on single studies.

You can get a list of datasets and gene expression matrices available accross all studies.

```
con
```

```
## <ImmuneSpaceConnection>
##   Study: Studies
##   URL: https://www.immunespace.org/Studies/
##   User: unknown_user at not_a_domain.com
##   13 Available Datasets
##     - cohort_membership
##     - neut_ab_titer
##     - hla_typing
##     - mbaa
##     - fcs_control_files
##     - fcs_sample_files
##     - pcr
##     - elispot
##     - hai
##     - fcs_analyzed_result
##     - gene_expression_files
##     - elisa
##     - demographics
##   106 Available Expression Matrices
```

In cross-study connections, `getDataset` and `getGEMatrix` will combine the requested datasets or expression matrices. See the dedicated vignettes for more information.

Likewise, `plot` will visualize accross studies. Note that in most cases the datasets will have too many cohorts/subjects, making the filtering of the data a necessity. The `colFilter` argument can be used here, as described in the `getDataset` section.

```
plotFilter <- makeFilter(c("cohort", "IN", "TIV 2010;TIV Group 2008"))
con$plot("elispot", filter = plotFilter)
```

![](data:image/png;base64...)

The figure above shows the ELISPOT results for two different years of TIV vaccine cohorts from two different studies.

# 7 Session info

```
sessionInfo()
```

```
## R version 3.5.3 (2019-03-11)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.6 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] Rlabkey_2.2.5       jsonlite_1.6        httr_1.4.0
## [4] ImmuneSpaceR_1.10.5 rmarkdown_1.12      knitr_1.22
##
## loaded via a namespace (and not attached):
##  [1] ncdfFlow_2.28.1       bitops_1.0-6          matrixStats_0.54.0
##  [4] webshot_0.5.1         RColorBrewer_1.1-2    prabclus_2.2-7
##  [7] Rgraphviz_2.26.0      tools_3.5.3           R6_2.4.0
## [10] KernSmooth_2.23-15    lazyeval_0.2.2        BiocGenerics_0.28.0
## [13] colorspace_1.4-1      flowWorkspace_3.30.2  trimcluster_0.1-2.1
## [16] nnet_7.3-12           tidyselect_0.2.5      gridExtra_2.3
## [19] preprocessCore_1.44.0 curl_3.3              compiler_3.5.3
## [22] graph_1.60.0          Biobase_2.42.0        TSP_1.1-6
## [25] plotly_4.8.0          labeling_0.3          diptest_0.75-7
## [28] caTools_1.17.1.2      scales_1.0.0          DEoptimR_1.0-8
## [31] hexbin_1.27.2         mvtnorm_1.0-10        robustbase_0.93-4
## [34] stringr_1.4.0         digest_0.6.18         rrcov_1.4-7
## [37] pkgconfig_2.0.2       htmltools_0.3.6       htmlwidgets_1.3
## [40] rlang_0.3.2           flowCore_1.48.1       mclust_5.4.3
## [43] gtools_3.8.1          dendextend_1.10.0     dplyr_0.8.0.1
## [46] magrittr_1.5          modeltools_0.2-22     Rcpp_1.0.1
## [49] munsell_0.5.0         viridis_0.5.1         stringi_1.4.3
## [52] whisker_0.3-2         yaml_2.2.0            MASS_7.3-51.1
## [55] zlibbioc_1.28.0       flexmix_2.3-15        gplots_3.0.1.1
## [58] plyr_1.8.4            grid_3.5.3            parallel_3.5.3
## [61] gdata_2.18.0          crayon_1.3.4          lattice_0.20-38
## [64] pillar_1.3.1          rjson_0.2.20          fpc_2.1-11.1
## [67] corpcor_1.6.9         reshape2_1.4.3        codetools_0.2-16
## [70] stats4_3.5.3          XML_3.98-1.19         glue_1.3.1
## [73] gclus_1.3.2           evaluate_0.13         latticeExtra_0.6-28
## [76] data.table_1.12.0     foreach_1.4.4         gtable_0.3.0
## [79] purrr_0.3.2           tidyr_0.8.3           kernlab_0.9-27
## [82] heatmaply_0.15.2      assertthat_0.2.1      ggplot2_3.1.0
## [85] xfun_0.5              class_7.3-15          IDPmisc_1.1.19
## [88] pcaPP_1.9-73          viridisLite_0.3.0     seriation_1.2-3
## [91] tibble_2.1.1          pheatmap_1.0.12       iterators_1.0.10
## [94] registry_0.5-1        flowViz_1.46.1        cluster_2.0.7-1
```