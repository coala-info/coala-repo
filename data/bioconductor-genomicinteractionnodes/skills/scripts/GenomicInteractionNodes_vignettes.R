# Code example from 'GenomicInteractionNodes_vignettes' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", warning=FALSE, message=FALSE-----------------
library(GenomicInteractionNodes)
library(rtracklayer)
library(TxDb.Hsapiens.UCSC.hg19.knownGene) 
library(org.Hs.eg.db)
knitr::opts_chunk$set(warning=FALSE, message=FALSE)

## ----devtoolsInstallation, eval=FALSE-----------------------------------------
# library(devtools)
# install_github("jianhong/GenomicInteractionNodes")

## ----BiocManagerInstallation, eval=FALSE--------------------------------------
# library(BiocManager)
# install("GenomicInteractionNodes")

## ----quickStart---------------------------------------------------------------
## load library
library(GenomicInteractionNodes)
library(rtracklayer)
library(TxDb.Hsapiens.UCSC.hg19.knownGene) ## for human hg19
library(org.Hs.eg.db) ## used to convert gene_id to gene_symbol
library(GO.db) ## used for enrichment analysis

## import the interactions from bedpe file
p <- system.file("extdata", "WT.2.bedpe",
                 package = "GenomicInteractionNodes")
#### please try to replace the connection to your file path
interactions <- import(con=p, format="bedpe")

## define the nodes
nodes <- detectNodes(interactions)
names(nodes)
lapply(nodes, head, n=2)

## annotate the nodes by gene promoters
node_regions <- nodes$node_regions
node_regions <- annotateNodes(node_regions,
                        txdb=TxDb.Hsapiens.UCSC.hg19.knownGene,
                        orgDb=org.Hs.eg.db,
                        upstream=2000, downstream=500)
head(node_regions, n=2)

## Gene Ontology enrichment analysis
enrich <- enrichmentAnalysis(node_regions, orgDb=org.Hs.eg.db)
names(enrich$enriched)
names(enrich$enriched_in_compound)
res <- enrich$enriched$BP
res <- res[order(res$fdr), ]
head(res, n=2)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

