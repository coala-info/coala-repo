# Code example from 'RLSeq' vignette. See references/ for full tutorial.

## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(tidy = FALSE,
                      cache = FALSE,
                      dev = "png",
                      message = FALSE, 
                      error = FALSE,
                      warning = FALSE)
BiocStyle::markdown()

## ----library, message=FALSE, warning=FALSE------------------------------------
library(RLSeq)
library(dplyr)

## ----pull_public_data---------------------------------------------------------
rlbase <- "https://rlbase-data.s3.amazonaws.com"

# Get peaks and coverage
s96Pks <- regioneR::toGRanges(file.path(rlbase, "peaks", "SRX1025890_hg38.broadPeak"))
s96Cvg <- file.path(rlbase, "coverage", "SRX1025890_hg38.bw")

## ----downsample_data----------------------------------------------------------
# For expediency, peaks we filter and down-sampled to the top 10000 by padj (V9)
# This is not necessary as part of the typical workflow, however
s96Pks <- s96Pks[s96Pks$V9 > 2,]
s96Pks <- s96Pks[sample(names(s96Pks), 10000)]

## ----build_rlranges-----------------------------------------------------------
## Build RLRanges ##
# S9.6 -RNaseH1
rlr <- RLRanges(
  peaks = s96Pks, 
  coverage = s96Cvg,
  genome = "hg38",
  mode = "DRIP",
  label = "POS",
  sampleName = "TC32 DRIP-Seq"
)

## ----analyzeRLFS--------------------------------------------------------------
# Analyze RLFS for positive sample
rlr <- analyzeRLFS(rlr, quiet = TRUE)

## ----plot-perm, fig.cap="Plot of permutation test results (S9.6 -RNaseH1)."----
plotRLFSRes(rlr)

## ----predictCondition---------------------------------------------------------
# Predict 
rlr <- predictCondition(rlr)

## ----rlresultPrediction-------------------------------------------------------
# Access results
s96_pred <- rlresult(rlr, "predictRes")
cat("Prediction: ", s96_pred$prediction)

## ----feature_enrich-----------------------------------------------------------
# Perform test
rlr <- featureEnrich(
  object = rlr,
  quiet = TRUE
)

## -----------------------------------------------------------------------------
# View Top Results
annoResS96 <- rlresult(rlr, "featureEnrichment")
annoResS96 %>%
  relocate(contains("fisher"), .after = type) %>%
  arrange(desc(stat_fisher_rl))

## ---- warning=FALSE, figures-side, fig.show="hold", out.width="50%"-----------
pltlst <- plotEnrichment(rlr)

## ----warning=FALSE------------------------------------------------------------
pltlst$Encode_CREs

## ----corrAnalyze--------------------------------------------------------------
# corrAnalyze does not work on Windows OS
if (.Platform$OS.type != "windows") {
  rlr <- corrAnalyze(rlr)
}

## -----------------------------------------------------------------------------
# corrAnalyze does not work on Windows OS
if (.Platform$OS.type != "windows") {
  corrHeatmap(rlr)
}

## ----geneAnnotation-----------------------------------------------------------
rlr <- geneAnnotation(rlr)

## ----rlRegionTest-------------------------------------------------------------
rlr <- rlRegionTest(rlr)

## ----plotRLRegionOverlap------------------------------------------------------
# Plot overlap
plotRLRegionOverlap(
  object = rlr, 
  
  # Arguments for VennDiagram::venn.diagram()
  fill = c("#9ad9ab", "#9aa0d9"),
  main.cex = 2,
  cat.pos = c(-40, 40),
  cat.dist=.05,
  margin = .05
)

## ----RLRangesFromRLBase-------------------------------------------------------
rlr <- RLRangesFromRLBase(acc = "SRX1025890")
rlr

## -----------------------------------------------------------------------------
sessionInfo()

