# Code example from 'curatedMetagenomicData' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
library(curatedMetagenomicData)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("curatedMetagenomicData")

## ----message = FALSE----------------------------------------------------------
library(dplyr)
library(DT)

## ----collapse = TRUE----------------------------------------------------------
sampleMetadata |>
    filter(study_name == "AsnicarF_2017") |>
    select(where(~ !any(is.na(.x)))) |>
    slice(1:10) |>
    select(1:10) |>
    datatable(options = list(dom = "t"), extensions = "Responsive")

## ----collapse = TRUE----------------------------------------------------------
curatedMetagenomicData("AsnicarF_20.+")

## ----collapse = TRUE, message = FALSE-----------------------------------------
curatedMetagenomicData("AsnicarF_2017.relative_abundance", dryrun = FALSE, rownames = "short")

## ----collapse = TRUE, message = FALSE-----------------------------------------
curatedMetagenomicData("AsnicarF_20.+.relative_abundance", dryrun = FALSE, counts = TRUE, rownames = "short")

## ----collapse = TRUE, message = FALSE-----------------------------------------
curatedMetagenomicData("AsnicarF_20.+.marker_abundance", dryrun = FALSE) |>
    mergeData()

## ----collapse = TRUE, message = FALSE-----------------------------------------
curatedMetagenomicData("AsnicarF_20.+.pathway_abundance", dryrun = FALSE) |>
    mergeData()

## ----collapse = TRUE, message = FALSE-----------------------------------------
curatedMetagenomicData("AsnicarF_20.+.relative_abundance", dryrun = FALSE, rownames = "short") |>
    mergeData()

## ----collapse = TRUE, message = FALSE-----------------------------------------
sampleMetadata |>
    filter(age >= 18) |>
    filter(!is.na(alcohol)) |>
    filter(body_site == "stool") |>
    select(where(~ !all(is.na(.x)))) |>
    returnSamples("relative_abundance", rownames = "short")

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(OmicsMLRepoR)
library(mia)
library(scater)
library(vegan)
library(stringr)
library(lefser)

## ----message = FALSE----------------------------------------------------------
cmd <- OmicsMLRepoR::getMetadata("cMD")

## -----------------------------------------------------------------------------
smoke <- cmd |> 
    filter(disease == "Healthy") |> 
    filter(age_group == "Adult") |>
    filter(!is.na(smoker)) |>
    filter(body_site == "feces") |>
    select(where(~ !all(is.na(.x))))  # remove metadata columns which are all `NA` values

## -----------------------------------------------------------------------------
table(smoke$smoker, useNA = "ifany")

## -----------------------------------------------------------------------------
smoke <- smoke %>%
  mutate(
    smoker_bin = as.factor(
      case_when(smoker == "Smoker (finding)" ~ "Smoker",
                smoker != "Non-smoker (finding);Never smoked tobacco (finding)" ~ "Never Smoker",
      )))

table(smoke$smoker_bin, useNA = "ifany")

## ----message = FALSE----------------------------------------------------------
smoke_tse <- smoke %>% returnSamples("relative_abundance", rownames = "short")

## Removing samples with NA values for smoker_bin
smoke_tse <- smoke_tse[,!is.na(smoke_tse$smoker_bin)]

## -----------------------------------------------------------------------------
smoke_tse_genus <- agglomerateByRank(smoke_tse, rank = "genus")

## ----fig.cap = "Alpha Diversity - Shannon Index (H')"-------------------------
## Adding Shannon diversity values to colData
smoke_shannon <- smoke_tse_genus |>
  addAlpha(assay.type = "relative_abundance", index = "shannon_diversity")

## Violin plots
title <- "Alpha Diversity by Smoking Status"
smoke_shannon |> 
    plotColData(x = "smoker_bin", y = "shannon_diversity", colour_by = "smoker_bin", shape_by = "smoker_bin") +
    labs(x = "Smoking Status", y = "Alpha Diversity (H')") + 
    guides(colour = guide_legend(title = "Smoking Status"), shape = guide_legend(title = title)) +
    theme(legend.position = "none")

## -----------------------------------------------------------------------------
## Test if alpha diversity between smokers and non-smokers is significantly different
wilcox.test(shannon_diversity ~ smoker_bin, data = colData(smoke_shannon))

## ----fig.cap = "Beta Diversity – Bray–Curtis PCoA"----------------------------
smoke_tse %>% 
  agglomerateByRanks() |>
    runMDS(FUN = vegdist, method = "bray", exprs_values = "relative_abundance", altexp = "genus", name = "BrayCurtis") |>
    plotReducedDim("BrayCurtis", colour_by = "smoker_bin", shape_by = "smoker_bin") +
    labs(x = "PCo 1", y = "PCo 2") +
    guides(colour = guide_legend(title = "Smoking Status"), shape = guide_legend(title = "Smoking Status")) +
    theme(legend.position = c(0.80, 0.25))

## -----------------------------------------------------------------------------
smoke_tse %>%
  agglomerateByRanks() |>
    runUMAP(exprs_values = "relative_abundance", altexp = "genus", name = "UMAP") |>
    plotReducedDim("UMAP", colour_by = "smoker_bin", shape_by = "smoker_bin") +
    labs(x = "UMAP 1", y = "UMAP 2") +
    guides(colour = guide_legend(title = "Smoking Status"), shape = guide_legend(title = "Smoking Status")) +
    theme(legend.position = c(0.80, 0.55))

## -----------------------------------------------------------------------------
lefser(
    relativeAb(smoke_tse_genus),
    kruskal.threshold = 0.05,
    wilcox.threshold = 0.05,
    lda.threshold = 2,
    classCol = "smoker_bin",
    subclassCol = NULL,
    assay = 1L,
    trim.names = FALSE,
    checkAbundances = TRUE
) %>%
    lefserPlot()

## ----eval = FALSE-------------------------------------------------------------
# convertToPhyloseq(alcoholStudy, assay.type = "relative_abundance")

## ----echo = FALSE-------------------------------------------------------------
utils::sessionInfo()

