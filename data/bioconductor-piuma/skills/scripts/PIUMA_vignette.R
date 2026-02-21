# Code example from 'PIUMA_vignette' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----install-package, eval=FALSE----------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("PIUMA")

## ----chunk-1,eval=FALSE-------------------------------------------------------
# #############################################
# ############# NOT TO EXECUTE ################
# ########## please skip this chunk ###########
# #############################################
# 
# 
# dataset_seu <- readRDS("./GSE193346_CD1_seurat_object.rds")
# 
# # subset vascular endothelial cells
# vascularEC_seuobj <- subset(x = dataset_seu,
#                             subset = markFinal == "vascular_ec")
# df_data_counts <- vascularEC_seuobj@assays$RNA@counts
# df_cl <- as.data.frame(df_data_counts)
# meta_cl <- vascularEC_seuobj@meta.data[, c(10,13,14,15)]
# meta_cl[sapply(meta_cl, is.character)] <- lapply(meta_cl[sapply(meta_cl,
#                                                                 is.character)],
#                                                  as.factor)
# 
# ## Filtering and normalization
# colnames(meta_cl)[4] <- "class"
# SE <- DaMiR.makeSE(df_cl, meta_cl)
# data_norm <- DaMiR.normalization(SE,
#                                  type = "vst",
#                                  minCounts = 3,
#                                  fSample = 0.4,
#                                  hyper = "no")
# vascEC_norm <- round(t(assay(data_norm)), 2)
# vascEC_meta <- meta_cl[, c(3,4), drop=FALSE]
# df_TDA <- cbind(vascEC_meta, vascEC_norm)
# 

## ----chunk-2,warning=FALSE----------------------------------------------------
library(PIUMA)
library(ggplot2)
data(vascEC_norm)
data(vascEC_meta)

df_TDA <- cbind(vascEC_meta, vascEC_norm)

dim(df_TDA)
head(df_TDA[1:5, 1:7])

## ----chunk-3,warning=FALSE----------------------------------------------------
TDA_obj <- makeTDAobj(df_TDA, c("stage","zone"))


## ----chunk-3_1,warning=FALSE, eval=FALSE--------------------------------------
# data("vascEC_meta")
# data("vascEC_norm")
# library(SummarizedExperiment)
# 
# dataSE <- SummarizedExperiment(assays=as.matrix(t(vascEC_norm)),
#                                colData=as.data.frame(vascEC_meta))
# TDA_obj <- makeTDAobjFromSE(dataSE, c("stage","zone"))
# 

## ----chunk-4, fig.width=10, fig.height=10,warning=FALSE, fig.cap = "Scatterplot from UMAP. Four scatter plots are drawn, using the first 2 components identified by UMAP. Each panel represents cells belonging to a specific heart chamber, while colors refer to the development stage."----
set.seed(1)

# calculate the distance matrix
TDA_obj <- dfToDistance(TDA_obj, distMethod = "euclidean")

# calculate the projections (lenses)
TDA_obj <- dfToProjection(TDA_obj,
                      "UMAP",
                      nComp = 2,
                      umapNNeigh = 25,
                      umapMinDist = 0.3,
                      showPlot = FALSE)

# plot point-cloud based on stage and zone
df_plot <- as.data.frame(cbind(getOutcomeFact(TDA_obj),
                                getComp(TDA_obj)), 
                         stringAsFactor = TRUE)

ggplot(data= df_plot, aes(x=comp1, y=comp2, color=stage))+
  geom_point(size=3)+
  facet_wrap(~zone)


## ----chunk-5-1, fig.width=10, fig.height=10,warning=FALSE---------------------
TDA_obj <- mapperCore(TDA_obj,
                       nBins = 15,
                       overlap = 0.3,
                       clustMeth = "kmeans")

# number of clusters (nodes)
dim(getDfMapper(TDA_obj))

# content of two overlapping clusters
getDfMapper(TDA_obj)["node_102_cl_1", 1]
getDfMapper(TDA_obj)["node_117_cl_1", 1]


## ----chunk-6, fig.width=10, fig.height=10,warning=FALSE-----------------------
# Jaccard Matrix
TDA_obj <- jaccardMatrix(TDA_obj)
head(round(getJacc(TDA_obj)[1:5,1:5],3))
round(getJacc(TDA_obj)["node_102_cl_1","node_117_cl_1"],3)

## ----chunk-7-1, fig.width=10, fig.height=10,warning=FALSE---------------------
TDA_obj <- tdaDfEnrichment(TDA_obj,
                           cbind(getScaledData(TDA_obj),
                                 getOutcome(TDA_obj)))
head(getNodeDataMat(TDA_obj)[1:5, tail(names(getNodeDataMat(TDA_obj)), 5)])

## ----chunk-8, fig.width=10, fig.height=10,warning=FALSE, eval=TRUE, fig.cap = "Power-law degree distribution. The correlation between P(k) (y-axis) and k (x-axis) is represented in linear scale (on the left) and in log-log scale (on the right). The regression line (orange line) is also provided."----
# Anchoring (supervised)
entropy <-  checkNetEntropy(getNodeDataMat(TDA_obj)[, "zone"])
entropy

# Scale free network (unsupervised)
netModel <- checkScaleFreeModel(TDA_obj, showPlot = TRUE)
netModel

## ----chunk-predict-mapper, warning=FALSE, eval=TRUE---------------------------
# quick inference of geometry, metrics-based
TDA_obj <- jaccardMatrix(TDA_obj)
TDA_obj <- setGraph(TDA_obj)
TDA_obj <- predict_mapper_class(TDA_obj, verbose = TRUE)

## ----clustering-1, fig.width=10, fig.height=10, warning=FALSE, eval=TRUE------
TDA_obj <- autoClusterMapper(TDA_obj,method = 'automatic')

## ----clustering-2, fig.width=12, fig.height=12, warning=FALSE, eval=TRUE,fig.cap = "Geometry-guided Clustering on Mapper()'s Graph. Four scatter plots are drawn, using the first 2 components identified by UMAP, faceting for each specific heart chamber. Cells are colored for the topological clusters identified with PIUMA. Topological clusters are also labelled on the graph, while Singletons are excluded."----
library(ggrepel)
library(dplyr)

# plot point-cloud based on stage and zone
df_plot <- as.data.frame(cbind(getOutcomeFact(TDA_obj),
                                getComp(TDA_obj)), 
                         stringAsFactor = TRUE)

df_plot$cell_id <- rownames(df_plot)  
df_plot <- merge(df_plot, TDA_obj@clustering$obs_cluster, 
                 by.x = "cell_id", by.y = "obs", all.x = TRUE)

centroids <- df_plot %>%
  group_by(zone, cluster) %>%
  summarize(
    n_cells = dplyr::n(),
    comp1 = mean(comp1, na.rm = TRUE),
    comp2 = mean(comp2, na.rm = TRUE),
    .groups = 'drop'
  ) %>%
  filter(!grepl("^Singleton", as.character(cluster)))  # Exclude singleton clusters

ggplot(df_plot, aes(x = comp1, y = comp2, color = factor(cluster))) +
  geom_point(size = 3, alpha = 0.7) +
  geom_label_repel(
    data = centroids,
    aes(label = cluster, fill = factor(cluster)),
    color = "white",
    fontface = "bold",
    box.padding = 0.5,
    segment.color = NA,
    min.segment.length = 0
  ) +
  facet_wrap(~ zone) +
  labs(color = "Cluster",
       title = "Geometry-Guided Community Detection",
       subtitle = "Cluster centroids labeled (singletons excluded)",
       caption = "Singleton clusters shown without labels") +
  theme_minimal() +
  scale_color_viridis_d(option = "D") +
  scale_fill_viridis_d(option = "D", guide = "none")

#for more inspection: obs X clusters
head(TDA_obj@clustering$obs_cluster)

# nodes X obs X clusters
head(TDA_obj@clustering$nodes_cluster)

## ----clustering-3, fig.width=10, fig.height=10, warning=FALSE, eval=TRUE------
str(TDA_obj@clustering)

## ----fig.width=10, fig.height=10, warning=FALSE, eval=FALSE-------------------
# write.table(x = round(getJacc(TDA_obj),3),
#             file = "./jaccard.matrix.txt",
#             sep = "\t",
#             quote = FALSE,
#             na = "",
#             col.names = NA)
# 
# write.table(x = getNodeDataMat(TDA_obj),
#             file = "./nodeEnrichment.txt",
#             sep = "\t",
#             quote = FALSE,
#             col.names = NA)
# 
# 

## ----session_info-------------------------------------------------------------
sessionInfo()

