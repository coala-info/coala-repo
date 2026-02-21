# Code example from 'sitePath' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----import_tree, message=FALSE-----------------------------------------------
library(sitePath)

tree_file <- system.file("extdata", "ZIKV.newick", package = "sitePath")
tree <- read.tree(tree_file)

## ----bad_tree_example, echo=FALSE---------------------------------------------
bad_tree <- read.tree(system.file("extdata", "WNV.newick", package = "sitePath"))

ggtree::ggtree(bad_tree) + ggplot2::ggtitle("Do not use a tree like this")

## ----add_alignment, message=FALSE---------------------------------------------
alignment_file <- system.file("extdata", "ZIKV.fasta", package = "sitePath")

options(list("cl.cores" = 1)) # Set this bigger than 1 to use multiprocessing

paths <- addMSA(tree, msaPath = alignment_file, msaFormat = "fasta")

## ----sneakPeek_plot-----------------------------------------------------------
preassessment <- sneakPeek(paths, makePlot = TRUE)

## ----get_lineagePath----------------------------------------------------------
paths <- lineagePath(preassessment, 18)
paths

## ----plot_paths---------------------------------------------------------------
plot(paths)

## ----min_entropy--------------------------------------------------------------
minEntropy <- sitesMinEntropy(paths)

## ----find_fixations-----------------------------------------------------------
fixations <- fixationSites(minEntropy)
fixations

## -----------------------------------------------------------------------------
allSites <- allSitesName(fixations)
allSites

## ----get_sitePath-------------------------------------------------------------
sp <- extractSite(fixations, 139)

## ----get_tipNames-------------------------------------------------------------
extractTips(fixations, 139)

## ----plot_sitePath------------------------------------------------------------
plot(sp)
plotSingleSite(fixations, 139)

## ----plot_fixations-----------------------------------------------------------
plot(fixations)

## -----------------------------------------------------------------------------
paraSites <- parallelSites(minEntropy, minSNP = 1, mutMode = "exact")
paraSites

## -----------------------------------------------------------------------------
plotSingleSite(paraSites, 105)

## ----plot_parallel------------------------------------------------------------
plot(paraSites)

## ----plot_sites---------------------------------------------------------------
plotSingleSite(paths, 139)
plotSingleSite(paths, 763)

## ----find_SNP-----------------------------------------------------------------
snps <- SNPsites(paths)
plotMutSites(snps)
plotSingleSite(paths, snps[4])
plotSingleSite(paths, snps[5])

## ----session_info-------------------------------------------------------------
sessionInfo()

