# Code example from 'GSEAmining' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("GSEAmining")

## ----eval=FALSE---------------------------------------------------------------
# install.packages("devtools") # If you have not installed "devtools" package
# library(devtools)
# devtools::install_github("oriolarques/GSEAmining")

## ----eval=FALSE---------------------------------------------------------------
# # A geneList contains three features:
# # 1.numeric vector: fold change or other type of numerical variable
# # 2.named vector: every number has a name, the corresponding gene ID
# # 3.sorted vector: number should be sorted in decreasing order
# tableTop_p30 <- as.data.frame(tableTop_p30)
# geneList = tableTop_p30[,2]
# names(geneList) = as.character(tableTop_p30[,1])

## ----eval=FALSE---------------------------------------------------------------
# library(clusterProfiler)
# # Read the .gmt file from MSigDB
# gmtC2<- read.gmt("gmt files/c2.all.v7.1.symbols.gmt")
# gmtC5<- read.gmt('gmt files/c5.all.v7.1.symbols.gmt')
# gmtHALL <- read.gmt('gmt files/h.all.v7.1.symbols.gmt')
# 
# # Merge all the gene sets
# gmt_all <- rbind(gmtC2, gmtC5, gmtHALL)

## ----eval=FALSE---------------------------------------------------------------
# GSEA_p30<-GSEA(geneList, TERM2GENE = gmt_all, nPerm = 1000, pvalueCutoff = 0.5)
# 
# # Selection of gene sets with a specific thershold in terms of NES and p.adjust
# genesets_sel <- GSEA_p30@result

## -----------------------------------------------------------------------------
# Structure of the data included in the package
data('genesets_sel', package = 'GSEAmining')
tibble::glimpse(genesets_sel)

## -----------------------------------------------------------------------------
library(GSEAmining)
data("genesets_sel", package = 'GSEAmining')
gs.filt <- gm_filter(genesets_sel, 
                     p.adj = 0.05, 
                     neg_NES = 2.6, 
                     pos_NES = 2)

## ----setup--------------------------------------------------------------------
# Create an object that will contain the cluster of gene sets.
gs.cl <- gm_clust(gs.filt)

## ----fig.height = 7, fig.width = 7--------------------------------------------
gm_dendplot(gs.filt, 
            gs.cl)

## ----fig.height = 7, fig.width = 7--------------------------------------------
gm_dendplot(gs.filt, 
            gs.cl, 
            col_pos = 'orange', 
            col_neg = 'black', 
            rect = TRUE,
            dend_len = 20, 
            rect_len = 2)


## ----message = FALSE, fig.height = 7, fig.width = 7---------------------------
gm_enrichterms(gs.filt, gs.cl)

## ----message = FALSE, fig.height = 7, fig.width = 7---------------------------
gm_enrichterms(gs.filt, 
               gs.cl, 
               clust = FALSE,
               col_pos = 'chocolate3',
               col_neg = 'skyblue3')

## ----message = FALSE, fig.height = 12, fig.width = 7.2------------------------
gm_enrichcores(gs.filt, gs.cl)

## ----eval=FALSE---------------------------------------------------------------
# gm_enrichreport(gs.filt, gs.cl, output = 'gm_report')

## -----------------------------------------------------------------------------
sessionInfo()

