# Code example from 'FGNet' vignette. See references/ for full tutorial.

## ----pre,echo=FALSE,results='hide'--------------------------------------------
library(knitr)
opts_chunk$set(warning=FALSE,message=FALSE,cache=TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("FGNet")

## ----echo=FALSE, message=FALSE------------------------------------------------
library(FGNet)

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install(c("RCurl",
#     "gage", "topGO",
#     "GO.db", "reactome.db", "org.Sc.sgd.db"))
# 
# BiocManager::install(c("RGtk2"))

## ----eval=FALSE---------------------------------------------------------------
# ?FGNet_report

## ----eval=FALSE---------------------------------------------------------------
# getwd()

## -----------------------------------------------------------------------------
genesYeast <- c("ADA2", "APC1", "APC11", "APC2", "APC4", "APC5", "APC9", "CDC16", 
                "CDC23", "CDC26", "CDC27", "CFT1", "CFT2", "DCP1", "DOC1", "FIP1", 
                "GCN5", "GLC7", "HFI1", "KEM1", "LSM1", "LSM2", "LSM3", "LSM4", 
                "LSM5", "LSM6", "LSM7", "LSM8", "MPE1", "NGG1", "PAP1", "PAT1", 
                "PFS2", "PTA1", "PTI1", "REF2", "RNA14", "RPN1", "RPN10", "RPN11", 
                "RPN13", "RPN2", "RPN3", "RPN5", "RPN6", "RPN8", "RPT1", "RPT3", 
                "RPT6", "SGF11", "SGF29", "SGF73", "SPT20", "SPT3", "SPT7", "SPT8", 
                "TRA1", "YSH1", "YTH1")

library(org.Sc.sgd.db)
geneLabels <- unlist(as.list(org.Sc.sgdGENENAME))
genesYeast <- sort(geneLabels[which(geneLabels %in% genesYeast)])

# Optional: Gene expression (1=UP, -1=DW)
genesYeastExpr <- setNames(c(rep(1,28), rep(-1,30)),genesYeast) 


## ----eval=FALSE---------------------------------------------------------------
# feaResults_topGO <- fea_topGO(genesYeast, geneIdType="GENENAME", organism="Sc")
# ?fea_topGO

## ----eval=FALSE---------------------------------------------------------------
# library(gage)
# data(gse16873)
# 
# # Set gene labels? (they need to have unique identifiers)
# # BiocManager::install("org.Hs.eg.db")
# library(org.Hs.eg.db)
# geneSymbols <- select(org.Hs.eg.db,columns="SYMBOL",keytype="ENTREZID",
#     keys=rownames(gse16873))
# 
# geneLabels <- geneSymbols$SYMBOL
# names(geneLabels) <- geneSymbols$ENTREZID
# head(geneLabels)
# 
# # GAGE:
# feaResults_gage <- fea_gage(eset=gse16873,
#                          refSamples=grep('HN',colnames(gse16873)),
#                          compSamples=grep('DCIS',colnames(gse16873)),
#                          geneLabels=geneLabels, annotations="REACTOME",
#                          geneIdType="ENTREZID", organism="Hs")
# ?fea_gage

## ----eval=FALSE---------------------------------------------------------------
# ?format_results()

## ----eval=FALSE---------------------------------------------------------------
# feaResults_David <- format_david("http://david.abcc.ncifcrf.gov/data/download/90128.txt")
# feaResults_gtLinker <- fea_gtLinker_getResults(jobID=3907019)

## ----eval=FALSE---------------------------------------------------------------
# FGNet_report(feaResults_topGO, geneExpr=genesYeastExpr)
# FGNet_report(feaResults_gage)
# FGNet_report(feaResults_David, geneExpr=genesYeastExpr)
# FGNet_report(feaResults_gtLinker, geneExpr=genesYeastExpr)

## ----eval=FALSE---------------------------------------------------------------
# data(FEA_tools)
# FEA_tools[,4:6]

## ----eval=FALSE---------------------------------------------------------------
# FGNet_report(feaResults_gtLinker, filterThreshold=0.3)

## ----eval=FALSE---------------------------------------------------------------
# ?FGNet_report

## ----eval=FALSE---------------------------------------------------------------
# #feaResults <- feaResults_gtLinker
# feaResults <- feaResults_gage
# incidMat <- fea2incidMat(feaResults)
# incidMat$metagroupsMatrix[1:5, 1:5]
# incidMat_terms <- fea2incidMat(feaResults, key="Terms")
# incidMat_terms$metagroupsMatrix[5:10, 1:5]

## ----eval=FALSE---------------------------------------------------------------
# functionalNetwork(incidMat, geneExpr=genesYeastExpr,
#     plotTitleSub="Default gene view")

## ----eval=FALSE---------------------------------------------------------------
# getTerms(feaResults)[1]

## ----eval=FALSE---------------------------------------------------------------
# functionalNetwork(incidMat_terms, plotOutput="dynamic")

## ----eval=FALSE---------------------------------------------------------------
# functionalNetwork(incidMat_terms, plotType="bipartite",
#     plotTitleSub="Terms in several metagroups")

## ----eval=FALSE---------------------------------------------------------------
# jobID <- 1639610
# feaAlzheimer <- fea_gtLinker_getResults(jobID=jobID, organism="Hs")

## ----eval=FALSE---------------------------------------------------------------
# names(feaAlzheimer)

## ----results='hide', eval=FALSE-----------------------------------------------
# head(feaAlzheimer$metagroups)

## ----eval=FALSE---------------------------------------------------------------
# getTerms(feaAlzheimer)[3:4]

## ----eval=FALSE---------------------------------------------------------------
# incidMat <- fea2incidMat(feaAlzheimer)

## ----eval=FALSE---------------------------------------------------------------
# head(incidMat$metagroupsMatrix)
# incidMat$gtSetsMatrix[1:5, 14:18]

## ----eval=FALSE---------------------------------------------------------------
# data(FEA_tools)
# FEA_tools[,4:6]

## ----eval=FALSE---------------------------------------------------------------
# incidMatFiltered <- fea2incidMat(feaAlzheimer,
#     filterAttribute="Silhouette Width", filterOperator="<", filterThreshold=0.2)

## ----eval=FALSE---------------------------------------------------------------
# incidMatFiltered$filteredOut

## ----eval=FALSE---------------------------------------------------------------
# # (Fake expression data)
# genesAlz <- rownames(incidMat$metagroupsMatrix)
# genesAlzExpr <- setNames(c(rep(1,50), rep(-1,27)), genesAlz)

## ----eval=FALSE---------------------------------------------------------------
# fNw <- functionalNetwork(incidMatFiltered, geneExpr=genesAlzExpr, keepColors=FALSE, vLabelCex=0.5)

## ----eval=FALSE---------------------------------------------------------------
# functionalNetwork(incidMatFiltered, geneExpr=genesAlzExpr, plotOutput="dynamic")
# fNw <- functionalNetwork(incidMatFiltered, plotOutput="none")

## ----eval=FALSE---------------------------------------------------------------
# names(fNw)
# names(fNw$iGraph)
# library(igraph)
# clNw <- fNw$iGraph$commonClusters
# clNw

## ----eval=FALSE---------------------------------------------------------------
# vcount(clNw)
# ecount(clNw)
# sort(betweenness(clNw), decreasing=TRUE)[1:10]
# igraph.to.graphNEL(clNw)

## ----eval=FALSE---------------------------------------------------------------
# functionalNetwork(incidMatFiltered, plotOutput="dynamic")
# # Modify the layout...
# saveLayout <- tkplot.getcoords(1)   # tkp.id (ID of the tkplot window)
# functionalNetwork(incidMatFiltered, vLayout=saveLayout)

## ----eval=FALSE---------------------------------------------------------------
# mgKeyTerm <- keywordsTerm(getTerms(feaAlzheimer),
#     nChar=100)[-c(as.numeric(incidMatFiltered$filteredOut))]
# functionalNetwork(incidMatFiltered, plotType="bipartite", legendText=mgKeyTerm)

## ----eval=FALSE---------------------------------------------------------------
# functionalNetwork(incidMatFiltered, geneExpr=genesAlzExpr, plotType="bipartite", keepAllNodes=TRUE,
#     plotTitleSub="Bipartite network will all nodes", legendText=mgKeyTerm, vLabelCex=0.5)

## ----eval=FALSE---------------------------------------------------------------
# incidMatTerms <- fea2incidMat(feaAlzheimer, key="Terms")

## ----eval=FALSE---------------------------------------------------------------
# functionalNetwork(incidMatTerms, plotType="bipartite",
#     plotTitle="Terms in several metagroups")

## ----eval=FALSE---------------------------------------------------------------
# functionalNetwork(incidMatTerms,  weighted=TRUE, plotOutput="dynamic")

## ----eval=FALSE---------------------------------------------------------------
# incidMatTerms <- fea2incidMat(feaAlzheimer$metagroups, clusterColumn="Metagroup",
#     key="Terms",
#     filterAttribute="Silhouette.Width", filterThreshold=0.2)
# functionalNetwork(incidMatTerms, legendText=FALSE, plotOutput="dynamic")

## ----eval=FALSE---------------------------------------------------------------
# functionalNetwork(incidMatTerms, legendText=FALSE)

## ----fig.height=5, fig.width=10, eval=FALSE-----------------------------------
# incidMatTerms <- fea2incidMat(feaAlzheimer, key="Terms", removeFilteredGtl=FALSE)
# par(mfrow=c(1,2))
# functionalNetwork(incidMatTerms, vLabelCex=0.2,
#     plotTitle="Including filtered terms", legendText=FALSE)
# functionalNetwork(incidMatTerms, plotType="bipartite", vLabelCex=0.4,
#     plotTitle="Including filtered terms")

## ----eval=FALSE---------------------------------------------------------------
# txtFile <- paste(file.path(system.file('examples', package='FGNet')), "DAVID_Yeast_raw.txt", sep=.Platform$file.sep)
# feaResults_David <- format_david(txtFile, jobName="David_example", geneLabels=genesYeast)

## ----eval=FALSE---------------------------------------------------------------
# # Sorry, this function is no longer supported. Use  another fea_ function, or DAVID through the website.
# # feaResults_David <- fea_david(names(genesYeast), email="...", geneLabels=genesYeast)

## ----eval=FALSE---------------------------------------------------------------
# gtSets <- feaResults_David$geneTermSets
# gtSets <- gtSets[gtSets$Cluster %in% c(9),]
# gtSets <- gtSets[gtSets$Pop.Hits<500,]

## ----message=FALSE, eval=FALSE------------------------------------------------
# termsGenes <- t(fea2incidMat(gtSets, clusterColumn="Terms")$clustersMatrix)
# library(R.utils)
# rownames(termsGenes) <- sapply(strsplit(rownames(termsGenes), ":"),
#     function(x) capitalize(x[length(x)]))
# termsGenes[1:5,1:5]

## ----eval=FALSE---------------------------------------------------------------
# functionalNetwork(t(termsGenes), plotType="bipartite", keepAllNodes=TRUE,
#     legendPrefix="", plotTitle="Genes - Terms network", plotTitleSub="",
#     geneExpr=genesYeastExpr, plotExpression="Fill")

## ----eval=FALSE---------------------------------------------------------------
# functionalNetwork(termsGenes, plotType="bipartite", keepAllNodes=TRUE,
#     legendPrefix="", plotTitle="Genes - Terms network", plotTitleSub="")

## ----eval=FALSE---------------------------------------------------------------
# incidMat <- fea2incidMat(feaResults_David)
# functionalNetwork(incidMat)

## ----eval=FALSE---------------------------------------------------------------
# incidMatTerms <- fea2incidMat(feaResults_David, key="Terms")

## ----eval=FALSE---------------------------------------------------------------
# functionalNetwork(incidMatTerms$clustersMatrix, plotOutput="dynamic",
#   weighted=TRUE, eColor="grey")

## ----eval=FALSE---------------------------------------------------------------
# functionalNetwork(incidMatTerms$clustersMatrix, plotType="bipartite",
#  plotTitle="Terms in several clusters")

## ----eval=FALSE---------------------------------------------------------------
# colnames(feaResults_David$clusters)

## ----fig.height=5, fig.width=10, eval=FALSE-----------------------------------
# par(mfrow=c(1,2))
# 
# # Highest enrichment score
# filterProp <- as.numeric(as.character(feaResults_David$clusters$ClusterEnrichmentScore))
# quantile(filterProp, c(0.10, 0.25, 0.5, 0.75, 0.9))
# incidMatFiltered <- fea2incidMat(feaResults_David,
#     filterAttribute="ClusterEnrichmentScore",
#     filterOperator="<", filterThreshold=7.65)
# functionalNetwork(incidMatFiltered, eColor=NA,
#     plotTitle="Highest enrichment score")
# 
# # Lowest genes
# quantile(as.numeric(as.character(feaResults_David$clusters$nGenes)),
#     c(0.10, 0.25, 0.5, 0.75, 0.9))
# incidMatFiltered <- fea2incidMat(feaResults_David,
#  filterAttribute="nGenes", filterOperator=">", filterThreshold=20)
# functionalNetwork(incidMatFiltered, plotTitle="Smallest clusters")

## ----eval=FALSE---------------------------------------------------------------
# keywordsTerm(getTerms(feaResults_David), nChar=100)
# 
# keywords <- c("hydrolase")
# selectedClusters <- sapply(getTerms(feaResults_David),
#     function(x)
#     any(grep(paste("(", paste(keywords, collapse="|") ,")",sep=""), tolower(x))))

## ----eval=FALSE---------------------------------------------------------------
# getTerms(feaResults_David)[selectedClusters]

## ----eval=FALSE---------------------------------------------------------------
# tmpFea <- feaResults_David
# tmpFea$clusters <- cbind(tmpFea$clusters, keywords=selectedClusters)
# incidMatSelection <- fea2incidMat(tmpFea,
#  filterAttribute="keywords", filterOperator="!=",filterThreshold="TRUE")
# functionalNetwork(incidMatSelection, plotType="bipartite")

## ----eval=FALSE---------------------------------------------------------------
# distMat <- clustersDistance(incidMat)

## ----echo=FALSE, results='hide', eval=FALSE-----------------------------------
# dev.off()

## ----eval=FALSE---------------------------------------------------------------
# selectedClusters <- rep(FALSE, nrow(feaResults_David$clusters))
# selectedClusters[c(8,9,11)] <- TRUE
# 
# tmpFea <- feaResults_David
# tmpFea$clusters <- cbind(tmpFea$clusters, select=selectedClusters)
# incidMatSelection <- fea2incidMat(tmpFea,
#   filterAttribute="select", filterOperator="!=",filterThreshold="TRUE")
# functionalNetwork(incidMatSelection, eColor=NA)

## ----eval=FALSE---------------------------------------------------------------
# # No longer supported
# # Same analysis, setting overlap to 6:
# # feaResults_David_ov6 <- fea_david(names(genesYeast), geneLabels=genesYeast, email="example@email.com",
# #     argsWS=c(overlap=6, initialSeed=3, finalSeed=3, linkage=0.5, kappa=50))

## ----echo=FALSE---------------------------------------------------------------
txtFile <- paste(file.path(system.file('examples', package='FGNet')), "DAVID_Yeast_overl6_raw.txt", sep=.Platform$file.sep)
feaResults_David_ov6 <- format_david(txtFile, jobName="David_example", geneLabels=genesYeast)

## ----eval=FALSE---------------------------------------------------------------
# # Filter/select
# sum(feaResults_David_ov6$geneTermSets$Pop.Hits < 100)
# gtSets <- feaResults_David_ov6$geneTermSets[feaResults_David_ov6$geneTermSets$Pop.Hits < 100,]
# # Save
# write.table(gtSets, file="david_filteredGtsets.txt", sep="\t", col.names = TRUE, quote=FALSE)
# # Load with "readGeneTermSets"
# feaResults_filteredGtsets <- readGeneTermSets("david_filteredGtsets.txt", tool="DAVID")
# # ...
# functionalNetwork(fea2incidMat(feaResults_filteredGtsets), vLabelCex=0.5)

## ----eval=FALSE---------------------------------------------------------------
# # Yeast
# library(org.Sc.sgd.db)
# goGenesCountSc <- table(sapply(as.list(org.Sc.sgdGO2ORF), length))
# barplot(goGenesCountSc, main="Number of genes annotated to GO term (Sc) ",
#     xlab="Number of genes", ylab="Number of GO terms")
# 
# # Human
# library(org.Hs.eg.db)
# goGenesCountHs <- table(sapply(as.list(org.Hs.egGO2EG), length))
# barplot(goGenesCountHs, main="Number of genes annotated to GO term (Human)",
#     xlab="Number of genes", ylab="Number of GO terms")

## ----eval=FALSE---------------------------------------------------------------
# incidMatFiltered <- fea2incidMat(feaAlzheimer,
#     filterAttribute="Silhouette Width", filterOperator="<", filterThreshold=0.2)
# stats <- analyzeNetwork(incidMatFiltered)

## ----eval=FALSE---------------------------------------------------------------
# names(stats)
# stats$transitivity

## ----eval=FALSE---------------------------------------------------------------
# head(stats$betweennessMatrix)

## ----eval=FALSE---------------------------------------------------------------
# stats$hubsList$Global

## ----eval=FALSE---------------------------------------------------------------
# stats$hubsList$"9"

## ----eval=FALSE---------------------------------------------------------------
# incidMat_metab <- fea2incidMat(feaResults_David)
# analyzeNetwork(incidMat_metab)

## ----eval=FALSE---------------------------------------------------------------
# goIds <- getTerms(feaResults_David, returnValue="GO")[[7]]
#  plotGoAncestors(goIds, ontology="MF", nCharTerm=40, labelCex=0.8)

## ----eval=FALSE---------------------------------------------------------------
# library(FGNet)
# FGNet_GUI()

## ----eval=FALSE---------------------------------------------------------------
# geneExpr <- c("YBL084C", "YDL008W", "YDR118W", "YDR301W", "YDR448W",
#               "YFR036W", "YGL240W", "YHR166C", "YKL022C", "YLR102C", "YLR115W",
#               "YLR127C", "YNL172W", "YOL149W", "YOR249C")
# geneExpr <- setNames(c(rep(1,10),rep(-1,5)), geneExpr)
# 
# FGNet_GUI(geneExpr)

## ----eval=FALSE---------------------------------------------------------------
# jobID <- fea_gtLinker(geneList=genesYeast, organism="Sc")
# ?fea_gtLinker

## ----eval=FALSE---------------------------------------------------------------
# jobID <- 3907019
# feaResults_gtLinker <- fea_gtLinker_getResults(jobID=jobID, organism="Sc")

