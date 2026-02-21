# Code example from 'IntroToCOCOA' vignette. See references/ for full tutorial.

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
library(COCOA)
data("esr1_chr1")
data("gata3_chr1")
data("nrf1_chr1")
data("atf3_chr1")
data("brcaMCoord1")
data("brcaMethylData1")
data("brcaMetadata")

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
myPhen <- "ER_status"
targetVarDF <- brcaMetadata[colnames(brcaMethylData1), myPhen, drop=FALSE]

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
targetVarDF$ER_status <- scale(as.numeric(targetVarDF$ER_status), 
                               center=TRUE, scale=FALSE)
methylCor <- cor(t(brcaMethylData1), targetVarDF$ER_status, 
                 use = "pairwise.complete.obs")
# if the standard deviation of the methylation level 
# for a CpG across samples is 0,
# cor() will return NA, so manually set the correlation to 0 for these CpGs
methylCor[is.na(methylCor)] <- 0
colnames(methylCor) <- myPhen

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
GRList <- GRangesList(esr1_chr1, gata3_chr1, atf3_chr1, nrf1_chr1)
regionSetNames <- c("ESR1", "GATA3", "ATF3", "NRF1")
rsScores <- aggregateSignalGRList(signal=methylCor,
                     signalCoord=brcaMCoord1,
                     GRList=GRList,
                     signalCol=myPhen,
                     scoringMetric="default",
                     absVal=TRUE)
rsScores$regionSetName <- regionSetNames
rsScores

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
set.seed(100)

nPerm <- 5
permRSScores <- list()

for (i in 1:nPerm) {
    # shuffling sample labels
    sampleOrder <- sample(1:nrow(targetVarDF), nrow(targetVarDF))
    permRSScores[[i]] <- runCOCOA(sampleOrder=sampleOrder, 
                           genomicSignal=brcaMethylData1, 
                           signalCoord=brcaMCoord1, 
                           GRList=GRList,
                           signalCol=myPhen, 
                           targetVar=targetVarDF, 
                           variationMetric="cor")
    permRSScores[[i]]$regionSetName <- regionSetNames
}

permRSScores[1:3]

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
nullDistList <- convertToFromNullDist(permRSScores)
names(nullDistList) <- regionSetNames
nullDistList

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
# p-values based on fitted gamma distributions
gPValDF <- getGammaPVal(rsScores = rsScores, 
                        nullDistList = nullDistList, 
                        signalCol = myPhen, 
                        method = "mme", realScoreInDist = TRUE)
gPValDF <- cbind(gPValDF, 
                 rsScores[, colnames(rsScores)[!(colnames(rsScores) 
                                                 %in% myPhen)]])
gPValDF <- cbind(gPValDF, regionSetNames)
gPValDF

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
getPermStat(rsScores = rsScores, 
            nullDistList = nullDistList, 
            signalCol = myPhen)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
library(COCOA)
library(data.table)
library(ggplot2)
data("esr1_chr1")
data("gata3_chr1")
data("nrf1_chr1")
data("atf3_chr1")
data("brcaMCoord1")
data("brcaMethylData1")
data("brcaMetadata")

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
pca <- prcomp(t(brcaMethylData1))
pcScores <- pca$x

plot(pcScores[, c("PC1", "PC2")])

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
PCsToAnnotate <- paste0("PC", 1:4)
targetVar <- pcScores[, PCsToAnnotate]
targetVar <- as.matrix(scale(targetVar, 
                               center=TRUE, scale=FALSE))
methylCor <- cor(t(brcaMethylData1), targetVar, 
                 use = "pairwise.complete.obs")
# if the standard deviation of the methylation level 
# for a CpG across samples is 0,
# cor() will return NA, so manually set the correlation to 0 for these CpGs
methylCor[is.na(methylCor)] <- 0

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
# prepare data
GRList <- GRangesList(esr1_chr1, gata3_chr1, nrf1_chr1, atf3_chr1) 
regionSetNames <- c("esr1_chr1", "gata3_chr1", "nrf1_chr1", "atf3_chr1")

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
regionSetScores <- aggregateSignalGRList(signal=methylCor, 
                            signalCoord=brcaMCoord1, 
                            GRList=GRList, 
                            signalCol=PCsToAnnotate, 
                            scoringMetric="default")
regionSetScores$regionSetName <- regionSetNames
regionSetScores

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
annoPCScores <- data.frame(pcScores, ER_status=as.factor(brcaMetadata[row.names(pcScores), "ER_status"]))
ggplot(data = annoPCScores, mapping = aes(x=PC1, y=PC2, col=ER_status)) + geom_point() + ggtitle("PCA of a subset of DNA methylation data from breast cancer patients") + theme_classic()

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
plotAnnoScoreDist(rsScores = regionSetScores, 
                  colToPlot = "PC1", 
                  pattern = "GATA3|ESR1", 
                  patternName = "ER-related", 
                  rsNameCol = "regionSetName", 
                  alpha=1)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
rsScoreHeatmap(regionSetScores, 
               signalCol=paste0("PC", 1:4), 
               rsNameCol = "regionSetName",
               orderByCol = "PC1", 
               column_title = "Region sets ordered by score for PC1")

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
rsScoreHeatmap(regionSetScores, 
               signalCol=paste0("PC", 1:4),
               rsNameCol = "regionSetName",
               orderByCol = "PC2", 
               column_title = "Region sets ordered by score for PC2")

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
set.seed(100)

nPerm <- 5
permRSScores <- list()

for (i in 1:nPerm) {
    # shuffling sample labels
    sampleOrder <- sample(1:nrow(targetVar), nrow(targetVar))
    permRSScores[[i]] <- runCOCOA(sampleOrder=sampleOrder, 
                           genomicSignal=brcaMethylData1, 
                           signalCoord=brcaMCoord1, 
                           GRList=GRList,
                           signalCol=PCsToAnnotate, 
                           targetVar=targetVar, 
                           variationMetric="cor")
    permRSScores[[i]]$regionSetName <- regionSetNames
}

permRSScores[1:3]

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
nullDistList <- convertToFromNullDist(permRSScores)
names(nullDistList) <- regionSetNames
nullDistList

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
# p-values based on fitted gamma distributions
gPValDF <- getGammaPVal(rsScores = regionSetScores, 
                        nullDistList = nullDistList, 
                        signalCol = PCsToAnnotate, 
                        method = "mme", realScoreInDist = TRUE)
gPValDF <- cbind(gPValDF, 
                 regionSetScores[, colnames(regionSetScores)[!(colnames(regionSetScores) 
                                                 %in% PCsToAnnotate)]])
gPValDF <- cbind(gPValDF, regionSetNames)
gPValDF

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
getPermStat(rsScores = regionSetScores, 
            nullDistList = nullDistList, 
            signalCol = PCsToAnnotate)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
wideGRList <- lapply(GRList, resize, width=14000, fix="center")
fcsProfile <- lapply(wideGRList, function(x) getMetaRegionProfile(signal=methylCor,
                                                                signalCoord=brcaMCoord1,
                                                                regionSet=x, 
                                                                signalCol=PCsToAnnotate,
                                                                binNum=21))

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
# average FCS from each PC to normalize so PCs can be compared with each other
avFCS <- apply(X=methylCor[, PCsToAnnotate], 
                MARGIN=2, 
                FUN=function(x) mean(abs(x)))

# normalize
fcsProfile <- lapply(fcsProfile, 
                      FUN=function(x) as.data.frame(mapply(FUN = function(y, z) x[, y] - z, 
                                                           y=PCsToAnnotate, z=avFCS)))
binID = 1:nrow(fcsProfile[[1]])
fcsProfile <- lapply(fcsProfile, FUN=function(x) cbind(binID, x))

# for the plot scale
maxVal <- max(sapply(fcsProfile, FUN=function(x) max(x[, PCsToAnnotate])))
minVal <- min(sapply(fcsProfile, FUN=function(x) min(x[, PCsToAnnotate])))

# convert to long format for plots
fcsProfile <- lapply(X=fcsProfile, FUN=function(x) tidyr::gather(data=x, key="PC", value="meanFCS", PCsToAnnotate))
fcsProfile <- lapply(fcsProfile, 
                      function(x){x$PC <- factor(x$PC, levels=PCsToAnnotate); return(x)})

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
wrapper <- function(x, ...) paste(strwrap(x, ...), collapse="\n") 
profilePList <- list()
for (i in seq_along(fcsProfile)) {
    
    thisRS <- fcsProfile[[i]]
    
    profilePList[[i]] <- ggplot(data=thisRS, 
                                mapping=aes(x=binID , y=meanFCS)) + 
        geom_line() + ylim(c(minVal, maxVal)) + facet_wrap(facets="PC") + 
        ggtitle(label=wrapper(regionSetNames[i], width=30)) + 
        xlab("Genome around region set, 14 kb") + 
        ylab("Normalized mean FCS") + 
        theme(panel.grid.major.x=element_blank(), 
              panel.grid.minor.x=element_blank(), 
              axis.text.x=element_blank(), 
              axis.ticks.x=element_blank())
    profilePList[[i]]

}
profilePList[[1]]
profilePList[[2]]
profilePList[[3]]
profilePList[[4]]

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
signalAlongAxis(genomicSignal=brcaMethylData1,
                signalCoord=brcaMCoord1,
                regionSet=esr1_chr1,
                sampleScores=pcScores,
                topXVariables = 100,
                variableScores = abs(methylCor[, "PC1"]),
                orderByCol="PC1", cluster_columns=TRUE,
                column_title = "Individual cytosine/CpG",
                name = "DNA methylation level",
                show_row_names=FALSE)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
signalAlongAxis(genomicSignal=brcaMethylData1,
              signalCoord=brcaMCoord1,
              regionSet=nrf1_chr1,
              sampleScores=pcScores,
              topXVariables = 100,
              variableScores = abs(methylCor[, "PC1"]),
              orderByCol="PC1", 
              cluster_columns=TRUE, 
              column_title = "Individual cytosine/CpG",
              name = "DNA methylation level",
              show_row_names=FALSE)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
regionQuantileByTargetVar(signal = methylCor,
                                signalCoord = brcaMCoord1,
                                regionSet = esr1_chr1,
                                rsName = "Estrogen receptor (chr1)",
                                signalCol=paste0("PC", 1:4),
                                maxRegionsToPlot = 8000,
                                cluster_rows = TRUE,
                                cluster_columns = FALSE,
                                column_title = rsName,
                                name = "Percentile of feature contribution scores in PC")

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
regionQuantileByTargetVar(signal = methylCor,
                                signalCoord = brcaMCoord1,
                                regionSet = nrf1_chr1,
                                rsName = "NRF1 (chr1)",
                                signalCol=paste0("PC", 1:4),
                                maxRegionsToPlot = 8000,
                                cluster_rows = TRUE,
                                cluster_columns = FALSE,
                                column_title = rsName,
                                name = "Percentile of feature contribution scores in PC")

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
library(COCOA)
data("esr1_chr1")
data("gata3_chr1")
data("nrf1_chr1")
data("atf3_chr1")
data("brcaATACCoord1")
data("brcaATACData1")
data("brcaMetadata")

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
myPhen <- "ER_status"
targetVarDF <- brcaMetadata[colnames(brcaATACData1), myPhen, drop=FALSE]

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
targetVarDF$ER_status <- scale(as.numeric(targetVarDF$ER_status), 
                               center=TRUE, scale=FALSE)
atacCor <- cor(t(brcaATACData1), targetVarDF$ER_status, 
                 use = "pairwise.complete.obs")
# if the standard deviation of the epigenetic signal
# for a peak region across samples is 0,
# cor() will return NA, so manually set the correlation to 0 for these regions
atacCor[is.na(atacCor)] <- 0
colnames(atacCor) <- myPhen

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
GRList <- GRangesList(esr1_chr1, gata3_chr1, atf3_chr1, nrf1_chr1)
regionSetNames <- c("ESR1", "GATA3", "ATF3", "NRF1")
rsScores <- aggregateSignalGRList(signal=atacCor,
                     signalCoord=brcaATACCoord1,
                     GRList=GRList,
                     signalCol=myPhen,
                     scoringMetric="default",
                     absVal=TRUE)
rsScores$regionSetName <- regionSetNames
rsScores

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
set.seed(100)

nPerm <- 5
permRSScores <- list()

for (i in 1:nPerm) {
    # shuffling sample labels
    sampleOrder <- sample(1:nrow(targetVarDF), nrow(targetVarDF))
    permRSScores[[i]] <- runCOCOA(sampleOrder=sampleOrder, 
                           genomicSignal=brcaATACData1, 
                           signalCoord=brcaATACCoord1, 
                           GRList=GRList,
                           signalCol=myPhen, 
                           targetVar=targetVarDF, 
                           variationMetric="cor")
    permRSScores[[i]]$regionSetName <- regionSetNames
}

permRSScores[1:3]

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
nullDistList <- convertToFromNullDist(permRSScores)
names(nullDistList) <- regionSetNames
nullDistList

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
# p-values based on fitted gamma distributions
gPValDF <- getGammaPVal(rsScores = rsScores, 
                        nullDistList = nullDistList, 
                        signalCol = myPhen, 
                        method = "mme", realScoreInDist = TRUE)
gPValDF <- cbind(gPValDF, 
                 rsScores[, colnames(rsScores)[!(colnames(rsScores) 
                                                 %in% myPhen)]])
gPValDF <- cbind(gPValDF, regionSetNames)
gPValDF

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
getPermStat(rsScores = rsScores, 
            nullDistList = nullDistList, 
            signalCol = myPhen)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
library(COCOA)
library(data.table)
library(ggplot2)
data("esr1_chr1")
data("gata3_chr1")
data("nrf1_chr1")
data("atf3_chr1")
data("brcaATACCoord1")
data("brcaATACData1")

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
pca <- prcomp(t(brcaATACData1))
pcScores <- pca$x

plot(pcScores[, c("PC1", "PC2")])

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
PCsToAnnotate <- paste0("PC", 1:4)
targetVar <- pcScores[, PCsToAnnotate]
targetVar <- as.matrix(scale(targetVar, 
                               center=TRUE, scale=FALSE))
atacCor <- cor(t(brcaATACData1), targetVar, 
                 use = "pairwise.complete.obs")
# if the standard deviation of the ATAC-seq counts 
# for a peak region across samples is 0,
# cor() will return NA, so manually set the correlation to 0 for these regions
atacCor[is.na(atacCor)] <- 0

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
# prepare data
GRList <- GRangesList(esr1_chr1, gata3_chr1, nrf1_chr1, atf3_chr1) 
regionSetNames <- c("esr1_chr1", "gata3_chr1", "nrf1_chr1", "atf3_chr1")

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
regionSetScores <- aggregateSignalGRList(signal=atacCor, 
                            signalCoord=brcaATACCoord1, 
                            GRList=GRList, 
                            signalCol=PCsToAnnotate, 
                            scoringMetric="default")
regionSetScores$regionSetName <- regionSetNames
regionSetScores

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
annoPCScores <- data.frame(pcScores, ER_status=as.factor(brcaMetadata[row.names(pcScores), "ER_status"]))
ggplot(data = annoPCScores, mapping = aes(x=PC1, y=PC2, col=ER_status)) + geom_point() + ggtitle("PCA of a subset of chromatin accessibility data from breast cancer patients") + theme_classic()

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
plotAnnoScoreDist(rsScores = regionSetScores, 
                  colToPlot = "PC1", 
                  pattern = "GATA3|ESR1", 
                  patternName = "ER-related", 
                  rsNameCol = "regionSetName", 
                  alpha=1)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
rsScoreHeatmap(regionSetScores, 
               signalCol=paste0("PC", 1:4), 
               rsNameCol = "regionSetName",
               orderByCol = "PC1", 
               column_title = "Region sets ordered by score for PC1")

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
rsScoreHeatmap(regionSetScores, 
               signalCol=paste0("PC", 1:4),
               rsNameCol = "regionSetName",
               orderByCol = "PC2", 
               column_title = "Region sets ordered by score for PC2")

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
set.seed(100)

nPerm <- 5
permRSScores <- list()

for (i in 1:nPerm) {
    # shuffling sample labels
    sampleOrder <- sample(1:nrow(targetVar), nrow(targetVar))
    permRSScores[[i]] <- runCOCOA(sampleOrder=sampleOrder, 
                           genomicSignal=brcaATACData1, 
                           signalCoord=brcaATACCoord1, 
                           GRList=GRList,
                           signalCol=PCsToAnnotate, 
                           targetVar=targetVar, 
                           variationMetric="cor")
    permRSScores[[i]]$regionSetName <- regionSetNames
}

permRSScores[1:3]

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
nullDistList <- convertToFromNullDist(permRSScores)
names(nullDistList) <- regionSetNames
nullDistList

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
# p-values based on fitted gamma distributions
gPValDF <- getGammaPVal(rsScores = regionSetScores, 
                        nullDistList = nullDistList, 
                        signalCol = PCsToAnnotate, 
                        method = "mme", realScoreInDist = TRUE)
gPValDF <- cbind(gPValDF, 
                 regionSetScores[, colnames(regionSetScores)[!(colnames(regionSetScores) 
                                                 %in% PCsToAnnotate)]])
gPValDF <- cbind(gPValDF, regionSetNames)
gPValDF

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
getPermStat(rsScores = regionSetScores, 
            nullDistList = nullDistList, 
            signalCol = PCsToAnnotate)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
wideGRList <- lapply(GRList, resize, width=14000, fix="center")
fcsProfile <- lapply(wideGRList, function(x) getMetaRegionProfile(signal=atacCor,
                                                                signalCoord=brcaATACCoord1,
                                                                regionSet=x, 
                                                                signalCol=PCsToAnnotate,
                                                                binNum=21))

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
# average FCS from each PC to normalize so PCs can be compared with each other
avFCS <- apply(X=atacCor[, PCsToAnnotate], 
                MARGIN=2, 
                FUN=function(x) mean(abs(x)))

# normalize
fcsProfile <- lapply(fcsProfile, 
                      FUN=function(x) as.data.frame(mapply(FUN = function(y, z) x[, y] - z, 
                                                           y=PCsToAnnotate, z=avFCS)))
binID = 1:nrow(fcsProfile[[1]])
fcsProfile <- lapply(fcsProfile, FUN=function(x) cbind(binID, x))

# for the plot scale
maxVal <- max(sapply(fcsProfile, FUN=function(x) max(x[, PCsToAnnotate])))
minVal <- min(sapply(fcsProfile, FUN=function(x) min(x[, PCsToAnnotate])))

# convert to long format for plots
fcsProfile <- lapply(X=fcsProfile, FUN=function(x) tidyr::gather(data=x, key="PC", value="meanFCS", PCsToAnnotate))
fcsProfile <- lapply(fcsProfile, 
                      function(x){x$PC <- factor(x$PC, levels=PCsToAnnotate); return(x)})

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
wrapper <- function(x, ...) paste(strwrap(x, ...), collapse="\n") 
profilePList <- list()
for (i in seq_along(fcsProfile)) {
    
    thisRS <- fcsProfile[[i]]
    
    profilePList[[i]] <- ggplot(data=thisRS, 
                                mapping=aes(x=binID , y=meanFCS)) + 
        geom_line() + ylim(c(minVal, maxVal)) + facet_wrap(facets="PC") + 
        ggtitle(label=wrapper(regionSetNames[i], width=30)) + 
        xlab("Genome around region set, 14 kb") + 
        ylab("Normalized mean FCS") + 
        theme(panel.grid.major.x=element_blank(), 
              panel.grid.minor.x=element_blank(), 
              axis.text.x=element_blank(), 
              axis.ticks.x=element_blank())
    profilePList[[i]]

}
profilePList[[1]]
profilePList[[2]]
profilePList[[3]]
profilePList[[4]]

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
signalAlongAxis(genomicSignal=brcaATACData1,
                signalCoord=brcaATACCoord1,
                regionSet=esr1_chr1,
                sampleScores=pcScores,
                orderByCol="PC1", cluster_columns=TRUE,
                column_title = "Individual ATAC-seq region",
                name = "Normalized signal in ATAC-seq regions",
                show_row_names=FALSE,
                show_column_names=FALSE)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
signalAlongAxis(genomicSignal=brcaATACData1,
              signalCoord=brcaATACCoord1,
              regionSet=nrf1_chr1,
              sampleScores=pcScores,
              orderByCol="PC1", 
              cluster_columns=TRUE, 
              column_title = "Individual ATAC-seq region",
              name = "Normalized signal in ATAC-seq regions",
              show_row_names=FALSE,
              show_column_names=FALSE)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
regionQuantileByTargetVar(signal = atacCor,
                                signalCoord = brcaATACCoord1,
                                regionSet = esr1_chr1,
                                rsName = "Estrogen receptor (chr1)",
                                signalCol=paste0("PC", 1:4),
                                maxRegionsToPlot = 8000,
                                cluster_rows = TRUE,
                                cluster_columns = FALSE,
                                column_title = rsName,
                                name = "Percentile of feature contribution scores in PC")

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
regionQuantileByTargetVar(signal = atacCor,
                                signalCoord = brcaATACCoord1,
                                regionSet = nrf1_chr1,
                                rsName = "NRF1 (chr1)",
                                signalCol=paste0("PC", 1:4),
                                maxRegionsToPlot = 8000,
                                cluster_rows = TRUE,
                                cluster_columns = FALSE,
                                column_title = rsName,
                                name = "Percentile of feature contribution scores in PC")

## ----eval=FALSE, message=FALSE, warning=FALSE---------------------------------
# library(LOLA)
# 
# # reading in the region sets
# # load LOLA database
# lolaPath <- paste0("path/to/LOLACore/genomeVersion/")
# regionSetDB <- loadRegionDB(lolaPath)
# 
# # metadata about the region sets
# loRegionAnno <- regionSetDB$regionAnno
# lolaCoreRegionAnno <- loRegionAnno
# collections <- c("cistrome_cistrome", "cistrome_epigenome", "codex",
#                 "encode_segmentation", "encode_tfbs", "ucsc_features")
# collectionInd <- lolaCoreRegionAnno$collection %in% collections
# lolaCoreRegionAnno <- lolaCoreRegionAnno[collectionInd, ]
# regionSetName <- lolaCoreRegionAnno$filename
# regionSetDescription <- lolaCoreRegionAnno$description
# 
# # the actual region sets
# GRList <- GRangesList(regionSetDB$regionGRL[collectionInd])
# 
# # since we have what we need, we can delete this to free up memory
# rm("regionSetDB")

