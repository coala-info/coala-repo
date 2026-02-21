# Code example from 'PSICQUIC' vignette. See references/ for full tutorial.

### R code from vignette source 'PSICQUIC.Rnw'

###################################################
### code chunk number 1: listProviders
###################################################
library(PSICQUIC)
psicquic <- PSICQUIC()
providers(psicquic)


###################################################
### code chunk number 2: queryMycTp53
###################################################
library(PSICQUIC)
psicquic <- PSICQUIC()
providers(psicquic)
tbl <- interactions(psicquic, id=c("TP53", "MYC"), species="9606")
dim(tbl)


###################################################
### code chunk number 3: sourceCount
###################################################
table(tbl$provider)


###################################################
### code chunk number 4: summaryCounts
###################################################
tbl[, c("provider", "type", "detectionMethod")]


###################################################
### code chunk number 5: taptag
###################################################
tbl[grep("affinity", tbl$detectionMethod), 
    c("type", "publicationID", "firstAuthor", "confidenceScore", "provider")]


###################################################
### code chunk number 6: broadTaptag
###################################################
tbl.myc <- interactions(psicquic, "MYC", species="9606", publicationID="21150319")


###################################################
### code chunk number 7: mycInteractorsExamined
###################################################
dim(tbl.myc)
table(tbl.myc$provider)
table(tbl.myc$confidenceScore)


###################################################
### code chunk number 8: addGeneNames
###################################################
idMapper <- IDMapper("9606")
tbl.myc <- addGeneInfo(idMapper,tbl.myc)
print(head(tbl.myc$A.name))
print(head(tbl.myc$B.name))


###################################################
### code chunk number 9: threeGenes
###################################################
tbl.3 <- interactions(psicquic, id=c("ALK", "JAK3", "SHC3"),
                      species="9606", quiet=TRUE)
tbl.3g <- addGeneInfo(idMapper, tbl.3)
tbl.3gd <- with(tbl.3g, as.data.frame(table(detectionMethod, type, A.name, B.name, provider)))
print(tbl.3gd <- subset(tbl.3gd, Freq > 0))


