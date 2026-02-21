# Code example from 'STROMA4-vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'STROMA4-vignette.Rnw'

###################################################
### code chunk number 1: STROMA4-vignette.Rnw:44-48
###################################################
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
#BiocManager::install("STROMA4")
library("STROMA4")


###################################################
### code chunk number 2: STROMA4-vignette.Rnw:53-55
###################################################
library(breastCancerMAINZ)
data(mainz, package='breastCancerMAINZ')


###################################################
### code chunk number 3: STROMA4-vignette.Rnw:59-60
###################################################
head(fData(mainz)[, "Gene.symbol", drop=FALSE])


###################################################
### code chunk number 4: STROMA4-vignette.Rnw:72-74
###################################################
just.stromal.properties <- assign.properties(ESet=mainz, geneID.column="Gene.symbol",
                          genelists="Stroma4", n=10, mc.cores=1)


###################################################
### code chunk number 5: STROMA4-vignette.Rnw:81-83
###################################################
just.lehmann.properties <- assign.properties(ESet=mainz, geneID.column="Gene.symbol",
                          genelists="TNBCType", n=10, mc.cores=1)


###################################################
### code chunk number 6: STROMA4-vignette.Rnw:90-92
###################################################
all.properties <- assign.properties(ESet=mainz, geneID.column="Gene.symbol",
                genelists=c("Stroma4", "TNBCType"), n=10, mc.cores=1)


###################################################
### code chunk number 7: STROMA4-vignette.Rnw:100-102
###################################################
property.cols <- grepl('properties', pData(all.properties))
print(apply(pData(all.properties)[, property.cols], 2, table))


###################################################
### code chunk number 8: STROMA4-vignette.Rnw:111-121
###################################################
property.cols <- paste0(c('T', 'B', 'D', 'E'), '.stroma.property')
patient.subtypes <- pData(just.stromal.properties)[, property.cols]

for(i in c('T', 'B', 'D', 'E'))
  patient.subtypes[, paste0(i, '.stroma.property')] <-
    paste0(i, '-', patient.subtypes[, paste0(i, '.stroma.property')])

patient.subtypes <- apply(patient.subtypes, 1, paste, collapse='/')

print(head(patient.subtypes))


