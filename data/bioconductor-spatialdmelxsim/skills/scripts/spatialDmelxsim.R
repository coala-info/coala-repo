# Code example from 'spatialDmelxsim' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, "spatialDmelxsim")

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(SummarizedExperiment))
library(spatialDmelxsim)
se <- spatialDmelxsim()

## -----------------------------------------------------------------------------
table(is.na(mcols(se)$paper_symbol))
rownames(se) <- mcols(se)$paper_symbol

## -----------------------------------------------------------------------------
assay(se, "total") <- assay(se, "a1") + assay(se, "a2") 
assay(se, "ratio") <- assay(se, "a1") / assay(se, "total")

## -----------------------------------------------------------------------------
plotGene <- function(gene) {
    x <- se$normSlice
    y <- assay(se, "ratio")[gene,]
    col <- as.integer(se$rep)
    plot(x, y, xlab="normSlice", ylab="sim / total ratio",
        ylim=c(0,1), main=gene, col=col)
    lw <- loess(y ~ x, data=data.frame(x,y=unname(y)))
    lines(sort(lw$x), lw$fitted[order(lw$x)], col="red", lwd=2)
    abline(h=0.5, col="grey")
}

## ----DOR----------------------------------------------------------------------
plotGene("DOR")

## ----uif----------------------------------------------------------------------
plotGene("uif")

## ----bmm----------------------------------------------------------------------
plotGene("bmm")

## ----hb-----------------------------------------------------------------------
plotGene("hb")

## ----CG4500-------------------------------------------------------------------
plotGene("CG4500")

## -----------------------------------------------------------------------------
sessionInfo()

