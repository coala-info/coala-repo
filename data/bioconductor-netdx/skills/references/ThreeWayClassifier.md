# TL;DR

This code block is not evaluated. Need a breakdown? Look at the following sections.

```
suppressWarnings(suppressMessages(require(netDx)))
suppressWarnings(suppressMessages(library(curatedTCGAData)))

# fetch RNA, methylation and proteomic data for TCGA BRCA set
brca <- suppressMessages(
   curatedTCGAData("BRCA",
               c("mRNAArray","RPPA*","Methylation_methyl27*"),
    dry.run=FALSE))

# process input variables
# prepare clinical variable - stage
staget <- sub("[abcd]","",sub("t","",colData(brca)$pathology_T_stage))
staget <- suppressWarnings(as.integer(staget))
colData(brca)$STAGE <- staget
# exclude normal, HER2 (small num samples)
pam50 <- colData(brca)$PAM50.mRNA
idx <- union(which(pam50 %in% c("Normal-like","HER2-enriched")),
    which(is.na(staget)))
idx <- union(idx, which(is.na(pam50)))
pID <- colData(brca)$patientID
tokeep <- setdiff(pID, pID[idx])
brca <- brca[,tokeep,]
pam50 <- colData(brca)$PAM50.mRNA
colData(brca)$pam_mod <- pam50

# remove duplicate names
smp <- sampleMap(brca)
for (nm in names(brca)) {
    samps <- smp[which(smp$assay==nm),]
    notdup <- samps[which(!duplicated(samps$primary)),"colname"]
    brca[[nm]] <- suppressMessages(brca[[nm]][,notdup])
}

# colData must have ID and STATUS columns
pID <- colData(brca)$patientID
colData(brca)$ID <- pID
colData(brca)$STATUS <- gsub(" ","_",colData(brca)$pam_mod)

# create grouping rules
groupList <- list()
# genes in mRNA data are grouped by pathways
pathList <- readPathways(fetchPathwayDefinitions("January",2018))
groupList[["BRCA_mRNAArray-20160128"]] <- pathList[1:3]
# clinical data is not grouped; each variable is its own feature
groupList[["clinical"]] <- list(
      age="patient.age_at_initial_pathologic_diagnosis",
       stage="STAGE"
)
# for methylation generate one feature containing all probes
# same for proteomics data
tmp <- list(rownames(experiments(brca)[[2]]));
names(tmp) <- names(brca)[2]
groupList[[names(brca)[2]]] <- tmp

tmp <- list(rownames(experiments(brca)[[3]]));
names(tmp) <- names(brca)[3]
groupList[[names(brca)[3]]] <- tmp

# create function to tell netDx how to build features
# (PSN) from your data
makeNets <- function(dataList, groupList, netDir,...) {
    netList <- c() # initialize before is.null() check
    # correlation-based similarity for mRNA, RPPA and methylation data
    # (Pearson correlation)
    for (nm in setdiff(names(groupList),"clinical")) {
       # NOTE: the check for is.null() is important!
        if (!is.null(groupList[[nm]])) {
        netList <- makePSN_NamedMatrix(dataList[[nm]],
                     rownames(dataList[[nm]]),
                   groupList[[nm]],netDir,verbose=FALSE,
                     writeProfiles=TRUE,...)
        }
    }

    # make clinical nets (normalized difference)
    netList2 <- c()
    if (!is.null(groupList[["clinical"]])) {
    netList2 <- makePSN_NamedMatrix(dataList$clinical,
        rownames(dataList$clinical),
        groupList[["clinical"]],netDir,
        simMetric="custom",customFunc=normDiff, # custom function
        writeProfiles=FALSE,
        sparsify=TRUE,verbose=TRUE,...)
    }
    netList <- c(unlist(netList),unlist(netList2))
    return(netList)
}

# run predictor
set.seed(42) # make results reproducible
outDir <- paste(tempdir(),randAlphanumString(),"pred_output",sep=getFileSep())
# To see all messages, remove suppressMessages()
# and set logging="default".
# To keep all intermediate data, set keepAllData=TRUE
numSplits <- 2L
out <- suppressMessages(
   buildPredictor(dataList=brca,groupList=groupList,
      makeNetFunc=makeNets,
      outDir=outDir, ## netDx requires absolute path
      numSplits=numSplits, featScoreMax=2L, featSelCutoff=1L,
       numCores=1L)
)

# collect results for accuracy
st <- unique(colData(brca)$STATUS)
acc <- matrix(NA,ncol=length(st),nrow=numSplits)  # accuracy by class
colnames(acc) <- st
for (k in 1:numSplits) {
    pred <- out[[sprintf("Split%i",k)]][["predictions"]];
    tmp <- pred[,c("ID","STATUS","TT_STATUS","PRED_CLASS",
                     sprintf("%s_SCORE",st))]
    for (m in 1:length(st)) {
       tmp2 <- subset(tmp, STATUS==st[m])
       acc[k,m] <- sum(tmp2$PRED==tmp2$STATUS)/nrow(tmp2)
    }
}

# accuracy by class
print(round(acc*100,2))

# confusion matrix
res <- out$Split1$predictions
print(table(res[,c("STATUS","PRED_CLASS")]))

sessionInfo()
```

# Introduction

In this example, we will use clinical data and three types of 'omic data - gene expression, DNA methylation and proteomic data - to classify breast tumours as being one of three types: Luminal A, Luminal B, or Basal. This example is nearly identical to the one used to build a binary classifier.

We also use several strategies and definitions of similarity to create features:

* Clinical variables: Each *variable* is its own feature (e.g. age); similarity is defined as *normalized difference*.
* Gene expression: Features are defined at the level of ***pathways***; i.e. a feature groups genes corresponding to the pathway. Similarity is defined as pairwise *Pearson correlation*
* Proteomic and methylation data: Features are defined at the level of the entire *data layer*; a single feature is created for all of proteomic data, and the same for methylation. Similarity is defined by pairwise *Pearson correlation*

# Setup

Load the `netDx` package.

```
suppressWarnings(suppressMessages(require(netDx)))
```

# Data

For this example we pull data from the The Cancer Genome Atlas through the BioConductor `curatedTCGAData` package. The fetch command automatically brings in a `MultiAssayExperiment` object.

```
suppressMessages(library(curatedTCGAData))
```

We use the `curatedTCGAData()` command to look at available assays in the breast cancer dataset.

```
curatedTCGAData(diseaseCode="BRCA", assays="*",dry.run=TRUE)
```

```
##                                         Title DispatchClass
## 31                       BRCA_CNASeq-20160128           Rda
## 32                       BRCA_CNASNP-20160128           Rda
## 33                       BRCA_CNVSNP-20160128           Rda
## 35             BRCA_GISTIC_AllByGene-20160128           Rda
## 36                 BRCA_GISTIC_Peaks-20160128           Rda
## 37     BRCA_GISTIC_ThresholdedByGene-20160128           Rda
## 39  BRCA_Methylation_methyl27-20160128_assays        H5File
## 40      BRCA_Methylation_methyl27-20160128_se           Rds
## 41 BRCA_Methylation_methyl450-20160128_assays        H5File
## 42     BRCA_Methylation_methyl450-20160128_se           Rds
## 43                 BRCA_miRNASeqGene-20160128           Rda
## 44                    BRCA_mRNAArray-20160128           Rda
## 45                     BRCA_Mutation-20160128           Rda
## 46              BRCA_RNASeq2GeneNorm-20160128           Rda
## 47                   BRCA_RNASeqGene-20160128           Rda
## 48                    BRCA_RPPAArray-20160128           Rda
```

In this call we fetch only the gene expression, proteomic and methylation data; setting `dry.run=FALSE` initiates the fetching of the data.

```
brca <- suppressMessages(
   curatedTCGAData("BRCA",
               c("mRNAArray","RPPA*","Methylation_methyl27*"),
    dry.run=FALSE))
```

This next code block prepares the TCGA data. In practice you would do this once, and save the data before running netDx, but we run it here to see an end-to-end example.

```
# prepare clinical variable - stage
staget <- sub("[abcd]","",sub("t","",colData(brca)$pathology_T_stage))
staget <- suppressWarnings(as.integer(staget))
colData(brca)$STAGE <- staget

# exclude normal, HER2 (small num samples)
pam50 <- colData(brca)$PAM50.mRNA
idx <- union(which(pam50 %in% c("Normal-like","HER2-enriched")),
    which(is.na(staget)))
idx <- union(idx, which(is.na(pam50)))
pID <- colData(brca)$patientID
tokeep <- setdiff(pID, pID[idx])
brca <- brca[,tokeep,]

pam50 <- colData(brca)$PAM50.mRNA
colData(brca)$pam_mod <- pam50

# remove duplicate names
smp <- sampleMap(brca)
for (nm in names(brca)) {
    samps <- smp[which(smp$assay==nm),]
    notdup <- samps[which(!duplicated(samps$primary)),"colname"]
    brca[[nm]] <- suppressMessages(brca[[nm]][,notdup])
}
```

```
## harmonizing input:
##   removing 59 sampleMap rows with 'colname' not in colnames of experiments
```

```
## harmonizing input:
##   removing 19 sampleMap rows with 'colname' not in colnames of experiments
```

```
## harmonizing input:
##   removing 26 sampleMap rows with 'colname' not in colnames of experiments
```

The important thing is to create `ID` and `STATUS` columns in the sample metadata slot. netDx uses these to get the patient identifiers and labels, respectively.

```
pID <- colData(brca)$patientID
colData(brca)$ID <- pID
colData(brca)$STATUS <- gsub(" ","_",colData(brca)$pam_mod)
```

# Rules to create features (patient similarity networks)

Our plan is to group gene expression data by pathways and clinical data by single variables. We will treat methylation and proteomic data each as a single feature, so each of those groups will contain the entire input table for those corresponding data types.

In the code below, we fetch pathway definitions for January 2018 from (<http://download.baderlab.org/EM_Genesets>) and group gene expression data by pathways. To keep the example short, we limit to only three pathways, but in practice you would use all pathways meeting a size criterion; e.g. those containing between 10 and 500 genes.

Grouping rules are accordingly created for the clinical, methylation and proteomic data.

```
groupList <- list()

# genes in mRNA data are grouped by pathways
pathList <- readPathways(fetchPathwayDefinitions("January",2018))
```

```
## ---------------------------------------
```

```
## Fetching http://download.baderlab.org/EM_Genesets/January_01_2018/Human/symbol/Human_AllPathways_January_01_2018_symbol.gmt
```

```
## File: 31d166b24893_Human_AllPathways_January_01_2018_symbol.gmt
```

```
## Read 3028 pathways in total, internal list has 3009 entries
```

```
##  FILTER: sets with num genes in [10, 200]
```

```
##    => 971 pathways excluded
##    => 2038 left
```

```
groupList[["BRCA_mRNAArray-20160128"]] <- pathList[1:3]
# clinical data is not grouped; each variable is its own feature
groupList[["clinical"]] <- list(
      age="patient.age_at_initial_pathologic_diagnosis",
       stage="STAGE"
)
# for methylation generate one feature containing all probes
# same for proteomics data
tmp <- list(rownames(experiments(brca)[[2]]));
names(tmp) <- names(brca)[2]
groupList[[names(brca)[2]]] <- tmp

tmp <- list(rownames(experiments(brca)[[3]]));
names(tmp) <- names(brca)[3]
groupList[[names(brca)[3]]] <- tmp
```

## Define patient similarity for each network

We provide `netDx` with a custom function to generate similarity networks (i.e. features). The first block tells netDx to generate correlation-based networks using everything but the clinical data. This is achieved by the call:

```
makePSN_NamedMatrix(..., writeProfiles=TRUE,...)`
```

The second block makes a different call to `makePSN_NamedMatrix()` but this time, requesting the use of the normalized difference similarity metric. This is achieved by calling:

```
   makePSN_NamedMatrix(,...,
                       simMetric="custom", customFunc=normDiff,
                       writeProfiles=FALSE)
```

`normDiff` is a function provided in the `netDx` package, but the user may define custom similarity functions in this block of code and pass those to `makePSN_NamedMatrix()`, using the `customFunc` parameter.

```
makeNets <- function(dataList, groupList, netDir,...) {
    netList <- c() # initialize before is.null() check
    # correlation-based similarity for mRNA, RPPA and methylation data
    # (Pearson correlation)
    for (nm in setdiff(names(groupList),"clinical")) {
       # NOTE: the check for is.null() is important!
        if (!is.null(groupList[[nm]])) {
        netList <- makePSN_NamedMatrix(dataList[[nm]],
                     rownames(dataList[[nm]]),
                   groupList[[nm]],netDir,verbose=FALSE,
                     writeProfiles=TRUE,...)
        }
    }

    # make clinical nets (normalized difference)
    netList2 <- c()
    if (!is.null(groupList[["clinical"]])) {
    netList2 <- makePSN_NamedMatrix(dataList$clinical,
        rownames(dataList$clinical),
        groupList[["clinical"]],netDir,
        simMetric="custom",customFunc=normDiff, # custom function
        writeProfiles=FALSE,
        sparsify=TRUE,verbose=TRUE,...)
    }
    netList <- c(unlist(netList),unlist(netList2))
    return(netList)
}
```

# Build predictor

Finally we make the call to build the predictor.

```
set.seed(42) # make results reproducible

# location for intermediate work
# set keepAllData to TRUE to not delete at the end of the
# predictor run.
# This can be useful for debugging.
outDir <- paste(tempdir(),"pred_output",sep=getFileSep()) # use absolute path
numSplits <- 2L
out <- suppressMessages(
   buildPredictor(dataList=brca,groupList=groupList,
      makeNetFunc=makeNets,
      outDir=outDir, ## netDx requires absolute path
      numSplits=numSplits, featScoreMax=2L, featSelCutoff=1L,
       numCores=1L)
)
```

```
## function(dataList, groupList, netDir,...) {
##  netList <- c() # initialize before is.null() check
##  # correlation-based similarity for mRNA, RPPA and methylation data
##  # (Pearson correlation)
##  for (nm in setdiff(names(groupList),"clinical")) {
##     # NOTE: the check for is.null() is important!
##      if (!is.null(groupList[[nm]])) {
##      netList <- makePSN_NamedMatrix(dataList[[nm]],
##                   rownames(dataList[[nm]]),
##                    groupList[[nm]],netDir,verbose=FALSE,
##                   writeProfiles=TRUE,...)
##      }
##  }
##
##  # make clinical nets (normalized difference)
##  netList2 <- c()
##  if (!is.null(groupList[["clinical"]])) {
##  netList2 <- makePSN_NamedMatrix(dataList$clinical,
##      rownames(dataList$clinical),
##      groupList[["clinical"]],netDir,
##      simMetric="custom",customFunc=normDiff, # custom function
##      writeProfiles=FALSE,
##      sparsify=TRUE,verbose=TRUE,...)
##  }
##  netList <- c(unlist(netList),unlist(netList2))
##  return(netList)
## }
##             IS_TRAIN
## STATUS       TRAIN TEST
##   Basal-like    77   20
##   Luminal_A    184   46
##   Luminal_B    101   26
##
## Luminal_A   nonpred      <NA>
##       184       178         0
##
## Basal-like    nonpred       <NA>
##         77        285          0
##
## Luminal_B   nonpred      <NA>
##       101       261         0
##             IS_TRAIN
## STATUS       TRAIN TEST
##   Basal-like    77   20
##   Luminal_A    184   46
##   Luminal_B    101   26
##
## Luminal_A   nonpred      <NA>
##       184       178         0
##
## Basal-like    nonpred       <NA>
##         77        285          0
##
## Luminal_B   nonpred      <NA>
##       101       261         0
```

# Examine output

The results are stored in the list object returned by the `buildPredictor()` call.
This list contains:

* `inputNets`: all input networks that the model started with.
* `Split<i>`: a list with results for each train-test split
  + `featureScores`: feature scores for each label (list with `g` entries, where `g` is number of patient labels). Each entry contains the feature selection scores for the corresponding label.
  + `featureSelected`: vector of features that pass feature selection. List of length `g`, with one entry per label.
  + `predictions`: real and predicted labels for test patients
  + `accuracy`: percent accuracy of predictions

```
summary(out)
```

```
##           Length Class  Mode
## inputNets 14     -none- character
## Split1     4     -none- list
## Split2     4     -none- list
```

```
summary(out$Split1)
```

```
##                 Length Class      Mode
## featureScores      3   -none-     list
## featureSelected    3   -none-     list
## predictions     2693   data.frame list
## accuracy           1   -none-     numeric
```

Compute accuracy for three-way classificationL

```
# Average accuracy
st <- unique(colData(brca)$STATUS)
acc <- matrix(NA,ncol=length(st),nrow=numSplits)
colnames(acc) <- st
for (k in 1:numSplits) {
    pred <- out[[sprintf("Split%i",k)]][["predictions"]];
    tmp <- pred[,c("ID","STATUS","TT_STATUS","PRED_CLASS",
                     sprintf("%s_SCORE",st))]
    for (m in 1:length(st)) {
       tmp2 <- subset(tmp, STATUS==st[m])
       acc[k,m] <- sum(tmp2$PRED==tmp2$STATUS)/nrow(tmp2)
    }
}
print(round(acc*100,2))
```

```
##      Luminal_A Basal-like Luminal_B
## [1,]     46.43        100     35.71
## [2,]     44.83        100     55.00
```

Also, examine the confusion matrix. We can see that the model perfectly classifies basal tumours, but performs poorly in distinguishing between the two types of luminal tumours.

```
res <- out$Split1$predictions
print(table(res[,c("STATUS","PRED_CLASS")]))
```

```
##             PRED_CLASS
## STATUS       Basal-like Luminal_A Luminal_B
##   Basal-like         14         0         0
##   Luminal_A           5        13        10
##   Luminal_B           4         5         5
```

# sessionInfo

```
sessionInfo()
```

```
## R version 4.0.3 (2020-10-10)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.4 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.11-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.11-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=C                 LC_NUMERIC=C
##  [3] LC_TIME=C                  LC_COLLATE=C
##  [5] LC_MONETARY=C              LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats4    parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] rhdf5_2.32.4                BiocFileCache_1.12.1
##  [3] dbplyr_1.4.4                curatedTCGAData_1.10.1
##  [5] MultiAssayExperiment_1.14.0 SummarizedExperiment_1.18.2
##  [7] DelayedArray_0.14.1         matrixStats_0.57.0
##  [9] GenomicRanges_1.40.0        GenomeInfoDb_1.24.2
## [11] IRanges_2.22.2              S4Vectors_0.26.1
## [13] netDx_1.0.4                 bigmemory_4.5.36
## [15] Biobase_2.48.0              BiocGenerics_0.34.0
##
## loaded via a namespace (and not attached):
##   [1] uuid_0.1-4                    AnnotationHub_2.20.2
##   [3] NMF_0.23.0                    plyr_1.8.6
##   [5] igraph_1.2.6                  RCy3_2.8.1
##   [7] lazyeval_0.2.2                splines_4.0.3
##   [9] entropy_1.2.1                 BiocParallel_1.22.0
##  [11] rncl_0.8.4                    ggplot2_3.3.2
##  [13] gridBase_0.4-7                scater_1.16.2
##  [15] digest_0.6.25                 htmltools_0.5.0
##  [17] foreach_1.5.0                 viridis_0.5.1
##  [19] magrittr_1.5                  memoise_1.1.0
##  [21] cluster_2.1.0                 doParallel_1.0.15
##  [23] ROCR_1.0-11                   limma_3.44.3
##  [25] annotate_1.66.0               R.utils_2.10.1
##  [27] prettyunits_1.1.1             colorspace_1.4-1
##  [29] blob_1.2.1                    rappdirs_0.3.1
##  [31] xfun_0.18                     dplyr_1.0.2
##  [33] crayon_1.3.4                  RCurl_1.98-1.2
##  [35] bigmemory.sri_0.1.3           graph_1.66.0
##  [37] genefilter_1.70.0             phylobase_0.8.10
##  [39] survival_3.2-7                iterators_1.0.12
##  [41] ape_5.4-1                     glue_1.4.2
##  [43] registry_0.5-1                gtable_0.3.0
##  [45] zlibbioc_1.34.0               XVector_0.28.0
##  [47] BiocSingular_1.4.0            kernlab_0.9-29
##  [49] Rhdf5lib_1.10.1               shape_1.4.5
##  [51] SingleCellExperiment_1.10.1   HDF5Array_1.16.1
##  [53] scales_1.1.1                  DBI_1.1.0
##  [55] edgeR_3.30.3                  rngtools_1.5
##  [57] bibtex_0.4.2.3                Rcpp_1.0.5
##  [59] viridisLite_0.3.0             xtable_1.8-4
##  [61] progress_1.2.2                bit_4.0.4
##  [63] rsvd_1.0.3                    glmnet_4.0-2
##  [65] httr_1.4.2                    netSmooth_1.8.0
##  [67] RColorBrewer_1.1-2            ellipsis_0.3.1
##  [69] farver_2.0.3                  pkgconfig_2.0.3
##  [71] XML_3.99-0.5                  R.methodsS3_1.8.1
##  [73] locfit_1.5-9.4                RJSONIO_1.3-1.4
##  [75] labeling_0.3                  later_1.1.0.1
##  [77] howmany_0.3-1                 tidyselect_1.1.0
##  [79] rlang_0.4.8                   softImpute_1.4
##  [81] reshape2_1.4.4                AnnotationDbi_1.50.3
##  [83] BiocVersion_3.11.1            munsell_0.5.0
##  [85] tools_4.0.3                   ExperimentHub_1.14.2
##  [87] generics_0.0.2                RSQLite_2.2.1
##  [89] ade4_1.7-15                   fastmap_1.0.1
##  [91] evaluate_0.14                 stringr_1.4.0
##  [93] yaml_2.2.1                    knitr_1.30
##  [95] bit64_4.0.5                   purrr_0.3.4
##  [97] nlme_3.1-149                  mime_0.9
##  [99] R.oo_1.24.0                   pracma_2.2.9
## [101] xml2_1.3.2                    compiler_4.0.3
## [103] interactiveDisplayBase_1.26.3 beeswarm_0.2.3
## [105] curl_4.3                      tibble_3.0.4
## [107] RNeXML_2.4.5                  stringi_1.5.3
## [109] highr_0.8                     RSpectra_0.16-0
## [111] lattice_0.20-41               Matrix_1.2-18
## [113] markdown_1.1                  vctrs_0.3.4
## [115] pillar_1.4.6                  lifecycle_0.2.0
## [117] BiocManager_1.30.10           combinat_0.0-8
## [119] zinbwave_1.10.1               BiocNeighbors_1.6.0
## [121] data.table_1.13.0             bitops_1.0-6
## [123] irlba_2.3.3                   httpuv_1.5.4
## [125] R6_2.4.1                      promises_1.1.1
## [127] gridExtra_2.3                 vipor_0.4.5
## [129] codetools_0.2-16              MASS_7.3-53
## [131] assertthat_0.2.1              pkgmaker_0.31.1
## [133] withr_2.3.0                   GenomeInfoDbData_1.2.3
## [135] locfdr_1.1-8                  hms_0.5.3
## [137] grid_4.0.3                    tidyr_1.1.2
## [139] DelayedMatrixStats_1.10.1     Rtsne_0.15
## [141] shiny_1.5.0                   clusterExperiment_2.8.0
## [143] ggbeeswarm_0.6.0
```