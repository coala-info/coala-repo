# Code example from 'SpatialDecon_vignette_NSCLC' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----installation, eval=FALSE-------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("SpatialDecon")
# BiocManager::install("GeoMxTools")

## ----setup--------------------------------------------------------------------
library(SpatialDecon)
library(GeomxTools)

## ----loaddata-----------------------------------------------------------------
data("nsclc")

nsclc <- updateGeoMxSet(nsclc)

dim(nsclc)
head(pData(nsclc))
nsclc@assayData$exprs[seq_len(5), seq_len(5)]

# better segment names:
sampleNames(nsclc) <-  
  paste0(nsclc$ROI, nsclc$AOI.name)

#This dataset is already on Target level (genes instead of probeIDs in rows), 
# just need to reflect that in object. 
featureType(nsclc) <- "Target"

## ----derivebg-----------------------------------------------------------------
bg = derive_GeoMx_background(norm = nsclc@assayData$exprs_norm,
                             probepool = fData(nsclc)$Module,
                             negnames = c("NegProbe-CTP01", "NegProbe-Kilo"))

## ----showsafetme, fig.height=5, fig.width=10, fig.cap = "The safeTME cell profile matrix"----
data("safeTME")
data("safeTME.matches")

signif(safeTME[seq_len(3), seq_len(3)], 2)

heatmap(sweep(safeTME, 1, apply(safeTME, 1, max), "/"),
        labRow = NA, margins = c(10, 5))


## ----downloadmatrix, fig.height=7, fig.width=10, fig.cap = "The Mouse Spleen profile matrix", eval=T----
mousespleen <- download_profile_matrix(species = "Mouse",
                                       age_group = "Adult", 
                                       matrixname = "Spleen_MCA")
dim(mousespleen)

mousespleen[1:4,1:4]

head(cellGroups)

metadata

heatmap(sweep(mousespleen, 1, apply(mousespleen, 1, max), "/"),
        labRow = NA, margins = c(10, 5), cexCol = 0.7)


## ----single cell data---------------------------------------------------------
data("mini_singleCell_dataset")

mini_singleCell_dataset$mtx@Dim # genes x cells

as.matrix(mini_singleCell_dataset$mtx)[1:4,1:4]

head(mini_singleCell_dataset$annots)

table(mini_singleCell_dataset$annots$LabeledCellType)


## ----creatematrix, fig.height=7, fig.width=10, fig.cap = "Custom profile matrix"----
custom_mtx <- create_profile_matrix(mtx = mini_singleCell_dataset$mtx,            # cell x gene count matrix
                                    cellAnnots = mini_singleCell_dataset$annots,  # cell annotations with cell type and cell name as columns 
                                    cellTypeCol = "LabeledCellType",  # column containing cell type
                                    cellNameCol = "CellID",           # column containing cell ID/name
                                    matrixName = "custom_mini_colon", # name of final profile matrix
                                    outDir = NULL,                    # path to desired output directory, set to NULL if matrix should not be written
                                    normalize = FALSE,                # Should data be normalized? 
                                    minCellNum = 5,                   # minimum number of cells of one type needed to create profile, exclusive
                                    minGenes = 10,                    # minimum number of genes expressed in a cell, exclusive
                                    scalingFactor = 5,                # what should all values be multiplied by for final matrix
                                    discardCellTypes = TRUE)          # should cell types be filtered for types like mitotic, doublet, low quality, unknown, etc.

head(custom_mtx)

heatmap(sweep(custom_mtx, 1, apply(custom_mtx, 1, max), "/"),
        labRow = NA, margins = c(10, 5), cexCol = 0.7)


## ----runiss-------------------------------------------------------------------
res = runspatialdecon(object = nsclc,
                      norm_elt = "exprs_norm",
                      raw_elt = "exprs",
                      X = safeTME,
                      align_genes = TRUE)

str(pData(res))
names(res@assayData)

## ----plotissres, fig.height = 5, fig.width = 8, fig.cap = "Cell abundance estimates"----
heatmap(t(res$beta), cexCol = 0.5, cexRow = 0.7, margins = c(10,7))

## ----showmatches--------------------------------------------------------------
str(safeTME.matches)

## ----runisstils---------------------------------------------------------------
# vector identifying pure tumor segments:
nsclc$istumor = nsclc$AOI.name == "Tumor"

# run spatialdecon with all the bells and whistles:
restils = runspatialdecon(object = nsclc,
                          norm_elt = "exprs_norm",                # normalized data
                          raw_elt = "exprs",                      # expected background counts for every data point in norm
                          X = safeTME,                            # safeTME matrix, used by default
                          cellmerges = safeTME.matches,           # safeTME.matches object, used by default
                          cell_counts = nsclc$nuclei,      # nuclei counts, used to estimate total cells
                          is_pure_tumor = nsclc$istumor,   # identities of the Tumor segments/observations
                          n_tumor_clusters = 5)                   # how many distinct tumor profiles to append to safeTME

str(pData(restils))
names(restils@assayData)
str(restils@experimentData@other)

## ----shownewX, fig.height=5, fig.width=8, fig.cap = "safeTME merged with newly-derived tumor profiles"----
heatmap(sweep(restils@experimentData@other$SpatialDeconMatrix, 1, apply(restils@experimentData@other$SpatialDeconMatrix, 1, max), "/"),
         labRow = NA, margins = c(10, 5))


## ----barplot, fig.width=9, fig.height=6, fig.cap="Barplots of TIL abundance"----
# For reference, show the TILs color data object used by the plotting functions 
# when safeTME has been used:
data("cellcols")
cellcols

# show just the TME segments, since that's where the immune cells are:
o = hclust(dist(t(restils$cell.counts$cell.counts)))$order
layout(mat = (matrix(c(1, 2), 1)), widths = c(7, 3))
TIL_barplot(t(restils$cell.counts$cell.counts[, o]), draw_legend = TRUE, 
            cex.names = 0.5)
# or the proportions of cells:
temp = replace(restils$prop_of_nontumor, is.na(restils$prop_of_nontumor), 0)
o = hclust(dist(temp[restils$AOI.name == "TME",]))$order
TIL_barplot(t(restils$prop_of_nontumor[restils$AOI.name == "TME",])[, o], 
            draw_legend = TRUE, cex.names = 0.75)


## ----florets, fig.width=8, fig.height=6, fig.cap = "TIL abundance plotted on PC space"----
# PCA of the normalized data:
pc = prcomp(t(log2(pmax(nsclc@assayData$exprs_norm, 1))))$x[, c(1, 2)]

# run florets function:
par(mar = c(5,5,1,1))
layout(mat = (matrix(c(1, 2), 1)), widths = c(6, 2))
florets(x = pc[, 1], y = pc[, 2],
        b = t(restils$beta), cex = .5,
        xlab = "PC1", ylab = "PC2")
par(mar = c(0,0,0,0))
frame()
legend("center", fill = cellcols[colnames(restils$beta)], 
       legend = colnames(restils$beta), cex = 0.7)

## ----collapse, fig.width=5, fig.height=5, fig.cap="Cell abundance estimates with related cell types collapsed"----
matching = list()
matching$myeloid = c( "macrophages", "monocytes", "mDCs")
matching$T.NK = c("CD4.T.cells","CD8.T.cells", "Treg", "NK")
matching$B = c("B")
matching$mast = c("mast")
matching$neutrophils = c("neutrophils")
matching$stroma = c("endothelial.cells", "fibroblasts")


collapsed = runCollapseCellTypes(object = restils, 
                                 matching = matching)

heatmap(t(collapsed$beta), cexRow = 0.85, cexCol = 0.75)

## ----appendtumor, fig.width = 10, fig.height= 5, fig.cap = "safeTME merged with newly-derived tumor profiles"----
pure.tumor.ids = res$AOI.name == "Tumor"
safeTME.with.tumor = runMergeTumorIntoX(object = nsclc,
                                        norm_elt = "exprs_norm", 
                                        pure_tumor_ids = pure.tumor.ids,
                                        X = safeTME,
                                        K = 3) 

heatmap(sweep(safeTME.with.tumor, 1, apply(safeTME.with.tumor, 1, max), "/"),
        labRow = NA, margins = c(10, 5))


## ----reverse, fig.height=6, fig.width=6, fig.cap="Residuals from reverseDecon"----
rdecon = runReverseDecon(object = nsclc,
                         norm_elt = "exprs_norm",
                         beta = res$beta)
str(fData(rdecon))
names(rdecon@assayData)

# look at the residuals:
heatmap(pmax(pmin(rdecon@assayData$resids, 2), -2))

## ----reverse2, fig.height=6, fig.width=6, fig.cap="Genes' dependency on cell mixing"----
# look at the two metrics of goodness-of-fit:
plot(fData(rdecon)$cors, fData(rdecon)$resid.sd, col = 0)
showgenes = c("CXCL14", "LYZ", "FOXP3")
text(fData(rdecon)$cors[!rownames(fData(rdecon)) %in% showgenes], 
     fData(rdecon)$resid.sd[!rownames(fData(rdecon)) %in% showgenes], 
     setdiff(rownames(fData(rdecon)), showgenes), cex = 0.5)
text(fData(rdecon)$cors[rownames(fData(rdecon)) %in% showgenes], fData(rdecon)$resid.sd[rownames(fData(rdecon)) %in% showgenes], 
     showgenes, cex = 0.75, col = 2)


## ----sessioninfo--------------------------------------------------------------
sessionInfo()

