# Code example from 'details' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
source(system.file('vignettes_inc.R', package='biodb'))

## -----------------------------------------------------------------------------
mybiodb <- biodb::newInst()

## -----------------------------------------------------------------------------
mybiodb$terminate()

## -----------------------------------------------------------------------------
mybiodb <- biodb::newInst()

## -----------------------------------------------------------------------------
mybiodb$getConfig()

## -----------------------------------------------------------------------------
x <- mybiodb$getConfig()$listKeys()

## ----keysDf, echo=FALSE, results='asis'---------------------------------------
knitr::kable(x, "pipe", caption="List of keys with some of their parameters")

## -----------------------------------------------------------------------------
mybiodb$getConfig()$getDescription('useragent')

## -----------------------------------------------------------------------------
mybiodb$getConfig()$get('useragent')

## -----------------------------------------------------------------------------
mybiodb$getConfig()$set('useragent', 'My application ; wizard@of.oz')
mybiodb$getConfig()$get('useragent')

## -----------------------------------------------------------------------------
mybiodb$getConfig()$enable('offline')
mybiodb$getConfig()$disable('offline')

## -----------------------------------------------------------------------------
mybiodb$getConfig()$getDefaultValue('useragent')

## -----------------------------------------------------------------------------
mybiodb$getConfig()$getAssocEnvVar('useragent')

## -----------------------------------------------------------------------------
mybiodb$getDbsInfo()

## -----------------------------------------------------------------------------
mybiodb$getDbsInfo()$get('mass.csv.file')

## -----------------------------------------------------------------------------
compUrl <- system.file("extdata", "chebi_extract_custom.csv", package='biodb')
compdb <- mybiodb$getFactory()$createConn('comp.csv.file', url=compUrl)
compdb$setCsvSep(';')

## -----------------------------------------------------------------------------
compdb$getUnassociatedColumns()

## -----------------------------------------------------------------------------
compdb$getFieldsAndColumnsAssociation()

## -----------------------------------------------------------------------------
mybiodb$getFactory()$deleteConn(compdb)
compdb <- mybiodb$getFactory()$createConn('comp.csv.file', url=compUrl)
compdb$setCsvSep(';')
compdb$setField('accession', 'ID')
compdb$setField('kegg.compound.id', 'kegg')
compdb$setField('monoisotopic.mass', 'mass')
compdb$setField('molecular.mass', 'molmass')

## -----------------------------------------------------------------------------
compdb$getEntryIds()

## -----------------------------------------------------------------------------
compdb$getEntry('1018')$getFieldsAsDataframe()

## ----compTable, echo=FALSE, results='asis'------------------------------------
compDf <- read.table(compUrl, sep=";", header=TRUE, quote="")
# Prevent RMarkdown from interpreting @ character as a reference:
compDf$smiles <- vapply(compDf$smiles, function(s) paste0('`', s, '`'), FUN.VALUE='')
knitr::kable(head(compDf), "pipe", caption="Excerpt from compound database CSV file.")

## -----------------------------------------------------------------------------
mybiodb$getEntryFields()

## -----------------------------------------------------------------------------
mybiodb$getEntryFields()$getFieldNames()

## -----------------------------------------------------------------------------
mybiodb$getEntryFields()$get('monoisotopic.mass')

## -----------------------------------------------------------------------------
mybiodb$getPersistentCache()

## -----------------------------------------------------------------------------
biodb::getLogger()

## -----------------------------------------------------------------------------
biodb::logInfo("%d entries have been processed.", 12)

## -----------------------------------------------------------------------------
biodb::logDebug("The file %s has been written.", 'myfile.txt')

## -----------------------------------------------------------------------------
biodb::logTrace("%d bytes written.", 1284902)

## -----------------------------------------------------------------------------
biodb::getLogger()$set_threshold(300)

## -----------------------------------------------------------------------------
biodb::logInfo("hello")

## -----------------------------------------------------------------------------
biodb::getLogger()$set_threshold(400)

## -----------------------------------------------------------------------------
biodb::logInfo("hello")

## -----------------------------------------------------------------------------
mybiodb$terminate()

## -----------------------------------------------------------------------------
sessionInfo()

