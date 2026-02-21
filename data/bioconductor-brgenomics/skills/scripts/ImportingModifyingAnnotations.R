# Code example from 'ImportingModifyingAnnotations' vignette. See references/ for full tutorial.

## ---- eval = FALSE------------------------------------------------------------
#  # import bed file
#  genelist <- import.bed("~/data/genelists/genes.bed")
#  
#  # import gff
#  genelist <- import.gff("~/data/genelists/genes.gff")
#  
#  # export a bed file after modifying
#  export.bed(genelist, "~/data/genelists/filtered_genes.bed")

## ---- message = FALSE---------------------------------------------------------
library(BRGenomics)

## -----------------------------------------------------------------------------
data("txs_dm6_chr4")
tx4 <- txs_dm6_chr4[c(1, 10, 200, 300)]
tx4

## -----------------------------------------------------------------------------
tx4_pr <- promoters(tx4, upstream = 50, downstream = 100)
tx4_pr
width(tx4_pr)

## -----------------------------------------------------------------------------
tx4

## -----------------------------------------------------------------------------
genebodies(tx4, start = 300, end = -300)

## -----------------------------------------------------------------------------
genebodies(tx4, -50, 100, fix.end = "start")

## -----------------------------------------------------------------------------
genebodies(tx4, -100, -50, fix.end = "start")

## -----------------------------------------------------------------------------
genebodies(tx4, -1000, 1000, fix.start = "end")

## -----------------------------------------------------------------------------
genebodies(tx4, 0, 10000, fix.start = "end")

## -----------------------------------------------------------------------------
txs <- txs_dm6_chr4[order(txs_dm6_chr4$gene_id)] # sort by gene_id
txs[1:10]

## -----------------------------------------------------------------------------
reduceByGene(txs, gene_names = txs$gene_id)

## -----------------------------------------------------------------------------
txs_redux <- reduceByGene(txs, gene_names = txs$gene_id)
txs_redux$gene_id <- names(txs_redux)
names(txs_redux) <- NULL
txs_redux

## -----------------------------------------------------------------------------
txs[1:10]
txs_insxt <- intersectByGene(txs, gene_names = txs$gene_id)
txs_insxt[order(names(txs_insxt))]

