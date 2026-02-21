# Code example from 'GeneExpressionSignature' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(BiocStyle)

## ----load-ges-----------------------------------------------------------------
library(GeneExpressionSignature)

## ----get-ranklist,message=FALSE-----------------------------------------------
# If you have network access
#GSM118720 <- getGEO('GSM118720')
# GSM118721 <- getGEO('GSM118721')
if (require(GEOquery)){
  #treatment gene-expression profiles
  GSM118720 <- getGEO(
    filename = system.file(
      "extdata/GSM118720.soft",
      package = "GeneExpressionSignature")
  )
  #control gene-expression profiles
  GSM118721 <- getGEO(
    filename=system.file(
      "extdata/GSM118721.soft",
      package = "GeneExpressionSignature")
  )
  #data ranking according to the different expression values 
  control <- as.matrix(as.numeric(Table(GSM118721)[, 2]))
  treatment <- as.matrix(as.numeric(Table(GSM118720)[, 2]))
  ranked_list <- getRLs(control, treatment)
}

## ----sample-data--------------------------------------------------------------
data(exampleSet)
show(exampleSet)
exprs(exampleSet)[c(1:10), c(1:3)]
levels(as(phenoData(exampleSet), "data.frame")[, 1])

## ----rank-merge---------------------------------------------------------------
MergingSet <- RankMerging(exampleSet, "Spearman", weighted = TRUE)
show(MergingSet)

## ----gsea---------------------------------------------------------------------
ds <- ScoreGSEA(MergingSet, 250, "avg")
ds[1:5, 1:5]

## ----sig-dis------------------------------------------------------------------
SignatureDistance(
  exampleSet,
  SignatureLength = 250,
  MergingDistance = "Spearman",
  ScoringMethod = "GSEA",
  ScoringDistance = "avg",
  weighted = TRUE
)

## ----merge-detail-------------------------------------------------------------
MergingSet <- RankMerging(exampleSet, "Spearman", weighted = TRUE)
show(MergingSet)

## ----gsea-detail--------------------------------------------------------------
ds <- ScoreGSEA(MergingSet,250,"avg")
ds[1:5,1:5]

## ----pgsea-detail-------------------------------------------------------------
ds <- ScorePGSEA(MergingSet,250,"avg")
ds[1:5,1:5]

## ----cluster------------------------------------------------------------------
if (require(apcluster)){
  library(apcluster)
  clusterResult <- apcluster(1 - ds)
  show(clusterResult)
}

## ----cluster-graph,echo=FALSE-------------------------------------------------
knitr::include_graphics("cluster.png")

## ----session------------------------------------------------------------------
sessionInfo()

