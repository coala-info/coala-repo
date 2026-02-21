# Code example from 'metaseqr2-statistics' vignette. See references/ for full tutorial.

## ----install-0, eval=FALSE, echo=TRUE-----------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("metaseqR2")

## ----load-library, echo=TRUE, eval=TRUE, message=FALSE, warning=FALSE---------
library(metaseqR2)

## ----seed-0, eval=TRUE, echo=TRUE---------------------------------------------
set.seed(42)

## ----data-1, eval=TRUE, echo=TRUE---------------------------------------------
data("mm9GeneData",package="metaseqR2")

## ----head-1, eval=TRUE, echo=TRUE---------------------------------------------
head(mm9GeneCounts)

## ----random-1, eval=TRUE, echo=TRUE-------------------------------------------
sampleListMm9

## ----random-2, eval=TRUE, echo=TRUE-------------------------------------------
libsizeListMm9

## ----example-1, eval=TRUE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
library(metaseqR2)

data("mm9GeneData",package="metaseqR2")

# You can explore the results in the session's temporary directory
print(tempdir())

result <- metaseqr2(
    counts=mm9GeneCounts,
    sampleList=sampleListMm9,
    contrast=c("adult_8_weeks_vs_e14.5"),
    libsizeList=libsizeListMm9,
    annotation="embedded",
    embedCols=list(
        idCol=4,
        gcCol=5,
        nameCol=8,
        btCol=7
    ),
    org="mm9",
    countType="gene",
    normalization="edger",
    statistics="edger",
    pcut=0.05,
    qcPlots=c(
        "mds","filtered","correl","pairwise","boxplot","gcbias",
        "lengthbias","meandiff","meanvar","deheatmap","volcano",
        "mastat"
    ),
    figFormat=c("png","pdf"),
    exportWhat=c("annotation","p_value","adj_p_value","fold_change"),
    exportScale=c("natural","log2"),
    exportValues="normalized",
    exportStats=c("mean","sd","cv"),
    exportWhere=file.path(tempdir(),"test1"),
    restrictCores=0.01,
    geneFilters=list(
         length=list(
                length=500
         ),
         avgReads=list(
                averagePerBp=100,
                quantile=0.25
         ),
         expression=list(
                median=TRUE,
                mean=FALSE,
                quantile=NA,
                known=NA,
                custom=NA
         ),
         biotype=getDefaults("biotypeFilter","mm9")
    ),
    outList=TRUE
)

## ----head-2, eval=TRUE, echo=TRUE---------------------------------------------
head(result[["data"]][["adult_8_weeks_vs_e14.5"]])

## ----example-2, eval=TRUE, echo=TRUE, tidy=FALSE, message=FALSE, warning=FALSE----
library(metaseqR2)

data("mm9GeneData",package="metaseqR2")

result <- metaseqr2(
    counts=mm9GeneCounts,
    sampleList=sampleListMm9,
    contrast=c("adult_8_weeks_vs_e14.5"),
    libsizeList=libsizeListMm9,
    annotation="embedded",
    embedCols=list(
        idCol=4,
        gcCol=5,
        nameCol=8,
        btCol=7
    ),
    org="mm9",
    countType="gene",
    whenApplyFilter="prenorm",
    normalization="edaseq",
    statistics=c("deseq","edger"),
    metaP="fisher",
    #qcPlots=c(
    #    "mds","biodetection","countsbio","saturation","readnoise","filtered",
    #    "correl","pairwise","boxplot","gcbias","lengthbias","meandiff",
    #    "meanvar","rnacomp","deheatmap","volcano","mastat","biodist","statvenn"
    #),
    qcPlots=c(
        "mds","filtered","correl","pairwise","boxplot","gcbias",
        "lengthbias","meandiff","meanvar","deheatmap","volcano",
        "mastat"
    ),
    restrictCores=0.01,
    figFormat=c("png","pdf"),
    preset="medium_normal",
    exportWhere=file.path(tempdir(),"test2"),
    outList=TRUE
)

## ----example-3, eval=TRUE, echo=TRUE, tidy=FALSE, message=FALSE, warning=FALSE----
library(metaseqR2)

data("mm9GeneData",package="metaseqR2")

result <- metaseqr2(
    counts=mm9GeneCounts,
    sampleList=sampleListMm9,
    contrast=c("adult_8_weeks_vs_e14.5"),
    libsizeList=libsizeListMm9,
    annotation="embedded",
    embedCols=list(
        idCol=4,
        gcCol=5,
        nameCol=8,
        btCol=7
    ),
    org="mm9",
    countType="gene",
    normalization="edaseq",
    statistics=c("deseq","edger"),
    metaP="fisher",
    qcPlots=c(
        "mds","filtered","correl","pairwise","boxplot","gcbias",
        "lengthbias","meandiff","meanvar","deheatmap","volcano",
        "mastat"
    ),
    restrictCores=0.01,
    figFormat=c("png","pdf"),
    preset="medium_normal",
    outList=TRUE,
    exportWhere=file.path(tempdir(),"test3")
)

## ----example-4, eval=FALSE, echo=TRUE, tidy=FALSE, message=FALSE, warning=FALSE----
# library(metaseqR2)
# 
# data("mm9GeneData",package="metaseqR2")
# 
# result <- metaseqr2(
#     counts=mm9GeneCounts,
#     sampleList=sampleListMm9,
#     contrast=c("adult_8_weeks_vs_e14.5"),
#     libsizeList=libsizeListMm9,
#     annotation="embedded",
#     embedCols=list(
#         idCol=4,
#         gcCol=5,
#         nameCol=8,
#         btCol=7
#     ),
#     org="mm9",
#     countType="gene",
#     normalization="edaseq",
#     statistics=c("edger","limma"),
#     metaP="fisher",
#     figFormat="png",
#     preset="medium_basic",
#     qcPlots=c(
#         "mds","filtered","correl","pairwise","boxplot","gcbias",
#         "lengthbias","meandiff","meanvar","deheatmap","volcano",
#         "mastat"
#     ),
#     restrictCores=0.01,
#     outList=TRUE,
#     exportWhere=file.path(tempdir(),"test4")
# )

## ----example-5, eval=TRUE, echo=TRUE, tidy=FALSE, message=FALSE, warning=FALSE----
data("mm9GeneData",package="metaseqR2")
weights <- estimateAufcWeights(
    counts=as.matrix(mm9GeneCounts[,9:12]),
    normalization="edaseq",
    statistics=c("edger","limma"),
    nsim=1,N=10,ndeg=c(2,2),top=4,modelOrg="mm10",
    rc=0.01,libsizeGt=1e+5
)

## ----head-3, eval=TRUE, echo=TRUE---------------------------------------------
weights

## ----example-6, eval=TRUE, echo=TRUE, tidy=FALSE, message=FALSE, warning=FALSE----
data("hg19pvalues",package="metaseqR2")

# Examine the data
head(hg19pvalues)

# Now combine the p-values using the Simes method
pSimes <- apply(hg19pvalues,1,combineSimes)

# The harmonic mean method with PANDORA weights
w <- getWeights("human")
pHarm <- apply(hg19pvalues,1,combineHarmonic,w)

# The PANDORA method
pPandora <- apply(hg19pvalues,1,combineWeight,w)

## ----help-2, eval=TRUE, echo=TRUE, message=FALSE------------------------------
help(statEdger)

## ----si-1, eval=TRUE, echo=TRUE-----------------------------------------------
sessionInfo()

