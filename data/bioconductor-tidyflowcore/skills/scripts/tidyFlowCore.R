# Code example from 'tidyFlowCore' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## Track vignette build time
startTime <- Sys.time()

## Bib setup
library(RefManageR)

## Write bibliography information
bib <- c(
    R = citation(),
    BiocStyle = citation("BiocStyle")[1],
    knitr = citation("knitr")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    sessioninfo = citation("sessioninfo")[1],
    testthat = citation("testthat")[1],
    tidyverse = citation("dplyr")[1],
    HDCytoData = citation("HDCytoData")[1],
    tidyFlowCore = citation("tidyFlowCore")[1]
)

## ----"install", eval = FALSE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#       install.packages("BiocManager")
#   }
# 
# BiocManager::install("tidyFlowCore")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----"citation"---------------------------------------------------------------
citation("tidyFlowCore")

## ----warning = FALSE----------------------------------------------------------
library(tidyFlowCore)
library(flowCore)

## ----example, eval = requireNamespace('tidyFlowCore')-------------------------
# read data from the HDCytoData package
bcr_flowset <- HDCytoData::Bodenmiller_BCR_XL_flowSet()

## ----eval = FALSE-------------------------------------------------------------
# ?HDCytoData::Bodenmiller_BCR_XL_flowSet

## -----------------------------------------------------------------------------
asinh_transformation <- flowCore::arcsinhTransform(a = 0, b = 1/5, c = 0)
transformation_list <- 
  flowCore::transformList(
    colnames(bcr_flowset), 
    asinh_transformation
  )

transformed_bcr_flowset <- flowCore::transform(bcr_flowset, transformation_list)

## -----------------------------------------------------------------------------
transformed_bcr_flowset <- 
  bcr_flowset |>
  dplyr::mutate(across(-ends_with("_id"), \(.x) asinh(.x / 5)))

## -----------------------------------------------------------------------------
# extract all expression matrices from our flowSet 
combined_matrix <- flowCore::fsApply(bcr_flowset, exprs)

# take out the concatenated population_id column 
combined_population_id <- combined_matrix[, 'population_id']

# perform the calculation
table(combined_population_id)

## -----------------------------------------------------------------------------
bcr_flowset |> 
  dplyr::count(population_id)

## -----------------------------------------------------------------------------
flowCore::pData(object = bcr_flowset)

## -----------------------------------------------------------------------------
bcr_flowset |> 
  # use the .tidyFlowCore_identifier pronoun to access the name of 
  # each experiment in the flowSet 
  dplyr::count(.tidyFlowCore_identifier, population_id)

## -----------------------------------------------------------------------------
# unnesting a flowSet results in a flowFrame with an additional column, 
# 'tidyFlowCore_name` that identifies cells based on which experiment in the 
# original flowSet they come from
bcr_flowset |> 
  dplyr::ungroup()

## -----------------------------------------------------------------------------
# flowSets can be unnested and re-nested for various analyses
bcr_flowset |> 
  dplyr::ungroup() |> 
  # group_by cell type
  dplyr::group_by(population_id) |> 
  # calculate the mean HLA-DR expression of each cell population
  dplyr::summarize(mean_hladr_expression = mean(`HLA-DR(Yb174)Dd`)) |> 
  dplyr::select(population_id, mean_hladr_expression)

## -----------------------------------------------------------------------------
# cell population names, from the HDCytoData documentation
population_names <- 
  c(
    "B-cells IgM-", 
    "B-cells IgM+", 
    "CD4 T-cells", 
    "CD8 T-cells", 
    "DC", 
    "monocytes", 			
    "NK cells", 			
    "surface-"
  )

# calculate mean CD20 expression across all cells
mean_cd20_expression <- 
  bcr_flowset |> 
  dplyr::ungroup() |> 
  dplyr::summarize(mean_expression = mean(asinh(`CD20(Sm147)Dd` / 5))) |> 
  dplyr::pull(mean_expression)

# calculate mean CD4 expression across all cells
mean_cd4_expression <- 
  bcr_flowset |> 
  dplyr::ungroup() |> 
  dplyr::summarize(mean_expression = mean(asinh(`CD4(Nd145)Dd` / 5))) |> 
  dplyr::pull(mean_expression)

bcr_flowset |> 
  # preprocess all columns that represent protein measurements
  dplyr::mutate(dplyr::across(-ends_with("_id"), \(.x) asinh(.x / 5))) |> 
  # plot a CD4 vs. CD45 scatterplot
  ggplot2::ggplot(ggplot2::aes(x = `CD20(Sm147)Dd`, y = `CD4(Nd145)Dd`)) +
  # add some reference lines
  ggplot2::geom_hline(
    yintercept = mean_cd4_expression, 
    color = "red", 
    linetype = "dashed"
  ) + 
  ggplot2::geom_vline(
    xintercept = mean_cd20_expression, 
    color = "red", 
    linetype = "dashed"
  ) + 
  ggplot2::geom_point(size = 0.1, alpha = 0.1) +
  # facet by cell population
  ggplot2::facet_wrap(
    facets = ggplot2::vars(population_id), 
    labeller = 
      ggplot2::as_labeller(
        \(population_id) population_names[as.numeric(population_id)]
      )
  ) + 
  # axis labels
  ggplot2::labs(
    x = "CD20 expression (arcsinh)", 
    y = "CD4 expression (arcsinh)"
  )

## ----createVignette, eval=FALSE-----------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("tidyFlowCore.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("tidyFlowCore.Rmd", tangle = TRUE)

## ----reproduce1, echo=FALSE---------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE---------------------------------------------------
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

