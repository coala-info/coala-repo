# Code example from 'Preprocessing' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", message = TRUE, warning = FALSE,
  fig.width=8,
  fig.height =6
)

## ----message = FALSE----------------------------------------------------------
# Load and attach PRONE
library(PRONE)

## ----load_real_tmt------------------------------------------------------------
data("tuberculosis_TMT_se")
se <- tuberculosis_TMT_se

## ----eval = TRUE, include = TRUE----------------------------------------------
se <- subset_SE_by_norm(se, ain = c("raw", "log2"))

## ----overview_NA_table--------------------------------------------------------
knitr::kable(get_NA_overview(se, ain = "log2"))

## ----fig.cap = "Overview barplot of the number of samples per condition."-----
plot_condition_overview(se, condition = NULL)

## ----fig.cap = "Overview barplot of the number of samples per pool."----------
plot_condition_overview(se, condition = "Pool")

## ----fig.cap = "Heatmap of the log2-protein intensities with columns and proteins being clustered with hclust."----
available_ains <- names(assays(se))

plot_heatmap(se, ain = "log2", color_by = c("Pool", "Group"), 
             label_by = NULL, only_refs = FALSE)

## ----fig.cap = "Upset plot of the non-NA protein intensities with sets defined by the Pool column.", fig.width = 8, fig.height = 8----
plot_upset(se, color_by = NULL, label_by = NULL, mb.ratio = c(0.7,0.3), 
           only_refs = FALSE)

## ----fig.cap = "Boxplot of the log2-protein intensities of the markers Q92954;J3KP74;E9PLR3, Q9Y6Z7, and Q68CQ4. If specific biomarkers are known to be upregulated in some conditions, you can use this plot to get an impression of the intensities before doing differential expression analysis."----
p <- plot_markers_boxplots(se, 
                           markers = c("Q92954;J3KP74;E9PLR3", "Q9Y6Z7"), 
                           ain = "log2", 
                           id_column = "Protein.IDs", 
                           facet_norm = FALSE, 
                           facet_marker = TRUE)
p[[1]] + ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, vjust = 0.5))

## -----------------------------------------------------------------------------
se <- filter_out_complete_NA_proteins(se)

## -----------------------------------------------------------------------------
se <- filter_out_proteins_by_value(se, "Reverse", "+")
se <- filter_out_proteins_by_value(se, "Only.identified.by.site", "+")
#se <- filter_out_proteins_by_value(se, "Potential.contaminant", "+")

## -----------------------------------------------------------------------------
pot_contaminants <- get_proteins_by_value(se, "Potential.contaminant", "+")
se <- filter_out_proteins_by_ID(se, pot_contaminants)

## ----fig.cap = "Heatmap of the missing value pattern. Proteins with at least one missing value are included in this heatmap."----
plot_NA_heatmap(se, color_by = NULL, label_by = NULL, cluster_samples = TRUE, 
                cluster_proteins = TRUE)

## ----fig.cap = "Density plot of protein intensities of proteins with missing values and proteins without missing values. This can help to check whether the missing values are biased to lower intense proteins. In this case, the missing values are biased towards the lower intense proteins."----
plot_NA_density(se)

## ----fig.cap = "Protein identification overlap. This plot shows the number of identified proteins (y-axis) per number of samples (x-axis)."----
plot_NA_frequency(se)

## ----fig.cap = "Heatmap of the missing value pattern after filtering proteins with too many missing values (threshold was set to 70%). Proteins with at least one missing value are included in this heatmap."----
se <- filter_out_NA_proteins_by_threshold(se, thr = 0.7) 

plot_NA_heatmap(se)

## ----fig.cap = "Barplot on the number of non-zero proteins per samples colored by condition. This plot helps as quality control to check whether the number of proteins is similar across samples. In this case, only very few proteins have been detected for sample 1.HC_Pool1 compared to the other samples."----
plot_nr_prot_samples(se, color_by = NULL, label_by = NULL)

## ----fig.cap = "Barplot on the total protein intensity per samples colored by condition. This plot helps as quality control to check whether the total protein intensity is similar across samples. In this case, the total protein intensities of samples 1.HC_Pool1 and 1.HC_Pool2 are much lower compared to the other samples."----
plot_tot_int_samples(se, color_by = NULL, label_by = NULL)

## -----------------------------------------------------------------------------
se <- remove_samples_manually(se, "Label", c("1.HC_Pool1", "1.HC_Pool2"))

## -----------------------------------------------------------------------------
se_no_refs <- remove_reference_samples(se)

## -----------------------------------------------------------------------------
poma_res <- detect_outliers_POMA(se, ain = "log2")

## ----fig.cap = "Polygon plot of the principal coordinates calculated using the POMA algorithm. The original distances are reduced to principal coordinates (see POMA and the vegan::betadisper method)."----
poma_res$polygon_plot

## ----fig.cap = "Boxplot of the distances of the samples to the group centroid calculated using POMA."----
poma_res$distance_boxplot

## -----------------------------------------------------------------------------
knitr::kable(poma_res$outliers, 
             caption = "Outliers detected by the POMA algorithm.", digits = 2)

## -----------------------------------------------------------------------------
se <- remove_POMA_outliers(se, poma_res$outliers)

## -----------------------------------------------------------------------------
utils::sessionInfo()

