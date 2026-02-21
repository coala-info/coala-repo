# Code example from 'MPO_vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly=TRUE))
#      install.packages("BiocManager")
#  ## BiocManager::install("BiocUpgrade") ## you may need this
#  BiocManager::install("MPO.db")

## ----setup--------------------------------------------------------------------
library(MPO.db)

## -----------------------------------------------------------------------------
library(AnnotationDbi)

## -----------------------------------------------------------------------------
ls("package:MPO.db")
packageVersion("MPO.db")

## -----------------------------------------------------------------------------
toTable(MPOmetadata)
MPOMAPCOUNTS

## -----------------------------------------------------------------------------
doterm <- toTable(MPOTERM)
head(doterm)

## -----------------------------------------------------------------------------
dotermlist <- as.list(MPOTERM)
head(dotermlist)

## -----------------------------------------------------------------------------
doalias <- as.list(MPOALIAS)
doalias[['MP:0000003']]

## -----------------------------------------------------------------------------
dosynonym <- as.list(MPOSYNONYM)
dosynonym[['MP:0000003']]

## -----------------------------------------------------------------------------
anc_table <- toTable(MPOANCESTOR)
head(anc_table)

## -----------------------------------------------------------------------------
anc_list <- AnnotationDbi::as.list(MPOANCESTOR)
anc_list[["MP:0000013"]]

## -----------------------------------------------------------------------------
parent_table <- toTable(MPOPARENTS)
head(parent_table)

## -----------------------------------------------------------------------------
parent_list <- AnnotationDbi::as.list(MPOPARENTS)
parent_list[["MP:0000013"]]

## -----------------------------------------------------------------------------
off_list <- AnnotationDbi::as.list(MPO.db::MPOOFFSPRING)
off_list[["MP:0000010"]]

## -----------------------------------------------------------------------------
child_list <- AnnotationDbi::as.list(MPO.db::MPOCHILDREN)
child_list[["MP:0000003"]]

## -----------------------------------------------------------------------------
columns(MPO.db)
## use mpid keys
dokeys <- keys(MPO.db)[1:100]
res <- select(x = MPO.db, keys = dokeys, keytype = "mpid", 
    columns = c("offspring", "term", "doid", "mgi"))
head(na.omit(res))

key <-  keys(MPO.db, "mpid")[1:100]   
res <- select(x = MPO.db, keys = key, keytype = "mpid", 
    columns = c("mpid", "term", "children"))   
head(na.omit(res))

## use term keys
# dokeys <- head(keys(MPO.db, keytype = "term"))
# res <- select(x = MPO.db, keys = dokeys, keytype = "term", 
#     columns = c("offspring", "mpid", "parent"))   
# head(res)

dokeys <- keys(MPO.db, keytype = "term")[1:100]
res <- select(x = MPO.db, keys = dokeys, keytype = "term", 
    columns = c("offspring", "mpid", "doid", "mgi"))   
head(na.omit(res))

## use mgi keys
key <- keys(MPO.db, "mgi")[1:100]
res <- select(x = MPO.db, keys = key, keytype = "mgi", 
    columns = c("mgi", "mpid", "children"))   
head(na.omit(res))

res <- select(x = MPO.db, keys = key, keytype = "mgi", 
    columns = c("doid", "mgi"))   
head(na.omit(res))



## -----------------------------------------------------------------------------
sessionInfo()

