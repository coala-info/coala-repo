# Code example from 'enhancerHomologSearch' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", warning=FALSE, message=FALSE-----------------
suppressPackageStartupMessages({
  library(enhancerHomologSearch)
  library(BSgenome.Drerio.UCSC.danRer10)
  library(BSgenome.Hsapiens.UCSC.hg38)
  library(BSgenome.Mmusculus.UCSC.mm10)
  library(TxDb.Hsapiens.UCSC.hg38.knownGene)
  library(org.Hs.eg.db)
  library(TxDb.Mmusculus.UCSC.mm10.knownGene)
  library(org.Mm.eg.db)
  library(utils)
  library(MotifDb)
  library(motifmatchr)
})
pval <- NULL
distance <- NULL
knitr::opts_chunk$set(warning=FALSE, message=FALSE)

## ----installation,eval=FALSE--------------------------------------------------
# if (!"BiocManager" %in% rownames(installed.packages()))
#      install.packages("BiocManager")
# library(BiocManager)
# BiocManager::install(c("enhancerHomologSearch",
#                        "BiocParallel",
#                        "BSgenome.Drerio.UCSC.danRer10",
#                        "BSgenome.Hsapiens.UCSC.hg38",
#                        "BSgenome.Mmusculus.UCSC.mm10",
#                        "TxDb.Hsapiens.UCSC.hg38.knownGene",
#                        "TxDb.Mmusculus.UCSC.mm10.knownGene",
#                        "org.Hs.eg.db",
#                        "org.Mm.eg.db",
#                        "MotifDb",
#                        "motifmatchr"))

## -----------------------------------------------------------------------------
R.version

## -----------------------------------------------------------------------------
# load genome sequences
library(BSgenome.Drerio.UCSC.danRer10)
# define the enhancer genomic coordinates
LEN <- GRanges("chr4", IRanges(19050041, 19051709))
# extract the sequences as Biostrings::DNAStringSet object
(seqEN <- getSeq(BSgenome.Drerio.UCSC.danRer10, LEN))

## -----------------------------------------------------------------------------
# load library
library(enhancerHomologSearch)
library(BSgenome.Hsapiens.UCSC.hg38)
library(BSgenome.Mmusculus.UCSC.mm10)
# download enhancer candidates for human heart tissue
hs <- getENCODEdata(genome=Hsapiens,
                    partialMatch=c(biosample_summary = "heart"))
# download enhancer candidates for mouse heart tissue
mm <- getENCODEdata(genome=Mmusculus,
                    partialMatch=c(biosample_summary = "heart"))

## -----------------------------------------------------------------------------
# subset the data for test run 
# in human, the homolog LEP gene is located at chromosome 7
# In this test run, we will only use upstream 1M and downstream 1M of homolog
# gene
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
library(org.Hs.eg.db)
eid <- mget("LEP", org.Hs.egALIAS2EG)[[1]]
g_hs <- select(TxDb.Hsapiens.UCSC.hg38.knownGene,
               keys=eid,
               columns=c("GENEID", "TXCHROM", "TXSTART", "TXEND", "TXSTRAND"),
               keytype="GENEID")
g_hs <- range(with(g_hs, GRanges(TXCHROM, IRanges(TXSTART, TXEND))))
expandGR <- function(x, ext){
  stopifnot(length(x)==1)
  start(x) <- max(1, start(x)-ext)
  end(x) <- end(x)+ext
  GenomicRanges::trim(x)
}
hs <- subsetByOverlaps(hs, expandGR(g_hs, ext=1000000))
# in mouse, the homolog Lep gene is located at chromosome 6
# Here we use the subset of 1M upstream and downstream of homolog gene.
library(TxDb.Mmusculus.UCSC.mm10.knownGene)
library(org.Mm.eg.db)
eid <- mget("Lep", org.Mm.egALIAS2EG)[[1]]
g_mm <- select(TxDb.Mmusculus.UCSC.mm10.knownGene,
               keys=eid,
               columns=c("GENEID", "TXCHROM", "TXSTART", "TXEND", "TXSTRAND"),
               keytype="GENEID")
g_mm <- range(with(g_mm,
                   GRanges(TXCHROM,
                           IRanges(TXSTART, TXEND),
                           strand=TXSTRAND)))
g_mm <- g_mm[seqnames(g_mm) %in% "chr6" & strand(g_mm) %in% "+"]
mm <- subsetByOverlaps(mm, expandGR(g_mm, ext=1000000))

# search the binding pattern
data(motifs)
## In the package, there are 10 sets of motif cluster sets.
## In this example, we use motif clusters merged by distance 60, which 
## is calculated by matalgin (motifStack implementation)
PWMs <- motifs[["dist60"]]
## Here we set maximalShuffleEnhancers = 100 to decrease the computation time.
## The defaults of maximalShuffleEnhancers is 1000. Increase the shuffle number
## may help to get accurate P-value.
aln_hs <- searchTFBPS(seqEN, hs, PWMs = PWMs,
                      queryGenome = Drerio,
                      maximalShuffleEnhancers = 100)
aln_mm <- searchTFBPS(seqEN, mm, PWMs = PWMs,
                      queryGenome = Drerio,
                      maximalShuffleEnhancers = 100)
## if you want to stick to sequence similarity search, try to use ?alignmentOne

## -----------------------------------------------------------------------------
# Step4
ext <- 100000
aln_hs <- subsetByOverlaps(aln_hs, ranges = expandGR(g_hs, ext=ext))
## filter by distance
distance(aln_hs) <- distance(peaks(aln_hs), g_hs, ignore.strand=TRUE)
aln_hs <- subset(aln_hs, pval<0.1 & distance >5000)
aln_hs

aln_mm <- subsetByOverlaps(aln_mm, ranges = expandGR(g_mm, ext=ext))
## filter by distance
distance(aln_mm) <- distance(peaks(aln_mm), g_mm, ignore.strand=TRUE)
aln_mm <- subset(aln_mm, pval<0.1 & distance >5000)
aln_mm

## -----------------------------------------------------------------------------
aln_list <- list(human=aln_hs, mouse=aln_mm)
al <- alignment(seqEN, aln_list,
                method="ClustalW", order="input")
al

## -----------------------------------------------------------------------------
cm <- conservedMotifs(al[[1]], aln_list, PWMs, Drerio)

## -----------------------------------------------------------------------------
library(MotifDb)
motifs <- query(MotifDb, "JASPAR_CORE")
consensus <- sapply(motifs, consensusString)
consensus <- DNAStringSet(gsub("\\?", "N", consensus))
tmpfolder <- tempdir()
saveAlignments(al, output_folder = tmpfolder, motifConsensus=consensus)
readLines(file.path(tmpfolder, "aln1.phylip.txt"))

## -----------------------------------------------------------------------------
sessionInfo()

