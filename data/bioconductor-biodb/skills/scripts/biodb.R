# Code example from 'biodb' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
source(system.file('vignettes_inc.R', package='biodb'))

## ----echo=FALSE, results='asis'-----------------------------------------------
insert_features_table()

## ----echo=FALSE, results='asis'-----------------------------------------------
make_vignette_ref('details')

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install('biodb')

## ----results='hide'-----------------------------------------------------------
mybiodb <- biodb::newInst()

## -----------------------------------------------------------------------------
compUrl <- system.file("extdata", "chebi_extract.tsv", package='biodb')
compdb <- mybiodb$getFactory()$createConn('comp.csv.file', url=compUrl)

## ----echo=FALSE, results='asis'-----------------------------------------------
make_vignette_ref('details')

## -----------------------------------------------------------------------------
mybiodb$getDbsInfo()

## -----------------------------------------------------------------------------
mybiodb$getDbsInfo()$get(c('comp.csv.file', 'mass.csv.file'))

## ----echo=FALSE, results='asis'-----------------------------------------------
make_vignette_ref('details')

## ----compTable, echo=FALSE, results='asis'------------------------------------
compDf <- read.table(compUrl, sep="\t", header=TRUE, quote="")
# Prevent RMarkdown from interpreting @ character as a reference:
compDf$smiles <- vapply(compDf$smiles, function(s) paste0('`', s, '`'), FUN.VALUE='')
knitr::kable(head(compDf), "pipe", caption="Excerpt from compound database TSV file.")

## -----------------------------------------------------------------------------
entries <- compdb$getEntry(c('1018', '1549', '64679'))
entries

## -----------------------------------------------------------------------------
entries[[1]]$getFieldsAsJson()

## -----------------------------------------------------------------------------
fields <- entries[[1]]$getFieldNames()
fields

## -----------------------------------------------------------------------------
mybiodb$getEntryFields()$get(fields)

## -----------------------------------------------------------------------------
entries[[1]]$getFieldValue('formula')

## -----------------------------------------------------------------------------
entryDf <- entries[[1]]$getFieldsAsDataframe()

## ----entryTable, echo=FALSE, results='asis'-----------------------------------
# Prevent RMarkdown from interpreting @ character as a reference:
entryDf$smiles <- vapply(entryDf$smiles, function(s) paste0('`', s, '`'), FUN.VALUE='')
knitr::kable(entryDf, "pipe", caption="Values of one entry of the compound database.")

## -----------------------------------------------------------------------------
entriesDf <- mybiodb$entriesToDataframe(entries)

## ----entriesTable, echo=FALSE, results='asis'---------------------------------
# Prevent RMarkdown from interpreting @ character as a reference:
entriesDf$smiles <- vapply(entriesDf$smiles, function(s) paste0('`', s, '`'), FUN.VALUE='')
knitr::kable(entriesDf, "pipe", caption="Values of a set of entries from the compound database.")

## -----------------------------------------------------------------------------
compdb$searchForEntries(list(name='deoxyguanosine'))

## -----------------------------------------------------------------------------
compdb$searchForEntries(list(name='guanosine', monoisotopic.mass=list(value=283.0917, delta=0.1)))

## -----------------------------------------------------------------------------
mybiodb$getEntryFields()$getFieldNames(type='mass')

## -----------------------------------------------------------------------------
mybiodb$getEntryFields()$get('nominal.mass')

## -----------------------------------------------------------------------------
compdb$isSearchableByField('average.mass')

## -----------------------------------------------------------------------------
compdb$getSearchableFields()

## -----------------------------------------------------------------------------
ms.tsv <- system.file("extdata", "ms.tsv", package='biodb')
mzdf <- read.table(ms.tsv, header=TRUE, sep="\t")

## ----mzdfTable, echo=FALSE, results='asis'------------------------------------
knitr::kable(mzdf, "pipe", caption="Input M/Z values.")

## -----------------------------------------------------------------------------
annotMz <- compdb$annotateMzValues(mzdf, mz.tol=1e-3, ms.mode='neg')

## ----annotMzTable, echo=FALSE, results='asis'---------------------------------
knitr::kable(annotMz, "pipe", caption="Annotation output.")

## -----------------------------------------------------------------------------
massUrl <- system.file("extdata", "massbank_extract_lcms_3.tsv", package='biodb')
massDb <- mybiodb$getFactory()$createConn('mass.csv.file', url=massUrl)

## ----lcms3Table, echo=FALSE, results='asis'-----------------------------------
massDf <- read.table(massUrl, sep="\t", header=TRUE, quote="")
knitr::kable(head(massDf), "pipe", caption="Excerpt from LCMS database TSV file.")

## -----------------------------------------------------------------------------
input <- data.frame(mz=c(73.01, 116.04, 174.2), rt=c(79, 173, 79))

## -----------------------------------------------------------------------------
annotMzRt <- massDb$searchMsPeaks(input, mz.tol=0.1, rt.unit='s', rt.tol=10, match.rt=TRUE, prefix='match.')

## ----annotMzRtTable, echo=FALSE, results='asis'-------------------------------
knitr::kable(head(annotMzRt), "pipe", caption="Results of annotation of an M/Z and RT input file with an LCMS database.")

## -----------------------------------------------------------------------------
msmsUrl <- system.file("extdata", "massbank_extract_msms.tsv", package='biodb')
msmsdb <- mybiodb$getFactory()$createConn('mass.csv.file', url=msmsUrl)

## ----msmsTable, echo=FALSE, results='asis'------------------------------------
msmsDf <- read.table(msmsUrl, sep="\t", header=TRUE, quote="")
knitr::kable(head(msmsDf), "pipe", caption="Excerpt from MS/MS database TSV file.")

## -----------------------------------------------------------------------------
input <- data.frame(mz=c(286.1456, 287.1488, 288.1514), rel.int=c(100, 45, 18))

## -----------------------------------------------------------------------------
matchDf <- msmsdb$msmsSearch(input, precursor.mz=286.1438, mz.tol=0.1, mz.tol.unit='plain', ms.mode='pos')

## ----msmsMatchingTable, echo=FALSE, results='asis'----------------------------
knitr::kable(head(matchDf), "pipe", caption="Results of running spectrum matching service on an MS/MS database.")

## ----vignettes, echo=FALSE, results='asis'------------------------------------
x <- biodbVignettes[, c('link', 'desc')]
names(x) <- c('Vignette', 'Description')
knitr::kable(x, "pipe", caption="List of *biodb* available vignettes with their short description.")

## -----------------------------------------------------------------------------
mybiodb$terminate()

## -----------------------------------------------------------------------------
sessionInfo()

