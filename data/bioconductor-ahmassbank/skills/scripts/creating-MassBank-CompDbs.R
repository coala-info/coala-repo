# Code example from 'creating-MassBank-CompDbs' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----load-lib, message = FALSE------------------------------------------------
library(AnnotationHub)
ah <- AnnotationHub()

## -----------------------------------------------------------------------------
query(ah, "MassBank")

## ----load-ensdb---------------------------------------------------------------
qr <- query(ah, c("MassBank", "2021.03"))
cdb <- qr[[1]]

## ----eval = FALSE-------------------------------------------------------------
# library(RMariaDB)
# con <- dbConnect(MariaDB(), host = "localhost", user = <username>,
#                  pass = <password>, dbname = "MassBank")
# source(system.file("scripts", "massbank_to_compdb.R", package = "CompoundDb"))
# massbank_to_compdb(con)

## -----------------------------------------------------------------------------
sessionInfo()

