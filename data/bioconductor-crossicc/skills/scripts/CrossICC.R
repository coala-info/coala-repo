# Code example from 'CrossICC' vignette. See references/ for full tutorial.

## ----echo=FALSE----------------------------------------------------------
CRANpkg <- function (pkg) {
    cran <- "https://CRAN.R-project.org/package"
    fmt <- "[%s](%s=%s)"
    sprintf(fmt, pkg, cran, pkg)
}
Biocpkg <- function (pkg) {
    sprintf("[%s](http://bioconductor.org/packages/%s)", pkg, pkg)
}

## ----getPackage, eval=FALSE----------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("CrossICC")

## ----getDevel, eval=FALSE------------------------------------------------
#  BiocManager::install("bioinformatist/CrossICC")

## ----Load, message=FALSE, eval = TRUE------------------------------------
library(CrossICC)

## ------------------------------------------------------------------------
library(CrossICC)
data(demo.platforms)
# Turn on use.shiny parameter if you want to call shiny once the CrossICC finished
CrossICC.object <- CrossICC(demo.platforms, skip.mfs = TRUE, use.shiny = FALSE, overwrite = TRUE, output.dir = tempdir())

## ------------------------------------------------------------------------
Mcluster <- paste("K", CrossICC.object$clusters$clusters[[1]], sep = "")
CrossICC.ssGSEA <- ssGSEA(x = demo.platforms[[1]], gene.signature = CrossICC.object$gene.signature, geneset2gene = CrossICC.object$unioned.genesets, cluster = Mcluster)

## ------------------------------------------------------------------------
predicted <- predictor(demo.platforms[[1]], CrossICC.object)

## ------------------------------------------------------------------------
sessionInfo()

