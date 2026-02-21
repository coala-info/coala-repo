# Code example from 'covRNA' vignette. See references/ for full tutorial.

## ----eval=FALSE, prompt=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("covRNA")

## ----eval=TRUE, message=FALSE, warning=FALSE, prompt=FALSE--------------------
library(covRNA)
data(Baca)

## -----------------------------------------------------------------------------
statBaca <- stat(ExprSet = Baca, npermut = 999, padjust = "BH", nrcor = 2, exprvar = 1)
# or
statBaca <- stat(L = exprs(Baca), R = fData(Baca), Q = pData(Baca), npermut = 999, 
                 padjust = "BH", nrcor = 2, exprvar = 1)

## ----eval=FALSE---------------------------------------------------------------
# ls(statBaca)
# adjp <- statBaca$adj.pvalue; adjp
# tests <- statBaca$stattest; tests

## -----------------------------------------------------------------------------
plot(statBaca, xnames = c('cold','ctrl','etoh','salt'), shiftx = -0.1)

## -----------------------------------------------------------------------------
ordBaca <- ord(Baca)

## -----------------------------------------------------------------------------
plot(ordBaca, feature = "variance")

## -----------------------------------------------------------------------------
vis(Stat = statBaca, Ord = ordBaca, rangex=1.5, rangey=1.5)

## ----eval=FALSE, prompt=TRUE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("biomaRt")
# library(biomaRt)

## ----eval=FALSE, prompt=TRUE--------------------------------------------------
# ensembl <- useEnsembl(biomart = "ensembl")
# listDatasets(ensembl)
# ensemblhuman <- useEnsembl(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")
# listAttributes(ensemblhuman)

