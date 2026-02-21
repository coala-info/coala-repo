# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----init, eval=TRUE, results='hide', echo=FALSE, cache=FALSE------------
knitr::opts_chunk$set(cache=FALSE, echo=FALSE, eval=TRUE)

## ----style-knitr, results="asis"--------------------------------------------------------
BiocStyle::latex()

## ----load-package, echo=TRUE, results='hide'--------------------------------------------
library(rDGIdb)

## ----gene-list, echo=TRUE, results='hide'-----------------------------------------------
genes <- c("TNF", "AP1", "AP2", "XYZA")

## ----query-dgidb-1, echo=TRUE, results='hide'-------------------------------------------
result <- queryDGIdb(genes)

## ----access-result-details, echo=TRUE, results='hide'-----------------------------------
## Result summary
resultSummary(result)

## Detailed results
detailedResults(result)

## By gene
byGene(result)

## Search term summary
searchTermSummary(result)

## ----query-dgidb-stab, echo=TRUE, results='hide'----------------------------------------
queryDGIdb(genes = genes,
    sourceDatabases = NULL,
    geneCategories = NULL,
    interactionTypes = NULL)

## ----argument-options, echo=TRUE, results='markup'--------------------------------------
## Available source databases
sourceDatabases()

## Available gene categories
geneCategories()

## Available interaction types
interactionTypes()

## ----query-dgidb-optional, echo=TRUE, results='hide'------------------------------------
resultFilter <- queryDGIdb(genes,
                sourceDatabases = c("DrugBank","MyCancerGenome"),
                geneCategories = "clinically actionable",
                interactionTypes = c("suppressor","activator","blocker"))

## ----bp-figure-setup, echo=FALSE, results='hide'----------------------------------------
h <- '0.5\\linewidth'
w <- '0.7\\linewidth'
c <- 'center'

## ----bp,echo=TRUE,fig.align=c,fig.height=5,fig.width=7,out.height=h,out.width=w---------
plotInteractionsBySource(result, main = "Number of interactions by source")

## ----resource-versions, echo=FALSE, results='hide'--------------------------------------
resourceVersions()

## ----variant-annotation, echo=TRUE, results='hide', eval=FALSE--------------------------
#  library("VariantAnnotation")
#  library("TxDb.Hsapiens.UCSC.hg19.knownGene")
#  library("org.Hs.eg.db")
#  vcf <- readVcf("file.vcf.gz", "hg19")
#  seqlevels(vcf) <- paste("chr", seqlevels(vcf), sep = "")
#  rd <- rowRanges(vcf)
#  loc <- locateVariants(rd, TxDb.Hsapiens.UCSC.hg19.knownGene, CodingVariants())
#  symbols <- select(x = org.Hs.eg.db, keys = mcols(loc)$GENEID,
#                  columns = "SYMBOL", keytype = "ENTREZID")
#  genes <- unique(symbols$SYMBOL)

## ----questions, echo=TRUE, results='hide'-----------------------------------------------
?queryDGIdb
?rDGIdbFilters
?rDGIdbResult
?plotInteractionsBySource

## ----session-info, results="asis"-------------------------------------------------------
toLatex(sessionInfo())

## ----citation, echo=TRUE, results='hide'------------------------------------------------
citation('rDGIdb')

