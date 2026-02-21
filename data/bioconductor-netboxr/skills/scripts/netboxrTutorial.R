# Code example from 'netboxrTutorial' vignette. See references/ for full tutorial.

## ----knitrSetup, include=FALSE------------------------------------------------
library(knitr)
opts_chunk$set(out.extra='style="display:block; margin: auto"', fig.align="center", fig.width=12, fig.height=12, tidy=TRUE)

## ----style, include=FALSE, echo=FALSE, results='asis'-------------------------
BiocStyle::markdown()

## ----installNetBoxr, eval=FALSE-----------------------------------------------
#  BiocManager::install("netboxr")

## ----loadLibrary, message=FALSE, warning=FALSE--------------------------------
library(netboxr)

## ----searchHelp, eval=FALSE, tidy=FALSE---------------------------------------
#  help(package="netboxr")

## ----showHelp, eval=FALSE, tidy=FALSE-----------------------------------------
#  help(geneConnector)
#  ?geneConnector

## ----netboxrExampleNetwork----------------------------------------------------
data(netbox2010)
sifNetwork <- netbox2010$network
graphReduced <- networkSimplify(sifNetwork,directed = FALSE)      

## ----netboxrExampleGene-------------------------------------------------------
geneList <- as.character(netbox2010$geneList) 
length(geneList)

## ----netboxrExampleGeneConnector, fig.width=12, fig.height=12-----------------
## Use Benjamini-Hochberg method to do multiple hypothesis 
## correction for linker candidates.

## Use edge-betweeness method to detect community structure in the network. 
threshold <- 0.05
results <- geneConnector(geneList=geneList,
                        networkGraph=graphReduced,
                        directed=FALSE,
                       pValueAdj="BH",
                       pValueCutoff=threshold,
                       communityMethod="ebc",
                       keepIsolatedNodes=FALSE)

# Add edge annotations
library(RColorBrewer)
edges <- results$netboxOutput
interactionType<-unique(edges[,2])
interactionTypeColor<-brewer.pal(length(interactionType),name="Spectral")

edgeColors<-data.frame(interactionType,interactionTypeColor,stringsAsFactors = FALSE)
colnames(edgeColors)<-c("INTERACTION_TYPE","COLOR")


netboxGraphAnnotated <- annotateGraph(netboxResults = results,
                                      edgeColors = edgeColors,
                                      directed = FALSE,
                                      linker = TRUE)

# Check the p-value of the selected linker
linkerDF <- results$neighborData
linkerDF[linkerDF$pValueFDR<threshold,]

# The geneConnector function returns a list of data frames. 
names(results)

# Plot graph with the Fruchterman-Reingold layout algorithm
# As an example, plot both the original and the annotated graphs
# Save the layout for easier comparison
graph_layout <- layout_with_fr(results$netboxGraph) 

# plot the original graph
plot(results$netboxCommunity,results$netboxGraph, layout=graph_layout) 

# Plot the edge annotated graph
plot(results$netboxCommunity, netboxGraphAnnotated, layout = graph_layout,
     vertex.size = 10,
     vertex.shape = V(netboxGraphAnnotated)$shape,
     edge.color = E(netboxGraphAnnotated)$interactionColor,
     edge.width = 3)

# Add interaction type annotations
legend("bottomleft", 
       legend=interactionType,
       col=interactionTypeColor,
       lty=1,lwd=2,
       bty="n",
       cex=1)



## ----netboxrExampleGlobalTest, eval=FALSE-------------------------------------
#  ## This function will need a lot of time to complete.
#  globalTest <- globalNullModel(netboxGraph=results$netboxGraph, networkGraph=graphReduced, iterations=10, numOfGenes = 274)

## ----netboxrExampleLocalTest--------------------------------------------------
localTest <- localNullModel(netboxGraph=results$netboxGraph, iterations=1000)


## ----netboxrExampleLocalTestPlot----------------------------------------------
h<-hist(localTest$randomModularityScore,breaks=35,plot=FALSE)
h$density = h$counts/sum(h$counts)
plot(h,freq=FALSE,ylim=c(0,0.1),xlim=c(0.1,0.6), col="lightblue")
abline(v=localTest$modularityScoreObs,col="red")

## -----------------------------------------------------------------------------
DT::datatable(results$moduleMembership, rownames = FALSE)

## ----netboxrEampleOutput, eval=FALSE------------------------------------------
#  # Write results for further visilaztion in the cytoscape software.
#  #
#  # network.sif file is the NetBox algorithm output in SIF format.
#  write.table(results$netboxOutput, file="network.sif", sep="\t", quote=FALSE, col.names=FALSE, row.names=FALSE)
#  #
#  # netighborList.txt file contains the information of all neighbor nodes.
#  write.table(results$neighborData, file="neighborList.txt", sep="\t", quote=FALSE, col.names=TRUE, row.names=FALSE)
#  #
#  # community.membership.txt file indicates the identified pathway module numbers.
#  write.table(results$moduleMembership, file="community.membership.txt", sep="\t", quote=FALSE, col.names=FALSE, row.names=FALSE)
#  #
#  # nodeType.txt file indicates the node is "linker" node or "candidate" node.
#  write.table(results$nodeType,file="nodeType.txt", sep="\t", quote=FALSE, col.names=FALSE, row.names=FALSE)

## ----clusterExample, eval=TRUE------------------------------------------------
library(clusterProfiler)
library(org.Hs.eg.db)

module <- 6
selectedModule <- results$moduleMembership[results$moduleMembership$membership == module,]
geneList <-selectedModule$geneSymbol

# Check available ID types in for the org.Hs.eg.db annotation package
keytypes(org.Hs.eg.db)

ids <- bitr(geneList, fromType="SYMBOL", toType=c("ENTREZID"), OrgDb="org.Hs.eg.db")
head(ids)

ego <- enrichGO(gene = ids$ENTREZID,
                OrgDb = org.Hs.eg.db,
                ont = "BP",
               pAdjustMethod = "BH",
                pvalueCutoff  = 0.01,
               qvalueCutoff  = 0.05,
               readable = TRUE)

## -----------------------------------------------------------------------------
head(ego)

## ---- fig.width=10, fig.height=5----------------------------------------------
dotplot(ego)

## -----------------------------------------------------------------------------
example <- "PARTICIPANT_A	INTERACTION_TYPE	PARTICIPANT_B
TP53	interacts	MDM2
MDM2	interacts	MDM4"

sif <- read.table(text=example, header=TRUE, sep="\t", stringsAsFactors=FALSE)

graphReduced <- networkSimplify(sif, directed = FALSE)  

## ----paxtoolsr, fig.width=15, fig.height=15, eval=FALSE-----------------------
#  library(paxtoolsr)
#  
#  filename <- "PathwayCommons.8.reactome.EXTENDED_BINARY_SIF.hgnc.txt.gz"
#  sif <- downloadPc2(filename, version="8")
#  
#  
#  # Filter interactions for specific types
#  interactionTypes <- getSifInteractionCategories()
#  
#  filteredSif <- filterSif(sif$edges, interactionTypes=interactionTypes[["BetweenProteins"]])
#  filteredSif <- filteredSif[(filteredSif$INTERACTION_TYPE %in% "in-complex-with"), ]
#  
#  # Re-run NetBox algorithm with new network
#  graphReduced <- networkSimplify(filteredSif, directed=FALSE)
#  geneList <- as.character(netbox2010$geneList)
#  
#  threshold <- 0.05
#  pcResults <- geneConnector(geneList=geneList,
#                            networkGraph=graphReduced,
#                             directed=FALSE,
#                             pValueAdj="BH",
#                             pValueCutoff=threshold,
#                             communityMethod="lec",
#                             keepIsolatedNodes=FALSE)
#  
#  # Check the p-value of the selected linker
#  linkerDF <- results$neighborData
#  linkerDF[linkerDF$pValueFDR<threshold,]
#  
#  # The geneConnector function returns a list of data frames.
#  names(results)
#  
#  # plot graph with the Fruchterman-Reingold layout algorithm
#  plot(results$netboxCommunity,results$netboxGraph, layout=layout_with_fr)

## ---- eval=FALSE--------------------------------------------------------------
#  library(cgdsr)
#  
#  mycgds <- CGDS("http://www.cbioportal.org/")
#  
#  # Find available studies, caselists, and geneticProfiles
#  studies <- getCancerStudies(mycgds)
#  caselists <- getCaseLists(mycgds,'gbm_tcga_pub')
#  geneticProfiles <- getGeneticProfiles(mycgds,'gbm_tcga_pub')
#  
#  genes <- c("EGFR", "TP53", "ACTB", "GAPDH")
#  
#  results <- sapply(genes, function(gene) {
#    geneticProfiles <- c("gbm_tcga_pub_cna_consensus", "gbm_tcga_pub_mutations")
#    caseList <- "gbm_tcga_pub_cnaseq"
#  
#    dat <- getProfileData(mycgds, genes=gene, geneticProfiles=geneticProfiles, caseList=caseList)
#    head(dat)
#  
#    cna <- dat$gbm_tcga_pub_cna_consensus
#    cna <- as.numeric(levels(cna))[cna]
#  
#    mut <- dat$gbm_tcga_pub_mutations
#    mut <- as.character(levels(mut))[mut]
#  
#    tmp <- data.frame(cna=cna, mut=mut, stringsAsFactors = FALSE)
#    tmp$isAltered <- abs(tmp$cna) == 2 | !is.na(tmp$mut) # Amplification or Deep Deletion or any mutation
#    length(which(tmp$isAltered))/nrow(tmp)
#  }, USE.NAMES = TRUE)
#  
#  # 10 percent alteration frequency cutoff
#  geneList <- names(results)[results > 0.1]

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

