# Code example from 'RcisTarget_MainTutorial' vignette. See references/ for full tutorial.

## ----libraries, echo=FALSE, message=FALSE, warning=FALSE----------------------
suppressPackageStartupMessages({
library(RcisTarget)
library(RcisTarget.hg19.motifDBs.cisbpOnly.500bp) 
library(DT)
library(data.table)
#require(visNetwork)
})

## ----citation, echo=FALSE-----------------------------------------------------
print(citation("RcisTarget")[1], style="textVersion")

## ----overview, eval=FALSE-----------------------------------------------------
# library(RcisTarget)
# 
# # Load gene sets to analyze. e.g.:
# geneList1 <- read.table(file.path(system.file('examples', package='RcisTarget'), "hypoxiaGeneSet.txt"), stringsAsFactors=FALSE)[,1]
# geneLists <- list(geneListName=geneList1)
# # geneLists <- GSEABase::GeneSet(genes, setName="geneListName") # alternative
# 
# # Select motif database to use (i.e. organism and distance around TSS)
# data(motifAnnotations_hgnc)
# motifRankings <- importRankings("~/databases/hg38_10kbp_up_10kbp_down_full_tx_v10_clust.genes_vs_motifs.rankings.feather")
# 
# # Motif enrichment analysis:
# motifEnrichmentTable_wGenes <- cisTarget(geneLists, motifRankings,
#                                motifAnnot=motifAnnotations)

## ----overviewAdvanced, eval=FALSE---------------------------------------------
# # 1. Calculate AUC
# motifs_AUC <- calcAUC(geneLists, motifRankings)
# 
# # 2. Select significant motifs, add TF annotation & format as table
# motifEnrichmentTable <- addMotifAnnotation(motifs_AUC,
#                           motifAnnot=motifAnnotations)
# 
# # 3. Identify significant genes for each motif
# # (i.e. genes from the gene set in the top of the ranking)
# # Note: Method 'iCisTarget' instead of 'aprox' is more accurate, but slower
# motifEnrichmentTable_wGenes <- addSignificantGenes(motifEnrichmentTable,
#                                                    geneSets=geneLists,
#                                                    rankings=motifRankings,
#                                                    nCores=1,
#                                                    method="aprox")

## ----installDep, eval=FALSE---------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# # To support paralell execution:
# BiocManager::install(c("doMC", "doRNG"))
# # For the examples in the follow-up section of the tutorial:
# BiocManager::install(c("DT", "visNetwork"))

## ----vignette, eval=FALSE-----------------------------------------------------
# # Explore tutorials in the web browser:
# browseVignettes(package="RcisTarget")
# 
# # Commnad line-based:
# vignette(package="RcisTarget") # list
# vignette("RcisTarget") # open

## ----editRmd, eval=FALSE------------------------------------------------------
# vignetteFile <- paste(file.path(system.file('doc', package='RcisTarget')),
#                       "RcisTarget.Rmd", sep="/")
# # Copy to edit as markdown
# file.copy(vignetteFile, ".")
# # Alternative: extract R code
# Stangle(vignetteFile)

## ----geneSets-----------------------------------------------------------------
library(RcisTarget)
geneSet1 <- c("gene1", "gene2", "gene3")
geneLists <- list(geneSetName=geneSet1)
# or: 
# geneLists <- GSEABase::GeneSet(geneSet1, setName="geneSetName") 

## ----geneSetsFormat, eval=FALSE-----------------------------------------------
# class(geneSet1)
# class(geneLists)
# geneSet2 <- c("gene2", "gene4", "gene5", "gene6")
# geneLists[["anotherGeneSet"]] <- geneSet2
# names(geneLists)
# geneLists$anotherGeneSet
# lengths(geneLists)

## ----sampleGeneSet------------------------------------------------------------
txtFile <- paste(file.path(system.file('examples', package='RcisTarget')),
                 "hypoxiaGeneSet.txt", sep="/")
geneLists <- list(hypoxia=read.table(txtFile, stringsAsFactors=FALSE)[,1])
head(geneLists$hypoxia)

## ----loadDatabases, eval=FALSE------------------------------------------------
# # Search space: 10k bp around TSS - HUMAN
# motifRankings <- importRankings("hg38_10kbp_up_10kbp_down_full_tx_v10_clust.genes_vs_motifs.rankings.feather")
# # Load the annotation to human transcription factors
# data(motifAnnotations_hgnc)

## ----loadAnnot, eval=TRUE-----------------------------------------------------
# mouse:
# data(motifAnnotations_mgi)

# human:
data(motifAnnotations_hgnc)
motifAnnotations[199:202,]

## ----motifAnnotQuery----------------------------------------------------------
showLogo(motifAnnotations[(directAnnotation==TRUE) & keptInRanking 
                               & (TF %in% c("HIF1A", "HIF2A", "EPAS1")), ])

## ----installDatabases, eval=FALSE---------------------------------------------
# # From Bioconductor
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("RcisTarget.hg19.motifDBs.cisbpOnly.500bp")

## ----loadDatabasesCisbpOnly---------------------------------------------------
library(RcisTarget.hg19.motifDBs.cisbpOnly.500bp)
# Rankings
data(hg19_500bpUpstream_motifRanking_cispbOnly)
motifRankings <- hg19_500bpUpstream_motifRanking_cispbOnly
motifRankings

# Annotations
data(hg19_motifAnnotation_cisbpOnly) 
motifAnnotations <- hg19_motifAnnotation_cisbpOnly

## ----eval=FALSE---------------------------------------------------------------
# motifEnrichmentTable_wGenes <- cisTarget(geneLists,
#          motifRankings,
#          motifAnnot=motifAnnotations)

## ----calcAUC, cache=TRUE------------------------------------------------------
motifs_AUC <- calcAUC(geneLists, motifRankings, nCores=1)

## ----AUChistogram, cache=TRUE, fig.height=5, fig.width=5----------------------
auc <- getAUC(motifs_AUC)["hypoxia",]
hist(auc, main="hypoxia", xlab="AUC histogram",
     breaks=100, col="#ff000050", border="darkred")
nes3 <- (3*sd(auc)) + mean(auc)
abline(v=nes3, col="red")

## ----addMotifAnnotation, cache=TRUE-------------------------------------------
motifEnrichmentTable <- addMotifAnnotation(motifs_AUC, nesThreshold=3,
     motifAnnot=motifAnnotations,
     highlightTFs=list(hypoxia=c("HIF1A", "EPAS1")))

## -----------------------------------------------------------------------------
class(motifEnrichmentTable)
dim(motifEnrichmentTable)
head(motifEnrichmentTable[,-"TF_lowConf", with=FALSE])

## ----addSignificantGenes, cache=TRUE------------------------------------------
motifEnrichmentTable_wGenes <- addSignificantGenes(motifEnrichmentTable,
                      rankings=motifRankings, 
                      geneSets=geneLists)
dim(motifEnrichmentTable_wGenes)

## ----getSignificantGenes, fig.height=7, fig.width=7---------------------------
geneSetName <- "hypoxia"
selectedMotifs <- c(sample(motifEnrichmentTable$motif, 2))
par(mfrow=c(2,2))
getSignificantGenes(geneLists[[geneSetName]], 
                    rankings=motifRankings,
                    signifRankingNames=selectedMotifs,
                    plotCurve=TRUE, maxRank=5000, genesFormat="none",
                    method="aprox")

## ----output-------------------------------------------------------------------
resultsSubset <- motifEnrichmentTable_wGenes[1:10,]
showLogo(resultsSubset)

## ----anotatedTfs, cache=TRUE--------------------------------------------------
anotatedTfs <- lapply(split(motifEnrichmentTable_wGenes$TF_highConf,
                            motifEnrichmentTable$geneSet),
                      function(x) {
                        genes <- gsub(" \\(.*\\). ", "; ", x, fixed=FALSE)
                        genesSplit <- unique(unlist(strsplit(genes, "; ")))
                        return(genesSplit)
                        })
                      
anotatedTfs$hypoxia

## ----network, cache=FALSE, eval=FALSE-----------------------------------------
# signifMotifNames <- motifEnrichmentTable$motif[1:3]
# 
# incidenceMatrix <- getSignificantGenes(geneLists$hypoxia,
#                                        motifRankings,
#                                        signifRankingNames=signifMotifNames,
#                                        plotCurve=TRUE, maxRank=5000,
#                                        genesFormat="incidMatrix",
#                                        method="aprox")$incidMatrix
# 
# library(reshape2)
# edges <- melt(incidenceMatrix)
# edges <- edges[which(edges[,3]==1),1:2]
# colnames(edges) <- c("from","to")

## ----visNetwork, eval=FALSE---------------------------------------------------
# library(visNetwork)
# motifs <- unique(as.character(edges[,1]))
# genes <- unique(as.character(edges[,2]))
# nodes <- data.frame(id=c(motifs, genes),
#       label=c(motifs, genes),
#       title=c(motifs, genes), # tooltip
#       shape=c(rep("diamond", length(motifs)), rep("elypse", length(genes))),
#       color=c(rep("purple", length(motifs)), rep("skyblue", length(genes))))
# visNetwork(nodes, edges) %>% visOptions(highlightNearest = TRUE,
#                                         nodesIdSelection = TRUE)

## -----------------------------------------------------------------------------
date()
sessionInfo()

