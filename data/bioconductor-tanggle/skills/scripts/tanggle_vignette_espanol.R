# Code example from 'tanggle_vignette_espanol' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)
suppressPackageStartupMessages({
    library(tanggle, quietly=TRUE)
    library(phangorn, quietly=TRUE)
    library(ggtree, quietly=TRUE)
})

## ----install-bioc, eval=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("tanggle")

## ----install-gh, eval=FALSE---------------------------------------------------
# if (!requireNamespace("remotes", quietly=TRUE))
#   install.packages("remotes")
# remotes::install_github("KlausVigo/tanggle")

## ----install-ggtree, eval=FALSE-----------------------------------------------
# remotes::install_github("YuLab-SMU/ggtree")

## ----load-pkg, echo=TRUE, results='hide'--------------------------------------
library(tanggle)
library(phangorn)
library(ggtree)

## -----------------------------------------------------------------------------
fdir <- system.file("extdata/trees", package = "phangorn")
Nnet <- phangorn::read.nexus.networx(file.path(fdir,"woodmouse.nxs"))

## -----------------------------------------------------------------------------
p <- ggsplitnet(Nnet) + geom_tiplab2()
p

## -----------------------------------------------------------------------------
p <- p + xlim(-0.019, .003) + ylim(-.01, .012) 
p

## -----------------------------------------------------------------------------
Nnet$translate$label <- seq_along(Nnet$tip.label)

## -----------------------------------------------------------------------------
ggsplitnet(Nnet) + geom_tiplab2(col = "blue", font = 4, hjust = -0.15) + 
    geom_nodepoint(col = "green", size = 0.25)

## -----------------------------------------------------------------------------
ggsplitnet(Nnet) + geom_point(aes(shape = isTip, color = isTip), size = 2)

## -----------------------------------------------------------------------------
z <- read.evonet(text = "((1,((2,(3,(4)Y#H1)g)e,(((Y#H1,5)h,6)f)X#H2)c)a,
                 ((X#H2,7)d,8)b)r;")

## -----------------------------------------------------------------------------
ggevonet(z, layout = "rectangular") + geom_tiplab() + geom_nodelab()
p <- ggevonet(z, layout = "slanted") + geom_tiplab() + geom_nodelab()
p + geom_tiplab(size=3, color="purple")
p + geom_nodepoint(color="#b5e521", alpha=1/4, size=10)

## -----------------------------------------------------------------------------
sessionInfo()

