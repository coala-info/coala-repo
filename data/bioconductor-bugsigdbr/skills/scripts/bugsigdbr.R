# Code example from 'bugsigdbr' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL
)

## ----"start", message=FALSE---------------------------------------------------
library(bugsigdbr)

## ----getBugSigDB, message = FALSE---------------------------------------------
bsdb <- importBugSigDB()
dim(bsdb)
colnames(bsdb)

## -----------------------------------------------------------------------------
us.obesity.feces <- subset(bsdb,
                           `Location of subjects` == "United States of America" &
                           Condition == "obesity" &
                           `Body site` == "feces")

## ----getSignatures------------------------------------------------------------
sigs <- getSignatures(bsdb)
length(sigs)
sigs[1:3]

## ----getSignaturesMP----------------------------------------------------------
mp.sigs <- getSignatures(bsdb, tax.id.type = "metaphlan")
mp.sigs[1:3]

## ----getSignaturesTN----------------------------------------------------------
tn.sigs <- getSignatures(bsdb, tax.id.type = "taxname")
tn.sigs[1:3]

## ----getSignaturesGN----------------------------------------------------------
gn.sigs <- getSignatures(bsdb, 
                         tax.id.type = "taxname",
                         tax.level = "genus")
gn.sigs[1:3]

## ----getSignaturesSP----------------------------------------------------------
gn.sigs <- getSignatures(bsdb, 
                         tax.id.type = "taxname",
                         tax.level = "species")
gn.sigs[1:3]

## ----getSignaturesExact-------------------------------------------------------
gn.sigs <- getSignatures(bsdb, 
                         tax.id.type = "taxname",
                         tax.level = "genus",
                         exact.tax.level = FALSE)
gn.sigs[1:3]

## ----writeGMT-----------------------------------------------------------------
writeGMT(sigs, gmt.file = "bugsigdb_signatures.gmt")

## ----echo = FALSE, results = "hide"-------------------------------------------
file.remove("bugsigdb_signatures.gmt")

## ----browseSig----------------------------------------------------------------
browseSignature(names(sigs)[1])

## ----browseTaxon--------------------------------------------------------------
browseTaxon(sigs[[1]][1])

## ----getEfo-------------------------------------------------------------------
efo <- getOntology("efo")
efo

## ----getUberon----------------------------------------------------------------
uberon <- getOntology("uberon")
uberon

## ----subsetByEfo--------------------------------------------------------------
sdf <- subsetByOntology(bsdb,
                        column = "Condition",
                        term = "cancer",
                        ontology = efo)
dim(sdf)
table(sdf[,"Condition"])

## ----subsetByUberon-----------------------------------------------------------
sdf <- subsetByOntology(bsdb,
                        column = "Body site",
                        term = "digestive system",
                        ontology = uberon)
dim(sdf)
table(sdf[,"Body site"])

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

