# Code example from 'milo_gastrulation' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = FALSE,
  message=FALSE
)

## ----setup, message=FALSE, warning=FALSE--------------------------------------
library(miloR)
library(SingleCellExperiment)
library(scater)
library(scran)
library(dplyr)
library(patchwork)
library(MouseGastrulationData)

## ----warning=FALSE, message=FALSE, echo=FALSE---------------------------------
# ## remove the old cache - this location points to the Bioc submission server - ignore this code block
# library(ExperimentHub)
# oldcache = path.expand(rappdirs::user_cache_dir(appname="ExperimentHub"))
# setExperimentHubOption("CACHE", oldcache)
# eh = ExperimentHub(localHub=FALSE)
# ## removes old location and all resources
# removeCache(eh, ask=FALSE)

## -----------------------------------------------------------------------------
select_samples <- c(2,  3,  6, 4, #15,
                    # 19, 
                    10, 14#, 20 #30
                    #31, 32
                    )
embryo_data = EmbryoAtlasData(samples = select_samples)
embryo_data

## ----dev="jpeg"---------------------------------------------------------------
embryo_data <- embryo_data[,apply(reducedDim(embryo_data, "pca.corrected"), 1, function(x) !all(is.na(x)))]
embryo_data <- runUMAP(embryo_data, dimred = "pca.corrected", name = 'umap')

plotReducedDim(embryo_data, colour_by="stage", dimred = "umap") 

## -----------------------------------------------------------------------------
embryo_milo <- Milo(embryo_data)
embryo_milo

## -----------------------------------------------------------------------------
embryo_milo <- buildGraph(embryo_milo, k = 30, d = 30, reduced.dim = "pca.corrected")

## -----------------------------------------------------------------------------
embryo_milo <- makeNhoods(embryo_milo, prop = 0.1, k = 30, d=30, refined = TRUE, reduced_dims = "pca.corrected")

## -----------------------------------------------------------------------------
plotNhoodSizeHist(embryo_milo)

## -----------------------------------------------------------------------------
embryo_milo <- countCells(embryo_milo, meta.data = as.data.frame(colData(embryo_milo)), sample="sample")

## -----------------------------------------------------------------------------
head(nhoodCounts(embryo_milo))

## -----------------------------------------------------------------------------
embryo_design <- data.frame(colData(embryo_milo))[,c("sample", "stage", "sequencing.batch")]

## Convert batch info from integer to factor
embryo_design$sequencing.batch <- as.factor(embryo_design$sequencing.batch) 
embryo_design <- distinct(embryo_design)
rownames(embryo_design) <- embryo_design$sample

embryo_design

## -----------------------------------------------------------------------------
embryo_milo <- calcNhoodDistance(embryo_milo, d=30, reduced.dim = "pca.corrected")

## -----------------------------------------------------------------------------
da_results <- testNhoods(embryo_milo, design = ~ sequencing.batch + stage, design.df = embryo_design, reduced.dim="pca.corrected")
head(da_results)

## -----------------------------------------------------------------------------
da_results %>%
  arrange(SpatialFDR) %>%
  head() 

## -----------------------------------------------------------------------------
ggplot(da_results, aes(PValue)) + geom_histogram(bins=50)

## ----dev="jpeg"---------------------------------------------------------------
ggplot(da_results, aes(logFC, -log10(SpatialFDR))) + 
  geom_point() +
  geom_hline(yintercept = 1) ## Mark significance threshold (10% FDR)

## ----fig.width=15, fig.height=8, dev="jpeg"-----------------------------------
embryo_milo <- buildNhoodGraph(embryo_milo)

## Plot single-cell UMAP
umap_pl <- plotReducedDim(embryo_milo, dimred = "umap", colour_by="stage", text_by = "celltype", 
                          text_size = 3, point_size=0.5) +
  guides(fill="none")

## Plot neighbourhood graph
nh_graph_pl <- plotNhoodGraphDA(embryo_milo, da_results, layout="umap",alpha=0.1) 
  
umap_pl + nh_graph_pl +
  plot_layout(guides="collect")

## -----------------------------------------------------------------------------
da_results <- annotateNhoods(embryo_milo, da_results, coldata_col = "celltype")
head(da_results)

## -----------------------------------------------------------------------------
ggplot(da_results, aes(celltype_fraction)) + geom_histogram(bins=50)

## -----------------------------------------------------------------------------
da_results$celltype <- ifelse(da_results$celltype_fraction < 0.7, "Mixed", da_results$celltype)

## ----fig.height=7, fig.width=7, dev="jpeg"------------------------------------
plotDAbeeswarm(da_results, group.by = "celltype")

## -----------------------------------------------------------------------------
## Add log normalized count to Milo object
embryo_milo <- logNormCounts(embryo_milo)

da_results$NhoodGroup <- as.numeric(da_results$SpatialFDR < 0.1 & da_results$logFC < 0)
da_nhood_markers <- findNhoodGroupMarkers(embryo_milo, da_results, subset.row = rownames(embryo_milo)[1:10])

head(da_nhood_markers)

## -----------------------------------------------------------------------------
da_nhood_markers <- findNhoodGroupMarkers(embryo_milo, da_results, subset.row = rownames(embryo_milo)[1:10], 
                                          aggregate.samples = TRUE, sample_col = "sample")

head(da_nhood_markers)

## -----------------------------------------------------------------------------
## Run buildNhoodGraph to store nhood adjacency matrix
embryo_milo <- buildNhoodGraph(embryo_milo)

## Find groups
da_results <- groupNhoods(embryo_milo, da_results, max.lfc.delta = 10)
head(da_results)

## ----fig.height=7, fig.width=7, dev="jpeg"------------------------------------
plotNhoodGroups(embryo_milo, da_results, layout="umap") 

## ----dev="jpeg"---------------------------------------------------------------
plotDAbeeswarm(da_results, "NhoodGroup")

## ----dev="jpeg"---------------------------------------------------------------
# code not run - uncomment to run.
# plotDAbeeswarm(groupNhoods(embryo_milo, da_results, max.lfc.delta = 1) , group.by = "NhoodGroup") + ggtitle("max LFC delta=1")
# plotDAbeeswarm(groupNhoods(embryo_milo, da_results, max.lfc.delta = 2)   , group.by = "NhoodGroup") + ggtitle("max LFC delta=2")
# plotDAbeeswarm(groupNhoods(embryo_milo, da_results, max.lfc.delta = 3)   , group.by = "NhoodGroup") + ggtitle("max LFC delta=3")

## ----dev="jpeg"---------------------------------------------------------------
# code not run - uncomment to run.
# plotDAbeeswarm(groupNhoods(embryo_milo, da_results, max.lfc.delta = 5, overlap=1) , group.by = "NhoodGroup") + ggtitle("overlap=5")
# plotDAbeeswarm(groupNhoods(embryo_milo, da_results, max.lfc.delta = 5, overlap=5)   , group.by = "NhoodGroup") + ggtitle("overlap=10")
# plotDAbeeswarm(groupNhoods(embryo_milo, da_results, max.lfc.delta = 5, overlap=10)   , group.by = "NhoodGroup") + ggtitle("overlap=20")

## ----dev="jpeg"---------------------------------------------------------------
set.seed(42)
da_results <- groupNhoods(embryo_milo, da_results, max.lfc.delta = 10, overlap=1)
plotNhoodGroups(embryo_milo, da_results, layout="umap")
plotDAbeeswarm(da_results, group.by = "NhoodGroup")

## -----------------------------------------------------------------------------
## Exclude zero counts genes
keep.rows <- rowSums(logcounts(embryo_milo)) != 0
embryo_milo <- embryo_milo[keep.rows, ]

## Find HVGs
set.seed(101)
dec <- modelGeneVar(embryo_milo)
hvgs <- getTopHVGs(dec, n=2000)

# this vignette randomly fails to identify HVGs for some reason
if(!length(hvgs)){
    set.seed(42)
    dec <- modelGeneVar(embryo_milo)
    hvgs <- getTopHVGs(dec, n=2000)
}

head(hvgs)

## -----------------------------------------------------------------------------
set.seed(42)
nhood_markers <- findNhoodGroupMarkers(embryo_milo, da_results, subset.row = hvgs, 
                                       aggregate.samples = TRUE, sample_col = "sample")

head(nhood_markers)

## -----------------------------------------------------------------------------
gr5_markers <- nhood_markers[c("logFC_5", "adj.P.Val_5")] 
colnames(gr5_markers) <- c("logFC", "adj.P.Val")

head(gr5_markers[order(gr5_markers$adj.P.Val), ])

## -----------------------------------------------------------------------------
nhood_markers <- findNhoodGroupMarkers(embryo_milo, da_results, subset.row = hvgs, 
                                       aggregate.samples = TRUE, sample_col = "sample",
                                       subset.groups = c("5")
                                       )

head(nhood_markers)

## -----------------------------------------------------------------------------
nhood_markers <- findNhoodGroupMarkers(embryo_milo, da_results, subset.row = hvgs,
                                       subset.nhoods = da_results$NhoodGroup %in% c('5','6'),
                                       aggregate.samples = TRUE, sample_col = "sample")

head(nhood_markers)

## ----dev="jpeg"---------------------------------------------------------------
ggplot(nhood_markers, aes(logFC_5, -log10(adj.P.Val_5 ))) + 
  geom_point(alpha=0.5, size=0.5) +
  geom_hline(yintercept = 3)

markers <- nhood_markers$GeneID[nhood_markers$adj.P.Val_5 < 0.01 & nhood_markers$logFC_5 > 0]

## ----fig.width=12, fig.height=7, dev="jpeg"-----------------------------------
set.seed(42)
plotNhoodExpressionGroups(embryo_milo, da_results, features=intersect(rownames(embryo_milo), markers[1:10]),
                          subset.nhoods = da_results$NhoodGroup %in% c('6','5'), 
                          scale=TRUE,
                          grid.space = "fixed")

## ----warning=FALSE------------------------------------------------------------
dge_6 <- testDiffExp(embryo_milo, da_results, design = ~ stage, meta.data = data.frame(colData(embryo_milo)),
                     subset.row = rownames(embryo_milo)[1:5], subset.nhoods=da_results$NhoodGroup=="6")

dge_6

## -----------------------------------------------------------------------------
sessionInfo()

