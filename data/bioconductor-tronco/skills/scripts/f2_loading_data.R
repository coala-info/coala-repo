# Code example from 'f2_loading_data' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(
concordance = TRUE,
background = "#f3f3ff"
)

## -----------------------------------------------------------------------------
library(TRONCO)
data(aCML)
data(crc_maf)
data(crc_gistic)
data(crc_plain)

## ----eval=FALSE---------------------------------------------------------------
# aCML = annotate.description(aCML, 'aCML data (Bioinf.)')

## -----------------------------------------------------------------------------
head(crc_maf[, 1:10])

## -----------------------------------------------------------------------------
dataset_maf = import.MAF(crc_maf)

## -----------------------------------------------------------------------------
dataset_maf = import.MAF(crc_maf, merge.mutation.types = FALSE)

## -----------------------------------------------------------------------------
dataset_maf = import.MAF(crc_maf, filter.fun = function(x){ x['Hugo_Symbol'] == 'APC'} )

## -----------------------------------------------------------------------------
dataset_maf = import.MAF(crc_maf, 
    merge.mutation.types = FALSE, 
    paste.to.Hugo_Symbol = c('MA.protein.change'))

## -----------------------------------------------------------------------------
crc_gistic

## -----------------------------------------------------------------------------
dataset_gistic = import.GISTIC(crc_gistic)

## -----------------------------------------------------------------------------
crc_plain

## -----------------------------------------------------------------------------
dataset_plain = import.genotypes(crc_plain, event.type='myVariant')

## ----results='hide', eval=FALSE-----------------------------------------------
# data = cbio.query(
#     genes=c('TP53', 'KRAS', 'PIK3CA'),
#     cbio.study = 'luad_tcga_pub',
#     cbio.dataset = 'luad_tcga_pub_cnaseq',
#     cbio.profile = 'luad_tcga_pub_mutations')

