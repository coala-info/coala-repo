# Code example from 'spma' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(transite)

## ----message=FALSE------------------------------------------------------------
background_df <- transite:::ge$background_df

## ----message=FALSE------------------------------------------------------------
background_df <- dplyr::arrange(background_df, value)

## ----message=FALSE------------------------------------------------------------
background_set <- gsub("T", "U", background_df$seq)

## ----message=FALSE------------------------------------------------------------
names(background_set) <- paste0(background_df$refseq, "|", background_df$seq_type)

## ----message=FALSE------------------------------------------------------------
motif_db <- get_motif_by_id("M178_0.6")

## ----message=FALSE------------------------------------------------------------
results <- run_matrix_spma(background_set, motifs = motif_db, cache = FALSE)

# Usually, all motifs are included in the analysis and results are cached to make subsequent analyses more efficient.
# results <- run_matrix_spma(background_set)

## ----results='asis', echo=FALSE, fig.width=10, fig.height=7-------------------
cat("\n\n####", results$spectrum_info_df$motif_rbps, " (", results$spectrum_info_df$motif_id, ")\n\n", sep = "")
  
cat("\n\n**Spectrum plot with polynomial regression:**\n\n")

grid::grid.draw(results$spectrum_plots[[1]])

cat("\n\n**Classification:**\n\n")

if (results$spectrum_info_df$aggregate_classifier_score == 3) {
    cat('\n\n<p style="background-color: #2ecc71; padding: 10px; color: white; margin: 0">spectrum classification: non-random (3 out of 3 criteria met)</p>\n\n')
} else if (results$spectrum_info_df$aggregate_classifier_score == 2) {
    cat('\n\n<p style="background-color: #f1c40f; padding: 10px; color: white; margin: 0">spectrum classification: random (2 out of 3 criteria met)</p>\n\n')
} else if (results$spectrum_info_df$aggregate_classifier_score == 1) {
    cat('\n\n<p style="background-color: #e67e22; padding: 10px; color: white; margin: 0">spectrum classification: random (1 out of 3 criteria met)</p>\n\n')
} else {
    cat('\n\n<p style="background-color: #c0392b; padding: 10px; color: white; margin: 0">spectrum classification: random (0 out of 3 criteria met)</p>\n\n')
}

cat("\n\nProperty | Value | Threshold\n")
cat("------------- | ------------- | -------------\n")
cat("adjusted $R^2$ | ", round(results$spectrum_info_df$adj_r_squared, 3), " | $\\geq 0.4$ \n")
cat("polynomial degree | ", results$spectrum_info_df$degree, " | $\\geq 1$ \n")
cat("slope | ", round(results$spectrum_info_df$slope, 3), " | $\\neq 0$ \n")
cat("unadjusted p-value estimate of consistency score | ", round(results$spectrum_info_df$consistency_score_p_value, 7), " | $< 0.000005$ \n")
cat("number of significant bins | ", results$spectrum_info_df$n_significant, " | ", paste0("$\\geq ", floor(40 / 10), "$"), " \n\n")

