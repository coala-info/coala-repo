# Code example from 'GSBenchMark' vignette. See references/ for full tutorial.

### R code from vignette source 'GSBenchMark.Rnw'

###################################################
### code chunk number 1: start
###################################################
options(width=85)
options(continue=" ")
#rm(list=ls())


###################################################
### code chunk number 2: GSBenchMark.Rnw:113-114
###################################################
require(GSBenchMark)


###################################################
### code chunk number 3: GSBenchMark.Rnw:120-126
###################################################
data(diracpathways)
class(diracpathways)
names(diracpathways)[1:5]
class(diracpathways[[1]])
diracpathways[[1]]
pathways = diracpathways;


###################################################
### code chunk number 4: GSBenchMark.Rnw:136-138
###################################################
data(GSBenchMarkDatasets)
print(GSBenchMark.Dataset.names)


###################################################
### code chunk number 5: GSBenchMark.Rnw:143-151
###################################################
for(i in 1: length(GSBenchMark.Dataset.names))
{
  DataSetStudy = GSBenchMark.Dataset.names[[i]]
  data(list=DataSetStudy)
  cat("Data Set",DataSetStudy,"\n")
  print(phenotypesLevels)
  print(table(phenotypes))
}


###################################################
### code chunk number 6: GSBenchMark.Rnw:168-170
###################################################
genenames = rownames(exprsdata);
genenames[1:10]


###################################################
### code chunk number 7: GSBenchMark.Rnw:175-186
###################################################
prunedpathways = lapply(pathways, function(x) intersect(x, genenames))
emptypathways = which(sapply(prunedpathways, length) < 2)
if (length(emptypathways) > 0) {
        warning(paste("After pruning the pathways, there exist pathways with zero or one gene!\n Small pathways were deleted. Deleted pathways:", 
            paste(names(emptypathways), collapse = ","), "\n"))
        diracpathwayPruned= prunedpathways[-emptypathways]
}else {
        diracpathwayPruned = prunedpathways
}
cat("Number of pathways before pruning ",length(pathways),"\n")
cat("Number of pathways after pruning ",length(diracpathwayPruned))


###################################################
### code chunk number 8: GSBenchMark.Rnw:190-192
###################################################
summary(phenotypes)
phenotypesLevels


###################################################
### code chunk number 9: sessioInfo
###################################################
toLatex(sessionInfo())


