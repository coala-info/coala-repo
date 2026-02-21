# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(collapse = TRUE)

## -----------------------------------------------------------------------------
library(gep2pep)
suppressMessages(library(GSEABase))

## -----------------------------------------------------------------------------
## db <- importMSigDB.xml("msigdb_v6.1.xml")
## db <- as.CategorizedCollection(db)

## -----------------------------------------------------------------------------
db <- loadSamplePWS()

## -----------------------------------------------------------------------------
colltypes <- sapply(db, collectionType)
cats <- sapply(colltypes, attr, "category")
subcats <- sapply(colltypes, attr, "subCategory")
print(cats)
print(subcats)
makeCollectionIDs(db)

## ----collapse=TRUE------------------------------------------------------------
repoRoot <- file.path(tempdir(), "gep2pep_data")
rp <- createRepository(repoRoot, db)

## -----------------------------------------------------------------------------
rp
TFTsets <- loadCollection(rp, "c3_TFT")
TFTsets
description(TFTsets[["E47_01"]])

## -----------------------------------------------------------------------------
geps <- loadSampleGEP()
dim(geps)
geps[1:5, 1:3]

## ----collapse=TRUE------------------------------------------------------------
buildPEPs(rp, geps)

## -----------------------------------------------------------------------------
loadESmatrix(rp, "c3_TFT")[1:3, 1:3]
loadPVmatrix(rp, "c3_TFT")[1:3, 1:3]

## ----collapse=TRUE------------------------------------------------------------
pgset <- c("(+)_chelidonine", "(+/_)_catechin")
psea <- CondSEA(rp, pgset)

## -----------------------------------------------------------------------------
getResults(psea, "c3_TFT")

## -----------------------------------------------------------------------------
sets <- loadCollection(rp, "c3_MIR")
wM5012 <- which(sapply(sets, setIdentifier)=="M5012")
wM18759 <- which(sapply(sets, setIdentifier)=="M18759")

description(sets[[wM5012]])

description(sets[[wM18759]])

## ----eval=FALSE---------------------------------------------------------------
# exportSEA(rp, psea)

## ----collapse=TRUE------------------------------------------------------------
pathways <- c("M11607", "M10817", "M16694",         ## from c3_TFT
              "M19723", "M5038", "M13419", "M1094") ## from c4_CGN
w <- sapply(db, setIdentifier) %in% pathways
subdb <- db[w]

psea <- PathSEA(rp, subdb)

## -----------------------------------------------------------------------------
getResults(psea, "c3_TFT")

## -----------------------------------------------------------------------------
pathways <- gene2pathways(rp, "FAM126A")
pathways

## ----eval=F-------------------------------------------------------------------
# download.file("http://dsea.tigem.it/data/Cmap_MSigDB_v6.1_PEPs.tar.gz",
#   "Cmap_MSigDB_v6.1_PEPs.tar.gz")
# 
# untar("Cmap_MSigDB_v6.1_PEPs.tar.gz")
# 
# rpBig <- openRepository("Cmap_MSigDB_v6.1_PEPs")

## ----eval=F-------------------------------------------------------------------
# csea <- CondSEA(rpBig, c("scriptaid", "trichostatin_a", "valproic_acid",
#                       "vorinostat", "hc_toxin", "bufexamac"),
#                 collections=c("C5_BP", "C5_MF", "C5_CC"))
# ## [16:41:40] Working on collection: C5_BP
# ## [16:41:42] Common conditions removed from bgset
# ## [16:41:42] Row-ranking collection
# ## [16:41:48] Computing enrichments
# ## [16:41:58] done
# ## [16:41:58] Working on collection: C5_MF
# ## [16:41:58] Row-ranking collection
# ## [16:42:00] Computing enrichments
# ## [16:42:02] done
# ## [16:42:02] Working on collection: C5_CC
# ## [16:42:02] Row-ranking collection
# ## [16:42:03] Computing enrichments
# ## [16:42:04] done

## ----eval=F-------------------------------------------------------------------
# library(GSEABase)
# setids <- sapply(loadCollection(rpBig, "C5_MF"), setIdentifier)
# MFresults <- getResults(csea, "C5_MF")
# w <- match(rownames(MFresults)[1:10], setids)
# top10 <- loadCollection(rpBig, "C5_MF")[w]
# sapply(top10, setName)
# ##  [1] "GO_TRANSCRIPTION_FACTOR_ACTIVITY_PROTEIN_BINDING"
# ##  [2] "GO_TRANSCRIPTION_COACTIVATOR_ACTIVITY"
# ##  [3] "GO_PHOSPHATIDYLCHOLINE_1_ACYLHYDROLASE_ACTIVITY"
# ##  [4] "GO_RETINOIC_ACID_RECEPTOR_BINDING"
# ##  [5] "GO_PRE_MRNA_BINDING"
# ##  [6] "GO_N_ACETYLTRANSFERASE_ACTIVITY"
# ##  [7] "GO_CYTOSKELETAL_PROTEIN_BINDING"
# ##  [8] "GO_PEPTIDE_N_ACETYLTRANSFERASE_ACTIVITY"
# ##  [9] "GO_ACETYLTRANSFERASE_ACTIVITY"
# ## [10] "GO_HYDROGEN_EXPORTING_ATPASE_ACTIVITY"

## ----eval=F-------------------------------------------------------------------
# exportSEA(rpBig, csea)

## ----eval=F-------------------------------------------------------------------
# pws <- gene2pathways(rpBig, "TFEB")

## ----eval=F-------------------------------------------------------------------
# psea <- PathSEA(rpBig, pws, collections=c("C5_BP", "C5_MF", "C5_CC"))
# ## Warning: [17:17:13] There is at least one selected collections for
# ## which no pathway has been provided
# ## [17:17:13] Removing pathways not in specified collections
# ## [17:17:13] Working on collection: C5_BP
# ## [17:17:13] Common pathway sets removed from bgset
# ## [17:17:15] Column-ranking collection
# ## [17:17:22] Computing enrichments
# ## [17:17:29] done
# ## [17:17:29] Working on collection: C5_MF
# ## [17:17:29] Common pathway sets removed from bgset
# ## [17:17:29] Column-ranking collection
# ## [17:17:30] Computing enrichments
# ## [17:17:32] done

## ----eval=F-------------------------------------------------------------------
# getResults(psea, "C5_BP")[1:10,]
# ##                      ES           PV
# ## loperamide    0.7324720 1.504075e-11
# ## proadifen     0.7278256 2.079448e-11
# ## hydroquinine  0.7220082 3.110434e-11
# ## bepridil      0.6904276 2.616027e-10
# ## clomipramine  0.6891810 2.839879e-10
# ## alexidine     0.6741085 7.574142e-10
# ## digitoxigenin 0.6737685 7.741670e-10
# ## lanatoside_c  0.6651556 1.342553e-09
# ## helveticoside 0.6642112 1.425479e-09
# ## ouabain       0.6631157 1.527949e-09

## ----eval=F-------------------------------------------------------------------
# exportSEA(rpBig, psea)

## -----------------------------------------------------------------------------
rp$info("gep2pep repository")

## -----------------------------------------------------------------------------
rp

## -----------------------------------------------------------------------------
rp$info()

## ----collapse=TRUE------------------------------------------------------------
checkRepository(rp)

## ----include=FALSE------------------------------------------------------------
unlink(repoRoot, TRUE)

