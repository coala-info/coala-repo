# Code example from 'iSEEfier_userguide' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  error    = FALSE,
  warning  = FALSE,
  eval     = TRUE,
  message  = FALSE
)

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("iSEEfier")

## ----setup--------------------------------------------------------------------
library("iSEEfier")

## ----runfunc, eval=FALSE------------------------------------------------------
# iSEEinit(sce = sce_obj,
#          features = feature_list,
#          reddim.type = reduced_dim,
#          clusters = cluster,
#          groups = group,
#          add_markdown_panel = FALSE)

## ----loaddata-----------------------------------------------------------------
library("scRNAseq")
sce <- BaronPancreasData('mouse')
sce

## ----logNorm------------------------------------------------------------------
library("scuttle")
sce <- logNormCounts(sce)

## ----reddim-------------------------------------------------------------------
library("scater")
sce <- runPCA(sce)
sce <- runTSNE(sce)
sce <- runUMAP(sce)

## ----genelist-----------------------------------------------------------------
gene_list <- c("Gcg", # alpha
               "Ins1") # beta

## ----reddim-type--------------------------------------------------------------
reddim_type <- "TSNE"

## ----cluster-id---------------------------------------------------------------
# cell populations
cluster <- "label" #the name should match what's in the colData names

## ----group-id-----------------------------------------------------------------
# ICR vs C57BL/6
group <- "strain" #the name should match what's in the colData names

## ----initial1-----------------------------------------------------------------
initial1 <- iSEEinit(sce = sce,
                    features = gene_list,
                    clusters = cluster,
                    groups = group,
                    add_markdown_panel = TRUE)

## ----iSEEviz1, eval=FALSE-----------------------------------------------------
# library("iSEE")
# iSEE(sce, initial= initial1)

## ----set-param----------------------------------------------------------------
GO_collection <- "GO"
Mm_organism <- "org.Mm.eg.db"
gene_id <- "SYMBOL"
cluster <- "label"
group <- "strain"
reddim_type <- "PCA"

## ----initial2-----------------------------------------------------------------
results <- iSEEnrich(
  sce = sce,
  collection = GO_collection,
  gene_identifier = gene_id,
  organism = Mm_organism,
  clusters = cluster,
  reddim_type = reddim_type,
  groups = group
)

## ----iSEEviz2,  eval=FALSE----------------------------------------------------
# iSEE(results$sce, initial = results$initial)

## ----initial3-----------------------------------------------------------------
initial3 <- iSEEmarker(
  sce = sce,
  clusters = cluster,
  groups = group,
  selection_plot_format = "ColumnDataPlot")

## ----iSEEviz3,  eval=FALSE----------------------------------------------------
# iSEE(sce, initial = initial3)

## ----panelgraph---------------------------------------------------------------
library(ggplot2)
view_initial_tiles(initial = initial1)
view_initial_tiles(initial = results$initial)

## ----networkviz---------------------------------------------------------------
library("igraph")
library("visNetwork")
g1 <- view_initial_network(initial1, plot_format = "igraph")
g1
initial2 <- results$initial
g2 <- view_initial_network(initial2, plot_format = "visNetwork")

## ----glueconfig---------------------------------------------------------------
merged_config <- glue_initials(initial1,initial2)

## ----preview------------------------------------------------------------------
view_initial_tiles(merged_config)

## -----------------------------------------------------------------------------
sessionInfo()

