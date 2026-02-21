# Code example from 'customCMPdb' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, messages=FALSE, warnings=FALSE------------------------
suppressPackageStartupMessages({
  library(customCMPdb); library(ChemmineR)
})

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("customCMPdb")

## ----inst_git, eval=FALSE-----------------------------------------------------
# devtools::install_github("yduan004/customCMPdb", build_vignettes=TRUE)

## ----load, eval=TRUE, message=FALSE-------------------------------------------
library(customCMPdb)
library(help = "customCMPdb")  # Lists package info

## ----load_vignette, eval=FALSE, message=FALSE---------------------------------
# browseVignettes("customCMPdb")  # Opens vignette

## ----sql, eval=TRUE, message=FALSE--------------------------------------------
conn <- loadAnnot()
library(RSQLite)
dbListTables(conn)
drugAgeAnnot <- dbReadTable(conn, "drugAgeAnnot")
head(drugAgeAnnot)
dbDisconnect(conn)

## ----da, eval=TRUE, message=FALSE, results=FALSE------------------------------
da_sdfset <- loadSDFwithName(source="DrugAge")

## ----da_chemmineR, eval=TRUE, message=FALSE, results=FALSE--------------------
ChemmineR::cid(da_sdfset) <- ChemmineR::sdfid(da_sdfset)
ChemmineR::plot(da_sdfset[1])

## ----db, eval=FALSE-----------------------------------------------------------
# db_sdfset <- loadSDFwithName(source="DrugBank")

## ----cmap, eval=TRUE, message=FALSE, results=FALSE----------------------------
cmap_sdfset <- loadSDFwithName(source="CMAP2")

## ----lincs, eval=TRUE, message=FALSE, results=FALSE---------------------------
lincs_sdfset <- loadSDFwithName(source="LINCS")

## ----download_db, eval=TRUE, message=FALSE------------------------------------
library(AnnotationHub)
ah <- AnnotationHub()
annot_path <- ah[["AH79563"]]

## ----custom, eval=TRUE, message=FALSE, results=FALSE--------------------------
chembl_id <- c("CHEMBL1000309", "CHEMBL100014", "CHEMBL10",
               "CHEMBL100", "CHEMBL1000", NA)
annot_tb <- data.frame(cmp_name=paste0("name", 1:6),
        chembl_id=chembl_id,
        feature1=paste0("f", 1:6),
        feature2=rnorm(6))
addCustomAnnot(annot_tb, annot_name="myCustom")

## ----del, eval=TRUE, message=FALSE--------------------------------------------
listAnnot()
deleteAnnot("myCustom")
listAnnot()

## ----default, eval=FALSE------------------------------------------------------
# defaultAnnot()

## ----query, eval=TRUE, message=FALSE------------------------------------------
query_id <- c("CHEMBL1064", "CHEMBL10", "CHEMBL113", "CHEMBL1004", "CHEMBL31574")
listAnnot()
qres <- queryAnnotDB(query_id, annot=c("drugAgeAnnot", "lincsAnnot"))
qres
# query the added custom annotation
addCustomAnnot(annot_tb, annot_name="myCustom")
qres2 <- queryAnnotDB(query_id, annot=c("lincsAnnot", "myCustom"))
qres2

## ----not_chembl, eval=TRUE, message=FALSE-------------------------------------
query_id <- c("BRD-A00474148", "BRD-A00150179", "BRD-A00763758", "BRD-A00267231")
qres3 <- queryAnnotDB(chembl_id=query_id, annot=c("lincsAnnot"))
qres3

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

