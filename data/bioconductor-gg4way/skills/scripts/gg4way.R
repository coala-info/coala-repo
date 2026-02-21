# Code example from 'gg4way' vignette. See references/ for full tutorial.

## ----Setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE,
                      message = FALSE,
                      crop = NULL)

## ----Install, eval = FALSE----------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("gg4way")

## ----Install GitHub, eval = FALSE---------------------------------------------
# if (!requireNamespace("remotes", quietly = TRUE)) {
#     install.packages("remotes")
# }
# 
# remotes::install_github("ben-laufer/gg4way")

## ----Prepare data-------------------------------------------------------------
library("airway")
data("airway")
se <- airway

library("org.Hs.eg.db")
rowData(se)$symbol <- mapIds(org.Hs.eg.db,
                             keys = rownames(se),
                             column = "SYMBOL",
                             keytype = "ENSEMBL")

rowData(se)$ID <- rownames(se)

se <- se[!is.na(rowData(se)$symbol)]

## ----limma--------------------------------------------------------------------
library("edgeR")
library("limma")

dge <- se |>
    SE2DGEList()

design <- model.matrix(~ 0 + cell + dex, data = dge$samples)
colnames(design) <- gsub("cell", "", colnames(design))

contr.matrix <- makeContrasts(N61311 - N052611,
                              N061011 - N052611,
                              levels = c("N052611", "N061011",
                                         "N080611", "N61311",
                                         "dexuntrt"))

keep <- filterByExpr(dge, design)
dge <- dge[keep, ]

efit <- dge |>
    calcNormFactors() |>
    voom(design) |>
    lmFit(design) |>
    contrasts.fit(contrasts = contr.matrix) |>
    eBayes()

## ----limmaPlot, fig.cap="gg4way from limma", fig.width=6, fig.height=6.5, dpi=50----
library("gg4way")

p1 <- efit |>
    gg4way(x = "N61311 vs N052611",
           y = "N061011 vs N052611")

p1

## ----Prepare text, include=FALSE----------------------------------------------
textTable <- p1 |>
    getTotals()

blueText <- textTable |>
    dplyr::filter(countGroup == "bottomLeft") |>
    dplyr::pull(n)

redText <- textTable |>
    dplyr::filter(countGroup == "sigX xDown yDown") |>
    dplyr::pull(n)
    
greenText <- textTable |>
    dplyr::filter(countGroup == "sigY xDown yDown") |>
    dplyr::pull(n)

## ----limma table--------------------------------------------------------------
p1 |>
    getShared() |>
    head()

## ----labelsPlot, fig.cap="gg4way with labels", fig.width=6, fig.height=6.5, dpi=50----
efit |>
    gg4way(x = "N61311 vs N052611",
           y = "N061011 vs N052611",
           label = c("PSG5", "ERAP2"))

## ----titlesPlot, fig.cap="gg4way with custom axis titles", fig.width=6, fig.height=6.5, dpi=50----
p1 +
    xlab(expression(atop(
        paste("Higher in Line 2" %<->% "Higher in Line 1"),
        paste("Line 1 vs 2 LogFC")))) +
    ylab(expression(atop(
        paste("Line 3 vs 2"),
        paste("Higher in Line 2" %<->% "Higher in Line 3"))))

## ----Correlation--------------------------------------------------------------
p1 |>
    getCor()

## ----edgeRplot, fig.cap="gg4way from edgeR", fig.width=6, fig.height=6.5, dpi=50----
library("purrr")

rfit <- dge |>
    calcNormFactors() |>
    estimateDisp() |>
    glmQLFit(design) 

rfit <- contr.matrix |> 
    colnames() |>
    set_names() |>
    map(~ rfit |>
            glmQLFTest(contrast = contr.matrix[,.x]))

rfit |>
    gg4way(x = "N61311 vs N052611",
           y = "N061011 vs N052611")

## ----DESeq2-------------------------------------------------------------------
library("DESeq2")

ddsSE <- se |>
    DESeqDataSet(design = ~ cell + dex)

keep <- ddsSE |>
    counts() |>
    apply(1, function(gene) {
        all(gene != 0)
    })

ddsSE <- ddsSE[keep, ]

dds <- ddsSE |>
    DESeq()

## ----DESeq2plot, fig.cap="gg4way from DESeq2", fig.width=6, fig.height=6.5, dpi=50----
dds |>
    gg4way(x = "N61311 vs N052611",
           y = "N061011 vs N052611")

## ----DESeq2plot2, fig.cap="gg4way from DESeq2 contrast", fig.width=6, fig.height=6.5, dpi=50----
list("N61311 vs N052611" = c("cell", "N61311", "N052611"),
     "N061011 vs N052611" = c("cell", "N061011", "N052611")) |>
    map(~ results(dds, contrast = .x)) |>
    gg4way(x = "N61311 vs N052611",
           y = "N061011 vs N052611")

## ----DESeq2plot3, fig.cap="gg4way from DESeq2 lfcShrink", fig.width=6, fig.height=6.5, dpi=50----
list("N61311 vs N052611" = c("cell", "N61311", "N052611"),
     "N061011 vs N052611" = c("cell", "N061011", "N052611")) |>
    map(~ dds |>
        results(contrast = .x) |>
        lfcShrink(dds, contrast = .x, res = _, type = "normal")) |>
    gg4way(x = "N61311 vs N052611",
           y = "N061011 vs N052611")

## ----Session info, echo=FALSE-------------------------------------------------
sessionInfo()

