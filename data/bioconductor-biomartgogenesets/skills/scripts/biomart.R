# Code example from 'biomart' vignette. See references/ for full tutorial.

## ----eval = TRUE, echo = FALSE------------------------------------------------
library(knitr)
knitr::opts_chunk$set(
    error = FALSE,
    tidy  = FALSE,
    message = FALSE
)

## -----------------------------------------------------------------------------
system.file("scripts", "biomart_genesets.R", package = "BioMartGOGeneSets")

## -----------------------------------------------------------------------------
library(biomaRt)
ensembl = useEnsembl(biomart = "genes")
ensembl

## ----echo = FALSE-------------------------------------------------------------
ensembl = useEnsembl(biomart = "genes")

## ----eval = FALSE-------------------------------------------------------------
#  useEnsembl(biomart = "genes", mirror = "uswest")

## -----------------------------------------------------------------------------
datasets = listDatasets(ensembl)
dim(datasets)
head(datasets)

## -----------------------------------------------------------------------------
ensembl = useDataset(dataset = "hsapiens_gene_ensembl", mart = ensembl)
ensembl

## -----------------------------------------------------------------------------
all_at = listAttributes(mart = ensembl)
dim(all_at)
head(all_at)

## -----------------------------------------------------------------------------
at = c("ensembl_gene_id", "go_id", "namespace_1003")
go = getBM(attributes = at, mart = ensembl)

## -----------------------------------------------------------------------------
head(go)

## ----eval = FALSE-------------------------------------------------------------
#  genes = getBM(attributes = "ensembl_gene_id", mart = ensembl)[, 1]
#  go1 = getBM(attributes = at, mart = ensembl, filter = "ensembl_gene_id", value = genes[1:1000])
#  go2 = getBM(attributes = at, mart = ensembl, filter = "ensembl_gene_id", value = genes[1001:2000])
#  ...
#  rbind(go1, go2, ...)

## -----------------------------------------------------------------------------
go = go[go$namespace_1003 == "biological_process", , drop = FALSE]
gs = split(go$ensembl_gene_id, go$go_id)

## -----------------------------------------------------------------------------
library(GO.db)
bp_terms = GOID(GOTERM)[Ontology(GOTERM) == "BP"]
GOBPOFFSPRING = as.list(GOBPOFFSPRING)

## -----------------------------------------------------------------------------
gs2 = lapply(bp_terms, function(nm) {
  go_id = c(nm, GOBPOFFSPRING[[nm]]) # self + offspring
  unique(unlist(gs[go_id]))
})
names(gs2) = bp_terms
gs2 = gs2[sapply(gs2, length) > 0]

## ----echo = FALSE-------------------------------------------------------------
library(biomaRt)
library(GO.db)

## -----------------------------------------------------------------------------
sessionInfo()

