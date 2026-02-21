# Code example from 'msigdb' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  warning = FALSE,
  message = FALSE,
  comment = "#>"
)

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("msigdb")

## ----load-packages, message=FALSE---------------------------------------------
library(msigdb)
library(ExperimentHub)
library(GSEABase)

## ----get-msigdb---------------------------------------------------------------
eh = ExperimentHub()
query(eh , 'msigdb')

## ----download-msigdb-sym-id---------------------------------------------------
eh[['EH5421']]

## ----download-msigdb-sym-getMsigdb--------------------------------------------
#use the custom accessor to select a specific version of MSigDB
msigdb.hs = getMsigdb(org = 'hs', id = 'SYM', version = '7.4')
msigdb.hs

## ----append-kegg--------------------------------------------------------------
msigdb.hs = appendKEGG(msigdb.hs)
msigdb.hs

## ----process-gsc--------------------------------------------------------------
length(msigdb.hs)

## ----access-gs----------------------------------------------------------------
gs = msigdb.hs[[1000]]
gs
#get genes in the signature
geneIds(gs)
#get collection type
collectionType(gs)
#get MSigDB category
bcCategory(collectionType(gs))
#get MSigDB subcategory
bcSubCategory(collectionType(gs))
#get description
description(gs)
#get details
details(gs)

## ----summarise-gsc------------------------------------------------------------
#calculate the number of signatures in each category
table(sapply(lapply(msigdb.hs, collectionType), bcCategory))
#calculate the number of signatures in each subcategory
table(sapply(lapply(msigdb.hs, collectionType), bcSubCategory))
#plot the distribution of sizes
hist(sapply(lapply(msigdb.hs, geneIds), length),
     main = 'MSigDB signature size distribution',
     xlab = 'Signature size')

## ----list-collections---------------------------------------------------------
listCollections(msigdb.hs)
listSubCollections(msigdb.hs)

## -----------------------------------------------------------------------------
#retrieeve the hallmarks gene sets
subsetCollection(msigdb.hs, 'h')
#retrieve the biological processes category of gene ontology
subsetCollection(msigdb.hs, 'c5', 'GO:BP')

## ----load-limma, message=FALSE------------------------------------------------
library(limma)

#create expression data
allg = unique(unlist(geneIds(msigdb.hs)))
emat = matrix(0, nrow = length(allg), ncol = 6)
rownames(emat) = allg
colnames(emat) = paste0('sample', 1:6)
head(emat)

## ----subset-msigdb------------------------------------------------------------
#retrieve collections
hallmarks = subsetCollection(msigdb.hs, 'h')
msigdb_ids = geneIds(hallmarks)

#convert gene sets into a list of gene indices
fry_indices = ids2indices(msigdb_ids, rownames(emat))
fry_indices[1:2]

## ----download-msig-sym-id-mouse-----------------------------------------------
msigdb.mm = getMsigdb(org = 'mm', id = 'SYM', version = '7.4')
msigdb.mm

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

