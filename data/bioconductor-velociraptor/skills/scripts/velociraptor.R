# Code example from 'velociraptor' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
library(BiocStyle)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)

## -----------------------------------------------------------------------------
library(scRNAseq)
sce <- HermannSpermatogenesisData()
sce

## -----------------------------------------------------------------------------
sce <- sce[, 1:500]

## -----------------------------------------------------------------------------
library(scuttle)
sce <- logNormCounts(sce, assay.type=1)

library(scran)
dec <- modelGeneVar(sce)
top.hvgs <- getTopHVGs(dec, n=2000)

## -----------------------------------------------------------------------------
library(velociraptor)
velo.out <- scvelo(
  sce, subset.row=top.hvgs, assay.X="spliced",
  scvelo.params=list(neighbors=list(n_neighbors=30L))
)
velo.out

## -----------------------------------------------------------------------------
library(scater)

set.seed(100)
sce <- runPCA(sce, subset_row=top.hvgs)
sce <- runTSNE(sce, dimred="PCA", perplexity = 30)

sce$velocity_pseudotime <- velo.out$velocity_pseudotime
plotTSNE(sce, colour_by="velocity_pseudotime")

## -----------------------------------------------------------------------------
embedded <- embedVelocity(reducedDim(sce, "TSNE"), velo.out)
grid.df <- gridVectors(sce, embedded, use.dimred = "TSNE")

library(ggplot2)
plotTSNE(sce, colour_by="velocity_pseudotime") +
    geom_segment(data=grid.df, mapping=aes(x=start.1, y=start.2, 
        xend=end.1, yend=end.2, colour=NULL), arrow=arrow(length=unit(0.05, "inches")))

## -----------------------------------------------------------------------------
# Only setting assay.X= for the initial AnnData creation,
# it is not actually used in any further steps.
velo.out2 <- scvelo(sce, assay.X=1, subset.row=top.hvgs, use.dimred="PCA") 
velo.out2

## -----------------------------------------------------------------------------
velo.out3 <- scvelo(sce, assay.X=1, use.theirs=TRUE)
velo.out3

## -----------------------------------------------------------------------------
velo.out4 <- scvelo(sce, assay.X=1, subset.row=top.hvgs,
    scvelo.params=list(recover_dynamics=list(max_iter=20)))
velo.out4

## -----------------------------------------------------------------------------
sessionInfo()

