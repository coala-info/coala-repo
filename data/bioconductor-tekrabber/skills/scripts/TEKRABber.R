# Code example from 'TEKRABber' vignette. See references/ for full tutorial.

## ----installation, eval=FALSE-------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("TEKRABber")

## ----load package, message=FALSE----------------------------------------------
library(TEKRABber)

## ----load built-in data (two species)-----------------------------------------
# load built-in data
data(speciesCounts)
hmGene <- speciesCounts$hmGene
hmTE <- speciesCounts$hmTE
chimpGene <- speciesCounts$chimpGene
chimpTE <- speciesCounts$chimpTE
# the first column must be Ensembl gene ID for gene, and TE name for TE
head(hmGene)

## ----search species name, eval=FALSE------------------------------------------
# # You can use the code below to search for species name
# ensembl <- biomaRt::useEnsembl(biomart = "genes")
# biomaRt::listDatasets(ensembl)

## ----orthology and normalizeation, message=FALSE------------------------------
# In order to save time, we provide the data for this tutorial.
# you can also uncomment the code below and run it for yourself.
data(fetchDataHmChimp)
fetchData <- fetchDataHmChimp

# Query the data and calculate scaling factor using orthologScale():
#' data(speciesCounts)
#' data(hg38_panTro6_rmsk) 
#' hmGene <- speciesCounts$hmGene
#' chimpGene <- speciesCounts$chimpGene
#' hmTE <- speciesCounts$hmTE
#' chimpTE <- speciesCounts$chimpTE
#' 
#' ## For demonstration, here we only select 1000 rows to save time
#' set.seed(1234)
#' hmGeneSample <- hmGene[sample(nrow(hmGene), 1000), ]
#' chimpGeneSample <- chimpGene[sample(nrow(chimpGene), 1000), ]
#' 
#' ## hg38_panTro6_rmsk = prepareRMSK("hg38", "panTro6")
#' fetchData <- orthologScale(
#'     speciesRef = "hsapiens",
#'     speciesCompare = "ptroglodytes",
#'     geneCountRef = hmGeneSample,
#'     geneCountCompare = chimpGeneSample,
#'     teCountRef = hmTE,
#'     teCountCompare = chimpTE,
#'     rmsk = hg38_panTro6_rmsk
#' )

## ----create input files, warning=FALSE----------------------------------------
inputBundle <- DECorrInputs(fetchData)

## ----DE analysis (two species), message=FALSE, results='hide', warning=FALSE----
meta <- data.frame(
    species = c(rep("human", ncol(hmGene) - 1), 
    rep("chimpanzee", ncol(chimpGene) - 1))
)

meta$species <- factor(meta$species, levels = c("human", "chimpanzee"))
rownames(meta) <- colnames(inputBundle$geneInputDESeq2)
hmchimpDE <- DEgeneTE(
    geneTable = inputBundle$geneInputDESeq2,
    teTable = inputBundle$teInputDESeq2,
    metadata = meta,
    expDesign = TRUE
)

## ----correlation (two species), warning=FALSE, eval=FALSE---------------------
# # we select the 200 rows of genes for demo
# hmCorrResult <- corrOrthologTE(
#     geneInput = hmchimpDE$geneCorrInputRef[c(1:200),],
#     teInput = hmchimpDE$teCorrInputRef,
#     numCore = 1,
#     corrMethod = "pearson",
#     padjMethod = "fdr"
# )
# 
# chimpCorrResult <- corrOrthologTE(
#     geneInput = hmchimpDE$geneCorrInputCompare[c(1:200), ],
#     teInput = hmchimpDE$teCorrInputCompare,
#     numCore = 1,
#     corrMethod = "pearson",
#     padjMethod = "fdr"
# )

## ----app visualize (two species), warning=FALSE, eval=FALSE-------------------
# remotes::install_github('rstudio/gridlayout')
# 
# library(plotly)
# library(bslib)
# library(shiny)
# library(gridlayout)
# 
# appTEKRABber(
#     corrRef = hmCorrResult,
#     corrCompare = chimpCorrResult,
#     DEobject = hmchimpDE
# )

## ----load built-in data (same species)----------------------------------------
# load built-in data
data(ctInputDE)
geneInputDE <- ctInputDE$gene
teInputDE <- ctInputDE$te

# you need to follow the input format as below
head(geneInputDE)

## ----DE analysis (same species), warning=FALSE, results='hide', message=FALSE----
metaExp <- data.frame(experiment = c(rep("control", 5), rep("treatment", 5)))
rownames(metaExp) <- colnames(geneInputDE)
metaExp$experiment <- factor(
    metaExp$experiment, 
    levels = c("control", "treatment")
)

resultDE <- DEgeneTE(
    geneTable = geneInputDE,
    teTable = teInputDE,
    metadata = metaExp,
    expDesign = FALSE
)

## ----correlation (same species), warning=FALSE, eval=FALSE--------------------
# controlCorr <- corrOrthologTE(
#     geneInput = resultDE$geneCorrInputRef[c(1:200),],
#     teInput = resultDE$teCorrInputRef,
#     numCore = 1,
#     corrMethod = "pearson",
#     padjMethod = "fdr"
# )
# 
# treatmentCorr <- corrOrthologTE(
#     geneInput = resultDE$geneCorrInputCompare[c(1:200),],
#     teInput = resultDE$teCorrInputCompare,
#     numCore = 1,
#     corrMethod = "pearson",
#     padjMethod = "fdr"
# )
# 
# head(treatmentCorr)

## ----app visualize (same species), warning=FALSE, eval=FALSE------------------
# remotes::install_github('rstudio/gridlayout')
# appTEKRABber(
#     corrRef = controlCorr,
#     corrCompare = treatmentCorr,
#     DEobject = resultDE
# )

## -----------------------------------------------------------------------------
sessionInfo()

