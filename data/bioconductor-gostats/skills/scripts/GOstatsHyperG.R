# Code example from 'GOstatsHyperG' vignette. See references/ for full tutorial.

## ----Setup, echo=TRUE, message=FALSE------------------------------------------
library("ALL")
library("hgu95av2.db")
library("GO.db") 
library("annotate")
library("genefilter") 
library("GOstats") 
library("RColorBrewer")
library("xtable") 
library("Rgraphviz")

## ----universeSizeVsPvalue, eval=TRUE, echo=FALSE, results='hide'--------------
hg_tester <-function(size){
  numFound <- 10 
  numDrawn <- 400 
  numAtCat <- 40
  numNotAtCat <- size - numAtCat 
  phyper(numFound-1, numAtCat,numNotAtCat, numDrawn, lower.tail=FALSE)
}
pv1000 <- hg_tester(1000)
pv5000 <- hg_tester(5000)

## ----bcrAblOrNegSubset, results='hide', echo=TRUE, cache=TRUE-----------------
data(ALL, package="ALL") 
## For this data we can have ALL1/AF4 or BCR/ABL 
subsetType <- "ALL1/AF4"
## Subset of interest: 37BRC/ABL + 42NEG = 79 samples 
Bcell <- grep("^B", as.character(ALL$BT))
bcrAblOrNegIdx <- which(as.character(ALL$mol) %in% c("NEG", subsetType))
bcrAblOrNeg <- ALL[, intersect(Bcell, bcrAblOrNegIdx)]
bcrAblOrNeg$mol.biol = factor(bcrAblOrNeg$mol.biol)

## ----nsFiltering-noEntrez, results='hide', echo=TRUE, cache=TRUE--------------
##Remove genes that have no entrezGene id 
entrezIds <- mget(featureNames(bcrAblOrNeg), envir=hgu95av2ENTREZID) 
haveEntrezId <- names(entrezIds)[sapply(entrezIds, function(x) !is.na(x))]
numNoEntrezId <- length(featureNames(bcrAblOrNeg)) - length(haveEntrezId) 
bcrAblOrNeg <- bcrAblOrNeg[haveEntrezId, ]

## ----nsFiltering-noGO, results='hide', echo=TRUE, cache=FALSE-----------------
## Remove genes with no GO mapping 
haveGo <- sapply(mget(featureNames(bcrAblOrNeg), hgu95av2GO), 
                 function(x){
                   if (length(x) == 1 && is.na(x)) 
                     FALSE 
                   else TRUE 
                   })
numNoGO <- sum(!haveGo)
bcrAblOrNeg <- bcrAblOrNeg[haveGo, ]

## ----nsFiltering-IQR, results='hide', echo=TRUE, cache=TRUE-------------------
## Non-specific filtering based on IQR 
iqrCutoff <- 0.5 
bcrAblOrNegIqr <- apply(exprs(bcrAblOrNeg), 1, IQR) 
selected <- bcrAblOrNegIqr > iqrCutoff

## Drop those that are on the Y chromosome 
## because there is an imbalance of men and women by group 
chrN <- mget(featureNames(bcrAblOrNeg), envir=hgu95av2CHR) 
onY <- sapply(chrN, function(x) any(x=="Y"))
onY[is.na(onY)] <- FALSE
selected <- selected & !onY

nsFiltered <- bcrAblOrNeg[selected, ]

## ----nsFiltering-unique, results='hide', echo=TRUE, cache=TRUE----------------
numNsWithDups <- length(featureNames(nsFiltered))
nsFilteredIqr <- bcrAblOrNegIqr[selected] 
uniqGenes <- findLargest(featureNames(nsFiltered), nsFilteredIqr, 
                         "hgu95av2")
nsFiltered <- nsFiltered[uniqGenes, ] 
numSelected <- length(featureNames(nsFiltered))

##set up some colors 
BCRcols = ifelse(nsFiltered$mol == subsetType, "goldenrod", "skyblue")
cols = brewer.pal(10, "RdBu")

## ----defineGeneUniverse, echo=TRUE, results='hide', cache=TRUE----------------
## Define gene universe based on results of non-specific filtering
affyUniverse <- featureNames(nsFiltered)
entrezUniverse <- unlist(mget(affyUniverse, hgu95av2ENTREZID))
if (any(duplicated(entrezUniverse)))
  stop("error in gene universe: can't have duplicate Entrez Gene Ids")

## Also define an alternate universe based on the entire chip
chipAffyUniverse <- featureNames(bcrAblOrNeg)
chipEntrezUniverse <- mget(chipAffyUniverse, hgu95av2ENTREZID)
chipEntrezUniverse <- unique(unlist(chipEntrezUniverse)) 

## ----parametric1, echo=TRUE, results='hide', cache=TRUE-----------------------
ttestCutoff <- 0.05
ttests = rowttests(nsFiltered, "mol.biol")

smPV = ttests$p.value < ttestCutoff

pvalFiltered <- nsFiltered[smPV, ] 
selectedEntrezIds <- unlist(mget(featureNames(pvalFiltered), 
                                 hgu95av2ENTREZID))

## ----eval=FALSE---------------------------------------------------------------
# resultList <- lapply(lisOfParamObjs, hyperGTest)

## ----withYourData1, eval=FALSE------------------------------------------------
# entrezUniverse <- unlist(mget(featureNames(yourData),
#                               hgu95av2ENTREZID))
# if (any(duplicated(entrezUniverse)))
#  stop(\"error in gene universe: can't have duplicate Entrez Gene Ids")
# 
# pvalFiltered <- yourData[hasSmallPvalue, ]
# selectedEntrezIds <-unlist(mget(featureNames(pvalFiltered),
#                                 hgu95av2ENTREZID))

## ----standardHyperGeo, echo=TRUE, results='hide', cache=TRUE------------------
hgCutoff<- 0.001 
params <- new("GOHyperGParams", 
              geneIds=selectedEntrezIds,
              universeGeneIds=entrezUniverse, 
              annotation="hgu95av2.db",
              ontology="BP", 
              pvalueCutoff=hgCutoff, 
              conditional=FALSE,
              testDirection="over")

## ----condHyperGeo, echo=TRUE, results='hide', cache=TRUE----------------------
paramsCond <- params 
conditional(paramsCond) <- TRUE 

## ----standardHGTEST, cache=TRUE, echo=TRUE, results='hide'--------------------
hgOver <- hyperGTest(params)
hgCondOver <- hyperGTest(paramsCond)

## ----HGTestAns----------------------------------------------------------------
hgOver 
hgCondOver

## ----summaryEx----------------------------------------------------------------
df <- summary(hgOver)
names(df) # the columns 
dim(summary(hgOver, pvalue=0.1))
dim(summary(hgOver, categorySize=10)) 

## ----resultAccessors----------------------------------------------------------
pvalues(hgOver)[1:3]

oddsRatios(hgOver)[1:3]

expectedCounts(hgOver)[1:3]

geneCounts(hgOver)[1:3]
universeCounts(hgOver)[1:3]

length(geneIds(hgOver)) 
length(geneIdUniverse(hgOver)[[3]])

## GOHyperGResult _only_ 
## (NB: edges go from parent to child)
goDag(hgOver)

geneMappedCount(hgOver) 
universeMappedCount(hgOver)

conditional(hgOver) 
testDirection(hgOver)
testName(hgOver)

## ----htmlReportExample, results='hide', echo=TRUE-----------------------------
htmlReport(hgCondOver, file="ALL_hgco.html")

## ----helperFunc, echo=FALSE, results='hide', cache=TRUE-----------------------
sigCategories <- function(res, p){
  if (missing(p)) 
    p <- pvalueCutoff(res) 
  pv <- pvalues(res) 
  goIds <- names(pv[pv < p])
  goIds 
}

## ----plotFuns, echo=FALSE, results='hide', cache=TRUE-------------------------
coloredGoPlot <- function(ccMaxGraph, hgOver, hgCondOver) {
  nodeColors <- sapply(nodes(ccMaxGraph),
                       function(n) {
                         if (n %in% sigCategories(hgCondOver))
                             "dark red"
                          else if (n %in% sigCategories(hgOver))
                            "pink" 
                          else 
                            "gray"
                        }) 
 nattr <- makeNodeAttrs(ccMaxGraph,
                        label=nodes(ccMaxGraph), 
                        shape="ellipse", 
                        fillcolor=nodeColors,
                        fixedsize=FALSE)
 plot(ccMaxGraph, nodeAttrs=nattr)
}

getMaxConnCompGraph <- function(hgOver, hgCondOver){
  ##uGoDagRev \<-ugraph(goDag(hgOver)) 
  sigNodes <- sigCategories(hgOver) 
  ##adjNodes \<- unlist(adj(uGoDagRev, sigNodes))
  adjNodes <- unlist(adj(goDag(hgOver),sigNodes))
  displayNodes <- unique(c(sigNodes, adjNodes)) 
  displayGraph <- subGraph(displayNodes, goDag(hgOver))
  cc <- connComp(displayGraph)
  ccSizes <- listLen(cc) 
  ccMaxIdx <- which(ccSizes == max(ccSizes))
  ccMaxGraph <- subGraph(cc[[ccMaxIdx]], displayGraph)
  ccMaxGraph
}


## ----info---------------------------------------------------------------------
sessionInfo()

