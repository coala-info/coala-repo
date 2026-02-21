# Code example from 'SBGNview.data.vignette' vignette. See references/ for full tutorial.

## ----echo = FALSE, eval = TRUE, results = 'hide', message = FALSE, warning = FALSE----
library(knitr)

## ----echo = TRUE, eval = TRUE, results = 'hide', message = FALSE, warning = FALSE----
library(SBGNview.data)
library(SummarizedExperiment)
data("IFNg","cancer.ds")
head(assays(IFNg)$counts)
IFNg$group

## ----echo = TRUE, eval = TRUE, results = 'hide', message = FALSE, warning = FALSE----
head(assays(cancer.ds)$counts)

## ----echo = TRUE, eval = TRUE, results = 'hide', message = FALSE, warning = FALSE----
# hsa ID <=> glyph ID
data(hsa_ENTREZID_pathwayCommons)
head(hsa_ENTREZID_pathwayCommons)

## ----echo = TRUE, eval = TRUE, results = 'hide', message = FALSE, warning = FALSE----
data(mmu_KO_ENTREZID)
# mmu ID <=> KO
head(mmu_KO_ENTREZID)
data(hsa_KO_ENTREZID)
# hsa ID <=> KO
head(hsa_KO_ENTREZID)

## ----echo = TRUE, eval = TRUE, results = 'hide', message = FALSE, warning = FALSE----
# Compound ID: chebi
data(chebi_pathwayCommons)
head(chebi_pathwayCommons)
data(chebi_pathway.id)
head(chebi_pathway.id)

