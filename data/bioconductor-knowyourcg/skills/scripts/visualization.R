# Code example from 'visualization' vignette. See references/ for full tutorial.

## ----ky14, echo=TRUE, message=FALSE-------------------------------------------
library(SummarizedExperiment)
library(sesame)
library(knowYourCG)
sesameDataCache("MM285.tissueSignature")
kycgDataCache()
df <- rowData(sesameDataGet('MM285.tissueSignature'))
query <- df$Probe_ID[df$branch == "fetal_liver" & df$type == "Hypo"]
results <- testEnrichment(query, "TFBS")

## ----ky15, fig.width=5, fig.height=3.5----------------------------------------
KYCG_plotDot(results)

## ----ky16, fig.width=6.5, fig.height=4, message=FALSE-------------------------
library(ggplot2)
library(wheatmap)
p1 <- KYCG_plotBar(results, label=TRUE)
p2 <- KYCG_plotBar(results, y="estimate") + ylab("log2(Odds Ratio)") +
    xlab("") + theme(axis.text.y = element_blank())
WGG(p1) + WGG(p2, RightOf(width=0.5, pad=0))

## ----ky17, fig.width=6, fig.height=4, warning=FALSE, message=FALSE------------
query <- df$Probe_ID[df$branch == "fetal_brain" & df$type == "Hypo"]
results_2tailed <- testEnrichment(query, "TFBS", alternative = "two.sided")
KYCG_plotVolcano(results_2tailed)

## ----ky18, fig.width=6, fig.height=4.5----------------------------------------
KYCG_plotWaterfall(results)

## ----ky19, fig.width=3.5, fig.height=4----------------------------------------
## pick some big TFBS-overlapping CpG groups
cg_lists <- getDBs("MM285.TFBS", silent=TRUE)
queries <- cg_lists[(sapply(cg_lists, length) > 40000)]
res <- lapply(queries, function(q) {
    testEnrichment(q, "MM285.chromHMM", silent=TRUE)})

## note the input of the function is a list of testEnrichment outputs.
KYCG_plotPointRange(res)

## ----ky20, plot-meta1, fig.width=5, fig.height=4, message=FALSE---------------
sdf <- sesameDataGet("EPIC.1.SigDF")
KYCG_plotMeta(getBetas(sdf))

## ----ky21, fig.width=6, fig.height=4, message=FALSE---------------------------
library(ggrepel)
smry_pvals = readRDS(url("https://zenodo.org/records/18176501/files/20220413_testManhattan.rds"))
KYCG_plotManhattan(-log10(smry_pvals), platform="HM450",
    title="Differentially Methylated CpGs - EWAS Aging",
    col=c("navy","skyblue"), ylabel = bquote(-log[10](P~value)), label_min=30) +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

## ----ky22, echo=TRUE, message=FALSE-------------------------------------------
library(SummarizedExperiment)
betas = assay(sesameDataGet('MM285.467.SE.tissue20Kprobes'))

## ----ky25---------------------------------------------------------------------
stats <- dbStats(betas, 'MM285.chromHMM')
head(stats[, 1:5])

## ----ky26, fig.width=6, fig.height=6------------------------------------------
library(wheatmap)
WHeatmap(both.cluster(stats)$mat, xticklabels=TRUE,
    cmp=CMPar(stop.points=c("blue","yellow")))

## ----ky30---------------------------------------------------------------------
query <- names(sesameData_getManifestGRanges("MM285"))
anno <- annoProbes(query, "designGroup", silent = TRUE)
head(anno)

