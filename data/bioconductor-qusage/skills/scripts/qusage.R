# Code example from 'qusage' vignette. See references/ for full tutorial.

### R code from vignette source 'qusage.Rnw'

###################################################
### code chunk number 1: install (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("qusage")


###################################################
### code chunk number 2: setup
###################################################
options(width=70)
options(SweaveHooks=list(fig=function()
             par(mar=c(5.1, 4.1, 1.1, 2.1))))

library(qusage)
library(nlme)
data("fluExample")
data("GeneSets")

i = c(which(flu.meta$Hours==0), which(flu.meta$Hours==77))
eset = eset.full[,i]
resp = flu.meta$Condition[i]


###################################################
### code chunk number 3: exprSimple
###################################################
dim(eset)
eset[1:5,1:5]


###################################################
### code chunk number 4: labelsSimple
###################################################
labels = c(rep("t0",17),rep("t1",17))
labels


###################################################
### code chunk number 5: contrastSimple
###################################################
contrast = "t1-t0"


###################################################
### code chunk number 6: geneSetSimple
###################################################
ISG.geneSet[1:10]


###################################################
### code chunk number 7: qsSimple
###################################################
qs.results = qusage(eset, labels, contrast, ISG.geneSet)


###################################################
### code chunk number 8: pValSimple
###################################################
pdf.pVal(qs.results)


###################################################
### code chunk number 9: plotCodeSimple (eval = FALSE)
###################################################
## plot(qs.results, xlab="Gene Set Activation")


###################################################
### code chunk number 10: plotSimple
###################################################
getOption("SweaveHooks")[["fig"]]()
plot(qs.results, xlab="Gene Set Activation")


###################################################
### code chunk number 11: read.MSIG.geneSets (eval = FALSE)
###################################################
##   MSIG.geneSets = read.gmt("c2.cp.kegg.v4.0.symbols.gmt")


###################################################
### code chunk number 12: MSIG.geneSets
###################################################
  summary(MSIG.geneSets[1:5])
  MSIG.geneSets[2]

  qs.results.msig = qusage(eset, labels, contrast, MSIG.geneSets)
  numPathways(qs.results.msig)


###################################################
### code chunk number 13: multiHypCorr
###################################################
  p.vals = pdf.pVal(qs.results.msig)
  head(p.vals)
  q.vals = p.adjust(p.vals, method="fdr")
  head(q.vals)


###################################################
### code chunk number 14: qusage.Rnw:150-151
###################################################
  options(width=100)


###################################################
### code chunk number 15: qsTable
###################################################
  qsTable(qs.results.msig, number=10)


###################################################
### code chunk number 16: qusage.Rnw:158-159
###################################################
  options(width=70)


###################################################
### code chunk number 17: plotCIs
###################################################
getOption("SweaveHooks")[["fig"]]()
par(mar=c(10,4,1,2))
plot(qs.results.msig)


###################################################
### code chunk number 18: pairVector
###################################################
  pairs = c(1:17,1:17)
  pairs


###################################################
### code chunk number 19: twoWayLabels
###################################################
  resp
  twoWay.labels = paste(resp, labels, sep=".")
  twoWay.labels


###################################################
### code chunk number 20: twoWayRun
###################################################
  sx.results  = qusage(eset, twoWay.labels, "sx.t1-sx.t0",
                       MSIG.geneSets, pairVector=pairs)
  asx.results = qusage(eset, twoWay.labels, "asx.t1-asx.t0", 
                       MSIG.geneSets, pairVector=pairs)


###################################################
### code chunk number 21: twoCurvePval
###################################################
  p.vals = twoCurve.pVal(sx.results,asx.results)
  head(p.vals)


###################################################
### code chunk number 22: twoWayComplex
###################################################
  asx.vs.sx = qusage(eset, twoWay.labels, "(sx.t1-sx.t0) - (asx.t1-asx.t0)",
                   MSIG.geneSets, pairVector=pairs)

  p.vals = pdf.pVal(asx.vs.sx)
  head(p.vals)


###################################################
### code chunk number 23: twoWayDensityCurvesCode
###################################################
  plotDensityCurves(asx.results,path.index=125,xlim=c(-0.2,0.5),
                    col=3,main="CYTOSOLIC DNA SENSING")
  plotDensityCurves(sx.results,path.index=125,col=2,add=T)
  plotDensityCurves(asx.vs.sx, path.index=125,col=1,add=T, lwd=3)
  legend("topleft", legend=c("asx","sx","asx-sx"),lty=1,col=c(2:3,1),
         lwd=c(1,1,3))


###################################################
### code chunk number 24: twoWayDensityCurves
###################################################
getOption("SweaveHooks")[["fig"]]()
  plotDensityCurves(asx.results,path.index=125,xlim=c(-0.2,0.5),
                    col=3,main="CYTOSOLIC DNA SENSING")
  plotDensityCurves(sx.results,path.index=125,col=2,add=T)
  plotDensityCurves(asx.vs.sx, path.index=125,col=1,add=T, lwd=3)
  legend("topleft", legend=c("asx","sx","asx-sx"),lty=1,col=c(2:3,1),
         lwd=c(1,1,3))


###################################################
### code chunk number 25: plotGSD
###################################################
getOption("SweaveHooks")[["fig"]]()
plotGeneSetDistributions(sx.results,asx.results,path.index=125)


###################################################
### code chunk number 26: plotCIsGenes
###################################################
getOption("SweaveHooks")[["fig"]]()
par(mar=c(8,4,1,2))
plotCIsGenes(sx.results,path.index=125)


###################################################
### code chunk number 27: qgen_fluexpr
###################################################
dim(eset.full)

eset.full[1:5,1:5]


###################################################
### code chunk number 28: qgen_design
###################################################
head(flu.meta)


###################################################
### code chunk number 29: qgen_fixedSimple
###################################################
fixedeffects <- ~Hours+Condition+Condition*Hours+Age+Gender


###################################################
### code chunk number 30: qgen_contrast.factor
###################################################
con.fac <- ~Condition*Hours


###################################################
### code chunk number 31: qgen_contrast2
###################################################
contrast = "sx77 - sx0"


###################################################
### code chunk number 32: qgen_geneSet
###################################################
ISG.geneSet[1:10]


###################################################
### code chunk number 33: qgen_randomeffect
###################################################
qusage.result.random<-qgen(eset.full,flu.meta,
                           fixed=fixedeffects,
                           contrast.factor=con.fac, 
                           contrast=contrast,
                           geneSets=ISG.geneSet,
                           random=~1|Subject,
                           design.sampleid="SampleID")


###################################################
### code chunk number 34: qgen_randomResult
###################################################
qsTable(qusage.result.random)


###################################################
### code chunk number 35: qgen_correlation (eval = FALSE)
###################################################
## corStruct = corExp(value=3,~Hours.Numeric|Subject)
## corStruct
## 
## qusage.result.corstruct<-qgen(eset.full,flu.meta,
##                               fixed=fixedeffects,
##                               contrast.factor=con.fac, 
##                               contrast=contrast,
##                               geneSets=ISG.geneSet,
##                               correlation=corStruct,
##                               design.sampleid="SampleID")


###################################################
### code chunk number 36: qgen_plot (eval = FALSE)
###################################################
##   plotDensityCurves(qusage.result.random, main="ISG_geneSet", 
##                     xlim=c(0,1.2), xlab="Day 77 - Day 0", col="red")
##   plotDensityCurves(qusage.result.corstruct, col="blue",add=T)


###################################################
### code chunk number 37: plotQgen (eval = FALSE)
###################################################
getOption("SweaveHooks")[["fig"]]()
##   plotDensityCurves(qusage.result.random, main="ISG_geneSet", 
##                     xlim=c(0,1.2), xlab="Day 77 - Day 0", col="red")
##   plotDensityCurves(qusage.result.corstruct, col="blue",add=T)


###################################################
### code chunk number 38: LoadMetaSets
###################################################
data("fluVaccine")


###################################################
### code chunk number 39: BTM (eval = FALSE)
###################################################
## read.gmt("BTM_for_GSEA_20131008.gmt")


###################################################
### code chunk number 40: GSE59635_desc
###################################################
head(fluVaccine$phenoData[["GSE59635"]])


###################################################
### code chunk number 41: GSE59654_desc
###################################################
head(fluVaccine$phenoData[["GSE59654"]])


###################################################
### code chunk number 42: metaAnalysis_Qusage
###################################################
qs.results.list = lapply(c("GSE59635", "GSE59654"), function(n){
  eset = fluVaccine$esets[[n]]
  phenoData = fluVaccine$phenoData[[n]]
  labels = paste(phenoData$responder, phenoData$bloodDrawDay, 
                 sep = ".")
  ##run QuSAGE
  qusage(eset, labels, "(high.d7-high.d0)-(low.d7-low.d0)", 
            BTM.geneSets, pairVector=phenoData$subjectId, n.points=2^14)
})


###################################################
### code chunk number 43: metaAnalysis_combinePDFs
###################################################
combined = combinePDFs(qs.results.list)


###################################################
### code chunk number 44: metaAnalysis_pval
###################################################
head(pdf.pVal(combined))


###################################################
### code chunk number 45: metaAnalysis_plot
###################################################
  plotCombinedPDF(combined, path.index=235)
  legend("topleft", legend=c("GSE59635", "GSE59654", "Meta-analysis"), 
         lty=1, col=c("red", "blue","black"))



###################################################
### code chunk number 46: plotMeta
###################################################
getOption("SweaveHooks")[["fig"]]()
  plotCombinedPDF(combined, path.index=235)
  legend("topleft", legend=c("GSE59635", "GSE59654", "Meta-analysis"), 
         lty=1, col=c("red", "blue","black"))



###################################################
### code chunk number 47: prettyPDF
###################################################
##select the best 5 gene sets
p.vals = pdf.pVal(qs.results.msig)
topSets = order(p.vals)[1:5]

##plot 
plotDensityCurves(qs.results.msig, path.index=topSets, col=1:5, 
                  lwd=2, xlab=expression(log[2](Activity)))


###################################################
### code chunk number 48: plotPDF
###################################################
getOption("SweaveHooks")[["fig"]]()
##select the best 5 gene sets
p.vals = pdf.pVal(qs.results.msig)
topSets = order(p.vals)[1:5]

##plot 
plotDensityCurves(qs.results.msig, path.index=topSets, col=1:5, 
                  lwd=2, xlab=expression(log[2](Activity)))


###################################################
### code chunk number 49: createCDF
###################################################
##get coordinates
coord.list = plotDensityCurves(qs.results, plot=FALSE)
coords = coord.list[[1]]
x=coords$x
##Calculate the CDF as the integral of the PDF at each point.
y = cumsum(coords$y)/sum(coords$y)

plot(x,y, type="l", xlim=calcBayesCI(qs.results,low=0.001)[,1])


###################################################
### code chunk number 50: plotCDF
###################################################
getOption("SweaveHooks")[["fig"]]()
##get coordinates
coord.list = plotDensityCurves(qs.results, plot=FALSE)
coords = coord.list[[1]]
x=coords$x
##Calculate the CDF as the integral of the PDF at each point.
y = cumsum(coords$y)/sum(coords$y)

plot(x,y, type="l", xlim=calcBayesCI(qs.results,low=0.001)[,1])


###################################################
### code chunk number 51: plotISG_GSD
###################################################
getOption("SweaveHooks")[["fig"]]()
plotGeneSetDistributions(qs.results)


###################################################
### code chunk number 52: plotGSDHighlight
###################################################
getOption("SweaveHooks")[["fig"]]()
path = 125 ##the CYTOSOLIC_DNA_SENSING pathway
path.gene.i = sx.results$pathways[[path]] ##the genes are stored as indexes
path.genes = rownames(eset)[path.gene.i]

cols = rep("#33333399",length(path.genes))
##make the IFNA genes red, and the IFNB genes blue.
cols[path.genes=="CXCL10"] = "#FF0000"

plotGeneSetDistributions(sx.results,asx.results,path.index=125, 
                         groupLabel=c("Symptomatic","Asymptomatic"),
                         colorScheme=cols, barcode.col=cols)


