# Code example from 'treeclimbR' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>", 
    eval = TRUE,
    crop = NULL
)

## ----install-pkg--------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("treeclimbR")

## ----setup--------------------------------------------------------------------
suppressPackageStartupMessages({
    library(TreeSummarizedExperiment)
    library(treeclimbR)
    library(ggtree)
    library(dplyr)
    library(ggplot2)
})

## ----da-load-and-visualize-data-----------------------------------------------
## Read data
da_lse <- readRDS(system.file("extdata", "da_sim_100_30_18de.rds", 
                              package = "treeclimbR"))
da_lse

## Generate tree visualization where true signal leaves are colored orange
## ...Find internal nodes in the subtrees where all leaves are differentially 
##    abundant. These will be colored orange.
nds <- joinNode(tree = rowTree(da_lse), 
                node = rownames(da_lse)[rowData(da_lse)$Signal])
br <- unlist(findDescendant(tree = rowTree(da_lse), node = nds,
                            only.leaf = FALSE, self.include = TRUE))
df_color <- data.frame(node = showNode(tree = rowTree(da_lse), 
                                       only.leaf = FALSE)) |>
    mutate(signal = ifelse(node %in% br, "yes", "no"))
## ...Generate tree
da_fig_tree <- ggtree(tr = rowTree(da_lse), layout = "rectangular", 
                      branch.length = "none", 
                      aes(color = signal)) %<+% df_color +
    scale_color_manual(values = c(no = "grey", yes = "orange"))
## ...Zoom into the subtree defined by a particular node. In this case, we 
##    know that all true signal leaves were sampled from the subtree defined 
##    by a particular node (stored in metadata(da_lse)$parentNodeForSignal).
da_fig_tree <- scaleClade(da_fig_tree, 
                          node = metadata(da_lse)$parentNodeForSignal, 
                          scale = 4)

## Extract count matrix and scale each row to [0, 1]
count <- assay(da_lse, "counts")
scale_count <- t(apply(count, 1, FUN = function(x) {
    xx <- x
    rx <- (max(xx) - min(xx))
    (xx - min(xx))/max(rx, 1)
}))
rownames(scale_count) <- rownames(count)
colnames(scale_count) <- colnames(count)

## Plot tree and heatmap of scaled counts
## ...Generate sample annotation
vv <- gsub(pattern = "_.*", "", colnames(count))
names(vv) <- colnames(scale_count)
anno_c <- structure(vv, names = vv)
TreeHeatmap(tree = rowTree(da_lse), tree_fig = da_fig_tree, 
            hm_data = scale_count, legend_title_hm = "Scaled\ncount",
            column_split = vv, rel_width = 0.6,
            tree_hm_gap = 0.3,
            column_split_label = anno_c) +
    scale_fill_viridis_c(option = "B") +
    scale_y_continuous(expand = c(0, 10))

## ----da-aggregate-------------------------------------------------------------
## Get a list of all node IDs
all_node <- showNode(tree = rowTree(da_lse), only.leaf = FALSE)

## Calculate counts for internal nodes
da_tse <- aggTSE(x = da_lse, rowLevel = all_node, rowFun = sum)
da_tse

## ----da-run-edger-------------------------------------------------------------
## Run differential analysis
da_res <- runDA(da_tse, assay = "counts", option = "glmQL", 
                design = model.matrix(~ group, data = colData(da_tse)), 
                contrast = c(0, 1), filter_min_count = 0, 
                filter_min_prop = 0, filter_min_total_count = 15)

## ----da-runda-res-------------------------------------------------------------
names(da_res)
class(da_res$edgeR_results)

## Nodes with too low total count
da_res$nodes_drop

## ----da-node-results----------------------------------------------------------
da_tbl <- nodeResult(da_res, n = Inf, type = "DA")
dim(da_tbl)
head(da_tbl)

## ----da-get-cand--------------------------------------------------------------
## Get candidates
da_cand <- getCand(tree = rowTree(da_tse), score_data = da_tbl, 
                   node_column = "node", p_column = "PValue",
                   threshold = 0.05, sign_column = "logFC", message = FALSE)

## ----da-plot-cand-------------------------------------------------------------
## All candidates
names(da_cand$candidate_list)

## Nodes contained in the candidate corresponding to t = 0.03
## This is a mix of leaves and internal nodes
(da_cand_0.03 <- da_cand$candidate_list[["0.03"]])

## Visualize candidate
da_fig_tree +
    geom_point2(aes(subset = (node %in% da_cand_0.03)), 
                color = "navy", size = 0.5) +
    labs(title = "t = 0.03") +
    theme(legend.position = "none",
          plot.title = element_text(color = "navy", size = 7, 
                                    hjust = 0.5, vjust = -0.08))

## ----da-eval-cand-------------------------------------------------------------
## Evaluate candidates
da_best <- evalCand(tree = rowTree(da_tse), levels = da_cand$candidate_list, 
                    score_data = da_tbl, node_column = "node",
                    p_column = "PValue", sign_column = "logFC")

## ----da-info-cand-------------------------------------------------------------
infoCand(object = da_best)

## ----da-topnodes--------------------------------------------------------------
da_out <- topNodes(object = da_best, n = Inf, p_value = 0.05)

## ----da-plot-significant------------------------------------------------------
da_fig_tree +
    geom_point2(aes(subset = node %in% da_out$node),
                color = "red")

## ----da-fdr-tpr---------------------------------------------------------------
fdr(rowTree(da_tse), truth = rownames(da_lse)[rowData(da_lse)$Signal], 
    found = da_out$node, only.leaf = TRUE)

tpr(rowTree(da_tse), truth = rownames(da_lse)[rowData(da_lse)$Signal], 
    found = da_out$node, only.leaf = TRUE)

## ----ds-load-and-visualize-data-----------------------------------------------
ds_tse <- readRDS(system.file("extdata", "ds_sim_20_500_8de.rds", 
                              package = "treeclimbR"))
ds_tse

## Assignment of cells to high-resolution clusters, samples and conditions
head(colData(ds_tse))

## Tree providing the successive aggregation of the high-resolution clusters
## into more coarse-grained ones
## Node numbers are indicated in blue, node labels in orange
ggtree(colTree(ds_tse)) +
    geom_text2(aes(label = node), color = "darkblue",
               hjust = -0.5, vjust = 0.7) +
    geom_text2(aes(label = label), color = "darkorange",
               hjust = -0.1, vjust = -0.7)

## ----ds-list-truth------------------------------------------------------------
rowData(ds_tse)[rowData(ds_tse)$Signal != "no", , drop = FALSE] 

## ----ds-aggregate-------------------------------------------------------------
ds_se <- aggDS(TSE = ds_tse, assay = "counts", sample_id = "sample_id", 
               group_id = "group", cluster_id = "cluster_id", FUN = sum)
ds_se

## ----ds-ncells----------------------------------------------------------------
metadata(ds_se)$n_cells

## ----ds-run-edger-------------------------------------------------------------
ds_res <- runDS(SE = ds_se, tree = colTree(ds_tse), option = "glmQL", 
                design = model.matrix(~ group, data = colData(ds_se)), 
                contrast = c(0, 1), filter_min_count = 0, 
                filter_min_total_count = 1, filter_min_prop = 0, min_cells = 5, 
                group_column = "group", message = FALSE)

## ----ds-runds-res-------------------------------------------------------------
names(ds_res)
names(ds_res$edgeR_results)

## ----ds-node-results----------------------------------------------------------
ds_tbl <- nodeResult(ds_res, type = "DS", n = Inf)
dim(ds_tbl)
head(ds_tbl)

## ----ds-get-cand--------------------------------------------------------------
## Split result table by feature
ds_tbl_list <- split(ds_tbl, f = ds_tbl$feature)

## Find candidates for each gene separately
ds_cand_list <- lapply(seq_along(ds_tbl_list), 
                       FUN = function(x) {
                           getCand(
                               tree = colTree(ds_tse),
                               t = seq(from = 0.05, to = 1, by = 0.05),
                               score_data = ds_tbl_list[[x]], 
                               node_column = "node", 
                               p_column = "PValue", 
                               sign_column = "logFC",
                               message = FALSE)$candidate_list
                       })
names(ds_cand_list) <- names(ds_tbl_list)

## ----ds-eval-cand-------------------------------------------------------------
ds_best <- evalCand(tree = colTree(ds_tse), type = "multiple", 
                    levels = ds_cand_list, score_data = ds_tbl_list, 
                    node_column = "node", 
                    p_column = "PValue", 
                    sign_column = "logFC", 
                    feature_column = "feature",
                    limit_rej = 0.05,
                    message = FALSE,
                    use_pseudo_leaf = FALSE)

ds_out <- topNodes(object = ds_best, n = Inf, p_value = 0.05) 
ds_out

## ----ds-check-cand------------------------------------------------------------
lapply(findDescendant(colTree(ds_tse), node = c(11, 13, 5, 9), 
                      self.include = TRUE, 
                      use.alias = FALSE, only.leaf = TRUE), 
       function(x) convertNode(colTree(ds_tse), node = x))

## ----ds-list-truth-again------------------------------------------------------
rowData(ds_tse)[rowData(ds_tse)$Signal != "no", , drop = FALSE] 

## ----session-info-------------------------------------------------------------
sessionInfo()

