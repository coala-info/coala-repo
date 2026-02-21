# Code example from 'Starr' vignette. See references/ for full tutorial.

### R code from vignette source 'Starr.Rnw'

###################################################
### code chunk number 1: Loading library
###################################################
library(Starr)


###################################################
### code chunk number 2: Reading bpmap file
###################################################
dataPath <- system.file("extdata", package="Starr")
bpmapChr1 <- readBpmap(file.path(dataPath, "Scerevisiae_tlg_chr1.bpmap"))


###################################################
### code chunk number 3: Data read-in
###################################################
cels <- c(file.path(dataPath,"Rpb3_IP_chr1.cel"), file.path(dataPath,"wt_IP_chr1.cel"), 
	file.path(dataPath,"Rpb3_IP2_chr1.cel"))
names <- c("rpb3_1", "wt_1","rpb3_2")
type <- c("IP", "CONTROL", "IP")
rpb3Chr1 <- readCelFile(bpmapChr1, cels, names, type, featureData=T, log.it=T)


###################################################
### code chunk number 4: ExpressionSet
###################################################
rpb3Chr1


###################################################
### code chunk number 5: assayData
###################################################
head(exprs(rpb3Chr1))


###################################################
### code chunk number 6: phenoData
###################################################
pData(rpb3Chr1)


###################################################
### code chunk number 7: featureData
###################################################
featureData(rpb3Chr1)
head(featureData(rpb3Chr1)$chr)
head(featureData(rpb3Chr1)$seq)
head(featureData(rpb3Chr1)$pos)


###################################################
### code chunk number 8: Reconstruction of the array image (eval = FALSE)
###################################################
## plotImage(file.path(dataPath,"Rpb3_IP_chr1.cel"))


###################################################
### code chunk number 9: Reconstruction of the array image
###################################################
jpeg(file="image.jpeg", quality=100)
plotImage(file.path(dataPath,"Rpb3_IP_chr1.cel"))
dev.off()


###################################################
### code chunk number 10: boxplots and density plots (eval = FALSE)
###################################################
## par(mfcol=c(1,2))
## plotDensity(rpb3Chr1, oneDevice=T, main="")
## plotBoxes(rpb3Chr1)


###################################################
### code chunk number 11: boxplots and density plots
###################################################
png("boxdens.png", height=400, width=720)
par(mfcol=c(1,2))
plotDensity(rpb3Chr1, oneDevice=T, main="")
plotBoxes(rpb3Chr1)
dev.off()


###################################################
### code chunk number 12: Scatterplot matrix (eval = FALSE)
###################################################
## plotScatter(rpb3Chr1, density=T, cex=0.5)


###################################################
### code chunk number 13: Scatterplot matrix
###################################################
png("densscatter.png", height=400, width=360)
plotScatter(rpb3Chr1, density=T, cex=0.5)
dev.off()


###################################################
### code chunk number 14: MA plot of raw data (eval = FALSE)
###################################################
## ips <- rpb3Chr1$type == "IP"
## controls <- rpb3Chr1$type == "CONTROL"
## plotMA(rpb3Chr1, ip=ips, control=controls)


###################################################
### code chunk number 15: MA plot of raw data
###################################################
png("maRaw.png", height=400, width=720)
ips <- rpb3Chr1$type == "IP"
controls <- rpb3Chr1$type == "CONTROL"
plotMA(rpb3Chr1, ip=ips, control=controls)
dev.off()


###################################################
### code chunk number 16: Sequence-specific hybridization bias (eval = FALSE)
###################################################
## par(mfcol=c(1,2))
## plotGCbias(exprs(rpb3Chr1)[,1], featureData(rpb3Chr1)$seq, main="")
## plotPosBias(exprs(rpb3Chr1)[,1], featureData(rpb3Chr1)$seq)


###################################################
### code chunk number 17: Sequence-specific hybridization bias
###################################################
png("posGC1.png", height=400, width=720)
par(mfcol=c(1,2))
plotGCbias(exprs(rpb3Chr1)[,1], featureData(rpb3Chr1)$seq, main="")
plotPosBias(exprs(rpb3Chr1)[,1], featureData(rpb3Chr1)$seq)
dev.off()


###################################################
### code chunk number 18: Starr.Rnw:226-227
###################################################
rpb3_loess <- normalize.Probes(rpb3Chr1, method="loess")


###################################################
### code chunk number 19: MA-plot of the normalized data (eval = FALSE)
###################################################
## plotMA(rpb3_loess, ip=ips, control=controls)


###################################################
### code chunk number 20: MA-plot of the normalized data
###################################################
png("maNorm.png", height=400, width=720)
plotMA(rpb3_loess, ip=ips, control=controls)
dev.off()


###################################################
### code chunk number 21: Calculating ratio
###################################################
description <- c("Rpb3vsWT")
rpb3_loess_ratio <- getRatio(rpb3_loess, ips, controls, description, fkt=median, featureData=F)


###################################################
### code chunk number 22: Sequence-specific hybridization bias (normalized data) (eval = FALSE)
###################################################
## par(mfcol=c(1,2))
## plotGCbias(exprs(rpb3_loess_ratio)[,1], featureData(rpb3_loess)$seq, main="")
## plotPosBias(exprs(rpb3_loess_ratio)[,1], featureData(rpb3_loess)$seq, ylim=c(-0.5,0.5))


###################################################
### code chunk number 23: Sequence-specific hybridization bias (normalized data)
###################################################
png("posGC2.png", height=400, width=720)
par(mfcol=c(1,2))
plotGCbias(exprs(rpb3_loess_ratio)[,1], featureData(rpb3_loess)$seq, main="")
plotPosBias(exprs(rpb3_loess_ratio)[,1], featureData(rpb3_loess)$seq, ylim=c(-1,1))
dev.off()


###################################################
### code chunk number 24: Starr.Rnw:298-299
###################################################
probeAnnoChr1 <- bpmapToProbeAnno(bpmapChr1)


###################################################
### code chunk number 25: Remapping probes
###################################################
newbpmap <- remap(bpmapChr1, path=dataPath, reverse_complementary=TRUE, return_bpmap=TRUE)


###################################################
### code chunk number 26: Summary of bpmap
###################################################
str(newbpmap)


###################################################
### code chunk number 27: Summary of bpmap (eval = FALSE)
###################################################
## writeTpmap("newbpmap.tpmap", newbpmap)
## tpmap2bpmap("newbpmap.tpmap", "newbpmap.bpmap")
## 
## pA <- bpmapToProbeAnno(newbpmap)


###################################################
### code chunk number 28: Starr.Rnw:352-354
###################################################
transcriptAnno <- read.gffAnno(file.path(dataPath, "transcriptAnno.gff"), feature="transcript")
filteredIDs <- filterGenes(transcriptAnno, distance_us = 0, distance_ds = 0, minLength = 1000)


###################################################
### code chunk number 29: means
###################################################
pos <- c("start", "start", "start", "region", "region","region","region", "stop","stop","stop")
upstream <- c(500, 0, 250, 0, 0, 500, 500, 500, 0, 250)
downstream <- c(0, 500, 250, 0, 500, 0, 500, 0, 500, 250)
info <- data.frame(pos=pos, upstream=upstream, downstream=downstream, stringsAsFactors=F)


###################################################
### code chunk number 30: means
###################################################
means_rpb3 <- getMeans(rpb3_loess_ratio, probeAnnoChr1, transcriptAnno[which(transcriptAnno$name %in% filteredIDs),], info)


###################################################
### code chunk number 31: correlationPlot (eval = FALSE)
###################################################
## info$cor <- sapply(means_rpb3, mean, na.rm=T)
## level <- c(1, 1, 2, 3, 4, 5, 6, 1, 1, 2)
## info$level <- level
## correlationPlot(info, labels=c("TSS", "TTS"))


###################################################
### code chunk number 32: correlationPlot
###################################################
png("corPlot.png", height=400, width=360)
info$cor <- sapply(means_rpb3, mean, na.rm=T)
level <- c(1, 1, 2, 3, 4, 5, 6, 1, 1, 2)
info$level <- level
correlationPlot(info, labels=c("TSS", "TTS"))
dev.off()


###################################################
### code chunk number 33: profileplotExampleData (eval = FALSE)
###################################################
## sampls = 100
## probes = 63
## at = (-31:31)*14
## clus = matrix(rnorm(probes*sampls,sd=1),ncol=probes)
## clus= rbind( t(t(clus)+sin(1:probes/10))+1:nrow(clus)/sampls , t(t(clus)+sin(pi/2+1:probes/10))+1:nrow(clus)/sampls )


###################################################
### code chunk number 34: profileplotExampleData (eval = FALSE)
###################################################
## labs = paste("cluster",kmeans(clus,2)$cluster)


###################################################
### code chunk number 35: profileplotExampleData (eval = FALSE)
###################################################
## par(mfrow=c(1,2))
## profileplot(clus,label=labs,main="Clustered data",colpal=c("heat","blue"),add.quartiles=T,fromto=c(0.05,0.95))


###################################################
### code chunk number 36: profileplot
###################################################
png("profileplot.png", height=400, width=720)
sampls = 100
probes = 63
at = (-31:31)*14
clus = matrix(rnorm(probes*sampls,sd=1),ncol=probes)
clus= rbind( t(t(clus)+sin(1:probes/10))+1:nrow(clus)/sampls , t(t(clus)+sin(pi/2+1:probes/10))+1:nrow(clus)/sampls )
labs = paste("cluster",kmeans(clus,2)$cluster)
par(mfrow=c(1,2))
profileplot(clus,label=labs,main="Clustered data",colpal=c("heat","blue","red","topo"),add.quartiles=T,fromto=c(0.05,0.95))
dev.off()


###################################################
### code chunk number 37: Starr.Rnw:466-471
###################################################
tssAnno <- transcriptAnno
watson <- which(tssAnno$strand == 1)
tssAnno[watson,]$end <- tssAnno[watson,]$start
crick <- which(tssAnno$strand == -1)
tssAnno[crick,]$start <- tssAnno[crick,]$end


###################################################
### code chunk number 38: Starr.Rnw:476-477
###################################################
profile <- getProfiles(rpb3_loess_ratio, probeAnnoChr1, tssAnno, 500, 500, feature="TSS", borderNames="TSS", method="basewise")


###################################################
### code chunk number 39: plotProfiles (eval = FALSE)
###################################################
## clust <- rep(1, dim(tssAnno)[1])
## names(clust) <- tssAnno$name
## plotProfiles(profile, cluster=clust)


###################################################
### code chunk number 40: plotProfiles
###################################################
png("sumPlot.png", height=400, width=720)
clust <- rep(1, dim(tssAnno)[1])
names(clust) <- tssAnno$name
plotProfiles(profile, cluster=clust, type="l", lwd=2)
dev.off()


###################################################
### code chunk number 41: Starr.Rnw:515-516
###################################################
peaks <- cmarrt.ma(rpb3_loess_ratio, probeAnnoChr1, chr=NULL, M=NULL, frag.length=300)


###################################################
### code chunk number 42: diagnostic plots cmarrt (eval = FALSE)
###################################################
## plotcmarrt(peaks)


###################################################
### code chunk number 43: diagnostic plots cmarrt
###################################################
png("cmarrt.png", height=800, width=720)
plotcmarrt(peaks)
dev.off()


###################################################
### code chunk number 44: Starr.Rnw:552-553
###################################################
peaklist <- cmarrt.peak(peaks, alpha = 0.05, method = "BH", minrun = 4)


###################################################
### code chunk number 45: Starr.Rnw:556-557
###################################################
str(peaklist)


###################################################
### code chunk number 46: smoothing
###################################################
rpb3_ratio_smooth <- computeRunningMedians(rpb3_loess_ratio, probeAnno=probeAnnoChr1, allChr = "chr1", winHalfSize = 80, modColumn="type")
sampleNames(rpb3_ratio_smooth) <- paste(sampleNames(rpb3_loess_ratio),"smoothed")
y0 <- apply(exprs(rpb3_ratio_smooth), 2, upperBoundNull)


###################################################
### code chunk number 47: ChIP-enriched regions
###################################################
distCutOff <- max(transcriptAnno$end - transcriptAnno$start)
chers <- findChersOnSmoothed(rpb3_ratio_smooth, probeAnno=probeAnnoChr1, thresholds=y0, allChr="chr1", distCutOff=distCutOff, cellType="yeast", minProbesInRow = 10)


###################################################
### code chunk number 48: ChIP-enriched regions
###################################################
chers <- relateChers(chers, transcriptAnno, upstream=500)


###################################################
### code chunk number 49: ChIP-enriched regions
###################################################
chersD <- as.data.frame.cherList(chers)
chersD <- chersD[which(chersD$feature != ""),]
chersD[order(chersD$maxLevel, decreasing=TRUE)[1:5],]


###################################################
### code chunk number 50: plotCher
###################################################
plot(chers[[11]], rpb3_ratio_smooth, probeAnno=probeAnnoChr1, gff=transcriptAnno, paletteName="Spectral")


###################################################
### code chunk number 51: sessionInfo
###################################################
toLatex(sessionInfo())


