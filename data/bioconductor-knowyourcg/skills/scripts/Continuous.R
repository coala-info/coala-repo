# Code example from 'Continuous' vignette. See references/ for full tutorial.

## ----ky9, echo = FALSE, results="asis"----------------------------------------
library(knitr)
df = data.frame(
    c("Correlation-based","Set Enrichment Analysis"),
    c("Set Enrichment Analysis","Fisher's Exact Test")
)
colnames(df) <- c("Continuous Database Set", "Discrete Database Set")
rownames(df) <- c("Continuous Query", "Discrete Query")
kable(df, caption="Four knowYourCG Testing Scenarios")

## ----ky21, run-test-data, echo=TRUE, eval=TRUE, message=FALSE-----------------
library(knowYourCG)
query <- getDBs("KYCG.MM285.designGroup")[["TSS"]]

## ----ky22, echo=TRUE, eval=TRUE, message=FALSE--------------------------------
sesameDataCache(data_titles = c("KYCG.MM285.seqContextN.20210630"))
res <- testEnrichmentSEA(query, "MM285.seqContextN")
main_stats <- c("dbname", "test", "estimate", "FDR", "nQ", "nD", "overlap")
res[,main_stats]

## ----ky23, warning=FALSE, eval=TRUE,message=FALSE-----------------------------
library(sesame)
sesameDataCache(data_titles = c("MM285.1.SigDF"))
beta_values <- getBetas(sesameDataGet("MM285.1.SigDF"))
res <- testEnrichmentSEA(beta_values, "MM285.chromHMM")
main_stats <- c("dbname", "test", "estimate", "FDR", "nQ", "nD", "overlap")
res[,main_stats] 

## -----------------------------------------------------------------------------
sessionInfo()

