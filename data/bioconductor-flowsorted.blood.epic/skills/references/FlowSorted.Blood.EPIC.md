# FlowSorted.Blood.EPIC

#### Lucas A Salas

#### 2025-11-04

Illumina Human Methylation data from EPIC on immunomagnetic sorted adult blood cell populations. The FlowSorted.Blood.EPIC package contains Illumina HumanMethylationEPIC (EPIC)) DNA methylation microarray data from the immunomethylomics group (manuscript submitted), consisting of 37 magnetic sorted blood cell references and 12 samples, formatted as an RGChannelSet object for integration and normalization using most of the existing Bioconductor packages.

This package contains data similar to the FlowSorted.Blood.450k package consisting of data from peripheral blood samples generated from adult men and women. However, when using the newer EPIC microarray minfi estimates of cell type composition using the FlowSorted.Blood.450k package are less precise compared to actual cell counts. Hence, this package consists of appropriate data for deconvolution of adult blood samples used in for example EWAS relying in the newer EPIC technology.

Researchers may find this package useful as these samples represent different cellular populations ( T lymphocytes (CD4+ and CD8+), B cells (CD19+), monocytes (CD14+), NK cells (CD56+) and Neutrophils of cell sorted blood generated with high purity estimates. As a test of accuracy 12 experimental mixtures were reconstructed using fixed amounts of DNA from purified cells.

**Objects included:**
1. *FlowSorted.Blood.EPIC* is the RGChannelSet object containing the reference library

```
library(FlowSorted.Blood.EPIC)
#> Loading required package: minfi
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: GenomicRanges
#> Loading required package: stats4
#> Loading required package: S4Vectors
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: IRanges
#> Loading required package: Seqinfo
#> Loading required package: SummarizedExperiment
#> Loading required package: MatrixGenerics
#> Loading required package: matrixStats
#>
#> Attaching package: 'MatrixGenerics'
#> The following objects are masked from 'package:matrixStats':
#>
#>     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
#>     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
#>     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
#>     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
#>     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
#>     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
#>     colWeightedMeans, colWeightedMedians, colWeightedSds,
#>     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
#>     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
#>     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
#>     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
#>     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
#>     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
#>     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
#>     rowWeightedSds, rowWeightedVars
#> Loading required package: Biobase
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#>
#> Attaching package: 'Biobase'
#> The following object is masked from 'package:MatrixGenerics':
#>
#>     rowMedians
#> The following objects are masked from 'package:matrixStats':
#>
#>     anyMissing, rowMedians
#> Loading required package: Biostrings
#> Loading required package: XVector
#>
#> Attaching package: 'Biostrings'
#> The following object is masked from 'package:base':
#>
#>     strsplit
#> Loading required package: bumphunter
#> Loading required package: foreach
#> Loading required package: iterators
#> Loading required package: parallel
#> Loading required package: locfit
#> locfit 1.5-9.12   2025-03-05
#> Setting options('download.file.method.GEOquery'='auto')
#> Setting options('GEOquery.inmemory.gpl'=FALSE)
#> Loading required package: ExperimentHub
#> Loading required package: AnnotationHub
#> Loading required package: BiocFileCache
#> Loading required package: dbplyr
#>
#> Attaching package: 'AnnotationHub'
#> The following object is masked from 'package:Biobase':
#>
#>     cache
FlowSorted.Blood.EPIC <- libraryDataGet('FlowSorted.Blood.EPIC')
#> see ?FlowSorted.Blood.EPIC and browseVignettes('FlowSorted.Blood.EPIC') for documentation
#> loading from cache
FlowSorted.Blood.EPIC
#> class: RGChannelSet
#> dim: 1051815 49
#> metadata(0):
#> assays(2): Green Red
#> rownames(1051815): 1600101 1600111 ... 99810990 99810992
#> rowData names(0):
#> colnames(49): 201868500150_R01C01 201868500150_R03C01 ...
#>   201870610111_R06C01 201870610111_R07C01
#> colData names(32): Sample_Plate Sample_Well ... filenames normalmix
#> Annotation
#>   array: IlluminaHumanMethylationEPIC
#>   annotation: ilm10b4.hg19
```

The raw dataset is hosted in both ExperimentHub (EH1136) and GEO [GSE110554](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE110554)

2. *IDOLOptimizedCpGs* the IDOL L-DMR library for EPIC arrays

```
data("IDOLOptimizedCpGs")
head(IDOLOptimizedCpGs)
```

3. *IDOLOptimizedCpGs450klegacy* the IDOL L-DMR library for legacy 450k arrays

```
data("IDOLOptimizedCpGs450klegacy")
head(IDOLOptimizedCpGs450klegacy)
```

*See the object help files for additional information*

**estimateCellCounts2 function for cell type deconvolution:**

We offer the function estimateCellCounts2 a modification of the popular estimatesCellCounts function in minfi. Our function corrected small glitches when dealing with combining the DataFrame objects with the reference libraries. We allow the use of MethylSet objects such as those from GEO. However, we offer only Quantile normalization for those datasets (assuming that they have not been previously normalized). The estimates are calculated using the CP/QP method described in Houseman et al. 2012. and adapted in minfi. CIBERSORT and RPC are allowed using external packages.
*see ?estimateCellCounts2 for details*

```
# Step 1: Load the reference library to extract the artificial mixtures
FlowSorted.Blood.EPIC <- libraryDataGet('FlowSorted.Blood.EPIC')
#> see ?FlowSorted.Blood.EPIC and browseVignettes('FlowSorted.Blood.EPIC') for documentation
#> loading from cache
FlowSorted.Blood.EPIC
#> class: RGChannelSet
#> dim: 1051815 49
#> metadata(0):
#> assays(2): Green Red
#> rownames(1051815): 1600101 1600111 ... 99810990 99810992
#> rowData names(0):
#> colnames(49): 201868500150_R01C01 201868500150_R03C01 ...
#>   201870610111_R06C01 201870610111_R07C01
#> colData names(32): Sample_Plate Sample_Well ... filenames normalmix
#> Annotation
#>   array: IlluminaHumanMethylationEPIC
#>   annotation: ilm10b4.hg19

library(minfi)
# Note: If your machine does not allow access to internet you can download
# and save the file. Then load it manually into the R environment

# Step 2 separate the reference from the testing dataset if you want to run
# examples for estimations for this function example

RGsetTargets <- FlowSorted.Blood.EPIC[,
             FlowSorted.Blood.EPIC$CellType == "MIX"]

sampleNames(RGsetTargets) <- paste(RGsetTargets$CellType,
                            seq_len(dim(RGsetTargets)[2]), sep = "_")
RGsetTargets
#> class: RGChannelSet
#> dim: 1051815 12
#> metadata(0):
#> assays(2): Green Red
#> rownames(1051815): 1600101 1600111 ... 99810990 99810992
#> rowData names(0):
#> colnames(12): MIX_1 MIX_2 ... MIX_11 MIX_12
#> colData names(32): Sample_Plate Sample_Well ... filenames normalmix
#> Annotation
#>   array: IlluminaHumanMethylationEPIC
#>   annotation: ilm10b4.hg19

# Step 3: use your favorite package for deconvolution.
# Deconvolve a target data set consisting of EPIC DNA methylation
# data profiled in blood, using your prefered method.

# You can use our IDOL optimized DMR library for the EPIC array.  This object
# contains a vector of length 450 consisting of the IDs of the IDOL optimized
# CpG probes.  These CpGs are used as the backbone for deconvolution and were
# selected because their methylation signature differs across the six normal
# leukocyte subtypes. Use the option "IDOL"

head (IDOLOptimizedCpGs)
#> [1] "cg08769189" "cg07661835" "cg00219921" "cg13468685" "cg04329870"
#> [6] "cg14085952"
# If you need to deconvolve a 450k legacy dataset use
# IDOLOptimizedCpGs450klegacy instead

# We recommend using Noob processMethod = "preprocessNoob" in minfi for the
# target and reference datasets.
# Cell types included are "CD8T", "CD4T", "NK", "Bcell", "Mono", "Neu"

# To use the IDOL optimized list of CpGs (IDOLOptimizedCpGs) use
# estimateCellCounts2 an adaptation of the popular estimateCellCounts in
# minfi. This function also allows including customized reference arrays.

# Do not run with limited RAM the normalization step requires a big amount
# of memory resources

 propEPIC<-estimateCellCounts2(RGsetTargets, compositeCellType = "Blood",
                                processMethod = "preprocessNoob",
                                probeSelect = "IDOL",
                                cellTypes = c("CD8T", "CD4T", "NK", "Bcell",
                                "Mono", "Neu"))
#> see ?FlowSorted.Blood.EPIC and browseVignettes('FlowSorted.Blood.EPIC') for documentation
#> loading from cache
#> [estimateCellCounts2] Combining user data with reference (flow sorted) data.
#> [estimateCellCounts2] Processing user and reference data together.
#> Loading required package: IlluminaHumanMethylationEPICmanifest
#> Loading required package: IlluminaHumanMethylationEPICanno.ilm10b4.hg19
#> [estimateCellCounts2] Using IDOL L-DMR probes for composition estimation.
#> [estimateCellCounts2] Estimating proportion composition (prop), if you provide cellcounts those will be provided as counts in the composition estimation.

print(head(propEPIC$prop))
#>         CD8T   CD4T     NK  Bcell   Mono    Neu
#> MIX_1 0.1915 0.0704 0.1517 0.1906 0.1907 0.2114
#> MIX_2 0.0464 0.1757 0.0181 0.0444 0.0584 0.6699
#> MIX_3 0.0672 0.1010 0.0047 0.0225 0.1093 0.7034
#> MIX_4 0.1210 0.1778 0.0201 0.0168 0.0765 0.6032
#> MIX_5 0.2893 0.1599 0.1526 0.0720 0.2233 0.1120
#> MIX_6 0.0963 0.1573 0.0270 0.0245 0.0706 0.6401
percEPIC<-round(propEPIC$prop*100,1)
```

# Advanced user deconvolution CP/QP, CIBERSORT and/or RPC deconvolution

```
noobset<- preprocessNoob(RGsetTargets)
#or from estimateCellCounts2 returnAll=TRUE

 propEPIC<-projectCellType_CP (
 getBeta(noobset)[IDOLOptimizedCpGs,],
 IDOLOptimizedCpGs.compTable, contrastWBC=NULL, nonnegative=TRUE,
 lessThanOne=FALSE)

print(head(propEPIC))
#>         CD8T   CD4T     NK  Bcell   Mono    Neu
#> MIX_1 0.1907 0.0710 0.1519 0.1906 0.1907 0.2116
#> MIX_2 0.0455 0.1763 0.0184 0.0445 0.0583 0.6702
#> MIX_3 0.0665 0.1014 0.0049 0.0225 0.1092 0.7037
#> MIX_4 0.1199 0.1783 0.0204 0.0169 0.0765 0.6035
#> MIX_5 0.2883 0.1604 0.1529 0.0720 0.2232 0.1122
#> MIX_6 0.0954 0.1578 0.0272 0.0246 0.0705 0.6404
percEPIC<-round(propEPIC*100,1)

# If you prefer CIBERSORT or RPC deconvolution use EpiDISH or similar

# Example not to run

# library(EpiDISH)
# RPC <- epidish(getBeta(noobset)[IDOLOptimizedCpGs,],
# IDOLOptimizedCpGs.compTable, method = "RPC")
# RPC$estF#RPC proportion estimates
# percEPICRPC<-round(RPC$estF*100,1)#percentages
#
# CBS <- epidish(getBeta(noobset)[IDOLOptimizedCpGs,],
# IDOLOptimizedCpGs.compTable, method = "CBS")
# CBS$estF#CBS proportion estimates
# percEPICCBS<-round(CBS$estF*100,1)#percentages
```

Umbilical Cord Blood

```
# # UMBILICAL CORD BLOOD DECONVOLUTION
#
# library (FlowSorted.CordBloodCombined.450k)
# # Step 1: Load the reference library to extract the umbilical cord samples
# FlowSorted.CordBloodCombined.450k <-
#     libraryDataGet('FlowSorted.CordBloodCombined.450k')
#
# FlowSorted.CordBloodCombined.450k
#
# # Step 2 separate the reference from the testing dataset if you want to run
# # examples for estimations for this function example
#
# RGsetTargets <- FlowSorted.CordBloodCombined.450k[,
# FlowSorted.CordBloodCombined.450k$CellType == "WBC"]
# sampleNames(RGsetTargets) <- paste(RGsetTargets$CellType,
#                               seq_len(dim(RGsetTargets)[2]), sep = "_")
# RGsetTargets
#
# # Step 3: use your favorite package for deconvolution.
# # Deconvolve a target data set consisting of 450K DNA methylation
# # data profiled in blood, using your prefered method.
# # You can use our IDOL optimized DMR library for the Cord Blood,  This object
# # contains a vector of length 517 consisting of the IDs of the IDOL optimized
# # CpG probes.  These CpGs are used as the backbone for deconvolution and were
# # selected because their methylation signature differs across the six normal
# # leukocyte subtypes plus the nucleated red blood cells.
#
# # We recommend using Noob processMethod = "preprocessNoob" in minfi for the
# # target and reference datasets.
# # Cell types included are "CD8T", "CD4T", "NK", "Bcell", "Mono", "Gran",
# # "nRBC"
# # To use the IDOL optimized list of CpGs (IDOLOptimizedCpGsCordBlood) use
# # estimateCellCounts2 from FlowSorted.Blood.EPIC.
# # Do not run with limited RAM the normalization step requires a big amount
# # of memory resources. Use the parameters as specified below for
# # reproducibility.
# #
#
#     propUCB<-estimateCellCounts2(RGsetTargets,
#                                     compositeCellType =
#                                                "CordBloodCombined",
#                                     processMethod = "preprocessNoob",
#                                     probeSelect = "IDOL",
#                                     cellTypes = c("CD8T", "CD4T", "NK",
#                                     "Bcell", "Mono", "Gran", "nRBC"))
#
#     head(propUCB$prop)
#     percUCB<-round(propUCB$prop*100,1)
```

Using cell counts instead of proportions. Note: These are random numbers, not the actual cell counts of the experiment

```
# library(FlowSorted.Blood.450k)
# RGsetTargets2 <- FlowSorted.Blood.450k[,
#                              FlowSorted.Blood.450k$CellType == "WBC"]
# sampleNames(RGsetTargets2) <- paste(RGsetTargets2$CellType,
#                              seq_len(dim(RGsetTargets2)[2]), sep = "_")
# RGsetTargets2
# propEPIC2<-estimateCellCounts2(RGsetTargets2, compositeCellType = "Blood",
#                              processMethod = "preprocessNoob",
#                              probeSelect = "IDOL",
#                              cellTypes = c("CD8T", "CD4T", "NK", "Bcell",
#                              "Mono", "Neu"), cellcounts = rep(10000,6))
# head(propEPIC2$prop)
# head(propEPIC2$counts)
# percEPIC2<-round(propEPIC2$prop*100,1)
```

Blood Extended deconvolution

```
# # Blood Extended deconvolution or any external reference
# #please contact <Technology.Transfer@dartmouth.edu>
#
# # Do not run
# library (FlowSorted.BloodExtended.EPIC)
# #
# # Step 1: Extract the mix samples
#
# FlowSorted.Blood.EPIC <- libraryDataGet('FlowSorted.Blood.EPIC')
#
# # Step 2 separate the reference from the testing dataset if you want to run
# # examples for estimations for this function example
#
# RGsetTargets <- FlowSorted.Blood.EPIC[,
# FlowSorted.Blood.EPIC$CellType == "MIX"]
# sampleNames(RGsetTargets) <- paste(RGsetTargets$CellType,
#                               seq_len(dim(RGsetTargets)[2]), sep = "_")
# RGsetTargets
#
# # Step 3: use your favorite package for deconvolution.
# # Deconvolve the target data set 450K or EPIC blood DNA methylation.
# # We recommend ONLY the IDOL method, the automatic method can lead to severe
# # biases.
#
# # We recommend using Noob processMethod = "preprocessNoob" in minfi for the
# # target and reference datasets.
# # Cell types included are "Bas", "Bmem", "Bnv", "CD4mem", "CD4nv",
# # "CD8mem", "CD8nv", "Eos", "Mono", "Neu", "NK", and "Treg"
# # Use estimateCellCounts2 from FlowSorted.Blood.EPIC.
# # Do not run with limited RAM the normalization step requires a big amount
# # of memory resources. Use the parameters as specified below for
# # reproducibility.
# #
#
#     prop_ext<-estimateCellCounts2(RGsetTargets,
#                                     compositeCellType =
#                                                "BloodExtended",
#                                     processMethod = "preprocessNoob",
#                                     probeSelect = "IDOL",
#                                     cellTypes = c("Bas", "Bmem", "Bnv",
#                                                "CD4mem", "CD4nv",
#                                               "CD8mem", "CD8nv", "Eos",
#                                               "Mono", "Neu", "NK", "Treg"),
#     CustomCpGs =if(RGsetTargets@annotation[1]=="IlluminaHumanMethylationEPIC"){
#     IDOLOptimizedCpGsBloodExtended}else{IDOLOptimizedCpGsBloodExtended450k})
#
#    perc_ext<-round(prop_ext$prop*100,1)
#    head(perc_ext)
```

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
#> [1] parallel  stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] IlluminaHumanMethylationEPICanno.ilm10b4.hg19_0.6.0
#>  [2] IlluminaHumanMethylationEPICmanifest_0.3.0
#>  [3] FlowSorted.Blood.EPIC_2.14.0
#>  [4] ExperimentHub_3.0.0
#>  [5] AnnotationHub_4.0.0
#>  [6] BiocFileCache_3.0.0
#>  [7] dbplyr_2.5.1
#>  [8] minfi_1.56.0
#>  [9] bumphunter_1.52.0
#> [10] locfit_1.5-9.12
#> [11] iterators_1.0.14
#> [12] foreach_1.5.2
#> [13] Biostrings_2.78.0
#> [14] XVector_0.50.0
#> [15] SummarizedExperiment_1.40.0
#> [16] Biobase_2.70.0
#> [17] MatrixGenerics_1.22.0
#> [18] matrixStats_1.5.0
#> [19] GenomicRanges_1.62.0
#> [20] Seqinfo_1.0.0
#> [21] IRanges_2.44.0
#> [22] S4Vectors_0.48.0
#> [23] BiocGenerics_0.56.0
#> [24] generics_0.1.4
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
#>   [3] magrittr_2.0.4            GenomicFeatures_1.62.0
#>   [5] rmarkdown_2.30            BiocIO_1.20.0
#>   [7] vctrs_0.6.5               multtest_2.66.0
#>   [9] memoise_2.0.1             Rsamtools_2.26.0
#>  [11] DelayedMatrixStats_1.32.0 RCurl_1.98-1.17
#>  [13] askpass_1.2.1             htmltools_0.5.8.1
#>  [15] S4Arrays_1.10.0           curl_7.0.0
#>  [17] Rhdf5lib_1.32.0           SparseArray_1.10.1
#>  [19] rhdf5_2.54.0              sass_0.4.10
#>  [21] nor1mix_1.3-3             bslib_0.9.0
#>  [23] plyr_1.8.9                httr2_1.2.1
#>  [25] cachem_1.1.0              GenomicAlignments_1.46.0
#>  [27] lifecycle_1.0.4           pkgconfig_2.0.3
#>  [29] Matrix_1.7-4              R6_2.6.1
#>  [31] fastmap_1.2.0             digest_0.6.37
#>  [33] siggenes_1.84.0           reshape_0.8.10
#>  [35] AnnotationDbi_1.72.0      RSQLite_2.4.3
#>  [37] base64_2.0.2              filelock_1.0.3
#>  [39] httr_1.4.7                abind_1.4-8
#>  [41] compiler_4.5.1            beanplot_1.3.1
#>  [43] rngtools_1.5.2            bit64_4.6.0-1
#>  [45] withr_3.0.2               BiocParallel_1.44.0
#>  [47] DBI_1.2.3                 HDF5Array_1.38.0
#>  [49] MASS_7.3-65               openssl_2.3.4
#>  [51] rappdirs_0.3.3            DelayedArray_0.36.0
#>  [53] rjson_0.2.23              tools_4.5.1
#>  [55] rentrez_1.2.4             glue_1.8.0
#>  [57] quadprog_1.5-8            h5mread_1.2.0
#>  [59] restfulr_0.0.16           nlme_3.1-168
#>  [61] rhdf5filters_1.22.0       grid_4.5.1
#>  [63] tzdb_0.5.0                preprocessCore_1.72.0
#>  [65] tidyr_1.3.1               data.table_1.17.8
#>  [67] hms_1.1.4                 xml2_1.4.1
#>  [69] BiocVersion_3.22.0        pillar_1.11.1
#>  [71] limma_3.66.0              genefilter_1.92.0
#>  [73] splines_4.5.1             dplyr_1.1.4
#>  [75] lattice_0.22-7            survival_3.8-3
#>  [77] rtracklayer_1.70.0        bit_4.6.0
#>  [79] GEOquery_2.78.0           annotate_1.88.0
#>  [81] tidyselect_1.2.1          knitr_1.50
#>  [83] xfun_0.54                 scrime_1.3.5
#>  [85] statmod_1.5.1             yaml_2.3.10
#>  [87] evaluate_1.0.5            codetools_0.2-20
#>  [89] cigarillo_1.0.0           tibble_3.3.0
#>  [91] BiocManager_1.30.26       cli_3.6.5
#>  [93] xtable_1.8-4              jquerylib_0.1.4
#>  [95] Rcpp_1.1.0                png_0.1-8
#>  [97] XML_3.99-0.19             readr_2.1.5
#>  [99] blob_1.2.4                mclust_6.1.2
#> [101] doRNG_1.8.6.2             sparseMatrixStats_1.22.0
#> [103] bitops_1.0-9              illuminaio_0.52.0
#> [105] purrr_1.1.0               crayon_1.5.3
#> [107] rlang_1.1.6               KEGGREST_1.50.0
```

**References**

LA Salas et al. (2018). An optimized library for reference-based deconvolution of whole-blood biospecimens assayed using the Illumina HumanMethylationEPIC BeadArray. Genome Biology 19, 64. doi: [10.1186/s13059-018-1448-7](https://dx.doi.org/10.1186/s13059-018-1448-7).

LA Salas et al. (2022). . Nat Comm 13, 761 (2022). doi: [10.1038/s41467-021-27864-7](https://doi.org/10.1038/s41467-021-27864-7).

DC Koestler et al. (2016). Improving cell mixture deconvolution by identifying optimal DNA methylation libraries (IDOL). BMC bioinformatics. 17, 120. doi: [10.1186/s12859-016-0943-7](https://dx.doi.org/10.1186/s12859-016-0943-7).

K Gervin, LA Salas et al. (2019) . Clin Epigenetics 11,125. doi: [10.1186/s13148-019-0717-y](https://dx.doi.org/10.1186/s13148-019-0717-y).

EA Houseman et al. (2012) DNA methylation arrays as surrogate measures of cell mixture distribution. BMC Bioinformatics 13, 86. doi: [10.1186/1471-2105-13-86](https://dx.doi.org/10.1186/1471-2105-13-86).

[minfi](http://bioconductor.org/packages/release/bioc/html/minfi.html) Tools to analyze & visualize Illumina Infinium methylation arrays.