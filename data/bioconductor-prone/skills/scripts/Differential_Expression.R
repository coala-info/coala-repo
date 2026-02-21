# Code example from 'Differential_Expression' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", message = TRUE, warning = FALSE,
  fig.width=8,
  fig.height =6
)

## ----setup, message = FALSE---------------------------------------------------
library(PRONE)

## ----load_real_tmt------------------------------------------------------------
data("tuberculosis_TMT_se")
se <- tuberculosis_TMT_se

## -----------------------------------------------------------------------------
se_norm <- normalize_se(se, c("IRS_on_RobNorm", "IRS_on_Median", 
                              "IRS_on_LoessF", "IRS_on_Quantile"), 
                        combination_pattern = "_on_")

## -----------------------------------------------------------------------------
se_norm <- remove_reference_samples(se_norm)

## -----------------------------------------------------------------------------
comparisons <- specify_comparisons(se_norm, condition = "Group", 
                                   sep = NULL, control = NULL)

comparisons <- c("PTB-HC", "TBL-HC", "TBL-PTB", "Rx-PTB")

## -----------------------------------------------------------------------------
de_res <- run_DE(se = se_norm, 
                     comparisons = comparisons,
                     ain = NULL, 
                     condition = NULL, 
                     DE_method = "limma", 
                     logFC = TRUE, 
                     logFC_up = 1, 
                     logFC_down = -1, 
                     p_adj = TRUE, 
                     alpha = 0.05,
                     covariate = NULL, 
                     trend = TRUE,
                     robust = TRUE,
                     B = 100,
                     K = 500
                 ) 

## -----------------------------------------------------------------------------
new_de_res <- apply_thresholds(de_res = de_res, logFC = FALSE, p_adj = TRUE, 
                               alpha = 0.05)

## -----------------------------------------------------------------------------
new_de_res <- apply_thresholds(de_res = de_res, logFC = TRUE, 
                               logFC_up = 0, logFC_down = 0, 
                               p_adj = TRUE, alpha = 0.05)

## ----fig.cap = "Barplot showing the number of DE proteins per normalization method colored by comparison and facetted by up- and down-regulation."----
plot_overview_DE_bar(de_res, ain = NULL, comparisons = comparisons, 
                     plot_type = "facet_regulation")

## ----fig.cap = "Barplot showing the number of DE proteins per normalization method faceted by comparison."----
plot_overview_DE_bar(de_res, ain = NULL, comparisons = comparisons[seq_len(2)], 
                     plot_type = "facet_comp")

## ----fig.cap = "Heatmap showing the number of DE proteins per comparison and per normalization method."----
plot_overview_DE_tile(de_res)

## ----fig.cap = "Volcano plots per normalization method for a single comparison."----
plot_volcano_DE(de_res, ain = NULL, comparisons = comparisons[1], 
                facet_norm = TRUE)

## ----fig.cap = "Individual heatmap of the DE results for a specific comparison and a selection of normalization methods. The adjusted p-values are added as row annotation, while the condition of each sample is shown as column annotation."----
plot_heatmap_DE(se_norm, de_res, ain = c("RobNorm", "IRS_on_RobNorm"), 
                comparison = "PTB-HC", condition = NULL, label_by = NULL, 
                pvalue_column = "adj.P.Val")

## ----fig.cap = "Upset plot showing the overlapping DE proteins of different normalization methods colored by comparison.", fig.height = 12----
intersections <- plot_upset_DE(de_res, ain = NULL, 
                               comparisons = comparisons[seq_len(3)], 
                               min_degree = 6, plot_type = "stacked")
if(!is.null(intersections)){
  # put legend on top due to very long comparisons
intersections$upset[[2]] <- intersections$upset[[2]] + 
  ggplot2::theme(legend.position = "top", legend.direction = "vertical")
intersections$upset
}

## ----fig.cap = "Heatmap showing the Jaccard similarity indices of the DE results between different normalization methods for all comparisons."----
plot_jaccard_heatmap(de_res, ain = NULL, comparisons = comparisons, 
                     plot_type = "all")

## -----------------------------------------------------------------------------
DT::datatable(extract_consensus_DE_candidates(de_res, ain = NULL, 
                                              comparisons = comparisons, 
                                              norm_thr = 0.8, 
                                              per_comparison = TRUE), 
              options = list(scrollX = TRUE))

## -----------------------------------------------------------------------------
enrich_results <- plot_intersection_enrichment(se, de_res, comparison = "PTB-HC", 
                             ain = c("IRS_on_Median", "IRS_on_RobNorm", "RobNorm"), 
                             id_column = "Gene.Names", organism = "hsapiens", 
                             source = "KEGG", signif_thr = 0.05)

## ----fig.cap = "Heatmap showing enriched terms of the DE sets between different normalization methods for a specific comparison."----
enrich_results$enrichment_term_plot


## ----fig.cap = "Heatmap showing the Jaccard similarity indices of the enriched terms between different normalization methods for a specific comparison."----
enrich_results$jaccard_intersection_plot

## -----------------------------------------------------------------------------
utils::sessionInfo()

