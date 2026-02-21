# Code example from 'Enrichment' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  crop = NULL,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(TDbasedUFE)
library(TDbasedUFEadv)
library(DOSE)
library(enrichplot)
library(RTCGA.rnaseq)
library(RTCGA.clinical)
library(enrichR)
library(STRINGdb)

## -----------------------------------------------------------------------------
Multi <- list(
  BLCA.rnaseq[seq_len(100), 1 + seq_len(1000)],
  BRCA.rnaseq[seq_len(100), 1 + seq_len(1000)],
  CESC.rnaseq[seq_len(100), 1 + seq_len(1000)],
  COAD.rnaseq[seq_len(100), 1 + seq_len(1000)]
)
Z <- prepareTensorfromList(Multi, 10L)
Z <- aperm(Z, c(2, 1, 3))
Clinical <- list(BLCA.clinical, BRCA.clinical, CESC.clinical, COAD.clinical)
Multi_sample <- list(
  BLCA.rnaseq[seq_len(100), 1, drop = FALSE],
  BRCA.rnaseq[seq_len(100), 1, drop = FALSE],
  CESC.rnaseq[seq_len(100), 1, drop = FALSE],
  COAD.rnaseq[seq_len(100), 1, drop = FALSE]
)
# patient.stage_event.tnm_categories.pathologic_categories.pathologic_m
ID_column_of_Multi_sample <- c(770, 1482, 773, 791)
# patient.bcr_patient_barcode
ID_column_of_Clinical <- c(20, 20, 12, 14)
Z <- PrepareSummarizedExperimentTensor(
  feature = colnames(ACC.rnaseq)[1 + seq_len(1000)],
  sample = array("", 1), value = Z,
  sampleData = prepareCondTCGA(
    Multi_sample, Clinical,
    ID_column_of_Multi_sample, ID_column_of_Clinical
  )
)
HOSVD <- computeHosvd(Z)
cond <- attr(Z, "sampleData")
index <- selectFeatureProj(HOSVD, Multi, cond, de = 1e-3, input_all = 3) # Batch mode
head(tableFeatures(Z, index))
genes <- unlist(lapply(strsplit(tableFeatures(Z, index)[, 1], "|",
  fixed = TRUE
), "[", 1))
entrez <- unlist(lapply(strsplit(tableFeatures(Z, index)[, 1], "|",
  fixed = TRUE
), "[", 2))

## -----------------------------------------------------------------------------
setEnrichrSite("Enrichr")
websiteLive <- TRUE
dbs <- c(
  "GO_Molecular_Function_2021", "GO_Cellular_Component_2021",
  "GO_Biological_Process_2021"
)
enriched <- enrichr(genes, dbs)
if (websiteLive) {
  plotEnrich(enriched$GO_Biological_Process_2021,
    showTerms = 20, numChar = 40, y = "Count",
    orderBy = "P.value"
  )
}

## -----------------------------------------------------------------------------
options(timeout = 200)
string_db <- STRINGdb$new(
  version = "11.5",
  species = 9606, score_threshold = 200,
  network_type = "full", input_directory = ""
)
example1_mapped <- string_db$map(data.frame(genes = genes),
  "genes",
  removeUnmappedRows = TRUE
)
hits <- example1_mapped$STRING_id
string_db$plot_network(hits)

## -----------------------------------------------------------------------------
edo <- enrichDGN(entrez)
dotplot(edo, showCategory=30) + ggtitle("dotplot for ORA")

## -----------------------------------------------------------------------------
sessionInfo()

