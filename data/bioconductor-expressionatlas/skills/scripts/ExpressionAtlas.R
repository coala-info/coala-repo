# Code example from 'ExpressionAtlas' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
suppressMessages( library( ExpressionAtlas ) )

## ----eval=FALSE---------------------------------------------------------------
# atlasRes <- searchAtlasExperiments( properties = "salt", species = "oryza" )
# # Searching for Expression Atlas experiments matching your query ...
# # Query successful.
# # Found 16 experiments matching your query.

## ----echo=FALSE---------------------------------------------------------------
data( "atlasRes" )

## -----------------------------------------------------------------------------
atlasRes

## ----eval=FALSE---------------------------------------------------------------
# allExps <- getAtlasData( atlasRes$Accession )
# # Downloading Expression Atlas experiment summary from:
# #  ftp://ftp.ebi.ac.uk/pub/databases/microarray/data/atlas/experiments/E-GEOD-11175/E-GEOD-11175-atlasExperimentSummary.Rdata
# # Successfully downloaded experiment summary object for E-GEOD-11175
# # Downloading Expression Atlas experiment summary from:
# #  ftp://ftp.ebi.ac.uk/pub/databases/microarray/data/atlas/experiments/E-MTAB-1625/E-MTAB-1625-atlasExperimentSummary.Rdata
# # Successfully downloaded experiment summary object for E-MTAB-1625
# # Downloading Expression Atlas experiment summary from:
# #  ftp://ftp.ebi.ac.uk/pub/databases/microarray/data/atlas/experiments/E-MTAB-1624/E-MTAB-1624-atlasExperimentSummary.Rdata
# # Successfully downloaded experiment summary object for E-MTAB-1624

## ----echo=FALSE---------------------------------------------------------------
data( "allExps" )

## -----------------------------------------------------------------------------
allExps

## ----eval=FALSE---------------------------------------------------------------
# rnaseqExps <- getAtlasData(
#     atlasRes$Accession[
#         grep(
#             "rna-seq",
#             atlasRes$Type,
#             ignore.case = TRUE
#         )
#     ]
# )
# # Downloading Expression Atlas experiment summary from:
# #  ftp://ftp.ebi.ac.uk/pub/databases/microarray/data/atlas/experiments/E-MTAB-1625/E-MTAB-1625-atlasExperimentSummary.Rdata
# # Successfully downloaded experiment summary object for E-MTAB-1625

## ----echo=FALSE---------------------------------------------------------------
data( "rnaseqExps" )

## -----------------------------------------------------------------------------
rnaseqExps

## -----------------------------------------------------------------------------
mtab1624 <- allExps[[ "E-MTAB-1624" ]]
mtab1625 <- allExps[[ "E-MTAB-1625" ]]

## -----------------------------------------------------------------------------
sumexp <- mtab1625$rnaseq
sumexp

## -----------------------------------------------------------------------------
head( assays( sumexp )$counts )

## -----------------------------------------------------------------------------
colData( sumexp )

## -----------------------------------------------------------------------------
metadata( sumexp )

## -----------------------------------------------------------------------------
names( mtab1624 )
affy126data <- mtab1624[[ "A-AFFY-126" ]]
affy126data

## -----------------------------------------------------------------------------
head( exprs( affy126data ) )

## -----------------------------------------------------------------------------
pData( affy126data )

## -----------------------------------------------------------------------------
preproc( experimentData( affy126data ) )

## ----eval=FALSE---------------------------------------------------------------
# mtab3007 <- getAtlasExperiment( "E-MTAB-3007" )
# # Downloading Expression Atlas experiment summary from:
# #  ftp://ftp.ebi.ac.uk/pub/databases/microarray/data/atlas/experiments/E-MTAB-3007/E-MTAB-3007-atlasExperimentSummary.Rdata
# # Successfully downloaded experiment summary object for E-MTAB-3007

