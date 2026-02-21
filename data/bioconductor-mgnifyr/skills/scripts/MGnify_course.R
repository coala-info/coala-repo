# Code example from 'MGnify_course' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message = FALSE, warning = FALSE, eval = FALSE)

## ----install------------------------------------------------------------------
# # List of packages that we need
# packages <- c("ANCOMBC", "MGnifyR", "mia",  "miaViz", "scater")
# 
# # Get packages that are already installed
# packages_already_installed <- packages[ packages %in% installed.packages() ]
# # Get packages that need to be installed
# packages_need_to_install <- setdiff( packages, packages_already_installed )
# # Loads BiocManager into the session. Install it if it is not already installed.
# if( !require("BiocManager") ){
#     install.packages("BiocManager")
#     library("BiocManager")
# }
# # If there are packages that need to be installed, installs them with BiocManager
# # Updates old packages.
# if( length(packages_need_to_install) > 0 ) {
#    install(packages_need_to_install, ask = FALSE)
# }
# 
# # Load all packages into session. Stop if there are packages that were not
# # successfully loaded
# pkgs_not_loaded <- !sapply(packages, require, character.only = TRUE)
# pkgs_not_loaded <- names(pkgs_not_loaded)[ pkgs_not_loaded ]
# if( length(pkgs_not_loaded) > 0 ){
#     stop(
#         "Error in loading the following packages into the session: '",
#         paste0(pkgs_not_loaded, collapse = "', '"), "'")
# }

## ----create_mgnify_obj--------------------------------------------------------
# # Create the MgnifyClient object with caching enabled
# mg <- MgnifyClient(
#   useCache = TRUE,
#   cacheDir = "/home/training" # Set this to your desired cache directory
#   )

## ----search_analysis----------------------------------------------------------
# study_id <- "MGYS00005154"
# analysis_id <- searchAnalysis(mg, "studies", study_id)

## ----load_meta----------------------------------------------------------------
# metadata <- getMetadata(mg, accession = analysis_id)

## ----subset_meta--------------------------------------------------------------
# metadata <- metadata[metadata[["analysis_pipeline-version"]] == "5.0", ]

## ----import_treese------------------------------------------------------------
# tse <- getResult(
#     mg,
#     accession = metadata[["analysis_accession"]],
#     get.func = FALSE
#     )
# tse

## ----agg----------------------------------------------------------------------
# tse_order <- agglomerateByRank(tse, rank = "Order")

## ----preprocess---------------------------------------------------------------
# # Transform the main TreeSE
# tse <- transformAssay(tse, method = "relabundance")
# # Transform the agglomerated TreeSE
# tse_order <- transformAssay(tse_order, method = "relabundance")

## ----alpha--------------------------------------------------------------------
# # Calculate alpha diversity
# tse <- addAlpha(tse)
# 
# # Create a plot
# p <- plotColData(
#   tse,
#   y = "shannon_diversity",
#   x = "sample_geographic.location..country.and.or.sea.region.",
#   show_boxplot = TRUE
#   )
# p

## -----------------------------------------------------------------------------
# pairwise.wilcox.test(
#     tse[["shannon_diversity"]],
#     tse[["sample_geographic.location..country.and.or.sea.region."]],
#     p.adjust.method = "fdr"
#     )

## ----pcoa---------------------------------------------------------------------
# # Perform PCoA
# tse <- runMDS(
#   tse,
#   FUN = getDissimilarity,
#   method = "bray",
#   assay.type = "relabundance"
# )
# # Visualize PCoA
# p <- plotReducedDim(
#   tse,
#   dimred = "MDS",
#   colour_by = "sample_geographic.location..country.and.or.sea.region."
#   )
# p

## ----daa1---------------------------------------------------------------------
# # Perform DAA
# res <- ancombc2(
#     data = tse_order,
#     assay.type = "counts",
#     fix_formula = "sample_geographic.location..country.and.or.sea.region.",
#     p_adj_method = "fdr",
#     )

## ----daa2---------------------------------------------------------------------
# # Get the most significant features
# n_top <- 4
# res_tab <- res[["res"]]
# res_tab <- res_tab[order(res_tab[["q_(Intercept)"]]), ]
# top_feat <- res_tab[seq_len(n_top), "taxon"]
# 
# # Create a plot
# p <- plotExpression(
#   tse_order,
#   features = top_feat,
#   assay.type = "relabundance",
#   x = "sample_geographic.location..country.and.or.sea.region.",
#   show_boxplot = TRUE, show_violin = FALSE, point_shape = NA
#   ) +
#   scale_y_log10()
# p

## ----sesion_info--------------------------------------------------------------
# sessionInfo()

