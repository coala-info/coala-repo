# Code example from 'Analysis-of-MCIA-Decomposition' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----installation-github, eval = FALSE----------------------------------------
# # devel version
# 
# # install.packages("devtools")
# devtools::install_github("Muunraker/nipalsMCIA", ref = "devel",
#                          force = TRUE, build_vignettes = TRUE) # devel version

## ----installation-bioconductor, eval = FALSE----------------------------------
# # release version
# if (!require("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# BiocManager::install("nipalsMCIA")

## ----load-packages, message = FALSE-------------------------------------------
library(ComplexHeatmap)
library(dplyr)
library(fgsea)
library(ggplot2)
library(ggpubr)
library(nipalsMCIA)
library(stringr)

# NIPALS starts with a random vector
set.seed(42)

## ----intro-load-data----------------------------------------------------------
# load the dataset which uses the name data_blocks
data(NCI60)

# examine the contents
data_blocks$miRNA[1:3, 1:3]
data_blocks$mrna[1:3, 1:3]
data_blocks$prot[1:3, 1:3]

## ----convert-to-mae-----------------------------------------------------------
data_blocks_mae <- simple_mae(data_blocks, row_format = "sample")

## ----intro-mcia, warning = FALSE, message = FALSE-----------------------------
set.seed(42)
mcia_results <- nipals_multiblock(data_blocks_mae,
                                  col_preproc_method = "colprofile",
                                  num_PCs = 10, tol = 1e-12, plots = "none")

## ----intro-mcia-results-------------------------------------------------------
slotNames(mcia_results)

## ----part-1-mcia, warning = FALSE, message = FALSE, fig.dim = c(9, 5)---------
set.seed(42)
mcia_results <- nipals_multiblock(data_blocks_mae,
                                  col_preproc_method = "colprofile",
                                  num_PCs = 10, tol = 1e-12)

## ----part-1-visualize-clusters, fig.dim = c(5, 5)-----------------------------
projection_plot(mcia_results, projection = "global", orders = c(1, 2))

## ----part-1-metadata----------------------------------------------------------
# preview of metadata
head(metadata_NCI60)

# loading of mae with metadata
data_blocks_mae <- simple_mae(data_blocks, row_format = "sample",
                              colData = metadata_NCI60)

## ----part-1-mcia-again, warning = FALSE, message = FALSE----------------------
# adding metadata as part of the nipals_multiblock() function
set.seed(42)
mcia_results <- nipals_multiblock(data_blocks_mae,
                                  col_preproc_method = "colprofile",
                                  plots = "none",
                                  num_PCs = 10, tol = 1e-12)

## ----part-1-visualize-clusters-color-col, fig.dim = c(5, 5)-------------------
# meta_colors = c("blue", "grey", "yellow") can use color names
# meta_colors = c("#00204DFF", "#7C7B78FF", "#FFEA46FF") can use hex codes
meta_colors <- get_metadata_colors(mcia_results, color_col = 1,
                                   color_pal_params = list(option = "E"))

projection_plot(mcia_results, projection = "global", orders = c(1, 2),
                color_col = "cancerType", color_pal = meta_colors,
                legend_loc = "bottomleft")

## ----part-1-global-heatmap-colored, fig.dim = c(6, 4)-------------------------
global_scores_heatmap(mcia_results = mcia_results,
                      color_col = "cancerType", color_pal = meta_colors)

## ----part-2-block-heatmap, fig.dim = c(4.5, 3)--------------------------------
block_weights_heatmap(mcia_results)

## ----part-2-loadings, fig.dim = c(6, 4)---------------------------------------
# colors_omics = c("red", "blue", "green")
# colors_omics <- get_colors(mcia_results, color_pal = colors_omics)
colors_omics <- get_colors(mcia_results)

vis_load_plot(mcia_results, axes = c(1, 4), color_pal = colors_omics)

## ----part-2-factor-1, fig.dim = c(8, 3)---------------------------------------
# generate the visualizations
all_pos_1_vis <- vis_load_ord(mcia_results, omic = "all", factor = 1,
                              absolute = FALSE, descending = TRUE)
mrna_pos_1_vis <- vis_load_ord(mcia_results, omic = "mrna", factor = 1,
                               absolute = FALSE, descending = TRUE)

ggpubr::ggarrange(all_pos_1_vis, mrna_pos_1_vis)

## ----part-2-factor-1-orderings------------------------------------------------
# obtain the loadings as plotted above
all_pos_1 <- ord_loadings(mcia_results, omic = "all", factor = 1,
                          absolute = FALSE, descending = TRUE)
mrna_pos_1 <- ord_loadings(mcia_results, omic = "mrna", factor = 1,
                           absolute = FALSE, descending = TRUE)

## ----part-2-factor-1-orderings-1----------------------------------------------
# visualize the tabular data
all_pos_1[1:3, ]

## ----part-2-factor-1-orderings-2----------------------------------------------
mrna_pos_1[1:3, ]

## ----part-2-factor-2, fig.dim = c(8, 3)---------------------------------------
# define the loadings
all_abs_2 <- vis_load_ord(mcia_results, omic = "all", factor = 2,
                          absolute = TRUE, descending = TRUE)

prot_abs_2 <- vis_load_ord(mcia_results, omic = "prot", factor = 2,
                           absolute = TRUE, descending = TRUE)

ggpubr::ggarrange(all_abs_2, prot_abs_2)

## ----part-2-factor-2-orderings------------------------------------------------
# obtain the loadings as plotted above
all_abs_2_vis <- ord_loadings(mcia_results, omic = "all", factor = 2,
                          absolute = TRUE, descending = TRUE)
prot_abs_2_vis <- ord_loadings(mcia_results, omic = "prot", factor = 2,
                          absolute = TRUE, descending = TRUE)

## ----part-2-factor-2-orderings-1----------------------------------------------
# visualize the tabular data
all_abs_2_vis[1:3, ]

## ----part-2-factor-2-orderings-2----------------------------------------------
prot_abs_2_vis[1:3, ]

## ----part-2-factor-4, fig.dim = c(10, 4)--------------------------------------
# visualization
all_4_plot <- vis_load_ord(mcia_results, omic = "all", factor = 4, 
                           absolute = FALSE, descending = TRUE, n_feat = 60)
all_4_plot

## ----part-2-factor-4-orderings, fig.dim = c(10, 4)----------------------------
# visualize the tabular data
all_4 <- ord_loadings(mcia_results, omic = "all", factor = 4,
                      absolute = FALSE, descending = TRUE)

## ----part-2-pathways, echo = TRUE, message = FALSE, warning = FALSE, results = "hide"----
# extract mRNA global loadings
mrna_gfscores <- nmb_get_gl(mcia_results)
mrna_rows <- str_detect(row.names(mrna_gfscores), "_mrna")
mrna_gfscores <- mrna_gfscores[mrna_rows, ]

# rename rows to contain HUGO based gene symbols
row.names(mrna_gfscores) <- str_remove(rownames(mrna_gfscores), "_[0-9]*_.*")

# load pathway data
path.database <- "https://data.broadinstitute.org/gsea-msigdb/msigdb/release/6.2/c2.cp.reactome.v6.2.symbols.gmt"
pathways <- fgsea::gmtPathways(gmt.file = path.database)

# generate the GSEA report
geneset_report <- gsea_report(metagenes = mrna_gfscores, path.database,
                              factors = seq(1, 3), pval.thr = 0.05, nproc = 2)

## ----include = FALSE----------------------------------------------------------
# # Apply scientific notation to min_pval
geneset_report[[1]]$min_pval <- sprintf("%.2e", geneset_report[[1]]$min_pval)

## ----part-2-genesets----------------------------------------------------------
geneset_report[[1]]

## ----part-2-gsea-for-factor-3, echo = TRUE, message = FALSE, warning = FALSE, results = "hide"----
# re-running GSEA
factor3_paths <- fgseaMultilevel(pathways, stats = mrna_gfscores[, 3],
                                 nPermSimple = 10000, minSize = 15,
                                 nproc = 2, maxSize = 500)

## ----include=FALSE------------------------------------------------------------
# Order by adjusted p value
factor3_paths <- factor3_paths[order(factor3_paths$padj), ]

# Apply scientific notation to padj
to_sci <- function(x) return(sprintf("%.2e", x))
factor3_paths$padj <- vapply(factor3_paths$padj, to_sci, character(1))

# Clean up pathway name
clean_pathway_name <- function(x) {
    replaced_value <- str_replace_all(x , "_", " ")
    if (nchar(replaced_value) > 49) {
        substring_value <- substr(replaced_value, 1, 50) 
        return(paste0(substring_value, "..."))
    }
    else {
        return(replaced_value)
    }
}

factor3_paths[, "pathway"] <- apply(X = factor3_paths[, "pathway"],
                                    MARGIN = 1, FUN = clean_pathway_name)

## ----part-2-gsea-for-factor-3-viz---------------------------------------------
head(factor3_paths[, c("pathway", "padj")])

## ----part-2-significant-------------------------------------------------------
# extracting REACTOME_CELL_CYCLE, the most significant gene set
sig_path3 <- factor3_paths[min(factor3_paths$padj) == factor3_paths$padj, ][1, ]
sig_path3$leadingEdge[[1]][1:10]

## ----session-info-------------------------------------------------------------
sessionInfo()

