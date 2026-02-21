# Code example from 'loading_genesets' vignette. See references/ for full tutorial.

## ----knitr.setup, echo=FALSE--------------------------------------------------
library(knitr)
knitr::opts_chunk$set(
  echo = TRUE,
  warning=FALSE,
  message=FALSE,
  error = FALSE,
  tidy = FALSE,
  cache = TRUE)


# rmarkdown::render("loading_genesets.Rmd")

## ----load1, eval=FALSE--------------------------------------------------------
# library(zenith)
# 
# ## MSigDB as ENSEMBL genes
# # all genesets in MSigDB
# gs.msigdb = get_MSigDB()
# 
# # only Hallmark gene sets
# gs = get_MSigDB('H')
# 
# # only C1
# gs = get_MSigDB('C1')
# 
# # C1 and C2
# gs = get_MSigDB(c('C1', 'C2'))
# 
# # C1 as gene SYMBOL
# gs = get_MSigDB('C1', to="SYMBOL")
# 
# # C1 as gene ENTREZ
# gs = get_MSigDB('C1', to="ENTREZ")
# 
# ## Gene Ontology
# gs.go = get_GeneOntology()
# 
# # load Biological Process and gene SYMBOL
# gs.go = get_GeneOntology("BP", to="SYMBOL")

## ----load2, eval=FALSE--------------------------------------------------------
# library(EnrichmentBrowser)
# 
# # KEGG
# gs.kegg = getGenesets(org = "hsa",
#                       db = "kegg",
#                       gene.id.type = "ENSEMBL",
#                       return.type = "GeneSetCollection")
# 
# ## ENRICHR resource
# # provides many additional gene set databases
# df = showAvailableCollections( org = "hsa", db = "enrichr")
# 
# head(df)
# 
# # Allen_Brain_Atlas_10x_scRNA_2021
# gs.allen = getGenesets( org = "hsa",
#                         db = "enrichr",
#                         lib = "Allen_Brain_Atlas_10x_scRNA_2021",
#                         gene.id.type = "ENSEMBL",
#                         return.type = "GeneSetCollection")

## ----custom, eval=FALSE-------------------------------------------------------
# # Load gene sets from GMT file
# gmt.file <- system.file("extdata/hsa_kegg_gs.gmt",
#                        package = "EnrichmentBrowser")
# gs <- getGenesets(gmt.file)

## ----session, echo=FALSE------------------------------------------------------
sessionInfo()

