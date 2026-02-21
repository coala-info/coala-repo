# Code example from 'multistateQTL' vignette. See references/ for full tutorial.

## ----knitr-options, echo=FALSE------------------------------------------------
set.seed(42)
knitr::opts_chunk$set(
    warning=FALSE, error=FALSE, message=FALSE, 
    fig.height=6, fig.width=8)

## -----------------------------------------------------------------------------
library(QTLExperiment)
library(multistateQTL)

## ----demo-sumstats2qtle-------------------------------------------------------
input_path <- system.file("extdata", package="multistateQTL")
state <- c("lung", "thyroid", "spleen", "blood")

input <- data.frame(
    state=state, 
    path=paste0(input_path, "/GTEx_tx_", state, ".tsv"))

gtex <- sumstats2qtle(
    input, 
    feature_id="molecular_trait_id",
    variant_id="rsid", 
    betas="beta", 
    errors="se",
    pvalues="pvalue", 
    verbose=TRUE)
gtex
head(betas(gtex))

## ----estimate-parameters------------------------------------------------------
params <- qtleEstimate(gtex, threshSig=0.05, threshNull=0.5)
params

## ----plot-estimated params, fig.height=3, fig.width=6, fig.cap="Gamma distributions defined by the parameters estimated by qtleEstimate."----
plotSimulationParams(params=params)

## ----basic-simulation---------------------------------------------------------
sim <- qtleSimulate(nTests=1000, nStates=6, global=0.5)
sim

## ----basic-simulation-key-----------------------------------------------------
head(rowData(sim))

## ----complex-simulation-------------------------------------------------------
sim <- qtleSimulate(
    nStates=10, nFeatures=100, nTests=1000,
    global=0.2, multi=0.4, unique=0.2, k=2)

## ----snapshot-unique----------------------------------------------------------
head(rowData(subset(sim, QTL == "unique")))

## ----snapshot-multistate------------------------------------------------------
head(rowData(subset(sim, QTL == "multistate")))

message("Number of QTL specific to each state-group:")
table(rowData(subset(sim, QTL == "multistate"))$multistateGroup)

## ----add-NAs------------------------------------------------------------------
na_pattern <- sample(seq(1, ncol(sim)*nrow(sim)), 1000)

sim_na <- sim
assay(sim_na, "betas")[na_pattern] <- NA
assay(sim_na, "errors")[na_pattern] <- NA
assay(sim_na, "lfsrs")[na_pattern] <- NA

message("Number of simulated tests: ", nrow(sim_na))
head(betas(sim_na))

## ----remove-50p-missing-------------------------------------------------------
sim_na <- getComplete(sim_na, n=0.5, verbose=TRUE)

## ----fill-in-missing----------------------------------------------------------
sim_na <- replaceNAs(sim_na, verbose=TRUE)

head(betas(sim_na))

## ----simple-significance-calling----------------------------------------------
sim <- callSignificance(sim, assay="lfsrs", thresh=0.05)

message("Median number of significant tests per state: ", 
    median(colData(sim)$nSignificant))

## ----simple-sig-calling-performance-------------------------------------------
sim <- callSignificance(sim, assay="lfsrs", thresh=0.001)
perf_metrics <- simPerformance(sim)
lapply(perf_metrics, FUN=function(x) {round(x, 2)})

## ----state-by-state-double-thresholds-----------------------------------------
sim <- callSignificance(
    sim, mode="simple", assay="lfsrs",
    thresh=0.0001, secondThresh=0.0002)
simPerformance(sim)$recall

## ----pairwise-sharing---------------------------------------------------------
sim_sig <- getSignificant(sim)
sim_top <- getTopHits(sim_sig, assay="lfsrs", mode="state")
sim_top <- runPairwiseSharing(sim_top)
p1 <- plotPairwiseSharing(sim_top, annotateColsBy=c("nSignificant", "multistateGroup"))
p1

## ----upset-plot---------------------------------------------------------------
plotUpSet(sim_top, annotateColsBy=c("nSignificant", "multistateGroup"))

## ----get-significant-simple---------------------------------------------------
sim_top <- runTestMetrics(sim_top)

plotCompareStates(sim_top, x="S01", y="S02")
    
table(rowData(sim_top)$qtl_type)

hist(rowData(sim_top)$nSignificant)

## ----plot-multistate-QTL------------------------------------------------------
sim_top_ms <- subset(sim_top, qtl_type_simple == "multistate")

plotQTLClusters(
    sim_top_ms, 
    annotateColsBy=c("multistateGroup"),
    annotateRowsBy=c("qtl_type", "mean_beta", "QTL"))

## ----session-info-------------------------------------------------------------
sessionInfo()

