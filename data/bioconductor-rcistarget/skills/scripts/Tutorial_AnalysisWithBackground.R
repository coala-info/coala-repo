# Code example from 'Tutorial_AnalysisWithBackground' vignette. See references/ for full tutorial.

## ----libraries, echo=FALSE, message=FALSE, warning=FALSE----------------------
suppressPackageStartupMessages({
library(RcisTarget)
library(RcisTarget.hg19.motifDBs.cisbpOnly.500bp) 
library(DT)
library(data.table)
#require(visNetwork)
})

## -----------------------------------------------------------------------------
packageVersion("RcisTarget")

## -----------------------------------------------------------------------------
# Genes to analyze:
txtFile <- paste(file.path(system.file('examples', package='RcisTarget')),"hypoxiaGeneSet.txt", sep="/")
geneSets <- list(hypoxia=read.table(txtFile, stringsAsFactors=FALSE)[,1])

# Background: 
txtFile <- paste(file.path(system.file('examples', package='RcisTarget')),"randomGeneSet.txt", sep="/") # for the toy example we will use a few random genes
background <- read.table(txtFile, stringsAsFactors=FALSE)[,1]

## -----------------------------------------------------------------------------
# A: Add
background <- unique(c(geneSets$hypoxia, background))
# B: Intersect
# geneSets$hypoxia <- intersect(geneSets$hypoxia, background)

## ----fig.height=3, fig.width=3------------------------------------------------
gplots::venn(list(background=background, geneLists=unlist(geneSets)))

## ----eval=FALSE---------------------------------------------------------------
# dbPath <- "~/databases/hg19-500bp-upstream-10species.mc9nr.feather"

## ----eval=FALSE---------------------------------------------------------------
# library(RcisTarget)
# rankingsDb <- importRankings(dbPath, columns=background)
# bgRanking <- reRank(rankingsDb)

## ----eval=FALSE---------------------------------------------------------------
# motifEnrichmentTable <- cisTarget(geneSets, bgRanking,
#                                   aucMaxRank=0.03*getNumColsInDB(bgRanking),
#                                   geneErnMaxRank=getNumColsInDB(bgRanking),
#                                   geneErnMethod = "icistarget")

## ----eval=FALSE---------------------------------------------------------------
# showLogo(motifEnrichmentTable)

