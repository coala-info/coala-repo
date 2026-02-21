# Code example from 'mCSEAdata' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(mCSEAdata)
data(mcseadata)
data(bandTable)

## -----------------------------------------------------------------------------
class(betaTest)
dim(betaTest)
head(betaTest, 3)
class(phenoTest)
dim(phenoTest)
head(phenoTest, 3)
class(exprTest)
dim(exprTest)
head(exprTest, 3)

## -----------------------------------------------------------------------------
class(assocPromoters450k)
length(assocPromoters450k)
head(assocPromoters450k, 3)
class(assocGenes450k)
length(assocGenes450k)
head(assocGenes450k, 3)
class(assocCGI450k)
length(assocCGI450k)
head(assocCGI450k, 3)
class(assocPromotersEPIC)
length(assocPromotersEPIC)
head(assocPromotersEPIC, 3)
class(assocGenesEPIC)
length(assocGenesEPIC)
head(assocGenesEPIC, 3)
class(assocCGIEPIC)
length(assocCGIEPIC)
head(assocCGIEPIC, 3)
class(assocPromotersEPICv2)
length(assocPromotersEPICv2)
head(assocPromotersEPICv2, 3)
class(assocGenesEPICv2)
length(assocGenesEPICv2)
head(assocGenesEPICv2, 3)
class(assocCGIEPICv2)
length(assocCGIEPICv2)
head(assocCGIEPICv2, 3)

## ----message = FALSE----------------------------------------------------------
class(annot450K)
head(annot450K, 3)
class(annotEPIC)
head(annotEPIC, 3)
class(annotEPICv2)
head(annotEPICv2, 3)

## -----------------------------------------------------------------------------
head(bandTablehg19)
head(bandTablehg38)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

