# Code example from 'RefNet' vignette. See references/ for full tutorial.

### R code from vignette source 'RefNet.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: init
###################################################
library(RefNet)
refnet <- RefNet()
providers(refnet)


###################################################
### code chunk number 3: e2f3
###################################################
if("Biogrid" %in% unlist(providers(refnet), use.names=FALSE)){
   tbl.1 <- interactions(refnet, species="9606", id="E2F3", provider=c("gerstein-2012", "BioGrid"))
   dim(tbl.1)
   }


###################################################
### code chunk number 4: mapper
###################################################
if("IntAct" %in% unlist(providers(refnet), use.names=FALSE)){
   tbl.2 <- interactions(refnet, id="E2F3", provider="IntAct", species="9606")
   dim(tbl.2)
   idMapper <- IDMapper("9606")
   tbl.3 <- addStandardNames(idMapper, tbl.2)
   dim(tbl.3)
   tbl.3[, c("A.name", "B.name", "A.id", "B.id", "type", "provider")]
   }


###################################################
### code chunk number 5: mixedColumns
###################################################
if("Biogrid" %in% unlist(providers(refnet), use.names=FALSE)){
   tbl.4 <- interactions(refnet, id="ACO2", provider=c("gerstein-2012", "BioGrid"))
   tbl.5 <- addStandardNames(idMapper, tbl.4)
   sort(colnames(tbl.5))
   }


###################################################
### code chunk number 6: explore.e2f3
###################################################
if(exists("tbl.5")){
    dim(tbl.5)
    table(tbl.5$provider)
    }


###################################################
### code chunk number 7: xtab
###################################################
if(exists("tbl.5")){
   options(width=180)
   tbl.info <- with(tbl.5, as.data.frame(table(detectionMethod, type, provider)))
   tbl.info <- tbl.info[tbl.info$Freq>0,]
   tbl.info
   options(width=80)
   }


###################################################
### code chunk number 8: dups
###################################################
if("Biogrid" %in% unlist(providers(refnet), use.names=FALSE)){
   tbl.6 <- interactions(refnet, species="9606", id="E2F3", provider=c("gerstein-2012", "BioGrid"))
   tbl.7 <- addStandardNames(idMapper, tbl.6)
   tbl.withDups <- detectDuplicateInteractions(tbl.7)
   }


###################################################
### code chunk number 9: dupGroups
###################################################
if(exists("tbl.withDups")){
    options(width=180)
    table(tbl.withDups$dupGroup)
    subset(tbl.withDups, dupGroup==1)[, c("A.name", "B.name", "type", "detectionMethod", "publicationID")]
    options(width=80)
    }


###################################################
### code chunk number 10: pubmed
###################################################
noquote(pubmedAbstract("22580460", split=TRUE))


###################################################
### code chunk number 11: alias
###################################################
library(org.Hs.eg.db)
if(exists("tbl.withDups")){
   geneID <- unique(subset(tbl.withDups, A.common=="FZR1")$A.canonical)
   suppressWarnings(select(org.Hs.eg.db, keys=geneID, columns="ALIAS", keytype="ENTREZID"))
   }


###################################################
### code chunk number 12: eliminateDups
###################################################
providers <- intersect(unlist(providers(refnet), use.names=FALSE),
                       c("BIND", "BioGrid", "IntAct", "MINT",
                         "gerstein-2012"))
tbl.8 <- interactions(refnet, species="9606", id="E2F3", 
                      provider=providers)
tbl.9 <- addStandardNames(idMapper, tbl.8)
dim(tbl.9)


###################################################
### code chunk number 13: eliminateNonCanonicals
###################################################
removers <- with(tbl.9, unique(c(grep("^-$", A.id),
                               grep("^-$", B.id))))
if(length(removers) > 0)
    tbl.10 <- tbl.9[-removers,]
dim(tbl.10)


###################################################
### code chunk number 14: pickBestFromDups
###################################################
options(width=120)
table(tbl.10$type)


###################################################
### code chunk number 15: detectDups
###################################################
tbl.11 <- detectDuplicateInteractions(tbl.10)
dupGroups <- sort(unique(tbl.11$dupGroup))
preferred.types <- c("direct interaction",
                     "physical association",
                     "transcription factor binding")
bestOfDups <- unlist(lapply(dupGroups, function(dupGroup) 
                         pickBestFromDupGroup(dupGroup, tbl.11, preferred.types)))

deleters <- which(is.na(bestOfDups))
if(length(deleters) > 0)
    bestOfDups <- bestOfDups[-deleters]
length(bestOfDups)
tbl.12 <- tbl.11[bestOfDups,]
tbl.12[, c("A.name", "B.name", "type", "provider", "publicationID")]


###################################################
### code chunk number 16: sessionInfo
###################################################
toLatex(sessionInfo())


