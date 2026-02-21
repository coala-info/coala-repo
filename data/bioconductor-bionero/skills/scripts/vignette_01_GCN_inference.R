# Code example from 'vignette_01_GCN_inference' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  message = TRUE,
  warning = FALSE,
  cache = FALSE,
  fig.align = 'center',
  fig.width = 5,
  fig.height = 4,
  crop = NULL
)

## ----installation, eval=FALSE-------------------------------------------------
# if(!requireNamespace('BiocManager', quietly = TRUE))
#   install.packages('BiocManager')
# 
# BiocManager::install("BioNERO")

## ----load_package-------------------------------------------------------------
# Load package after installation
library(BioNERO)
set.seed(123) # for reproducibility

## ----data_loading_soybean, message=FALSE--------------------------------------
data(zma.se)

# Take a quick look at the data
zma.se
SummarizedExperiment::colData(zma.se)

## ----remove_na----------------------------------------------------------------
exp_filt <- replace_na(zma.se)
sum(is.na(zma.se))

## ----remove_nonexp------------------------------------------------------------
exp_filt <- remove_nonexp(exp_filt, method = "median", min_exp = 10)
dim(exp_filt)

## ----filter_by_variance-------------------------------------------------------
exp_filt <- filter_by_variance(exp_filt, n = 2000)
dim(exp_filt)

## ----ZKfiltering--------------------------------------------------------------
exp_filt <- ZKfiltering(exp_filt, cor_method = "pearson")
dim(exp_filt)

## ----PC_correction------------------------------------------------------------
exp_filt <- PC_correction(exp_filt)

## ----exp_preprocess-----------------------------------------------------------
final_exp <- exp_preprocess(
    zma.se, min_exp = 10, variance_filter = TRUE, n = 2000
)
identical(dim(exp_filt), dim(final_exp))

# Take a look at the final data
final_exp

## ----include=FALSE------------------------------------------------------------
# This object is no longer necessary
rm(exp_filt)

## ----plot_heatmap, fig.width=6, fig.height=4, message=FALSE-------------------
# Heatmap of sample correlations
p <- plot_heatmap(final_exp, type = "samplecor", show_rownames = FALSE)
p

# Heatmap of gene expression (here, only the first 50 genes)
p <- plot_heatmap(
    final_exp[1:50, ], type = "expr", show_rownames = FALSE, show_colnames = FALSE
)
p

## ----pcaplot, fig.small=TRUE--------------------------------------------------
plot_PCA(final_exp)

## ----sft_fit------------------------------------------------------------------
sft <- SFT_fit(final_exp, net_type = "signed hybrid", cor_method = "pearson")
sft$power
power <- sft$power

## ----plot_sft, fig.width=8----------------------------------------------------
sft$plot

## ----exp2net------------------------------------------------------------------
net <- exp2gcn(
    final_exp, net_type = "signed hybrid", SFTpower = power, 
    cor_method = "pearson"
)
names(net)

## ----dendro-------------------------------------------------------------------
# Dendro and colors
plot_dendro_and_colors(net)

## ----eigengene_net, fig.height=4, fig.width=6---------------------------------
# Eigengene networks
plot_eigengene_network(net)

## ----genes_per_module, fig.wide=TRUE------------------------------------------
plot_ngenes_per_module(net)

## ----module_stability---------------------------------------------------------
module_stability(final_exp, net, nRuns = 5)

## ----moddtraitcor-------------------------------------------------------------
MEtrait <- module_trait_cor(exp = final_exp, MEs = net$MEs)
head(MEtrait)

## ----plot-module-trait-cor, fig.width = 5, fig.height = 5---------------------
plot_module_trait_cor(MEtrait)

## ----exp_profile, fig.width=5, fig.height=3-----------------------------------
plot_expression_profile(
    exp = final_exp, 
    net = net, 
    plot_module = TRUE, 
    modulename = "yellow"
)

## ----module_enrichment--------------------------------------------------------
# Enrichment analysis for conserved protein domains (Interpro)
data(zma.interpro)
interpro_enrichment <- module_enrichment(
    net = net, 
    background_genes = rownames(final_exp),
    annotation = zma.interpro
)

# Print results without geneIDs for better visualization
interpro_enrichment[, -6]

## -----------------------------------------------------------------------------
hubs <- get_hubs_gcn(final_exp, net)
head(hubs)

## -----------------------------------------------------------------------------
edges <- get_edge_list(net, module="midnightblue")
head(edges)

## ----filter_edges, fig.small=TRUE---------------------------------------------
# Remove edges based on optimal scale-free topology fit
edges_filtered <- get_edge_list(net, module = "midnightblue", filter = TRUE)
dim(edges_filtered)

# Remove edges based on p-value
edges_filtered <- get_edge_list(
    net, module = "midnightblue",
    filter = TRUE, method = "pvalue", 
    nSamples = ncol(final_exp)
)
dim(edges_filtered)

# Remove edges based on minimum correlation
edges_filtered <- get_edge_list(
    net, module = "midnightblue", 
    filter = TRUE, method = "min_cor", rcutoff = 0.7
)
dim(edges_filtered)

## ----plot_gcn, fig.width=5, fig.height=5--------------------------------------
plot_gcn(
    edgelist_gcn = edges_filtered, 
    net = net, 
    color_by = "module", 
    hubs = hubs
)

## ----interactive_gcn----------------------------------------------------------
plot_gcn(
    edgelist_gcn = edges_filtered, 
    net = net,
    color_by = "module",
    hubs = hubs,
    interactive = TRUE,
    dim_interactive = c(500, 500)
)

## -----------------------------------------------------------------------------
sessionInfo()

