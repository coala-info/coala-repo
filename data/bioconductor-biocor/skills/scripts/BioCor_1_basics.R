# Code example from 'BioCor_1_basics' vignette. See references/ for full tutorial.

## ----knitsetup, message=FALSE, warning=FALSE, include=FALSE-------------------
knitr::opts_chunk$set(collapse = TRUE, warning = TRUE, crop = FALSE)
library("BiocStyle")

## ----eval = FALSE-------------------------------------------------------------
# citation("BioCor")

## ----install, eval=FALSE------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("BioCor")

## ----github, eval = FALSE-----------------------------------------------------
# library("devtools")
# install_github("llrs/BioCor")

## ----preload, include=FALSE---------------------------------------------------
library("BioCor")
library("org.Hs.eg.db")
library("reactome.db")

## ----load---------------------------------------------------------------------
library("BioCor")
## Load libraries with the data of the pathways
library("org.Hs.eg.db")
library("reactome.db")
genesKegg <- as.list(org.Hs.egPATH)
genesReact <- as.list(reactomeEXTID2PATHID)
# Remove genes and pathways which are not from human pathways 
genesReact <- lapply(genesReact, function(x){
    unique(grep("R-HSA-", x, value = TRUE))
    })
genesReact <- genesReact[lengths(genesReact) >= 1] 

## ----GSEABase, eval = FALSE---------------------------------------------------
# library("GSEABase")
# paths2Genes <- geneIds(getGmt("/path/to/file.symbol.gmt",
#                  geneIdType=SymbolIdentifier()))
# 
# genes <- unlist(paths2Genes, use.names = FALSE)
# pathways <- rep(names(paths2Genes), lengths(paths2Genes))
# genes2paths <- split(pathways, genes) # List of genes and the gene sets

## ----pathSim------------------------------------------------------------------
(paths <- sample(unique(unlist(genesReact)), 2))
pathSim(paths[1], paths[2], genesReact)

(pathways <- sample(unique(unlist(genesReact)), 10))
mpathSim(pathways, genesReact)

## ----combineScores------------------------------------------------------------
sim <- mpathSim(pathways, genesReact)
methodsCombineScores <- c("avg", "max", "rcmax", "rcmax.avg", "BMA",
                          "reciprocal")
sapply(methodsCombineScores, BioCor::combineScores, scores = sim)

## ----geneSim------------------------------------------------------------------
geneSim("672", "675", genesKegg)
geneSim("672", "675", genesReact)

mgeneSim(c("BRCA1" = "672", "BRCA2" = "675", "NAT2" = "10"), genesKegg)
mgeneSim(c("BRCA1" = "672", "BRCA2" = "675", "NAT2" = "10"), genesReact)

## ----clusterSim---------------------------------------------------------------
clusterSim(c("672", "675"), c("100", "10", "1"), genesKegg)
clusterSim(c("672", "675"), c("100", "10", "1"), genesKegg, NULL)

clusters <- list(cluster1 = c("672", "675"),
                 cluster2 = c("100", "10", "1"),
                 cluster3 = c("18", "10", "83"))
mclusterSim(clusters, genesKegg, "rcmax.avg")
mclusterSim(clusters, genesKegg, "max")

## ----clusterGeneSim-----------------------------------------------------------
clusterGeneSim(c("672", "675"), c("100", "10", "1"), genesKegg)
clusterGeneSim(c("672", "675"), c("100", "10", "1"), genesKegg, "max")

mclusterGeneSim(clusters, genesKegg, c("max", "rcmax.avg"))
mclusterGeneSim(clusters, genesKegg, c("max", "max"))

## ----sims---------------------------------------------------------------------
D2J(sim)

## ----whole_db, eval=FALSE-----------------------------------------------------
# ## Omit those genes without a pathway
# nas <- sapply(genesKegg, function(y){all(is.na(y)) | is.null(y)})
# genesKegg2 <- genesKegg[!nas]
# m <- mgeneSim(names(genesKegg2), genesKegg2, method  = "max")

## ----whole_db2, eval=FALSE----------------------------------------------------
# sim <- AintoB(m, B)

## ----hclust1, fig.cap="Gene clustering by similarities", fig.wide = TRUE------
genes.id <- c("10", "15", "16", "18", "2", "9", "52", "3855", "3880", "644", 
              "81327", "9128", "2073", "2893", "5142", "60", "210", "81", 
              "1352", "88", "672", "675")
genes.id <- mapIds(org.Hs.eg.db, keys = genes.id, keytype = "ENTREZID", 
                   column = "SYMBOL")
genes <- names(genes.id)
names(genes) <- genes.id
react <- mgeneSim(genes, genesReact)
## We remove genes which are not in list (hence the warning):
nan <- genes %in% names(genesReact)
react <- react[nan, nan]
hc <- hclust(as.dist(1 - react))
plot(hc, main = "Similarities between genes")

## ----hclust3, fig.cap="Clustering using clusterSim", fig.wide = TRUE----------
mycl <- cutree(hc, h = 0.2)
clusters <- split(genes[nan], as.factor(mycl))
# Removing clusters of just one gene
(clusters <- clusters[lengths(clusters) >= 2])
names(clusters) <- paste0("cluster", names(clusters))
## Remember we can use two methods to compare clusters
sim_clus1 <- mclusterSim(clusters, genesReact)
plot(hclust(as.dist(1 - sim_clus1)), 
     main = "Similarities between clusters by pathways")

## ----hclust3b, fig.cap="Clustering using clusterGeneSim", fig.wide=TRUE-------
sim_clus2 <- mclusterGeneSim(clusters, genesReact)
plot(hclust(as.dist(1 - sim_clus2)), 
     main ="Similarities between clusters by genes")

## ----GOSemSim-----------------------------------------------------------------
hsGO <- GOSemSim::godata('org.Hs.eg.db', ont = "BP", computeIC = FALSE)

## ----geneSimGOSemSim----------------------------------------------------------
goSemSim <- GOSemSim::geneSim("241", "251", semData = hsGO, 
                              measure = "Wang", combine="BMA")
# In case it is null
sim <- ifelse(is.na(goSemSim), 0, getElement(goSemSim, "geneSim"))
BioCor::geneSim("241", "251", genesReact, "BMA") - sim

genes <- c("835", "5261","241", "994")
goSemSim <- GOSemSim::mgeneSim(genes, semData = hsGO, 
                   measure = "Wang", combine = "BMA",
                   verbose = FALSE, drop = NULL)
BioCor::mgeneSim(genes, genesReact, "BMA", round = TRUE) - goSemSim

## ----named--------------------------------------------------------------------
genes <- c("CDC45", "MCM10", "CDC20", "NMU", "MMP1")
genese <- mapIds(org.Hs.eg.db, keys = genes, column = "ENTREZID", 
                 keytype = "SYMBOL")
BioCor::mgeneSim(genese, genesReact, "BMA")

## ----clusterSimGOSemSim-------------------------------------------------------
gs1 <- c("835", "5261","241", "994", "514", "533")
gs2 <- c("578","582", "400", "409", "411")
BioCor::clusterSim(gs1, gs2, genesReact, "BMA") - 
    GOSemSim::clusterSim(gs1, gs2, hsGO, measure = "Wang", combine = "BMA")

x <- org.Hs.egGO
hsEG <- mappedkeys(x)
set.seed(123)
(clusters <- list(a=sample(hsEG, 20), b=sample(hsEG, 20), c=sample(hsEG, 20)))
BioCor::mclusterSim(clusters, genesReact, "BMA") - 
    GOSemSim::mclusterSim(clusters, hsGO, measure = "Wang", combine = "BMA")

## ----wgcna, eval=FALSE--------------------------------------------------------
# expr.sim <- WGCNA::cor(expr) # or bicor
# 
# ## Combine the similarities
# similarity <- similarities(c(list(exp = expr.sim), sim), mean, na.rm = TRUE)
# 
# ## Choose the softThreshold
# pSFT <- pickSoftThreshold.fromSimilarity(similarity)
# 
# ## Or any other function we want
# adjacency <- adjacency.fromSimilarity(similarity, power = pSFT$powerEstimate)
# 
# ## Once we have the similarities we can calculate the TOM with TOM
# TOM <- TOMsimilarity(adjacency) ## Requires adjacencies despite its name
# dissTOM <- 1 - TOM
# geneTree <- hclust(as.dist(dissTOM), method = "average")
# ## We can use a clustering tool to group the genes
# dynamicMods <- cutreeHybrid(dendro = geneTree, distM = dissTOM,
#                             deepSplit = 2, pamRespectsDendro = FALSE,
#                             minClusterSize = 30)
# moduleColors <- labels2colors(dynamicMods$labels)

## ----eval = FALSE-------------------------------------------------------------
# Error in FUN(X[[i]], ...) :
#   trying to get slot "geneAnno" from an object of a basic class ("list") with no slots

## ----session, code_folding = FALSE--------------------------------------------
sessionInfo()

