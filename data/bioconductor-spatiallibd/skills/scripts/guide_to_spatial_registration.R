# Code example from 'guide_to_spatial_registration' vignette. See references/ for full tutorial.

## ----setup, include = FALSE-------------------------------------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE--------------------------------------------------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    R = citation(),
    BiocStyle = citation("BiocStyle")[1],
    knitr = citation("knitr")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    sessioninfo = citation("sessioninfo")[1],
    testthat = citation("testthat")[1],
    spatialLIBD = citation("spatialLIBD")[1],
    spatialLIBDpaper = citation("spatialLIBD")[2],
    tran2021 = RefManageR::BibEntry(
        bibtype = "Article",
        key = "tran2021",
        author = "Tran, Matthew N. and Maynard, Kristen R. and Spangler, Abby and Huuki, Louise A. and Montgomery, Kelsey D. and Sadashivaiah, Vijay and Tippani, Madhavi and Barry, Brianna K. and Hancock, Dana B. and Hicks, Stephanie C. and Kleinman, Joel E. and Hyde, Thomas M. and Collado-Torres, Leonardo and Jaffe, Andrew E. and Martinowich, Keri",
        title = "Single-nucleus transcriptome analysis reveals cell-type-specific molecular signatures across reward circuitry in the human brain",
        year = 2021, doi = "10.1016/j.neuron.2021.09.001",
        journal = "Neuron"
    )
)

## ----"citation"-------------------------------------------------------------------------------------------------------
## Citation info
citation("spatialLIBD")

## ----"install", eval = FALSE------------------------------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("spatialLIBD")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----"start", message=FALSE-------------------------------------------------------------------------------------------
library("spatialLIBD")
library("SingleCellExperiment")

## ----"fetch_refrence"-------------------------------------------------------------------------------------------------
## get reference layer enrichment statistics
layer_modeling_results <- fetch_data(type = "modeling_results")

layer_modeling_results$enrichment[1:5, 1:5]

## ----"download_sce_data"----------------------------------------------------------------------------------------------
# Download and save a local cache of the data available at:
# https://github.com/LieberInstitute/10xPilot_snRNAseq-human#processed-data
bfc <- BiocFileCache::BiocFileCache()
url <- paste0(
    "https://libd-snrnaseq-pilot.s3.us-east-2.amazonaws.com/",
    "SCE_DLPFC-n3_tran-etal.rda"
)
local_data <- BiocFileCache::bfcrpath(url, x = bfc)

load(local_data, verbose = TRUE)

## ----"check_cell_types"-----------------------------------------------------------------------------------------------
table(sce.dlpfc.tran$cellType)

## ----"donor_x_cellType"-----------------------------------------------------------------------------------------------
table(sce.dlpfc.tran$donor, sce.dlpfc.tran$cellType)

## ----"run_registration_wrapper"---------------------------------------------------------------------------------------
## Perform the spatial registration
sce_modeling_results <- registration_wrapper(
    sce = sce.dlpfc.tran,
    var_registration = "cellType",
    var_sample_id = "donor",
    gene_ensembl = "gene_id",
    gene_name = "gene_name"
)

## ----"extract_t_stats"------------------------------------------------------------------------------------------------
## check out table on enrichment t-statistics
sce_modeling_results$enrichment[1:5, 1:5]

## ----"layer_stat_cor"-------------------------------------------------------------------------------------------------
cor_layer <- layer_stat_cor(
    stats = sce_modeling_results$enrichment,
    modeling_results = layer_modeling_results,
    model_type = "enrichment",
    top_n = 100
)

cor_layer

## ----layer_cor_plot---------------------------------------------------------------------------------------------------
layer_stat_cor_plot(cor_layer)

## ----"annotate"-------------------------------------------------------------------------------------------------------
anno <- annotate_registered_clusters(
    cor_stats_layer = cor_layer,
    confidence_threshold = 0.25,
    cutoff_merge_ratio = 0.25
)

anno

## ----"plot_anno"------------------------------------------------------------------------------------------------------
layer_stat_cor_plot(
    cor_layer,
    query_colors = get_colors(clusters = rownames(cor_layer)),
    reference_colors = libd_layer_colors,
    annotation = anno,
    cluster_rows = FALSE,
    cluster_columns = FALSE
)

## ----createVignette, eval=FALSE---------------------------------------------------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("guide_to_spatial_registration.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("guide_to_spatial_registration.Rmd", tangle = TRUE)

## ----reproduce1, echo=FALSE-------------------------------------------------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE-------------------------------------------------------------------------------------------
## Processing time in seconds
totalTime <- diff(c(startTime, Sys.time()))
round(totalTime, digits = 3)

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()

## ----vignetteBiblio, results = "asis", echo = FALSE, warning = FALSE, message = FALSE---------------------------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

