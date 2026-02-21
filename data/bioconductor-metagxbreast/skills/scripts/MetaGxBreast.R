# Code example from 'MetaGxBreast' vignette. See references/ for full tutorial.

### R code from vignette source 'MetaGxBreast.Rnw'

###################################################
### code chunk number 1: setup (eval = FALSE)
###################################################
## options(keep.source=TRUE, width = 50)


###################################################
### code chunk number 2: install-pkg (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly = TRUE))
##     install.packages("BiocManager")
## BiocManager::install("MetaGxBreast")


###################################################
### code chunk number 3: loadlib
###################################################
library(MetaGxBreast)
esets <- MetaGxBreast::loadBreastEsets(loadString = c("CAL", "DFHCC", "DFHCC2",
    "DFHCC3", "DUKE", "DUKE2", "EMC2"))[[1]]


###################################################
### code chunk number 4: sampleNumber-summary
###################################################
library(Biobase)
numSamples <- vapply(seq_along(esets), FUN=function(i, esets){
  length(sampleNames(esets[[i]]))
  }, numeric(1), esets=esets)


SampleNumberSummaryAll <- data.frame(NumberOfSamples = numSamples,
                                     row.names = names(esets))
total <- sum(SampleNumberSummaryAll[,"NumberOfSamples"])
SampleNumberSummaryAll <- rbind(SampleNumberSummaryAll, total)
rownames(SampleNumberSummaryAll)[nrow(SampleNumberSummaryAll)] <- "Total"

require(xtable)
print(xtable(SampleNumberSummaryAll,digits = 2), floating = FALSE)


###################################################
### code chunk number 5: sampleNumberSummariesPdata
###################################################
#pData Variables
pDataID <- c("er","pgr", "her2", "age_at_initial_pathologic_diagnosis",
             "grade", "dmfs_days", "dmfs_status", "days_to_tumor_recurrence",
             "recurrence_status", "days_to_death", "vital_status",
             "sample_type", "treatment")


pDataPercentSummaryTable <- NULL
pDataSummaryNumbersTable <- NULL

pDataSummaryNumbersList <- lapply(esets, function(x)
  vapply(pDataID, function(y) sum(!is.na(pData(x)[,y])), numeric(1)))

pDataPercentSummaryList <- lapply(esets, function(x)
  vapply(pDataID, function(y)
    sum(!is.na(pData(x)[,y]))/nrow(pData(x)), numeric(1))*100)

pDataSummaryNumbersTable <- sapply(pDataSummaryNumbersList, function(x) x)
pDataPercentSummaryTable <- sapply(pDataPercentSummaryList, function(x) x)

rownames(pDataSummaryNumbersTable) <- pDataID
rownames(pDataPercentSummaryTable) <- pDataID
colnames(pDataSummaryNumbersTable) <- names(esets)
colnames(pDataPercentSummaryTable) <- names(esets)

pDataSummaryNumbersTable <- rbind(pDataSummaryNumbersTable, total)
rownames(pDataSummaryNumbersTable)[nrow(pDataSummaryNumbersTable)] <- "Total"


# Generate a heatmap representation of the pData
pDataPercentSummaryTable <- t(pDataPercentSummaryTable)
pDataPercentSummaryTable <- cbind(Name=(rownames(pDataPercentSummaryTable))
                                ,pDataPercentSummaryTable)

nba<-pDataPercentSummaryTable
gradient_colors <- c("#ffffff","#ffffd9","#edf8b1","#c7e9b4","#7fcdbb",
                    "#41b6c4","#1d91c0","#225ea8","#253494","#081d58")

library(lattice)
nbamat<-as.matrix(nba)
rownames(nbamat) <- nbamat[,1]
nbamat <- nbamat[,-1]
Interval <- as.numeric(c(10,20,30,40,50,60,70,80,90,100))

levelplot(nbamat,col.regions=gradient_colors,
          main="Available Clinical Annotation",
          scales=list(x=list(rot=90, cex=0.5),
                      y= list(cex=0.5),key=list(cex=0.2)),
          at=seq(from=0,to=100,length=10),
          cex=0.2, ylab="", xlab="", lattice.options=list(),
          colorkey=list(at=as.numeric(factor(c(seq(from=0, to=100, by=10)))),
                  labels=as.character(c( "0","10%","20%","30%", "40%","50%",
                                         "60%", "70%", "80%","90%", "100%"),
                                      cex=0.2,font=1,col="brown",height=1,
                                      width=1.4), col=(gradient_colors)))



###################################################
### code chunk number 6: sessionInfo
###################################################
toLatex(sessionInfo())


