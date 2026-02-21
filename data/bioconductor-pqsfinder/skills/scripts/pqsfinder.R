# Code example from 'pqsfinder' vignette. See references/ for full tutorial.

## ----pqsfinder, message=FALSE, warning=FALSE----------------------------------
library(pqsfinder)

## ----basic_detection, results='hold'------------------------------------------
seq <- DNAString("TTTTGGGCGGGAGGAGTGGAGTTTTTAACCCCAAAAATTTGGGAGGGTGGGTGGGAGAA")
pqs <- pqsfinder(seq, min_score = 20)
pqs

## ----accessors----------------------------------------------------------------
elementMetadata(pqs)

## ----overlapping--------------------------------------------------------------
pqsfinder(seq, overlapping = TRUE, min_score = 30)

## ----density------------------------------------------------------------------
pqs <- pqsfinder(seq, deep = TRUE, min_score = 20)
density(pqs)

## ----density_viz, fig.height=1.5, fig.width=8.0, message=FALSE----------------
library(Gviz)
ss <- DNAStringSet(seq)
names(ss) <- "chr1"
dtrack <- DataTrack(
  start = 1:length(density(pqs)), width = 1, data = density(pqs),
  chromosome = "chr1", genome = "", name = "density")
strack <- SequenceTrack(ss, chromosome = "chr1", name = "sequence")
suppressWarnings(plotTracks(c(dtrack, strack), type = "h"))

## ----perfect_g4, results='hold'-----------------------------------------------
pqsfinder(seq, max_defects = 0, min_score = 20)

## ----min_score, results='hold'------------------------------------------------
pqsfinder(seq, min_score = 70)

## ----granges_conversion-------------------------------------------------------
gr <- as(pqs, "GRanges")
gr

## ----granges_export-----------------------------------------------------------
library(rtracklayer)
export(gr, "test.gff", version = "3")

## ----gff_file, echo=FALSE, comment=NA-----------------------------------------
text <- readLines("test.gff")
cat(strwrap(text, width = 80, exdent = 3), sep = "\n")

## ----dnastringset_conversion--------------------------------------------------
dss <- as(pqs, "DNAStringSet")
dss

## ----dnastringset_export------------------------------------------------------
writeXStringSet(dss, file = "test.fa", format = "fasta")

## ----fasta_file, echo=FALSE, comment=NA---------------------------------------
text <- readLines("test.fa")
cat(text, sep = "\n")

## ----rwe_libraries, message=FALSE---------------------------------------------
library(pqsfinder)
library(BSgenome.Hsapiens.UCSC.hg38)
library(rtracklayer)
library(ggplot2)
library(Gviz)

## ----rwe_biomart, warning=FALSE-----------------------------------------------
gnm <- "hg38"
gene <- "AHNAK"
# Load cached AHNAK region track:
load(system.file("extdata", "gtrack_ahnak.RData", package="pqsfinder"))
# Alternatively, query biomaRt API with the following commands:
# library(biomaRt)
# gtrack <- BiomartGeneRegionTrack(genome = gnm, symbol = gene, name = gene)

## ----rwe_seq------------------------------------------------------------------
extend <- 1000
seq_start <- min(start(gtrack)) - extend
seq_end <- max(end(gtrack)) + extend
chr <- chromosome(gtrack)
seq <- Hsapiens[[chr]][seq_start:seq_end]

## ----rwe_pqsfinder, results='hide'--------------------------------------------
pqs <- pqsfinder(seq, deep = TRUE)

## ----rwe_show, message=FALSE--------------------------------------------------
pqs

## ----rwe_sort-----------------------------------------------------------------
pqs_s <- pqs[order(score(pqs), decreasing = TRUE)]
pqs_s

## ----rwe_gff------------------------------------------------------------------
export(as(pqs, "GRanges"), "test.gff", version = "3")

## ----rwe_gff_file, echo=FALSE, comment=NA-------------------------------------
text <- readLines("test.gff", n = 5)
cat(strwrap(text, width = 80, exdent = 3), sep= "\n")

## ----rwe_fasta----------------------------------------------------------------
writeXStringSet(as(pqs, "DNAStringSet"), file = "test.fa", format = "fasta")

## ----rwe_fasta_file, echo=FALSE, comment=NA-----------------------------------
text <- readLines("test.fa", n = 6)
cat(text, sep = "\n")

## ----rwe_hist, fig.height=4, fig.width=6--------------------------------------
sf <- data.frame(score = score(pqs))
ggplot(sf) + geom_histogram(mapping = aes(x = score), binwidth = 5)

## ----rwe_viz, fig.height=4.0, fig.width=8.0-----------------------------------
strack <- DataTrack(
  start = start(pqs)+seq_start, end = end(pqs)+seq_start,
  data = score(pqs), chromosome = chr, genome = gnm, name = "score")
dtrack <- DataTrack(
  start = (seq_start):(seq_start+length(density(pqs))-1), width = 1,
  data = density(pqs), chromosome = chr, genome = gnm,
  name = "density")
atrack <- GenomeAxisTrack()
suppressWarnings(plotTracks(c(gtrack, strack, dtrack, atrack), type = "h"))

## ----custom_scoring_fn--------------------------------------------------------
c_loop_bonus <- function(subject, score, start, width, loop_1,
                         run_2, loop_2, run_3, loop_3, run_4) {
  l1 <- run_2 - loop_1
  l2 <- run_3 - loop_2
  l3 <- run_4 - loop_3
  if (l1 == l2 && l1 == l3 && subject[loop_1] == DNAString("C") &&
      subject[loop_1] == subject[loop_2] &&
      subject[loop_1] == subject[loop_3]) {
    score <- score + 20
  }
  return(score)
}

## ----no_custom_scoring, results='hold'----------------------------------------
seq <- DNAString("GGGCGGGCGGGCGGGAAAAAAAAAAAAAGGGAGGGAGGGAGGG")
pqsfinder(seq)

## ----custom_scoring, results='hold'-------------------------------------------
pqsfinder(seq, custom_scoring_fn = c_loop_bonus)

## ----isg4_scoring_function----------------------------------------------------
isG4 <- function(subject, score, start, width, loop_1,
                 run_2, loop_2, run_3, loop_3, run_4) {
  r1 <- loop_1 - start
  r2 <- loop_2 - run_2
  r3 <- loop_3 - run_3
  r4 <- start + width - run_4
  
  if (!(r1 == r2 && r1 == r3 && r1 == r4))
    return(0)
  
  run_1_s <- subject[start:start+r1-1]
  run_2_s <- subject[run_2:run_2+r2-1]
  run_3_s <- subject[run_3:run_3+r3-1]
  run_4_s <- subject[run_4:run_4+r4-1]
  
  if (length(grep("^G+$", run_1_s)) && length(grep("^C+$", run_2_s)) &&
      length(grep("^G+$", run_3_s)) && length(grep("^C+$", run_4_s)))
    return(r1 * 20)
  else
    return(0)
}

## ----isg4_pqsfinder, results='hold'-------------------------------------------
pqsfinder(DNAString("AAAAGGGATCCCTAAGGGGTCCC"), strand = "+",
          use_default_scoring = FALSE, run_re = "G{3,6}|C{3,6}",
          custom_scoring_fn = isG4)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

