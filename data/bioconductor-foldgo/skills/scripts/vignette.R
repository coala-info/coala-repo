# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

devtools::load_all(".")
library(kableExtra)
library(topGO)

## ---- eval=FALSE---------------------------------------------------------
#  head(degenes)

## ---- warning = FALSE, message = FALSE, echo=FALSE-----------------------
cut_degenes <- head(degenes)
cut_degenes[, c(3, 4)] <- sapply(c(3, 4), function(x) formatC(as.numeric(cut_degenes[, x]), digits = 2,  format="e"))
knitr::kable(cut_degenes, row.names = FALSE)

## ----groups, warning = FALSE, message = FALSE----------------------------
up_groups <- GeneGroups(degenes, quannumber=6)

## ----gafread, warning = FALSE, message = FALSE---------------------------
gaf_path <- system.file("extdata", "gene_association.tair.lzma", package = "FoldGO")
gaf <- GAFReader(file = gaf_path,  geneid_col = 10)

## ----gaf_getters chunk 1, warning = FALSE, message = FALSE---------------
getVersion(gaf)

## ----gaf_getters chunk 2, warning = FALSE, message = FALSE, results='hide'----
getAnnotation(gaf)

## ----annot, eval = FALSE-------------------------------------------------
#  up_annotobj <- FuncAnnotGroupsTopGO(genegroups = up_groups, namespace = "MF", customAnnot = gaf, annot = topGO::annFUN.GO2genes, bggenes = bggenes)

## ----ara_annot, eval = FALSE---------------------------------------------
#  up_annotobj <- FuncAnnotGroupsTopGO(up_groups,"MF", mapping = "org.At.tair.db", annot = topGO::annFUN.org, ID = "entrez", bggenes = bggenes)

## ----human_annot, warning = FALSE, message = FALSE, results='hide'-------
up_groups <- GeneGroups(degenes_hum, quannumber=6)
FuncAnnotGroupsTopGO(up_groups,"MF", mapping = "org.Hs.eg.db", annot = topGO::annFUN.org, ID = "ensembl", bggenes = bggenes_hum)

## ----fs_test, warning = FALSE, message = FALSE---------------------------
up_fsobj <- FoldSpecTest(up_annotobj, fdrstep1 = 0.05, fdrstep2 = 0.01)
down_fsobj <- FoldSpecTest(down_annotobj, fdrstep1 = 0.05, fdrstep2 = 0.01)

## ----fs_test_padj, eval=FALSE--------------------------------------------
#  FoldSpecTest(up_annotobj, padjmethod = "BY")

## ----fs_table------------------------------------------------------------
fs_table <- getFStable(up_fsobj)

## ---- eval=FALSE---------------------------------------------------------
#  head(fs_table)

## ---- echo=FALSE---------------------------------------------------------
library(kableExtra)
fs_table[, c(4, 5, 6, 7)] <- sapply(c(4, 5, 6, 7), function(x) formatC(as.numeric(fs_table[, x]), digits = 2,  format="e"))
knitr::kable(head(fs_table)) %>% kable_styling(font_size = 12)

## ----nfs_table-----------------------------------------------------------
nfs_table <- getNFStable(up_fsobj)

## ---- eval=FALSE---------------------------------------------------------
#  head(nfs_table)

## ---- echo=FALSE---------------------------------------------------------
nfs_table[, c(4, 5, 6, 7)] <- sapply(c(4, 5, 6, 7), function(x) formatC(as.numeric(nfs_table[, x]), digits = 2,  format="e"))
knitr::kable(head(nfs_table)) %>% kable_styling(font_size = 12)

## ----fs_plot, warning = FALSE, message = FALSE, fig.height = 10, fig.width = 7----
plot(up_fsobj, down_fsobj)

