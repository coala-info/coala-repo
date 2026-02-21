# Code example from 'tomoseqr' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# # for bioconductor
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# 
# BiocManager::install("tomoseqr")

## ----setup, message = FALSE---------------------------------------------------
library(tomoseqr)

## -----------------------------------------------------------------------------
data(testx, testy, testz)
head(testx)

## ----eval = FALSE-------------------------------------------------------------
# tomoCache <- downloadJunker2014()
# junker2014 <- doadJunker2014(tomoCache)
# 
# sheldAV <- junker2014[["sheldAV"]]
# sheldVD <- junker2014[["sheldVD"]]
# sheldLR <- junker2014[["sheldLR"]]
# mask <- junker2014[["mask"]]

## -----------------------------------------------------------------------------
data(mask)

## ----eval = FALSE-------------------------------------------------------------
# masker()

## -----------------------------------------------------------------------------
tomoObj <- estimate3dExpressions(
    testx,
    testy,
    testz,
    mask = mask,
    query = c("gene1", "gene2", "gene3")
)

## ----eval = FALSE-------------------------------------------------------------
# imageViewer(tomoObj)

## -----------------------------------------------------------------------------
axialGeneTable <- findAxialGenes(testx)
print(axialGeneTable)

## -----------------------------------------------------------------------------
axialGeneTable <- findAxialGenes(testx, genes = c("gene1", "gene3"))
print(axialGeneTable)

## -----------------------------------------------------------------------------
sessionInfo()

