# Code example from 'HTSanalyzeR-Vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'HTSanalyzeR-Vignette.Rnw'

###################################################
### code chunk number 1: Ropts
###################################################
options(width=70)


###################################################
### code chunk number 2: setup
###################################################
library(HTSanalyzeR)
library(GSEABase)
library(cellHTS2)
library(org.Dm.eg.db)
library(GO.db)
library(KEGG.db)


###################################################
### code chunk number 3: cellHTSRead
###################################################
experimentName <- "KcViab"
dataPath <- system.file(experimentName, package = "cellHTS2")
x <- readPlateList("Platelist.txt", name = experimentName, 
path = dataPath,verbose=TRUE)


###################################################
### code chunk number 4: cellHTSConfig
###################################################
x <- configure(x, descripFile = "Description.txt", confFile = 
"Plateconf.txt", logFile = "Screenlog.txt", path = dataPath)


###################################################
### code chunk number 5: cellHTSNorm
###################################################
xn <- normalizePlates(x, scale = "multiplicative", log = FALSE, 
method = "median", varianceAdjust = "none")


###################################################
### code chunk number 6: cellHTSNorm
###################################################
xn <- annotate(xn, geneIDFile = "GeneIDs_Dm_HFA_1.1.txt", 
path = dataPath)


###################################################
### code chunk number 7: cellHTSScore
###################################################
xsc <- scoreReplicates(xn, sign = "-", method = "zscore")


###################################################
### code chunk number 8: cellHTSSum
###################################################
xsc <- summarizeReplicates(xsc, summary = "mean")	


###################################################
### code chunk number 9: showXSC
###################################################
xsc


###################################################
### code chunk number 10: getDataFromCellHTS
###################################################
data4enrich <- as.vector(Data(xsc))
names(data4enrich) <- fData(xsc)[, "GeneID"]
data4enrich <- data4enrich[which(!is.na(names(data4enrich)))]


###################################################
### code chunk number 11: selectHits
###################################################
hits <- names(data4enrich)[which(abs(data4enrich) > 2)]


###################################################
### code chunk number 12: gscList
###################################################
GO_MF <- GOGeneSets(species="Dm", ontologies=c("MF"))
GO_BP <- GOGeneSets(species="Dm", ontologies=c("BP"))
PW_KEGG <- KeggGeneSets(species="Dm")
ListGSC <- list(GO_MF=GO_MF, GO_BP=GO_BP, PW_KEGG=PW_KEGG)


###################################################
### code chunk number 13: gscaInit
###################################################
gsca <- new("GSCA", listOfGeneSetCollections=ListGSC, 
geneList=data4enrich, hits=hits)
gsca <- preprocess(gsca, species="Dm", initialIDs="FlybaseCG", 
keepMultipleMappings=TRUE, duplicateRemoverMethod="max", 
orderAbsValue=FALSE)


###################################################
### code chunk number 14: gscaAnalyses
###################################################
gsca<-analyze(gsca, para=list(pValueCutoff=0.05, pAdjustMethod
="BH", nPermutations=100, minGeneSetSize=180, exponent=1))


###################################################
### code chunk number 15: HTSanalyzeR-Vignette.Rnw:214-216 (eval = FALSE)
###################################################
## library(snow)
## options(cluster=makeCluster(4, "SOCK"))


###################################################
### code chunk number 16: HTSanalyzeR-Vignette.Rnw:221-225 (eval = FALSE)
###################################################
## if(is(getOption("cluster"), "cluster")) {
## 	stopCluster(getOption("cluster"))
## 	options(cluster=NULL)
## }


###################################################
### code chunk number 17: gscaSum
###################################################
summarize(gsca)


###################################################
### code chunk number 18: selectSigGS
###################################################
topGS_GO_MF <- getTopGeneSets(gsca, "GSEA.results", c("GO_MF", 
"PW_KEGG"), allSig=TRUE)


###################################################
### code chunk number 19: printTopGSs
###################################################
topGS_GO_MF


###################################################
### code chunk number 20: viewGSEARandWalk
###################################################
viewGSEA(gsca, "GO_MF", topGS_GO_MF[["GO_MF"]][1])


###################################################
### code chunk number 21: HTSanalyzeR-Vignette.Rnw:263-265 (eval = FALSE)
###################################################
## plotGSEA(gsca, gscs=c("GO_BP","GO_MF","PW_KEGG"), 
## ntop=1, filepath=".")


###################################################
### code chunk number 22: viewEnrichMap1_a
###################################################
data("KcViab_GSCA")
viewEnrichMap(KcViab_GSCA, resultName="HyperGeo.results", 
gscs=c("PW_KEGG"), allSig=FALSE, ntop=30, gsNameType="id", 
displayEdgeLabel=FALSE, layout="layout.fruchterman.reingold")


###################################################
### code chunk number 23: viewEnrichMap1_b
###################################################
data("KcViab_GSCA")
viewEnrichMap(KcViab_GSCA, resultName="GSEA.results", 
gscs=c("PW_KEGG"), allSig=FALSE, ntop=30, gsNameType="id", 
displayEdgeLabel=FALSE, layout="layout.fruchterman.reingold")


###################################################
### code chunk number 24: viewEnrichMap2_a
###################################################
KcViab_GSCA<-appendGSTerms(KcViab_GSCA, goGSCs=c("GO_BP",
"GO_MF","GO_CC"), keggGSCs=c("PW_KEGG"))
viewEnrichMap(KcViab_GSCA, resultName="HyperGeo.results",
gscs=c("PW_KEGG"), allSig=FALSE, ntop=30, gsNameType="term", 
displayEdgeLabel=FALSE, layout="layout.fruchterman.reingold")


###################################################
### code chunk number 25: viewEnrichMap2_b
###################################################
KcViab_GSCA<-appendGSTerms(KcViab_GSCA, goGSCs=c("GO_BP",
"GO_MF","GO_CC"), keggGSCs=c("PW_KEGG"))
viewEnrichMap(KcViab_GSCA, resultName="GSEA.results", 
gscs=c("PW_KEGG"), allSig=FALSE, ntop=30, gsNameType="term", 
displayEdgeLabel=FALSE, layout="layout.fruchterman.reingold")


###################################################
### code chunk number 26: HTSanalyzeR-Vignette.Rnw:335-339 (eval = FALSE)
###################################################
## plotEnrichMap(KcViab_GSCA, gscs=c("PW_KEGG"), allSig=TRUE, 
## ntop=NULL, gsNameType="id", displayEdgeLabel=FALSE,
## layout="layout.fruchterman.reingold", filepath=".", 
## filename="PW_KEGG.map.pdf",output="pdf", width=8, height=8)


###################################################
### code chunk number 27: gscaReport (eval = FALSE)
###################################################
## report(object=gsca, experimentName=experimentName, species="Dm", 
## allSig=TRUE, keggGSCs="PW_KEGG", goGSCs=c("GO_BP", "GO_MF"), 
## reportDir="HTSanalyzerGSCAReport")


###################################################
### code chunk number 28: gscaReportStruct (eval = FALSE)
###################################################
## print(dir("HTSanalyzerGSCAReport",recursive=TRUE))


###################################################
### code chunk number 29: gscaSaveAndLoad (eval = FALSE)
###################################################
## save(gsca, file="./gsca.RData")
## load(file="./gsca.RData")


###################################################
### code chunk number 30: nwaGetPval
###################################################
test.stats <- cellHTS2OutputStatTests(cellHTSobject=xn, 
annotationColumn="GeneID", alternative="two.sided", 
tests=c("T-test"))
library(BioNet)
pvalues <- aggrPvals(test.stats, order=2, plot=FALSE)


###################################################
### code chunk number 31: nwaInit2 (eval = FALSE)
###################################################
## data("Biogrid_DM_Interactome")
## nwa <- new("NWA", pvalues=pvalues, interactome=
## Biogrid_DM_Interactome, phenotypes=data4enrich)


###################################################
### code chunk number 32: nwaInit
###################################################
nwa <- new("NWA", pvalues=pvalues, phenotypes=data4enrich)
nwa <- preprocess(nwa, species="Dm", initialIDs="FlybaseCG", 
keepMultipleMappings=TRUE, duplicateRemoverMethod="max")


###################################################
### code chunk number 33: getInteractome2 (eval = FALSE)
###################################################
## nwa<-interactome(nwa, species="Dm", reportDir="HTSanalyzerReport",
## genetic=FALSE)


###################################################
### code chunk number 34: getInteractome
###################################################
data("Biogrid_DM_Mat")
nwa<-interactome(nwa, interactionMatrix=Biogrid_DM_Mat,
genetic=FALSE)


###################################################
### code chunk number 35: showNWAGraph
###################################################
nwa@interactome


###################################################
### code chunk number 36: fitBUMplot
###################################################
nwa<-analyze(nwa, fdr=0.001, species="Dm")


###################################################
### code chunk number 37: nwaSum
###################################################
summarize(nwa)


###################################################
### code chunk number 38: viewSubNet
###################################################
viewSubNet(nwa)


###################################################
### code chunk number 39: HTSanalyzeR-Vignette.Rnw:470-471 (eval = FALSE)
###################################################
## plotSubNet(nwa, filepath=".", filename="subnetwork.png")


###################################################
### code chunk number 40: HTSanalyzeR-Vignette.Rnw:478-481 (eval = FALSE)
###################################################
## report(object=nwa, experimentName=experimentName, species="Dm", 
## allSig=TRUE, keggGSCs="PW_KEGG", goGSCs=c("GO_BP", "GO_MF"), 
## reportDir="HTSanalyzerNWReport")


###################################################
### code chunk number 41: HTSanalyzeR-Vignette.Rnw:486-489 (eval = FALSE)
###################################################
## reportAll(gsca=gsca, nwa=nwa, experimentName=experimentName, 
## species="Dm", allSig=TRUE, keggGSCs="PW_KEGG", goGSCs=
## c("GO_BP", "GO_MF"), reportDir="HTSanalyzerReport")


###################################################
### code chunk number 42: HTSanalyzeR-Vignette.Rnw:494-496 (eval = FALSE)
###################################################
## save(nwa, file="./nwa.RData")
## load("./nwa.RData")


###################################################
### code chunk number 43: HTSanalyzeR-Vignette.Rnw:505-509 (eval = FALSE)
###################################################
## data("KcViab_Norm")
## GO_CC<-GOGeneSets(species="Dm",ontologies=c("CC"))
## PW_KEGG<-KeggGeneSets(species="Dm")
## ListGSC<-list(GO_CC=GO_CC,PW_KEGG=PW_KEGG)


###################################################
### code chunk number 44: HTSanalyzeR-Vignette.Rnw:514-526 (eval = FALSE)
###################################################
## HTSanalyzeR4cellHTS2(
## 	normCellHTSobject=KcViab_Norm,
## 	annotationColumn="GeneID",
## 	species="Dm",
## 	initialIDs="FlybaseCG",
## 	listOfGeneSetCollections=ListGSC,
## 	cutoffHitsEnrichment=2,
## 	minGeneSetSize=200,
## 	keggGSCs=c("PW_KEGG"),
## 	goGSCs=c("GO_CC"),
## 	reportDir="HTSanalyzerReport"
## ) 


###################################################
### code chunk number 45: HTSanalyzeR-Vignette.Rnw:535-538 (eval = FALSE)
###################################################
## c2<-getGmt(con="c2.all.v2.5.symbols.gmt.txt",geneIdType=
## SymbolIdentifier(), collectionType=
## BroadCollection(category="c2"))


###################################################
### code chunk number 46: HTSanalyzeR-Vignette.Rnw:542-543 (eval = FALSE)
###################################################
## c2entrez<-mapIdentifiers(c2, EntrezIdentifier('org.Hs.eg.db'))


###################################################
### code chunk number 47: HTSanalyzeR-Vignette.Rnw:548-550 (eval = FALSE)
###################################################
## collectionOfGeneSets<-geneIds(c2entrez)
## names(collectionOfGeneSets)<-names(c2entrez)


###################################################
### code chunk number 48: sessionInfo
###################################################
toLatex(sessionInfo())


