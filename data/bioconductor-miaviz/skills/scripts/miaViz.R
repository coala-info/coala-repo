# Code example from 'miaViz' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)
knitr::opts_chunk$set(dev = "png", dev.args = list(type = "cairo-png")) 

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("miaViz")

## ----setup, message=FALSE-----------------------------------------------------
library(miaViz)
library(scater)
data(GlobalPatterns, package = "mia")

## -----------------------------------------------------------------------------
plotExpression(GlobalPatterns, features = "549322", assay.type = "counts")

## ----transform----------------------------------------------------------------
GlobalPatterns <- transformAssay(GlobalPatterns, method = "relabundance")

## ----plotabundance------------------------------------------------------------
plotAbundance(GlobalPatterns, rank = "Kingdom", assay.type = "relabundance")

## ----plotabundance_king-------------------------------------------------------
GlobalPatterns_king <- agglomerateByRank(GlobalPatterns, "Kingdom")
plotAbundance(GlobalPatterns_king, assay.type = "relabundance")

## ----prevalent----------------------------------------------------------------
prev_phylum <- getPrevalent(GlobalPatterns, rank = "Phylum", detection = 0.01)

## ----plotabundance_prev-------------------------------------------------------
plotAbundance(
    GlobalPatterns[rowData(GlobalPatterns)$Phylum %in% prev_phylum],
    rank = "Phylum",
    assay.type = "relabundance")

## ----plotabundance_sampletype-------------------------------------------------
library(patchwork)
plots <- plotAbundance(
    GlobalPatterns[rowData(GlobalPatterns)$Phylum %in% prev_phylum],
    features = "SampleType",
    rank = "Phylum",
    assay.type = "relabundance")
plots$abundance / plots$SampleType + plot_layout(heights = c(9, 1))

## ----plotrowprevalence--------------------------------------------------------
plotRowPrevalence(
    GlobalPatterns, rank = "Phylum", detections = c(0, 0.001, 0.01, 0.1, 0.2))

## ----plotprevalentabundance---------------------------------------------------
plotPrevalentAbundance(GlobalPatterns, rank = "Family", colour.by = "Phylum") +
    scale_x_log10()

## ----plotprevalence-----------------------------------------------------------
plotPrevalence(
    GlobalPatterns, rank = "Phylum",
    detections = c(0.01, 0.1, 1, 2, 5, 10, 20)/100,
    prevalences = seq(0.1, 1, 0.1))

## ----message=FALSE------------------------------------------------------------
library(scater)
library(mia)

## ----gettop-------------------------------------------------------------------
altExp(GlobalPatterns,"Genus") <- agglomerateByRank(GlobalPatterns,"Genus")
altExp(GlobalPatterns,"Genus") <- addPerFeatureQC(
    altExp(GlobalPatterns,"Genus"))
rowData(altExp(GlobalPatterns,"Genus"))$log_mean <- log(
    rowData(altExp(GlobalPatterns,"Genus"))$mean)
rowData(altExp(GlobalPatterns,"Genus"))$detected <- rowData(
    altExp(GlobalPatterns,"Genus"))$detected / 100
top_taxa <- getTop(
    altExp(GlobalPatterns,"Genus"),
    method="mean",
    top=100L,
    assay.type="counts")

## ----plot1, fig.cap="Tree plot using ggtree with tip labels decorated by mean abundance (colour) and prevalence (size)"----
plotRowTree(
    altExp(GlobalPatterns,"Genus")[top_taxa,], tip.colour.by = "log_mean",
    tip.size.by = "detected")

## ----plot2, fig.cap="Tree plot using ggtree with tip labels decorated by mean abundance (colour) and prevalence (size). Tip labels of the tree are shown as well."----
plotRowTree(
    altExp(GlobalPatterns,"Genus")[top_taxa,],
    tip.colour.by = "log_mean", tip.size.by = "detected", show.label = TRUE)

## ----plot3, fig.cap="Tree plot using ggtree with tip labels decorated by mean abundance (colour) and prevalence (size). Selected node and tip labels are shown."----
labels <- c("Genus:Providencia", "Genus:Morganella", "0.961.60")
plotRowTree(
    altExp(GlobalPatterns,"Genus")[top_taxa,],
    tip.colour.by = "log_mean",
    tip.size.by = "detected",
    show.label = labels,
    layout="rectangular")

## ----plot4, fig.cap="Tree plot using ggtree with tip labels decorated by mean abundance (colour) and edges labeled Kingdom (colour) and prevalence (size)"----
plotRowTree(
    altExp(GlobalPatterns,"Genus")[top_taxa,],
    edge.colour.by = "Phylum",
    tip.colour.by = "log_mean")

## ----colgraph-----------------------------------------------------------------
data(col_graph)

## ----plotcolgraph-------------------------------------------------------------
plotColGraph(
    col_graph,
    altExp(GlobalPatterns,"Genus"),
    colour.by = "SampleType",
    edge.colour.by = "weight",
    edge.width.by = "weight",
    show.label = TRUE)

## ----plotcolgraph2------------------------------------------------------------
metadata(altExp(GlobalPatterns,"Genus"))$graph <- col_graph

## ----plotcolgraph3, include=FALSE---------------------------------------------
plotColGraph(
    altExp(GlobalPatterns,"Genus"),
    name = "graph",
    colour.by = "SampleType",
    edge.colour.by = "weight",
    edge.width.by = "weight",
    show.label = TRUE)

## ----plotseries, eval=FALSE---------------------------------------------------
# # Load data from miaTime package
# library("miaTime")
# data(SilvermanAGutData, package="miaTime")
# tse <- SilvermanAGutData
# tse <- transformAssay(tse, method = "relabundance")
# taxa <- getTop(tse, 2)

## ----plotseries2, eval=FALSE--------------------------------------------------
# plotSeries(
#     tse,
#     assay.type = "relabundance",
#     time.col = "DAY_ORDER",
#     features = taxa,
#     colour.by = "Family",
#     facet.by = "Vessel"
#     )

## ----plotseries3, eval=FALSE--------------------------------------------------
# plotSeries(
#     tse[taxa,],
#     time.col = "DAY_ORDER",
#     colour.by = "Family",
#     linetype.by = "Phylum",
#     assay.type = "relabundance")

## ----plotseries4, eval=FALSE--------------------------------------------------
# plotSeries(
#     tse,
#     time.col = "DAY_ORDER",
#     features = getTop(tse, 5),
#     colour.by = "Family",
#     linetype.by = "Phylum",
#     assay.type = "counts")

## ----plotcoltile--------------------------------------------------------------
data(GlobalPatterns, package="mia")
se <- GlobalPatterns
plotColTile(se,"SampleType","Primer") +
    theme(axis.text.x.top = element_text(angle = 45, hjust = 0))

## ----plotdmn------------------------------------------------------------------
data(dmn_se, package = "mia")
names(metadata(dmn_se))
# plot the fit
plotDMNFit(dmn_se, type = "laplace")

## ----MDS, eval=FALSE----------------------------------------------------------
# library(miaTime)
# data(hitchip1006, package = "miaTime")
# tse <- hitchip1006
# tse <- transformAssay(tse, method = "relabundance")
# ## Ordination with PCoA with Bray-Curtis dissimilarity
# tse <- runMDS(
#     tse, FUN = getDissimilarity, method = "bray", name = "PCoA_BC",
#     assay.type = "relabundance", na.rm = TRUE)
# # plot
# p <- plotReducedDim(tse, dimred = "PCoA_BC")
# p

## ----timepoint_table, eval=FALSE----------------------------------------------
# library(dplyr)
# 
# # List subjects with two time points
# selected.subjects <- names(which(table(tse$subject)==2))
# 
# # Subjects counts per number of time points available in the data
# table(table(tse$subject)) %>% as.data.frame() %>%
#     rename(Timepoints=Var1, Subjects=Freq)

## ----mds_timepoint, eval=FALSE------------------------------------------------
# # plot
# p + geom_path(
#     aes(x=X1, y=X2, group=subject),
#     arrow=arrow(length = unit(0.1, "inches")),
#     # combining ordination data and metadata then selecting the subjects
#     # Note, scuttle::makePerCellDF could also be used for the purpose.
#     data = subset(
#         data.frame(reducedDim(tse), colData(tse)),
#         subject %in% selected.subjects) %>% arrange(time)) +
#     labs(title = "All trajectories with two time points") +
#     theme(plot.title = element_text(hjust = 0.5))

## ----stepwise_divergence, eval=FALSE------------------------------------------
# library(miaTime)
# # calculating step wise divergence based on the microbial profiles
# tse <- getStepwiseDivergence(tse, group = "subject", time_field = "time")
# # retrieving the top 10% divergent subjects having two time points
# top.selected.subjects <- subset(
#     data.frame(reducedDim(tse), colData(tse)),
#     subject %in% selected.subjects) %>%
#     top_frac(0.1, time_divergence) %>% select(subject) %>% .[[1]]
# # plot
# p + geom_path(
#     aes(x=X1, y=X2, color=time_divergence, group=subject),
#     # the data is sorted in descending order in terms of time
#     # since geom_path will use the first occurring observation
#     # to color the corresponding segment. Without the sorting
#     # geom_path will pick up NA values (corresponding to initial time
#     # points); breaking the example.
#     data = subset(
#         data.frame(reducedDim(tse), colData(tse)),
#         subject %in% top.selected.subjects) %>%
#     arrange(desc(time)),
#     # arrow end is reversed, due to the earlier sorting.
#     arrow=arrow(length = unit(0.1, "inches"), ends = "first")) +
#     labs(title = "Top 10%  divergent trajectories from time point one to two") +
#     scale_color_gradient2(low="white", high="red")+
#     theme(plot.title = element_text(hjust = 0.5))

## ----visualize_divergence, eval=FALSE-----------------------------------------
# # Get subject with the maximum total divergence
# selected.subject <- data.frame(reducedDim(tse), colData(tse)) %>%
#     group_by(subject) %>%
#     summarise(total_divergence = sum(time_divergence, na.rm = TRUE)) %>%
#     filter(total_divergence==max(total_divergence)) %>% select(subject) %>%
#     .[[1]]
# # plot
# p +  geom_path(
#     aes(x=X1, y=X2, group=subject),
#     data = subset(
#         data.frame(reducedDim(tse), colData(tse)),
#         subject %in% selected.subject) %>% arrange(time),
#     arrow=arrow(length = unit(0.1, "inches"))) +
#     labs(title = "Longest trajectory by divergence") +
#     theme(plot.title = element_text(hjust = 0.5))

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

