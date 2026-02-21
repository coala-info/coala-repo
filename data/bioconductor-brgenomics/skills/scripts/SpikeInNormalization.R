# Code example from 'SpikeInNormalization' vignette. See references/ for full tutorial.

## ---- message = FALSE---------------------------------------------------------
library(BRGenomics)

## ---- echo = FALSE------------------------------------------------------------
gr1_rep1 <- GRanges(seqnames = c("chr1", "chr2", "spikechr1", "spikechr2"),
                    ranges = IRanges(start = 1:4, width = 1),
                    strand = "+")
gr2_rep2 <- gr2_rep1 <- gr1_rep2 <- gr1_rep1

# set readcounts
score(gr1_rep1) <- c(1, 1, 1, 1) # 2 exp + 2 spike = 4 total
score(gr2_rep1) <- c(2, 2, 1, 1) # 4 exp + 2 spike = 6 total
score(gr1_rep2) <- c(1, 1, 2, 1) # 2 exp + 3 spike = 5 total
score(gr2_rep2) <- c(4, 4, 2, 2) # 8 exp + 4 spike = 12 total

grl <- list(gr1_rep1, gr2_rep1,
            gr1_rep2, gr2_rep2)

names(grl) <- c("gr1_rep1", "gr2_rep1",
                "gr1_rep2", "gr2_rep2")

## -----------------------------------------------------------------------------
grl[1:2]

## -----------------------------------------------------------------------------
getSpikeInCounts(grl, si_pattern = "spike", ncores = 1)

## -----------------------------------------------------------------------------
removeSpikeInReads(grl[1:2], si_pattern = "spike", ncores = 1)

## -----------------------------------------------------------------------------
getSpikeInNFs(grl, si_pattern = "spike", ctrl_pattern = "gr1", ncores = 1)

## -----------------------------------------------------------------------------
spikeInNormGRanges(grl, si_pattern = "spike", ctrl_pattern = "gr1", ncores = 1)

## -----------------------------------------------------------------------------
data("PROseq")
data("txs_dm6_chr4")

## -----------------------------------------------------------------------------
# choose a single gene
gene_i <- txs_dm6_chr4[185]
reads.gene_i <- subsetByOverlaps(PROseq, gene_i)

# sample half the raw reads
set.seed(11)
sreads.gene_i <- subsampleGRanges(reads.gene_i, prop = 0.5, ncores = 1)

# downscale raw reads by a factor of 2
score(reads.gene_i) <- 0.5 * score(reads.gene_i)

## ---- collapse = TRUE---------------------------------------------------------
sum(score(reads.gene_i))
sum(score(sreads.gene_i))

## ---- results = "hold"--------------------------------------------------------
plot(x = 1:width(gene_i), 
     y = getCountsByPositions(sreads.gene_i, gene_i),
     type = "h", ylim = c(0, 20),
     main = "PRO-seq (down-sampled)",
     xlab = "Distance from TSS", ylab = "Down-sampled PRO-seq Reads")

plot(x = 1:width(gene_i), 
     y = getCountsByPositions(reads.gene_i, gene_i),
     type = "h",  ylim = c(0, 20),
     main = "PRO-seq (down-scaled)", 
     xlab = "Distance from TSS",  ylab = "Down-scaled PRO-seq Reads")

## -----------------------------------------------------------------------------
removeSpikeInReads(grl, si_pattern = "spike", ncores = 1)
getSpikeInNFs(grl, si_pattern = "spike", method = "SNR", batch_norm = FALSE,
              ncores = 1)
subsampleBySpikeIn(grl, si_pattern = "spike", batch_norm = FALSE, ncores = 1)

