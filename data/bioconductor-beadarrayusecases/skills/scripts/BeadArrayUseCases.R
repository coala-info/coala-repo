# Code example from 'BeadArrayUseCases' vignette. See references/ for full tutorial.

### R code from vignette source 'BeadArrayUseCases.rnw'

###################################################
### code chunk number 1: setWidth
###################################################
options(width=70);


###################################################
### code chunk number 2: install (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install(c("beadarray","limma","GEOquery", "illuminaHumanv1.db",
##               "illuminaHumanv2.db", "illuminaHumanv3.db", "BeadArrayUseCases"))


###################################################
### code chunk number 3: optionalInstall (eval = FALSE)
###################################################
## 
## BiocManager::install(c("GOstats", "GenomicRanges", "Biostrings"))
## 


###################################################
### code chunk number 4: BeadArrayUseCases.rnw:126-131
###################################################
options(width=70)
library(beadarray)
library(GEOquery)
library(illuminaHumanv2.db)
library(illuminaHumanv1.db)


###################################################
### code chunk number 5: plotmetrics
###################################################
ht12metrics <- read.table(system.file("extdata/Chips/Metrics.txt",package = "BeadArrayUseCases"),sep="\t",header=TRUE,as.is=TRUE)


ht12snr <- ht12metrics$P95Grn/ht12metrics$P05Grn
labs <- paste(ht12metrics[,2], ht12metrics[,3], sep="_")


par(mai=c(1.5, 0.8,0.3,0.1))
plot(1:12, ht12snr, pch=19,ylab="P95 / P05",
        xlab="", main="Signal-to-noise ratio for HT12 data",
        axes=FALSE, frame.plot=TRUE)
axis(2)
axis(1, 1:12, labs, las=2)


###################################################
### code chunk number 6: Import
###################################################
library(beadarray)

chipPath <- system.file("extdata/Chips", package = "BeadArrayUseCases")
list.files(chipPath)
sampleSheetFile <- paste(chipPath, "/sampleSheet.csv",sep="")
readLines(sampleSheetFile)
data <- readIllumina(dir=chipPath, sampleSheet = sampleSheetFile, useImages=FALSE, illuminaAnnotation="Humanv3")



###################################################
### code chunk number 7: annotation
###################################################
suggestAnnotation(data,verbose=TRUE)

annotation(data) <- "Humanv3"


###################################################
### code chunk number 8: BLData
###################################################
slotNames(data)


###################################################
### code chunk number 9: BLData2
###################################################
data@sectionData
sectionNames(data)
numBeads(data)


head(data[[1]])


getBeadData(data, array=1, what = "Grn")[1:5]
getBeadData(data, array=1, what = "GrnX")[1:5]
getBeadData(data, array=1, what = "ProbeID")[1:5]


###################################################
### code chunk number 10: transformFunctions
###################################################
log2(data[[1]][1:10,"Grn"])
log2(getBeadData(data, array = 1, what = "Grn")[1:10])
logGreenChannelTransform(data, array = 1)[1:10]


###################################################
### code chunk number 11: transformFunctions2
###################################################
logGreenChannelTransform


###################################################
### code chunk number 12: readinTIFF1
###################################################
TIFF<-readTIFF(system.file("extdata/FullData/4613710052_B_Grn.tif",package = "BeadArrayUseCases"))

cbind(col(TIFF)[which(TIFF == 0)], row(TIFF)[which(TIFF == 0)])
xcoords<-getBeadData(data,array=2,what="GrnX")
ycoords<-getBeadData(data,array=2,what="GrnY")


par(mfrow=c(1,3))
offset<-1


plotTIFF(TIFF+offset,c(1517,1527),c(5507,5517),values=T,textCol="yellow",
main=expression(log[2](intensity+1)))
points(xcoords[503155],ycoords[503155],pch=16,col="red")


plotTIFF(TIFF+offset,c(1202,1212),c(13576,13586),values=T,textCol="yellow",
main=expression(log[2](intensity+1)))
points(xcoords[625712],ycoords[625712],pch=16,col="red")


plotTIFF(TIFF+offset,c(1613,1623),c(9219,9229),values=T,textCol="yellow",
main=expression(log[2](intensity+1)))
points(xcoords[767154],ycoords[767154],pch=16,col="red")


###################################################
### code chunk number 13: readinTIFF2
###################################################
Brob<-medianBackground(TIFF,cbind(xcoords,ycoords))
data<-insertBeadData(data,array=2,what="GrnRB",Brob)


###################################################
### code chunk number 14: readinTIFF3
###################################################
# apply Illumina's image filtering
TIFF2<-illuminaSharpen(TIFF)
# calculate foreground values
IllF<-illuminaForeground(TIFF2, cbind(xcoords,ycoords))
 
data<-insertBeadData(data,array=2,what="GrnF",IllF)
data<-backgroundCorrectSingleSection(data, array = 2, fg="GrnF", bg="GrnRB", newName = "GrnR")


###################################################
### code chunk number 15: readinTIFF4
###################################################


oldG<-getBeadData(data,array=2,"Grn")


newG<-getBeadData(data,array=2,"GrnR")


summary(oldG-newG)


par(mfrow=c(1,2))


plot(xcoords[(abs(oldG-newG)>50)],ycoords[(abs(oldG-newG)>50)],pch=16,xlab="X",ylab="Y",main="entire array")


points(col(TIFF)[TIFF<400],row(TIFF)[TIFF<400],col="red",pch=16)


plot(xcoords[(abs(oldG-newG)>50)],ycoords[(abs(oldG-newG)>50)],pch=16,xlim=c(1145,1180),ylim=c(15500,15580),xlab="X",ylab="Y",main="zoomed in")


points(col(TIFF)[TIFF<400],row(TIFF)[TIFF<400],col="red",pch=16)


###################################################
### code chunk number 16: Boxplots
###################################################
boxplot(data, transFun = logGreenChannelTransform, col = "green", ylab=expression(log[2](intensity)), las = 2, outline = FALSE, main = "HT-12 MAQC data")


###################################################
### code chunk number 17: imageplots (eval = FALSE)
###################################################
## par(mfrow=c(6,2))
## par(mar=c(1,1,1,1))
## 
## 
## for(i in 1:12) {
##    imageplot(data, array=i, high="darkgreen", low="lightgreen", zlim=c(4,10), main=sectionNames(data)[i])
## }


###################################################
### code chunk number 18: outliers
###################################################
par(mfrow=c(2,1))
for(i in c(8,12)){
   outlierplot(data, array=i, main=paste(sectionNames(data)[i], "outliers"))
}


###################################################
### code chunk number 19: BASH (eval = FALSE)
###################################################
## BASHoutput <- BASH(data, array=c(8,12))
## 
## data <- setWeights(data, wts = BASHoutput$wts, array=c(8,12))
## 
## 
## head(data[[8]])
## 
## 
## par(mfrow=c(1,2))
## for(i in c(8,12)) {
##   showArrayMask(data, array = i, override = TRUE)
## }
## 
## table(getBeadData(data, what="wts", array=8))
## table(getBeadData(data, what="wts", array=12))
## 
## BASHoutput$QC
## 


###################################################
### code chunk number 20: HULK
###################################################
HULKoutput <- HULK(data, array = 1, transFun = logGreenChannelTransform)
data <- insertBeadData(data, array = 1, data = HULKoutput,  what = "GrnHulk")


###################################################
### code chunk number 21: Registration (eval = FALSE)
###################################################
## registrationScores <- checkRegistration(data, array = c(1,7) )
## boxplot(registrationScores, plotP95 = TRUE)


###################################################
### code chunk number 22: controlEx
###################################################

par(mfrow=c(2,2))


for(i in c(6,7,8,12)) {
poscontPlot(data ,array = i, main=paste(sectionNames(data)[i], "Positive Controls"), ylim = c(4,15) )
}


###################################################
### code chunk number 23: qcTables
###################################################
quickSummary(data, array=1)


qcReport <- makeQCTable(data)


head(qcReport)[,1:5]


###################################################
### code chunk number 24: storeQCTables
###################################################
data <- insertSectionData(data, what="BeadLevelQC", data=qcReport)
names(data@sectionData)


###################################################
### code chunk number 25: sexControl (eval = FALSE)
###################################################
## 
## cprof <- makeControlProfile("Humanv3")
## 
## sexprof <- data.frame("ArrayAddress" = c("5270068", "1400139", "6860102"), "Tag" = rep("Gender",3))
## 
## cprof <- rbind(cprof, sexprof)
## 
## makeQCTable(data, controlProfile=cprof)


###################################################
### code chunk number 26: qaReport (eval = FALSE)
###################################################
## expressionQCPipeline(data)


###################################################
### code chunk number 27: createBeadSummaryData (eval = FALSE)
###################################################
## 
## datasumm <- summarize(BLData =data)
## 
## grnchannel.unlogged <- new("illuminaChannel", transFun = greenChannelTransform, outlierFun = illuminaOutlierMethod, exprFun = function(x) mean(x,na.rm=TRUE),  varFun= function(x) sd(x, na.rm=TRUE),channelName= "G")
## 
## datasumm.unlogged <- summarize(BLData = data, 
## useSampleFac=FALSE, channelList = list(grnchannel.unlogged))


###################################################
### code chunk number 28: ExpressionSetIllumina (eval = FALSE)
###################################################
## dim(datasumm)
## 
## 
## exprs(datasumm)[1:10,1:2]
## se.exprs(datasumm)[1:10, 1:2]
## 
## 
## par(mai=c(1.5,1,0.2,0.1), mfrow=c(1,2))
## boxplot(exprs(datasumm), ylab=expression(log[2](intensity)), las=2, outline=FALSE)
## boxplot(nObservations(datasumm),  ylab="number of beads", las=2, outline=FALSE)
## 
## 
## det <- calculateDetection(datasumm)
## 
## 
## head(det)
## 
## 
## Detection(datasumm) <- det


###################################################
### code chunk number 29: Import (eval = FALSE)
###################################################
## library(limma)
## 
## maqc <- read.ilmn(files="AsuragenMAQC-probe-raw.txt",
##                ctrlfiles="AsuragenMAQC-controls.txt",
##                probeid="ProbeID", annotation="TargetID",
##                other.columns=c("Detection Pval", "Avg_NBEADS"))
## dim(maqc)
## maqc$targets
## maqc$E[1:5,]
## table(maqc$genes$Status)


###################################################
### code chunk number 30: proportionexpressed (eval = FALSE)
###################################################
## proportion <- propexpr(maqc)
## proportion
## t.test(proportion[1:3], proportion[4:6])


###################################################
### code chunk number 31: normexp (eval = FALSE)
###################################################
## maqc.norm <- neqc(maqc)
## dim(maqc.norm)
## par(mfrow=c(3,1))
## boxplot(log2(maqc$E[maqc$genes$Status=="regular",]), range=0, las=2, xlab="", ylab=expression(log[2](intensity)), main="Regular probes")
## boxplot(log2(maqc$E[maqc$genes$Status=="NEGATIVE",]), range=0, las=2, xlab="", ylab=expression(log[2](intensity)), main="Negative control probes")
## boxplot(maqc.norm$E, range=0, ylab=expression(log[2](intensity)), las=2, xlab="", main="Regular probes, NEQC normalized")


###################################################
### code chunk number 32: qualplots (eval = FALSE)
###################################################
## plotMDS(maqc.norm$E)


###################################################
### code chunk number 33: filteringByAnnotation (eval = FALSE)
###################################################
## library(illuminaHumanv2.db)
## 
## illuminaHumanv2()
## 
## ids <- as.character(rownames(maqc.norm))
## 
## 
## ids2 <- unlist(mget(ids, revmap(illuminaHumanv2ARRAYADDRESS), ifnotfound=NA))
## 
## qual <- unlist(mget(ids2, illuminaHumanv2PROBEQUALITY, ifnotfound=NA))
## 
## table(qual)
## 
## AveSignal = rowMeans(maqc.norm$E)
## 
## boxplot(AveSignal~ qual)
## 
## rem <- qual == "No match" | qual == "Bad"
## 
## maqc.norm.filt <- maqc.norm[!rem,]
## 
## dim(maqc.norm)
## dim(maqc.norm.filt)


###################################################
### code chunk number 34: badProbes (eval = FALSE)
###################################################
## 
## queryIDs <- names(which(qual == "Bad" & AveSignal > 12))
## 
## unlist(mget(queryIDs, illuminaHumanv2REPEATMASK))
## 
## unlist(mget(queryIDs, illuminaHumanv2SECONDMATCHES))
## 
## mget("ILMN_1692145", illuminaHumanv2PROBESEQUENCE)
## 


###################################################
### code chunk number 35: otherBitsAndPieces_cluster (eval = FALSE)
###################################################
## IQR <- apply(maqc.norm.filt$E, 1, IQR, na.rm=TRUE)
## 
## topVar <- order(IQR, decreasing=TRUE)[1:500]
## d <- dist(t(maqc.norm.filt$E[topVar,]))
## plot(hclust(d))
## 


###################################################
### code chunk number 36: otherBitsAndPieces_heatmap (eval = FALSE)
###################################################
## 
## heatmap(maqc.norm.filt$E[topVar,])
## 


###################################################
### code chunk number 37: deanalysis (eval = FALSE)
###################################################
## rna <- factor(rep(c("UHRR", "Brain"), each=3))
## design <- model.matrix(~0+rna)
## colnames(design) <- levels(rna)
## aw <- arrayWeights(maqc.norm.filt, design)
## aw
## fit <- lmFit(maqc.norm.filt, design, weights=aw)
## contrasts <- makeContrasts(UHRR-Brain, levels=design)
## contr.fit <- eBayes(contrasts.fit(fit, contrasts))
## topTable(contr.fit, coef=1)
## 
## 
## par(mfrow=c(1,2))
## volcanoplot(contr.fit, main="UHRR - Brain")
## smoothScatter(contr.fit$Amean, contr.fit$coef,
##                  xlab="average intensity", ylab="log-ratio")
## abline(h=0, col=2, lty=2)


###################################################
### code chunk number 38: annotation (eval = FALSE)
###################################################
## library(illuminaHumanv2.db)
## 
## illuminaHumanv2()
## 
## ids <- as.character(contr.fit$genes$ProbeID)
## 
## ids2 <- unlist(mget(ids, revmap(illuminaHumanv2ARRAYADDRESS), ifnotfound=NA))
## 
## chr <- mget(ids2, illuminaHumanv2CHR, ifnotfound = NA)
## cytoband<- mget(ids2, illuminaHumanv2MAP, ifnotfound = NA)
## refseq <- mget(ids2, illuminaHumanv2REFSEQ, ifnotfound = NA)
## entrezid <- mget(ids2, illuminaHumanv2ENTREZID, ifnotfound = NA)
## symbol <- mget(ids2, illuminaHumanv2SYMBOL, ifnotfound = NA)
## genename <- mget(ids2, illuminaHumanv2GENENAME, ifnotfound = NA)
## 
## anno <- data.frame(Ill_ID = ids2, Chr = as.character(chr),
##            Cytoband = as.character(cytoband), RefSeq = as.character(refseq),
##            EntrezID = as.numeric(entrezid), Symbol = as.character(symbol),
##            Name = as.character(genename))
## 
## contr.fit$genes <- anno
## topTable(contr.fit)
## write.fit(contr.fit, file = "maqcresultsv2.txt")


###################################################
### code chunk number 39: getGO
###################################################
cellCycleProbesGO <- mget("GO:0045787", illuminaHumanv2GO2PROBE)
cellCycleProbesKEGG <- mget("04110", illuminaHumanv2PATH2PROBE)


###################################################
### code chunk number 40: getSymbol
###################################################
queryIDs <- mget("ERBB2", revmap(illuminaHumanv2SYMBOL))
mget("ERBB2", revmap(illuminaHumanv2SYMBOL))
mget(unlist(queryIDs), illuminaHumanv2PROBEQUALITY)


###################################################
### code chunk number 41: installBiostrings (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("Biostrings")


###################################################
### code chunk number 42: GChistogram
###################################################
require("Biostrings")
probeseqs <- unlist(as.list(illuminaHumanv2PROBESEQUENCE))

GC = vector(length=length(probeseqs))

ss <- BStringSet(probeseqs[which(!is.na(probeseqs))])

GC[which(!is.na(probeseqs))] = letterFrequency(ss, letters="GC")

hist(GC/50, main="GC proportion")



###################################################
### code chunk number 43: installGenomicRanges (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("GenomicRanges")


###################################################
### code chunk number 44: toRangedData
###################################################
require("GenomicRanges")

allLocs <- unlist(as.list(illuminaHumanv2GENOMICLOCATION))


chrs <- unlist(lapply(allLocs,function(x) strsplit(as.character(x), ":")[[1]][1]))
spos <- as.numeric(unlist(lapply(allLocs,function(x) strsplit(as.character(x), ":")[[1]][2])))
epos <- as.numeric(unlist(lapply(allLocs,function(x) strsplit(as.character(x), ":")[[1]][3])))
strand <-  substr(unlist(lapply(allLocs,function(x) strsplit(as.character(x), ":")[[1]][4])),1,1)

validPos <- !is.na(spos)
Humanv2RD <- GRanges(seqnames = chrs[validPos], 
ranges=IRanges(start = spos[validPos],end=epos[validPos]),
names=names(allLocs)[validPos],strand = strand[validPos])


###################################################
### code chunk number 45: regionquery
###################################################

query <- IRanges(start = 28800001, end = 36500000)

olaps <- findOverlaps(Humanv2RD, GRanges(ranges = query, seqnames = "chr8"))

matchingProbes <- as.matrix(olaps)[,1]

Humanv2RD[matchingProbes,]

Humanv2RD$names[matchingProbes]

unlist(mget(Humanv2RD$names[matchingProbes], illuminaHumanv2SYMBOL))



###################################################
### code chunk number 46: installGOstats (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("GOstats")


###################################################
### code chunk number 47: GOstats (eval = FALSE)
###################################################
## require("GOstats")
## 
## universeIds <- anno$EntrezID
## 
## dTests <- decideTests(contr.fit)
## 
## selectedEntrezIds <- anno$EntrezID[dTests == 1]
## 
## params = new("GOHyperGParams", geneIds = selectedEntrezIds, universeGeneIds = universeIds,  annotation = "illuminaHumanv2", ontology = "BP", pvalueCutoff = 0.05, conditional = FALSE, testDirection = "over")
## 
## hgOver = hyperGTest(params)
## 
## summary(hgOver)[1:10,]
## 


###################################################
### code chunk number 48: readFromGEO
###################################################
library(GEOquery)
library(limma)
library(illuminaHumanv1.db)

## We need to set this, otherwise the next line will fail
Sys.setenv("VROOM_CONNECTION_SIZE" = 512000)
gse <- getGEO(GEO = 'GSE5350')[['GSE5350-GPL2507_series_matrix.txt.gz']]

dim(gse)
exprs(gse)[1:5,1:2]
 
samples <- as.character(pData(gse)[,"title"])
sites <- as.numeric(substr(samples,10,10))
shortlabels <- substr(samples,12,13)

rnasource <- pData(gse)[,"source_name_ch1"]
levels(rnasource) <- c("UHRR", "Brain", "UHRR75", "UHRR25")

boxplot(log2(exprs(gse)), col=sites+1, names=shortlabels, las=2, cex.names=0.5, ylab=expression(log[2](intensity)), outline=FALSE, ylim=c(3,10), main="Before batch correction")


###################################################
### code chunk number 49: installMAQCsubsetpackage (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("MAQCsubsetILM")
## library(MAQCsubsetILM)
## data(refA);data(refB);data(refC);data(refD)
## gse = combine(refA, refB, refC, refD)
## sites = pData(gse)[,2]
## shortlabels = substr(sampleNames(gse), 7,8)
## rnasource = pData(gse)[,3]
## levels(rnasource) = c("UHRR", "Brain", "UHRR75", "UHRR25")
## 
## boxplot(log2(exprs(gse)), col=sites+1, names=shortlabels, las=2, cex.names=0.5, ylab=expression(log[2](intensity)), outline=FALSE, ylim=c(3,10), main="Before batch correction")


###################################################
### code chunk number 50: deAnalysisFromGEO (eval = FALSE)
###################################################
## gse.batchcorrect <- removeBatchEffect(log2(exprs(gse)), batch=sites)
## 
## par(mfrow=c(1,2), oma=c(1,0.5,0.2,0.1))
## boxplot(gse.batchcorrect, col=sites+1, names=shortlabels, las=2, cex.names=0.5, ylab=expression(log[2](intensity)), outline=FALSE, ylim=c(3,10),  main="After batch correction")
## plotMDS(gse.batchcorrect, labels=shortlabels, col=sites+1, main="MDS plot")
## 
## ids3 <- featureNames(gse)
## 
## qual2 <-  unlist(mget(ids3, illuminaHumanv1PROBEQUALITY, ifnotfound=NA))
## 
## table(qual2)
## 
## rem2 <- qual2 == "No match" | qual2 == "Bad" | is.na(qual2)
## 
## gse.batchcorrect.filt <- gse.batchcorrect[!rem2,]
## 
## dim(gse.batchcorrect)
## dim(gse.batchcorrect.filt)
## 
## design2 <- model.matrix(~0+rnasource)
## colnames(design2) <- levels(rnasource)
## aw2 <- arrayWeights(gse.batchcorrect.filt, design2)
## fit2 <- lmFit(gse.batchcorrect.filt, design2, weights=aw2)
## 
## contrasts2 <- makeContrasts(UHRR-Brain, levels=design2)
## contr.fit2 <- eBayes(contrasts.fit(fit2, contrasts2))
## 
## topTable(contr.fit2, coef=1)
## volcanoplot(contr.fit2, main="UHRR - Brain")
## 
## ids4 <- rownames(gse.batchcorrect.filt)
## 
## chr2 <- mget(ids4, illuminaHumanv1CHR, ifnotfound = NA)
## chrloc2 <- mget(ids4, illuminaHumanv1CHRLOC, ifnotfound = NA)
## refseq2 <- mget(ids4, illuminaHumanv1REFSEQ, ifnotfound = NA)
## entrezid2 <- mget(ids4, illuminaHumanv1ENTREZID, ifnotfound = NA)
## symbols2 <- mget(ids4, illuminaHumanv1SYMBOL, ifnotfound = NA)
## genename2 <- mget(ids4, illuminaHumanv1GENENAME, ifnotfound = NA)
## anno2 <- data.frame(Ill_ID = ids4, Chr = as.character(chr2),
##                Loc = as.character(chrloc2), RefSeq = as.character(refseq2),
##                Symbol = as.character(symbols2), Name = as.character(genename2),
##                EntrezID = as.numeric(entrezid2))
## 
## contr.fit2$genes <- anno2
## write.fit(contr.fit2, file = "maqcresultsv1.txt")


###################################################
### code chunk number 51: Import (eval = FALSE)
###################################################
## z <- contr.fit[!is.na(contr.fit$genes$EntrezID),]
## z <- z[order(z$genes$EntrezID),]
## f <- factor(z$genes$EntrezID)
## sel.unique <- tapply(z$Amean,f,function(x) x==max(x))
## sel.unique <- unlist(sel.unique)
## contr.fit.unique <- z[sel.unique,]
## 
## 
## z <- contr.fit2[!is.na(contr.fit2$genes$EntrezID),]
## z <- z[order(z$genes$EntrezID),]
## f <- factor(z$genes$EntrezID)
## sel.unique <- tapply(z$Amean,f,function(x) x==max(x))
## sel.unique <- unlist(sel.unique)
## contr.fit2.unique <- z[sel.unique,]
## 
## 
## m <- match(contr.fit.unique$genes$EntrezID, contr.fit2.unique$genes$EntrezID)
## contr.fit.common <- contr.fit.unique[!is.na(m),]
## contr.fit2.common <- contr.fit2.unique[m[!is.na(m)],]
## 
## 
## lfc <- data.frame(lfc_version1=contr.fit2.common$coef[,1], lfc_version2=contr.fit.common$coef[,1])
## dim(lfc)
## options(digits=2)
## lfc[1:10,]
## 
## 
## plot(lfc[,1], lfc[,2], xlab="version 1", ylab="version 2")
## abline(0,1,col=2)


###################################################
### code chunk number 52: sessionInfo
###################################################
sessionInfo()


