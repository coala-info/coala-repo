# Code example from 'BiSeq' vignette. See references/ for full tutorial.

### R code from vignette source 'BiSeq.Rnw'

###################################################
### code chunk number 1: BiSeq.Rnw:35-37
###################################################
options(width=60)
options(continue=" ")


###################################################
### code chunk number 2: preliminaries
###################################################
library(BiSeq)


###################################################
### code chunk number 3: read (eval = FALSE)
###################################################
## readBismark(files, colData)


###################################################
### code chunk number 4: BiSeq.Rnw:81-93
###################################################
metadata <- list(Sequencer = "Instrument", Year = "2013")
rowRanges <- GRanges(seqnames = "chr1",
                  ranges = IRanges(start = c(1,2,3), end = c(1,2,3)))
colData <- DataFrame(group = c("cancer", "control"),
                     row.names = c("sample_1", "sample_2"))
totalReads <- matrix(c(rep(10L, 3), rep(5L, 3)), ncol = 2)
methReads <- matrix(c(rep(5L, 3), rep(5L, 3)), ncol = 2)
BSraw(metadata = metadata,
      rowRanges = rowRanges,
      colData = colData,
      totalReads = totalReads,
      methReads = methReads)


###################################################
### code chunk number 5: BiSeq.Rnw:98-100
###################################################
data(rrbs)
rrbs


###################################################
### code chunk number 6: BiSeq.Rnw:103-104
###################################################
colData(rrbs)


###################################################
### code chunk number 7: BiSeq.Rnw:107-108
###################################################
head(rowRanges(rrbs))


###################################################
### code chunk number 8: BiSeq.Rnw:111-112
###################################################
head(totalReads(rrbs))


###################################################
### code chunk number 9: BiSeq.Rnw:115-116
###################################################
head(methReads(rrbs))


###################################################
### code chunk number 10: BiSeq.Rnw:132-137
###################################################
methLevel <- matrix(c(rep(0.5, 3), rep(1, 3)), ncol = 2)
BSrel(metadata = metadata,
      rowRanges = rowRanges,
      colData = colData,
      methLevel = methLevel)


###################################################
### code chunk number 11: BiSeq.Rnw:141-143
###################################################
rrbs.rel <- rawToRel(rrbs)
rrbs.rel


###################################################
### code chunk number 12: BiSeq.Rnw:146-147
###################################################
head(methLevel(rrbs.rel))


###################################################
### code chunk number 13: BiSeq.Rnw:152-154
###################################################
dim(rrbs)
colnames(rrbs)


###################################################
### code chunk number 14: BiSeq.Rnw:157-160
###################################################
rrbs[,"APL2"]
ind.chr1 <- which(seqnames(rrbs) == "chr1")
rrbs[ind.chr1,]


###################################################
### code chunk number 15: BiSeq.Rnw:163-166
###################################################
region <- GRanges(seqnames="chr1",
                  ranges=IRanges(start = 875200,
                                 end = 875500))


###################################################
### code chunk number 16: BiSeq.Rnw:168-170
###################################################
findOverlaps(rrbs, region)
subsetByOverlaps(rrbs, region)


###################################################
### code chunk number 17: BiSeq.Rnw:173-174
###################################################
sort(rrbs)


###################################################
### code chunk number 18: BiSeq.Rnw:177-180
###################################################
combine(rrbs[1:10,1:2], rrbs[1:1000, 3:10])
split(rowRanges(rrbs),
      f = as.factor(as.character(seqnames(rrbs))))


###################################################
### code chunk number 19: BiSeq.Rnw:186-187
###################################################
covStatistics(rrbs)


###################################################
### code chunk number 20: BiSeq.Rnw:191-192
###################################################
covBoxplots(rrbs, col = "cornflowerblue", las = 2)


###################################################
### code chunk number 21: BiSeq.Rnw:218-224
###################################################
rrbs.small <- rrbs[1:1000,]
rrbs.clust.unlim <- clusterSites(object = rrbs.small,
                                 groups = colData(rrbs)$group,
                                 perc.samples = 4/5,
                                 min.sites = 20,
                                 max.dist = 100)


###################################################
### code chunk number 22: BiSeq.Rnw:227-228
###################################################
head(rowRanges(rrbs.clust.unlim))


###################################################
### code chunk number 23: BiSeq.Rnw:231-232
###################################################
clusterSitesToGR(rrbs.clust.unlim)


###################################################
### code chunk number 24: BiSeq.Rnw:237-241
###################################################
ind.cov <- totalReads(rrbs.clust.unlim) > 0
quant <- quantile(totalReads(rrbs.clust.unlim)[ind.cov], 0.9)
quant
rrbs.clust.lim <- limitCov(rrbs.clust.unlim, maxCov = quant)


###################################################
### code chunk number 25: BiSeq.Rnw:245-246
###################################################
covBoxplots(rrbs.clust.lim, col = "cornflowerblue", las = 2)


###################################################
### code chunk number 26: BiSeq.Rnw:252-253
###################################################
predictedMeth <- predictMeth(object = rrbs.clust.lim)


###################################################
### code chunk number 27: BiSeq.Rnw:256-257
###################################################
predictedMeth


###################################################
### code chunk number 28: BiSeq.Rnw:262-268
###################################################
plotMeth(object.raw = rrbs[,6],
         object.rel = predictedMeth[,6],
         region = region,
         lwd.lines = 2,
         col.points = "blue",
         cex = 1.5)


###################################################
### code chunk number 29: BiSeq.Rnw:279-288
###################################################
cancer <- predictedMeth[, colData(predictedMeth)$group == "APL"]
control <- predictedMeth[, colData(predictedMeth)$group == "control"]
mean.cancer <- rowMeans(methLevel(cancer))
mean.control <- rowMeans(methLevel(control))
plot(mean.control,
     mean.cancer,
     col = "blue",
     xlab = "Methylation in controls",
     ylab = "Methylation in APLs")


###################################################
### code chunk number 30: BiSeq.Rnw:294-299
###################################################
## To shorten the run time set mc.cores, if possible!
betaResults <- betaRegression(formula = ~group,
                              link = "probit",
                              object = predictedMeth,
                              type = "BR")


###################################################
### code chunk number 31: BiSeq.Rnw:301-303
###################################################
## OR:
data(betaResults)


###################################################
### code chunk number 32: BiSeq.Rnw:306-307
###################################################
head(betaResults)


###################################################
### code chunk number 33: BiSeq.Rnw:314-323
###################################################
## Both resampled groups should have the same number of
## cancer and control samples:
predictedMethNull <- predictedMeth[,c(1:4, 6:9)]
colData(predictedMethNull)$group.null <- rep(c(1,2), 4)
## To shorten the run time, please set mc.cores, if possible!
betaResultsNull <- betaRegression(formula = ~group.null,
                                  link = "probit",
                                  object = predictedMethNull,
                                  type="BR")


###################################################
### code chunk number 34: BiSeq.Rnw:325-327
###################################################
## OR:
data(betaResultsNull)


###################################################
### code chunk number 35: BiSeq.Rnw:330-331
###################################################
vario <- makeVariogram(betaResultsNull)


###################################################
### code chunk number 36: BiSeq.Rnw:333-335
###################################################
## OR:
data(vario)


###################################################
### code chunk number 37: BiSeq.Rnw:340-345
###################################################
plot(vario$variogram$v)
vario.sm <- smoothVariogram(vario, sill = 0.9)
lines(vario.sm$variogram[,c("h", "v.sm")],
      col = "red", lwd = 1.5)
grid()


###################################################
### code chunk number 38: BiSeq.Rnw:351-354
###################################################
names(vario.sm)
head(vario.sm$variogram)
head(vario.sm$pValsList[[1]])


###################################################
### code chunk number 39: BiSeq.Rnw:357-362
###################################################
## auxiliary object to get the pValsList for the test
## results of interest:
vario.aux <- makeVariogram(betaResults, make.variogram=FALSE)
vario.sm$pValsList <- vario.aux$pValsList
head(vario.sm$pValsList[[1]])


###################################################
### code chunk number 40: BiSeq.Rnw:365-366
###################################################
locCor <- estLocCor(vario.sm)


###################################################
### code chunk number 41: BiSeq.Rnw:369-372
###################################################
clusters.rej <- testClusters(locCor,
                             FDR.cluster = 0.1)
clusters.rej$clusters.reject


###################################################
### code chunk number 42: BiSeq.Rnw:379-382
###################################################
clusters.trimmed <- trimClusters(clusters.rej,
                                 FDR.loc = 0.05)
head(clusters.trimmed)


###################################################
### code chunk number 43: BiSeq.Rnw:389-393
###################################################
DMRs <- findDMRs(clusters.trimmed,
                 max.dist = 100,
                 diff.dir = TRUE)
DMRs


###################################################
### code chunk number 44: BiSeq.Rnw:399-404
###################################################
DMRs.2 <- compareTwoSamples(object = predictedMeth,
                            sample1 = "APL1",
                            sample2 = "APL10961",
                            minDiff = 0.3,
                            max.dist = 100)


###################################################
### code chunk number 45: BiSeq.Rnw:407-408
###################################################
sum(overlapsAny(DMRs.2,DMRs))


###################################################
### code chunk number 46: <
###################################################
data(promoters)
data(rrbs)
rrbs.red <- subsetByOverlaps(rrbs, promoters)
ov <- findOverlaps(rrbs.red, promoters)
rowRanges(rrbs.red)$cluster.id[queryHits(ov)] <- promoters$acc_no[subjectHits(ov)]
head(rowRanges(rrbs.red))


###################################################
### code chunk number 47: <
###################################################
data(promoters)
data(rrbs)
rrbs <- rawToRel(rrbs)
promoters <- promoters[overlapsAny(promoters, rrbs)]
gt <- globalTest(group~1,
                 rrbs,
                 subsets = promoters)
head(gt)


###################################################
### code chunk number 48: BiSeq.Rnw:473-481
###################################################
rowCols <- c("magenta", "blue")[as.numeric(colData(predictedMeth)$group)]
plotMethMap(predictedMeth,
            region = DMRs[3],
            groups = colData(predictedMeth)$group,
            intervals = FALSE,
            zlim = c(0,1),
            RowSideColors = rowCols,
            labCol = "", margins = c(0, 6))


###################################################
### code chunk number 49: BiSeq.Rnw:489-499
###################################################
plotSmoothMeth(object.rel = predictedMeth,
               region = DMRs[3],
               groups = colData(predictedMeth)$group,
               group.average = FALSE,
               col = c("magenta", "blue"),
               lwd = 1.5)
legend("topright",
       legend=levels(colData(predictedMeth)$group),
       col=c("magenta", "blue"),
       lty=1, lwd = 1.5)


###################################################
### code chunk number 50: BiSeq.Rnw:506-513
###################################################
data(promoters)
head(promoters)
DMRs.anno <- annotateGRanges(object = DMRs,
                             regions = promoters,
                             name = 'Promoter',
                             regionInfo = 'acc_no')
DMRs.anno


###################################################
### code chunk number 51: BiSeq.Rnw:519-529
###################################################
plotBindingSites(object = rrbs,
                 regions = promoters,
                 width = 4000,
                 group = colData(rrbs)$group,
                 col = c("magenta", "blue"),
                 lwd = 1.5)
legend("top",
       legend=levels(colData(rrbs)$group),
       col=c("magenta", "blue"),
       lty=1, lwd = 1.5)


###################################################
### code chunk number 52: BiSeq.Rnw:535-545 (eval = FALSE)
###################################################
## track.names <- paste(colData(rrbs)$group,
##                      "_",
##                      gsub("APL", "", colnames(rrbs)),
##                      sep="")
## writeBED(object = rrbs,
##          name = track.names,
##          file = paste(colnames(rrbs), ".bed", sep = ""))
## writeBED(object = predictedMeth,
##          name = track.names,
##          file = paste(colnames(predictedMeth), ".bed", sep = ""))


