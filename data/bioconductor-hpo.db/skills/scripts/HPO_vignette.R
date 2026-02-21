# Code example from 'HPO_vignette' vignette. See references/ for full tutorial.

## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(HPO.db)

## ----eval=FALSE---------------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly=TRUE))
#      install.packages("BiocManager")
#  ## BiocManager::install("BiocUpgrade") ## you may need this
#  BiocManager::install("HPO.db")

## -----------------------------------------------------------------------------
library(AnnotationDbi)

## -----------------------------------------------------------------------------
ls("package:HPO.db")
packageVersion("HPO.db")

## -----------------------------------------------------------------------------
toTable(HPOmetadata)
HPOMAPCOUNTS

## -----------------------------------------------------------------------------
doterm <- toTable(HPOTERM)
head(doterm)

## -----------------------------------------------------------------------------
dotermlist <- as.list(HPOTERM)
head(dotermlist)

## -----------------------------------------------------------------------------
doalias <- as.list(HPOALIAS)
doalias[['HP:0000006']]

## -----------------------------------------------------------------------------
dosynonym <- as.list(HPOSYNONYM)
dosynonym[['HP:0000006']]

## -----------------------------------------------------------------------------
anc_table <- toTable(HPOANCESTOR)
head(anc_table)

## -----------------------------------------------------------------------------
anc_list <- AnnotationDbi::as.list(HPOANCESTOR)
anc_list[["HP:0000006"]]

## -----------------------------------------------------------------------------
parent_table <- toTable(HPOPARENTS)
head(parent_table)

## -----------------------------------------------------------------------------
parent_list <- AnnotationDbi::as.list(HPOPARENTS)
parent_list[["HP:0000006"]]

## -----------------------------------------------------------------------------
off_list <- AnnotationDbi::as.list(HPO.db::HPOOFFSPRING)
off_list[["HP:0000002"]]

## -----------------------------------------------------------------------------
child_list <- AnnotationDbi::as.list(HPO.db::HPOCHILDREN)
child_list[["HP:0000002"]]

## -----------------------------------------------------------------------------
columns(HPO.db)
## use hpoid keys
dokeys <- head(keys(HPO.db))
res <- select(x = HPO.db, keys = dokeys, keytype = "hpoid", 
    columns = c("offspring", "term", "parent"))
head(res)
## use term keys
dokeys <- head(keys(HPO.db, keytype = "term"))
res <- select(x = HPO.db, keys = dokeys, keytype = "term", 
    columns = c("offspring", "hpoid", "parent"))   
head(res)

## -----------------------------------------------------------------------------
sessionInfo()

