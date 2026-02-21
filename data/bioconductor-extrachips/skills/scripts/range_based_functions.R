# Code example from 'range_based_functions' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE--------------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## ----install, eval = FALSE----------------------------------------------------
# if (!"BiocManager" %in% rownames(installed.packages()))
#   install.packages("BiocManager")
# BiocManager::install(c("tidyverse", "plyranges", "Gviz"))
# BiocManager::install("extraChIPs")

## ----gr-----------------------------------------------------------------------
library(tidyverse)
library(extraChIPs)
set.seed(73)
df <- tibble(
  range = c("chr1:1-10:+", "chr1:5-10:+", "chr1:5-6:+"),
  gene_id = "gene1",
  tx_id = paste0("transcript", 1:3),
  score = runif(3)
)
df
gr <- colToRanges(df, "range")
gr

## ----as-tibble----------------------------------------------------------------
as_tibble(gr)
as_tibble(gr, rangeAsChar = FALSE)

## ----collapse-gene, results='asis'--------------------------------------------
gn <- c("Gene1", "Gene2", "Gene3")
collapseGenes(gn)

## ----load-peaks---------------------------------------------------------------
fl <- system.file(
    c("extdata/ER_1.narrowPeak", "extdata/ER_2.narrowPeak"),
    package = "extraChIPs"
)
peaks <- importPeaks(fl)
names(peaks) <- c("ER_1", "ER_2")

## ----make-consensus1----------------------------------------------------------
makeConsensus(peaks)

## ----make-consensus2----------------------------------------------------------
makeConsensus(peaks, p = 1)

## ----make-consensus-var-------------------------------------------------------
makeConsensus(peaks, p = 1, var = "qValue")

## ----make-consensus-mutate----------------------------------------------------
library(plyranges)
peaks %>% 
    endoapply(mutate, centre = start + peak) %>% 
    makeConsensus(p = 1, var = "centre")

## ----make-consensus-centre----------------------------------------------------
peaks %>% 
    endoapply(mutate, centre = start + peak) %>% 
    makeConsensus(p = 1, var = "centre") %>% 
    mutate(centre = vapply(centre, mean, numeric(1)))

## ----tss----------------------------------------------------------------------
tss <- resize(gr, width = 1)
tss

## ----reduce-------------------------------------------------------------------
GenomicRanges::reduce(tss)
reduceMC(tss)

## ----reduce-no-simplify-------------------------------------------------------
reduceMC(tss, simplify = FALSE) 

## ----reduce-unnest------------------------------------------------------------
reduceMC(tss, simplify = FALSE) %>% 
  as_tibble() %>% 
  unnest(everything())

## ----chop---------------------------------------------------------------------
chopMC(tss)

## ----distinct-----------------------------------------------------------------
distinctMC(tss)
distinctMC(tss, gene_id)

## ----setopts------------------------------------------------------------------
peaks <- GRanges(c("chr1:1-5", "chr1:9-12:*"))
peaks$peak_id <- c("peak1", "peak2")
GenomicRanges::intersect(gr, peaks, ignore.strand = TRUE)
intersectMC(gr, peaks, ignore.strand = TRUE)
setdiffMC(gr, peaks, ignore.strand = TRUE)
unionMC(gr, peaks, ignore.strand = TRUE)

## ----setopts-plyranges--------------------------------------------------------
gr %>% 
  select(tx_id) %>% 
  intersectMC(peaks, ignore.strand = TRUE)

## ----prop-overlaps------------------------------------------------------------
propOverlap(gr, peaks)

## ----best-overlap-------------------------------------------------------------
bestOverlap(gr, peaks, var = "peak_id")

## ----partition-ranges---------------------------------------------------------
partitionRanges(gr, peaks)

## ----partition-ranges-subset--------------------------------------------------
partitionRanges(gr, peaks) %>% 
  subset(is.na(peak_id))

## ----stitch-ranges------------------------------------------------------------
enh <- GRanges(c("chr1:1-10", "chr1:101-110", "chr1:181-200"))
prom <- GRanges("chr1:150:+")
se <- stitchRanges(enh, exclude = prom, maxgap = 100)
se

## ----plot-stitched, echo = FALSE, fig.height=3, fig.width=8-------------------
knitr::include_graphics("stitched.png")

## ----session-info-------------------------------------------------------------
sessionInfo()

