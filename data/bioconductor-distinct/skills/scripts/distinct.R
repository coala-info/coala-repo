# Code example from 'distinct' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(tidy=FALSE, cache=TRUE,
                      dev="png",
                      message=TRUE, error=FALSE, warning=TRUE)

## ----vignettes, eval=FALSE----------------------------------------------------
# browseVignettes("distinct")

## ----citation, eval=FALSE-----------------------------------------------------
# citation("distinct")

## ----Bioconductor_installation, eval=FALSE------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#   install.packages("BiocManager")
# BiocManager::install("distinct")

## ----load-example-data, message = FALSE---------------------------------------
library(SingleCellExperiment)
data("Kang_subset", package = "distinct")
Kang_subset

## ----visualize colData--------------------------------------------------------
colData(Kang_subset)

## ----visualize experimental design--------------------------------------------
Kang_subset@metadata$experiment_info

## ----load_distinct, message=FALSE---------------------------------------------
library(distinct)

## ----create_design------------------------------------------------------------
samples = Kang_subset@metadata$experiment_info$sample_id
group = Kang_subset@metadata$experiment_info$stim
design = model.matrix(~group)
# rownames of the design must indicate sample ids:
rownames(design) = samples
design

## ----check_sample_names-------------------------------------------------------
rownames(design)

unique(colData(Kang_subset)$sample_id)

## ----differential-analyses----------------------------------------------------
set.seed(61217)

res = distinct_test(x = Kang_subset, 
                    name_assays_expression = "logcounts",
                    name_cluster = "cell",
                    name_sample = "sample_id",
                    design = design,
                    column_to_test = 2,
                    min_non_zero_cells = 20,
                    n_cores = 2)

## ----define-batches-----------------------------------------------------------
batch = factor(c("A", "B", "C", "A", "B", "C"))

design = model.matrix(~group + batch)
# rownames of the design must indicate sample ids:
rownames(design) = samples
design

## ----differential-analyses-with-batches---------------------------------------
set.seed(61217)

res_batches = distinct_test(x = Kang_subset, 
                            name_assays_expression = "logcounts",
                            name_cluster = "cell",
                            name_sample = "sample_id",
                            design = design,
                            column_to_test = 2,
                            min_non_zero_cells = 20,
                            n_cores = 2)

## ----compute-log2_FC----------------------------------------------------------
res = log2_FC(res = res,
              x = Kang_subset, 
              name_assays_expression = "cpm",
              name_group = "stim",
              name_cluster = "cell")

## ----visualize-group-levels---------------------------------------------------
levels(colData(Kang_subset)$stim)
head(res[,9:10], 3)

## ----reorder-group-levels-----------------------------------------------------
# set "stim" as 1st level:
colData(Kang_subset)$stim = relevel(colData(Kang_subset)$stim, "stim")
levels(colData(Kang_subset)$stim)

res_2 = log2_FC(res = res,
              x = Kang_subset, 
              name_assays_expression = "cpm",
              name_group = "stim",
              name_cluster = "cell")

head(res_2[,9:10], 3)

## ----visualize-results--------------------------------------------------------
head(top_results(res))

## ----visualize-results-one-cluster--------------------------------------------
top_results(res, cluster = "Dendritic cells")

## ----visualize-results-one-cluster-sort-by-FC---------------------------------
top_results(res, cluster = "Dendritic cells", sort_by = "log2FC")

## ----visualize-results-down---------------------------------------------------
top_results(res, up_down = "down",
            cluster = "Dendritic cells")

## ----plot_densitied-----------------------------------------------------------
plot_densities(x = Kang_subset,
               gene = "ISG15",
               cluster = "Dendritic cells",
               name_assays_expression = "logcounts",
               name_cluster = "cell",
               name_sample = "sample_id",
               name_group = "stim")

## ----plot_densitied_group_level-----------------------------------------------
plot_densities(x = Kang_subset,
               gene = "ISG15",
               cluster = "Dendritic cells",
               name_assays_expression = "logcounts",
               name_cluster = "cell",
               name_sample = "sample_id",
               name_group = "stim",
               group_level = TRUE)

## ----plot_cdfs----------------------------------------------------------------
plot_cdfs(x = Kang_subset,
          gene = "ISG15",
          cluster = "Dendritic cells",
          name_assays_expression = "logcounts",
          name_cluster = "cell",
          name_sample = "sample_id",
          name_group = "stim")

## ----plotExpression-----------------------------------------------------------
# select cluster of cells:
cluster = "Dendritic cells"
sel_cluster = res$cluster_id == cluster
sel_column = Kang_subset$cell == cluster

# select significant genes:
sel_genes = res$p_adj.glb < 0.01
genes = as.character(res$gene[sel_cluster & sel_genes])

# make violin plots:
library(scater)
plotExpression(Kang_subset[,sel_column],
               features = genes, exprs_values = "logcounts",
               log2_values = FALSE,
               x = "sample_id", colour_by = "stim", ncol = 3) +
  guides(fill = guide_legend(override.aes = list(size = 5, alpha = 1))) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## ----UpsetR plot--------------------------------------------------------------
library(UpSetR)
res_by_cluster = split( ifelse(res$p_adj.glb < 0.01, 1, 0), res$cluster_id)
upset(data.frame(do.call(cbind, res_by_cluster)), nsets = 10, nintersects = 20)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

