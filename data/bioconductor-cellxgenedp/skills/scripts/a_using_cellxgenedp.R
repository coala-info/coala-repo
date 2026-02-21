# Code example from 'a_using_cellxgenedp' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# if (!"BiocManager" %in% rownames(installed.packages()))
#     install.packages("BiocManager", repos = "https://CRAN.R-project.org")
# BiocManager::install("cellxgenedp")

## ----eval = FALSE-------------------------------------------------------------
# if (!"remotes" %in% rownames(installed.packages()))
#     install.packages("remotes", repos = "https://CRAN.R-project.org")
# remotes::install_github("mtmorgan/cellxgenedp")

## ----eval = FALSE-------------------------------------------------------------
# pkgs <- c("tidyr", "zellkonverter", "SingleCellExperiment", "HDF5Array")
# required_pkgs <- pkgs[!pkgs %in% rownames(installed.packages())]
# BiocManager::install(required_pkgs)

## ----message = FALSE----------------------------------------------------------
library(zellkonverter)
library(SingleCellExperiment) # load early to avoid masking dplyr::count()
library(dplyr)
library(cellxgenedp)

## ----eval = FALSE-------------------------------------------------------------
# cxg()

## -----------------------------------------------------------------------------
db <- db()

## -----------------------------------------------------------------------------
db

## -----------------------------------------------------------------------------
collections(db)

datasets(db)

files(db)

## -----------------------------------------------------------------------------
collection_with_most_datasets <-
    datasets(db) |>
    count(collection_id, sort = TRUE) |>
    slice(1)

## -----------------------------------------------------------------------------
left_join(
    collection_with_most_datasets |> select(collection_id),
    collections(db),
    by = "collection_id"
) |> glimpse()

## -----------------------------------------------------------------------------
left_join(
    collection_with_most_datasets |> select(collection_id),
    datasets(db),
    by = "collection_id"
)

## -----------------------------------------------------------------------------
datasets(db) |>
    select(where(is.list))

## ----facets-------------------------------------------------------------------
facets(db, "assay")
facets(db, "self_reported_ethnicity")
facets(db, "sex")

## ----african_american_female--------------------------------------------------
african_american_female <-
    datasets(db) |>
    filter(
        facets_filter(assay, "ontology_term_id", "EFO:0009922"),
        facets_filter(self_reported_ethnicity, "label", "African American"),
        facets_filter(sex, "label", "female")
    )

## -----------------------------------------------------------------------------
african_american_female |>
    summarise(total_cell_count = sum(cell_count))

## -----------------------------------------------------------------------------
## collections
left_join(
    african_american_female |> select(collection_id) |> distinct(),
    collections(db),
    by = "collection_id"
)

## -----------------------------------------------------------------------------
title_of_interest <- paste(
    "A single-cell atlas of the healthy breast tissues reveals clinically",
    "relevant clusters of breast epithelial cells"
)
collection_of_interest <-
    collections(db) |>
    dplyr::filter(startsWith(name, title_of_interest))
collection_of_interest |>
    glimpse()

## -----------------------------------------------------------------------------
collection_id_of_interest <- pull(collection_of_interest, "collection_id")
publisher_metadata(db) |>
    filter(collection_id == collection_id_of_interest) |>
    glimpse()
authors(db) |>
    filter(collection_id == collection_id_of_interest)

## -----------------------------------------------------------------------------
external_links <- links(db)
external_links
external_links |>
    count(link_type)
external_links |>
    filter(collection_id == collection_id_of_interest)

## -----------------------------------------------------------------------------
doi_of_interest <- "https://doi.org/10.1016/j.stem.2018.12.011"
links(db) |>
    filter(link_url == doi_of_interest) |>
    left_join(collections(db), by = "collection_id") |>
    glimpse()

## ----eval = FALSE-------------------------------------------------------------
# african_american_female |>
#     ## use criteria to identify a single dataset (here just the
#     ## 'first' dataset), then visualize
#     slice(1) |>
#     datasets_visualize()

## ----selected_files-----------------------------------------------------------
selected_files <-
    left_join(
        african_american_female |> select(dataset_id),
        files(db),
        by = "dataset_id"
    )

## ----local_file_from_dataset_id-----------------------------------------------
local_file <-
    selected_files |>
    filter(
        dataset_id == "de985818-285f-4f59-9dbd-d74968fddba3",
        filetype == "H5AD"
    ) |>
    files_download(dry.run = FALSE)
basename(local_file)

## ----readH5AD-----------------------------------------------------------------
h5ad <- readH5AD(local_file, use_hdf5 = TRUE, reader = "R")
h5ad

## -----------------------------------------------------------------------------
h5ad |>
    colData(h5ad) |>
    as_tibble() |>
    count(sex, donor_id)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

