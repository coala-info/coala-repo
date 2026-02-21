# Code example from 'ATACseqTFEA' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", warning=FALSE, message=FALSE-----------------
suppressPackageStartupMessages({
  library(ATACseqTFEA)
  library(BSgenome.Drerio.UCSC.danRer10)
  library(Rsamtools)
  library(ATACseqQC)
})
knitr::opts_chunk$set(warning=FALSE, message=FALSE, fig.width=5, fig.height=3.5)

## ----eval=FALSE---------------------------------------------------------------
# library(BiocManager)
# BiocManager::install(c("ATACseqTFEA",
#                        "ATACseqQC",
#                        "Rsamtools",
#                        "BSgenome.Drerio.UCSC.danRer10",
#                        "TxDb.Drerio.UCSC.danRer10.refGene"))

## -----------------------------------------------------------------------------
library(ATACseqTFEA)
library(BSgenome.Drerio.UCSC.danRer10) ## for binding sites search
library(ATACseqQC) ## for footprint

## -----------------------------------------------------------------------------
motifs <- readRDS(system.file("extdata", "PWMatrixList.rds",
                               package="ATACseqTFEA"))

## -----------------------------------------------------------------------------
motifs_human <- readRDS(system.file("extdata", "best_curated_Human.rds",
                                    package="ATACseqTFEA"))

## -----------------------------------------------------------------------------
MotifsSTARR <- readRDS(system.file("extdata", "cluster_PWMs.rds",
                                      package="ATACseqTFEA"))

## -----------------------------------------------------------------------------
# for test run, we use a subset of data within chr1:5000-100000
# for real data, use the merged peaklist as grange input.
# Drerio is the short-link of BSgenome.Drerio.UCSC.danRer10
seqlev <- "chr1" 
bindingSites <- 
  prepareBindingSites(motifs, Drerio, seqlev,
                      grange=GRanges("chr1", IRanges(5000, 100000)),
                      p.cutoff = 5e-05)#set higher p.cutoff to get more sites.

## -----------------------------------------------------------------------------
bamExp <- system.file("extdata",
                      c("KD.shift.rep1.bam",
                        "KD.shift.rep2.bam"),
                      package="ATACseqTFEA")
bamCtl <- system.file("extdata",
                      c("WT.shift.rep1.bam",
                        "WT.shift.rep2.bam"),
                      package="ATACseqTFEA")
res <- TFEA(bamExp, bamCtl, bindingSites=bindingSites,
            positive=0, negative=0) # the bam files were shifted reads

## -----------------------------------------------------------------------------
TF <- "Tal1::Gata1"
## volcanoplot
ESvolcanoplot(TFEAresults=res, TFnameToShow=TF)
### plot enrichment score for one TF
plotES(res, TF=TF, outfolder=NA)
## footprint
sigs <- factorFootprints(c(bamCtl, bamExp), 
                         pfm = as.matrix(motifs[[TF]]),
                         bindingSites = getBindingSites(res, TF=TF),
                         seqlev = seqlev, genome = Drerio,
                         upstream = 100, downstream = 100,
                         group = rep(c("WT", "KD"), each=2))
## export the results into a csv file
write.csv(res$resultsTable, tempfile(fileext = ".csv"), 
          row.names=FALSE)

## -----------------------------------------------------------------------------
# prepare the counting region
exbs <- expandBindingSites(bindingSites=bindingSites,
                           proximal=40,
                           distal=40,
                           gap=10)
## count reads by 5'ends
counts <- count5ends(bam=c(bamExp, bamCtl),
                     positive=0L, negative=0L,
                     bindingSites = bindingSites,
                     bindingSitesWithGap=exbs$bindingSitesWithGap,
                     bindingSitesWithProximal=exbs$bindingSitesWithProximal,
                     bindingSitesWithProximalAndGap=
                         exbs$bindingSitesWithProximalAndGap,
                     bindingSitesWithDistal=exbs$bindingSitesWithDistal)

## -----------------------------------------------------------------------------
colnames(counts)
counts <- eventsFilter(counts, "proximalRegion>0")

## -----------------------------------------------------------------------------
counts <- countsNormalization(counts, proximal=40, distal=40)

## -----------------------------------------------------------------------------
counts <- getWeightedBindingScore(counts)

## -----------------------------------------------------------------------------
design <- cbind(CTL=1, EXPvsCTL=c(1, 1, 0, 0))
counts <- DBscore(counts, design=design, coef="EXPvsCTL")

## -----------------------------------------------------------------------------
res <- doTFEA(counts)
res
plotES(res, TF=TF, outfolder=NA) ## will show same figure as above one

## -----------------------------------------------------------------------------
sessionInfo()

