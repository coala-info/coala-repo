# Code example from 'hermes' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----bioc-installation, eval = FALSE------------------------------------------
# if (!require("BiocManager")) {
#   install.packages("BiocManager")
# }
# BiocManager::install("hermes")

## ----gh-installation, eval = FALSE--------------------------------------------
# if (!require("devtools")) {
#   install.packages("devtools")
# }
# devtools::install_github("insightsengineering/hermes")

## ----message=FALSE------------------------------------------------------------
library(hermes)
library(SummarizedExperiment)

## ----message=FALSE, warning=FALSE---------------------------------------------
?expression_set
?summarized_experiment

## -----------------------------------------------------------------------------
object <- HermesData(summarized_experiment)

## -----------------------------------------------------------------------------
object

## -----------------------------------------------------------------------------
head(annotation(object))

## -----------------------------------------------------------------------------
object <- summarized_experiment %>%
  rename(
    row_data = c(
      symbol = "HGNC",
      desc = "HGNCGeneName",
      chromosome = "Chromosome",
      size = "WidthBP",
      low_expression_flag = "LowExpressionFlag"
    ),
    col_data = c(
      low_depth_flag = "LowDepthFlag",
      technical_failure_flag = "TechnicalFailureFlag"
    )
  ) %>%
  HermesData()

## -----------------------------------------------------------------------------
head(annotation(object))

## -----------------------------------------------------------------------------
summary(object)

## -----------------------------------------------------------------------------
object <- hermes_data

## -----------------------------------------------------------------------------
object_exp <- summarized_experiment %>%
  rename(assays = c(count = "counts"))

## -----------------------------------------------------------------------------
object_exp <- rename(object_exp,
  assays = c(counts = "count")
)
object_exp <- HermesData(object_exp)

## -----------------------------------------------------------------------------
se <- makeSummarizedExperimentFromExpressionSet(expression_set)
object2 <- HermesData(se)
object2

## -----------------------------------------------------------------------------
counts_matrix <- assay(hermes_data)
object3 <- HermesDataFromMatrix(
  counts = counts_matrix,
  rowData = rowData(hermes_data),
  colData = colData(hermes_data)
)
object3
identical(object, object3)

## -----------------------------------------------------------------------------
cnts <- counts(object)
cnts[1:3, 1:3]

## -----------------------------------------------------------------------------
small_object <- object[1:10, ]

## ----eval=FALSE---------------------------------------------------------------
# httr::set_config(httr::config(ssl_verifypeer = 0L))
# connection <- connect_biomart(prefix(small_object))

## ----eval=FALSE---------------------------------------------------------------
# annotation(small_object) <- query(genes(small_object), connection)

## -----------------------------------------------------------------------------
my_controls <- control_quality(min_cpm = 10, min_cpm_prop = 0.4, min_corr = 0.4, min_depth = 1e4)
object_flagged <- add_quality_flags(object, control = my_controls)

## -----------------------------------------------------------------------------
object_flagged <- set_tech_failure(object_flagged, sample_ids = "06520011B0023R")

## -----------------------------------------------------------------------------
head(get_tech_failure(object_flagged))
head(get_low_depth(object_flagged))
head(get_low_expression(object_flagged))

## -----------------------------------------------------------------------------
object_flagged_filtered <- filter(object_flagged)
object_flagged_genes_filtered <- filter(object_flagged, what = "genes")

## -----------------------------------------------------------------------------
names(rowData(object_flagged))
names(colData(object_flagged))
head(rowData(object_flagged)$chromosome)
head(object_flagged$ARMCD)
object_flagged_subsetted <- subset(
  object_flagged,
  subset = chromosome == "5",
  select = ARMCD == "COH1"
)

## -----------------------------------------------------------------------------
object_normalized <- normalize(object_flagged_filtered)

## -----------------------------------------------------------------------------
assay(object_normalized, "tpm")[1:3, 1:3]

## -----------------------------------------------------------------------------
metadata(object_normalized)

## -----------------------------------------------------------------------------
object_normalized_original <- normalize(
  object_flagged_filtered,
  control = control_normalize(log = FALSE)
)
assay(object_normalized_original, "tpm")[1:3, 1:3]

## -----------------------------------------------------------------------------
autoplot(object)

## -----------------------------------------------------------------------------
draw_libsize_hist(object, bins = 10L, fill = "blue")

## -----------------------------------------------------------------------------
most_expr_genes <- top_genes(object_normalized, assay_name = "tpm")
autoplot(most_expr_genes)

## -----------------------------------------------------------------------------
most_var_genes <- top_genes(object_normalized, summary_fun = rowSds)
autoplot(most_var_genes)

## -----------------------------------------------------------------------------
draw_heatmap(object[1:20], assay_name = "counts")

## -----------------------------------------------------------------------------
draw_heatmap(object[1:20], assay_name = "counts", col_data_annotation = "COUNTRY")

## -----------------------------------------------------------------------------
cor_mat <- correlate(object)
autoplot(cor_mat)

## -----------------------------------------------------------------------------
pca_res <- calc_pca(object_normalized, assay_name = "tpm")
summary(pca_res)$importance
autoplot(pca_res)

## -----------------------------------------------------------------------------
autoplot(
  pca_res,
  x = 2, y = 3,
  data = as.data.frame(colData(object_normalized)), colour = "SEX"
)

## -----------------------------------------------------------------------------
pca_cor <- correlate(pca_res, object_normalized)
autoplot(pca_cor)

## -----------------------------------------------------------------------------
colData(object) <- df_cols_to_factor(colData(object))
diff_res <- diff_expression(object, group = "SEX", method = "voom")
head(diff_res)

## ----fig.small = TRUE---------------------------------------------------------
autoplot(diff_res, log2_fc_thresh = 8)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

