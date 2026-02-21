# Code example from 'GWENA_guide' vignette. See references/ for full tutorial.

## ----vignette_setup, include = FALSE------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  warning = FALSE,
  comment = "#>",
  cache = TRUE
)

is_windows <- identical(.Platform$OS.type, "windows")

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#   install.packages("BiocManager")
# 
# # 1. From Bioconductor release
# BiocManager::install("GWENA")
# 
# # 2. From Bioconductor devel
# BiocManager::install("GWENA", version = "devel")
# 
# # 3. From Github repository
# BiocManager::install("Kumquatum/GWENA")
# # OR
# if (!requireNamespace("devtools", quietly=TRUE))
#   install.packages("devtools")
# devtools::install_github("Kumquatum/GWENA")
# 

## ----load_windows, message=FALSE, warning=FALSE, eval=is_windows, echo=is_windows----
# library(GWENA)
# library(magrittr) # Not mandatory, but in this tutorial we use the pipe `%>%` to ease readability.
# 
# threads_to_use <- 1

## ----load_other_os, message=FALSE, warning=FALSE, eval=isFALSE(is_windows), echo=isFALSE(is_windows)----
library(GWENA)
library(magrittr) # Not mandatory, we use the pipe `%>%` to ease readability.

threads_to_use <- 2

## ----data_input_expr----------------------------------------------------------
# Import expression table
data("kuehne_expr")
# If kuehne_expr was in a file :
# kuehne_expr = read.table(<path_to_file>, header=TRUE, row.names=1)

# Number of genes
ncol(kuehne_expr)
# Number of samples
nrow(kuehne_expr)

# Overview of expression table
kuehne_expr[1:5,1:5]

# Checking expression data set is correctly defined
is_data_expr(kuehne_expr)

## ----data_input_phenotype-----------------------------------------------------
# Import phenotype table (also called traits)
data("kuehne_traits")
# If kuehne_traits was in a file :
# kuehne_traits = read.table(<path_to_file>, header=TRUE, row.names=1)

# Phenotype
unique(kuehne_traits$Condition)

# Overview of traits table
kuehne_traits[1:5,]

## ----data_input_SummarizedExperiment------------------------------------------
se_kuehne <- SummarizedExperiment::SummarizedExperiment(
  assays = list(expr = t(kuehne_expr)),
  colData = S4Vectors::DataFrame(kuehne_traits)
)

S4Vectors::metadata(se_kuehne) <- list(
  experiment_type = "Expression profiling by array",
  transcriptomic_technology = "Microarray",
  GEO_accession_id = "GSE85358",
  overall_design = paste("Gene expression in epidermal skin samples from the",
                         "inner forearms 24 young (20 to 25 years) and 24 old",
                         "(55 to 66 years) human volunteers were analysed", 
                         "using Agilent Whole Human Genome Oligo Microarrays",
                         "8x60K V2."),
  contributors = c("Kuehne A", "Hildebrand J", "Soehle J", "Wenck H", 
                   "Terstegen L", "Gallinat S", "Knott A", "Winnefeld M", 
                   "Zamboni N"),
  title = paste("An integrative metabolomics and transcriptomics study to",
                "identify metabolic alterations in aged skin of humans in", 
                "vivo"),
  URL = "https://www.ncbi.nlm.nih.gov/pubmed/28201987",
  PMIDs = 28201987
)

## ----filtration---------------------------------------------------------------
kuehne_expr_filtered <- filter_low_var(kuehne_expr, pct = 0.7, type = "median")

# Remaining number of genes
ncol(kuehne_expr_filtered)

## ----net_building-------------------------------------------------------------
# In order to fasten the example execution time, we only take an 
# arbitary sample of the genes. 
kuehne_expr_filtered <- kuehne_expr_filtered[, 1:1000]

net <- build_net(kuehne_expr_filtered, cor_func = "spearman", 
                 n_threads = threads_to_use)

# Power selected :
net$metadata$power

# Fit of the power law to data ($R^2$) :
fit_power_table <- net$metadata$fit_power_table
fit_power_table[fit_power_table$Power == net$metadata$power, "SFT.R.sq"]

## ----modules_detection--------------------------------------------------------
modules <- detect_modules(kuehne_expr_filtered, 
                            net$network, 
                            detailled_result = TRUE,
                            merge_threshold = 0.25)

## ----bipartite_graph_merge----------------------------------------------------
# Number of modules before merging :
length(unique(modules$modules_premerge))
# Number of modules after merging: 
length(unique(modules$modules))

layout_mod_merge <- plot_modules_merge(
  modules_premerge = modules$modules_premerge, 
  modules_merged = modules$modules)

## ----plot_modules_gene_distribution, fig.height=3-----------------------------
ggplot2::ggplot(data.frame(modules$modules %>% stack), 
                ggplot2::aes(x = ind)) + ggplot2::stat_count() +
  ggplot2::ylab("Number of genes") +
  ggplot2::xlab("Module")

## ----plot_module_profile------------------------------------------------------
# plot_expression_profiles(kuehne_expr_filtered, modules$modules)

## ----modules_enrichment, fig.height=12----------------------------------------
enrichment <- bio_enrich(modules$modules)
plot_enrichment(enrichment)

## ----modules_phenotype--------------------------------------------------------
# With data.frame/matrix
phenotype_association <- associate_phenotype(
  modules$modules_eigengenes, 
  kuehne_traits %>% dplyr::select(Condition, Age, Slide))

# With SummarizedExperiment
phenotype_association <- associate_phenotype(
  modules$modules_eigengenes, 
  SummarizedExperiment::colData(se_kuehne) %>% 
    as.data.frame %>% 
    dplyr::select(Condition, Age, Slide))

plot_modules_phenotype(phenotype_association)

## ----graph, fig.width=12, fig.height=12---------------------------------------
module_example <- modules$modules$`2`
graph <- build_graph_from_sq_mat(net$network[module_example, module_example])

layout_mod_2 <- plot_module(graph, upper_weight_th = 0.999995, 
                            vertex.label.cex = 0, 
                            node_scaling_max = 7, 
                            legend_cex = 1)

## ----sub_clusters, fig.width=12, fig.height=12--------------------------------
net_mod_2 <- net$network[modules$modules$`2`, modules$modules$`2`] 
sub_clusters <- get_sub_clusters(net_mod_2)
layout_mod_2_sub_clust <- plot_module(graph, upper_weight_th = 0.999995,
                                      groups = sub_clusters,
                                      vertex.label.cex = 0, 
                                      node_scaling_max = 7, 
                                      legend_cex = 1)

## ----condition_comparison-----------------------------------------------------
# Expression by condition with data.frame/matrix
samples_by_cond <- lapply(kuehne_traits$Condition %>% unique, function(cond){
  df <- kuehne_traits %>% 
    dplyr::filter(Condition == cond) %>%
    dplyr::select(Slide, Exp)
  apply(df, 1, paste, collapse = "_")
}) %>% setNames(kuehne_traits$Condition %>% unique)

expr_by_cond <- lapply(samples_by_cond %>% names, function(cond){
  samples <- samples_by_cond[[cond]]
  kuehne_expr_filtered[which(rownames(kuehne_expr_filtered) %in% samples),]
}) %>% setNames(samples_by_cond %>% names)


# Expression by condition with SummarizedExperiment
se_expr_by_cond <- lapply(unique(se_kuehne$Condition), function(cond){
     se_kuehne[, se_kuehne$Condition == cond]
}) %>% setNames(unique(se_kuehne$Condition))


# Network building and modules detection by condition
net_by_cond <- lapply(expr_by_cond, build_net, cor_func = "spearman", 
                      n_threads = threads_to_use, keep_matrices = "both")

mod_by_cond <- mapply(detect_modules, expr_by_cond, 
                      lapply(net_by_cond, `[[`, "network"), 
                      MoreArgs = list(detailled_result = TRUE), 
                      SIMPLIFY = FALSE)


comparison <- compare_conditions(expr_by_cond, 
                                 lapply(net_by_cond, `[[`, "adja_mat"), 
                                 lapply(net_by_cond, `[[`, "cor_mat"),  
                                 lapply(mod_by_cond, `[[`, "modules"), 
                                 pvalue_th = 0.05)

## ----plot_comparison_stats----------------------------------------------------
plot_comparison_stats(comparison$result$young$old$p.values)

