# Code example from 'differential_signal_sliding' vignette. See references/ for full tutorial.

## ----setup--------------------------------------------------------------------
knitr::opts_chunk$set(message = FALSE, crop = NULL)

## ----load-packages, eval = TRUE-----------------------------------------------
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
library(here)
library(magrittr)
library(quantro)
library(ggrepel)
theme_set(theme_bw())

## ----samples, eval = FALSE----------------------------------------------------
# samples <- here("data", "PRJNA509779.tsv") %>%
#   read_tsv() %>%
#   dplyr::filter(target == "H3K27ac") %>%
#   mutate(treatment = factor(treatment, levels = c("E2", "E2DHT")))
# accessions <- unique(c(samples$accession, samples$input))
# treat_colours <- c("steelblue", "red3", "grey")
# names(treat_colours) <- c(levels(samples$treatment), "Input")

## ----bfl, eval = FALSE--------------------------------------------------------
# bfl <- here("data", "H3K27ac", glue("{accessions}.bam")) %>%
#   BamFileList() %>%
#   setNames(str_remove_all(names(.), ".bam"))
# file.exists(path(bfl))

## ----sq-----------------------------------------------------------------------
sq <- defineSeqinfo("GRCh37")

## ----wincounts, eval = FALSE--------------------------------------------------
# greylist <- here("data", "chr10_greylist.bed") %>%
#   import.bed(seqinfo = sq)
# blacklist <- here("data", "chr10_blacklist.bed") %>%
#   import.bed(seqinfo = sq)
# rp <- readParam(
#   pe = "none",
#   dedup = TRUE,
#   restrict = "chr10",
#   discard = c(greylist, blacklist)
# )
# wincounts <- windowCounts(
#   bam.files = bfl,
#   spacing = 40,
#   width = 120,
#   ext = 200,
#   filter = length(bfl),
#   param = rp
# )
# seqlevels(wincounts) <- seqlevels(sq)
# seqinfo(wincounts) <- sq

## ----rowranges-wincounts, eval = FALSE----------------------------------------
# rowRanges(wincounts)

## ----coldata-wincounts, eval = FALSE------------------------------------------
# colData(wincounts)

## ----update-coldata, eval = FALSE---------------------------------------------
# colData(wincounts) <- colData(wincounts) %>%
#   as_tibble(rownames = "accession") %>%
#   left_join(samples, by = "accession") %>%
#   dplyr::select(
#     accession, all_of(colnames(colData(wincounts))), target, treatment
#   ) %>%
#   mutate(
#     target = str_replace_na(target, "Input"),
#     treatment = str_replace_na(treatment, "Input") %>%
#       as.factor()
#   ) %>%
#   DataFrame(row.names = .$accession)

## ----plot-densities, eval = FALSE---------------------------------------------
# plotAssayDensities(wincounts, colour = "treatment", trans = "log1p") +
#   theme_bw() +
#   scale_colour_manual(values = treat_colours)

## ----filter-counts, eval = FALSE----------------------------------------------
# guide_regions <- here("data", "H3K27ac", "H3K27ac_chr10.bed") %>%
#   import.bed(seqinfo = sq)
# filtcounts <- dualFilter(
#   x = wincounts, bg = "SRR8315192", ref = guide_regions, q = 0.6
# )

## ----plot-density-pca, eval = FALSE-------------------------------------------
# A <- plotAssayDensities(filtcounts, assay = "logCPM", colour = "treatment") +
#   scale_colour_manual(values = treat_colours) +
#   theme_bw()
# B <- plotAssayPCA(filtcounts, "logCPM", colour = "treatment", label = "accession") +
#   scale_colour_manual(values = treat_colours) +
#   theme_bw()
# A + B +
#   plot_layout(guides = "collect") + plot_annotation(tag_levels = "A")

## ----add-dens-pca, echo = FALSE, eval = TRUE, fig.cap = "*A) Densities for logCPM values across all samples after discarding windows less likely to contain H3K27ac signal using `dualFilter()` B) PCA plot based on the logCPM assay*"----
knitr::include_graphics("differential_signal_sliding_files/figure-gfm/plot-density-pca-1.png")

## ----plot-assay-rle, eval = FALSE---------------------------------------------
# a <- plotAssayRle(filtcounts, assay = "logCPM", fill = "treat") +
#   geom_hline(yintercept = 0, linetype = 2, colour = "grey") +
#   scale_fill_manual(values = treat_colours) +
#   ggtitle("RLE: Across All Samples") +
#   theme_bw()
# b <- plotAssayRle(
#   filtcounts, assay = "logCPM", fill = "treat", rle_group = "treat"
# ) +
#   geom_hline(yintercept = 0, linetype = 2, colour = "grey") +
#   scale_fill_manual(values = treat_colours) +
#   ggtitle("RLE: Within Treatment Groups") +
#   theme_bw()
# a + b + plot_layout(guides = "collect") +
#   plot_annotation(tag_levels = "A")

## ----add-rle-plot, eval = TRUE, echo = FALSE, fig.cap = "*RLE plots (A) across all samples and (B) with values calculated within treatment groups*"----
knitr::include_graphics("differential_signal_sliding_files/figure-gfm/plot-assay-rle-1.png")

## ----fit-gr, eval = FALSE-----------------------------------------------------
# X <- model.matrix(~treatment, data = colData(filtcounts))
# fit_gr <- fitAssayDiff(filtcounts, design = X, fc = 1.2, asRanges = TRUE)

## ----results-gr, eval = FALSE-------------------------------------------------
# results_gr <- mergeByHMP(fit_gr, inc_cols = "overlaps_ref", merge_within = 120) %>%
#   addDiffStatus(drop = TRUE)
# arrange(results_gr, hmPValue)[1:5]

## ----plot-ma-libsize, eval = FALSE--------------------------------------------
# A <- fit_gr %>%
#   as_tibble() %>%
#   ggplot(aes(logCPM, logFC)) +
#   geom_point(alpha = 0.6) +
#   geom_smooth(se = FALSE, method = "loess") +
#   geom_label(
#     aes(label = label),
#     data = . %>%
#       summarise(
#         n = dplyr::n(),
#         logCPM = max(logCPM) - 0.15 * diff(range(logCPM)),
#         logFC = max(logFC) - 0.05 * diff(range(logFC)),
#         label = glue("{comma(n)}\nSliding Windows")
#       )
#   ) +
#   ylim(range(fit_gr$logFC)) +
#   ggtitle("MA Plot: All Retained Sliding Windows")
# B <- results_gr %>%
#   as_tibble() %>%
#   mutate(`FDR < 0.05` = hmPValue_fdr < 0.05) %>%
#   ggplot(aes(logCPM, logFC)) +
#   geom_point(aes(colour = `FDR < 0.05`), alpha = 0.6) +
#   geom_smooth(se = FALSE, method = "loess") +
#   geom_label_repel(
#     aes(label = range, colour = `FDR < 0.05`),
#     data = . %>% dplyr::filter(hmPValue_fdr == min(hmPValue_fdr)),
#     show.legend = FALSE
#   ) +
#   geom_label(
#     aes(label = label),
#     data = . %>%
#       summarise(
#         n = dplyr::n(),
#         logCPM = max(logCPM) - 0.15 * diff(range(logCPM)),
#         logFC = max(fit_gr$logFC) - 0.05 * diff(range(fit_gr$logFC)),
#         label = glue("{comma(n)}\nMerged Windows")
#       )
#   ) +
#   scale_colour_manual(values = c("black", "red")) +
#   ylim(range(fit_gr$logFC)) +
#   ggtitle("MA Plot: Merged Windows")
# A + B + plot_annotation(tag_levels = "A")

## ----add-ma-plot, echo=FALSE, eval=TRUE, fig.cap="*MA Plots using A) all sliding windows (after filtering before merging) and B) the final set of merged windows. The most highly ranked merged window is also labelled in the set of merged windows. Blue lines represent a loess curve through the data.*"----
knitr::include_graphics("differential_signal_sliding_files/figure-gfm/plot-ma-libsize-1.png")

## ----qtest, eval = FALSE------------------------------------------------------
# set.seed(100)
# qtest <- assay(filtcounts, "counts") %>%
#   quantro(groupFactor = filtcounts$treatment, B = 1e3)
# qtest

## ----fit-tmm, eval = FALSE----------------------------------------------------
# tmm_gr <- fitAssayDiff(
#   filtcounts, design = X, fc = 1.2, norm = "TMM", asRanges = TRUE
# )
# tmm_results <- mergeByHMP(tmm_gr, inc_cols = "overlaps_ref", merge_within = 120) %>%
#   addDiffStatus(drop = TRUE)
# table(tmm_results$status)

## ----plot-ma-tmm, eval = FALSE------------------------------------------------
# tmm_gr %>%
#   as_tibble() %>%
#   ggplot(aes(logCPM, logFC)) +
#   geom_point(alpha = 0.6) +
#   geom_smooth(se = FALSE, method = "loess") +
#   ggtitle("MA Plot: TMM Normalisation")

## ----gencode, eval = FALSE----------------------------------------------------
# gencode <- here("data/gencode.v43lift37.chr10.annotation.gtf.gz") %>%
#   import.gff() %>%
#   filter_by_overlaps(GRanges("chr10:42354900-100000000")) %>%
#   split(.$type)
# seqlevels(gencode) <- seqlevels(sq)
# seqinfo(gencode) <- sq

## ----tss, eval = FALSE--------------------------------------------------------
# tss <- gencode$transcript %>%
#   resize(width = 1, fix = "start") %>%
#   select(gene_id, ends_with("name")) %>%
#   reduceMC(min.gapwidth = 0)

## ----subset-tss, eval = FALSE-------------------------------------------------
# subset(tss, vapply(gene_name, function(x) "PPIF" %in% x, logical(1)))

## ----overlaps-any, eval = FALSE-----------------------------------------------
# tmm_results$tss <- overlapsAny(tmm_results, tss)

## ----promoters, eval = FALSE--------------------------------------------------
# promoters <- gencode$transcript %>%
#     select(gene_id, ends_with("name")) %>%
#     promoters(upstream = 2500, downstream = 500) %>%
#     reduceMC(simplify = FALSE)
# tail(promoters)

## ----map-by-feature, eval = FALSE---------------------------------------------
# tmm_results <- mapByFeature(
#   tmm_results, genes = gencode$gene,
#   prom = select(promoters, gene_id, gene_name)
# )
# tmm_results %>% filter(hmPValue_fdr < 0.05) %>% arrange(hmPValue)

## ----plot-ma-mapped, eval = FALSE---------------------------------------------
# status_colours <- c(Unchanged = "grey70", Increased = "red3", Decreased = "royalblue")
# tmm_results %>%
#   as_tibble() %>%
#   ggplot(aes(logCPM, logFC, colour = status, shape = tss)) +
#   geom_point() +
#   geom_label_repel(
#     aes(label = label),
#     data = . %>%
#       arrange(hmPValue) %>%
#       dplyr::slice(1:20) %>%
#       mutate(
#         label  = vapply(gene_name, paste, character(1), collapse = "; ") %>%
#           str_trunc(30)
#       ),
#     fill = "white", alpha = 0.6, show.legend = FALSE
#   ) +
#   scale_colour_manual(values = status_colours) +
#   scale_shape_manual(values = c(19, 21))

## ----add-ma-mapped-plot, eval = TRUE, echo = FALSE, fig.cap = "*MA-plot with the top 20 regions by significance labelled according to the most likely gene influenced by the detected signal. Regions which directly overlap a TSS are shown as empty circles*"----
knitr::include_graphics("differential_signal_sliding_files/figure-gfm/plot-ma-mapped-1.png")

## ----define-regions, eval = FALSE---------------------------------------------
# regions <- defineRegions(
#   genes = gencode$gene, transcripts = gencode$transcript, exons = gencode$exon
# )
# regions

## ----bet-overlap, eval = FALSE------------------------------------------------
# tmm_results$bestOverlap <- bestOverlap(tmm_results, regions) %>%
#   factor(levels = names(regions))
# filter(tmm_results, hmPValue_fdr < 0.05, bestOverlap == "promoter")

## ----reg-as-factor, eval = FALSE----------------------------------------------
# reg_levels <- vapply(regions, function(x) x$region[1], character(1))
# tmm_results$bestOverlap <- tmm_results %>%
#   bestOverlap(unlist(regions), var = "region") %>%
#   factor(levels = reg_levels)

## ----reg-colours, eval = FALSE------------------------------------------------
# region_colours <- hcl.colors(length(reg_levels), "Viridis", rev = TRUE)
# names(region_colours) <- reg_levels

## ----plot-pie-labels, eval = FALSE--------------------------------------------
# plotPie(
#   tmm_results, fill = "bestOverlap", min_p = 0.05,
#   cat_glue = "{.data[[fill]]}\n{n}\n({percent(p, 0.1)})"
# ) +
#   scale_fill_manual(values = region_colours)

## ----add-pit, eval = TRUE, echo = FALSE, fig.cap = "*Pie chart showing customised labels. Here the regions have been modified to use title case in the labels, but without modifying the underlying data.*"----
knitr::include_graphics("differential_signal_sliding_files/figure-gfm/plot-pie-labels-1.png")

## ----plot-donut-default, eval = FALSE-----------------------------------------
# plotSplitDonut(
#   tmm_results, inner = "bestOverlap", outer = "status",
#   inner_palette = region_colours
# )

## ----add-donut, eval = TRUE, echo=FALSE, fig.cap = "*Split-Donut chart showing status with overlapping region*"----
knitr::include_graphics("differential_signal_sliding_files/figure-gfm/plot-donut-default-1.png")

## ----plot-donut-customised, eval = FALSE--------------------------------------
# plotSplitDonut(
#   tmm_results, inner = "bestOverlap", outer = "status",
#   inner_palette = region_colours, outer_palette = status_colours,
#   inner_glue = "{str_replace_all(.data[[inner]], ' ', '\n')}\nn = {comma(n)}\n{percent(p,0.1)}",
#   outer_glue = "{.data[[outer]]}\n{str_replace_all(.data[[inner]], ' ', '\n')}\nn = {n}",
#   explode_outer = "(In|De)creased", explode_r = 0.3,
#   outer_label = "text", outer_min_p = 0, outer_max_p = 0.02
# )

## ----add-donut-customised, eval=TRUE, echo=FALSE, fig.cap = "*Split-Donut chart exploding key regions and customising labels.*"----
knitr::include_graphics("differential_signal_sliding_files/figure-gfm/plot-donut-customised-1.png")

## ----bwfl, eval = FALSE-------------------------------------------------------
# bwfl <- here::here(
#   "data", "H3K27ac", glue("{levels(samples$treatment)}_cov_chr10.bw")
# ) %>%
#   BigWigFileList() %>%
#   setNames(levels(samples$treatment))

## ----cytobands----------------------------------------------------------------
data("grch37.cytobands")
head(grch37.cytobands)

## ----gr, eval = FALSE---------------------------------------------------------
# gr <- filter(tmm_results, hmPValue_fdr < 0.05, str_detect(bestOverlap, '^Prom'))[1]

## ----plot-hfgc, eval = FALSE--------------------------------------------------
# plotHFGC(gr, cytobands = grch37.cytobands, coverage = bwfl)

## ----cov-list, eval = FALSE---------------------------------------------------
# cov_list <- list(H3K27ac = bwfl)
# cov_colour <- list(H3K27ac = treat_colours[levels(samples$treatment)])
# plotHFGC(
#   gr, cytobands = grch37.cytobands,
#   coverage =  cov_list, linecol = cov_colour, zoom = 50, rotation.title = 90
# )

## ----cov-annot, eval = FALSE--------------------------------------------------
# cov_annot <- splitAsList(tmm_results, tmm_results$status) %>%
#   endoapply(granges)
# cov_annot <- list(H3K27ac = cov_annot)

## ----gene-models, eval = FALSE------------------------------------------------
# gene_models <- gencode$exon %>%
#   select(
#     type, gene = gene_id, exon = exon_id, transcript = transcript_id,
#     symbol = gene_name
#   )

## ----plot-hfgc-with-annot, eval = FALSE---------------------------------------
# names(region_colours) <- names(regions)
# plotHFGC(
#   gr, cytobands = grch37.cytobands,
#   features = regions, featcol = region_colours, featstack = "dense",
#   coverage =  cov_list, linecol = cov_colour,
#   genes = gene_models, genecol = "wheat", collapseTranscripts = FALSE,
#   zoom = 350, shift = -1e5,
#   rotation.title = 90, covsize = 10, genesize = 1, featsize = 5,
#   annotation = cov_annot, annotcol = status_colours[c("Unchanged", "Increased")]
# )

## ----add-hfgc, eval=TRUE, echo=FALSE, fig.cap = "The addition of an annotation track for the coverage tracks shows which regions were retained during the analysis, as well as those which were considered as showing changed or unchanged signal"----
knitr::include_graphics("differential_signal_sliding_files/figure-gfm/plot-hfgc-with-annot-1.png")

## ----session-info-------------------------------------------------------------
sessionInfo()

