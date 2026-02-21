# Code example from 'periodicDNA' vignette. See references/ for full tutorial.

## ----eval = TRUE, echo=FALSE, results="hide", warning=FALSE-------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)
suppressPackageStartupMessages({
    library(GenomicRanges)
    library(ggplot2)
    library(magrittr)
    library(periodicDNA)
})
BiocParallel::register(setUpBPPARAM(1), default = TRUE)

## ----eval = TRUE, echo=FALSE, out.width='100%'--------------------------------
knitr::include_graphics(
   "https://raw.githubusercontent.com/js2264/periodicDNA/master/man/figures/periodicityDNA_principle.png"
)

## ----eval = TRUE--------------------------------------------------------------
library(ggplot2)
library(magrittr)
library(periodicDNA)
#
data(ce11_TSSs)
periodicity_result <- getPeriodicity(
    ce11_TSSs[['Ubiq.']][1:500],
    genome = 'BSgenome.Celegans.UCSC.ce11',
    motif = 'TT', 
    BPPARAM = setUpBPPARAM(1)
)

## ----eval = TRUE--------------------------------------------------------------
head(periodicity_result$PSD)
subset(periodicity_result$periodicityMetrics, Period == 10)

## ----eval = TRUE, fig.width = 9, fig.height = 3.2, out.width='100%'-----------
plotPeriodicityResults(periodicity_result)

## ----eval = TRUE, fig.width = 9, fig.height = 3.2, out.width='100%'-----------
periodicity_result <- getPeriodicity(
    ce11_TSSs[['Ubiq.']][1:500],
    genome = 'BSgenome.Celegans.UCSC.ce11',
    motif = 'TT', 
    n_shuffling = 5
)
head(periodicity_result$periodicityMetrics)
subset(periodicity_result$periodicityMetrics, Period == 10)
plotPeriodicityResults(periodicity_result)

## ----eval = TRUE--------------------------------------------------------------
data(ce11_proms_seqs)
periodicity_result <- getPeriodicity(
    ce11_proms_seqs,
    motif = 'TT', 
    BPPARAM = setUpBPPARAM(1)
)
subset(periodicity_result$periodicityMetrics, Period == 10)

## ----eval = FALSE-------------------------------------------------------------
# WW_10bp_track <- getPeriodicityTrack(
#     genome = 'BSgenome.Celegans.UCSC.ce11',
#     granges = ce11_proms,
#     motif = 'WW',
#     period = 10,
#     BPPARAM = setUpBPPARAM(1),
#     bw_file = 'WW-10-bp-periodicity_over-proms.bw'
# )

## ----eval = FALSE, results="hide", warning=FALSE------------------------------
# data(ce11_TSSs)
# plotAggregateCoverage(
#     WW_10bp_track,
#     ce11_TSSs,
#     xlab = 'Distance from TSS',
#     ylab = '10-bp periodicity strength (forward proms.)'
# )

## ----eval = TRUE, echo=FALSE, out.width='100%'--------------------------------
knitr::include_graphics(
    "https://raw.githubusercontent.com/js2264/periodicDNA/master/man/figures/TT-10bp-periodicity_tissue-spe-TSSs.png"
)

## ----eval = TRUE--------------------------------------------------------------
sessionInfo()

