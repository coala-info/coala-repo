# Code example from 'clipper' vignette. See references/ for full tutorial.

### R code from vignette source 'clipper.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: cppr
###################################################
options(keep.source = TRUE, width = 60)
cppr <- packageDescription("clipper")


###################################################
### code chunk number 3: loadGraphitePathways
###################################################
library(graphite)
kegg  <- pathways("hsapiens", "kegg")
graph <- convertIdentifiers(kegg[["Chronic myeloid leukemia"]], "entrez")
graph <- pathwayGraph(graph)
genes <- nodes(graph)
head(genes)


###################################################
### code chunk number 4: loadDataAndClasses
###################################################
library(ALL)
data(ALL)


###################################################
### code chunk number 5: lookPhenoData
###################################################
head(pData(ALL))
dim(pData(ALL))


###################################################
### code chunk number 6: Bcell-selection
###################################################
pData(ALL)$BT
pAllB <- pData(ALL)[grep("B", pData(ALL)$BT),]
dim(pAllB)


###################################################
### code chunk number 7: mol.biolSelection
###################################################
pAllB$'mol.biol'
NEG <- pAllB$'mol.biol' == "NEG"
BCR <- pAllB$'mol.biol' == "BCR/ABL"
pAll <- pAllB[(NEG | BCR),]


###################################################
### code chunk number 8: builtClassesVector
###################################################
classesUn <- as.character(pAll$'mol.biol')
classesUn[classesUn=="BCR/ABL"] <- 2
classesUn[classesUn=="NEG"] <- 1
classesUn <- as.numeric(classesUn)
names(classesUn) <- row.names(pAll)
classes <- sort(classesUn)


###################################################
### code chunk number 9: selectExpressionSet
###################################################
library("hgu95av2.db")
all <- ALL[,names(classes)]
probesIDS <- row.names(exprs(all))
featureNames(all@assayData)<-unlist(mget(probesIDS, hgu95av2ENTREZID))
all <- all[(!is.na(row.names(exprs(all))))]


###################################################
### code chunk number 10: clipper.Rnw:126-128
###################################################
all_rnames <- featureNames(all@assayData)
featureNames(all@assayData) <- paste("ENTREZID", all_rnames, sep = ":")


###################################################
### code chunk number 11: obtainingTheSubgraph
###################################################
library(graph)
genes <- intersect(genes, row.names(exprs(all)))
graph <- subGraph(genes, graph)
exp <- all[genes,,drop=FALSE]
exp
dim(exprs(exp))


###################################################
### code chunk number 12: pathQUsage
###################################################
library(clipper)
pathwayAnalysis <- pathQ(exp, classes, graph, nperm=100, alphaV=0.05, b=100)
pathwayAnalysis


###################################################
### code chunk number 13: clipperUsage
###################################################
clipped <- clipper(exp, classes, graph, "var", trZero=0.01, permute=FALSE)
clipped[,1:5]


###################################################
### code chunk number 14: sintetizeYourResult
###################################################
clipped <- prunePaths(clipped, thr=0.2)
clipped[,1:5]


###################################################
### code chunk number 15: easyClip usage
###################################################
clipped <- easyClip(exp, classes, graph, method="mean")
clipped[,1:5]


###################################################
### code chunk number 16: easylook usage
###################################################
easyLook(clipped)


