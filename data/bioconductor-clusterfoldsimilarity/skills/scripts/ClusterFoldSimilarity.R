# Code example from 'ClusterFoldSimilarity' vignette. See references/ for full tutorial.

## ----options, include=FALSE, echo=FALSE---------------------------------------
library(BiocStyle)
knitr::opts_chunk$set(eval=TRUE, warning=FALSE, error=FALSE, message=FALSE)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("ClusterFoldSimilarity")

## ----setup--------------------------------------------------------------------
library(ClusterFoldSimilarity)

## ----construct----------------------------------------------------------------
library(Seurat)
library(scRNAseq)
library(dplyr)
# Human pancreatic single cell data 1
pancreasMuraro <- scRNAseq::MuraroPancreasData(ensembl=FALSE)
pancreasMuraro <- pancreasMuraro[,rownames(colData(pancreasMuraro)[!is.na(colData(pancreasMuraro)$label),])]
colData(pancreasMuraro)$cell.type <- colData(pancreasMuraro)$label
rownames(pancreasMuraro) <- make.names(unlist(lapply(strsplit(rownames(pancreasMuraro), split="__"), function(x)x[[1]])), unique = TRUE)
singlecell1Seurat <- CreateSeuratObject(counts=counts(pancreasMuraro), meta.data=as.data.frame(colData(pancreasMuraro)))

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(
  table(colData(pancreasMuraro)$label),
  caption = 'Cell-types on pancreas dataset from Muraro et al.', align = "c"
)

## -----------------------------------------------------------------------------
# Human pancreatic single cell data 2
pancreasBaron <- scRNAseq::BaronPancreasData(which="human", ensembl=FALSE)
colData(pancreasBaron)$cell.type <- colData(pancreasBaron)$label
rownames(pancreasBaron) <- make.names(rownames(pancreasBaron), unique = TRUE)

singlecell2Seurat <- CreateSeuratObject(counts=counts(pancreasBaron), meta.data=as.data.frame(colData(pancreasBaron)))

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(
  table(colData(pancreasBaron)$label),
  caption = 'Cell-types on pancreas dataset from Baron et al.', align = "c"
)

## ----results='hide'-----------------------------------------------------------
# Create a list with the unprocessed single-cell datasets
singlecellObjectList <- list(singlecell1Seurat, singlecell2Seurat)
# Apply the same processing to each dataset and return a list of single-cell analysis
singlecellObjectList <- lapply(X=singlecellObjectList, FUN=function(scObject){
scObject <- NormalizeData(scObject)
scObject <- FindVariableFeatures(scObject, selection.method="vst", nfeatures=2000)
scObject <- ScaleData(scObject, features=VariableFeatures(scObject))
scObject <- RunPCA(scObject, features=VariableFeatures(object=scObject))
scObject <- FindNeighbors(scObject, dims=seq(16))
scObject <- FindClusters(scObject, resolution=0.4)
})

## ----fig.wide = TRUE----------------------------------------------------------
# Assign cell-type annotated from the original study to the cell labels:
Idents(singlecellObjectList[[1]]) <- factor(singlecellObjectList[[1]][[]][, "cell.type"])

library(ClusterFoldSimilarity)
similarityTable <- clusterFoldSimilarity(scList=singlecellObjectList, 
                                         sampleNames=c("human", "humanNA"),
                                         topN=1, 
                                         nSubsampling=24)


## ----echo=FALSE---------------------------------------------------------------
knitr::kable(
  head(similarityTable), caption = 'A table of the first 10 rows of the similarity results.', align = "c", 
  format = "html", table.attr = "style='width:70%;'") %>% kableExtra::kable_styling(font_size=10)

## -----------------------------------------------------------------------------
typeCount <- singlecellObjectList[[2]][[]] %>% 
  group_by(seurat_clusters) %>% 
  count(cell.type) %>%
  arrange(desc(n), .by_group = TRUE) %>% 
  filter(row_number()==1)

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(
  cbind.data.frame(typeCount, 
                 matched.type=rep(table(typeCount$seurat_clusters), x=similarityTable[similarityTable$datasetL == "humanNA",]$clusterR)),
  caption = 'Cell-type label matching on pancreas single-cell data.', align = "c"
)

## ----fig.wide = TRUE----------------------------------------------------------
cellCommunities <- findCommunitiesSimmilarity(similarityTable = similarityTable)

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(
  head(cellCommunities)
)

## ----fig.wide = TRUE----------------------------------------------------------
# Retrieve the top 3 similar cluster for each of the clusters:
similarityTable3Top <- clusterFoldSimilarity(scList=singlecellObjectList, 
                                             topN=3,
                                             sampleNames=c("human", "humanNA"), 
                                             nSubsampling=24)

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(
  head(similarityTable3Top),
  caption = 'Similarity results showing the top 3 most similar clusters.', align = "c", 
  format = "html", table.attr = "style='width:70%;'") %>% kableExtra::kable_styling(font_size=10)

## ----fig.wide = TRUE----------------------------------------------------------
# Retrieve the top 5 features that contribute the most to the similarity between each pair of clusters:
similarityTable5TopFeatures <- clusterFoldSimilarity(scList=singlecellObjectList, 
                                                     topNFeatures=5, 
                                                     nSubsampling=24)

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(
  head(similarityTable5TopFeatures, n=10),
  caption = 'Similarity results showing the top 5 features that most contributed to the similarity.', align = "c", 
  format = "html", table.attr = "style='width:70%;'") %>% kableExtra::kable_styling(font_size=10)

## ----fig.wide = TRUE,  out.height="400px"-------------------------------------
similarityTableAllValues <- clusterFoldSimilarity(scList=singlecellObjectList, 
                                                  sampleNames=c("human", "humanNA"), 
                                                  topN=Inf)
dim(similarityTableAllValues)

## -----------------------------------------------------------------------------
library(dplyr)
dataset1 <- "human"
dataset2 <- "humanNA"
similarityTable2 <- similarityTableAllValues %>% 
  filter(datasetL == dataset1 & datasetR == dataset2) %>% 
  arrange(desc(as.numeric(clusterL)), as.numeric(clusterR))
cls <- unique(similarityTable2$clusterL)
cls2 <- unique(similarityTable2$clusterR)
similarityMatrixAll <- t(matrix(similarityTable2$similarityValue, ncol=length(unique(similarityTable2$clusterL))))
rownames(similarityMatrixAll) <- cls
colnames(similarityMatrixAll) <- cls2

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(
  similarityMatrixAll,
  caption = 'A 2 datasets Similarity matrix.', digits = 2, align = "c", 
  format = "html", table.attr = "style='width:60%;'") %>% kableExtra::kable_styling(font_size=8)

## -----------------------------------------------------------------------------
# Mouse pancreatic single cell data
pancreasBaronMM <- scRNAseq::BaronPancreasData(which="mouse", ensembl=FALSE)

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(
  table(colData(pancreasBaronMM)$label),
  caption = 'Cell-types on pancreas dataset from Baron et al.', align = "c"
)

## -----------------------------------------------------------------------------
colData(pancreasBaronMM)$cell.type <- colData(pancreasBaronMM)$label
# Translate mouse gene ids to human ids
# *for the sake of simplicity we are going to transform to uppercase all mouse gene names
rownames(pancreasBaronMM) <- make.names(toupper(rownames(pancreasBaronMM)), unique=TRUE)
# Create seurat object
singlecell3Seurat <- CreateSeuratObject(counts=counts(pancreasBaronMM), meta.data=as.data.frame(colData(pancreasBaronMM)))

# We append the single-cell object to our list
singlecellObjectList[[3]] <- singlecell3Seurat

## ----results='hide'-----------------------------------------------------------
scObject <- singlecellObjectList[[3]]
scObject <- NormalizeData(scObject)
scObject <- FindVariableFeatures(scObject, selection.method="vst", nfeatures=2000)
scObject <- ScaleData(scObject, features=VariableFeatures(scObject))
scObject <- RunPCA(scObject, features=VariableFeatures(object=scObject))
scObject <- FindNeighbors(scObject, dims=seq(16))
scObject <- FindClusters(scObject, resolution=0.4)
singlecellObjectList[[3]] <- scObject

## ----fig.wide = TRUE----------------------------------------------------------
# We use the cell labels as a second reference, but we can also use the cluster labels if our interest is to match clusters
Idents(singlecellObjectList[[3]]) <- factor(singlecellObjectList[[3]][[]][,"cell.type"])

# We subset the most variable genes in each experiment
singlecellObjectListVariable <- lapply(singlecellObjectList, function(x){x[VariableFeatures(x),]})

# Setting the number of CPUs with BiocParallel:
BiocParallel::register(BPPARAM =  BiocParallel::MulticoreParam(workers = 6))

similarityTableHumanMouse <- clusterFoldSimilarity(scList=singlecellObjectListVariable,
                                                        sampleNames=c("human", "humanNA", "mouse"),
                                                        topN=1, 
                                                        nSubsampling=24,
                                                        parallel=TRUE)

## ----fig.wide = TRUE,  out.height="400px"-------------------------------------
similarityTableHumanMouseAll <- clusterFoldSimilarity(scList=singlecellObjectListVariable,
                                                          sampleNames=c("human", "humanNA", "mouse"),
                                                          topN=Inf,
                                                          nSubsampling=24,
                                                          parallel=TRUE)

## ----fig.wide = TRUE,  out.height="400px"-------------------------------------
ClusterFoldSimilarity::similarityHeatmap(similarityTable=similarityTableHumanMouseAll, mainDataset="humanNA")

## ----fig.wide = TRUE,  out.height="400px"-------------------------------------
# Turn-off the highlighting:
ClusterFoldSimilarity::similarityHeatmap(similarityTable=similarityTableHumanMouseAll, mainDataset="humanNA", highlightTop=FALSE)

## -----------------------------------------------------------------------------
sessionInfo()

