# Code example from 'single_molecule_sorting_by_TF' vignette. See references/ for full tutorial.

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
suppressWarnings(library(BSgenome.Mmusculus.UCSC.mm10))

## ----eval=FALSE, echo=FALSE---------------------------------------------------
# RegionOfInterest = GRanges("chr12", IRanges(20464551, 20465050))
# TFBSs_full_list = qs::qread("/g/krebs/barzaghi/DB/TFBSs.qs")
# 
# Methylation = CallContextMethylation(
#   sampleFile = "/g/krebs/barzaghi/HTS/SMF/MM/QuasR_input_files/QuasR_input_AllCanWGpooled_dprm_DE_only.txt", samples = "SMF_MM_TKO_DE_", genome = BSgenome.Mmusculus.UCSC.mm10,
#   RegionOfInterest = RegionOfInterest, coverage = 20, ConvRate.thr = NULL, returnSM = TRUE, clObj = NULL, verbose = FALSE
# )
# qs::qsave(Methylation, "../inst/extdata/Methylation_3.qs")
# 
# TFBSs = plyranges::filter(plyranges::filter_by_overlaps(TFBSs_full_list, RegionOfInterest), TF == "CTCF")
# elementMetadata(TFBSs) = NULL
# TFBSs$TF = "CTCF"
# qs::qsave(TFBSs, "../inst/extdata/TFBSs_3.qs")

## -----------------------------------------------------------------------------
RegionOfInterest = GRanges("chr12", IRanges(20464551, 20465050))
Methylation = qs::qread(system.file("extdata", "Methylation_3.qs", package="SingleMoleculeFootprinting"))
TFBSs = qs::qread(system.file("extdata", "TFBSs_3.qs", package="SingleMoleculeFootprinting"))

motif_center = start(IRanges::resize(TFBSs, 1, "center"))
SortingBins = c(
  GRanges("chr1", IRanges(motif_center-35, motif_center-25)),
  GRanges("chr1", IRanges(motif_center-15, motif_center+15)),
  GRanges("chr1", IRanges(motif_center+25, motif_center+35))
)

PlotAvgSMF(
  MethGR = Methylation[[1]], RegionOfInterest = RegionOfInterest, 
  TFBSs = TFBSs, SortingBins = SortingBins
  )

## ----eval=TRUE----------------------------------------------------------------
SortedReads = SortReadsBySingleTF(MethSM = Methylation[[2]], TFBS = TFBSs)

## -----------------------------------------------------------------------------
lapply(SortedReads$SMF_MM_TKO_DE_, head, 2)

## -----------------------------------------------------------------------------
lengths(SortedReads$SMF_MM_TKO_DE_)

## -----------------------------------------------------------------------------
SingleTFStates()

## -----------------------------------------------------------------------------
StateQuantification(SortedReads = SortedReads, states = SingleTFStates())

## -----------------------------------------------------------------------------
PlotSM(MethSM = Methylation[[2]], RegionOfInterest = RegionOfInterest, sorting.strategy = "classical", SortedReads = SortedReads)

## -----------------------------------------------------------------------------
StateQuantificationPlot(SortedReads = SortedReads, states = SingleTFStates())

## ----eval=FALSE, echo=FALSE---------------------------------------------------
# RegionOfInterest = GRanges("chr6", IRanges(88106000, 88106500))
# 
# Methylation = CallContextMethylation(
#   sampleFile = "/g/krebs/barzaghi/HTS/SMF/MM/QuasR_input_files/QuasR_input_AllCanWGpooled_dprm_DE_only.txt", samples = "SMF_MM_TKO_DE_", genome = BSgenome.Mmusculus.UCSC.mm10,
#   RegionOfInterest = RegionOfInterest, coverage = 20, ConvRate.thr = NULL, returnSM = TRUE, clObj = NULL, verbose = FALSE
# )
# qs::qsave(Methylation, "../inst/extdata/Methylation_4.qs")

## ----eval=TRUE----------------------------------------------------------------
RegionOfInterest = GRanges("chr6", IRanges(88106000, 88106500))
Methylation = qs::qread(system.file("extdata", "Methylation_4.qs", package="SingleMoleculeFootprinting"))
TFBSs = qs::qread(system.file("extdata", "TFBSs_1.qs", package="SingleMoleculeFootprinting"))

motif_center_1 = start(IRanges::resize(TFBSs[1], 1, "center"))
motif_center_2 = start(IRanges::resize(TFBSs[2], 1, "center"))
SortingBins = c(
  GRanges("chr6", IRanges(motif_center_1-35, motif_center_1-25)),
  GRanges("chr6", IRanges(motif_center_1-7, motif_center_1+7)),
  GRanges("chr6", IRanges(motif_center_2-7, motif_center_2+7)),
  GRanges("chr6", IRanges(motif_center_2+25, motif_center_2+35))
)

PlotAvgSMF(
  MethGR = Methylation[[1]], RegionOfInterest = RegionOfInterest, TFBSs = TFBSs, SortingBins = SortingBins
)

## ----eval=TRUE----------------------------------------------------------------
SortedReads = SortReadsByTFCluster(MethSM = Methylation[[2]], TFBS_cluster = TFBSs)

## -----------------------------------------------------------------------------
lapply(SortedReads$SMF_MM_TKO_DE_, head, 2)

## -----------------------------------------------------------------------------
lengths(SortedReads$SMF_MM_TKO_DE_)

## -----------------------------------------------------------------------------
TFPairStates()

## -----------------------------------------------------------------------------
StateQuantification(SortedReads = SortedReads, states = TFPairStates())

## -----------------------------------------------------------------------------
PlotSM(MethSM = Methylation[[2]], RegionOfInterest = RegionOfInterest, sorting.strategy = "classical", SortedReads = SortedReads)

## -----------------------------------------------------------------------------
StateQuantificationPlot(SortedReads = SortedReads, states = TFPairStates())

## ----eval=FALSE, echo=FALSE---------------------------------------------------
# TFBSs_full_list %>%
#   plyranges::filter(seqnames == "chr19", TF == "KLF4", isBound) %>%
#   head(500) -> KLF4s
# elementMetadata(KLF4s) = NULL
# KLF4s$TF = "KLF4"
# qs::qsave(KLF4s, "../inst/extdata/KLF4_chr19.qs")

## -----------------------------------------------------------------------------
KLF4s = qs::qread(system.file("extdata", "KLF4_chr19.qs", package="SingleMoleculeFootprinting"))
KLF4s

## -----------------------------------------------------------------------------
Create_MethylationCallingWindows(RegionsOfInterest = KLF4s)

## -----------------------------------------------------------------------------
Create_MethylationCallingWindows(
  RegionsOfInterest = KLF4s, 
  fix.window.size = TRUE, max.window.size = 50
  )

## -----------------------------------------------------------------------------
KLF4_clusters = Arrange_TFBSs_clusters(TFBSs = KLF4s)
KLF4_clusters$ClusterCoordinates
KLF4_clusters$ClusterComposition

## ----eval=FALSE---------------------------------------------------------------
# SortReadsBySingleTF_MultiSiteWrapper(
#   sampleFile = "/g/krebs/barzaghi/HTS/SMF/MM/QuasR_input_files/QuasR_input_AllCanWGpooled_dprm_DE_only.txt",
#   samples = "SMF_MM_TKO_DE_",
#   genome = BSgenome.Mmusculus.UCSC.mm10,
#   coverage = 20, ConvRate.thr = NULL,
#   CytosinesToMask = NULL,
#   TFBSs = KLF4s,
#   max_interTF_distance = NULL, max_window_width = NULL, min_cluster_width = NULL,
#   fix.window.size = TRUE, max.window.size = 50,
#   cores = 4
# ) -> sorting_results

## ----echo=FALSE, eval=FALSE---------------------------------------------------
# qs::qsave(sorting_results, "../inst/extdata/gw_sorting.qs")

## -----------------------------------------------------------------------------
sorting_results = qs::qread(system.file("extdata", "gw_sorting.qs", package="SingleMoleculeFootprinting"))
sorting_results[[1]]
# sorting_results[[2]]
sorting_results[[3]]

## ----eval=FALSE---------------------------------------------------------------
# SortReadsByTFCluster_MultiSiteWrapper(
#   ...,
#   max_intersite_distance = , min_intersite_distance = , max_cluster_size = , max_cluster_width = ,
#   ...
# )

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

