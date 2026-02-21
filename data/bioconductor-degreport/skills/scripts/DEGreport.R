# Code example from 'DEGreport' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
library(BiocStyle)
knitr::opts_chunk$set(tidy=FALSE,
                      dev="png",
                      message=FALSE, error=FALSE,
                      warning=TRUE)

## ----load-data----------------------------------------------------------------
library(DEGreport)
data(humanGender)

## ----experiment---------------------------------------------------------------
library(DESeq2)
idx <- c(1:10, 75:85)
dds <- DESeqDataSetFromMatrix(assays(humanGender)[[1]][1:1000, idx],
                              colData(humanGender)[idx,], design=~group)
dds <- DESeq(dds)
res <- results(dds)

## ----count-design-------------------------------------------------------------
counts <- counts(dds, normalized = TRUE)
design <- as.data.frame(colData(dds))

## ----check-factor-------------------------------------------------------------
degCheckFactors(counts[, 1:6])

## ----qc-----------------------------------------------------------------------
degQC(counts, design[["group"]], pvalue = res[["pvalue"]])

## ----cov----------------------------------------------------------------------
resCov <- degCovariates(log2(counts(dds)+0.5),
                        colData(dds))

## ----corcov-------------------------------------------------------------------
cor <- degCorCov(colData(dds))
names(cor)

## ----report, eval=FALSE-------------------------------------------------------
# createReport(colData(dds)[["group"]], counts(dds, normalized = TRUE),
#              row.names(res)[1:20], res[["pvalue"]], path = "~/Downloads")

## ----degComps-----------------------------------------------------------------
degs <- degComps(dds, combs = "group",
                 contrast = list("group_Male_vs_Female",
                                 c("group", "Female", "Male")))
names(degs)

## ----deg----------------------------------------------------------------------
deg(degs[[1]])

## ----raw----------------------------------------------------------------------
deg(degs[[1]], "raw", "tibble")

## ----significants-------------------------------------------------------------
significants(degs[[1]], fc = 0, fdr = 0.05)

## ----significants-list--------------------------------------------------------
significants(degs, fc = 0, fdr = 0.05)

## ----significants-list-full---------------------------------------------------
significants(degs, fc = 0, fdr = 0.05, full = TRUE)

## ----plotMA-------------------------------------------------------------------
degMA(degs[[1]], diff = 2, limit = 3)

## ----plotMA-raw---------------------------------------------------------------
degMA(degs[[1]], diff = 2, limit = 3, raw = TRUE)

## ----plotMA-cor---------------------------------------------------------------
degMA(degs[[1]], limit = 3, correlation = TRUE)

## ----deseq2-volcano-----------------------------------------------------------
res[["id"]] <- row.names(res)
show <- as.data.frame(res[1:10, c("log2FoldChange", "padj", "id")])
degVolcano(res[,c("log2FoldChange", "padj")], plot_text = show)

## ----deseq2-gene-plots--------------------------------------------------------
degPlot(dds = dds, res = res, n = 6, xs = "group")

## ----deseq2-gene-plot-wide----------------------------------------------------
degPlotWide(dds, rownames(dds)[1:5], group="group")

## ----markers------------------------------------------------------------------
data(geneInfo)
degSignature(humanGender, geneInfo, group = "group")

## ----deseq2-------------------------------------------------------------------
resreport <- degResults(dds = dds, name = "test", org = NULL,
                        do_go = FALSE, group = "group", xs = "group",
                        path_results = NULL)

## ----shiny, eval=FALSE--------------------------------------------------------
# degObj(counts, design, "degObj.rda")
# library(shiny)
# shiny::runGitHub("lpantano/shiny", subdir="expression")

## ----pattern------------------------------------------------------------------
ma = assay(rlog(dds))[row.names(res)[1:100],]
res <- degPatterns(ma, design, time = "group")

## ----filter, results="asis"---------------------------------------------------
cat("gene in original count matrix: 1000")
filter_count <- degFilter(counts(dds),
                          design, "group",
                          min=1, minreads = 50)
cat("gene in final count matrix", nrow(filter_count))

## ----degColors----------------------------------------------------------------
library(ComplexHeatmap)
th <- HeatmapAnnotation(df = colData(dds),
                        col = degColors(colData(dds), TRUE))
Heatmap(log2(counts(dds) + 0.5)[1:10,],
        top_annotation = th)

library(pheatmap)
pheatmap(log2(counts(dds) + 0.5)[1:10,], 
         annotation_col = as.data.frame(colData(dds))[,1:4],
         annotation_colors = degColors(colData(dds)[1:4],
                                       con_values = c("white",
                                                      "red")
                                       )
         )


## ----sessionInfo--------------------------------------------------------------
sessionInfo()

