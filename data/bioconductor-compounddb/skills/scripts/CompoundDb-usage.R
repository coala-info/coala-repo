# Code example from 'CompoundDb-usage' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----echo = FALSE, message = FALSE--------------------------------------------
library(CompoundDb)
library(BiocStyle)
knitr::opts_chunk$set(echo = TRUE, message = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("CompoundDb")

## ----load---------------------------------------------------------------------
library(CompoundDb)
cdb <- CompDb(system.file("sql/CompDb.MassBank.sql", package = "CompoundDb"))
cdb

## -----------------------------------------------------------------------------
metadata(cdb)

## -----------------------------------------------------------------------------
compoundVariables(cdb)

## -----------------------------------------------------------------------------
head(compounds(cdb, columns = c("name", "formula", "exactmass")))

## -----------------------------------------------------------------------------
head(compounds(cdb, columns = c("compound_id", "name", "formula")))

## -----------------------------------------------------------------------------
compounds(cdb, columns = c("compound_id", "name", "formula"),
          filter = ~ name == "Mellein")

## -----------------------------------------------------------------------------
supportedFilters(cdb)

## -----------------------------------------------------------------------------
compounds(cdb, columns = c("compound_id", "name", "formula"),
          filter = ~ name == "Mellein" & compound_id %in% c(1, 5))

## -----------------------------------------------------------------------------
compounds(cdb, columns = c("name", "exactmass"),
          filter = ~ exactmass > 310 & exactmass < 320)

## -----------------------------------------------------------------------------
compounds(cdb, columns = c("name", "formula", "exactmass"),
          filter = FormulaFilter("H14", "contains"))

## -----------------------------------------------------------------------------
filters <- AnnotationFilterList(
    FormulaFilter("H14", "contains"),
    ExactmassFilter(310, ">"),
    ExactmassFilter(320, "<"),
    logicOp = c("&", "&"))
compounds(cdb, columns = c("name", "formula", "exactmass"),
          filter = filters)

## -----------------------------------------------------------------------------
mass2mz(cdb, adduct = c("[M+H]+", "[M+Na]+"))

## -----------------------------------------------------------------------------
mass2mz(cdb, adduct = c("[M+H]+", "[M+Na]+"), name = "inchikey")

## -----------------------------------------------------------------------------
MetaboCoreUtils::adductNames()

## -----------------------------------------------------------------------------
MetaboCoreUtils::adductNames(polarity = "negative")

## -----------------------------------------------------------------------------
sps <- Spectra(cdb)
sps

## -----------------------------------------------------------------------------
spectraVariables(sps)

## -----------------------------------------------------------------------------
head(sps$adduct)

## -----------------------------------------------------------------------------
mellein <- Spectra(cdb, filter = ~ name == "Mellein")
mellein

## ----message = FALSE----------------------------------------------------------
library(Spectra)
cormat <- compareSpectra(mellein, sps, ppm = 40)

## -----------------------------------------------------------------------------
cormat <- compareSpectra(mellein, sps, ppm = 40, BPPARAM = MulticoreParam(2))

## -----------------------------------------------------------------------------
library(RSQLite)
## Create a temporary database
con <- dbConnect(SQLite(), tempfile())
## Create an IonDb copying the content of cdb to the new database
idb <- IonDb(con, cdb)
idb

## -----------------------------------------------------------------------------
ions(idb)

## -----------------------------------------------------------------------------
ion <- data.frame(compound_id = c(1, 1),
                  ion_adduct = c("[M+H]+", "[M+Na]+"),
                  ion_mz = c(123.34, 125.34),
                  ion_rt = c(196, 196))
idb <- insertIon(idb, ion)

## -----------------------------------------------------------------------------
ions(idb)

## -----------------------------------------------------------------------------
ions(idb, columns = c("ion_adduct", "name", "exactmass"))

## -----------------------------------------------------------------------------
sessionInfo()

