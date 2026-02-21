# Code example from 'attract' vignette. See references/ for full tutorial.

### R code from vignette source 'attract.Rnw'

###################################################
### code chunk number 1: attract.Rnw:22-28
###################################################
  options(width=60)

  listing <- function(x, options) {
    paste("\\begin{lstlisting}[basicstyle=\\ttfamily,breaklines=true]\n",
      x, "\\end{lstlisting}\n", sep = "")
  }


###################################################
### code chunk number 2: filterData (eval = FALSE)
###################################################
## library(attract)
## filteredData <- filterDataSet(data, filterPerc=0.75)


###################################################
### code chunk number 3: loadlib
###################################################
library(attract)
data(exprs.dat) 
data(samp.info)


###################################################
### code chunk number 4: makeESet
###################################################
loring.eset <- new("ExpressionSet")
loring.eset@assayData <- new.env()
assign("exprs", exprs.dat, loring.eset@assayData)
p.eset <- new("AnnotatedDataFrame", data=samp.info)
loring.eset@phenoData <- p.eset


###################################################
### code chunk number 5: findAttractors
###################################################
attractor.states <- findAttractors(loring.eset, "celltype", 
                                   annotation="illuminaHumanv1.db", 
                                   database="KEGG",analysis="microarray",
                                   databaseGeneFormat=NULL, expressionSetGeneFormat=NULL)


###################################################
### code chunk number 6: exprsSetgeneIDoptions
###################################################
columns(illuminaHumanv1.db)


###################################################
### code chunk number 7: dataSetIDoptions
###################################################
keytypes(illuminaHumanv1.db)


###################################################
### code chunk number 8: findAttractorsCustom (eval = FALSE)
###################################################
## MSigDBpath <- system.file("extdata","c4.cgn.v5.0.entrez.gmt",package="attract")
## attractor.states.cutsom <- findAttractors(loring.eset, "celltype", annotation="illuminaHumanv1.db",database=MSigDBpath, analysis="microarray",databaseGeneFormat="ENTREZID", expressionSetGeneFormat="PROBEID")


###################################################
### code chunk number 9: showSlots
###################################################
class(attractor.states) 
slotNames(attractor.states) 


###################################################
### code chunk number 10: removeFlats
###################################################
remove.these.genes <- removeFlatGenes(loring.eset, "celltype", 
                                      contrasts=NULL, limma.cutoff=0.05)


###################################################
### code chunk number 11: findSynE
###################################################
mapk.syn <- findSynexprs("04010", attractor.states, "celltype"
                         , remove.these.genes)


###################################################
### code chunk number 12: showSynSlots
###################################################
class(mapk.syn)
slotNames(mapk.syn)


###################################################
### code chunk number 13: howMany
###################################################
length(mapk.syn@groups) 
sapply(mapk.syn@groups, length) 


###################################################
### code chunk number 14: findMultiSynE
###################################################
top5.syn <- findSynexprs(attractor.states@rankedPathways[1:5,1], 
                         attractor.states, "celltype", 
                         removeGenes=remove.these.genes)


###################################################
### code chunk number 15: demoEnv
###################################################
ls(top5.syn) 


###################################################
### code chunk number 16: demoClass
###################################################
class(get(ls(top5.syn)[1], top5.syn))


###################################################
### code chunk number 17: plotSyn
###################################################
par(mfrow=c(2,2)) 
pretty.col <- rainbow(3) 
for( i in 1:3 ){
	plotsynexprs(mapk.syn, tickMarks=c(6, 28, 47, 60), 
               tickLabels=c("ESC", "PRO", "NSC", "TER"), 
               vertLines=c(12.5, 43.5, 51.5), index=i, 
			main=paste("Synexpression Group ", i, sep="")
      ,col=pretty.col[i])
 }


###################################################
### code chunk number 18: findCorrP
###################################################
mapk.cor <- findCorrPartners(mapk.syn, loring.eset, remove.these.genes)


###################################################
### code chunk number 19: lookatCorr
###################################################
sapply(mapk.cor@groups, length)


###################################################
### code chunk number 20: funcE
###################################################
mapk.func <- calcFuncSynexprs(mapk.syn, attractor.states, "CC", 
                              annotation="illuminaHumanv1.db"
                              ,analysis="microarray",expressionSetGeneFormat=NULL) 


###################################################
### code chunk number 21: SessionInfo
###################################################
sessionInfo()


