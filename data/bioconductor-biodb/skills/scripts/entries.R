# Code example from 'entries' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
source(system.file('vignettes_inc.R', package='biodb'))

## ----echo=FALSE, results='asis'-----------------------------------------------
make_vignette_ref('details')

## -----------------------------------------------------------------------------
mybiodb <- biodb::BiodbMain$new()

## -----------------------------------------------------------------------------
chebi.tsv <- system.file("extdata", "chebi_extract.tsv", package='biodb')

## -----------------------------------------------------------------------------
chebi <- mybiodb$getFactory()$createConn('comp.csv.file', url=chebi.tsv)

## -----------------------------------------------------------------------------
chebi$getEntryIds()

## -----------------------------------------------------------------------------
chebi$getEntryIds(max.results=3)

## -----------------------------------------------------------------------------
chebi$searchForEntries(list(name='deoxyguanosine'))

## -----------------------------------------------------------------------------
chebi$searchForEntries(list(monoisotopic.mass=list(value=283.0917, delta=0.1)))

## -----------------------------------------------------------------------------
chebi$searchForEntries(list(name='guanosine', monoisotopic.mass=list(value=283.0917, delta=0.1)))

## -----------------------------------------------------------------------------
ids <- chebi$searchForEntries(list(monoisotopic.mass=list(value=283.0917, delta=0.1)), max.results=2)

## -----------------------------------------------------------------------------
chebi$getEntry(ids)

## -----------------------------------------------------------------------------
e <- chebi$getEntry(ids[[1]])

## -----------------------------------------------------------------------------
e$getFieldNames()

## -----------------------------------------------------------------------------
e$getFieldValue('name')

## -----------------------------------------------------------------------------
e$getFieldsByType('mass')

## -----------------------------------------------------------------------------
mybiodb$getEntryFields()$get('monoisotopic.mass')

## -----------------------------------------------------------------------------
x <- e$getFieldsAsDataframe()

## ----entryToDf, echo=FALSE, results='asis'------------------------------------
knitr::kable(head(x), "pipe", caption="Converting an entry to a data frame")

## -----------------------------------------------------------------------------
x <- e$getFieldsAsDataframe(fields=c('name', 'monoisotopic.mass'))

## ----filterByName, echo=FALSE, results='asis'---------------------------------
knitr::kable(head(x), "pipe", caption="Selecting fields by names")

## -----------------------------------------------------------------------------
x <- e$getFieldsAsDataframe(fields.type='mass')

## ----filterByType, echo=FALSE, results='asis'---------------------------------
knitr::kable(head(x), "pipe", caption="Selecting fields by type")

## -----------------------------------------------------------------------------
massSqliteFile <- system.file("extdata", "generated", "massbank_extract_full.sqlite", package='biodb')
massbank <- mybiodb$getFactory()$createConn('mass.sqlite', url=massSqliteFile)
massbankEntry <- massbank$getEntry('KNA00776')

## -----------------------------------------------------------------------------
x <- massbankEntry$getFieldsAsDataframe(only.card.one=TRUE)

## ----filterCardOne, echo=FALSE, results='asis'--------------------------------
knitr::kable(head(x), "pipe", caption="Selecting fields with only one value")

## -----------------------------------------------------------------------------
x <- massbankEntry$getFieldsAsDataframe(only.card.one=FALSE)

## ----concatenated, echo=FALSE, results='asis'---------------------------------
knitr::kable(head(x), "pipe", caption="Concatenate multiple values")

## -----------------------------------------------------------------------------
x <- massbankEntry$getFieldsAsDataframe(only.card.one=FALSE, flatten=FALSE)

## ----onePerLine, echo=FALSE, results='asis'-----------------------------------
knitr::kable(head(x), "pipe", caption="Output one value per row")

## -----------------------------------------------------------------------------
x <- massbankEntry$getFieldsAsDataframe(only.card.one=FALSE, limit=1)

## ----oneValuePerField, echo=FALSE, results='asis'-----------------------------
knitr::kable(head(x), "pipe", caption="Output only one value for each field")

## -----------------------------------------------------------------------------
entries <- chebi$getEntry(chebi$getEntryIds(max.results=3))
x <- mybiodb$entriesToDataframe(entries)

## ----entriesToDf, echo=FALSE, results='asis'----------------------------------
knitr::kable(head(x), "pipe", caption="Converting a list of entries into a data frame")

## -----------------------------------------------------------------------------
mybiodb$entriesToJson(entries)

## -----------------------------------------------------------------------------
chebi$deleteAllEntriesFromVolatileCache()

## -----------------------------------------------------------------------------
chebi$deleteAllEntriesFromPersistentCache()

## -----------------------------------------------------------------------------
chebi$deleteWholePersistentCache()

## -----------------------------------------------------------------------------
sqliteOutputFile <- tempfile(pattern="biodb_copy_entries_new_db", fileext='.sqlite')
newDbConn <- mybiodb$getFactory()$createConn('comp.sqlite', url=sqliteOutputFile)

## -----------------------------------------------------------------------------
newDbConn$allowEditing()
newDbConn$allowWriting()

## -----------------------------------------------------------------------------
mybiodb$copyDb(chebi, newDbConn)

## -----------------------------------------------------------------------------
newDbConn$write()

## -----------------------------------------------------------------------------
uniprot.tsv <- system.file("extdata", "uniprot_extract.tsv", package='biodb')
uniprot <- mybiodb$getFactory()$createConn('comp.csv.file', url=uniprot.tsv)

## -----------------------------------------------------------------------------
expasy.tsv <- system.file("extdata", "expasy_enzyme_extract.tsv", package='biodb')
expasy <- mybiodb$getFactory()$createConn('comp.csv.file', url=expasy.tsv)

## -----------------------------------------------------------------------------
completeUniprotEntry <- function(e) {
    expasy.id <- e$getFieldValue('expasy.enzyme.id');
    if ( ! is.na(expasy.id)) {
        ex <- expasy$getEntry(expasy.id)
        if ( ! is.null(ex)) {
            for (field in c('catalytic.activity', 'cofactor')) {
                v <- ex$getFieldValue(field)
                if ( ! is.na(v) && length(v) > 0)
                    e$setFieldValue(field, v)
            }
        }
    }
}

## -----------------------------------------------------------------------------
uniprot.entries <- uniprot$getEntry(uniprot$getEntryIds())
invisible(lapply(uniprot.entries, completeUniprotEntry))

## -----------------------------------------------------------------------------
chebi.entries <- chebi$getEntry(chebi$getEntryIds())
all.entries.df <- mybiodb$entriesToDataframe(c(chebi.entries, uniprot.entries))
output.file <- tempfile(pattern="biodb_merged_entries", fileext='.tsv')
write.table(all.entries.df, file=output.file, sep="\t", row.names=FALSE)

## ----mergedData, echo=FALSE, results='asis'-----------------------------------
knitr::kable(head(all.entries.df), "pipe", caption="Merged data")

## -----------------------------------------------------------------------------
newDbOutputFile <- tempfile(pattern="biodb_merged_entries_new_db", fileext='.tsv')
newDbConn <- mybiodb$getFactory()$createConn('comp.csv.file', url=newDbOutputFile)
newDbConn$allowEditing()
newDbConn$allowWriting()

## -----------------------------------------------------------------------------
mybiodb$copyDb(chebi, newDbConn)
mybiodb$copyDb(uniprot, newDbConn)

## -----------------------------------------------------------------------------
newDbConn$write()

## -----------------------------------------------------------------------------
mybiodb$terminate()

## -----------------------------------------------------------------------------
sessionInfo()

