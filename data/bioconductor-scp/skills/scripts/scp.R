# Code example from 'scp' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL
    ## cf https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----scp_framework, results='markup', fig.cap="`scp` relies on `SingleCellExperiment` and `QFeatures` objects.", echo=FALSE, out.width='100%', fig.align='center'----
knitr::include_graphics("./figures/SCP_framework.png", error = FALSE)

## ----load_scp, message = FALSE------------------------------------------------
library("scp")

## ----load_other_package, message = FALSE--------------------------------------
library("ggplot2")
library("dplyr")

## -----------------------------------------------------------------------------
data("mqScpData")

## -----------------------------------------------------------------------------
data("sampleAnnotation")

## -----------------------------------------------------------------------------
table(sampleAnnotation$SampleType)

## ----readSCP------------------------------------------------------------------
scp <- readSCP(assayData = mqScpData,
               colData = sampleAnnotation,
               runCol = "Raw.file",
               removeEmptyCols = TRUE)
scp

## ----plot1--------------------------------------------------------------------
plot(scp)

## ----zeroIsNA-----------------------------------------------------------------
scp <- zeroIsNA(scp, i = 1:4)

## ----rowDataNames-------------------------------------------------------------
rowDataNames(scp)

## ----filter_psms--------------------------------------------------------------
scp <- filterFeatures(scp,
                      ~ Reverse != "+" &
                          Potential.contaminant != "+" &
                          !is.na(PIF) & PIF > 0.8)

## ----dims---------------------------------------------------------------------
dims(scp)

## ----filter_assays------------------------------------------------------------
keepAssay <- dims(scp)[1, ] > 150
scp <- scp[, , keepAssay]
scp

## ----show_annotation----------------------------------------------------------
table(colData(scp)[, "SampleType"])

## ----computeSCR---------------------------------------------------------------
scp <- computeSCR(scp,
                  i = 1:3,
                  colvar = "SampleType",
                  carrierPattern = "Carrier",
                  samplePattern = "Macrophage|Monocyte",
                  sampleFUN = "mean",
                  rowDataName = "MeanSCR")

## ----plot_SCR, warning=FALSE, message=FALSE-----------------------------------
rbindRowData(scp, i = 1:3) |>
    data.frame() |>
    ggplot(aes(x = MeanSCR)) +
    geom_histogram() +
    geom_vline(xintercept = c(1/200, 0.1),
               lty = c(2, 1)) +
    scale_x_log10()

## ----filter_SCR---------------------------------------------------------------
scp <- filterFeatures(scp,
                      ~ !is.na(MeanSCR) &
                          MeanSCR < 0.1)

## ----compute_qvalues----------------------------------------------------------
scp <- pep2qvalue(scp,
                  i = 1:3,
                  PEP = "dart_PEP",
                  rowDataName = "qvalue_PSMs")

## ----compute_qvalues2---------------------------------------------------------
scp <- pep2qvalue(scp,
                  i = 1:3,
                  PEP = "dart_PEP",
                  groupBy = "Leading.razor.protein",
                  rowDataName = "qvalue_proteins")

## ----filter_FDR---------------------------------------------------------------
scp <- filterFeatures(scp,
                      ~ qvalue_proteins < 0.01)

## ----divideByReference--------------------------------------------------------
scp <- divideByReference(scp,
                         i = 1:3,
                         colvar = "SampleType",
                         samplePattern = ".",
                         refPattern = "Reference")

## ----features_aggregation, results = 'markup', fig.cap = "Conceptual illustration of feature aggregation.", echo=FALSE, out.width='100%', fig.align='center'----
knitr::include_graphics("./figures/feature_aggregation.png", error = FALSE)

## ----show_agg_psms------------------------------------------------------------
scp

## ----aggregate_peptides, message = FALSE--------------------------------------
scp <- aggregateFeatures(scp,
                         i = 1:3,
                         fcol = "Modified.sequence",
                         name = paste0("peptides_", names(scp)),
                         fun = matrixStats::colMedians, na.rm = TRUE)

## ----show_agg_peptides--------------------------------------------------------
scp

## ----plot2--------------------------------------------------------------------
plot(scp)

## ----joinAssays---------------------------------------------------------------
scp <- joinAssays(scp,
                  i = 4:6,
                  name = "peptides")

## ----plot3--------------------------------------------------------------------
plot(scp)

## ----subset samples-----------------------------------------------------------
scp
scp <- scp[, scp$SampleType %in% c("Blank", "Macrophage", "Monocyte"), ]

## ----show_cell_filter---------------------------------------------------------
scp

## ----compute_colMedians-------------------------------------------------------
medians <- colMedians(assay(scp[["peptides"]]), na.rm = TRUE)
scp$MedianRI <- medians

## ----plot_medianRI, warning=FALSE, message=FALSE------------------------------
colData(scp) |>
    data.frame() |>
    ggplot() +
    aes(x = MedianRI,
        y = SampleType,
        fill = SampleType) +
    geom_boxplot() +
    scale_x_log10()

## ----medianCVperCell----------------------------------------------------------
scp <- medianCVperCell(scp,
                       i = 1:3,
                       groupBy = "Leading.razor.protein",
                       nobs = 5,
                       norm = "div.median",
                       na.rm = TRUE,
                       colDataName = "MedianCV")

## ----plot_medianCV, message = FALSE, warning = FALSE--------------------------
getWithColData(scp, "peptides") |>
    colData() |>
    data.frame() |>
    ggplot(aes(x = MedianCV,
               fill = SampleType)) +
    geom_boxplot() +
    geom_vline(xintercept = 0.65)

## ----create_filter------------------------------------------------------------
scp <- scp[, !is.na(scp$MedianCV) & scp$MedianCV < 0.65, ]

## ----remove_NC----------------------------------------------------------------
scp <- scp[, scp$SampleType != "Blank", ]

## ----normalize_scale----------------------------------------------------------
## Divide columns by median
scp <- sweep(scp,
             i = "peptides",
             MARGIN = 2,
             FUN = "/",
             STATS = colMedians(assay(scp[["peptides"]]), na.rm = TRUE),
             name = "peptides_norm_col")
## Divide rows by mean
scp <- sweep(scp,
             i = "peptides_norm_col",
             MARGIN = 1,
             FUN = "/",
             STATS = rowMeans(assay(scp[["peptides_norm_col"]]),  na.rm = TRUE),
             name = "peptides_norm")

## ----plot4--------------------------------------------------------------------
plot(scp)

## ----filterNA-----------------------------------------------------------------
scp <- filterNA(scp,
                i = "peptides_norm",
                pNA = 0.99)

## ----logTransform-------------------------------------------------------------
scp <- logTransform(scp,
                    base = 2,
                    i = "peptides_norm",
                    name = "peptides_log")

## ----aggregate_proteins-------------------------------------------------------
scp <- aggregateFeatures(scp,
                         i = "peptides_log",
                         name = "proteins",
                         fcol = "Leading.razor.protein",
                         fun = matrixStats::colMedians, na.rm = TRUE)

## ----show_agg_proteins--------------------------------------------------------
scp

## ----normalize_center---------------------------------------------------------
## Center columns with median
scp <- sweep(scp, i = "proteins",
             MARGIN = 2,
             FUN = "-",
             STATS = colMedians(assay(scp[["proteins"]]),
                                na.rm = TRUE),
             name = "proteins_norm_col")
## Center rows with mean
scp <- sweep(scp, i = "proteins_norm_col",
             MARGIN = 1,
             FUN = "-",
             STATS = rowMeans(assay(scp[["proteins_norm_col"]]),
                              na.rm = TRUE),
             name = "proteins_norm")

## ----missingness--------------------------------------------------------------
scp[["proteins_norm"]] |>
    assay() |>
    is.na() |>
    mean()

## ----impute-------------------------------------------------------------------
scp <- impute(scp,
              i = "proteins_norm",
              name = "proteins_imptd",
              method = "knn",
              k = 3, rowmax = 1, colmax= 1,
              maxp = Inf, rng.seed = 1234)

## ----missingness_imputed------------------------------------------------------
scp[["proteins_imptd"]] |>
    assay() |>
    is.na() |>
    mean()

## ----get_proteins-------------------------------------------------------------
sce <- getWithColData(scp, "proteins_imptd")

## ----prepare_batch_correction-------------------------------------------------
batch <- sce$runCol
model <- model.matrix(~ SampleType, data = colData(sce))

## ----compute_batch_correction, results = 'hide', message = FALSE--------------
library(sva)
assay(sce) <- ComBat(dat = assay(sce),
                     batch = batch,
                     mod = model)

## ----add_batch_correction-----------------------------------------------------
scp <- addAssay(scp,
                y = sce,
                name = "proteins_batchC")
scp <- addAssayLinkOneToOne(scp,
                            from = "proteins_imptd",
                            to = "proteins_batchC")

## ----plot5--------------------------------------------------------------------
plot(scp)

## ----load_scater--------------------------------------------------------------
library(scater)

## -----------------------------------------------------------------------------
scp[["proteins_batchC"]] <- as(scp[["proteins_batchC"]], "SingleCellExperiment")

## ----run_PCA------------------------------------------------------------------
scp[["proteins_batchC"]] <- runPCA(scp[["proteins_batchC"]],
                                   ncomponents = 5,
                                   ntop = Inf,
                                   scale = TRUE,
                                   exprs_values = 1,
                                   name = "PCA")

## ----plot_PCA-----------------------------------------------------------------
plotReducedDim(scp[["proteins_batchC"]],
               dimred = "PCA",
               colour_by = "SampleType",
               point_alpha = 1)

## ----run_UMAP-----------------------------------------------------------------
scp[["proteins_batchC"]] <- runUMAP(scp[["proteins_batchC"]],
                                    ncomponents = 2,
                                    ntop = Inf,
                                    scale = TRUE,
                                    exprs_values = 1,
                                    n_neighbors = 3,
                                    dimred = "PCA",
                                    name = "UMAP")

## ----plot_UMAP----------------------------------------------------------------
plotReducedDim(scp[["proteins_batchC"]],
               dimred = "UMAP",
               colour_by = "SampleType",
               point_alpha = 1)

## ----monitor_plot, warning = FALSE, fig.width = 10, fig.height = 10, out.width = "100%"----
## Get the features related to Plastin-2 (P13796)
subsetByFeature(scp, "P13796") |>
    ## Format the `QFeatures` to a long format table
    longForm(colvars = c("runCol", "SampleType", "quantCols")) |>
    data.frame() |>
    ## This is used to preserve ordering of the samples and assays in ggplot2
    mutate(assay = factor(assay, levels = names(scp)),
           Channel = sub("Reporter.intensity.", "TMT-", quantCols),
           Channel = factor(Channel, levels = unique(Channel))) |>
    ## Start plotting
    ggplot(aes(x = Channel, y = value, group = rowname, col = SampleType)) +
    geom_point() +
    ## Plot every assay in a separate facet
    facet_wrap(facets = vars(assay), scales = "free_y", ncol = 3) +
    ## Annotate plot
    xlab("Channels") +
    ylab("Intensity (arbitrary units)") +
    ## Improve plot aspect
    theme(axis.text.x = element_text(angle = 90),
          strip.text = element_text(hjust = 0),
          legend.position = "bottom")

## ----setup2, include = FALSE--------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "",
    crop = NULL
)

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

