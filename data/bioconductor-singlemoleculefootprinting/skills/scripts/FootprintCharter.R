# Code example from 'FootprintCharter' vignette. See references/ for full tutorial.

## ----echo = FALSE, message=FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  # comment = "#>", 
  tidy = FALSE, 
  cache = FALSE, 
  results = 'markup'
)

## ----setup, message=FALSE-----------------------------------------------------
suppressWarnings(library(SingleMoleculeFootprinting))
suppressWarnings(library(GenomicRanges))
suppressWarnings(library(tidyverse))
suppressWarnings(library(ggplot2))

## -----------------------------------------------------------------------------
Methylation = qs::qread(system.file("extdata", "Methylation_4.qs", package="SingleMoleculeFootprinting"))
MethSM = Methylation[[2]]
RegionOfInterest = GRanges("chr6", IRanges(88106000, 88106500))
RegionOfInterest = IRanges::resize(RegionOfInterest, 80, "center")

## -----------------------------------------------------------------------------
FootprintCharter(
  MethSM = MethSM,
  RegionOfInterest = RegionOfInterest,
  coverage = 30, 
  k = 16,
  n = 5, 
  TF.length = c(5,75),
  nucleosome.length = c(120,1000),
  cytosine.coverage.thr = 5,
  verbose = TRUE
) -> FC_results

## -----------------------------------------------------------------------------
rrapply::rrapply(FC_results$partitioned.molecules, f = head, n = 2)

## -----------------------------------------------------------------------------
head(FC_results$footprints.df)

## -----------------------------------------------------------------------------
TFBSs = qs::qread(system.file("extdata", "TFBSs_1.qs", package="SingleMoleculeFootprinting"))
TFBSs$absolute.idx = names(TFBSs)
TFBSs

## -----------------------------------------------------------------------------
FootprintCharter(
  MethSM = MethSM,
  RegionOfInterest = RegionOfInterest,
  TFBSs = TFBSs,
  coverage = 30, 
  k = 16,
  n = 5, 
  TF.length = c(5,75), 
  nucleosome.length = c(120,1000), 
  cytosine.coverage.thr = 5,
  verbose = FALSE
) -> FC_results

FC_results$footprints.df %>%
  filter(biological.state == "TF") %>%
  dplyr::select(start, end, partition.nr, TF, TF.name) %>%
  tidyr::unnest(cols = c(TF, TF.name))

## ----fig.width=7, fig.height=7------------------------------------------------
x.axis.breaks = c(
  start(resize(RegionOfInterest, width = 500, fix = "center")), 
  end(resize(RegionOfInterest, width = 500, fix = "center"))
  )
PlotFootprints(
  MethSM = MethSM, 
  partitioned.molecules = FC_results$partitioned.molecules, 
  footprints.df = FC_results$footprints.df, 
  TFBSs = TFBSs
    ) +
  scale_x_continuous(
    limits = x.axis.breaks, 
    breaks = x.axis.breaks, 
    labels = format(x.axis.breaks, nsmall=1, big.mark=",")
    ) +
  theme(legend.position = "top", axis.text.x = element_text(angle = 30, hjust = 1))

## -----------------------------------------------------------------------------
PlotSM(
  MethSM = MethSM, 
  RegionOfInterest = IRanges::resize(RegionOfInterest, 500, "center"), 
  SortedReads = FC_results$partitioned.molecules, 
  sorting.strategy = "custom"
  ) +
  scale_x_continuous(
    limits = x.axis.breaks, 
    breaks = x.axis.breaks, 
    labels = format(x.axis.breaks, nsmall=1, big.mark=",")
    )

## -----------------------------------------------------------------------------
partitions.order = c(3,1,2,5,6,7,4,8)
ordered.molecules = lapply(FC_results$partitioned.molecules, function(x){x[rev(partitions.order)]})

PlotSM(
  MethSM = MethSM, 
  RegionOfInterest = IRanges::resize(RegionOfInterest, 500, "center"), 
  SortedReads = ordered.molecules, 
  sorting.strategy = "custom"
  ) +
  scale_x_continuous(
    limits = x.axis.breaks, 
    breaks = x.axis.breaks, 
    labels = format(x.axis.breaks, nsmall=1, big.mark=",")
    )

## -----------------------------------------------------------------------------
Plot_FootprintCharter_SM(
  footprints.df = FC_results$footprints.df, 
  RegionOfInterest = IRanges::resize(RegionOfInterest, 500, "center"), 
  partitions.order = partitions.order
) +
  scale_x_continuous(
    limits = x.axis.breaks, 
    breaks = x.axis.breaks, 
    labels = format(x.axis.breaks, nsmall=1, big.mark=",")
    )

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

