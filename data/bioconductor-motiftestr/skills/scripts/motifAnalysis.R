# Code example from 'motifAnalysis' vignette. See references/ for full tutorial.

## ----setup, echo = FALSE------------------------------------------------------
knitr::opts_chunk$set(message = FALSE, crop = NULL)

## ----load-packages------------------------------------------------------------
library(motifTestR)
library(rtracklayer)
library(BSgenome.Hsapiens.UCSC.hg19)
library(parallel)
library(ggplot2)
library(patchwork)
library(universalmotif)
library(extraChIPs)
theme_set(theme_bw())
cores <- 1

## ----load-ar-er-peaks, echo = FALSE-------------------------------------------
data("ar_er_peaks")

## ----load-example-peaks-------------------------------------------------------
data("ar_er_peaks")
ar_er_peaks
sq <- seqinfo(ar_er_peaks)

## ----test-seq-----------------------------------------------------------------
test_seq <- getSeq(BSgenome.Hsapiens.UCSC.hg19, ar_er_peaks)
names(test_seq) <- as.character(ar_er_peaks)

## ----ex-pwm-------------------------------------------------------------------
data("ex_pfm")
names(ex_pfm)
ex_pfm$ESR1

## ----match-esr1---------------------------------------------------------------
score_thresh <- "70%"
getPwmMatches(ex_pfm$ESR1, test_seq, min_score = score_thresh)

## ----best-match-esr1----------------------------------------------------------
getPwmMatches(ex_pfm$ESR1, test_seq, min_score = score_thresh, best_only = TRUE)

## ----bm-all-------------------------------------------------------------------
bm_all <- getPwmMatches(
  ex_pfm, test_seq, min_score = score_thresh, best_only = TRUE, break_ties = "all",
  mc.cores = cores
)

## ----count-pwm-matches--------------------------------------------------------
countPwmMatches(ex_pfm, test_seq, min_score = score_thresh, mc.cores = cores)

## ----test-motif-pos-----------------------------------------------------------
res_pos <- testMotifPos(bm_all, mc.cores = cores)
head(res_pos)

## ----test-motif-pos-abs-------------------------------------------------------
res_abs <- testMotifPos(bm_all, abs = TRUE, mc.cores = cores) 
head(res_abs)

## ----plot-pos, fig.cap = "Distribution of motif matches around the centres of the set of peaks", fig.alt="Two panel plot with the left panel showing the probability distribution of motif matches for ESR1, ANDR and FOXA1 within the set of test sequences as coloured lines. The right panel shows the counts within each 10bp bin around the centre of the sequences with a loess curve overlaid"----
topMotifs <- res_pos |>
    subset(fdr < 0.05) |>
    rownames()
A <- plotMatchPos(bm_all[topMotifs], binwidth = 10, se = FALSE)
B <- plotMatchPos(
    bm_all[topMotifs], binwidth = 10, geom = "col", use_totals = TRUE
) +
  geom_smooth(se = FALSE, show.legend = FALSE) +
  facet_wrap(~name)
A + B + plot_annotation(tag_levels = "A") & theme(legend.position = "bottom")

## ----plot-abs-pos, fig.cap = "Distribution of motif matches shown as a distance from the centre of each sequence", fig.alt="Two panel plot with the left panel showing the distances from the sequence centres of the best matches for FOXA1, ANDR and ESR1. The right panel shows the CDF of these matches as a line plot"----
topMotifs <- res_abs |>
    subset(fdr < 0.05) |>
    rownames()
A <- plotMatchPos(bm_all[topMotifs], abs = TRUE, type = "heatmap") +
  scale_fill_viridis_c()
B <- plotMatchPos(
  bm_all[topMotifs], abs = TRUE, type = "cdf", geom = "line", binwidth = 5
)
A + B + plot_annotation(tag_levels = "A") & theme(legend.position = "bottom")

## ----zr75-enh-----------------------------------------------------------------
data("zr75_enh")
mean(overlapsAny(ar_er_peaks, zr75_enh))

## ----define-bg-ranges---------------------------------------------------------
ar_er_peaks$feature <- ifelse(
  overlapsAny(ar_er_peaks, zr75_enh), "enhancer", "other"
)
chr1 <- GRanges(sq)[1]
bg_ranges <- GRangesList(
  enhancer = zr75_enh,
  other = GenomicRanges::setdiff(chr1, zr75_enh)
)

## ----rm-ranges----------------------------------------------------------------
data("hg19_mask")
set.seed(305)
rm_ranges <- makeRMRanges(
  splitAsList(ar_er_peaks, ar_er_peaks$feature),
  bg_ranges, exclude = hg19_mask,
  n_iter = 100
)

## ----rm-seq-------------------------------------------------------------------
rm_seq <- getSeq(BSgenome.Hsapiens.UCSC.hg19, rm_ranges)
mcols(rm_seq) <- mcols(rm_ranges)

## ----enrich-res---------------------------------------------------------------
enrich_res <- testMotifEnrich(
  ex_pfm, test_seq, rm_seq, min_score = score_thresh, model = "quasi", mc.cores = cores
)
head(enrich_res)

## ----iter-res-----------------------------------------------------------------
iter_res <- testMotifEnrich(
  ex_pfm, test_seq, rm_seq, min_score = score_thresh, mc.cores = cores, model = "iteration"
)
head(iter_res)

## ----plot-overlaps, fig.cap = "Distribution of select PWM matches within sequences. Each sequence is only considered once and as such, match numbers may be below those returned during testing, which includes multiple matches within a sequence.", fig.alt = "UpSet plot showing the sequences which match one or more of the PWMs in the example dataset."----
ex_pfm |>
  getPwmMatches(test_seq, min_score = score_thresh, mc.cores = cores) |>
  lapply(\(x) x$seq) |>
  plotOverlaps(type = "upset")

## ----compare-andr-foxa1, fig.cap = "Binding Motifs for ANDR and FOXA1 overlaid for the best alignment, showing the similarity in the core regions.", fig.alt="Binding Motifs for ANDR and FOXA1 overlaid for the best alignment, showing the similarity in the core regions."----
c("ANDR", "FOXA1") |>
    lapply(
        \(x) create_motif(ex_pfm[[x]], name = x, type = "PPM")
    ) |>
    view_motifs()

## ----ex-cl, fig.cap = "Plot produced when requested by clusterMotifs showing the relationship between motifs. The red horizontal line indicates the threshold below which motifs are grouped together into a cluster. Clustering is performed using hclust on the distance matrices produced by `universalmotif::compare_motifs()`", fig.alt = "Dendrogram showing clusters formed by `clusterMotifs()` with default settings."----
cl <- clusterMotifs(ex_pfm, plot = TRUE, labels = NULL)
ex_cl <- split(ex_pfm, cl)
names(ex_cl) <- vapply(split(names(cl), cl), paste, character(1), collapse = "/")

## ----cl-matches---------------------------------------------------------------
cl_matches <- getClusterMatches(
    ex_cl, test_seq, min_score = score_thresh, best_only = TRUE
)
cl_matches

## ----test-cluster-pos---------------------------------------------------------
testClusterPos(cl_matches, test_seq, abs = TRUE)

## ----test-cluster-enrich------------------------------------------------------
testClusterEnrich(
  ex_cl, test_seq, rm_seq, min_score = score_thresh, model = "quasi", mc.cores = cores
)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

