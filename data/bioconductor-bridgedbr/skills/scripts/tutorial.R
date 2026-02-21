# Code example from 'tutorial' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(BridgeDbR)

## -----------------------------------------------------------------------------
code <- getOrganismCode("Rattus norvegicus")
code

## -----------------------------------------------------------------------------
fullName <- getFullName("Ce")
fullName
code <- getSystemCode("ChEBI")
code

## -----------------------------------------------------------------------------
getMatchingSources("HMDB00555")
getMatchingSources("ENSG00000100030")

## ----eval=FALSE---------------------------------------------------------------
# getBridgeNames()

## ----eval=FALSE---------------------------------------------------------------
# dbLocation <- getDatabase("Rattus norvegicus", location = getwd())

## ----eval=FALSE---------------------------------------------------------------
# getwd()
# dbLocation <- ("/home/..../BridgeDb/wikidata_diseases.bridge")

## ----eval=FALSE---------------------------------------------------------------
# mapper <- loadDatabase(dbLocation)

## ----eval=FALSE---------------------------------------------------------------
# location <- getDatabase("Homo sapiens")
# mapper <- loadDatabase(location)
# map(mapper, "L", "196410", "X")

## ----eval=FALSE---------------------------------------------------------------
# location <- getDatabase("Homo sapiens")
# mapper <- loadDatabase(location)
# map(mapper, compactIdentifier="ncbigene:196410", "X")

## ----eval=FALSE---------------------------------------------------------------
# input <- data.frame(
#     source = rep("Ch", length(data[, 2])),
#     identifier = data[, 2]
# )
# wikidata <- maps(mapper, input, "Wd")

## ----eval=FALSE---------------------------------------------------------------
# ## Set the working directory to download the Metabolite mapping file
# location <- "data/metabolites.bridge"
# checkfile <- paste0(getwd(), "/", location)
# 
# ## Download the Metabolite mapping file (if it doesn't exist locally yet):
# if (!file.exists(checkfile)) {
#     download.file(
#         "https://figshare.com/ndownloader/files/26001794",
#         location
#     )
# }
# # Load the ID mapper:
# mapper <- BridgeDbR::loadDatabase(checkfile)

## ----eval=FALSE---------------------------------------------------------------
# map(mapper, "456", source = "Cs", target = "Ck")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

