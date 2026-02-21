# Code example from 'GlobalAncova' vignette. See references/ for full tutorial.

### R code from vignette source 'GlobalAncova.rnw'

###################################################
### code chunk number 1: GlobalAncova.rnw:41-45
###################################################
#library(Biobase)
library(GlobalAncova)
library(globaltest)
sI <- sessionInfo()


###################################################
### code chunk number 2: initialize
###################################################
library(GlobalAncova)
library(globaltest)
library(golubEsets)
library(hu6800.db)
library(vsn)

data(Golub_Merge)
golubX <- justvsn(Golub_Merge)


###################################################
### code chunk number 3: GlobalAncova.rnw:197-198
###################################################
options(width=70)


###################################################
### code chunk number 4: all
###################################################
gr <- as.numeric(golubX$ALL.AML=="ALL")
ga.all <- GlobalAncova(xx=exprs(golubX), group=gr, covars=NULL, perm=100)


###################################################
### code chunk number 5: all2 (eval = FALSE)
###################################################
## GlobalAncova(xx=exprs(golubX), formula.full=~ALL.AML, formula.red=~1, 
##              model.dat=pData(golubX), perm=100)
## GlobalAncova(xx=exprs(golubX), formula.full=~ALL.AML, test.terms="ALL.AMLAML",
##              model.dat=pData(golubX), perm=100)


###################################################
### code chunk number 6: all.display
###################################################
ga.all 


###################################################
### code chunk number 7: gt.all
###################################################
gt.all <- gt(ALL.AML, golubX)


###################################################
### code chunk number 8: GlobalAncova.rnw:277-278
###################################################
gt.all


###################################################
### code chunk number 9: loadKEGG
###################################################
kegg <- as.list(hu6800PATH2PROBE)


###################################################
### code chunk number 10: GlobalAncova.rnw:294-295
###################################################
cellcycle <- kegg[["04110"]]


###################################################
### code chunk number 11: cc (eval = FALSE)
###################################################
## cellcycle <- kegg[["04110"]]


###################################################
### code chunk number 12: cellcycle
###################################################
ga.cc <- GlobalAncova(xx=exprs(golubX), group=gr, test.genes=cellcycle, 
                      method="both", perm=1000) 
ga.cc


###################################################
### code chunk number 13: gt.cellcycle
###################################################
gt.cc <- gt(ALL.AML, golubX, subsets=cellcycle)
gt.cc


###################################################
### code chunk number 14: GlobalAncova.rnw:323-324
###################################################
gt.cc


###################################################
### code chunk number 15: adjust
###################################################
ga.cc.BMPB <- GlobalAncova(xx=exprs(golubX), group=gr, covars=golubX$BM.PB, 
                           test.genes=cellcycle, method="both", perm=1000) 
ga.cc.BMPB


###################################################
### code chunk number 16: gt.adjust
###################################################
gt.cc.BMPB <- gt(ALL.AML ~ BM.PB, golubX, subsets=cellcycle)
gt.cc.BMPB


###################################################
### code chunk number 17: GlobalAncova.rnw:355-356
###################################################
gt.cc.BMPB


###################################################
### code chunk number 18: GlobalAncova.rnw:366-369
###################################################
data(vantVeer)
data(phenodata)	
data(pathways)	


###################################################
### code chunk number 19: vV
###################################################
data(vantVeer)
data(phenodata)	
data(pathways)
metastases <- phenodata$metastases
p53 <- pathways$p53_signalling	


###################################################
### code chunk number 20: p53test
###################################################
vV.1 <- GlobalAncova(xx=vantVeer, group=metastases, test.genes=p53, 
                     method="both", perm=1000)
vV.1


###################################################
### code chunk number 21: grade
###################################################
vV.3 <- GlobalAncova(xx=vantVeer, formula.full=~grade, formula.red=~1, 
          model.dat=phenodata, test.genes=p53, method="both", perm=1000)
vV.3


###################################################
### code chunk number 22: interact
###################################################
signature.gene <- "AL137718"
model <- data.frame(phenodata, signature.gene=vantVeer[signature.gene, ])
vV.4 <- GlobalAncova(xx=vantVeer, formula.full=~signature.gene + ERstatus,
                     formula.red=~ERstatus, model.dat=model, test.genes=p53,
                     method="both", perm=1000)
vV.4


###################################################
### code chunk number 23: coexpr
###################################################
vV.5 <- GlobalAncova(xx=vantVeer, formula.full=~metastases + signature.gene + ERstatus, 
                     formula.red=~metastases + ERstatus, model.dat=model, 
                     test.genes=p53, method="both", perm=1000)
vV.5


###################################################
### code chunk number 24: diffcoexpr
###################################################
vV.6 <- GlobalAncova(xx=vantVeer, formula.full=~metastases * signature.gene + ERstatus, 
                     formula.red=~metastases + signature.gene + ERstatus, 
                     model.dat=model, test.genes=p53, method="both", perm=1000)
vV.6


###################################################
### code chunk number 25: pathways
###################################################
metastases <- phenodata$metastases
ga.pw <- GlobalAncova(xx=vantVeer, group=metastases, test.genes=pathways[1:4],
                      method="both", perm=1000) 
ga.pw


###################################################
### code chunk number 26: gt.pathways
###################################################
gt.options(transpose = TRUE)
gt.pw <- gt(metastases, vantVeer, subsets=pathways[1:4])
gt.pw


###################################################
### code chunk number 27: GlobalAncova.rnw:529-535
###################################################
ga.pw.raw <- ga.pw[ ,"p.perm"] 
ga.pw.adj <- p.adjust(ga.pw.raw, "holm")
ga.result <- data.frame(rawp=ga.pw.raw, Holm=ga.pw.adj)
ga.result
gt.result <- p.adjust(gt.pw)
gt.result


###################################################
### code chunk number 28: hypoth
###################################################
if(require(Rgraphviz))
{
res <- GlobalAncova:::Hnull.family(pathways[1:4])
graph <- new("graphNEL", nodes=names(res), edgemode="directed")
graph <- addEdge(from=c(rep(names(res)[15],4),rep(names(res)[10],3),rep(names(res)[11],3),
  rep(names(res)[13],3),rep(names(res)[14],3),rep(names(res)[5],2),rep(names(res)[6],2),
  rep(names(res)[7],2),rep(names(res)[8],2),rep(names(res)[9],2),rep(names(res)[12],2)), 
  to=c(names(res)[10],names(res)[11],names(res)[13],names(res)[14],names(res)[5],names(res)[6],
  names(res)[8],names(res)[5],names(res)[7],names(res)[9],names(res)[6],names(res)[7],names(res)[12],
  names(res)[8],names(res)[9],names(res)[12],names(res)[1],names(res)[2],names(res)[1],names(res)[3],
  names(res)[1],names(res)[4],names(res)[2],names(res)[3],names(res)[2],names(res)[4],names(res)[3],
  names(res)[4]), graph, weights=rep(1, 28))

att <- list()
lab <- c("1","2","3","4","1-2","1-3","1-4","2-3","2-4","1-2-3","1-2-4","3-4","1-3-4","2-3-4","1-2-3-4")
names(lab) <- names(res)
att$label <- lab

plot(graph, nodeAttrs=att)
} else {
plot(1, 1, type="n", main="This plot requires Rgraphviz", 
     axes=FALSE, xlab="", ylab="")
}


###################################################
### code chunk number 29: closed.test
###################################################
ga.closed <- GlobalAncova.closed(xx=vantVeer, group=metastases, 
                                 test.genes=pathways[1:4], previous.test=ga.pw,
                                 level=0.05, method="approx")


###################################################
### code chunk number 30: names.closed.test
###################################################
names(ga.closed)
rownames(ga.closed$test.results[[1]])
rownames(ga.closed$test.results[[1]]) <- NULL
ga.closed$test.results[1]
ga.closed$significant
ga.closed$not.significant


###################################################
### code chunk number 31: gago
###################################################
library(GO.db)
descendants <- get("GO:0007049", GOBPOFFSPRING)
gago <- GAGO(xx=exprs(golubX), formula.full=~ALL.AML, formula.red=~1, 
             model.dat=pData(golubX), id=c("GO:0007049", descendants),
             annotation="hu6800", ontology="BP", multtest="focuslevel")


###################################################
### code chunk number 32: GlobalAncova.rnw:645-646
###################################################
head(gago)


###################################################
### code chunk number 33: gabroad (eval = FALSE)
###################################################
## broad <- getBroadSets("your/path/to/msigdb_v.2.5.xml")
## GABroad(xx=exprs(golubX), formula.full=~ALL.AML, formula.red=~1, 
##         model.dat=pData(golubX), id="chr5q33", collection=broad, 
##         annotation="hu6800")


###################################################
### code chunk number 34: gabroad2 (eval = FALSE)
###################################################
## GABroad(xx=exprs(golubX), formula.full=~ALL.AML, formula.red=~1, 
##         model.dat=pData(golubX), category=c("c1", "c3"), collection=broad,
##         annotation="hu6800", multtest="holm")


###################################################
### code chunk number 35: geneplot
###################################################
Plot.genes(xx=vantVeer, group=metastases, test.genes=p53)
gt.vV <- gt(metastases, vantVeer, subsets=p53)
features(gt.vV, what="w")


###################################################
### code chunk number 36: genes
###################################################
Plot.genes(xx=vantVeer, group=metastases, test.genes=p53)


###################################################
### code chunk number 37: gt_genes
###################################################
features(gt.vV, what="w")


###################################################
### code chunk number 38: geneplot2
###################################################
Plot.genes(xx=vantVeer, formula.full=~metastases, formula.red=~1, 
           model.dat=phenodata, test.genes=p53, Colorgroup="ERstatus")


###################################################
### code chunk number 39: genes2
###################################################
Plot.genes(xx=vantVeer, formula.full=~metastases, formula.red=~1, 
           model.dat=phenodata, test.genes=p53, Colorgroup="ERstatus")


###################################################
### code chunk number 40: subjectsplot
###################################################
#colnames(exprs(golubX)) <- pData(golubX)[ ,1]
Plot.subjects(xx=vantVeer, group=metastases, test.genes=p53, legendpos="bottomright")
subjects(gt.vV, what="w")


###################################################
### code chunk number 41: subjects
###################################################
Plot.subjects(xx=vantVeer, group=metastases, test.genes=p53, legendpos="bottomright")


###################################################
### code chunk number 42: gt_subjects
###################################################
subjects(gt.vV, what="w")


###################################################
### code chunk number 43: subjectsplot2
###################################################
Plot.subjects(xx=vantVeer, formula.full=~grade, formula.red=~1, 
              model.dat=phenodata, test.genes=p53, Colorgroup="grade", legendpos="topleft")


###################################################
### code chunk number 44: subjects2
###################################################
Plot.subjects(xx=vantVeer, formula.full=~grade, formula.red=~1, model.dat=phenodata, test.genes=p53, Colorgroup="grade", legendpos="topleft")


###################################################
### code chunk number 45: gGA
###################################################
data(bindata)
X <- as.matrix(bindata[,-1])

gGlobalAncova(X, formula.full=~group, model.dat=bindata, perm=1000)


###################################################
### code chunk number 46: gGAmulti
###################################################
gGlobalAncova(X, formula.full=~group, model.dat=bindata, 
              Sets=list(2:5, 6:10, 19:24), perm=1000)


###################################################
### code chunk number 47: plotfeatures
###################################################
Plot.features(X, formula.full=~group, model.dat=bindata)


###################################################
### code chunk number 48: hierarchical
###################################################
# get a hierarchy for variables
dend <- as.dendrogram(hclust(dist(t(X))))

# hierarchical test
set.seed(555)
res <- gGlobalAncova.hierarchical(X, H=dend, formula.full=~group, 
                                  model.dat=bindata, alpha=0.05, perm=1000)


###################################################
### code chunk number 49: hierres
###################################################
res
results(res)


###################################################
### code chunk number 50: signodes
###################################################
# get names of significant clusters
sigEndnodes(res)
sigEndnodes(res, onlySingleton=TRUE)


###################################################
### code chunk number 51: plothier
###################################################
# visualize results
Plot.hierarchy(res, dend)


###################################################
### code chunk number 52: shortcut
###################################################
# starting with 3 sub-hierarchies
set.seed(555)
res2 <- gGlobalAncova.hierarchical(X, H=dend, K=3, formula.full=~group, 
                                   model.dat=bindata, alpha=0.05, perm=1000)

results(res2)


###################################################
### code chunk number 53: GlobalAncova.rnw:977-978
###################################################
sessionInfo()


