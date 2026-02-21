# Code example from 'Spike_In_Data' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", message = TRUE, warning = FALSE,
  fig.width=8,
  fig.height =6
)

## ----setup, message = FALSE---------------------------------------------------
library(PRONE)

## -----------------------------------------------------------------------------
data_path <- readPRONE_example("Ecoli_human_MaxLFQ_protein_intensities.csv")
md_path <- readPRONE_example("Ecoli_human_MaxLFQ_metadata.csv")

data <- read.csv(data_path)
md <- read.csv(md_path)

## -----------------------------------------------------------------------------
# Check if some protein groups are mixed
mixed <- grepl("Homo sapiens.*Escherichia|Escherichia.*Homo sapiens",data$Fasta.headers) 
data <- data[!mixed,]

table(mixed) 

## -----------------------------------------------------------------------------
data$Spiked <- rep("HUMAN", nrow(data))
data$Spiked[grepl("ECOLI", data$Fasta.headers)] <- "ECOLI"

## -----------------------------------------------------------------------------
se <- load_spike_data(data, 
                      md, 
                      spike_column = "Spiked", 
                      spike_value = "ECOLI", 
                      spike_concentration = "Concentration",
                      protein_column = "Protein.IDs", 
                      gene_column = "Gene.names", 
                      ref_samples = NULL, 
                      batch_column = NULL, 
                      condition_column = "Condition", 
                      label_column = "Label")

## ----fig.cap = "Overview of the number of identified spike-in proteins per sample, colored by condition. In this data set, the conditions were labeled with H and L. H indicates the sample group with high concentrations of spike-in proteins added to the background proteome, while L represents the sample group with low concentrations."----
plot_identified_spiked_proteins(se)

## ----fig.cap = "Histogram of the protein intensities of the spike-in proteins (ECOLI) and the background proteins (HUMAN) in the different conditions. This plot helps to compare the distributions of spike-in (red) and background proteins (grey) for the different spike-in levels."----
plot_histogram_spiked(se, condition = NULL)

## ----fig.cap = "Profiles of the spike-in proteins (ECOLI) and the background proteins (HUMAN) in the different conditions. This plot helps to analyze whether the intensities of the background proteins are constant across the different spike-in concentrations. Spike-in proteins (red) should increase in intensity with increasing spike-in concentrations, while background proteins (grey) should remain constant."----
plot_profiles_spiked(se, xlab = "Concentration")

## -----------------------------------------------------------------------------
se_norm <- normalize_se(se, c("Median", "Mean", "MAD", "LoessF"), 
                        combination_pattern = NULL)

## -----------------------------------------------------------------------------
comparisons <- specify_comparisons(se_norm, condition = "Condition", 
                                   sep = NULL, control = NULL)

## -----------------------------------------------------------------------------
de_res <- run_DE(se = se_norm, 
                     comparisons = comparisons,
                     ain = NULL, 
                     condition = NULL, 
                     DE_method = "limma", 
                     covariate = NULL, 
                     logFC = TRUE, 
                     logFC_up = 1, 
                     logFC_down = -1, 
                     p_adj = TRUE, 
                     alpha = 0.05, 
                     B = 100, 
                     K = 500)

## -----------------------------------------------------------------------------
stats <- get_spiked_stats_DE(se_norm, de_res)

# Show tp, fp, fn, tn, with F1 score
knitr::kable(stats[,c("Assay", "Comparison", "TP", "FP", "FN", "TN", "F1Score")], caption = "Performance metrics for the different normalization methods and pairwise comparisons.", digits = 2)

## ----fig.cap = "Barplot showing the number of false positives (FP) and true positives (TP) for each normalization method and is facetted by pairwise comparison. This plot shows the impact of normalization on DE results."----
plot_TP_FP_spiked_bar(stats, ain = c("Median", "Mean", "MAD", "LoessF"), 
                      comparisons = NULL)

## ----fig.cap = "Boxplot showing the distribution of true positives (TP) and false positives (FP) for each normalization method across all pairwise comparisons. This plot helps to visualize the distribution of TP and FP for each normalization method. Since in this dataset, only two conditions are available, hence a single pairwise comparison, this plot is not very informative."----
plot_TP_FP_spiked_box(stats, ain = c("Median", "Mean", "MAD", "LoessF"), 
                      comparisons = NULL)

## ----fig.cap = "Scatter plot showing the median true positives (TP) and false positives (FP) for each normalization method across all pairwise comparisons."----
plot_TP_FP_spiked_scatter(stats, ain = NULL, comparisons = NULL)

## ----fig.cap = "Heatmap showing a selection of performance metrics for the different normalization methods and pairwise comparisons."----
plot_stats_spiked_heatmap(stats, ain = c("Median", "Mean", "MAD"), 
                          metrics = c("Precision", "F1Score"))

## ----fig.cap = "ROC curves and AUC barplots and boxplots for the different normalization methods and pairwise comparisons. AUC barplots are shown for each pairwise comparison, while the boxplot shows the distribution of AUC values across all comparisons."----
plot_ROC_AUC_spiked(se_norm, de_res, ain = c("Median", "Mean", "LoessF"), 
                    comparisons = NULL)

## ----fig.cap = "Boxplot showing the distribution of log fold changes for the different normalization methods and pairwise comparisons. The dotted blue line is at y = 0 because logFC values of the background proteins should be centered around 0, while the dotted red line shows the expected logFC value based on the spike-in concentrations of both sample groups."----
plot_fold_changes_spiked(se_norm, de_res, condition = "Condition", 
                         ain = c("Median", "Mean", "MAD"), comparisons = NULL)

## ----fig.cap = "Boxplot showing the distribution of p-values for the different normalization methods and pairwise comparisons."----
plot_pvalues_spiked(se_norm, de_res, ain = c("Median", "Mean", "MAD"), 
                    comparisons = NULL)

## -----------------------------------------------------------------------------
plots <- plot_logFC_thresholds_spiked(se_norm, de_res, condition = NULL, 
                                      ain = c("Median", "Mean", "MAD"), 
                                      nrow = 1, alpha = 0.05)

## ----fig.cap = "Barplot showing the number of true positives for each normalization method and pairwise comparison for different log fold change thresholds. This plot helps to analyze the impact of different log fold change thresholds on the number of true positives. The dotted line in the plot shows the expected logFC value based on the spike-in concentrations of both sample groups."----
plots[[1]]

## ----fig.cap = "Barplot showing the number of false positives for each normalization method and pairwise comparison for different log fold change thresholds. This plot helps to analyze the impact of different log fold change thresholds on the number of false positives. The dotted line in the plot shows the expected logFC value based on the spike-in concentrations of both sample groups."----
plots[[2]]

## -----------------------------------------------------------------------------
utils::sessionInfo()

