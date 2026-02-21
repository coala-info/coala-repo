# Handling Expression Matrices with ImmuneSpaceR

#### Renan Sauteraud

#### 2019-03-27

* [1 Create connections](#create-connections)
* [2 List the expression matrices](#list-the-expression-matrices)
* [3 Download](#download)
  + [3.1 By run name](#by-run-name)
  + [3.2 By cohortType](#by-cohorttype)
* [4 Summarized matrices](#summarized-matrices)
* [5 Combining matrices](#combining-matrices)
* [6 Caching](#caching)
* [7 Session info](#session-info)

This vignette shows detailed examples for the `getGEMatrix()` method

# 1 Create connections

As explained into the introductory vignette, datasets must be downloaded from `ImmuneSpaceConnection` objects. We must first instantiate a connection to the study or studies of interest. Throughout this vignette, we will use two connections, one to a single study, and one to to all available data.

```
library(ImmuneSpaceR)
sdy269 <- CreateConnection("SDY269")
all <- CreateConnection("")
```

# 2 List the expression matrices

Now that the connections have been instantiated, we can start downloading from them. But we need to figure out which processed matrices are available within our chosen studies.

On the ImmuneSpace portal, in the study of interest or at the project level, the **Gene expression matrices** table will show the available runs.

Printing the connections will, among other information, list the datasets availables. The `listDatasets` method will only display the downloadable data. looking for. With `output = "expression"`, the datasets wont be printed.

```
sdy269$listDatasets()
```

```
## datasets
##  gene_expression_files
##  fcs_sample_files
##  demographics
##  elispot
##  hai
##  elisa
##  pcr
##  cohort_membership
##  fcs_analyzed_result
## Expression Matrices
##  SDY269_PBMC_TIV_Geo
##  SDY269_PBMC_LAIV_Geo
```

Using `output = "expression"`, we can remove the datasets from the output.

```
all$listDatasets(output = "expression")
```

```
## Expression Matrices
##  SDY1325_WholeBlood_LowIntraMuscularPS_geo
##  SDY1294_PBMC_ChineseCohort_Geo
##  SDY1119_PBMC_oldHealthy_Geo
##  SDY1119_PBMC_oldT2D_Geo
##  SDY1119_PBMC_youngT2D_Geo
##  SDY1119_PBMC_youngHealthy_Geo
##  SDY1289_WholeBlood_MontrealCohort_Geo
##  SDY1289_WholeBlood_LausanneCohort_Geo
##  SDY1324_PBMC_nonBCGvacc
##  SDY1324_PBMC_LatentTB
##  SDY1324_PBMC_BCGvacc
##  SDY89_WholeBlood_EnergixB
##  SDY1370_Bcell_lc16m8_geo
##  SDY1370_Bcell_dryvax_geo
##  SDY1370_Tcell_lc16m8_geo
##  SDY1370_Tcell_dryvax_geo
##  SDY1370_PBMC_lc16m8_geo
##  SDY1370_PBMC_dryvax_geo
##  SDY1368_WholeBlood_Twin_Geo
##  SDY1368_WholeBlood_NonTwin_Geo
##  SDY67_PBMC_HealthyAdults
##  SDY1328_WholeBlood_HealthyAdults_geo
##  SDY224_PBMC_TIV2010_ImmPort
##  SDY888_PBMC_UninfectedEndemicArea_Geo
##  SDY888_PBMC_UninfectedNonEndemicArea_Geo
##  SDY888_PBMC_InfectedEndemicArea_Geo
##  SDY28_PBMC_Dryvax
##  SDY34_PBMC_TIV
##  SDY34_PBMC_Controls
##  SDY305_Other_IDTIV_Geo
##  SDY305_Other_TIV_Geo
##  SDY112_Other_GroupC
##  SDY112_Other_GroupB
##  SDY112_Other_GroupA
##  SDY315_Other_GroupC_Geo
##  SDY315_Other_GroupB_Geo
##  SDY315_Other_GroupA_Geo
##  SDY406_Other_ILI_Geo
##  SDY113_Other_IDTIV_Geo
##  SDY113_Other_LAIV_Geo
##  SDY113_Other_TIV_Geo
##  SDY144_Other_TIV_Geo
##  SDY690_PBMC_Energixb
##  SDY690_WholeBlood_Energixb
##  SDY597_Other_InVitro
##  SDY522_Other_LAIV
##  SDY387_WholeBlood_NCH2010
##  SDY372_WholeBlood_JDM2012
##  SDY368_WholeBlood_NCH2013
##  SDY364_WholeBlood_NCH2012
##  SDY312_Other_GroupC
##  SDY312_Other_GroupB
##  SDY312_Other_GroupA
##  SDY301_Other_AIRFV
##  SDY299_Other_HEPISLAV
##  SDY296_WholeBlood_AIRFV
##  SDY667_WholeBlood_PSORPPP
##  SDY212_WholeBlood_Older_Geo
##  SDY212_WholeBlood_Young_Geo
##  SDY212_PBMC_Older_Geo
##  SDY212_PBMC_Young_geo
##  SDY270_PBMC_TIVGroup_Geo
##  SDY1373_WholeBlood_highDose_Geo
##  SDY1373_WholeBlood_lowDose_Geo
##  SDY1364_PBMC_IntraDermal_Geo
##  SDY1364_PBMC_IntraMuscular_Geo
##  SDY1325_WholeBlood_IntramuscularCRM_Geo
##  SDY1325_WholeBlood_IntramuscularPS_Geo
##  SDY1325_WholeBlood_SubcutaneousPS_Geo
##  SDY1291_PBMC_HealthyHIVUninfected_Geo
##  SDY80_Other_Cohort2_Geo
##  SDY1293_PBMC_Vaccinated_geo
##  SDY1293_PBMC_Control_Geo
##  SDY1276_WholeBlood_Validation_Geo
##  SDY1276_WholeBlood_Discovery_Geo
##  SDY1264_PBMC_Trial2_Geo
##  SDY1264_PBMC_Trial1_Geo
##  SDY1260_PBMC_MCV4_Geo
##  SDY1260_PBMC_MPSV4_Geo
##  SDY984_PBMC_Elderly_Geo
##  SDY984_PBMC_Young_Geo
##  SDY61_PBMC_TIVGrp
##  SDY56_PBMC_Older
##  SDY56_PBMC_Young
##  SDY80_PBMC_Cohort2_Geo
##  SDY63_PBMC_Young_Geo
##  SDY63_PBMC_Older_Geo
##  SDY404_PBMC_Young_Geo
##  SDY404_PBMC_Older_Geo
##  SDY400_PBMC_Older_Geo
##  SDY400_PBMC_Young_Geo
##  SDY269_PBMC_TIV_Geo
##  SDY269_PBMC_LAIV_Geo
##  SDY180_Other_Grp2Saline_Geo
##  SDY180_Other_Grp2Pneunomax23_Geo
##  SDY180_Other_Grp2Fluzone_Geo
##  SDY180_Other_Grp1Saline_Geo
##  SDY180_Other_Grp1Pneunomax23_Geo
##  SDY180_Other_Grp1Fluzone_Geo
##  SDY300_dendriticCell_dcMonoFlu2011
##  SDY300_otherCell_dcMonoFlu2011
##  SDY67_Batch2_HealthyAdult
##  SDY162_Macrophage_VLplus
##  SDY162_PBMC_VLplus
##  SDY162_Macrophage_VLminus
##  SDY162_PBMC_VLminus
```

Naturally, `all` contains every processed matrices available on ImmuneSpace as it combines all available studies.

# 3 Download

## 3.1 By run name

The `getGEMatrix` method will accept any of the run names listed in the connection.

```
TIV_2008 <- sdy269$getGEMatrix("SDY269_PBMC_TIV_Geo")
```

```
## Downloading matrix..
```

```
## Constructing ExpressionSet
```

```
TIV_2011 <- all$getGEMatrix(matrixName = "SDY144_Other_TIV_Geo")
```

```
## Downloading matrix..
## Constructing ExpressionSet
```

The matrices are returned as `ExpressionSet` where the phenoData slot contains basic demographic information and the featureData slot shows a mapping of probe to official gene symbols.

```
TIV_2008
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 16442 features, 80 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: BS586128 BS586240 ... BS586267 (80 total)
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

## 3.2 By cohortType

The `cohortType` argument can be used in place of the run name (`x`). It is a concatenation of “cohort” and “cell type” so that you may use matrices for analysis that have been normalized within cell-type. Likewise, the list of valid cohortTypes can be found in the Gene expression matrices table.

```
LAIV_2008 <- sdy269$getGEMatrix(cohortType = "LAIV group 2008_PBMC")
```

```
## Downloading matrix..
```

```
## Constructing ExpressionSet
```

Note that when cohort is used, `x` is ignored.

# 4 Summarized matrices

By default, the returned `ExpressionSet`s have probe names as features (or rows). However, multiple probes often match the same gene and merging experiments from different arrays is impossible at feature level. When they are available, the `summary` argument allows to return the matrices with gene symbols instead of probes. You should use `currAnno` set to `TRUE` to use the latest official gene symbols mapped for each probe, but you can also set this to `FALSE` to retrieve the original mappings from when the matrix was created.

```
TIV_2008_sum <- sdy269$getGEMatrix("SDY269_PBMC_TIV_Geo", outputType = "summary", annotation = "latest")
```

```
## returning SDY269_PBMC_TIV_Geo_sum_eset from cache
```

Probes that do not map to a unique gene are removed and expression is averaged by gene.

```
TIV_2008_sum
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 16442 features, 80 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: BS586128 BS586240 ... BS586267 (80 total)
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

# 5 Combining matrices

In order to faciliate analysis across experiments and studies, when multiple runs or cohorts are specified, `getGEMatrix` will attempt to combine the selected expression matrices into a single `ExpressionSet`.

To avoid returning an empty object, it is usually recommended to use the summarized version of the matrices, thus combining by genes. This is almost always necessary when combining data from multiple studies.

```
# Within a study
em269 <- sdy269$getGEMatrix(c("SDY269_PBMC_TIV_Geo", "SDY269_PBMC_LAIV_Geo"))
```

```
## returning summary matrix from cache
## returning summary matrix from cache
```

```
## returning latest annotation from cache
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
# Combining across studies
TIV_seasons <- all$getGEMatrix(c("SDY269_PBMC_TIV_Geo", "SDY144_Other_TIV_Geo"),
outputType = "summary",
annotation = "latest")
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

# 6 Caching

As explained in the introductory, the `ImmuneSpaceConnection` class is a [`R6`](https://cran.r-project.org/web/packages/R6/index.html) class. It means its objects have fields accessed by reference. As a consequence, they can be modified without making a copy of the entire object. ImmuneSpaceR uses this feature to store downloaded datasets and expression matrices. Subsequent calls to `getGEMatrix` with the same input will be faster.

See `?R6::R6Class` for more information about R6 class system.

We can see a list of already downloaded runs and feature sets the `cache` field. This is not intended to be used for data manipulation and only displayed here to explain what gets cached.

```
names(sdy269$cache)
```

```
## [1] "GE_matrices"                   "SDY269_PBMC_TIV_Geo_sum"
## [3] "featureset_18"                 "SDY269_PBMC_TIV_Geo_sum_eset"
## [5] "SDY269_PBMC_LAIV_Geo_sum"      "SDY269_PBMC_LAIV_Geo_sum_eset"
```

If, for any reason, a specific marix needs to be redownloaded, the `reload` argument will clear the cache for that specific `getGEMatrix` call and download the file and metadata again.

```
TIV_2008 <- sdy269$getGEMatrix("SDY269_PBMC_TIV_Geo", reload = TRUE)
```

```
## Downloading matrix..
```

```
## Constructing ExpressionSet
```

Finally, it is possible to clear every cached expression matrix (and dataset).

```
sdy269$clearCache()
```

Again, the `cache` field should never be modified manually. When in doubt, simply reload the expression matrix.

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