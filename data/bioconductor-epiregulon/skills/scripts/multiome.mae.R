# Code example from 'multiome.mae' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = TRUE
)

## ----results='hide', message=FALSE, eval=FALSE--------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("epiregulon")
# 

## ----setup, message=FALSE, eval=FALSE-----------------------------------------
# devtools::install_github(repo ='xiaosaiyao/epiregulon')

## ----echo=TRUE, results='hide', message=FALSE, warning=FALSE------------------
library(epiregulon)

## ----echo=TRUE, results='hide', message=FALSE, warning=FALSE------------------
# load the MAE object
library(scMultiome)
mae <- scMultiome::reprogramSeq()

# extract peak matrix
PeakMatrix <- mae[["PeakMatrix"]]

# extract expression matrix
GeneExpressionMatrix <- mae[["GeneExpressionMatrix"]]
rownames(GeneExpressionMatrix) <- rowData(GeneExpressionMatrix)$name

# define the order of hash_assigment
GeneExpressionMatrix$hash_assignment <- 
  factor(as.character(GeneExpressionMatrix$hash_assignment),
         levels = c("HTO10_GATA6_UTR", "HTO2_GATA6_v2", 
                    "HTO8_NKX2.1_UTR", "HTO3_NKX2.1_v2",
                    "HTO1_FOXA2_v2", "HTO4_mFOXA1_v2", "HTO6_hFOXA1_UTR", 
                    "HTO5_NeonG_v2"))
# extract dimensional reduction matrix
reducedDimMatrix <- reducedDim(mae[['TileMatrix500']], "LSI_ATAC")

# transfer UMAP_combined from TileMatrix to GeneExpressionMatrix
reducedDim(GeneExpressionMatrix, "UMAP_Combined") <- 
  reducedDim(mae[['TileMatrix500']], "UMAP_Combined")

## -----------------------------------------------------------------------------

scater::plotReducedDim(GeneExpressionMatrix, 
                       dimred = "UMAP_Combined", 
                       text_by = "Clusters", 
                       colour_by = "Clusters")


## ----getTFMotifInfo-----------------------------------------------------------
grl <- getTFMotifInfo(genome = "hg38")
grl

## ----eval=FALSE---------------------------------------------------------------
# grl.motif <- getTFMotifInfo(genome = "hg38",
#                             mode = "motif",
#                             peaks = rowRanges(PeakMatrix))

## ----optimizeMetacellNumber---------------------------------------------------
cellNum <- optimizeMetacellNumber(peakMatrix = PeakMatrix,
                                  expMatrix = GeneExpressionMatrix,
                                  reducedDim = reducedDimMatrix,
                                  exp_assay = "normalizedCounts",
                                  peak_assay = "counts",
                                  BPPARAM = BiocParallel::SerialParam(progressbar = FALSE))

## ----optim_plot---------------------------------------------------------------
plot(cellNum)

## ----calculateP2G-------------------------------------------------------------
set.seed(1010)
p2g <- calculateP2G(peakMatrix = PeakMatrix, 
                    expMatrix = GeneExpressionMatrix, 
                    reducedDim = reducedDimMatrix,
                    exp_assay = "normalizedCounts",
                    peak_assay = "counts",
                    cellNum = cellNum,
                    BPPARAM = BiocParallel::SerialParam(progressbar = FALSE))

p2g

## ----addTFMotifInfo-----------------------------------------------------------

overlap <- addTFMotifInfo(grl = grl, 
                          p2g = p2g, 
                          peakMatrix = PeakMatrix)
head(overlap)

## ----warning=FALSE, getRegulon------------------------------------------------

regulon <- getRegulon(p2g = p2g, 
                      overlap = overlap)
regulon


## ----network pruning, results = "hide", message = FALSE-----------------------

pruned.regulon <- pruneRegulon(expMatrix = GeneExpressionMatrix,
                               exp_assay = "normalizedCounts",
                               peakMatrix = PeakMatrix,
                               peak_assay = "counts",
                               test = "chi.sq",
                               regulon = regulon[regulon$tf %in% 
                                         c("NKX2-1","GATA6","FOXA1","FOXA2", "AR"),],
                               clusters = GeneExpressionMatrix$Clusters,
                               prune_value = "pval",
                               regulon_cutoff = 0.05
                               )

pruned.regulon

## ----addWeights, results = "hide", warning = FALSE, message = FALSE-----------

regulon.w <- addWeights(regulon = pruned.regulon,
                        expMatrix  = GeneExpressionMatrix,
                        exp_assay  = "normalizedCounts",
                        peakMatrix = PeakMatrix,
                        peak_assay = "counts",
                        clusters = GeneExpressionMatrix$Clusters,
                        method = "wilcox")

regulon.w


## ----addMotifScore------------------------------------------------------------

regulon.w.motif <- addMotifScore(regulon = regulon.w,
                                 peaks = rowRanges(PeakMatrix),
                                 species = "human",
                                 genome = "hg38")

# if desired, set weight to 0 if no motif is found
regulon.w.motif$weight[regulon.w.motif$motif == 0] <- 0

regulon.w.motif

## ----add logFC----------------------------------------------------------------
# create logcounts
GeneExpressionMatrix <- scuttle::logNormCounts(GeneExpressionMatrix)

# add log fold changes which are calculated by taking the difference of the log counts
regulon.w <- addLogFC(regulon = regulon.w,
                      clusters = GeneExpressionMatrix$hash_assignment,
                      expMatrix  = GeneExpressionMatrix,
                      assay.type  = "logcounts",
                      pval.type = "any",
                      logFC_condition = c("HTO10_GATA6_UTR", 
                                          "HTO2_GATA6_v2", 
                                          "HTO8_NKX2.1_UTR"),
                      logFC_ref = "HTO5_NeonG_v2")

regulon.w

## ----calculateActivity--------------------------------------------------------
score.combine <- calculateActivity(expMatrix = GeneExpressionMatrix,
                                   regulon = regulon.w, 
                                   mode = "weight", 
                                   method = "weightedMean", 
                                   exp_assay = "normalizedCounts",
                                   normalize = FALSE)

score.combine[1:5,1:5]

## -----------------------------------------------------------------------------
sessionInfo()

