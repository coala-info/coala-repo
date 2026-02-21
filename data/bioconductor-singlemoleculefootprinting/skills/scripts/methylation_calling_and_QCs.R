# Code example from 'methylation_calling_and_QCs' vignette. See references/ for full tutorial.

## ----echo = FALSE, message=FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  # comment = "#>", 
  tidy = FALSE, 
  cache = FALSE, 
  results = 'markup'
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("SingleMoleculeFootprinting")

## ----eval=FALSE---------------------------------------------------------------
# clObj <- makeCluster(40)
# prj <- QuasR::qAlign(
#   sampleFile = sampleFile,
#   genome = "BSgenome.Mmusculus.UCSC.mm10",
#   aligner = "Rbowtie",
#   projectName = "prj",
#   paired = "fr",
#   bisulfite = "undir",
#   alignmentParameter = "-e 70 -X 1000 -k 2 --best -strata",
#   alignmentsDir = "./",
#   cacheDir = tempdir(),
#   clObj = clObj
#   )
# stopCluster(clObj)

## ----setup, message=FALSE-----------------------------------------------------
suppressWarnings(library(SingleMoleculeFootprinting))
suppressWarnings(library(SingleMoleculeFootprintingData))
suppressWarnings(library(BSgenome.Mmusculus.UCSC.mm10))
suppressWarnings(library(parallel))
suppressWarnings(library(ggplot2))

## ----include=FALSE------------------------------------------------------------
# Under the hood:
#       download and cache SingleMoleculeFootprintingData data
#       locate bam file and write QuasR sampleFile

# Download and cache
CachedBamPath = SingleMoleculeFootprintingData::NRF1pair.bam()[[1]]
CachedBaiPath = SingleMoleculeFootprintingData::NRF1pair.bam.bai()[[1]]
SingleMoleculeFootprintingData::AllCs.rds()
SingleMoleculeFootprintingData::EnrichmentRegions_mm10.rds()
SingleMoleculeFootprintingData::ReferenceMethylation.rds()

# Create copy of bam and bai files with relevant names
CacheDir <- ExperimentHub::getExperimentHubOption(arg = "CACHE")
file.copy(from = CachedBamPath, to = paste0(CacheDir, "/", "NRF1pair.bam"))
file.copy(from = CachedBaiPath, to = paste0(CacheDir, "/", "NRF1pair.bam.bai"))

# Write QuasR input
data.frame(
  FileName = paste0(CacheDir, "/", "NRF1pair.bam"),
  SampleName = "NRF1pair_DE_"
  ) -> df
readr::write_delim(df, paste0(CacheDir, "/NRF1Pair_sampleFile.txt"), delim = "\t")

## -----------------------------------------------------------------------------
sampleFile = paste0(CacheDir, "/NRF1Pair_sampleFile.txt")
knitr::kable(suppressMessages(readr::read_delim(sampleFile, delim = "\t")))

## ----eval=FALSE---------------------------------------------------------------
# BaitRegions <- SingleMoleculeFootprintingData::EnrichmentRegions_mm10.rds()
# clObj = makeCluster(4)
# BaitCapture(
#   sampleFile = sampleFile,
#   genome = BSgenome.Mmusculus.UCSC.mm10,
#   baits = BaitRegions,
#   clObj = clObj
# ) -> BaitCaptureEfficiency
# stopCluster(clObj)

## ----eval=FALSE---------------------------------------------------------------
# ConversionRate(
#   sampleFile = sampleFile,
#   genome = BSgenome.Mmusculus.UCSC.mm10,
#   chr = 19
# ) -> ConversionRateValue

## ----echo=FALSE, eval=FALSE---------------------------------------------------
# sampleFile = "/g/krebs/barzaghi/HTS/SMF/MM/QuasR_input_files/QuasR_input_tmp2.txt"
# samples = unique(readr::read_delim(sampleFile, "\t")$SampleName)

## ----eval=FALSE---------------------------------------------------------------
# RegionOfInterest = GRanges(BSgenome.Mmusculus.UCSC.mm10@seqinfo["chr19"])
# 
# CallContextMethylation(
#   sampleFile = sampleFile,
#   samples = samples,
#   genome = BSgenome.Mmusculus.UCSC.mm10,
#   RegionOfInterest = RegionOfInterest,
#   coverage = 20,
#   ConvRate.thr = NULL,
#   returnSM = FALSE,
#   clObj = NULL,
#   verbose = FALSE
#   ) -> Methylation
# 
# Methylation %>%
#   elementMetadata() %>%
#   as.data.frame() %>%
#   dplyr::select(grep("_MethRate", colnames(.))) -> MethylationRate_matrix
# 
# png("../inst/extdata/MethRateCorr_AllCs.png", units = "cm", res = 100, width = 20, height = 20)
# pairs(
#   MethylationRate_matrix,
#   upper.panel = panel.cor,
#   diag.panel = panel.hist,
#   lower.panel = panel.jet,
#   labels = gsub("SMF_MM_|DE_|_MethRate", "", colnames(MethylationRate_matrix))
#   )
# dev.off()

## -----------------------------------------------------------------------------
knitr::include_graphics(system.file("extdata", "MethRateCorr_AllCs.png", package="SingleMoleculeFootprinting"))

## ----eval=FALSE---------------------------------------------------------------
# Methylation %>%
#   elementMetadata() %>%
#   as.data.frame() %>%
#   filter(GenomicContext %in% c("DGCHN", "GCH")) %>%
#   dplyr::select(grep("_MethRate", colnames(.))) -> MethylationRate_matrix_GCH
# 
# png("../inst/extdata/MethRateCorr_GCHs.png", units = "cm", res = 100, width = 20, height = 20)
# pairs(MethylationRate_matrix_GCH, upper.panel = panel.cor, diag.panel = panel.hist, lower.panel = panel.jet, labels = colnames(MethylationRate_matrix_GCH))
# dev.off()
# 
# Methylation %>%
#   elementMetadata() %>%
#   as.data.frame() %>%
#   filter(GenomicContext %in% c("NWCGW", "HCG")) %>%
#   dplyr::select(grep("_MethRate", colnames(.))) -> MethylationRate_matrix_HCG
# 
# png("../inst/extdata/MethRateCorr_HCGs.png", units = "cm", res = 100, width = 20, height = 20)
# pairs(MethylationRate_matrix_HCG, upper.panel = panel.cor, diag.panel = panel.hist, lower.panel = panel.jet, labels = colnames(MethylationRate_matrix_HCG))
# dev.off()

## -----------------------------------------------------------------------------
knitr::include_graphics(system.file("extdata", "MethRateCorr_GCHs.png", package="SingleMoleculeFootprinting"))
knitr::include_graphics(system.file("extdata", "MethRateCorr_HCGs.png", package="SingleMoleculeFootprinting"))

## ----echo=FALSE, eval=FALSE---------------------------------------------------
# sampleFile_LowCoverage = "/g/krebs/barzaghi/HTS/SMF/MM/QuasR_input_files/QuasR_input_tmp.txt"
# samples_LowCoverage = grep(
#   "_NP_NO_R.*_MiSeq",
#   unique(readr::read_delim(sampleFile_LowCoverage, "\t")$SampleName), value = TRUE)
# 
# sampleFile_HighCoverage_reference = "/g/krebs/barzaghi/HTS/SMF/MM/QuasR_input_files/QuasR_input_tmp.txt"
# samples_HighCoverage_reference = grep(
#   "SMF_MM_TKO_as_NO_R_NextSeq",
#   unique(readr::read_delim(sampleFile_HighCoverage_reference, "\t")$SampleName), value = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# RegionOfInterest = GRanges(BSgenome.Mmusculus.UCSC.mm10@seqinfo["chr19"])
# 
# CallContextMethylation(
#   sampleFile = sampleFile_LowCoverage,
#   samples = samples_LowCoverage,
#   genome = BSgenome.Mmusculus.UCSC.mm10,
#   RegionOfInterest = RegionOfInterest,
#   coverage = 1,
#   ConvRate.thr = NULL,
#   returnSM = FALSE,
#   clObj = NULL,
#   verbose = FALSE
#   )$DGCHN -> LowCoverageMethylation
# 
# CallContextMethylation(
#   sampleFile = sampleFile_HighCoverage_reference,
#   samples = samples_HighCoverage_reference,
#   genome = BSgenome.Mmusculus.UCSC.mm10,
#   RegionOfInterest = RegionOfInterest,
#   coverage = 20,
#   ConvRate.thr = NULL,
#   returnSM = FALSE,
#   clObj = NULL,
#   verbose = FALSE
#   )$DGCHN -> HighCoverageMethylation
# 
# CompositeMethylationCorrelation(
#   LowCoverage = LowCoverageMethylation,
#   LowCoverage_samples = samples_LowCoverage,
#   HighCoverage = HighCoverageMethylation,
#   HighCoverage_samples = samples_HighCoverage_reference,
#   bins = 50,
#   returnDF = TRUE,
#   returnPlot = TRUE,
#   RMSE = TRUE,
#   return_RMSE_DF = TRUE,
#   return_RMSE_plot = TRUE
#   ) -> results

## -----------------------------------------------------------------------------
results <- qs::qread(system.file("extdata", "low_coverage_methylation_correlation.qs", 
                                 package="SingleMoleculeFootprinting"))
results$MethylationDistribution_plot +
  scale_color_manual(
    values = c("#00BFC4", "#00BFC4", "#00BFC4", "#F8766D", "#F8766D"), 
    breaks = c("SMF_MM_TKO_as_NO_R_NextSeq", "SMF_MM_NP_NO_R1_MiSeq", "SMF_MM_NP_NO_R2_MiSeq", 
               "SMF_MM_NP_NO_R3_MiSeq", "SMF_MM_NP_NO_R4_MiSeq"))

## -----------------------------------------------------------------------------
results$RMSE_plot +
  geom_bar(aes(fill = Sample), stat = "identity") +
  scale_fill_manual(
    values = c("#00BFC4", "#00BFC4", "#00BFC4", "#F8766D", "#F8766D"), 
    breaks = c("SMF_MM_TKO_as_NO_R_NextSeq", "SMF_MM_NP_NO_R1_MiSeq", "SMF_MM_NP_NO_R2_MiSeq", 
               "SMF_MM_NP_NO_R3_MiSeq", "SMF_MM_NP_NO_R4_MiSeq"))

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(data.frame(ExperimentType = c("Single enzyme SMF", "Double enzyme SMF", "No enzyme (endogenous mCpG only)"), 
                        substring = c("\\_NO_", "\\_DE_", "\\_SS_"), 
                        RelevanContext = c("DGCHN & NWCGW", "GCH + HCG", "CG"), 
                        Notes = c("Methylation info is reported separately for each context", "Methylation information is aggregated across the contexts", "-")))

## -----------------------------------------------------------------------------
samples <- suppressMessages(unique(readr::read_delim(sampleFile, delim = "\t")$SampleName))
RegionOfInterest <- GRanges("chr6", IRanges(88106000, 88106500))

CallContextMethylation(
  sampleFile = sampleFile, 
  samples = samples, 
  genome = BSgenome.Mmusculus.UCSC.mm10, 
  RegionOfInterest = RegionOfInterest,
  coverage = 20, 
  returnSM = FALSE,
  ConvRate.thr = NULL,
  verbose = TRUE,
  clObj = NULL # N.b.: when returnSM = TRUE, clObj should be set to NULL
  ) -> Methylation

## -----------------------------------------------------------------------------
head(Methylation)

## -----------------------------------------------------------------------------
CallContextMethylation(
  sampleFile = sampleFile, 
  samples = samples, 
  genome = BSgenome.Mmusculus.UCSC.mm10, 
  RegionOfInterest = RegionOfInterest,
  coverage = 20, 
  returnSM = TRUE,
  ConvRate.thr = NULL,
  verbose = FALSE,
  clObj = NULL # N.b.: when returnSM = TRUE, clObj should be set to NULL
  ) -> Methylation

Methylation[[2]]$NRF1pair_DE_[1:10,20:30]

## -----------------------------------------------------------------------------
PlotAvgSMF(
  MethGR = Methylation[[1]],
  RegionOfInterest = RegionOfInterest
  )

## -----------------------------------------------------------------------------
PlotAvgSMF(
  MethGR = Methylation[[1]],
  RegionOfInterest = RegionOfInterest, 
  ShowContext = TRUE
  )

## -----------------------------------------------------------------------------
TFBSs = qs::qread(system.file("extdata", "TFBSs_1.qs", package="SingleMoleculeFootprinting"))
TFBSs

## -----------------------------------------------------------------------------
PlotAvgSMF(
  MethGR = Methylation[[1]],
  RegionOfInterest = RegionOfInterest, 
  TFBSs = plyranges::filter_by_overlaps(TFBSs, RegionOfInterest)
  )

## -----------------------------------------------------------------------------
PlotAvgSMF(
  MethGR = Methylation[[1]],
  RegionOfInterest = RegionOfInterest, 
  ) -> smf_plot

user_annotation = data.frame(xmin = 88106300, xmax = 88106500, label = "nucleosome")

smf_plot +
  geom_line(linewidth = 1.5) +
  geom_point(size = 3) +
  geom_rect(data = user_annotation, aes(xmin=xmin, xmax=xmax, ymin=-0.09, ymax=-0.04), inherit.aes = FALSE) +
  ggrepel::geom_text_repel(data = user_annotation, aes(x=xmin, y=-0.02, label=label), inherit.aes = FALSE) +
  scale_y_continuous(breaks = c(0,1), limits = c(-.25,1)) +
  scale_x_continuous(breaks = c(start(RegionOfInterest),end(RegionOfInterest)), limits = c(start(RegionOfInterest),end(RegionOfInterest))) +
  theme_bw()

## ----echo=FALSE---------------------------------------------------------------
n = 1000
readsSubset <- sample(seq(nrow(Methylation[[2]]$NRF1pair_DE_)), n)
Methylation[[2]]$NRF1pair_DE_ <- Methylation[[2]]$NRF1pair_DE_[readsSubset,]

## -----------------------------------------------------------------------------
PlotSM(
  MethSM = Methylation[[2]],
  RegionOfInterest = RegionOfInterest,
  sorting.strategy = "None"
  )

## -----------------------------------------------------------------------------
PlotSM(
  MethSM = Methylation[[2]],
  RegionOfInterest = RegionOfInterest,
  sorting.strategy = "hierarchical.clustering"
  )

## -----------------------------------------------------------------------------
SNPs = qs::qread(system.file("extdata", "SNPs_1.qs", package="SingleMoleculeFootprinting"))
SNPs

## -----------------------------------------------------------------------------
Methylation = qs::qread(system.file("extdata", "Methylation_1.qs", package="SingleMoleculeFootprinting"))
TFBSs = qs::qread(system.file("extdata", "TFBSs_2.qs", package="SingleMoleculeFootprinting"))
RegionOfInterest = GRanges("chr16", IRanges(8470511,8471010))

PlotAvgSMF(
  MethGR = Methylation,
  RegionOfInterest = RegionOfInterest, 
  TFBSs = TFBSs,
  SNPs = SNPs
  )

## -----------------------------------------------------------------------------
Methylation = qs::qread(system.file("extdata", "Methylation_2.qs", package="SingleMoleculeFootprinting"))
TFBSs = qs::qread(system.file("extdata", "TFBSs_1.qs", package="SingleMoleculeFootprinting"))
SNPs = qs::qread(system.file("extdata", "SNPs_2.qs", package="SingleMoleculeFootprinting"))
RegionOfInterest = GRanges("chr6", IRanges(88106000, 88106500))

PlotAvgSMF(
  MethGR = Methylation,
  RegionOfInterest = RegionOfInterest, 
  TFBSs = TFBSs,
  SNPs = SNPs
  ) +
  geom_vline(xintercept = start(SNPs[5]), linetype = 2, color = "grey")

## -----------------------------------------------------------------------------
CytosinesToMask = qs::qread(system.file("extdata", "cytosines_to_mask.qs", package="SingleMoleculeFootprinting"))
CytosinesToMask

## -----------------------------------------------------------------------------
MaskSNPs(
  Methylation = Methylation, 
  CytosinesToMask = CytosinesToMask, 
  MaskSMmat = FALSE, 
  SampleStringMatch = list(Cast = "_CTKO", Spret = "_STKO"), 
  Experiment = "DE"
  ) -> Methylation_masked

PlotAvgSMF(
  MethGR = Methylation_masked,
  RegionOfInterest = RegionOfInterest, 
  TFBSs = TFBSs,
  SNPs = SNPs
  ) +
  geom_vline(xintercept = start(SNPs[5]), linetype = 2, color = "grey")

## ----echo=FALSE, eval=FALSE---------------------------------------------------
# sampleFile = "/g/krebs/barzaghi/HTS/SMF/MM/QuasR_input_files/QuasR_input_AllCanWGpooled_dprm_DE_only.txt"
# samples = suppressMessages(unique(readr::read_delim(sampleFile, "\t")$SampleName))
# plyranges::filter(TFBSs, TF=="REST" & isBound) -> REST_motifs
# 
# clObj = parallel::makeCluster(16)
# motif.counts = QuasR::qCount(GetQuasRprj(ChIP_data_dictionary[["Rest"]], genome = BSgenome.Mmusculus.UCSC.mm10), query = IRanges::resize(REST_motifs, 200, "center"), clObj = clObj)
# parallel::stopCluster(clObj)
# 
# motif.counts %>%
#   data.frame() %>%
#   rownames_to_column("TF.name") %>%
#   arrange(desc(Rest)) %>%
#   head(500) %>%
#   dplyr::select(TF.name) -> top_rest
# 
# TopMotifs = TFBSs[top_rest$TF.name]
# elementMetadata(TopMotifs) = NULL
# TopMotifs$TF = "REST"
# 
# qs::qsave(TopMotifs, "../inst/extdata/Top_bound_REST.qs")

## ----eval=FALSE---------------------------------------------------------------
# TopMotifs = qs::qread(system.file("extdata", "Top_bound_REST.qs", package="SingleMoleculeFootprinting"))
# 
# CollectCompositeData(
#   sampleFile = sampleFile,
#   samples = samples,
#   genome = BSgenome.Mmusculus.UCSC.mm10,
#   TFBSs = TopMotifs,
#   window = 1000,
#   coverage = 20,
#   ConvRate.thr = NULL,
#   cores = 16
# ) -> CompositeData
# 
# png("../inst/extdata/rest_composite.png", units = "cm", res = 100, width = 24, height = 16)
# CompositePlot(CompositeData = CompositeData, span = 0.1, TF = "Rest")
# dev.off()

## -----------------------------------------------------------------------------
knitr::include_graphics(system.file("extdata", "rest_composite.png", package="SingleMoleculeFootprinting"))

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

