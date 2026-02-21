# Code example from 'genesets' vignette. See references/ for full tutorial.

## ----eval = TRUE, echo = FALSE------------------------------------------------
library(knitr)
knitr::opts_chunk$set(
    error = FALSE,
    tidy  = FALSE,
    message = FALSE
)

## -----------------------------------------------------------------------------
library(BioMartGOGeneSets)
gr = getBioMartGenes("hsapiens_gene_ensembl")
gr

## ----eval = FALSE-------------------------------------------------------------
#  gr = getBioMartGenes("hsapiens")

## ----eval = FALSE-------------------------------------------------------------
#  gr = getBioMartGenes("human")

## ----eval = FALSE-------------------------------------------------------------
#  gr = getBioMartGenes(9606)

## -----------------------------------------------------------------------------
gr = getBioMartGenes("hsapiens_gene_ensembl", add_chr_prefix = TRUE)
gr

## -----------------------------------------------------------------------------
gr = getBioMartGenes("hsapiens_gene_ensembl")
GenomeInfoDb::seqlevelsStyle(gr) = "UCSC"
gr

## -----------------------------------------------------------------------------
gr = getBioMartGenes("cporcellus_gene_ensembl")
gr

## -----------------------------------------------------------------------------
getBioMartGenomeInfo("cporcellus_gene_ensembl")

## -----------------------------------------------------------------------------
gr2 = changeSeqnameStyle(gr, "cporcellus_gene_ensembl", 
    seqname_style_from = "GenBank-Accn", 
    seqname_style_to = "Sequence-Name")
gr2

## -----------------------------------------------------------------------------
gr = getBioMartGenes("apercula_gene_ensembl")
gr
getBioMartGenomeInfo("apercula_gene_ensembl")

## -----------------------------------------------------------------------------
gr2 = changeSeqnameStyle(gr, "apercula_gene_ensembl", 
    seqname_style_from = "Sequence-Name", 
    seqname_style_to = "GenBank-Accn", 
    reformat_from =function(x) gsub("chr", "", x),
    reformat_to = function(x) gsub("\\.\\d+$", "", x)
)
gr2

## -----------------------------------------------------------------------------
lt = getBioMartGOGeneSets("mmusculus_gene_ensembl")
length(lt)
lt[1]

## ----eval = FALSE-------------------------------------------------------------
#  lt = getBioMartGOGeneSets("mouse")

## ----eval = FALSE-------------------------------------------------------------
#  lt = getBioMartGOGeneSets(10090)

## -----------------------------------------------------------------------------
tb = getBioMartGOGeneSets("mmusculus_gene_ensembl", as_table = TRUE)
head(tb)

## ----eval = FALSE-------------------------------------------------------------
#  getBioMartGOGeneSets("mmusculus_gene_ensembl", ontology = "BP") # the default one
#  getBioMartGOGeneSets("mmusculus_gene_ensembl", ontology = "CC")
#  getBioMartGOGeneSets("mmusculus_gene_ensembl", ontology = "MF")

## -----------------------------------------------------------------------------
lt = getBioMartGOGeneSets("mmusculus_gene_ensembl", gene_id_type = "entrez_gene")
lt[1]

## -----------------------------------------------------------------------------
BioMartGOGeneSets

## -----------------------------------------------------------------------------
sessionInfo()

