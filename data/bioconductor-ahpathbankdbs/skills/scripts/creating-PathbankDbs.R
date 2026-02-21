# Code example from 'creating-PathbankDbs' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----load-lib, message = FALSE------------------------------------------------
library(AnnotationHub)
ah <- AnnotationHub()

## ----list-pathbankdb----------------------------------------------------------
query(ah, "pathbank")

## ----confirm-metadata---------------------------------------------------------
mcols(query(ah, "pathbank"))

## ----query-ecoli--------------------------------------------------------------
qr <- query(ah, c("pathbank", "Escherichia coli"))
qr

## ----load-ecolitbl------------------------------------------------------------
ecolitbl <- qr[[1]]
ecolitbl

## ----get-metabolites4TCA------------------------------------------------------
ecolitbl[ecolitbl$`Pathway Name`=="TCA Cycle", ]

## ----create-rda, eval = FALSE-------------------------------------------------
#  library(AHPathbankDbs)
#  scr <- system.file("scripts/make-data.R", package = "AHPathBankDbs")
#  source(scr)
#  createPathbankMetabolitesDb()
#  createPathbankProteinsDb()

