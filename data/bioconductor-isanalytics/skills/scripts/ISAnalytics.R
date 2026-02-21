# Code example from 'ISAnalytics' vignette. See references/ for full tutorial.

## ----GenSetup, include = FALSE------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL
    ## Related to
    ## https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
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
    ISAnalytics = citation("ISAnalytics")[1],
    ClonalTrackingPaper = BibEntry(
        bibtype = "Article",
        title = paste(
            "Efficient gene editing of human long-term hematopoietic",
            "stem cells validated by clonal tracking"
        ),
        author = "Ferrari Samuele, Jacob Aurelien, Beretta Stefano",
        journaltitle = "Nat Biotechnol 38, 1298–1308",
        date = "2020-11",
        doi = "https://doi.org/10.1038/s41587-020-0551-y"
    )
)

ngs_exp_fig <- fs::path("../man", "figures", "ngs_data_exp.png")

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("ISAnalytics")

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# # The following initializes usage of Bioc devel
# BiocManager::install(version='devel')
# 
# BiocManager::install("ISAnalytics")

## ----eval=FALSE---------------------------------------------------------------
# if (!require(devtools)) {
#   install.packages("devtools")
# }
# devtools::install_github("calabrialab/ISAnalytics",
#                          ref = "RELEASE_3_21",
#                          dependencies = TRUE,
#                          build_vignettes = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!require(devtools)) {
#   install.packages("devtools")
# }
# devtools::install_github("calabrialab/ISAnalytics",
#                          ref = "devel",
#                          dependencies = TRUE,
#                          build_vignettes = TRUE)

## ----OptVerbose, eval=FALSE---------------------------------------------------
# # DISABLE
# options("ISAnalytics.verbose" = FALSE)
# 
# # ENABLE
# options("ISAnalytics.verbose" = TRUE)
# 

## ----OptWidg, eval=FALSE------------------------------------------------------
# # DISABLE HTML REPORTS
# options("ISAnalytics.reports" = FALSE)
# 
# # ENABLE HTML REPORTS
# options("ISAnalytics.reports" = TRUE)

## ----load-package-and-pecs-and-file-setup-------------------------------------
library(ISAnalytics)

# Set appropriate data and metadata specs ----
metadata_specs <- tibble::tribble(
    ~names, ~types, ~transform, ~flag, ~tag,
    "ProjectID", "char", NULL, "required", "project_id",
    "SubjectID", "char", NULL, "required", "subject",
    "Tissue", "char", NULL, "required", "tissue",
    "TimePoint", "int", NULL, "required", "tp_days",
    "CellMarker", "char", NULL, "required", "cell_marker",
    "ID", "char", NULL, "required", "pcr_repl_id",
    "SourceFileName", "char", NULL, "optional", NA_character_,
    "Link", "char", NULL, "optional", NA_character_
)
set_af_columns_def(metadata_specs)

mandatory_specs <- tibble::tribble(
    ~names, ~types, ~transform, ~flag, ~tag,
    "BarcodeSeq", "char", NULL, "required", NA_character_
)
set_mandatory_IS_vars(mandatory_specs)

# Files ----
data_folder <- tempdir()
utils::unzip(zipfile = system.file("testdata", 
                                   "testdata.zip",
                                   package = "ISAnalytics"), 
             exdir = data_folder, overwrite = TRUE)
meta_file <- "barcodes_example_af.tsv.xz"
matrix_file <- "GSE144340_Matrix_542.tsv.xz"

# Data import ----
af <- import_association_file(fs::path(data_folder, meta_file),
    report_path = NULL
)
af

matrix <- import_single_Vispa2Matrix(fs::path(data_folder, matrix_file),
    sample_names_to = "ID"
)
matrix

# Descriptive stats ----
desc_stats <- sample_statistics(matrix, af,
    sample_key = pcr_id_column(),
    value_columns = "Value"
)$metadata |>
    dplyr::rename(distinct_barcodes = "nIS")
desc_stats

# Aggregation and new stats ----
agg_key <- c("SubjectID")
agg <- aggregate_values_by_key(matrix, af,
    key = agg_key,
    group = "BarcodeSeq",
    join_af_by = pcr_id_column()
)
agg

agg_meta_functions <- tibble::tribble(
    ~Column, ~Function, ~Args, ~Output_colname,
    "TimePoint", ~ mean(.x, na.rm = TRUE), NA, "{.col}_avg",
    "CellMarker", ~ length(unique(.x)), NA, "distinct_cell_marker_count",
    "ID", ~ length(unique(.x)), NA, "distinct_id_count"
)
agg_meta <- aggregate_metadata(
    af,
    aggregating_functions = agg_meta_functions,
    grouping_keys = agg_key
)
agg_meta

agg_stats <- sample_statistics(agg, agg_meta,
    sample_key = agg_key,
    value_columns = "Value_sum"
)$metadata |>
    dplyr::rename(distinct_barcodes = "nIS")
agg_stats

# Abundance ----
abundance <- compute_abundance(agg, columns = "Value_sum", key = agg_key)
abundance

reset_dyn_vars_config()

## ----eval=FALSE---------------------------------------------------------------
# NGSdataExplorer()

## ----eval=FALSE---------------------------------------------------------------
# data("association_file")

## ----sessionInfo, echo = FALSE------------------------------------------------
sessionInfo()

## ----vignetteBiblio, results = "asis", echo = FALSE, warning = FALSE, message = FALSE----
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

