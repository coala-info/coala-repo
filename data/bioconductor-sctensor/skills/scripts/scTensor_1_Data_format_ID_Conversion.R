# Code example from 'scTensor_1_Data_format_ID_Conversion' vignette. See references/ for full tutorial.

## ----scTensor with NCBI Gene ID, eval=FALSE-----------------------------------
# library("scTensor")
# library("AnnotationHub")
# library("LRBaseDbi")
# 
# # Input matrix
# input <- ...
# sce <- SingleCellExperiment(assays=list(counts = input))
# # Celltype vector
# label <- ...
# # LRBase.XXX.eg.db
# ah <- AnnotationHub()
# dbfile <- query(ah, c("LRBaseDb", "Homo sapiens"))[[1]]
# LRBase.Hsa.eg.db <- LRBaseDbi::LRBaseDb(dbfile)
# # Setting
# cellCellSetting(sce, LRBase.Hsa.eg.db, label)

## ----Seurat, eval=FALSE-------------------------------------------------------
# if(!require(Seurat)){
#     BiocManager::install("Seurat")
#     library(Seurat)
# }
# 
# # Load the PBMC dataset
# pbmc.data <- Read10X(data.dir = "filtered_gene_bc_matrices/hg19/")
# 
# # Initialize the Seurat object with the raw (non-normalized data).
# pbmc <- CreateSeuratObject(counts = pbmc.data,
#   project = "pbmc3k", min.cells = 3, min.features = 200)

## ----Ensembl with Organism DB, echo=TRUE--------------------------------------
suppressPackageStartupMessages(library("scTensor"))
if(!require(Homo.sapiens)){
    BiocManager::install("Homo.sapiens")
    suppressPackageStartupMessages(library(Homo.sapiens))
}
if(!require(scTGIF)){
    BiocManager::install("scTGIF")
    suppressPackageStartupMessages(library(scTGIF))
}

# 1. Input matrix
input <- matrix(1:20, nrow=4, ncol=5)
# 2. Gene identifier in each row
rowID <- c("ENSG00000204531", "ENSG00000181449",
  "ENSG00000136997", "ENSG00000136826")
# 3. Corresponding table
LefttoRight <- select(Homo.sapiens,
  column=c("ENSEMBL", "ENTREZID"),
  keytype="ENSEMBL", keys=rowID)
# ID conversion
(input <- convertRowID(input, rowID, LefttoRight))

## ----Ensembl with AnnotationHub, echo=TRUE------------------------------------
suppressPackageStartupMessages(library("AnnotationHub"))

# 1. Input matrix
input <- matrix(1:20, nrow=4, ncol=5)
# 3. Corresponding table
ah <- AnnotationHub()
# Database of Human
hs <- query(ah, c("OrgDb", "Homo sapiens"))[[1]]
LefttoRight <- select(hs,
  column=c("ENSEMBL", "ENTREZID"),
  keytype="ENSEMBL", keys=rowID)
(input <- convertRowID(input, rowID, LefttoRight))

## ----Gene Symbol with Organism DB, echo=TRUE----------------------------------
# 1. Input matrix
input <- matrix(1:20, nrow=4, ncol=5)
# 2. Gene identifier in each row
rowID <- c("POU5F1", "SOX2", "MYC", "KLF4")
# 3. Corresponding table
LefttoRight <- select(Homo.sapiens,
  column=c("SYMBOL", "ENTREZID"),
  keytype="SYMBOL", keys=rowID)
# ID conversion
(input <- convertRowID(input, rowID, LefttoRight))

## ----Gene Symbol with AnnotationHub, echo=TRUE--------------------------------
# 1. Input matrix
input <- matrix(1:20, nrow=4, ncol=5)
# 3. Corresponding table
ah <- AnnotationHub()
# Database of Human
hs <- query(ah, c("OrgDb", "Homo sapiens"))[[1]]
LefttoRight <- select(hs,
  column=c("SYMBOL", "ENTREZID"),
  keytype="SYMBOL", keys=rowID)
(input <- convertRowID(input, rowID, LefttoRight))

## ----Seurat normalization, eval=FALSE-----------------------------------------
# pbmc2 <- NormalizeData(pbmc, normalization.method = "LogNormalize",
#     scale.factor = 10000)
# sce <- as.SingleCellExperiment(pbmc2)
# assayNames(sce) # counts, logcounts

## ----Scater normalization, eval=FALSE-----------------------------------------
# if(!require(scater)){
#     BiocManager::install("scater")
#     library(scater)
# }
# sce <- SingleCellExperiment(assays=list(counts = input))
# cpm(sce) <- calculateCPM(sce)
# sce <- normalize(sce)
# assayNames(sce) # counts, normcounts, logcounts, cpm

## ----Original normalization, eval=FALSE---------------------------------------
# # User's Original Normalization Function
# CPMED <- function(input){
#     libsize <- colSums(input)
#     median(libsize) * t(t(input) / libsize)
# }
# # Normalization
# normcounts(sce) <- log10(CPMED(counts(sce)) + 1)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

