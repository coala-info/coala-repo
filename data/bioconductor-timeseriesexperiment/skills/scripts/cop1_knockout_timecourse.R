# Code example from 'cop1_knockout_timecourse' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, message=FALSE, warning=FALSE, results="asis"----------------------------------------------------------------------------------------------------------------------------------
rm(list = ls())
library("rmarkdown")
options(width = 200)

## ----message=FALSE, warning=FALSE---------------------------------------------------------------------------------------------------------------------------------------------------------------------
.packages <- c(
  "edgeR", "viridis", "Biobase", "SummarizedExperiment", 
  "ggplot2", "dplyr", "tidyr", "tibble", "readr", 
  "TimeSeriesExperiment")
sapply(.packages, require, character.only = TRUE)
theme_set(theme_bw())
theme_update(
  text = element_text(size = 15),
  strip.background = element_rect(fill = "grey70"),
  strip.text = element_text(size = 10))

## ---- message=FALSE, warning=FALSE--------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Remote location of the data
urls <- paste0(
    "https://www.ncbi.nlm.nih.gov/geo/download/",
    "?acc=GSE114762&format=file&file=",
    c(
        "GSE114762_raw_counts.csv.gz",
        "GSE114762_gene_data.csv.gz",
        "GSE114762_sample_info.csv.gz"
    )
)

## ---- message=FALSE, warning=FALSE--------------------------------------------------------------------------------------------------------------------------------------------------------------------
library(BiocFileCache)
bfc <- BiocFileCache(ask = FALSE)

cnts <- read_csv(bfcrpath(rnames = urls[1])) %>%
  column_to_rownames("X1") %>%
  as.matrix()

gene.data <- read_csv(bfcrpath(rnames = urls[2])) %>%
  as.data.frame() %>%
  column_to_rownames("X1")

pheno.data <- read_csv(bfcrpath(rnames = urls[3])) %>%
  as.data.frame() %>%
  column_to_rownames("X1")

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
cop1.te <- TimeSeriesExperiment(
  assays = list(cnts),
  rowData = gene.data,
  colData = pheno.data,
  timepoint = "time",
  replicate = "replicate",
  group = "group"
)
cop1.te

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
cop1.es <- ExpressionSet(
  as.matrix(cnts),
  phenoData = AnnotatedDataFrame(pheno.data),
  featureData = AnnotatedDataFrame(gene.data))

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
(cop1.te <- makeTimeSeriesExperimentFromExpressionSet(
  cop1.es, timepoint = "time", group = "group",
  replicate = "individual"))

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
cop1.se <- SummarizedExperiment(
  assays = list(counts = cnts),
  rowData = gene.data, colData = pheno.data)

(cop1.te <- makeTimeSeriesExperimentFromSummarizedExperiment(
  cop1.se, time = "time", group = "group",
  replicate = "individual"))

# Remove raw data
rm(cnts, gene.data, pheno.data, cop1.se, cop1.es)

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Compute CPMs 
cop1.te <- normalizeData(cop1.te)

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Fine genes with minimum mean count of 5 at least in one of the two groups
min_mean_cpm <- 5
group_cpm_means <- data.frame(row.names = rownames(cop1.te))
norm.cnts <- assays(cop1.te)$norm
for(g in unique(groups(cop1.te))) {
  g_cnts <- norm.cnts[ , which(groups(cop1.te) == g)]
  group_cpm_means[, g] <- apply(g_cnts, 1, mean)
}
group_cpm_max <- apply(as.vector(group_cpm_means), 1, max)
genes_expressed <- rownames(cop1.te)[group_cpm_max > min_mean_cpm]

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Filter out the noisy genes
cop1.te <- filterFeatures(cop1.te, genes_expressed)
cop1.te

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Collapsed sample data stored in cop1.te@sample.data.collapsed,
# and mean expression values in cop1.te@data.collapsed
cop1.te <- collapseReplicates(cop1.te, FUN = mean)

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Before conversion, scales gene expression to an even sum, for a fair
# gene-to-gene comparison.
cop1.te <- makeTimeSeries(
    cop1.te, feature.trans.method = "scale_feat_sum")

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# untransfomed
head(timeSeries(cop1.te, "ts"))

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# transfomed
head(timeSeries(cop1.te, "ts_trans"))

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Add lags to time-course data
cop1.te <- addLags(cop1.te, lambda = c(0.5, 0.25))
head(timeSeries(cop1.te, "ts_trans"))

## ----heatmap, fig.height=9, fig.width=7---------------------------------------------------------------------------------------------------------------------------------------------------------------
plotHeatmap(cop1.te, num.feat = 100)

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
cop1.te <- runPCA(cop1.te, var.stabilize.method = "asinh")

## ----pca-samples-group, fig.wide = TRUE, fig.height=3, fig.width=7------------------------------------------------------------------------------------------------------------------------------------
plotSamplePCA(cop1.te, col.var = "group", size = 5)

## ----pca-samples-time, fig.wide = TRUE, fig.height=3, fig.width=7-------------------------------------------------------------------------------------------------------------------------------------
plotSamplePCA(cop1.te, col.var = "timepoint", size = 5)

## ----pca-genes, fig.width = 10, fig.height = 8--------------------------------------------------------------------------------------------------------------------------------------------------------
plotTimeSeriesPCA(
    cop1.te,
    linecol = c("WT" = "#e31a1c", "Loxp" = "#1f78b4"),
    main = paste("Visualizing gene profiles with PCA"),
    m  = 15, n = 15, col = adjustcolor("grey77", alpha=0.7), 
    cex.main = 3, cex.axis = 2, cex.lab = 2)

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
params_for_clustering <- list(
  dynamic = TRUE, 
  dynamic_cut_params = list(deepSplit = TRUE, minModuleSize = 150))

cop1.te <- clusterTimeSeries(
  cop1.te, n.top.feat = 3000, groups = "all",
  clust.params = params_for_clustering)

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# See the count of genes in each cluster
cluster_map <- clusterMap(cop1.te)
table(cluster_map$cluster)

## ----hclust-dendrogram, fig.width = 7, fig.height = 4-------------------------------------------------------------------------------------------------------------------------------------------------
# Plot the hierarchical clustering of genes2cluster
hclust_obj <- clusterAssignment(cop1.te, "hclust")
plot(x = hclust_obj, labels = FALSE, xlab = "genes", sub = "")

## ----gene-clusters, fig.width = 7, fig.height = 5.5, fig.wide = TRUE----------------------------------------------------------------------------------------------------------------------------------
plotTimeSeriesClusters(cop1.te, transparency = 0.2) +
    scale_color_manual(values = c("WT" = "#1f78b4", "Loxp" = "#e31a1c")) +
    theme(strip.text = element_text(size = 10)) +
    ylim(NA, 0.55)

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
cop1.te <- timepointDE(cop1.te, timepoints = "all", alpha = 0.05)

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
tmp_de <- differentialExpression(cop1.te, "timepoint_de")
# First 6 DE genes at timepoint = 2.5:
head(tmp_de$`2.5`)

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
top10_genes <- sapply(tmp_de, function(tab) {
    top10 <- tab %>% arrange(-logFC) %>% .[["symbol"]] %>% .[1:10]
    if(length(top10) < 10)
      top10 <- c(top10, rep(NA, 10 - length(top10)))
    return(top10)
  }) %>% 
  as.data.frame()
top10_genes

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
de_genes <- lapply(tmp_de, function(x) x$symbol)
de_any_tmp <- unique(unlist(de_genes))
cat("Out of all", nrow(cop1.te), ", there were",
    length(de_any_tmp), "were found differentially expressed at any timepoint.")

## ----tmp-de-intersect, fig.width=7, fig.height=4------------------------------------------------------------------------------------------------------------------------------------------------------
library(UpSetR)
upset(fromList(de_genes),
      sets = rev(c("2.5", "4", "6", "9", "13")), keep.order = TRUE,
      number.angles = 30, #point.size = 3.5, line.size = 1,
      mainbar.y.label = "DE Gene Intersections",
      sets.x.label = "DE Genes Per Timepoint")

## ---- eval = FALSE------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#  cop1.te <- trajectoryDE(cop1.te, dist_method = "euclidean")
#  de_trajectory_res <- differentialExpression(cop1.te, "trajectory_de")
#  saveRDS(de_trajectory_res, "de_trajectory_cop1.rds")

## ----echo = FALSE-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
de_trajectory_res <- readRDS("de_trajectory_cop1.rds")

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
head(de_trajectory_res, 20)

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Select top most different genes across two groups
n_genes <- 20
genes_with_de_trajectory <- de_trajectory_res %>%
    filter(pval <= max(0.05, min(pval)), R2 > 0.7) %>%
    arrange(-R2)
(genes_to_plot <- genes_with_de_trajectory$feature[1:n_genes])

## ----genes-de-trajectory, fig.width = 7, fig.height = 5.5, fig.wide = TRUE----------------------------------------------------------------------------------------------------------------------------
plotTimeSeries(cop1.te, features = genes_to_plot) +
    scale_color_manual(values = c("WT" =  "#1f78b4", "Loxp" = "#e31a1c"))

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
length(genes_with_de_trajectory$feature)

## ----de-gene-clusters, fig.width = 8, fig.height = 6, fig.wide = TRUE---------------------------------------------------------------------------------------------------------------------------------
plotTimeSeriesClusters(
  cop1.te, transparency = 0.5,
  features = genes_with_de_trajectory$feature) +
  scale_color_manual(values = c("WT" = "#1f78b4", "Loxp" = "#e31a1c"))

## ---- eval = FALSE------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#  enrich_res <- pathwayEnrichment(
#    object = cop1.te,
#    features = genes_with_de_trajectory$feature,
#    species = "Mm", ontology ="BP")
#  saveRDS(enrich_res, "enrich_res_cop1.rds")

## ----echo = FALSE-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
enrich_res <- readRDS("enrich_res_cop1.rds")

## ----go-enrich-clst-c4,  fig.width = 8, fig.height = 4, fig.wide = TRUE-------------------------------------------------------------------------------------------------------------------------------
clst <- "C4"
plotEnrichment(
    enrich = enrich_res[[clst]], n_max = 15) +
  ggtitle(paste0("Cluster , ", clst, " enrichment"))

## ----go-enrich-clst-c5,  fig.width = 8, fig.height = 4, fig.wide = TRUE-------------------------------------------------------------------------------------------------------------------------------
clst <- "C5"
plotEnrichment(
    enrich = enrich_res[[clst]], n_max = 15) +
  ggtitle(paste0("Cluster , ", clst, " enrichment"))

## -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
sessionInfo()

