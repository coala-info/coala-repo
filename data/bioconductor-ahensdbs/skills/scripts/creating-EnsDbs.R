# Code example from 'creating-EnsDbs' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----load-lib, message = FALSE------------------------------------------------
library(AnnotationHub)
ah <- AnnotationHub()


## ----list-ensdb---------------------------------------------------------------
query(ah, "EnsDb")

## ----load-ensdb---------------------------------------------------------------
qr <- query(ah, c("EnsDb", "intestinalis", "87"))
edb <- qr[[1]]

## ----get-genes----------------------------------------------------------------
genes(edb)

## ----load-lib2, eval = FALSE--------------------------------------------------
# library(ensembldb)
# 
# scr <- system.file("scripts/generate-EnsDBs.R", package = "ensembldb")
# source(scr)
# 

## ----create-dbs, eval = FALSE-------------------------------------------------
# createEnsDbForSpecies(ens_version = 87, user = "someuser", host = "localhost",
#                       pass = "somepass")

