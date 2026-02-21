# Code example from 'BatchQC_Intro' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("BatchQC")

## ----eval = FALSE-------------------------------------------------------------
# if (!require("devtools", quietly = TRUE)) {
#     install.packages("devtools")
# }
# 
# library(devtools)
# install_github("wejlab/BatchQC")

## ----load package-------------------------------------------------------------
library(BatchQC)

## ----Launch Shiny App, eval = FALSE, echo = TRUE------------------------------
# BatchQC()

## ----Create Sumarized Experiment Object---------------------------------------
# Load package data examples
data(signature_data)
data(batch_indicator)

# Create SE Object
features <- signature_data
metadata <- batch_indicator
se_object <- BatchQC::summarized_experiment(features, metadata)

# Name your assay
SummarizedExperiment::assayNames(se_object) <- "log_intensity"

# Ensure all relevat metadata varaibles are factors
se_object$batch <- as.factor(se_object$batch)
se_object$condition <- as.factor(se_object$condition)

## ----Load TB example data-----------------------------------------------------
se_object <- tb_data_upload()

## ----TB Variables-------------------------------------------------------------
assay_of_interest <- "features"
batch <- "Experiment"
covar <- "TBStatus"

## ----AIC Model Fit------------------------------------------------------------
TB_AIC <- compute_aic(se = se_object,
    assay_of_interest = assay_of_interest,
    batchind = batch,
    groupind = covar,
    maxit = 1000,
    zero_filt_percent = 15
    )
TB_AIC["total_AIC"]
TB_AIC["min_AIC"]

## ----Neg Binomial Model Fit TB Data-------------------------------------------
# Set a seed if you would like reproducible results
set.seed(1)

TB_fit <- goodness_of_fit_DESeq2(se = se_object,
    count_matrix = assay_of_interest,
    condition = covar,
    other_variables = batch,
    num_genes = 3000)

TB_fit$res_histogram
TB_fit$recommendation

## -----------------------------------------------------------------------------
# CPM Normalization
se_object <- BatchQC::normalize_SE(se = se_object, method = "CPM",
    log_bool = FALSE, assay_to_normalize = assay_of_interest,
    output_assay_name = "CPM_normalized_counts")

# CPM Normalization w/log
se_object <- BatchQC::normalize_SE(se = se_object, method = "CPM",
    log_bool = TRUE, assay_to_normalize = assay_of_interest,
    output_assay_name = "CPM_log_normalized_counts")

# DESeq Normalization
se_object <- BatchQC::normalize_SE(se = se_object, method = "DESeq",
    log_bool = FALSE, assay_to_normalize = assay_of_interest,
    output_assay_name = "DESeq_normalized_counts")

# DESeq Normalization w/log
se_object <- BatchQC::normalize_SE(se = se_object, method = "DESeq",
    log_bool = TRUE, assay_to_normalize = assay_of_interest,
    output_assay_name = "DESeq_log_normalized_counts")

# log adjust
se_object <- BatchQC::normalize_SE(se = se_object, method = "none",
    log_bool = TRUE, assay_to_normalize = assay_of_interest,
    output_assay_name = "log_normalized_counts")

## -----------------------------------------------------------------------------
# ComBat correction
se_object <- BatchQC::batch_correct(se = se_object, method = "ComBat",
    assay_to_normalize = "CPM_log_normalized_counts", batch = batch,
    covar = c(covar), output_assay_name = "ComBat_corrected")

## -----------------------------------------------------------------------------
batch_design_tibble <- BatchQC::batch_design(se = se_object, batch = batch, 
    covariate = covar)
batch_design_tibble

## -----------------------------------------------------------------------------
confound_table <- BatchQC::confound_metrics(se = se_object, batch = batch)
confound_table

## -----------------------------------------------------------------------------
pearson_cor_result <- BatchQC::std_pearson_corr_coef(batch_design_tibble)
pearson_cor_result

## -----------------------------------------------------------------------------
cramers_v_result <- BatchQC::cramers_v(batch_design_tibble)
cramers_v_result

## -----------------------------------------------------------------------------
ex_variation <- batchqc_explained_variation(se = se_object,
    batch = batch, condition = covar, assay_name = assay_of_interest)
EV_boxplot <- BatchQC::EV_plotter(batchqc_ev = ex_variation[[1]])
EV_boxplot
EV_boxplot_type_2 <- BatchQC::EV_plotter(batchqc_ev = ex_variation[[2]])
EV_boxplot_type_2

## -----------------------------------------------------------------------------
ex_variation <- batchqc_explained_variation(se = se_object,
    batch = batch, condition = covar, assay_name = assay_of_interest)
EV_table <- BatchQC::EV_table(batchqc_ev = ex_variation[[1]])
EV_table
EV_table_type_2 <- BatchQC::EV_table(batchqc_ev = ex_variation[[2]])
EV_table_type_2

## -----------------------------------------------------------------------------
ex_variation <- batchqc_explained_variation(se = se_object,
    batch = batch, condition = covar, assay_name = "ComBat_corrected")
EV_boxplot <- BatchQC::EV_plotter(batchqc_ev = ex_variation[[1]])
EV_boxplot
EV_boxplot_type_2 <- BatchQC::EV_plotter(batchqc_ev = ex_variation[[2]])
EV_boxplot_type_2
EV_table <- BatchQC::EV_table(batchqc_ev = ex_variation[[1]])
EV_table
EV_table_type_2 <- BatchQC::EV_table(batchqc_ev = ex_variation[[2]])
EV_table_type_2

## ----kBET---------------------------------------------------------------------
TB_kBET <- BatchQC::run_kBET(se = se_object,
    assay_to_normalize = assay_of_interest,
    batch = batch)

BatchQC::plot_kBET(TB_kBET)

## -----------------------------------------------------------------------------
heatmaps <- BatchQC::heatmap_plotter(se = se_object, assay = assay_of_interest,
    nfeature = 38, annotation_column = c(batch, covar),
    log_option = "FALSE")
correlation_heatmap <- heatmaps$correlation_heatmap
correlation_heatmap

## -----------------------------------------------------------------------------
heatmaps <- BatchQC::heatmap_plotter(se = se_object, assay = assay_of_interest,
    nfeature = 38, annotation_column = c(batch, covar),
    log_option = FALSE)
heatmap <- heatmaps$topn_heatmap
heatmap

## -----------------------------------------------------------------------------
dendrogram_plot <- BatchQC::dendrogram_plotter(se = se_object,
    assay = assay_of_interest,
    batch_var = batch,
    category_var = covar)
dendrogram_plot$dendrogram

## -----------------------------------------------------------------------------
circular_dendrogram_plot <- BatchQC::dendrogram_plotter(
    se = se_object, assay = assay_of_interest, batch_var = batch,
    category_var = covar)
circular_dendrogram_plot$circular_dendrogram

## -----------------------------------------------------------------------------
pca_plot <- BatchQC::PCA_plotter(se = se_object, nfeature = 20, color = batch,
    shape = covar, batch = batch,
    assays = c(assay_of_interest, "ComBat_corrected"),
    xaxisPC = 1, yaxisPC = 2, log_option = FALSE)
pca_plot$plot
pca_plot$var_explained

## ----UMAP---------------------------------------------------------------------
umap_plot <- BatchQC::umap(se = se_object,
    assay_of_interest = assay_of_interest, batch = batch, covar = covar,
    neighbors = 15, min_distance = 0.1, spread = 1)

umap_plot

## ----UMAP batch corrected-----------------------------------------------------
umap_plot_batch_corrected <- BatchQC::umap(se = se_object,
    assay_of_interest = "ComBat_corrected", batch = batch, covar = covar,
    neighbors = 15, min_distance = 0.1, spread = 1)

umap_plot_batch_corrected

## -----------------------------------------------------------------------------
differential_expression <- BatchQC::DE_analyze(se = se_object,
    method = "limma", batch = batch, conditions = c(covar),
    assay_to_analyze = assay_of_interest, padj_method = "BH")

## -----------------------------------------------------------------------------
names(differential_expression)

## -----------------------------------------------------------------------------
head(differential_expression[["TBStatusPTB"]])

## -----------------------------------------------------------------------------
pval_plotter(differential_expression)
head(pval_summary(differential_expression))

## -----------------------------------------------------------------------------
value <- round((max(abs(
    differential_expression[[length(differential_expression)]][, 1]))
    + min(
        abs(differential_expression[[length(differential_expression)]][, 1])))
    / 2)
volcano_plot(DE_results = differential_expression[["TBStatusPTB"]],
    pslider = 0.05,
    fcslider = value)

## ----eval = FALSE, echo = TRUE------------------------------------------------
# file_location <- "location/to/save/object"
# 
# saveRDS(object = se_object, file = file_location)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

