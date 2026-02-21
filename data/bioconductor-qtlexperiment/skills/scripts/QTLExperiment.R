# Code example from 'QTLExperiment' vignette. See references/ for full tutorial.

## ----knitr-options, echo=FALSE------------------------------------------------
knitr::opts_chunk$set(warning=FALSE, error=FALSE, message=FALSE, 
                      fig.height=6, fig.width=8)

## -----------------------------------------------------------------------------
library(QTLExperiment)

## ----mock-summary-statistics--------------------------------------------------
set.seed(42)
nStates <- 6
nQTL <- 40

mock_summary_stats <- mockSummaryStats(nStates=nStates, nQTL=nQTL)
mock_summary_stats$betas[1:5,1:5]

## ----create-mock-QTLe-manual--------------------------------------------------
qtle <- QTLExperiment(
    assays=list(
        betas=mock_summary_stats$betas,
        errors=mock_summary_stats$errors),
    metadata=list(study="mock-example"))
qtle

## ----mock-qtle-provide-ids----------------------------------------------------
mock_summary_stats <- mockSummaryStats(nStates=nStates, nQTL=nQTL, names=FALSE)
mock_summary_stats$betas[1:5,1:5]
qtle <- QTLExperiment(assays=list(betas=mock_summary_stats$betas,
                                  errors=mock_summary_stats$errors),
                      feature_id=paste0("gene_", 1:nQTL),
                      variant_id=sample(1:1e6, nQTL),
                      state_id=paste0("state_", LETTERS[1:nStates]),
                      metadata=list(study="mock-example2"))
qtle

## ----create-mock-QTLe-wrapper-------------------------------------------------
qtle <- mockQTLE(nStates=nStates, nQTL=nQTL)
qtle

## ----demo-sumstats2qtle-------------------------------------------------------
input_path <- system.file("extdata", package="QTLExperiment")
state <- c("lung", "thyroid", "spleen", "blood")

input <- data.frame(
    state=state, 
    path=paste0(input_path, "/GTEx_tx_", state, ".tsv"))

qtle4 <- sumstats2qtle(
    input, 
    feature_id="molecular_trait_id",
    variant_id="rsid", 
    betas="beta", 
    errors="se",
    pvalues="pvalue", 
    verbose=TRUE)
qtle4
head(betas(qtle4))

## ----mashr-to-qtle------------------------------------------------------------
mashr_sim <- mockMASHR(nStates=nStates, nQTL=nQTL)

qtle2 <- mash2qtle(
    mashr_sim,
    rowData=DataFrame(feature_id=row.names(mashr_sim$Bhat),
                      variant_id=sample(seq(1:1e5), nQTL)))
qtle2

## ----show-dim-----------------------------------------------------------------
dim(qtle4)

## ----show-state-names---------------------------------------------------------
colnames(qtle4)

## ----show-feature-snp-ids-----------------------------------------------------
head(rowData(qtle4))

## ----show-bind-functions------------------------------------------------------
qtle4b <- qtle4
state_id(qtle4b) <- paste0(state_id(qtle4), "_b")
dim(cbind(qtle4, qtle4b))

## ----show-rbind-functions-----------------------------------------------------
qtle4b <- qtle4
feature_id(qtle4b) <- paste0(feature_id(qtle4), "_b")
dim(rbind(qtle4, qtle4b))

## ----show-subset-functions----------------------------------------------------
qtle.subset <- qtle[rowData(qtle)$feature_id == "geneA", ]
dim(qtle.subset)

qtle.subset <- qtle[, c("state1", "state2")]
dim(qtle.subset)

qtle.subset <- subset(qtle, , sample_size > 100)
dim(qtle.subset)

## ----convenient-getters-setters-----------------------------------------------
betas(qtle)[1:5,1:5]

betas(qtle) <- betas(qtle) * -1

betas(qtle)[1:5,1:5]

## ----set-significance-assay---------------------------------------------------
assay(qtle4, "significant") <- assay(qtle4, "pvalues") < 0.05

assay(qtle4, "significant")[1:5, 1:4]

## ----special-getters----------------------------------------------------------
state_id(qtle4)
feature_id(qtle4)[1:3]
variant_id(qtle4)[1:3]

## ----special-setters----------------------------------------------------------
state_id(qtle4) <- c("LUNG", "THYROID", "SPLEEN", "BLOOD")
head(colData(qtle4))
head(betas(qtle4))

## ----session-info-------------------------------------------------------------
sessionInfo()

