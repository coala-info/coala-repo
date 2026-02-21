# Code example from 'more_than_visium' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  message = FALSE,
  comment = "#>",
  fig.retina = NULL
)

## ----redDim_spe---------------------------------------------------------------
library(escheR)
library(STexampleData)
library(scater)
library(scran)

spe <- Visium_humanDLPFC() |> 
  logNormCounts()
spe <- spe[, spe$in_tissue == 1]
spe <- spe[, !is.na(spe$ground_truth)]
top.gene <- getTopHVGs(spe, n=500)

set.seed(100) # See below.
spe <- runPCA(spe, subset_row = top.gene) 

make_escheR(
  spe,
  dimred = "PCA"
) |> 
  add_fill(var = "ground_truth") +
  theme_minimal()

## ----bin_plot-----------------------------------------------------------------
spe$counts_MOBP <- counts(spe)[which(rowData(spe)$gene_name=="MOBP"),]
spe$ground_truth <- factor(spe$ground_truth)

# Point Binning version
make_escheR(
  spe,
  dimred = "PCA"
) |> 
  add_ground_bin(
    var = "ground_truth"
    ) |> 
  add_fill_bin(
    var = "counts_MOBP"
    ) +
  # Customize aesthetics
   scale_fill_gradient(low = "white", high = "black", name = "MOBP Count")+
  scale_color_discrete(name = "Spatial Domains") +
  theme_minimal()

## ----im_seqFISH---------------------------------------------------------------
library(STexampleData)
library(escheR)
spe_seqFISH <- seqFISH_mouseEmbryo()

make_escheR(spe_seqFISH) |>
  add_fill(var = "embryo")

## ----im_slideseq--------------------------------------------------------------
library(STexampleData)
library(escheR)
spe_slideseq <- SlideSeqV2_mouseHPC()

make_escheR(spe_slideseq) |>
  add_fill(var = "celltype")

## ----seurat_to_dataframe, eval = FALSE----------------------------------------
# library(escheR)
# library(Seurat)
# pbmc_small <- SeuratObject::pbmc_small
# pbmc_2pc <- pbmc_small@reductions$pca@cell.embeddings[,1:2]
# pbmc_meta <- pbmc_small@meta.data
# 
# #> Call generic function for make_escheR.data.frame
# make_escheR(
#   object = pbmc_meta,
#   .x = pbmc_2pc[,1],
#   .y = pbmc_2pc[,2]) |>
#   add_fill(var = "groups")

## -----------------------------------------------------------------------------
utils::sessionInfo()

