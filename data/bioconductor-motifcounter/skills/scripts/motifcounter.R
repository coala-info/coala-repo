# Code example from 'motifcounter' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(knitr)
knit_hooks$set(plot = function(x, options) {
    paste('<figure><img src="',
        opts_knit$get('base.url'), paste(x, collapse = '.'),
        '"><figcaption>', options$fig.cap, '</figcaption></figure>',
        sep = '')
})
library(motifcounter)
library(MotifDb)
library(seqLogo)
opts_chunk$set(fig.path="fig/")

## ----eval=FALSE---------------------------------------------------------------
# # Estimate a background model on a set of sequences
# bg <- readBackground(sequences, order)

## ----eval=FALSE---------------------------------------------------------------
# # Normalize a given PFM
# new_motif <- normalizeMotif(motif)

## ----eval=FALSE---------------------------------------------------------------
# # Evaluate the scores along a given sequence
# scores <- scoreSequence(sequence, motif, bg)

## ----eval=FALSE---------------------------------------------------------------
# # Evaluate the motif hits along a given sequence
# hits <- motifHits(sequence, motif, bg)

## ----eval=FALSE---------------------------------------------------------------
# # Evaluate the average score profile
# average_scores <- scoreProfile(sequences, motif, bg)

## ----eval=FALSE---------------------------------------------------------------
# # Evaluate the average motif hit profile
# average_hits <- motifHitProfile(sequences, motif, bg)

## ----eval=FALSE---------------------------------------------------------------
# # Compute the motif hit enrichment
# enrichment_result <- motifEnrichment(sequences, motif, bg)

## -----------------------------------------------------------------------------
order <- 1
file <- system.file("extdata", "seq.fasta", package = "motifcounter")
seqs <- Biostrings::readDNAStringSet(file)
bg <- readBackground(seqs, order)

## -----------------------------------------------------------------------------
# Extract the Oct4 motif from MotifDb
library(MotifDb)
oct4 <- as.list(query(query(query(MotifDb, "hsapiens"), 
                "pou5f1"), "jolma2013"))[[1]]
motif <- oct4

# Visualize the motif using seqLogo
library(seqLogo)
seqLogo(motif)

## -----------------------------------------------------------------------------
new_motif <- normalizeMotif(motif)

## ----eval=FALSE---------------------------------------------------------------
# alpha <- 0.01
# motifcounterOptions(alpha)

## -----------------------------------------------------------------------------
file <- system.file("extdata", "oct4_chipseq.fa", package = "motifcounter")
oct4peaks <- Biostrings::readDNAStringSet(file)

## ----fig.show=TRUE, fig.cap="Per-position and strand scores"------------------
# Determine the per-position and per-strand scores
scores <- scoreSequence(oct4peaks[[1]], motif, bg)

# As a comparison, compute the theoretical score distribution
sd <- scoreDist(motif, bg)

par(mfrow = c(1, 2))
# Plot the observed scores, per position and per strand
plot(1:length(scores$fscores), scores$fscores, type = "l", 
    col = "blue", xlab = "position", ylab = "score", 
    ylim = c(min(sd$score), max(sd$score)), xlim = c(1, 250))
points(scores$rscores, col = "red", type = "l")
legend("topright", c("forw.", "rev."), col = c("blue", "red"), lty = c(1, 1))

# Plot the theoretical score distribution for the comparison
plot(sd$dist, sd$scores, type = "l", xlab = "probability", ylab = "")

## -----------------------------------------------------------------------------
# Call putative TFBSs
mhits <- motifHits(oct4peaks[[1]], motif, bg)

# Inspect the result
fhitpos <- which(mhits$fhits == 1)
rhitpos <- which(mhits$rhits == 1)
fhitpos
rhitpos

## -----------------------------------------------------------------------------
oct4peaks[[1]][rhitpos:(rhitpos + ncol(motif) - 1)]

## -----------------------------------------------------------------------------
# Prescribe a new false positive level for calling TFBSs
motifcounterOptions(alpha = 0.01)

# Determine TFBSs
mhits <- motifHits(oct4peaks[[1]], motif, bg)

fhitpos <- which(mhits$fhits == 1)
rhitpos <- which(mhits$rhits == 1)
fhitpos
rhitpos

## ----fig.show=TRUE, fig.cap="Average score profile"---------------------------
# Determine the average score profile across all Oct4 binding sites
scores <- scoreProfile(oct4peaks, motif, bg)

plot(1:length(scores$fscores), scores$fscores, type = "l", 
    col = "blue", xlab = "position", ylab = "score")
points(scores$rscores, col = "red", type = "l")
legend("bottomleft", legend = c("forward", "reverse"), 
    col = c("blue", "red"), lty = c(1, 1))

## ----fig.show=TRUE, fig.cap="Average motif hit profile"-----------------------
motifcounterOptions()  # let's use the default alpha=0.001 again

# Determine the average motif hit profile
mhits <- motifHitProfile(oct4peaks, motif, bg)

plot(1:length(mhits$fhits), mhits$fhits, type = "l", 
    col = "blue", xlab = "position", ylab = "score")
points(mhits$rhits, col = "red", type = "l")
legend("bottomleft", legend = c("forward", "reverse"), 
    col = c("blue", "red"), lty = c(1, 1))

## -----------------------------------------------------------------------------
# Enrichment of Oct4 in Oct4-ChIP-seq peaks
result <- motifEnrichment(oct4peaks[1:10], motif, bg)
result

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

