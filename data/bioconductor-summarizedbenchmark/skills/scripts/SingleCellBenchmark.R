# Code example from 'SingleCellBenchmark' vignette. See references/ for full tutorial.

## ----echo=FALSE, include=FALSE---------------------------------------------
knitr::opts_chunk$set(tidy = FALSE,
                      cache = TRUE,
                      dev = "png",
                      message = FALSE,
                      error = FALSE,
                      warning = TRUE)

## --------------------------------------------------------------------------
library("SummarizedBenchmark")
library("magrittr")

## ----load-fluidigm-data----------------------------------------------------
library("splatter")
library("scRNAseq")

data("fluidigm")
se <- fluidigm[, colData(fluidigm)[, "Coverage_Type"] == "High"]
assays(se) <- assays(se)["rsem_counts"]
assayNames(se) <- "counts"

## ----subset-data-----------------------------------------------------------
set.seed(1912)
se <- se[sample(nrow(se), 1e4), sample(ncol(se), 20)]

## ----convert-to-sce--------------------------------------------------------
sce <- as(se, "SingleCellExperiment")

## ----construct-sim-benchdesign---------------------------------------------
bd <- BenchDesign() %>%
    addMethod(label = "splat",
              func = splatSimulate,
              params = rlang::quos(params = splatEstimate(in_data),
                                   verbose = in_verbose,
                                   seed = in_seed)) %>%
    addMethod(label = "simple",
              func = simpleSimulate,
              params = rlang::quos(params = simpleEstimate(in_data),
                                   verbose = in_verbose,
                                   seed = in_seed)) %>%
    addMethod(label = "lun",
              func = lunSimulate,
              params = rlang::quos(params = lunEstimate(in_data),
                                   verbose = in_verbose,
                                   seed = in_seed))

## ----run-sim-buildbench----------------------------------------------------
fluidigm_dat <- list(in_data = assay(sce, "counts"),
                     in_verbose = FALSE,
                     in_seed = 19120128)
sb <- buildBench(bd, data = fluidigm_dat) 
sb

## ----check-buildbench-results----------------------------------------------
assay(sb)
sapply(assay(sb), class)

## ----compute-sim-result-comparison-----------------------------------------
res_compare <- compareSCEs(c(ref = sce, assay(sb)[1, ]))
res_diff <- diffSCEs(c(ref = sce, assay(sb)[1, ]), ref = "ref")

## ----plot-sim-result-comparison--------------------------------------------
res_compare$Plots$MeanVar

res_diff$Plots$MeanVar

## ----add-performance-metrics-----------------------------------------------
sb <- sb %>%
    addPerformanceMetric(
        assay = "default",
        evalMetric = "zerosPerCell",
        evalFunction = function(query, truth) {
            colMeans(assay(query[[1]], "counts") == 0)
        }) %>%
    addPerformanceMetric(
        assay = "default",
        evalMetric = "zerosPerGene",
        evalFunction = function(query, truth) {
            rowMeans(assay(query[[1]], "counts") == 0)
        } )

## ----compute-performance-metrics-------------------------------------------
sbmets <- estimatePerformanceMetrics(sb, tidy = TRUE)
sbmets  <- dplyr::select(sbmets, label, value, performanceMetric)
head(sbmets)

## ----check-performance-metrics---------------------------------------------
sbmets <- tidyr::unnest(sbmets)
head(sbmets)

## ----plot-performace-metrics-----------------------------------------------
ggplot(sbmets, aes(x = label, y = value,
                   color = label, fill = label)) +
    geom_boxplot(alpha = 1/2) +
    xlab("method") +
    scale_color_discrete("method") + 
    scale_fill_discrete("method") + 
    facet_grid(performanceMetric ~ .) +
    theme_bw()

## ----analyze-new-data------------------------------------------------------
data(sc_example_counts, package = "scater")
scec <- SingleCellExperiment(assays = list(counts = sc_example_counts))

scater_dat <- list(in_data = scec,
                   in_verbose = FALSE,
                   in_seed = 19120128)
buildBench(bd, data = scater_dat)

