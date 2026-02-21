# Protein data using GeomxTools

#### Compiled: 2025-10-30

# Overview

This tutorial demonstrates how to use GeomxTools for preprocessing protein or proteogenomics data.

# Data Processing

Data processing is very similar to what is shown in the [Developer\_Introduction\_to\_the\_NanoStringGeoMxSet](http://www.bioconductor.org/packages/release/bioc/vignettes/GeomxTools/inst/doc/Developer_Introduction_to_the_NanoStringGeoMxSet.html) and [GeoMx Workflow](https://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html) vignettes with a couple of protein specific functions.

```
library(GeomxTools)
```

GeoMxSet objects can only read in one analyte at a time. With protein or proteogenomics data, the desired analyte must be added to the call to read in the object. RNA is the default analyte.

```
datadir <- system.file("extdata","DSP_Proteogenomics_Example_Data",
                       package = "GeomxTools")

DCCFiles <- unzip(zipfile = file.path(datadir,  "/DCCs.zip"))
PKCFiles <- unzip(zipfile = file.path(datadir,  "/pkcs.zip"))
SampleAnnotationFile <- file.path(datadir, "Annotation.xlsx")

RNAData <- suppressWarnings(readNanoStringGeoMxSet(dccFiles = DCCFiles,
                                                   pkcFiles = PKCFiles,
                                                   phenoDataFile = SampleAnnotationFile,
                                                   phenoDataSheet = "Annotations",
                                                   phenoDataDccColName = "Sample_ID",
                                                   protocolDataColNames = c("Tissue",
                                                                            "Segment_Type",
                                                                            "ROI.Size"),
                                                   configFile = NULL,
                                                   analyte = "RNA",
                                                   phenoDataColPrefix = "",
                                                   experimentDataColNames = NULL))

proteinData <- suppressWarnings(readNanoStringGeoMxSet(dccFiles = DCCFiles,
                                                       pkcFiles = PKCFiles,
                                                       phenoDataFile = SampleAnnotationFile,
                                                       phenoDataSheet = "Annotations",
                                                       phenoDataDccColName = "Sample_ID",
                                                       protocolDataColNames = c("Tissue",
                                                                                "Segment_Type",
                                                                                "ROI.Size"),
                                                       configFile = NULL,
                                                       analyte = "protein",
                                                       phenoDataColPrefix = "",
                                                       experimentDataColNames = NULL))

RNAData <- aggregateCounts(RNAData)
RNAData
```

```
## NanoStringGeoMxSet (storageMode: lockedEnvironment)
## assayData: 18677 features, 84 samples
##   element names: exprs
## protocolData
##   sampleNames: DSP-1001900002618-G-A02.dcc DSP-1001900002618-G-A03.dcc
##     ... DSP-1001900002618-G-H01.dcc (84 total)
##   varLabels: FileVersion SoftwareVersion ... ROI.Size (17 total)
##   varMetadata: labelDescription
## phenoData
##   sampleNames: DSP-1001900002618-G-A02.dcc DSP-1001900002618-G-A03.dcc
##     ... DSP-1001900002618-G-H01.dcc (84 total)
##   varLabels: Plate Well ... NegGeoSD_Hs_R_NGS_WTA_v1.0 (13 total)
##   varMetadata: labelDescription
## featureData
##   featureNames: A2M NAT2 ... CST2 (18677 total)
##   fvarLabels: TargetName Module ... Negative (7 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation: Hs_R_NGS_WTA_v1.0.pkc
## signature: none
## feature: Target
## analyte: RNA
```

```
#Protein Data is aggregated automatically on readin
proteinData
```

```
## NanoStringGeoMxSet (storageMode: lockedEnvironment)
## assayData: 147 features, 84 samples
##   element names: exprs
## protocolData
##   sampleNames: DSP-1001900002618-G-A02.dcc DSP-1001900002618-G-A03.dcc
##     ... DSP-1001900002618-G-H01.dcc (84 total)
##   varLabels: FileVersion SoftwareVersion ... ROI.Size (17 total)
##   varMetadata: labelDescription
## phenoData
##   sampleNames: DSP-1001900002618-G-A02.dcc DSP-1001900002618-G-A03.dcc
##     ... DSP-1001900002618-G-H01.dcc (84 total)
##   varLabels: Plate Well ... Y (11 total)
##   varMetadata: labelDescription
## featureData
##   featureNames: Ms IgG1 CD45 ... ADAM10 (147 total)
##   fvarLabels: RTS_ID TargetName ... Negative (9 total)
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation: Hs_P_NGS_ADPath_Ext_v1.0.pkc Hs_P_NGS_ADPath_v1.0.pkc Hs_P_NGS_Autophagy_v1.0.pkc Hs_P_NGS_CellDeath_v1.0.pkc Hs_P_NGS_Core_v1.0.pkc Hs_P_NGS_GlialSubtype_v1.0.pkc Hs_P_NGS_IODrugTarget_v1.0.pkc Hs_P_NGS_ImmuneActivation_v1.0.pkc Hs_P_NGS_ImmuneCellTyping_v1.0.pkc Hs_P_NGS_MAPK_v1.1.pkc Hs_P_NGS_Myeloid_v1.0.pkc Hs_P_NGS_NeuralCellTyping_v1.0.pkc Hs_P_NGS_PDPath_v1.0.pkc Hs_P_NGS_PI3K_AKT_v1.0.pkc Hs_P_NGS_PanTumor_v1.0.pkc
## signature: none
## feature: Target
## analyte: Protein
```

By having the datasets split by analyte, each object can go through the typical QC and normalization steps specific to that analyte.

# RNA

For RNA please refer to the [introduction](http://www.bioconductor.org/packages/release/bioc/vignettes/GeomxTools/inst/doc/Developer_Introduction_to_the_NanoStringGeoMxSet.html) or [GeoMx Workflow](https://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html) vignettes.

# Protein

### Segment QC

After reading in the object, we will do one QC step: flag and remove low quality ROIs

```
proteinData <- setSegmentQCFlags(proteinData, qcCutoffs = list(percentSaturation = 45,
                                                               minSegmentReads=1000,
                                                               percentAligned=80,
                                                               minNegativeCount=10,
                                                               maxNTCCount=60,
                                                               minNuclei=16000,
                                                               minArea=20))

# low sequenced ROIs
lowSaturation <- which(as.data.frame(protocolData(proteinData)[["QCFlags"]])["LowSaturation"] == TRUE)

# remove low quality ROIs
passedQC <- proteinData[, -lowSaturation]
dim(proteinData)
```

```
## Features  Samples
##      147       84
```

```
dim(passedQC)
```

```
## Features  Samples
##      147       82
```

### Target QC

Housekeepers and negative controls (IgGs) can easily be pulled out of the dataset.

```
hk.names <- hkNames(proteinData)
hk.names
```

```
## [1] "Histone H3" "GAPDH"      "S6"
```

```
igg.names <- iggNames(proteinData)
igg.names
```

```
## [1] "Ms IgG1"  "Ms IgG2a" "Rb IgG"
```

For the target QC step, we identify proteins with potentially little useful signal using this figure.

```
fig <- qcProteinSignal(object = proteinData, neg.names = igg.names)

proteinOrder <- qcProteinSignalNames(object = proteinData, neg.names = igg.names)
genesOfInterest <- c(which(proteinOrder == "Tyrosine Hydroxylase"),
                     which(proteinOrder == "ApoA-I"),
                     which(proteinOrder == "EpCAM"))

fig()
rect(xleft = 0, xright = 4,
     ybottom = -2, ytop = 2, density = 0, col = "#1B9E77", lwd = 2)
rect(xleft = genesOfInterest[1]-1, xright = genesOfInterest[1]+1,
     ybottom = -2, ytop = 1.25, density = 0, col = "#D95F02", lwd = 2)
rect(xleft = genesOfInterest[2]-1, xright = genesOfInterest[2]+1,
     ybottom = -1, ytop = 3, density = 0, col = "#66A61E", lwd = 2)
rect(xleft = genesOfInterest[3]-1, xright = genesOfInterest[3]+1,
     ybottom = -3, ytop = 6.5, density = 0, col = "#E7298A", lwd = 2)
```

![](data:image/png;base64...)

* Negative controls (IgGs) (cyan) are plotted on the far left of the plot.
* Tyrosine Hydroxylase (orange) hovers around background in all segments and might need to be excluded from analysis.
* ApoA-I (green) is mostly near-background, but it has meaningfully high signal in a handful of segments.
* EpCAM (pink) seems to have lower background than the negative controls. But its long range, and especially the existence of points well above background, suggests this protein has interpretable data.

The highlighted proteins may require further investigation after differential expression analysis but can typically be kept in the study.

```
proteinOrder <- qcProteinSignalNames(object = proteinData, neg.names = igg.names)

P62 <- which(proteinOrder == "P62")

fig()
rect(xleft = 3.5, xright = P62, ybottom = -6, ytop = 10, density = 2, col = "red", lty = 3)
```

![](data:image/png;base64...)

However, here is example code if you choose to remove them.

In bulk:

```
proteinOrder <- qcProteinSignalNames(object = proteinData, neg.names = igg.names)
length(proteinOrder)

P62 <- which(proteinOrder == "P62")

fig()
rect(xleft = 3.5, xright = P62, ybottom = -6, ytop = 10, density = 2, col = "red", lty = 3)

#Right most protein where all proteins to the left will get removed
#start after the IgG targets
proteinOrder <- proteinOrder[-c((length(igg.names)+1):P62)]
length(proteinOrder)

#replot with fewer targets
fig <- qcProteinSignal(object = proteinData[proteinOrder,], neg.names = igg.names)
fig()
```

Or by specific proteins:

```
proteinOrder <- qcProteinSignalNames(object = proteinData[proteinOrder,], neg.names = igg.names)
#which proteins to remove from analysis
lowTargets <- c("pan-RAS", "Neprilysin", "Olig2", "P2ry12", "p53", "NY-ESO-1", "INPP4B", "CD31", "Phospho-Alpha-synuclein (S129)", "Bcl-2")
proteinOrder <- proteinOrder[-c(which(proteinOrder %in% lowTargets))]
length(proteinOrder)

fig <- qcProteinSignal(object = proteinData[proteinOrder,], neg.names = igg.names)
fig()
```

### Normalization

For more information on protein normalization please refer to our [whitepaper](https://nanostring.com/resources/introduction-to-geomx-normalization-protein/).

After filtering targets, we move onto normalization. There are many types of normalization and we have two built in figure types to help decide what is the best method for the dataset.

The first is a concordance plot of a list of targets, normally the IgGs or HK, colored by ROI factors like tissue or segment type. The upper panels are the concordance plots and the lower panels are the standard deviation of the log2-ratios between the targets. This figure does not show correlations because that calculation is increased with the large range that these values can take (198-165497 in this example). SD(log2(ratios)) measures essentially the same thing but is invariant to that range. However the metrics are inversed, high correlation = low SDs.

Our motivating theory is simple: if several targets all accurately measure signal strength, they should be highly correlated with each other. More precisely, the log-ratios between them should have low SDs.

```
plotConcordance(object = proteinData, targetList = igg.names, plotFactor = "Tissue")
```

![](data:image/png;base64...)

Above we see good concordance amongst the IgGs, confirming they all can be used. Numbers in the top-right panels show the SD of the log2-ratios between IgGs. Importantly, we do not see a tendency for one IgG to be offset from the others, suggesting there’s no between-slide bias in calculation of background.

The second plot helps show the concordance of normalization factors. The factors are calculated on the IgG and HK targets and the area or nuclei count if provided. The lower panels are the concordance plots and the upper panels are the standard deviation of the log2-ratios between the normalization factors.

```
normfactors <- computeNormalizationFactors(object = proteinData,
                                           area = "AOI.Size.um2",
                                           nuclei = "Nuclei.Counts")

plotNormFactorConcordance(object = proteinData, plotFactor = "Tissue",
                          normfactors = normfactors)
```

![](data:image/png;base64...)

From this plot we can conclude that:

* The IgGs and the housekeepers agree nicely, suggesting that if we normalize using one of them, the other will leave little artifactual signal in the data. If these factors diverged strongly, we would know that normalization with one of them would fail to account for the other, leaving an artifact in the data that must be accounted for in downstream analysis.
* Area and nuclei are consistent with each other (SD log2 ratio of 0.61).
* Area and nuclei diverge somewhat from the target-based normalization factors Neg geomean and HK geomean. This suggests that signal strength is not purely a result of area/cell count, or alternatively, that the neg and HK geomeans are noisy metrics.
* The concordance of Negs/HKs suggests their performance is adequate, leading to the conclusion that area/nuclei are noisy measurements of signal strength in this data.

This divergence of area and nuclei vs IgGs and HKs is common which is why Background or HK normalization is recommended. The area and nuclei plots are good QC metrics to look for outliers or additionally can help you potentially ID some preferential bias in a study design.

After choosing a normalization technique from these plots, we normalize the data. Area and nuclei normalization are not native functions in GeomxTools, if you decide on normalizing by those factors you will need to do that separately. Quantile normalization is also available if HK or background normalization are not preferred.

```
#HK normalization
proteinData <- normalize(proteinData, norm_method="hk", toElt = "hk_norm")

#Background normalization
proteinData <- normalize(proteinData, norm_method="neg", toElt = "neg_norm")

#Quantile normalization
proteinData <- normalize(proteinData, norm_method="quant", desiredQuantile = .75, toElt = "q_norm")

names(proteinData@assayData)
```

```
## [1] "neg_norm" "q_norm"   "exprs"    "hk_norm"
```

This dataset is now ready for downstream analysis.

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
##  [1] SpatialExperiment_1.20.0    SingleCellExperiment_1.32.0
##  [3] SummarizedExperiment_1.40.0 GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] MatrixGenerics_1.22.0       matrixStats_1.5.0
##  [9] future_1.67.0               patchwork_1.3.2
## [11] SpatialDecon_1.20.0         Seurat_5.3.1
## [13] SeuratObject_5.2.0          sp_2.2-0
## [15] ggiraph_0.9.2               EnvStats_3.1.0
## [17] GeomxTools_3.14.0           NanoStringNCTools_1.18.0
## [19] ggplot2_4.0.0               S4Vectors_0.48.0
## [21] Biobase_2.70.0              BiocGenerics_0.56.0
## [23] generics_0.1.4
##
## loaded via a namespace (and not attached):
##   [1] RcppAnnoy_0.0.22        splines_4.5.1           later_1.4.4
##   [4] R.oo_1.27.1             tibble_3.3.0            cellranger_1.1.0
##   [7] polyclip_1.10-7         fastDummies_1.7.5       lifecycle_1.0.4
##  [10] Rdpack_2.6.4            globals_0.18.0          lattice_0.22-7
##  [13] MASS_7.3-65             magrittr_2.0.4          limma_3.66.0
##  [16] plotly_4.11.0           sass_0.4.10             rmarkdown_2.30
##  [19] jquerylib_0.1.4         yaml_2.3.10             httpuv_1.6.16
##  [22] otel_0.2.0              sctransform_0.4.2       spam_2.11-1
##  [25] spatstat.sparse_3.1-0   reticulate_1.44.0       cowplot_1.2.0
##  [28] pbapply_1.7-4           minqa_1.2.8             RColorBrewer_1.1-3
##  [31] abind_1.4-8             R.cache_0.17.0          Rtsne_0.17
##  [34] R.utils_2.13.0          purrr_1.1.0             gdtools_0.4.4
##  [37] ggrepel_0.9.6           irlba_2.3.5.1           listenv_0.9.1
##  [40] spatstat.utils_3.2-0    pheatmap_1.0.13         goftest_1.2-3
##  [43] RSpectra_0.16-2         spatstat.random_3.4-2   fitdistrplus_1.2-4
##  [46] parallelly_1.45.1       DelayedArray_0.36.0     codetools_0.2-20
##  [49] tidyselect_1.2.1        farver_2.1.2            lme4_1.1-37
##  [52] spatstat.explore_3.5-3  jsonlite_2.0.0          progressr_0.17.0
##  [55] ggridges_0.5.7          survival_3.8-3          systemfonts_1.3.1
##  [58] tools_4.5.1             ica_1.0-3               Rcpp_1.1.0
##  [61] glue_1.8.0              SparseArray_1.10.0      gridExtra_2.3
##  [64] mgcv_1.9-3              xfun_0.53               ggthemes_5.1.0
##  [67] dplyr_1.1.4             withr_3.0.2             numDeriv_2016.8-1.1
##  [70] fastmap_1.2.0           GGally_2.4.0            repmis_0.5.1
##  [73] boot_1.3-32             digest_0.6.37           R6_2.6.1
##  [76] mime_0.13               scattermore_1.2         tensor_1.5.1
##  [79] dichromat_2.0-0.1       spatstat.data_3.1-9     R.methodsS3_1.8.2
##  [82] tidyr_1.3.1             fontLiberation_0.1.0    data.table_1.17.8
##  [85] S4Arrays_1.10.0         httr_1.4.7              htmlwidgets_1.6.4
##  [88] ggstats_0.11.0          uwot_0.2.3              pkgconfig_2.0.3
##  [91] gtable_0.3.6            lmtest_0.9-40           S7_0.2.0
##  [94] XVector_0.50.0          htmltools_0.5.8.1       fontBitstreamVera_0.1.1
##  [97] dotCall64_1.2           scales_1.4.0            png_0.1-8
## [100] logNormReg_0.5-0        spatstat.univar_3.1-4   reformulas_0.4.2
## [103] knitr_1.50              reshape2_1.4.4          rjson_0.2.23
## [106] nlme_3.1-168            nloptr_2.2.1            cachem_1.1.0
## [109] zoo_1.8-14              stringr_1.5.2           KernSmooth_2.23-26
## [112] parallel_4.5.1          miniUI_0.1.2            vipor_0.4.7
## [115] ggrastr_1.0.2           pillar_1.11.1           grid_4.5.1
## [118] vctrs_0.6.5             RANN_2.6.2              promises_1.4.0
## [121] xtable_1.8-4            cluster_2.1.8.1         beeswarm_0.4.0
## [124] evaluate_1.0.5          magick_2.9.0            cli_3.6.5
## [127] compiler_4.5.1          rlang_1.1.6             crayon_1.5.3
## [130] future.apply_1.20.0     labeling_0.4.3          plyr_1.8.9
## [133] ggbeeswarm_0.7.2        stringi_1.8.7           viridisLite_0.4.2
## [136] deldir_2.0-4            lmerTest_3.1-3          Biostrings_2.78.0
## [139] lazyeval_0.2.2          spatstat.geom_3.6-0     fontquiver_0.2.1
## [142] Matrix_1.7-4            RcppHNSW_0.6.0          statmod_1.5.1
## [145] shiny_1.11.1            rbibutils_2.3           ROCR_1.0-11
## [148] igraph_2.2.1            bslib_0.9.0             readxl_1.4.5
```