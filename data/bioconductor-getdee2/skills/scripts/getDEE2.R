# Code example from 'getDEE2' vignette. See references/ for full tutorial.

## ----install, eval = FALSE----------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("getDEE2")

## ----lib----------------------------------------------------------------------
library("getDEE2")

## ----getmeta------------------------------------------------------------------
mdat <- getDEE2Metadata("celegans")
head(mdat)

## ----filtermeta---------------------------------------------------------------
mdat[which(mdat$SRP_accession %in% "SRP009256"),]

## ----getSRRs------------------------------------------------------------------
mdat1 <- mdat[which(mdat$SRP_accession %in% "SRP009256"),]
SRRvec <- as.vector(mdat1$SRR_accession)
SRRvec

## ----example1-----------------------------------------------------------------
suppressPackageStartupMessages(library("SummarizedExperiment"))
x <- getDEE2("celegans",SRRvec,metadata=mdat,counts="GeneCounts")
x
# show sample level metadata
colData(x)[1:7]
# show the counts
head(assays(x)$counts)

## ----testabsent---------------------------------------------------------------
x <- getDEE2("celegans",c("SRR363798","SRR363799","SRR3581689","SRR3581692"),
    metadata=mdat,counts="GeneCounts")

## ----legacy-------------------------------------------------------------------
x <- getDEE2("celegans",SRRvec,metadata=mdat,legacy=TRUE)
names(x)
head(x$GeneCounts)
head(x$TxCounts)
head(x$QcMx)
head(x$GeneInfo)
head(x$TxInfo)

## ----bundle1------------------------------------------------------------------
bundles <- list_bundles("athaliana")
head(bundles)
query_bundles(species="athaliana",query="SRP058781",
    col="SRP_accession",bundles=bundles)
x <- getDEE2_bundle("athaliana", "SRP058781",
    col="SRP_accession",counts="GeneCounts")
    assays(x)$counts[1:6,1:4]

## ----bundle2------------------------------------------------------------------
x <- getDEE2_bundle("drerio", "GSE106677",
    col="GSE_accession",counts="GeneCounts")
    assays(x)$counts[1:6,1:4]

## ----sessioninfo,message=FALSE------------------------------------------------
sessionInfo()

