# Code example from 'tutorial' vignette. See references/ for full tutorial.

### R code from vignette source 'tutorial.Rnw'

###################################################
### code chunk number 1: setup
###################################################
oldopt <- options(digits=3)
options(width=60)
on.exit( {options(oldopt)} )
library(iBBiG)


###################################################
### code chunk number 2: Arti
###################################################
library(iBBiG)
binMat<-makeArtificial()
binMat
plot(binMat)


###################################################
### code chunk number 3: Obj
###################################################
str(binMat)
Number(binMat)
RowxNumber(binMat)[1:2,]
NumberxCol(binMat)[,1:2]


###################################################
### code chunk number 4: iBBiG
###################################################
res<- iBBiG(binMat@Seeddata, nModules=10)
plot(res)


###################################################
### code chunk number 5: JI
###################################################
JIdist(res,binMat)
JIdist(res,binMat, margin="col", best=FALSE)

JIdist(res,binMat, margin="col")
JIdist(res,binMat, margin="row")
JIdist(res,binMat, margin="both")


###################################################
### code chunk number 6: JIcode (eval = FALSE)
###################################################
## showMethods(JIdist)
## getMethod(iBBiG:::JIdist, signature(clustObj = "iBBiG", GS = "iBBiG"))
## getMethod("JIdist",  signature(clustObj="iBBiG", GS="iBBiG"))


###################################################
### code chunk number 7: AC
###################################################
analyzeClust(res,binMat)
analyzeClust(res,binMat, margin="col")


###################################################
### code chunk number 8: ACcode (eval = FALSE)
###################################################
## showMethods(analyzeClust)
## getMethod("analyzeClust",  signature(clustObj="iBBiG", GS="iBBiG"))


###################################################
### code chunk number 9: strClass
###################################################
str(binMat)
RowScorexNumber(res)[1:2,]
Clusterscores(res)
Seeddata(res)[1:2,1:2]


###################################################
### code chunk number 10: Filter
###################################################
res[1:3]
res[c(4,2,1)]
res[1, drop=FALSE]


###################################################
### code chunk number 11: biclustPlots (eval = FALSE)
###################################################
## class(res)
## 
## par(mfrow=c(2,1))
## drawHeatmap2(res@Seeddata, res, number=4)
## biclustmember(res,res@Seeddata)
## 
## biclustbarchart(res@Seeddata, Bicres=res)
## 
## plotclust(res, res@Seeddata)


###################################################
### code chunk number 12: biclustBasic (eval = FALSE)
###################################################
## data(BicatYeast)
## BicatYeast[1:5,1:5]
## binarize(BicatYeast[1:5,1:5], threshold=0.2)
## discretize(BicatYeast[1:5,1:5])


###################################################
### code chunk number 13: bicluser
###################################################
Modules<-bicluster(res@Seeddata, res, 1:3)
str(Modules)
Modules[[1]][1:3,1:4]


###################################################
### code chunk number 14: Writebiclust (eval = FALSE)
###################################################
## writeBiclusterResults("Modules.txt", res, bicName="Output from iBBiG with default parameters", geneNames=rownames(res@Seeddata), arrayNames=colnames(res@Seeddata))
## 


###################################################
### code chunk number 15: sessionInfo
###################################################
toLatex(sessionInfo())


