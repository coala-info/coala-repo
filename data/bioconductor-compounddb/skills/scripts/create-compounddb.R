# Code example from 'create-compounddb' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----compound_tbl, message = FALSE, warnings = FALSE--------------------------
library(CompoundDb)

## Locate the file
hmdb_file <- system.file("sdf/HMDB_sub.sdf.gz", package = "CompoundDb")
## Extract the data
cmps <- compound_tbl_sdf(hmdb_file)

## ----cmps---------------------------------------------------------------------
cmps

## ----msms_spectra, message = FALSE--------------------------------------------
## Locate the folder with the xml files
xml_path <- system.file("xml", package = "CompoundDb")
spctra <- msms_spectra_hmdb(xml_path)

## ----metadata, message = FALSE------------------------------------------------
metad <- make_metadata(source = "HMDB", url = "http://www.hmdb.ca",
                       source_version = "4.0", source_date = "2017-09",
                       organism = "Hsapiens")

## ----createCompDb-------------------------------------------------------------
db_file <- createCompDb(cmps, metadata = metad, msms_spectra = spctra,
                        path = tempdir())

## ----CompDb-------------------------------------------------------------------
cmpdb <- CompDb(db_file)
cmpdb

## -----------------------------------------------------------------------------
tables(cmpdb)

## ----compounds----------------------------------------------------------------
compounds(cmpdb, columns = c("name", "formula", "exactmass"))

## ----spectra, message = FALSE-------------------------------------------------
library(Spectra)
sps <- Spectra(cmpdb)
sps

## ----spectraVariables---------------------------------------------------------
spectraVariables(sps)

## -----------------------------------------------------------------------------
sps$collisionEnergy

## -----------------------------------------------------------------------------
mz(sps)

## m/z of the 2nd spectrum
mz(sps)[[2]]

## ----spectra-selected---------------------------------------------------------
sps <- Spectra(cmpdb, filter = ~ compound_id == "HMDB0000001",
               columns = c(tables(cmpdb)$msms_spectrum, "name",
                           "inchikey"))
sps

## -----------------------------------------------------------------------------
spectraVariables(sps)

## -----------------------------------------------------------------------------
sps$inchikey

## ----createCompoundDbPackage, warning = FALSE---------------------------------
createCompDbPackage(
    db_file, version = "0.0.1", author = "J Rainer", path = tempdir(),
    maintainer = "Johannes Rainer <johannes.rainer@eurac.edu>")

## -----------------------------------------------------------------------------
cmps <- data.frame(
    compound_id = c("CP_0001", "CP_0002", "CP_0003", "CP_0004"),
    name = c("A", "B", "C", "D"),
    inchi = NA_character_,
    inchikey = NA_character_,
    formula = NA_character_,
    exactmass = c(123.4, 234.5, 345.6, 456.7),
    compound_group = c("G01", "G02", "G01", "G03")
)

## -----------------------------------------------------------------------------
cmps$synonyms <- list(
    c("a", "AA", "aaa"),
    c(),
    c("C", "c"),
    ("d")
)

## -----------------------------------------------------------------------------
metad <- make_metadata(source = "manually defined", url = "",
                       source_version = "1.0.0", source_date = "2022-03-01",
                       organism = NA_character_)

db_file <- createCompDb(cmps, metadata = metad, path = tempdir(),
                        dbFile = "CompDb.test.sqlite")

## -----------------------------------------------------------------------------
cdb <- CompDb(db_file, flags = RSQLite::SQLITE_RW)
cdb

## -----------------------------------------------------------------------------
compounds(cdb)

## -----------------------------------------------------------------------------
compounds(cdb, filter = ~ name %in% c("B", "A"))

## -----------------------------------------------------------------------------
#' Define basic spectra variables
df <- DataFrame(msLevel = 2L, precursorMz = c(124.4, 124.4, 235.5))
#' Add m/z and intensity information for each spectrum
df$mz <- list(
    c(3, 20, 59.1),
    c(2, 10, 30, 59.1),
    c(100, 206, 321.1))
df$intensity <- list(
    c(10, 13, 45),
    c(5, 8, 9, 43),
    c(10, 20, 400))
#' Create the Spectra object
sps <- Spectra(df)

## -----------------------------------------------------------------------------
compounds(cdb, "compound_id")
sps$compound_id <- c("CP_0001", "CP_0001", "CP_0002")

## -----------------------------------------------------------------------------
sps$instrument <- "AB Sciex TripleTOF 5600+"

## -----------------------------------------------------------------------------
cdb <- insertSpectra(cdb, spectra = sps,
                     columns = c("compound_id", "msLevel",
                                 "precursorMz", "instrument"))
cdb

## -----------------------------------------------------------------------------
Spectra(cdb, filter = ~ name == "A")

## ----mona-import, message = FALSE---------------------------------------------
mona_sub <- system.file("sdf/MoNa_export-All_Spectra_sub.sdf.gz",
                        package = "CompoundDb")
mona_data <- import_mona_sdf(mona_sub)

## ----mona-metadata------------------------------------------------------------
metad <- make_metadata(source = "MoNa",
                       url = "http://mona.fiehnlab.ucdavis.edu/",
                       source_version = "2018.11", source_date = "2018-11",
                       organism = "Unspecified")
mona_db_file <- createCompDb(mona_data$compound, metadata = metad,
                             msms_spectra = mona_data$msms_spectrum,
                             path = tempdir())

## ----mona-compounds-----------------------------------------------------------
mona <- CompDb(mona_db_file)
compounds(mona)

## -----------------------------------------------------------------------------
dbfile <- tempfile()
mydb <- emptyCompDb(dbfile)
mydb

## -----------------------------------------------------------------------------
cmp <- data.frame(compound_id = c("1", "2"),
                  name = c("Caffeine", "Glucose"),
                  formula = c("C8H10N4O2", "C6H12O6"),
                  exactmass = c(194.080375584, 180.063388116))
mydb <- insertCompound(mydb, cmp)
mydb

## ----message = FALSE----------------------------------------------------------
library(MsBackendMgf)
caf_ms2 <- Spectra(system.file("mgf", "caffeine.mgf", package = "CompoundDb"),
                   source = MsBackendMgf())
caf_ms2

## -----------------------------------------------------------------------------
spectraVariables(caf_ms2)
caf_ms2$rtime

## -----------------------------------------------------------------------------
caf_ms2$compound_id <- "1"

## -----------------------------------------------------------------------------
mydb <- insertSpectra(mydb, caf_ms2,
                      columns = c("compound_id", "msLevel", "splash",
                                  "precursorMz", "collisionEnergy"))
mydb

## -----------------------------------------------------------------------------
compounds(mydb)
sps <- Spectra(mydb)
sps$name

## -----------------------------------------------------------------------------
cmps <- data.frame(compound_id = "3", name = "X003",
                   formula = "C5H2P3O", extra_field = "artificial compound")
mydb <- insertCompound(mydb, cmps, addColumns = TRUE)
compounds(mydb)

## -----------------------------------------------------------------------------
compounds(mydb, columns = c("compound_id", "name"))

## -----------------------------------------------------------------------------
mydb <- deleteCompound(mydb, ids = "3")
compounds(mydb)

## -----------------------------------------------------------------------------
mydb <- deleteCompound(mydb, ids = "1", recursive = TRUE)
compounds(mydb)
Spectra(mydb)

## -----------------------------------------------------------------------------
#' Copy the test database to a temporary file
tf <- tempfile()
file.copy(system.file("sql/CompDb.MassBank.sql", package = "CompoundDb"), tf)

#' Connect to this new database
library(RSQLite)
con <- dbConnect(SQLite(), tf)

## -----------------------------------------------------------------------------
dbListTables(con)

## -----------------------------------------------------------------------------
exp <- data.frame(
    experiment_id = 1:4,
    experiment_name = c("exp_a", "exp_b", "exp_c", "exp_d"),
    experiment_date = c("2022-11-24", "2023-06-12", "2023-09-21", "2024-12-07"),
    experiment_operator = c("AA", "VV", "AA", "AA"))

## -----------------------------------------------------------------------------
cmp <- dbGetQuery(con, "select * from ms_compound")
nrow(cmp)

## -----------------------------------------------------------------------------
cmp$experiment_id <- sample(1:4, nrow(cmp), replace = TRUE)

## -----------------------------------------------------------------------------
dbWriteTable(con, name = "ms_compound", cmp, overwrite = TRUE)
dbWriteTable(con, name = "experiment", exp)
dbListTables(con)
dbDisconnect(con)

## -----------------------------------------------------------------------------
cdb <- CompDb(tf)

## -----------------------------------------------------------------------------
tables(cdb)

## -----------------------------------------------------------------------------
cdb <- addJoinDefinition(
    cdb, table_a = "ms_compound", table_b = "experiment",
    column_a = "experiment_id", column_b = "experiment_id")

## -----------------------------------------------------------------------------
#' Show the first 6 rows
compounds(cdb, columns = c("compound_id", "formula", "experiment_name",
                           "experiment_date")) |>
    head()

## -----------------------------------------------------------------------------
s <- Spectra(cdb)
spectraData(s)

## -----------------------------------------------------------------------------
s$experiment_name

## -----------------------------------------------------------------------------
file.remove(tf)

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

