# Code example from 'creating-WikipathwaysDbs' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----load-lib, message = FALSE------------------------------------------------
library(AnnotationHub)
ah <- AnnotationHub()

## ----list-wikipathwaysdb------------------------------------------------------
query(ah, "wikipathways")

## ----confirm-metadata---------------------------------------------------------
mcols(query(ah, "wikipathways"))

## ----query-hsa----------------------------------------------------------------
qr <- query(ah, c("wikipathways", "Homo sapiens"))
qr

## ----load-hsatbl--------------------------------------------------------------
hsatbl <- qr[[1]]
hsatbl

## ----get-metabolites----------------------------------------------------------
hsatbl[hsatbl$`pathway_name`=="Amino Acid metabolism", ]

## ----create-rda, eval = FALSE-------------------------------------------------
#  library(AHWikipathwaysDbs)
#  scr <- system.file("scripts/make-data.R", package = "AHWikipathwaysDbs")
#  source(scr)
#  createWikipathwaysMetabolitesDb()

