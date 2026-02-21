# Code example from 'tidyCoverage' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL, 
    width = 180, 
    dpi = 72, 
    fig.align = "center", 
    fig.width = 5, 
    fig.asp = 0.7, 
    dev = 'jpeg'
)

## ----warning = FALSE, include = FALSE, echo = FALSE, message = FALSE, results = FALSE----
library(tidyCoverage)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("tidyCoverage")

## -----------------------------------------------------------------------------
library(tidyCoverage)
showClass("CoverageExperiment")

data(ce)
ce

rowData(ce)

rowRanges(ce)

colData(ce)

assays(ce)

assay(ce, 'coverage')

## -----------------------------------------------------------------------------
assay(ce, 'coverage')

assay(ce, 'coverage')[1, 1] |> class()

assay(ce, 'coverage')[1, 1] |> length()

assay(ce, 'coverage')[1, 1][[1]] |> class()

assay(ce, 'coverage')[1, 1][[1]] |> dim()

# Compare this to `rowData(ce)$n` and `width(ce)`
rowData(ce)$n

width(ce)

assay(ce[1, 1], 'coverage')[[1]][1:10, 1:10]

## -----------------------------------------------------------------------------
showClass("AggregatedCoverage")

data(ac)
ac

rowData(ac)

rowRanges(ac)

colData(ac)

assays(ac)

assay(ac, 'mean')

## -----------------------------------------------------------------------------
assay(ac[1, 1], 'mean')[[1]] |> dim()

assay(ac[1, 1], 'mean')[[1]] |> length()

assay(ac[1, 1], 'mean')[[1]][1:10]

## -----------------------------------------------------------------------------
library(rtracklayer)
bw_file <- system.file("extdata", "MNase.bw", package = "tidyCoverage")
bw_file

bed_file <- system.file("extdata", "TSSs.bed", package = "tidyCoverage")
bed_file

CE <- CoverageExperiment(
    tracks = import(bw_file, as = "Rle"), 
    features = import(bed_file),
    width = 3000
)
CE

## -----------------------------------------------------------------------------
library(rtracklayer)
bw_file <- system.file("extdata", "MNase.bw", package = "tidyCoverage")
bw_file

bed_file <- system.file("extdata", "TSSs.bed", package = "tidyCoverage")
bed_file

CoverageExperiment(
    tracks = BigWigFile(bw_file), 
    features = GRangesList('TSSs' = import(bed_file)),
    width = 3000
)

## -----------------------------------------------------------------------------
assay(CE, 'coverage')[1, 1][[1]] |> ncol()

## -----------------------------------------------------------------------------
CE2 <- CoverageExperiment(
    tracks = import(bw_file, as = "Rle"), 
    features = import(bed_file),
    width = 3000, 
    window = 20
)

CE2

assay(CE2, 'coverage')[1, 1][[1]] |> ncol()

## -----------------------------------------------------------------------------
CE3 <- coarsen(CE, window = 20)

CE3 

identical(CE2, CE3)

## -----------------------------------------------------------------------------
expand(CE)

## -----------------------------------------------------------------------------
expand(CE3)

## -----------------------------------------------------------------------------
# ~~~~~~~~~~~~~~~ Import coverage tracks into a named list ~~~~~~~~~~~~~~~ #
tracks <- list(
    Scc1 = system.file("extdata", "Scc1.bw", package = "tidyCoverage"), 
    RNA_fwd = system.file("extdata", "RNA.fwd.bw", package = "tidyCoverage"),
    RNA_rev = system.file("extdata", "RNA.rev.bw", package = "tidyCoverage"),
    PolII = system.file("extdata", "PolII.bw", package = "tidyCoverage"), 
    MNase = system.file("extdata", "MNase.bw", package = "tidyCoverage")
) |> BigWigFileList()

locus <- GRanges("II:450001-475000")

# ~~~~~~~~~~~~~~~ Instantiate a CoverageExperiment object ~~~~~~~~~~~~~~~ #
CE_chrII <- CoverageExperiment(
    tracks = tracks, 
    features = locus,
    width = width(locus)
)

CE_chrII

## -----------------------------------------------------------------------------
library(ggplot2)
CE_chrII |> 
    coarsen(window = 10) |> 
    expand() |> 
    ggplot(aes(x = coord, y = coverage)) + 
        geom_col(aes(fill = track, col = track)) + 
        facet_grid(track~., scales = 'free') + 
        scale_x_continuous(expand = c(0, 0)) + 
        theme_bw() + 
        theme(legend.position = "none", aspect.ratio = 0.1)

## -----------------------------------------------------------------------------
AC <- aggregate(CE)

AC

assay(AC, 'mean')[1, 1][[1]] |> length()

## -----------------------------------------------------------------------------
AC20 <- aggregate(CE, bin = 20)
AC20

assay(AC20, 'mean')[1, 1][[1]] |> length()

## -----------------------------------------------------------------------------
as_tibble(AC20)

## -----------------------------------------------------------------------------
# Coarsen `CoverageExperiment` with `window = ...` then per-bin `aggregate`:
CoverageExperiment(
    tracks = import(bw_file, as = "Rle"), features = import(bed_file),
    width = 3000
) |> 
    coarsen(window = 20) |> ## FIRST COARSEN...
    aggregate() |>          ## ... THEN AGGREGATE
    as_tibble()

# Per-base `CoverageExperiment` then `aggregate` with `bin = ...`: 
CoverageExperiment(
    tracks = import(bw_file, as = "Rle"), features = import(bed_file),
    width = 3000
) |> 
    aggregate(bin = 20) |>  ## DIRECTLY AGGREGATE BY BIN
    as_tibble()

## -----------------------------------------------------------------------------
library(purrr)
library(plyranges)

# ~~~~~~~~~~~~~~~ Import genomic features into a named list ~~~~~~~~~~~~~~~ #
features <- list(
    TSSs = system.file("extdata", "TSSs.bed", package = "tidyCoverage"),
    `Convergent transcription` = system.file("extdata", "conv_transcription_loci.bed", package = "tidyCoverage")
) |> map(import) |> map(filter, strand == '+') 

# ~~~~~~~~~~~~~~~ Import coverage tracks into a named list ~~~~~~~~~~~~~~~ #
tracks <- list(
    Scc1 = system.file("extdata", "Scc1.bw", package = "tidyCoverage"), 
    RNA_fwd = system.file("extdata", "RNA.fwd.bw", package = "tidyCoverage"),
    RNA_rev = system.file("extdata", "RNA.rev.bw", package = "tidyCoverage"),
    PolII = system.file("extdata", "PolII.bw", package = "tidyCoverage"), 
    MNase = system.file("extdata", "MNase.bw", package = "tidyCoverage")
) |> map(import, as = 'Rle')

# ~~~~~~~~~~~~~~~ Compute aggregated coverage ~~~~~~~~~~~~~~~ #
CE <- CoverageExperiment(tracks, features, width = 5000, scale = TRUE, center = TRUE)
CE

AC <- aggregate(CE)
AC

## -----------------------------------------------------------------------------
AC |> 
    as_tibble() |> 
    ggplot() + 
    geom_aggrcoverage()

## -----------------------------------------------------------------------------
AC |> 
    as_tibble() |> 
    ggplot(aes(col = track)) + 
    geom_aggrcoverage() + 
    facet_grid(features ~ .)

## -----------------------------------------------------------------------------
AC |> 
    as_tibble() |> 
    ggplot(aes(col = track, linetype = track %in% c('RNA_fwd', 'RNA_rev'))) + 
    geom_aggrcoverage() + 
    facet_grid(features ~ .) + 
    labs(x = 'Distance from genomic feature', y = 'Mean coverage (± 95% conf. intervale)') + 
    theme_bw() + 
    theme(legend.position = 'top')

## -----------------------------------------------------------------------------
library(tidySummarizedExperiment)
CE

AC <- CE |> 
    filter(track == 'Scc1') |> 
    filter(features == 'Convergent transcription') |> 
    aggregate()

AC

## -----------------------------------------------------------------------------
AC |> 
    ggplot() + 
    geom_aggrcoverage() + 
    labs(x = 'Distance from locus of convergent transcription', y = 'Scc1 coverage') + 
    theme_bw() + 
    theme(legend.position = 'top')

## -----------------------------------------------------------------------------
CoverageExperiment(tracks, features, width = 5000, scale = TRUE, center = TRUE) |> 
    filter(track == 'RNA_fwd') |> 
    aggregate(bin = 20) |> 
    ggplot(col = features) + 
    geom_aggrcoverage(aes(col = features)) + 
    labs(x = 'Distance to center of genomic features', y = 'Forward RNA-seq coverage') + 
    theme_bw() + 
    theme(legend.position = 'top')

## -----------------------------------------------------------------------------
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene
TSSs <- GenomicFeatures::genes(txdb) |> 
    filter(strand == '+') |> 
    anchor_5p() |> 
    mutate(width = 1)

## -----------------------------------------------------------------------------
library(AnnotationHub)
ah <- AnnotationHub()
ah['AH34904']
H3K4me3_bw <- ah[['AH34904']]

H3K4me3_bw

## -----------------------------------------------------------------------------
CoverageExperiment(
    H3K4me3_bw, TSSs, 
    width = 6000, 
    scale = TRUE, center = TRUE
) |> 
    aggregate() |> 
    ggplot() + 
    geom_aggrcoverage(aes(col = track)) + 
    facet_grid(track ~ .) + 
    labs(x = 'Distance from TSSs', y = 'Mean coverage') + 
    theme_bw() + 
    theme(legend.position = 'top')

## ----eval = FALSE-------------------------------------------------------------
# # ~~~~~~~~~~ Recover 15 different histone PTM ChIP-seq tracks ~~~~~~~~~~ #
# ids <- c(
#     'AH35163', 'AH35165', 'AH35167', 'AH35170', 'AH35173', 'AH35176',
#     'AH35178', 'AH35180', 'AH35182', 'AH35185', 'AH35187', 'AH35189',
#     'AH35191', 'AH35193', 'AH35196'
# )
# names(ids) <- mcols(ah[ids])$title |>
#     gsub(".*IMR90.", "", x = _) |>
#     gsub("\\..*", "", x = _)
# bws <- map(ids, ~ ah[[.x]]) |>
#     map(resource) |>
#     BigWigFileList()
# names(bws) <- names(ids)
# 
# # ~~~~~~~~~~ Computing coverage over TSSs ~~~~~~~~~~ #
# AC <- CoverageExperiment(
#     bws, TSSs,
#     width = 4000,
#     scale = TRUE, center = TRUE
# ) |> aggregate()
# 
# # ~~~~~~~~~~ Plot the resulting AggregatedCoverage object ~~~~~~~~~~ #
# AC |>
#     as_tibble() |>
#     mutate(
#         histone = dplyr::case_when(
#             stringr::str_detect(track, 'H2A') ~ "H2A",
#             stringr::str_detect(track, 'H2B') ~ "H2B",
#             stringr::str_detect(track, 'H3') ~ "H3"
#         )
#     ) |>
#     ggplot() +
#     geom_aggrcoverage(aes(col = track)) +
#     facet_grid(~histone) +
#     labs(x = 'Distance from TSSs', y = 'Mean histone PTM coverage') +
#     theme_bw() +
#     theme(legend.position = 'top') +
#     hues::scale_colour_iwanthue() +
#     hues::scale_fill_iwanthue()

## -----------------------------------------------------------------------------
sessionInfo()

