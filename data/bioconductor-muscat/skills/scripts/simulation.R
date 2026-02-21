# Code example from 'simulation' vignette. See references/ for full tutorial.

## ----load-libs, message = FALSE,  warning = FALSE-----------------------------
library(dplyr)
library(muscat)
library(purrr)
library(scater)
library(reshape2)
library(patchwork)
library(cowplot)
library(SingleCellExperiment)

## ----prepSim------------------------------------------------------------------
# estimate simulation parameters
data(example_sce)
ref <- prepSim(example_sce, verbose = FALSE)
# only samples from `ctrl` group are retained
table(ref$sample_id)
# cell parameters: library sizes
sub <- assay(example_sce[rownames(ref), colnames(ref)])
all.equal(exp(ref$offset), as.numeric(colSums(sub)))
# gene parameters: dispersions & sample-specific means
head(rowData(ref))

## ----simData------------------------------------------------------------------
# simulated 10% EE genes
sim <- simData(ref, 
    nc = 2e3, ng = 1e3, force = TRUE,
    p_dd = diag(6)[1, ], nk = 3, ns = 3)
# number of cells per sample and subpopulation
table(sim$sample_id, sim$cluster_id)

## ----paired-false-------------------------------------------------------------
metadata(sim)$ref_sids

## ----paired-true--------------------------------------------------------------
# simulated paired design
sim <- simData(ref, 
    nk = 3, ns = 3, paired = TRUE,
    nc = 2e3, ng = 1e3, force = TRUE)
# same set of reference samples for both groups
ref_sids <- metadata(sim)$ref_sids
all(ref_sids[, 1] == ref_sids[, 2])

## ----p_dd---------------------------------------------------------------------
# simulate genes from all DD categories
sim <- simData(ref, 
    p_dd = c(0.5, rep(0.1, 5)),
    nc = 2e3, ng = 1e3, force = TRUE)

## ----gi_category--------------------------------------------------------------
gi <- metadata(sim)$gene_info
table(gi$category)

## ----densities, echo = FALSE, fig.wide = TRUE, fig.width = 8, fig.height = 3, fig.cap = "Expression densities for an exemplary set of 3 genes per *differential distribution* category. Each density corresponds to one sample, lines are colored by group ID, and panels are split by gene and subpopulation."----
# simulate genes from all DD categories
sim <- simData(ref, 
    nc = 2e3, nk = 1, ns = 4,
    p_dd = c(0.5, rep(0.1, 5)),
    ng = 1e3, force = TRUE)
# normalize 
sim <- logNormCounts(sim)
# get 'n' genes per category
n <- 3
gi <- metadata(sim)$gene_info %>% 
    mutate(sim_mean = (sim_mean.A+sim_mean.B)/2) %>% 
    filter(is.na(logFC) | abs(logFC) > 2, sim_mean > 1) 
gs <- group_by(gi, category) %>% 
    group_modify(~head(.x, n = n)) %>% 
    mutate(id = paste0(gene, cluster_id))
# construct data.frame for ggplot
df <- data.frame(t(logcounts(sim)), colData(sim)) %>% 
    melt(id.vars = names(colData(sim))) %>% 
    mutate(id = paste0(variable, cluster_id)) %>% 
    mutate(id = factor(id, levels = gs$id)) %>% 
    filter(id %in% gs$id) %>% 
    mutate(cat = gs$category[match(id, gs$id)])
# use category as facet label
labs <- setNames(toupper(df$cat), df$id)
labs <- labs[unique(names(labs))]
# keep labels only for top row
labs_keep <- levels(df$id)[seq(1, length(labs), n)]
labs[setdiff(names(labs), labs_keep)] <- ""
labs <- as_labeller(labs)
# plot expression densities
ggplot(df, aes(x = value, col = group_id)) +
    facet_wrap("id", scales = "free",
        dir = "v", ncol = 6, labeller = labs) +
    geom_density() + xlab("expression") + 
    theme_minimal() + theme(
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.spacing = unit(0, "mm"),
        panel.grid = element_blank())

## ----rel-lfc, echo = FALSE, warning = FALSE, fig.wide = TRUE, fig.cap = "t-SNEs of exemplary simulations demonstrating `rel_lfc`'s effect to induce cluster-specific state changes. Cells are colored by cluster ID (top-row) and group ID (bottom-row), respectively. From left to right: No cluster-specific changes, stronger change for `cluster3`, different logFC factors for all clusters with no change for `cluster1`."----
rel_lfc <- list(
    c(1, 1, 1), # same FC factor for all clusters
    c(1, 1, 2), # stronger change for cluster3 only
    c(0, 1, 2)) # cluster-specific logFC factors; no change for cluster1
sim <- lapply(rel_lfc, function(u)
    simData(ref, rel_lfc = u,
        nc = (nc <- 1e3), nk = 3,
        p_dd = c(0.95, 0, 0.05, 0, 0, 0),
        ng = 1e3, force = TRUE))
# normalize & run dimension reduction
sim <- lapply(sim, logNormCounts)
sim <- lapply(sim, runTSNE)
# arrange plots
ps <- lapply(c("cluster_id", "group_id"), 
    function(id) lapply(sim, function(u) {
        p <- plotTSNE(u, colour_by = id)
        p$layers[[1]]$aes_params$stroke <- 0
        p + guides(fill = guide_legend(
            override.aes = list(alpha = 1, size = 3)))
    }))
ps <- Reduce("c", ps)
lgd <- lapply(ps[c(1, 4)], get_legend)
ps <- lapply(ps, "+", theme(legend.position = "none"))
plot_grid(nrow = 1, rel_widths = c(8, 1),
    plot_grid(plotlist = ps, ncol = 3, align = "hv"),
    plot_grid(plotlist = lgd, ncol = 1))

## ----p-type, echo = FALSE, fig.wide = TRUE, fig.cap = "t-SNEs of exemplary simulations demonstrating `p_type`'s effect to introduce *type* features. Cells are colored by cluster ID (top-row) and group ID (bottom-row), respectively. The percentage of type features increases from left to right (1, 5, 10%). Simulations are pure EE, i.e., all genes are non-differential across groups."----
sim <- lapply(c(0.01, 0.05, 0.1), function(u)
    simData(ref, p_type = u, 
        nc = 1e3, nk = 3, 
        ng = 1e3, force = TRUE))
# normalize & run dimension reduction
sim <- lapply(sim, logNormCounts)
sim <- lapply(sim, runTSNE)
# arrange plots
# arrange plots
ps <- lapply(c("cluster_id", "group_id"), 
    function(id) lapply(sim, function(u) {
        p <- plotTSNE(u, colour_by = id)
        p$layers[[1]]$aes_params$stroke <- 0
        p + guides(fill = guide_legend(
            override.aes = list(alpha = 1, size = 3)))
    }))
ps <- Reduce("c", ps)
lgd <- lapply(ps[c(1, 4)], get_legend)
ps <- lapply(ps, "+", theme(legend.position = "none"))
plot_grid(nrow = 1, rel_widths = c(5, 1),
    plot_grid(plotlist = ps, ncol = 3, align = "hv"),
    plot_grid(plotlist = lgd, ncol = 1))

## ----simData-type-------------------------------------------------------------
# simulate 5% of type genes; one group only
sim <- simData(ref, p_type = 0.1, 
    nc = 2e3, ng = 1e3, force = TRUE,
    probs = list(NULL, NULL, c(1, 0)))
# do log-library size normalization
sim <- logNormCounts(sim)

## ----heatmap-type, fig.width = 12, fig.height = 8, fig.cap = "Exemplary heatmap demonstrating the effect of `p_type` to introduce cluster-specific *type* genes. Included are type genes (= rows) with a simulated expression mean > 1, and a random subset of 100 cells (= columns) per cluster; column annotations represent cluster IDs. Bins are colored by expression scaled in row direction, and both genes and cells are hierarchically clustered."----
# extract gene metadata & number of clusters
rd <- rowData(sim)
nk <- nlevels(sim$cluster_id)
# filter for type genes with high expression mean
is_type <- rd$class == "type"
is_high <- rowMeans(assay(sim, "logcounts")) > 1
gs <- rownames(sim)[is_type & is_high]
# sample 100 cells per cluster for plotting
cs <- lapply(split(seq_len(ncol(sim)), sim$cluster_id), sample, 100)
plotHeatmap(sim[, unlist(cs)], features = gs, center = TRUE,
    colour_columns_by = "cluster_id", cutree_cols = nk)

## ----phylo-tree, fig.small = TRUE, fig.height = 4, fig.cap = "Exemplary phylogeny. The phylogenetic tree specified via `phylo` relates 3 clusters such that there are 2 main branches, and clusters 1 and 2 should be more similar to one another than cluster 3."----
# specify cluster phylogeny 
tree <- "(('cluster1':0.4,'cluster2':0.4):0.4,('cluster3':
    0.5,('cluster4':0.2,'cluster5':0.2,'cluster6':0.2):0.4):0.4);"
# visualize cluster tree
library(phylogram)
plot(read.dendrogram(text = tree))

## ----simData-phylo------------------------------------------------------------
# simulate 5% of type genes; one group only
sim <- simData(ref, 
    phylo_tree = tree, phylo_pars = c(0.1, 1),
    nc = 800, ng = 1e3, dd = FALSE, force = TRUE)
# do log-library size normalization
sim <- logNormCounts(sim)

## ----heatmap-phylo, fig.width = 12, fig.height = 8, fig.cap = "Exemplary heatmap demonstrating the effect of `phylo_tree` to introduce a hierarchical cluster structure. Included are 100 randomly sampled non-state, i.e. type or shared, genes (= rows) with a simulated expression mean > 1, and a random subset of 100 cells (= columns) per cluster; column annotations represent cluster IDs. Bins are colored by expression scaled in row direction, and both genes and cells are hierarchically clustered."----
# extract gene metadata & number of clusters
rd <- rowData(sim)
nk <- nlevels(sim$cluster_id)
# filter for type & shared genes with high expression mean
is_type <- rd$class != "state"
is_high <- rowMeans(assay(sim, "logcounts")) > 1
gs <- rownames(sim)[is_type & is_high]
# sample 100 cells per cluster for plotting
cs <- lapply(split(seq_len(ncol(sim)), sim$cluster_id), sample, 50)
plotHeatmap(sim[, unlist(cs)], features = gs, 
    center = TRUE, show_rownames = FALSE,
    colour_columns_by = "cluster_id")

## ----countsimQC, eval = FALSE-------------------------------------------------
# # load required packages
# library(countsimQC)
# library(DESeq2)
# # simulate data
# sim <- simData(ref,
#     ng = nrow(ref),
#     nc = ncol(ref),
#     dd = FALSE)
# # construct 'DESeqDataSet's for both,
# # simulated and reference dataset
# dds_sim <- DESeqDataSetFromMatrix(
#     countData = counts(sim),
#     colData = colData(sim),
#     design = ~ sample_id)
# dds_ref <- DESeqDataSetFromMatrix(
#     countData = counts(ref),
#     colData = colData(ref),
#     design = ~ sample_id)
# dds_list <- list(sim = dds_sim, data = dds_ref)
# # generate 'countsimQC' report
# countsimQCReport(
#     ddsList = dds_list,
#     outputFile = "<file_name>.html",
#     outputDir = "<output_path>",
#     outputFormat = "html_document",
#     maxNForCorr = 200,
#     maxNForDisp = 500)

## ----iCOBRA-run-method-wrapper------------------------------------------------
# 'm' is a character string specifying a valid `pbDS` method
.run_method <- function(m) {
    res <- pbDS(pb, method = m, verbose = FALSE)
    tbl <- resDS(sim, res)
    left_join(gi, tbl, by = c("gene", "cluster_id"))
}

## ----iCOBRA-calc-perf-wrapper-------------------------------------------------
# 'x' is a list of result 'data.frame's
.calc_perf <- function(x, facet = NULL) {
    cd <- COBRAData(truth = gi,
        pval = data.frame(bind_cols(map(x, "p_val"))),
        padj = data.frame(bind_cols(map(x, "p_adj.loc"))))
    perf <- calculate_performance(cd, 
        binary_truth = "is_de", maxsplit = 1e6,
        splv = ifelse(is.null(facet), "none", facet),
        aspects = c("fdrtpr", "fdrtprcurve", "curve"))
}

## ----iCOBRA-comparison, warning = FALSE, message = FALSE, fig.height = 4, fig.width = 9----
# simulation with all DD types
sim <- simData(ref, 
    p_dd = c(rep(0.3, 2), rep(0.1, 4)),
    ng = 1e3, nc = 2e3, ns = 3, force = TRUE)
# aggregate to pseudobulks
pb <- aggregateData(sim)
# extract gene metadata
gi <- metadata(sim)$gene_info
# add truth column (must be numeric!)
gi$is_de <- !gi$category %in% c("ee", "ep")
gi$is_de <- as.numeric(gi$is_de) 

# specify methods for comparison & run them
# (must set names for methods to show in visualizations!)
names(mids) <- mids <- c("edgeR", "DESeq2", "limma-trend", "limma-voom")
res <- lapply(mids, .run_method)

# calculate performance measures 
# and prep. for plotting with 'iCOBRA'
library(iCOBRA)
perf <- .calc_perf(res, "cluster_id")
pd <- prepare_data_for_plot(perf)

# plot FDR-TPR curves by cluster
plot_fdrtprcurve(pd, 
    linewidth = 0.8, pointsize = 2) +
    facet_wrap(~ splitval, nrow = 1) +
    scale_x_continuous(trans = "sqrt") +
    theme(aspect.ratio = 1) 

## ----session-info-------------------------------------------------------------
sessionInfo()

