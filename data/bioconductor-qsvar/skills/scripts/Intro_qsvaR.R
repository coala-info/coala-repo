# Code example from 'Intro_qsvaR' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    R = citation(),
    bsp2 = RefManageR::BibEntry(
        bibtype = "article",
        key = "bsp2",
        author = "Leonardo Collado-Torres and Emily E. Burke and Amy Peterson and JooHeon Shin and Richard E. Straub and Anandita Rajpurohit and Stephen A. Semick and William S. Ulrich and Amanda J. Price and Cristian Valencia and Ran Tao and Amy Deep-Soboslay and Thomas M. Hyde and Joel E. Kleinman and Daniel R. Weinberger and Andrew E. Jaffe",
        title = "Regional Heterogeneity in Gene Expression, Regulation, and Coherence in the Frontal Cortex and Hippocampus across Development and Schizophrenia",
        year = 2019, doi = "0.1016/j.neuron.2019.05.013", journal = "Neuron", month = "jul",
        publisher = "Elsevier BV",
        volume = "103",
        number = "2",
        pages = "203--216.e8",
    ),
    BiocFileCache = citation("BiocFileCache")[1],
    BiocStyle = citation("BiocStyle")[1],
    covr = citation("covr")[1],
    ggplot2 = citation("ggplot2")[1],
    knitr = citation("knitr")[1],
    limma = citation("limma")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    sessioninfo = citation("sessioninfo")[1],
    testthat = citation("testthat")[1],
    qsvaR = citation("qsvaR")[1],
    SummarizedExperiment = citation("SummarizedExperiment")[1],
    sva = citation("sva")[1]
)

## ----"install", eval = FALSE--------------------------------------------------
# ## To install Bioconductor packages
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("qsvaR")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()
# 
# ## You can install the development version from GitHub with:
# BiocManager::install("LieberInstitute/qsvaR")

## ----"citation"---------------------------------------------------------------
## Citation info
citation("qsvaR")

## ----"start", message=FALSE---------------------------------------------------
library("qsvaR")
library("limma")
library("BiocFileCache")

## ----DesignDiagram,fig.cap="The diagram on the right shows the 2016 experimental design for qSVA.The diagram on the right shows the 2022 experimental design for qSVA.", echo=FALSE----
knitr::include_graphics("../man/figures/qsva_experimental_design.png")

## ----"Download demo dataset"--------------------------------------------------
bfc <- BiocFileCache::BiocFileCache()

## Download brainseq phase 2 ##
rse_file <- BiocFileCache::bfcrpath(
    "https://s3.us-east-2.amazonaws.com/libd-brainseq2/rse_tx_unfiltered.Rdata",
    x = bfc
)
load(rse_file, verbose = TRUE)
## keep only adult samples and apply minimum expression cutoff
rse_tx <- rse_tx[, rse_tx$Age > 17]
rse_tx <- rse_tx[rowMeans(assays(rse_tx)$tpm) > 0.3, ]

## ----VennDiagram,fig.cap="The above venn diagram shows the overlap between transcripts in each of the previously mentioned models.", echo=FALSE----
knitr::include_graphics("../man/figures/transcripts_venn_diagramm.png")

## ----"Get Degraded Transcripts"-----------------------------------------------
# obtain transcripts with degradation signature
DegTx <- getDegTx(
  rse_tx, sig_transcripts = select_transcripts(cell_component = TRUE)
)
dim(DegTx)

## ----"getPCs demo"------------------------------------------------------------
pcTx <- getPCs(rse_tx = DegTx, assayname = "tpm")

## ----"k_qsvs demo"------------------------------------------------------------
# design a basic model matrix to model the number of pcs needed
mod <- model.matrix(~ Dx + Age + Sex + Race + Region,
    data = colData(rse_tx)
)

## To ensure that the results are reproducible, you will need to set a
## random seed with the set.seed() function. Internally, we are using
## sva::num.sv() which needs a random seed to ensure reproducibility of the
## results.
set.seed(20230621)

# use k qsvs function to return a integer of pcs needed
k <- k_qsvs(rse_tx = DegTx, mod = mod, assayname = "tpm")
print(k)

## ----"get_qsvs demo"----------------------------------------------------------
# get_qsvs use k to subset our pca analysis
qsvs <- get_qsvs(qsvPCs = pcTx, k = k)
dim(qsvs)

## ----"wrapper function"-------------------------------------------------------
## To ensure that the results are reproducible, you will need to set a
## random seed with the set.seed() function. Internally, we are using
## sva::num.sv() which needs a random seed to ensure reproducibility of the
## results.
set.seed(20230621)

## Example use of the wrapper function qSVA()
qsvs_wrapper <- qSVA(
    rse_tx = rse_tx,
    sig_transcripts = select_transcripts(cell_component = TRUE),
    mod = mod, 
    assayname = "tpm"
)
dim(qsvs_wrapper)

## ----"perform DE"-------------------------------------------------------------
# create a model.matrix with demographic info and qsvs
mod_qSVA <- cbind(mod, qsvs)

# log tranform transcript expression
txExprs <- log2(assays(rse_tx)$tpm + 1)

# linear model differential expression
fitTx <- lmFit(txExprs, mod_qSVA)

# generate empirical bayes for DE
eBTx <- eBayes(fitTx)

# get DE results table
sigTx <- topTable(eBTx,
    coef = 2,
    p.value = 1, number = nrow(rse_tx)
)
head(sigTx)

## ----"DE plot"----------------------------------------------------------------
# get expression for most significant gene
yy <- txExprs[rownames(txExprs) == rownames(sigTx)[1], ]

## Visualize the expression of this gene using boxplots
p <- boxplot(yy ~ rse_tx$Dx,
    outline = FALSE,
    ylim = range(yy), ylab = "log2 Exprs", xlab = "",
    main = paste(rownames(sigTx)[1])
)

## ----"perform DE without qSVs"------------------------------------------------
# log tranform transcript expression
txExprs_noqsv <- log2(assays(rse_tx)$tpm + 1)

# linear model differential expression with generic model
fitTx_noqsv <- lmFit(txExprs_noqsv, mod)

# generate empirical bayes for DE
eBTx_noqsv <- eBayes(fitTx_noqsv)

# get DE results table
sigTx_noqsv <- topTable(eBTx_noqsv,
    coef = 2,
    p.value = 1, number = nrow(rse_tx)
)

## Explore the top results
head(sigTx_noqsv)

## ----"subset to t-statistics"-------------------------------------------------
## Subset the topTable() results to keep just the t-statistic
DE_noqsv <- data.frame(t = sigTx_noqsv$t, row.names = rownames(sigTx_noqsv))
DE <- data.frame(t = sigTx$t, row.names = rownames(sigTx))

## Explore this data.frame()
head(DE)

## ----"Generate DEqual without qSVs",fig.cap="Result of Differential Expression without qSVA normalization."----
## Generate a DEqual() plot using the model results without qSVs
DEqual(DE_noqsv)

## ----"Generate DEqual with qSVs",fig.cap="Result of Differential Expression with qSVA normalization."----
## Generate a DEqual() plot using the model results with qSVs
DEqual(DE)

## ----createVignette, eval=FALSE-----------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("Intro_qsvaR.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("Intro_qsvaR.Rmd", tangle = TRUE)

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

