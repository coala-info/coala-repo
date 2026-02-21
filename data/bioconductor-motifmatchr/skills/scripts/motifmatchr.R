# Code example from 'motifmatchr' vignette. See references/ for full tutorial.

## ----message = FALSE----------------------------------------------------------
library(motifmatchr)
library(GenomicRanges)
library(SummarizedExperiment)
library(BSgenome)

# load some example motifs
data(example_motifs, package = "motifmatchr") 

# Make a set of peaks
peaks <- GRanges(seqnames = c("chr1","chr2","chr2"),
                 ranges = IRanges(start = c(76585873,42772928,100183786),
                                  width = 500))

# Get motif matches for example motifs in peaks 
motif_ix <- matchMotifs(example_motifs, peaks, genome = "hg19") 
motifMatches(motif_ix) # Extract matches matrix from result

# Get motif positions within peaks for example motifs in peaks 
motif_pos <- matchMotifs(example_motifs, peaks, genome = "hg19", 
                         out = "positions") 

## -----------------------------------------------------------------------------
# using peaks
motif_ix_peaks <- matchMotifs(example_motifs, peaks, genome = "hg19") 

# using SummarizedExperiment
example_SummarizedExperiment <- 
    SummarizedExperiment(assays = list(counts = matrix(1,
                                                       ncol = 4,
                                                       nrow = 3)),
                         rowRanges = peaks)

motif_ix_SummarizedExperiment <- matchMotifs(example_motifs,
                                              example_SummarizedExperiment, 
                                              genome = "hg19") 

all.equal(motifMatches(motif_ix_peaks),
          motifMatches(motif_ix_SummarizedExperiment))

## ----message = FALSE----------------------------------------------------------
# using BSgenomeViews

example_BSgenomeViews <- BSgenomeViews(BSgenome.Hsapiens.UCSC.hg19, peaks)

motif_ix_BSgenomeViews <- matchMotifs(example_motifs, example_BSgenomeViews) 


all.equal(motifMatches(motif_ix_peaks), motifMatches(motif_ix_BSgenomeViews))

## ----message = FALSE----------------------------------------------------------
# using DNAStringSet
library(Biostrings)
library(BSgenome.Hsapiens.UCSC.hg19)

example_DNAStringSet <- getSeq(BSgenome.Hsapiens.UCSC.hg19, peaks)

motif_ix_DNAStringSet <- matchMotifs(example_motifs, example_DNAStringSet) 

all.equal(motifMatches(motif_ix_peaks), motifMatches(motif_ix_DNAStringSet))

## ----message = FALSE----------------------------------------------------------
# using character vector
example_character <- as.character(example_DNAStringSet)

motif_ix_character <- matchMotifs(example_motifs, example_character) 


all.equal(motifMatches(motif_ix_peaks), motifMatches(motif_ix_character))

## -----------------------------------------------------------------------------
motif_ix <- matchMotifs(example_motifs, peaks, genome = "hg19", bg = "even") 

## -----------------------------------------------------------------------------
motif_ix <- matchMotifs(example_motifs, peaks, genome = "hg19", bg = "genome") 

## -----------------------------------------------------------------------------
motif_ix <- matchMotifs(example_motifs, peaks, genome = "hg19",
                         bg = c("A" = 0.2,"C" = 0.3, "G" = 0.3, "T" = 0.2)) 

## ----message = FALSE----------------------------------------------------------
library(TFBSTools)
example_pwms <- do.call(PWMatrixList,lapply(example_motifs, toPWM, 
                                            pseudocounts = 0.5))

## -----------------------------------------------------------------------------
motif_ix <- matchMotifs(example_motifs, peaks, genome = "hg19") 
print(motif_ix)
head(motifMatches(motif_ix))

motif_ix_scores <- matchMotifs(example_motifs, peaks, 
                                genome = "hg19", out = "scores")
print(motif_ix_scores)
head(motifMatches(motif_ix_scores))
head(motifScores(motif_ix_scores))
head(motifCounts(motif_ix_scores))

motif_pos <- matchMotifs(example_motifs, peaks, genome = "hg19", 
                          out = "positions") 
print(motif_pos)

## -----------------------------------------------------------------------------
Sys.Date()

## -----------------------------------------------------------------------------
sessionInfo()

