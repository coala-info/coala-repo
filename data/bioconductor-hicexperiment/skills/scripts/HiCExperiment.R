# Code example from 'HiCExperiment' vignette. See references/ for full tutorial.

## ----opts, eval = TRUE, echo=FALSE, results="hide", warning=FALSE-------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>", 
    crop = NULL
)
suppressPackageStartupMessages({
    library(dplyr)
    library(GenomicRanges)
    library(HiContactsData)
    library(HiCExperiment)
})

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("HiCExperiment")

## ----load_lib-----------------------------------------------------------------
library(HiCExperiment)
showClass("HiCExperiment")
hic <- contacts_yeast()
hic

## ----graph, eval = TRUE, echo=FALSE, out.width='100%'-------------------------
knitr::include_graphics(
   "https://raw.githubusercontent.com/js2264/HiCExperiment/devel/man/figures/HiCExperiment_data-structure.png"
)

## ----import, eval = FALSE-----------------------------------------------------
# ## Change <path/to/contact_matrix>.cool accordingly
# hic <- import(
#     "<path/to/contact_matrix>.cool",
#     focus = "chr:start-end",
#     resolution = ...
# )

## ----evaled_import------------------------------------------------------------
library(HiContactsData)
cool_file <- HiContactsData('yeast_wt', format = 'cool')
import(cool_file, format = 'cool')

## ----many_imports-------------------------------------------------------------
## --- CoolFile
pairs_file <- HiContactsData('yeast_wt', format = 'pairs.gz')
coolf <- CoolFile(cool_file, pairsFile = pairs_file)
coolf
import(coolf)
import(pairsFile(coolf), format = 'pairs')

## --- HicFile
hic_file <- HiContactsData('yeast_wt', format = 'hic')
hicf <- HicFile(hic_file, pairsFile = pairs_file)
hicf
import(hicf)

## --- HicproFile
hicpro_matrix_file <- HiContactsData('yeast_wt', format = 'hicpro_matrix')
hicpro_regions_file <- HiContactsData('yeast_wt', format = 'hicpro_bed')
hicprof <- HicproFile(hicpro_matrix_file, bed = hicpro_regions_file)
hicprof
import(hicprof)

## ----focus--------------------------------------------------------------------
availableChromosomes(cool_file)
hic <- import(cool_file, format = 'cool',  focus = 'I:20001-80000')
hic
focus(hic)

## ----asym---------------------------------------------------------------------
hic <- import(cool_file, format = 'cool', focus = 'II:1-500000|II:100001-300000')
focus(hic)

## ----mcool--------------------------------------------------------------------
mcool_file <- HiContactsData('yeast_wt', format = 'mcool')
availableResolutions(mcool_file)
availableChromosomes(mcool_file)
hic <- import(mcool_file, format = 'cool', focus = 'II:1-800000', resolution = 2000)
hic

## ----slots--------------------------------------------------------------------
fileName(hic)
focus(hic)
resolutions(hic)
resolution(hic)
interactions(hic)
scores(hic)
tail(scores(hic, 1))
tail(scores(hic, 'balanced'))
topologicalFeatures(hic)
pairsFile(hic)
metadata(hic)

## ----extra--------------------------------------------------------------------
seqinfo(hic) ## To recover the `Seqinfo` object from the `.(m)cool` file
bins(hic) ## To bin the genome at the current resolution
regions(hic) ## To extract unique regions of the contact matrix
anchors(hic) ## To extract "first" and "second" anchors for each interaction

## ----scores-------------------------------------------------------------------
scores(hic, 'random') <- runif(length(hic))
scores(hic)
tail(scores(hic, 'random'))

## ----features-----------------------------------------------------------------
topologicalFeatures(hic, 'viewpoints') <- GRanges("II:300001-320000")
topologicalFeatures(hic)
topologicalFeatures(hic, 'viewpoints')

## ----as-----------------------------------------------------------------------
as(hic, "GInteractions")
as(hic, "ContactMatrix")
as(hic, "matrix")[1:10, 1:10]
as(hic, "data.frame")[1:10, ]

## ----pairs--------------------------------------------------------------------
import(pairs_file, format = 'pairs')

## ----session------------------------------------------------------------------
sessionInfo()

