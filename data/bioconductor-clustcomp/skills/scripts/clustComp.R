# Code example from 'clustComp' vignette. See references/ for full tutorial.

### R code from vignette source 'clustComp.Rnw'

###################################################
### code chunk number 1: loadData
###################################################
library(Biobase)
library(colonCA)
data(colonCA)


###################################################
### code chunk number 2: renameLongNames
###################################################
rownames(colonCA)[39:42] <- paste("HSAC07", 0:3)
rownames(colonCA)[50:53] <- paste("UMGAP", 0:3)
rownames(colonCA)[260:263] <- paste("i", 0:3)


###################################################
### code chunk number 3: loadPackage
###################################################
library(clustComp)


###################################################
### code chunk number 4: clustComp.Rnw:72-80
###################################################
set.seed(0)
# seven flat clusters:
flat1 <- paste("A", kmeans(exprs(colonCA), 7)$cluster, sep = "")   
# six flat clusters:
flat2 <- paste("B", kmeans(exprs(colonCA), 6)$cluster, sep = "")  
# dendrograms with 2000 leaves:
hierar <- hclust(dist(exprs(colonCA)))   
hierar2 <- hclust(dist(exprs(colonCA)), method = 'ward.D')


###################################################
### code chunk number 5: comparisonFlatVsFlat1
###################################################
flatVSflat( flat1, flat2, line.wd = 5, h.min = 0.3, greedy = FALSE)


###################################################
### code chunk number 6: fig01
###################################################
bitmap("fig01.png", height = 4, width = 4, pointsize = 10, res = 300)
flatVSflat(flat1, flat2, line.wd = 5, h.min = 0.3, greedy = FALSE)
dev.off()


###################################################
### code chunk number 7: comparisonFlatVsFlat1a
###################################################
flatVSflat(flat1, flat2, coord1=c(6,3,4,7,5,1,2), 
    coord2=c(5,1,4,6,3,2), greedy = FALSE)


###################################################
### code chunk number 8: fig01a
###################################################
bitmap("fig01a.png",height=4,width=4,pointsize=10,res=300)
flatVSflat(flat1, flat2, coord1=c(6,3,4,7,5,1,2), coord2=c(5,1,4,6,3,2), 
    greedy = FALSE)
dev.off()


###################################################
### code chunk number 9: comparisonFlatVsFlat2
###################################################
flatVSflat(flat1, flat2, evenly=TRUE, horiz=TRUE, greedy = FALSE)


###################################################
### code chunk number 10: fig02
###################################################
bitmap("fig02.png",height=4,width=4,pointsize=10,res=300)
flatVSflat(flat1, flat2, evenly=TRUE, horiz=TRUE, greedy = FALSE)
dev.off()


###################################################
### code chunk number 11: greedyAlgorithm
###################################################
myMapping<-SCmapping(flat1, flat2)


###################################################
### code chunk number 12: fig03
###################################################
bitmap("fig03.png",height=4,width=7,pointsize=10,res=300)
SCmapping(flat1,flat2)
dev.off()


###################################################
### code chunk number 13: comparisonFlatVsFlatGreedy
###################################################
flatVSflat( flat1, flat2, line.wd = 5, h.min = 0.3, greedy = TRUE)


###################################################
### code chunk number 14: fig04
###################################################
bitmap("fig04.png", height = 4, width = 4, pointsize = 10, res = 300)
flatVSflat(flat1, flat2, line.wd = 5, h.min = 0.3, greedy = TRUE)
dev.off()


###################################################
### code chunk number 15: aestheticsNoLookAhead
###################################################
comparison.flatVShier.1<-flatVShier(hierar, flat1, verbose=FALSE, 
    pausing=FALSE, score.function="crossing", greedy.colours=1:4, 
    look.ahead=0)


###################################################
### code chunk number 16: fig05
###################################################
bitmap("fig05.png",height=6,width=8,pointsize=9,res=300)
flatVShier(hierar,flat1,pausing=FALSE,verbose=FALSE, 
    score.function="crossing",greedy.colours=1:4,look.ahead=0)
dev.off()


###################################################
### code chunk number 17: aestheticsNoLookAheadExpanded
###################################################
comparison.flatVShier.1<-flatVShier(hierar, flat1, verbose=FALSE, 
    pausing=FALSE, score.function="crossing", greedy.colours=1:4, 
    look.ahead=0, expanded=TRUE)


###################################################
### code chunk number 18: fig06
###################################################
bitmap("fig06.png",height=14,width=8,pointsize=9,res=300)
flatVShier(hierar,flat1,pausing=FALSE,verbose=FALSE, 
    score.function="crossing",greedy.colours=1:4,look.ahead=0, 
    expanded=TRUE)
dev.off()


###################################################
### code chunk number 19: itLookAhead1
###################################################
comparison.flatVShier.2<-flatVShier(hierar, flat1, verbose=FALSE, 
    pausing=FALSE, h.min=0.2, score.function="it", 
    greedy.colours=1:4, look.ahead=1)


###################################################
### code chunk number 20: fig07
###################################################
bitmap("fig07.png",height=6,width=8,pointsize=9,res=300)
flatVShier(hierar,flat1,pausing=FALSE,h.min=0.2,verbose=FALSE, 
    score.function="it",greedy.colours=1:4,look.ahead=1)
dev.off()


###################################################
### code chunk number 21: itLookAhead2
###################################################
comparison.flatVShier.3<-flatVShier(hierar, flat1, verbose=FALSE, 
    pausing=FALSE, h.min=0.2, score.function="it", 
    greedy.colours=1:4, look.ahead=2)


###################################################
### code chunk number 22: fig08
###################################################
bitmap("fig08.png", height=6, width=8, pointsize=9, res=300)
flatVShier(hierar, flat1, pausing=FALSE, verbose=FALSE, score.function="it",
    greedy.colours=1:4, look.ahead=2,h.min=0.2)
dev.off()


###################################################
### code chunk number 23: itLookAhead2Expanded
###################################################
comparison.flatVShier.4<-flatVShier(hierar2, flat1, verbose=FALSE, 
    pausing=FALSE, h.min=0.2, score.function="it", 
    greedy.colours=1:4, look.ahead=2, expanded=TRUE)


###################################################
### code chunk number 24: fig09
###################################################
bitmap("fig09.png", height=14, width=8, pointsize=9, res=300)
flatVShier(hierar2, flat1, pausing=FALSE, verbose=FALSE, 
    score.function="it", greedy.colours=1:4, look.ahead=2, 
    h.min=0.2, expanded=TRUE)
dev.off()
Sys.sleep(10)


###################################################
### code chunk number 25: itLookAhead2Heatmap
###################################################
comparison.flatVShier.5<-flatVShier(hierar2, flat1, verbose=FALSE, 
    pausing=FALSE, h.min=0.2, score.function="it", 
    greedy.colours=1:4, look.ahead=2, expanded=TRUE,
    expression=exprs(colonCA))


###################################################
### code chunk number 26: fig10
###################################################
bitmap("fig10.png", height=14, width=8, pointsize=9, res=300)
flatVShier(hierar2, flat1, pausing=FALSE, verbose=FALSE, 
    score.function="it", greedy.colours=1:4, look.ahead=2, 
    h.min=0.2, expanded=TRUE, expression=exprs(colonCA))
dev.off()
Sys.sleep(10)


