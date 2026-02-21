# Code example from 'basics' vignette. See references/ for full tutorial.

## ----"setup", include=FALSE---------------------------------------------------
require("knitr")
opts_chunk$set(fig.width=4, fig.height=3)

## ----install-packages, include=FALSE, message=FALSE, warning=FALSE, eval=FALSE----
# # The following chunk will install all the required packages.
# (function() {
#   installed <- installed.packages()[,"Package"]
#   install <- function(list, fn) {
#     pkg <- setdiff(list, installed)
#     if (length(pkg)) fn(pkg, dependencies=TRUE)
#   }
# 
#   r_packages <- c(
#     "devtools", "dplyr", "ggplot2", "Rtsne", "rlang",
#     "reshape", "ape", "phytools", "repr", "KernelKnn",
#     "gridExtra", "parallel", 'foreach', 'phytools', "doParallel",
#     "zeallot", "gtools", "gplots", "roxygen2", "usethis"
#   )
#   install(r_packages, install.packages)
# 
#   if (requireNamespace("BiocManager", quietly = TRUE)) {
#     bioc_packages <- c('Biobase')
#     install(bioc_packages, BiocManager::install)
#   }
# })()

## ----load-package, quietly=TRUE, message=FALSE, warning=FALSE-----------------
library("scMultiSim")

## ----scmultisim-help, echo = TRUE, results = "hide"---------------------------
scmultisim_help("options")

## ----load-dplyr, quietly=TRUE, message=FALSE, warning=FALSE-------------------
library(dplyr)

## ----define-list-modify-------------------------------------------------------
list_modify <- function (curr_list, ...) {
  args <- list(...)
  for (i in names(args)) {
    curr_list[[i]] <- args[[i]]
  }
  curr_list
}

## ----plot-tree, fig.width = 8, fig.height = 4---------------------------------
par(mfrow=c(1,2))
Phyla5(plotting = TRUE)
Phyla3(plotting = TRUE)

# It's not possible to plot Phyla1() because it only contains 1 branch connecting two nodes.
Phyla1()

## ----random-tree--------------------------------------------------------------
# tree with four leaves
ape::read.tree(text = "(A:1,B:1,C:1,D:1);")

## ----load-grn-----------------------------------------------------------------
data(GRN_params_100)
GRN_params <- GRN_params_100
head(GRN_params)

## ----define-options-----------------------------------------------------------
set.seed(42)

options <- list(
  GRN = GRN_params,
  num.cells = 300,
  num.cifs = 20,
  cif.sigma = 1,
  tree = Phyla5(),
  diff.cif.fraction = 0.8,
  do.velocity = TRUE
)

## ----run-simulation-----------------------------------------------------------
results <- sim_true_counts(options)
names(results)

## ----plot-counts, fig.width = 4, fig.height = 3.5, out.width = "60%"----------
plot_tsne(log2(results$counts + 1),
         results$cell_meta$pop,
         legend = 'pop', plot.name = 'True RNA Counts Tsne')
plot_tsne(log2(results$atacseq_data + 1),
         results$cell_meta$pop,
         legend = 'pop', plot.name = 'True ATAC-seq Tsne')

## ----plot-velocity, fig.width = 4, fig.height = 3.5, out.width = "60%"--------
plot_rna_velocity(results, arrow.length = 2)

## ----plot-gene-correlation, fig.width = 8, fig.height = 8---------------------
plot_gene_module_cor_heatmap(results)

## ----technical-noise----------------------------------------------------------
add_expr_noise(
  results,
  # options go here
  alpha_mean = 1e4
)

## ----batch-effects------------------------------------------------------------
divide_batches(
  results,
  nbatch = 2,
  effect = 1
)

## ----add-expr-noise, fig.width = 4, fig.height = 3.5, out.width = "60%"-------
plot_tsne(log2(results$counts_with_batches + 1),
          results$cell_meta$pop,
          legend = 'pop', plot.name = 'RNA Counts Tsne with Batches')

## ----run-shiny, eval=FALSE----------------------------------------------------
# run_shiny()

## ----simulate-discrete, fig.width = 4, fig.height = 3.5, out.width = "60%"----
set.seed(42)

options <- list(
  GRN = GRN_params,
  num.cells = 400,
  num.cifs = 20,
  tree = Phyla5(),
  diff.cif.fraction = 0.8,
  discrete.cif = TRUE
)

results <- sim_true_counts(options)

plot_tsne(log2(results$counts + 1),
         results$cell_meta$pop,
         legend = 'pop', plot.name = 'True RNA Counts Tsne')

## ----adjust-diff-cif-fraction, fig.width = 4, fig.height = 3.5, out.width = "60%"----
set.seed(42)

options <- list(
  GRN = GRN_params,
  num.cells = 300,
  num.cifs = 20,
  tree = Phyla5(),
  diff.cif.fraction = 0.8
)

results <- sim_true_counts(
        options %>% list_modify(diff.cif.fraction = 0.4))
plot_tsne(log2(results$counts + 1),
         results$cell_meta$pop,
         legend = 'pop', plot.name = 'RNA Counts (diff.cif.fraction = 0.2)')

results <- sim_true_counts(
        options %>% list_modify(diff.cif.fraction = 0.9))
plot_tsne(log2(results$counts + 1),
         results$cell_meta$pop,
         legend = 'pop', plot.name = 'RNA Counts (diff.cif.fraction = 0.8)')

## ----adjust-cif-sigma, fig.width = 4, fig.height = 3.5, out.width = "60%"-----
set.seed(42)

options <- list(
  GRN = GRN_params,
  num.cells = 300,
  num.cifs = 20,
  tree = Phyla5(),
  diff.cif.fraction = 0.8,
  cif.sigma = 0.5
)

results <- sim_true_counts(
        options %>% list_modify(cif.sigma = 0.1))
plot_tsne(log2(results$counts + 1),
         results$cell_meta$pop,
         legend = 'pop', plot.name = 'RNA Counts (cif.sigma = 0.1)')

results <- sim_true_counts(
        options %>% list_modify(cif.sigma = 1.0))
plot_tsne(log2(results$counts + 1),
         results$cell_meta$pop,
         legend = 'pop', plot.name = 'RNA Counts (cif.sigma = 1.0)')

## ----adjust-intrinsic-noise, fig.width = 4, fig.height = 3.5, out.width = "60%"----
set.seed(42)

options <- list(
  GRN = GRN_params,
  num.cells = 300,
  num.cifs = 20,
  tree = Phyla5(),
  diff.cif.fraction = 0.8,
  intrinsic.noise = 1
)

results <- sim_true_counts(
        options %>% list_modify(intrinsic.noise = 0.5))
plot_tsne(log2(results$counts + 1),
         results$cell_meta$pop,
         legend = 'pop', plot.name = 'RNA Counts (intrinsic.noise = 0.5)')

results <- sim_true_counts(
        options %>% list_modify(intrinsic.noise = 1))
plot_tsne(log2(results$counts + 1),
         results$cell_meta$pop,
         legend = 'pop', plot.name = 'RNA Counts (intrinsic.noise = 1)')

## ----help-dynamic-grn---------------------------------------------------------
scmultisim_help("dynamic.GRN")

## ----define-options-dynamic-grn-----------------------------------------------
set.seed(42)

options_ <- list(
  GRN = GRN_params,
  num.cells = 300,
  num.cifs = 20,
  tree = Phyla1(),
  diff.cif.fraction = 0.8,
  do.velocity = FALSE,
  dynamic.GRN = list(
    cell.per.step = 3,
    num.changing.edges = 5,
    weight.mean = 0,
    weight.sd = 4
  )
)

results <- sim_true_counts(options_)

## ----show-cell-specific-grn---------------------------------------------------
# GRN for cell 1 (first 10 rows)
results$cell_specific_grn[[1]][1:10,]

## ----check-cell-specific-grn--------------------------------------------------
print(all(results$cell_specific_grn[[1]] == results$cell_specific_grn[[2]]))
print(all(results$cell_specific_grn[[2]] == results$cell_specific_grn[[3]]))
print(all(results$cell_specific_grn[[3]] == results$cell_specific_grn[[4]]))

## ----session-info-------------------------------------------------------------
sessionInfo()

