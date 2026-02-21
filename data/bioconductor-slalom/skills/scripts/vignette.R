# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----knitr-options, echo=FALSE, message=FALSE, warning=FALSE------------------
## To render an HTML version that works nicely with github and web pages, do:
## rmarkdown::render("vignettes/vignette.Rmd", "all")
library(knitr)
opts_chunk$set(fig.align = 'center', fig.width = 6, fig.height = 5, dev = 'png')
# library(ggplot2)
# theme_set(theme_bw(12))

## ----quickstart-load-data, message=FALSE, warning=FALSE-----------------------
library(slalom)
data("mesc")

## ----quickstart-make-sce, message=FALSE, warning=FALSE------------------------
exprs_matrix <- SingleCellExperiment::logcounts(mesc)
mesc <- SingleCellExperiment::SingleCellExperiment(
    assays = list(logcounts = exprs_matrix)
)


## ----quickstart-load-genesets, message=FALSE, warning=FALSE-------------------
gmtfile <- system.file("extdata", "reactome_subset.gmt", package = "slalom")
genesets <- GSEABase::getGmt(gmtfile)

## ----quickstart-new-slalom-model, message=FALSE, warning=FALSE----------------
model <- newSlalomModel(mesc, genesets, n_hidden = 5, min_genes = 10)

## ----quickstart-init, message=FALSE, warning=FALSE----------------------------
model <- initSlalom(model)

## ----quickstart-train, message=FALSE, warning=FALSE---------------------------
model <- trainSlalom(model, nIterations = 10)

## ----input-sce, message=FALSE, warning=FALSE----------------------------------
rdsfile <- system.file("extdata", "sim_N_20_v3.rds", package = "slalom")
sim <- readRDS(rdsfile)
sce <- SingleCellExperiment::SingleCellExperiment(
    assays = list(logcounts = sim[["init"]][["Y"]])
)

## ----input-genesets, message=FALSE, warning=FALSE-----------------------------
gmtfile <- system.file("extdata", "reactome_subset.gmt", package = "slalom")
genesets <- GSEABase::getGmt(gmtfile)

## ----input-names--------------------------------------------------------------
genesets <- GSEABase::GeneSetCollection(
    lapply(genesets, function(x) {
        GSEABase::setName(x) <- gsub("REACTOME_", "", GSEABase::setName(x))
        GSEABase::setName(x) <- strtrim(GSEABase::setName(x), 30)
        x
    })
)
rownames(sce) <- unique(unlist(GSEABase::geneIds(genesets[1:20])))[1:500]
colnames(sce) <- 1:ncol(sce)

## ----new-model----------------------------------------------------------------
m <- newSlalomModel(sce, genesets[1:23], n_hidden = 1, min_genes = 1)

## ----init-slalom--------------------------------------------------------------
m <- initSlalom(m, pi_prior = sim[["init"]][["Pi"]], n_hidden = 1, seed = 222)

## ----train-slalom-------------------------------------------------------------
mm <- trainSlalom(m, minIterations = 400, nIterations = 5000, shuffle = TRUE,
                  pretrain = TRUE, seed = 222)

## ----topterms-----------------------------------------------------------------
topTerms(m)

## ----plot-relevance-----------------------------------------------------------
plotRelevance(m)

## ----plot-terms---------------------------------------------------------------
plotTerms(m)

## ----plot-loadings------------------------------------------------------------
plotLoadings(m, "CELL_CYCLE")

## ----addtosce-----------------------------------------------------------------
sce <- addResultsToSingleCellExperiment(sce, m)

## ----session-info-------------------------------------------------------------
sessionInfo()

