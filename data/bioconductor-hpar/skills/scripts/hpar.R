# Code example from 'hpar' vignette. See references/ for full tutorial.

## ----env, echo=FALSE----------------------------------------------------------
suppressPackageStartupMessages(library("dplyr"))
suppressPackageStartupMessages(library("BiocStyle"))
suppressPackageStartupMessages(library("org.Hs.eg.db"))
suppressPackageStartupMessages(library("GO.db"))

## ----install, eval = FALSE----------------------------------------------------
# ## install BiocManager only one
# install.packages("BiocManager")
# ## install hpar
# BiocManager::install("hpar")

## ----load---------------------------------------------------------------------
library("hpar")

## -----------------------------------------------------------------------------
hpa_data <- allHparData()

## ----echo=FALSE---------------------------------------------------------------
DT::datatable(hpa_data)

## -----------------------------------------------------------------------------
head(normtissue <- hpaNormalTissue())

## ----message = FALSE----------------------------------------------------------
library("ExperimentHub")
eh <- ExperimentHub()
query(eh, "hpar")

## ----hpaData------------------------------------------------------------------
names(normtissue)
## Number of genes
length(unique(normtissue$Gene))
## Number of cell types
length(unique(normtissue$Cell.type))
## Number of tissues
length(unique(normtissue$Tissue))

## Number of genes highlighly and reliably expressed in each cell type
## in each tissue.
library("dplyr")
normtissue |>
    filter(Reliability == "Approved",
           Level == "High") |>
    count(Cell.type, Tissue) |>
    arrange(desc(n)) |>
    head()

## ----getHpa-------------------------------------------------------------------
id <- "ENSG00000000003"
subcell <- hpaSubcellularLoc()
rna <- rnaGeneCellLine()

## Compine protein immunohistochemisty data, with the subcellular
## location and RNA expression levels.
filter(normtissue, Gene == id) |>
    full_join(filter(subcell, Gene == id)) |>
    full_join(filter(rna, Gene == id)) |>
    head()

## ----getHpa2, eval=FALSE------------------------------------------------------
# browseHPA(id)

## ----rel----------------------------------------------------------------------
getHpaVersion()
getHpaDate()
getHpaEnsembl()

## ----uc-hpar------------------------------------------------------------------
id <- "ENSG00000001460"
filter(subcell, Gene == id)

## ----uc-db--------------------------------------------------------------------
library("org.Hs.eg.db")
library("GO.db")
ans <- AnnotationDbi::select(org.Hs.eg.db, keys = id,
                             columns = c("ENSEMBL", "GO", "ONTOLOGY"),
                             keytype = "ENSEMBL")
ans <- ans[ans$ONTOLOGY == "CC", ]
ans
sapply(as.list(GOTERM[ans$GO]), slot, "Term")

## ----sessioninfo, echo = FALSE------------------------------------------------
sessionInfo()

