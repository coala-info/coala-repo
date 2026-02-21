# Code example from 'biodbChebi' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install('biodbChebi')

## ----results='hide'-----------------------------------------------------------
mybiodb <- biodb::newInst()

## -----------------------------------------------------------------------------
chebi <- mybiodb$getFactory()$createConn('chebi')

## -----------------------------------------------------------------------------
entries <- chebi$getEntry(c('2528', '17053', '15440'))

## -----------------------------------------------------------------------------
entries[[1]]$getFieldValue('smiles')

## -----------------------------------------------------------------------------
entries[[1]]$getFieldsAsDataframe()

## -----------------------------------------------------------------------------
mybiodb$entriesToDataframe(entries, fields=c('accession', 'formula',
    'molecular.mass', 'inchikey', 'kegg.compound.id'))

## -----------------------------------------------------------------------------
chebi$searchCompound(name='aspartic', max.results=3)

## -----------------------------------------------------------------------------
chebi$searchCompound(mass=133, mass.field='molecular.mass', mass.tol=0.3,
    max.results=3)

## -----------------------------------------------------------------------------
ids <- chebi$searchCompound(name='aspartic', mass=133,
    mass.field='molecular.mass', mass.tol=0.3, max.results=3)

## -----------------------------------------------------------------------------
mybiodb$entriesToDataframe(chebi$getEntry(ids), fields=c('accession',
    'molecular.mass', 'name'))

## -----------------------------------------------------------------------------
chebi$convCasToChebi(c('87605-72-9', '51-41-2'))

## -----------------------------------------------------------------------------
chebi$convCasToChebi('14215-68-0')

## -----------------------------------------------------------------------------
chebi$convInchiToChebi('InChI=1S/C8H11NO3/c9-4-8(12)5-1-2-6(10)7(11)3-5/h1-3,8,10-12H,4,9H2/t8-/m0/s1')

## -----------------------------------------------------------------------------
chebi$convInchiToChebi('MBDOYVRWFFCFHM-SNAWJCMRSA-N')

## -----------------------------------------------------------------------------
mybiodb$terminate()

## -----------------------------------------------------------------------------
sessionInfo()

