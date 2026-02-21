# Code example from 'GeneOverlap' vignette. See references/ for full tutorial.

### R code from vignette source 'GeneOverlap.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex(use.unsrturl=FALSE)


###################################################
### code chunk number 2: GeneOverlap.Rnw:33-34
###################################################
library(GeneOverlap)


###################################################
### code chunk number 3: GeneOverlap.Rnw:39-40
###################################################
data(GeneOverlap)


###################################################
### code chunk number 4: GeneOverlap.Rnw:43-46
###################################################
sapply(hESC.ChIPSeq.list, length)
sapply(hESC.RNASeq.list, length)
gs.RNASeq


###################################################
### code chunk number 5: GeneOverlap.Rnw:52-56
###################################################
go.obj <- newGeneOverlap(hESC.ChIPSeq.list$H3K4me3, 
                         hESC.RNASeq.list$"Exp High", 
                         genome.size=gs.RNASeq)
go.obj


###################################################
### code chunk number 6: GeneOverlap.Rnw:59-61
###################################################
go.obj <- testGeneOverlap(go.obj)
go.obj


###################################################
### code chunk number 7: GeneOverlap.Rnw:64-65
###################################################
print(go.obj)


###################################################
### code chunk number 8: GeneOverlap.Rnw:70-75
###################################################
go.obj <- newGeneOverlap(hESC.ChIPSeq.list$H3K4me3, 
                         hESC.RNASeq.list$"Exp Low", 
                         genome.size=gs.RNASeq)
go.obj <- testGeneOverlap(go.obj)
print(go.obj)


###################################################
### code chunk number 9: GeneOverlap.Rnw:80-84
###################################################
head(getIntersection(go.obj))
getOddsRatio(go.obj)
getContbl(go.obj)
getGenomeSize(go.obj)


###################################################
### code chunk number 10: GeneOverlap.Rnw:87-90
###################################################
setListA(go.obj) <- hESC.ChIPSeq.list$H3K27me3
setListB(go.obj) <- hESC.RNASeq.list$"Exp Medium"
go.obj


###################################################
### code chunk number 11: GeneOverlap.Rnw:93-95
###################################################
go.obj <- testGeneOverlap(go.obj)
go.obj


###################################################
### code chunk number 12: GeneOverlap.Rnw:98-104
###################################################
v.gs <- c(12e3, 14e3, 16e3, 18e3, 20e3)
setNames(sapply(v.gs, function(g) {
    setGenomeSize(go.obj) <- g
    go.obj <- testGeneOverlap(go.obj)
    getPval(go.obj)
}), v.gs)


###################################################
### code chunk number 13: GeneOverlap.Rnw:110-113
###################################################
gom.obj <- newGOM(hESC.ChIPSeq.list, hESC.RNASeq.list, 
                  gs.RNASeq)
drawHeatmap(gom.obj)


###################################################
### code chunk number 14: GeneOverlap.Rnw:120-121
###################################################
getMatrix(gom.obj, name="pval")


###################################################
### code chunk number 15: GeneOverlap.Rnw:124-125
###################################################
getMatrix(gom.obj, "odds.ratio")


###################################################
### code chunk number 16: GeneOverlap.Rnw:128-130
###################################################
inter.nl <- getNestedList(gom.obj, name="intersection")
str(inter.nl)


###################################################
### code chunk number 17: GeneOverlap.Rnw:133-135
###################################################
go.k4.high <- gom.obj[1, 1]
go.k4.high


###################################################
### code chunk number 18: GeneOverlap.Rnw:138-139
###################################################
gom.obj["H3K9me3", "Exp Medium"]


###################################################
### code chunk number 19: GeneOverlap.Rnw:143-146
###################################################
gom.self <- newGOM(hESC.ChIPSeq.list, 
                   genome.size=gs.RNASeq)
drawHeatmap(gom.self)


###################################################
### code chunk number 20: GeneOverlap.Rnw:153-154
###################################################
drawHeatmap(gom.self, ncolused=5, grid.col="Blues", note.col="black")


###################################################
### code chunk number 21: GeneOverlap.Rnw:160-162
###################################################
drawHeatmap(gom.self, what="Jaccard", ncolused=3, grid.col="Oranges", 
            note.col="black")


###################################################
### code chunk number 22: GeneOverlap.Rnw:174-175
###################################################
sessionInfo()


