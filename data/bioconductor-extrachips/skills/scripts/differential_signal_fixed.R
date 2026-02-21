# Code example from 'differential_signal_fixed' vignette. See references/ for full tutorial.

## ----setup--------------------------------------------------------------------
knitr::opts_chunk$set(message = FALSE, crop = NULL)

## ----load-packages------------------------------------------------------------
library(tidyverse)
library(Rsamtools)
library(csaw)
library(BiocParallel)
library(rtracklayer)
library(edgeR)
library(patchwork)
library(extraChIPs)
library(plyranges)
library(scales)
library(glue)
library(ggrepel)
library(here)
library(quantro)
theme_set(theme_bw())

## ----samples------------------------------------------------------------------
treat_levels <- c("E2", "E2DHT")
treat_colours <- setNames(c("steelblue", "red3"), treat_levels)
samples <- tibble(
  accession = paste0("SRR831518", seq(0, 5)),
  target = "ER",
  treatment = factor(rep(treat_levels, each = 3), levels = treat_levels)
)
samples

## ----accessions---------------------------------------------------------------
accessions <- samples %>% 
  split(f = .$treatment) %>% 
  lapply(pull, "accession")

## ----bfl, eval = FALSE--------------------------------------------------------
# bfl <- here("data", "ER", glue("{samples$accession}.bam")) %>%
#   BamFileList() %>%
#   setNames(str_remove_all(names(.), ".bam"))
# file.exists(path(bfl))

## ----sq-----------------------------------------------------------------------
sq <- defineSeqinfo("GRCh37")

## ----omit-ranges, eval = FALSE------------------------------------------------
# greylist <- import.bed(here("data/chr10_greylist.bed"), seqinfo = sq)
# blacklist <- import.bed( here("data/chr10_blacklist.bed"), seqinfo = sq)
# omit_ranges <- c(greylist, blacklist)

## ----fake-peaks, eval = FALSE-------------------------------------------------
# peaks <- here("data", "ER", glue("{samples$accession}_peaks.narrowPeak")) %>%
#   importPeaks(seqinfo = sq, blacklist = omit_ranges)

## ----load-peaks, echo = FALSE-------------------------------------------------
data("peaks")

## ----edit-peaknames-----------------------------------------------------------
names(peaks) <- str_remove_all(names(peaks), "_peaks.narrowPeak")

## ----plot-overlaps, fig.cap = "*UpSet plot showing overlapping peaks across all replicates*"----
plotOverlaps(
  peaks, min_size = 10, sort_sets = NULL,
  set_col = treat_colours[as.character(samples$treatment)]
)

## ----plot-overlaps-score, fig.height = 7, fig.cap = "*UpSet plot showing overlapping peaks across all replicates, with the maximum score across all replicates shown in the upper panel.*"----
plotOverlaps(
  peaks, min_size = 10, sort_sets = NULL, var = "score", f = "max",
   set_col = treat_colours[as.character(samples$treatment)]
)

## ----make-consensus-----------------------------------------------------------
consensus_e2 <- makeConsensus(peaks[accessions$E2], p = 2/3, var = "score")
consensus_e2dht <- makeConsensus(peaks[accessions$E2DHT], p = 2/3, var = "score")

## ----make-consensus-centre----------------------------------------------------
consensus_e2 <- peaks[accessions$E2] %>% 
  endoapply(mutate, centre = start + peak) %>% 
  makeConsensus(p = 2/3, var = "centre") %>% 
  mutate(centre = vapply(centre, mean, numeric(1)))
consensus_e2
consensus_e2dht <- peaks[accessions$E2DHT] %>% 
  endoapply(mutate, centre = start + peak) %>% 
  makeConsensus(p = 2/3, var = "centre") %>% 
  mutate(centre = vapply(centre, mean, numeric(1)))

## ----venn-consensus-overlap, fig.width=6, fig.cap = "*Overlap between consensus peaks identified in a treatment-specific manner*"----
GRangesList(E2 = granges(consensus_e2), E2DHT = granges(consensus_e2dht)) %>% 
  plotOverlaps(set_col = treat_colours[treat_levels])

## ----union-peaks--------------------------------------------------------------
union_peaks <- GRangesList(
  E2 = select(consensus_e2, centre), 
  E2DHT = select(consensus_e2dht, centre)
) %>% 
  makeConsensus(var = c("centre")) %>% 
  mutate(
    centre = vapply(centre, mean, numeric(1)) %>% round(0)
  ) 

## ----centred-peaks, eval = FALSE----------------------------------------------
# w <- 500
# centred_peaks <- union_peaks %>%
#   mutate(
#     centre = glue("{seqnames}:{centre}:{strand}") %>%
#       GRanges(seqinfo = sq) %>%
#       resize(width = w),
#     union_peak = granges(.)
#   ) %>%
#   colToRanges("centre")

## ----se, echo = FALSE---------------------------------------------------------
data("se")

## ----fake-se, eval = FALSE----------------------------------------------------
# se <- regionCounts(bfl, centred_peaks, ext = 200)

## ----show-se------------------------------------------------------------------
se

## ----edit-coldata-------------------------------------------------------------
colData(se) <- colData(se) %>% 
  as_tibble(rownames = "accession") %>% 
  left_join(samples) %>% 
  mutate(sample = accession) %>% 
  as.data.frame() %>% 
  DataFrame(row.names = .$accession)
colData(se)

## ----add-logcpm---------------------------------------------------------------
assay(se, "logCPM") <- cpm(assay(se, "counts"), lib.size = se$totals, log = TRUE)

## ----plot-assay-densities, fig.cap = "*Count densities for all samples, using the log+1 transformation*"----
plotAssayDensities(se, assay = "counts", colour = "treat", trans = "log1p") +
  scale_colour_manual(values = treat_colours)

## ----plot-pca, fig.cap = "*PCA plot using logCPM values and showing that replicate variability is larger than variability between treatment groups.*"----
plotAssayPCA(se, assay = "logCPM", colour = "treat", label = "sample") +
  scale_colour_manual(values = treat_colours)

## ----ls-fit-------------------------------------------------------------------
X <- model.matrix(~treatment, data = colData(se))
ls_res <- fitAssayDiff(se, design = X, asRanges = TRUE)
sum(ls_res$FDR < 0.05)

## ----qtest--------------------------------------------------------------------
set.seed(100)
qtest <- assay(se, "counts") %>% 
  quantro(groupFactor = se$treatment, B = 1e3)
qtest

## ----tmm-res------------------------------------------------------------------
tmm_res <- fitAssayDiff(se, design = X, norm = "TMM", asRanges = TRUE, fc = 1.2)
sum(tmm_res$FDR < 0.05)

## ----plot-ma, fig.cap = "*MA-plot after fitting using TMM normalisation and applying a fold-change threshold during testing. Points are labelled using the original windows obtained when merging replicates and treatment groups.*"----
tmm_res %>% 
  as_tibble() %>% 
  mutate(`FDR < 0.05` = FDR < 0.05) %>% 
  ggplot(aes(logCPM, logFC)) +
  geom_point(aes(colour = `FDR < 0.05`)) +
  geom_smooth(se = FALSE) +
  geom_label_repel(
    aes(label = union_peak), colour = "red",
    data = . %>% dplyr::filter(FDR < 0.05)
  ) +
  scale_colour_manual(values = c("black", "red"))

## ----gencode, eval = FALSE----------------------------------------------------
# gencode <- here("data/gencode.v43lift37.chr10.annotation.gtf.gz") %>%
#   import.gff() %>%
#   filter_by_overlaps(GRanges("chr10:42354900-100000000")) %>%
#   split(.$type)
# seqlevels(gencode) <- seqlevels(sq)
# seqinfo(gencode) <- sq

## ----promoters, eval = FALSE--------------------------------------------------
# promoters <- gencode$transcript %>%
#     select(gene_id, ends_with("name")) %>%
#     promoters(upstream = 2500, downstream = 500) %>%
#     reduceMC(simplify = FALSE)
# promoters

## ----tmm-mapped-res, eval = FALSE---------------------------------------------
# tmm_mapped_res <- tmm_res %>%
#   colToRanges("union_peak") %>%
#   mapByFeature(genes = gencode$gene, prom = promoters) %>%
#   addDiffStatus()
# arrange(tmm_mapped_res, PValue)

## ----profile-heatmap, eval = FALSE--------------------------------------------
# fe_bw <- here("data", "ER", glue("{treat_levels}_FE_chr10.bw")) %>%
#   BigWigFileList() %>%
#   setNames(treat_levels)
# sig_ranges <- filter(tmm_mapped_res, FDR < 0.05)
# pd_fe <- getProfileData(fe_bw, sig_ranges, log = FALSE)
# pd_fe %>%
#   plotProfileHeatmap("profile_data", facetY = "status") +
#   scale_fill_gradient(low = "white", high = "red") +
#   labs(fill = "Fold\nEnrichment")

## ----session-info-------------------------------------------------------------
sessionInfo()

