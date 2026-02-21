# Code example from 'Introduction' vignette. See references/ for full tutorial.

params <-
list(demo_metadata = TRUE)

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)
root_dir <- knitr::opts_knit$get("root.dir")
if (!is.null(root_dir)){
    # This hack fixes the relative image paths. 
    # See https://github.com/rstudio/rmarkdown/issues/2473
    knitr::opts_knit$set(
        output.dir = root_dir
    )
}
proj_root <- rprojroot::find_package_root_file() |> normalizePath() 
# Utility function for figures to force them to have the correct path
find_figure <- function(names){
    rprojroot::find_package_root_file() |>
        file.path("man", "figures", names) 
}
METADATA_URL = if (params$demo_metadata)
        CuratedAtlasQueryR::SAMPLE_DATABASE_URL else
        CuratedAtlasQueryR::DATABASE_URL

## ----echo=FALSE, out.height = c("139px"), out.width = "120x"------------------
find_figure("logo.png") |> knitr::include_graphics()

## ----echo=FALSE, out.height = c("58px"), out.width = c("155x", "129px", "202px", "219px", "180px")----
c(
  "svcf_logo.jpeg", 
  "czi_logo.png", 
  "bioconductor_logo.jpg",
  "vca_logo.png",
  "nectar_logo.png"
) |> 
    find_figure() |>
    knitr::include_graphics()

## ----eval=FALSE---------------------------------------------------------------
# devtools::install_github("stemangiola/CuratedAtlasQueryR")

## ----message=FALSE, warning=FALSE---------------------------------------------
library(CuratedAtlasQueryR)

## -----------------------------------------------------------------------------
# Note: in real applications you should use the default value of remote_url 
metadata <- get_metadata(remote_url = METADATA_URL)
metadata

## -----------------------------------------------------------------------------
metadata |>
    dplyr::distinct(tissue, file_id) 

## -----------------------------------------------------------------------------
single_cell_counts = 
    metadata |>
    dplyr::filter(
        ethnicity == "African" &
        stringr::str_like(assay, "%10x%") &
        tissue == "lung parenchyma" &
        stringr::str_like(cell_type, "%CD4%")
    ) |>
    get_single_cell_experiment()

single_cell_counts

## -----------------------------------------------------------------------------
single_cell_counts = 
    metadata |>
    dplyr::filter(
        ethnicity == "African" &
        stringr::str_like(assay, "%10x%") &
        tissue == "lung parenchyma" &
        stringr::str_like(cell_type, "%CD4%")
    ) |>
    get_single_cell_experiment(assays = "cpm")

single_cell_counts

## -----------------------------------------------------------------------------
single_cell_counts = 
    metadata |>
    dplyr::filter(
        ethnicity == "African" &
        stringr::str_like(assay, "%10x%") &
        tissue == "lung parenchyma" &
        stringr::str_like(cell_type, "%CD4%")
    ) |>
    get_single_cell_experiment(assays = "cpm", features = "PUM1")

single_cell_counts

## -----------------------------------------------------------------------------
single_cell_counts_seurat = 
    metadata |>
    dplyr::filter(
        ethnicity == "African" &
        stringr::str_like(assay, "%10x%") &
        tissue == "lung parenchyma" &
        stringr::str_like(cell_type, "%CD4%")
    ) |>
    get_seurat()

single_cell_counts_seurat

## -----------------------------------------------------------------------------
single_cell_counts |> saveRDS("single_cell_counts.rds")

## -----------------------------------------------------------------------------
single_cell_counts |> HDF5Array::saveHDF5SummarizedExperiment("single_cell_counts", replace = TRUE)

## ----results='hide'-----------------------------------------------------------
suppressPackageStartupMessages({
    library(ggplot2)
})

# Plots with styling
counts <- metadata |>
  # Filter and subset
  dplyr::filter(cell_type_harmonised == "cd14 mono") |>
  dplyr::filter(file_id_db != "c5a05f23f9784a3be3bfa651198a48eb") |> 
  
  # Get counts per million for HCA-A gene
  get_single_cell_experiment(assays = "cpm", features = "HLA-A") |> 
  suppressMessages() |>
  
  # Add feature to table
  tidySingleCellExperiment::join_features("HLA-A", shape = "wide") |> 
    
  # Rank x axis
  tibble::as_tibble()

# Plot by disease
counts |>
  dplyr::with_groups(disease, ~ .x |> dplyr::mutate(median_count = median(`HLA.A`, rm.na=TRUE))) |> 
  
  # Plot
  ggplot(aes(forcats::fct_reorder(disease, median_count,.desc = TRUE), `HLA.A`,color = file_id)) +
  geom_jitter(shape=".") +
    
  # Style
  guides(color="none") +
  scale_y_log10() +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1)) + 
  xlab("Disease") + 
  ggtitle("HLA-A in CD14 monocytes by disease") 

## ----echo=FALSE---------------------------------------------------------------
find_figure("HLA_A_disease_plot.png") |> knitr::include_graphics()

## ----results='hide'-----------------------------------------------------------
# Plot by tissue
counts |> 
  dplyr::with_groups(tissue_harmonised, ~ .x |> dplyr::mutate(median_count = median(`HLA.A`, rm.na=TRUE))) |> 
  
  # Plot
  ggplot(aes(forcats::fct_reorder(tissue_harmonised, median_count,.desc = TRUE), `HLA.A`,color = file_id)) +
  geom_jitter(shape=".") +
    
  # Style
  guides(color="none") +
  scale_y_log10() +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1)) + 
  xlab("Tissue") + 
  ggtitle("HLA-A in CD14 monocytes by tissue") + 
  theme(legend.position = "none")

## ----echo=FALSE---------------------------------------------------------------
find_figure("HLA_A_tissue_plot.png") |> knitr::include_graphics()

## -----------------------------------------------------------------------------
metadata |> 
    
  # Filter and subset
  dplyr::filter(cell_type_harmonised=="nk") |> 

  # Get counts per million for HCA-A gene 
  get_single_cell_experiment(assays = "cpm", features = "HLA-A") |> 
  suppressMessages() |>

  # Plot
  tidySingleCellExperiment::join_features("HLA-A", shape = "wide") |> 
  ggplot(aes(tissue_harmonised, `HLA.A`, color = file_id)) +
  theme_bw() +
  theme(
      axis.text.x = element_text(angle = 60, vjust = 1, hjust = 1),
      legend.position = "none"
  ) + 
  geom_jitter(shape=".") + 
  xlab("Tissue") + 
  ggtitle("HLA-A in nk cells by tissue")

## -----------------------------------------------------------------------------
harmonised <- metadata |> dplyr::filter(tissue == "kidney blood vessel")
unharmonised <- get_unharmonised_metadata(harmonised)
unharmonised

## -----------------------------------------------------------------------------
dplyr::pull(unharmonised) |> head(2)

## -----------------------------------------------------------------------------
sessionInfo()

