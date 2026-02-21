# Code example from 'MatrixQCvis' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----env, include=FALSE, echo=FALSE, cache=FALSE------------------------------
library("knitr")
opts_chunk$set(stop_on_error = 1L)
suppressPackageStartupMessages(library("MatrixQCvis"))

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("MatrixQCvis")

## ----load_MatrixQCvis, eval=TRUE----------------------------------------------
library(MatrixQCvis)

## ----eval = TRUE, echo = FALSE------------------------------------------------
## run under Linux only
if (grepl(tolower(Sys.info()[["sysname"]]), pattern = "linux")) {
    proxy_string <- Sys.getenv("http_proxy")
    if (nzchar(proxy_string)) {
        ExperimentHub::setExperimentHubOption("PROXY", proxy_string)
    }
}
    

## ----prepare_se, eval=TRUE, echo=TRUE-----------------------------------------
library(ExperimentHub)
eh <- ExperimentHub()

## the SummarizedExperiment object has the title "RNA-Sequencing and clinical  
## data for 741 normal samples from The Cancer Genome Atlas"
eh[eh$title == "RNA-Sequencing and clinical data for 741 normal samples from The Cancer Genome Atlas"]

## in a next step download the SummarizedExperiment object from ExperimentHub
se <- eh[["EH1044"]]

## here we will restrain the analysis on 40 samples and remove the features
## that have a standard deviation of 0
se <- se[, seq_len(40)]
se_sds <- apply(assay(se), 1, sd, na.rm = TRUE)
se <- se[!is.na(se_sds) & se_sds > 0, ]

## ----eval=FALSE---------------------------------------------------------------
# qc <- shinyQC(se)

## ----hist_sample, eval=TRUE, echo=FALSE, crop=NULL, out.width = "200px", dpi=65----
tbl <- hist_sample_num(se = se, category = "type")
partial_bundle(hist_sample(tbl, category = "type"))

## ----mosaic, eval=TRUE, echo=FALSE, crop=NULL, out.width = "200px", dpi=65----
se_tmp <- se
se_tmp$arbitrary_values <- c("A", "B")
mosaic(se = se_tmp, f1 = "type", f2 = "arbitrary_values")

## ----boxplot, eval=TRUE, echo=FALSE, warning=FALSE, crop=NULL, out.width = "200px", dpi=65----
createBoxplot(se, orderCategory = "sample", title = "raw", log = TRUE, 
               violin = TRUE)

## ----drift, eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE, crop=NULL, out.width = "200px", dpi=65----
partial_bundle(driftPlot(se, aggregation = "median", category = "type",
          orderCategory = "type", level = "BRCA", method = "loess"))

## ----cv, eval=TRUE, echo=FALSE, warning=FALSE, message=FALSE, crop=NULL, out.width = "200px", dpi=65----
a <- assay(se)
a_n <- normalizeAssay(a, "sum")
se_n <- MatrixQCvis:::updateSE(se = se, assay = a_n)
a_b <- batchCorrectionAssay(se_n, method = "none")
a_t <- transformAssay(a_b, "vsn")
se_t <- MatrixQCvis:::updateSE(se = se, assay = a_t)

a_i <- imputeAssay(a_t, "MinDet")

## calculate cv values
cv_r <- cv(a, "raw")
cv_n <- cv(a_n, "normalized")
cv_b <- cv(a_b, "batch corrected")
cv_t <- cv(a_t, "transformed")
cv_i <- cv(a_i, "imputed")
 
df <- data.frame(cv_r, cv_n, cv_b, cv_t, cv_i)
plotCV(df)

## ----meansdplot, eval=TRUE, echo=FALSE, warning=FALSE, crop=NULL, out.width = "200px", dpi=65----
vsn::meanSdPlot(assay(se_t))

## ----maplot, eval=TRUE, echo = FALSE, show=FALSE, crop=NULL, out.width = "200px", dpi=65----
tbl <- MAvalues(se, group = "all")
MAplot(tbl, group = "all", plot = "TCGA-K4-A3WV-11A-21R-A22U-07")

## ----ecdf, eval=TRUE, echo=FALSE, crop=NULL, out.width = "200px", dpi=65------
ECDF(se, "TCGA-K4-A3WV-11A-21R-A22U-07", group = "all")

## ----distSampe, eval=TRUE, echo=FALSE, crop=NULL, warning=FALSE, message=FALSE, out.width = "200px", dpi=65----
a <- assay(se)
dist_mat <- distShiny(a)
distSample(dist_mat, se, "type", use_raster = TRUE, raster_device = "jpeg")
partial_bundle(sumDistSample(dist_mat, title = "raw"))

## ----featurePlot, eval=TRUE, echo=FALSE, crop=NULL, out.width = "200px", dpi=65----
l_assays <- list(raw = a, normalized = a_n, `batch.corrected` = a_b,
   transformed = a_t, imputed = a_i)
df_feature <- createDfFeature(l_assays, feature = rownames(se)[1])
featurePlot(df_feature)

## ----cvFeaturePlot, eval=TRUE, echo=FALSE, crop=NULL, out.width = "200px", dpi=65----
partial_bundle(cvFeaturePlot(l_assays, lines = FALSE))

## ----colData, echo=FALSE, eval=TRUE-------------------------------------------
colData(se) |>
    head(n = 10)

## ----modelMatrix, echo=FALSE, eval=TRUE---------------------------------------
mM <- model.matrix(formula("~ type + 0"), data = colData(se))
head(mM)

## ----contrasts, echo=FALSE, eval=TRUE, warning=FALSE, message=FALSE-----------
library(limma)
cM <- makeContrasts(contrasts = "typeBRCA-typeLUAD", levels = mM)
head(cM)

## ----topDE, echo=FALSE, eval=TRUE, warning=FALSE, message=FALSE---------------
a <- assay(se)
a_n <- a |>
    normalizeAssay(method = "none")
a_t <- a_n |>
    transformAssay(method = "vsn")
a_i <- a_t |>
    imputeAssay(method = "MinDet")

fit <- lmFit(a_i, design = mM)
fit <- contrasts.fit(fit, contrasts = cM)
fit <- eBayes(fit, trend = TRUE, robust = TRUE)
tT <- topTable(fit, number = Inf, adjust.method = "fdr", p.value = 0.05)
rmarkdown::paged_table(tT[seq_len(20), ])

## ----volcano, eval=TRUE, echo=FALSE, crop=NULL, out.width = "200px", dpi=65----
partial_bundle(volcanoPlot(tT, type = "ttest"))

## ----data_proteomics----------------------------------------------------------
eh[eh$title == "proteomic_20Q2"]
tbl <- eh[["EH3459"]]

## reduce the number of files to speed computations up (can be skipped)
cell_line_unique <- dplyr::pull(tbl, "cell_line") |>
    unique()
tbl <- tbl |> 
    filter(tbl[["cell_line"]] %in% cell_line_unique[seq_len(40)])

## using the information from protein_id/cell_line calculate the mean expression
## from the protein_expression values, 
tbl_mean <- tbl |>
    dplyr::group_by(protein_id, cell_line) |>
    dplyr::summarise(mean_expression = mean(protein_expression, na.rm = TRUE), 
        .groups = "drop") 

## create wide format from averaged expression data
tbl_mean <- tbl_mean |>
    tidyr::pivot_wider(names_from = cell_line, values_from = mean_expression,
        id_cols = protein_id, names_expand = TRUE)

## add additional information from tbl to tbl_mean, remove first columns 
## protein_expression and cell_line, remove the duplicated rows based on 
## protein_id, finally add the tbl_mean to tbl_info
tbl_info <- tbl |>
    dplyr::select(-protein_expression, -cell_line) |> 
    dplyr::distinct(protein_id, .keep_all = TRUE)
tbl_mean <- dplyr::right_join(tbl_info, tbl_mean,
    by = c("protein_id" = "protein_id")) 

## create assay object
cols_a_start <- which(colnames(tbl_mean) == "A2058_SKIN")
a <- tbl_mean[, cols_a_start:ncol(tbl_mean)] |>
    as.matrix()
rownames(a) <- dplyr::pull(tbl_mean, "protein_id")

## create rowData object
rD <- tbl_mean[, seq_len(cols_a_start - 1)] |>
    as.data.frame()
rownames(rD) <- dplyr::pull(tbl_mean, "protein_id")

## create colData object, for the tissue column split the strings in column 
## sample by "_", remove the first element (cell_line) and paste the remaining
## elements
cD <- data.frame(
    sample = colnames(tbl_mean)[cols_a_start:ncol(tbl_mean)]
) |> 
    mutate(tissue = unlist(lapply(strsplit(sample, split = "_"), function(sample_i) 
        paste0(sample_i[-1], collapse = "_"))))
rownames(cD) <- cD$sample

## create the SummarizedExperiment
se <- SummarizedExperiment(assay = a, rowData = rD, colData = cD)

## here we remove the features that have a standard deviation of 0
se_sds <- apply(assay(se), 1, sd, na.rm = TRUE)
se <- se[!is.na(se_sds) & se_sds > 0, ]

## ----shinyQC_proteomics, eval = FALSE-----------------------------------------
# shinyQC(se)

## ----samplesMeasuredMissing, eval=TRUE, echo=FALSE, crop=NULL, out.width = "200px", dpi=65----
tbl <- samplesMeasuredMissing(se)
partial_bundle(barplotSamplesMeasuredMissing(tbl, measured = TRUE))

## ----histFeature_measured, eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE, crop=NULL, out.width = "200px", dpi=65----
partial_bundle(histFeature(assay(se), measured = TRUE))

## ----histFeature_missing, eval=FALSE, echo=FALSE, message=FALSE, warning=FALSE, crop=NULL, out.width = "200px", dpi=65----
# partial_bundle(histFeature(assay(se), measured = FALSE))

## ----histFeatureCategory, eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE, crop=NULL, out.width = "200px", dpi=65----
partial_bundle(histFeatureCategory(se, measured = TRUE, category = "tissue"))

## ----upsetmeasured, eval=TRUE, echo=FALSE, crop=NULL, out.width = "200px", dpi=65----
upsetCategory(se, category = "tissue", measured = TRUE)

## ----upsetmissing, eval=FALSE, echo=FALSE, crop=NULL, out.width = "200px", dpi=65----
# upsetCategory(se, category = "tissue", measured = FALSE)

## ----session, eval=TRUE, echo=FALSE-------------------------------------------
sessionInfo()

