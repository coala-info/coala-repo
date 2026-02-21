# Code example from 'b_case_studies' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----install, eval = FALSE----------------------------------------------------
# if (!"BiocManager" %in% rownames(installed.packages()))
#     install.packages("BiocManager", repos = "https://CRAN.R-project.org")
# BiocManager::install("cellxgenedp")

## ----setup, message = FALSE---------------------------------------------------
library(cellxgenedp)

## -----------------------------------------------------------------------------
author_datasets <- left_join(
    authors(),
    datasets(),
    by = "collection_id",
    relationship = "many-to-many"
)
author_datasets

## -----------------------------------------------------------------------------
author_datasets |>
    count(family, given, sort = TRUE)

## ----prolific authors---------------------------------------------------------
prolific_authors <-
    authors() |>
    count(family, given, sort = TRUE) |>
    slice(1:5)
prolific_authors

## ----prolific-author-datasets-------------------------------------------------
right_join(
    author_datasets,
    prolific_authors,
    by = c("family", "given")
)

## ----specific-authors---------------------------------------------------------
author_datasets |>
    filter(
        family %in% c("Teichmann", "Regev", "Haniffa")
    )

## ----authors-of-interest------------------------------------------------------
authors_of_interest <-
    tibble(
        family = c("Teichmann", "Regev", "Haniffa"),
        given = c("Sarah A.", "Aviv", "Muzlifah")
    )
right_join(
    author_datasets,
    authors_of_interest,
    by = c("family", "given")
)

## ----disease------------------------------------------------------------------
author_datasets |>
    select(family, given, dataset_id, disease)

## ----disease-facets-----------------------------------------------------------
facets(db(), "disease")

## ----disease-facet-filter-----------------------------------------------------
author_datasets |>
    filter(facets_filter(disease, "label", "COVID-19"))

## ----disease-facet-fitler-authors---------------------------------------------
author_datasets |>
    filter(facets_filter(disease, "label", "COVID-19")) |>
    count(family, given, sort = TRUE)

## ----disease-unnest-----------------------------------------------------------
author_dataset_diseases <-
    author_datasets |>
    select(family, given, dataset_id, disease) |>
    tidyr::unnest_longer(disease) |>
    tidyr::unnest_wider(disease)
author_dataset_diseases

## ----covid-19, eval = FALSE---------------------------------------------------
# author_dataset_diseases |>
#     filter(label == "COVID-19")
# 
# author_dataset_diseases |>
#     filter(label == "COVID-19") |>
#     count(family, given, sort = TRUE)

## -----------------------------------------------------------------------------
authors <- authors()
authors

## -----------------------------------------------------------------------------
nrow(authors) == nrow(distinct(authors))

## -----------------------------------------------------------------------------
authors |> 
    count(collection_id, family, given, consortium, sort = TRUE) |>
    filter(n > 1)

## -----------------------------------------------------------------------------
duplicate_authors <-
    collections() |>
    filter(collection_id == "e5f58829-1a66-40b5-a624-9046778e74f5")
duplicate_authors

## -----------------------------------------------------------------------------
publisher_metadata <-
    duplicate_authors |>
    pull(publisher_metadata)

## -----------------------------------------------------------------------------
names(publisher_metadata[[1]])

## -----------------------------------------------------------------------------
length(publisher_metadata[[1]][["authors"]])

## -----------------------------------------------------------------------------
deduplicated_authors <- distinct(authors)

## ----sessionInfo, echo = FALSE------------------------------------------------
sessionInfo()

