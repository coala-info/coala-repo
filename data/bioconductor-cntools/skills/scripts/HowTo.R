# Code example from 'HowTo' vignette. See references/ for full tutorial.

### R code from vignette source 'HowTo.Rnw'

###################################################
### code chunk number 1: HowTo.Rnw:46-49
###################################################
require("CNTools")
data(sampleData)
head(sampleData)


###################################################
### code chunk number 2: HowTo.Rnw:65-70
###################################################
cnseg <- CNSeg(sampleData[which(is.element(sampleData[, "ID"], sample(unique(sampleData[, "ID"]), 20))), ])
rdseg <- getRS(cnseg, by = "region", imput = FALSE, XY = FALSE, what = "mean")
data("geneInfo")
geneInfo <- geneInfo[sample(1:nrow(geneInfo), 2000), ]
rdByGene <- getRS(cnseg, by = "gene", imput = FALSE, XY = FALSE, geneMap = geneInfo, what = "median")


###################################################
### code chunk number 3: HowTo.Rnw:75-76
###################################################
reducedseg <- rs(rdseg)


###################################################
### code chunk number 4: HowTo.Rnw:82-85
###################################################
f1 <- kOverA(5, 1)
ffun <- filterfun(f1)
filteredrs <- genefilter(rdseg, ffun)


###################################################
### code chunk number 5: HowTo.Rnw:90-91
###################################################
filteredrs <- madFilter(rdseg, 0.8)


###################################################
### code chunk number 6: HowTo.Rnw:96-98
###################################################
hc <- hclust(getDist(filteredrs, method = "euclidian"), method = "complete") 
plot(hc, hang = -1, cex = 0.8, main = "", xlab = "")  


###################################################
### code chunk number 7: HowTo.Rnw:125-126
###################################################
sessionInfo()


