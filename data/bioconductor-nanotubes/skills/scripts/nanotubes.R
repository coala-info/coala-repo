# Code example from 'nanotubes' vignette. See references/ for full tutorial.

## ----bioconductor, eval=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("nanotubes")

## ----library, results='hide', message=FALSE-----------------------------------
library(nanotubes)

## ----github, eval=FALSE-------------------------------------------------------
# devtools::install_github("MalteThodberg/nanotubes")

## ----citation, eval=TRUE------------------------------------------------------
citation("nanotubes")

## ----nanotubes----------------------------------------------------------------
data("nanotubes")
knitr::kable(nanotubes)

## ----rtracklayer, message=FALSE-----------------------------------------------
library(rtracklayer)
bw_fname <- system.file("extdata", nanotubes$BigWigPlus[1], 
                        package = "nanotubes", 
                        mustWork = TRUE)
import(bw_fname)

## ----CAGEfightR, eval=FALSE---------------------------------------------------
# library(CAGEfightR)
# 
# # Setup paths
# bw_plus <- system.file("extdata", nanotubes$BigWigPlus,
#                         package = "nanotubes",
#                         mustWork = TRUE)
# bw_minus <- system.file("extdata", nanotubes$BigWigMinus,
#                         package = "nanotubes",
#                         mustWork = TRUE)
# 
# # Save as named BigWigFileList
# bw_plus <- BigWigFileList(bw_plus)
# bw_minus <- BigWigFileList(bw_minus)
# names(bw_plus) <- names(bw_minus) <- nanotubes$Name
# 
# # Quantify
# CTSSs <- quantifyCTSSs(bw_plus, bw_minus, design=nanotubes)

## ----session------------------------------------------------------------------
sessionInfo()

