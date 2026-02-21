# Code example from 'intro' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(message=FALSE, warning=FALSE)

## ----eval=FALSE---------------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("crisprViz")

## ----message=FALSE, warning=FALSE---------------------------------------------
library(BSgenome.Hsapiens.UCSC.hg38)
library(crisprDesign)
library(crisprViz)

## -----------------------------------------------------------------------------
data("krasGuideSet", package="crisprViz")
data("krasGeneModel", package="crisprViz")
length(krasGuideSet) # number of candidate gRNAs

## -----------------------------------------------------------------------------
plotGuideSet(krasGuideSet[1:4],
             geneModel=krasGeneModel,
             targetGene="KRAS")

## -----------------------------------------------------------------------------
from <- min(start(krasGeneModel$transcripts))
to <- max(end(krasGeneModel$transcripts))
plotGuideSet(krasGuideSet[1:4],
             geneModel=krasGeneModel,
             targetGene="KRAS",
             from=from,
             to=to,
             extend.left=1000,
             extend.right=1000)

## ----fig.height=10------------------------------------------------------------
plotGuideSet(krasGuideSet,
             geneModel=krasGeneModel,
             targetGene="KRAS",
             showGuideLabels=FALSE,
             from=from,
             to=to,
             extend.left=1000,
             extend.right=1000)

## -----------------------------------------------------------------------------
# new window range around target exon
targetExon <- queryTxObject(krasGeneModel,
                            featureType="cds",
                            queryColumn="exon_id",
                            queryValue="ENSE00000936617")
targetExon <- unique(targetExon)
from <- start(targetExon)
to <- end(targetExon)
plotGuideSet(krasGuideSet,
             geneModel=krasGeneModel,
             targetGene="KRAS",
             from=from,
             to=to,
             extend.left=20,
             extend.right=20)

## -----------------------------------------------------------------------------
plotGuideSet(krasGuideSet,
             geneModel=krasGeneModel,
             targetGene="KRAS",
             from=from,
             to=to,
             extend.left=20,
             extend.right=20,
             pamSiteOnly=TRUE)

## ----message=FALSE, warning=FALSE---------------------------------------------
selectedGuides <- c("spacer_80", "spacer_84", "spacer_88", "spacer_92",
                    "spacer_96", "spacer_100", "spacer_104", "spacer_108",
                    "spacer_112")
candidateGuides <- krasGuideSet[selectedGuides]
plotGuideSet(candidateGuides,
             geneModel=krasGeneModel,
             targetGene="KRAS",
             onTargetScore="score_deephf")

## -----------------------------------------------------------------------------
data("gpr21GuideSet", package="crisprViz")
data("gpr21GeneModel", package="crisprViz")

## ----fig.height=4, fig.width=6------------------------------------------------
plotGuideSet(gpr21GuideSet,
             geneModel=gpr21GeneModel,
             targetGene="GPR21",
             bsgenome=BSgenome.Hsapiens.UCSC.hg38,
             margin=0.3)

## ----fig.height=4, fig.width=10-----------------------------------------------
# increase plot width from 6" to 10"
plotGuideSet(gpr21GuideSet,
             geneModel=gpr21GeneModel,
             targetGene="GPR21",
             bsgenome=BSgenome.Hsapiens.UCSC.hg38,
             margin=0.3)

## -----------------------------------------------------------------------------
data("mmp7GuideSet", package="crisprViz")
data("mmp7GeneModel", package="crisprViz")

## -----------------------------------------------------------------------------
data("repeats", package="crisprViz")

## -----------------------------------------------------------------------------
from <- min(start(mmp7GuideSet))
to <- max(end(mmp7GuideSet))
plotGuideSet(mmp7GuideSet,
             geneModel=mmp7GeneModel,
             targetGene="MMP7",
             guideStacking="dense",
             annotations=list(Repeats=repeats),
             pamSiteOnly=TRUE,
             from=from,
             to=to,
             extend.left=600,
             extend.right=100,
             includeSNPTrack=TRUE)

## -----------------------------------------------------------------------------
filteredGuideSet <- crisprDesign::removeRepeats(mmp7GuideSet,
                                                gr.repeats=repeats)
filteredGuideSet <- filteredGuideSet[!filteredGuideSet$hasSNP]
plotGuideSet(filteredGuideSet,
             geneModel=mmp7GeneModel,
             targetGene="MMP7",
             guideStacking="dense",
             annotations=list(Repeats=repeats),
             pamSiteOnly=TRUE,
             from=from,
             to=to,
             extend.left=600,
             extend.right=100,
             includeSNPTrack=TRUE)

## -----------------------------------------------------------------------------
data("cage", package="crisprViz")
data("dnase", package="crisprViz")

## -----------------------------------------------------------------------------
plotGuideSet(filteredGuideSet,
             geneModel=mmp7GeneModel,
             targetGene="MMP7",
             guideStacking="dense",
             annotations=list(CAGE=cage, DNase=dnase),
             pamSiteOnly=TRUE,
             from=from,
             to=to,
             extend.left=600,
             extend.right=100)

## -----------------------------------------------------------------------------
# filter GuideSet for gRNAs overlapping DNase track
overlaps <- findOverlaps(filteredGuideSet, dnase, ignore.strand=TRUE)
finalGuideSet <- filteredGuideSet[queryHits(overlaps)]
plotGuideSet(finalGuideSet,
             geneModel=mmp7GeneModel,
             targetGene="MMP7",
             guideStacking="dense",
             annotations=list(CAGE=cage, DNase=dnase),
             pamSiteOnly=TRUE,
             margin=0.4)

## -----------------------------------------------------------------------------
data("cas9GuideSet", package="crisprViz")
data("cas12aGuideSet", package="crisprViz")
data("ltn1GeneModel", package="crisprViz")

## ----fig.height=8-------------------------------------------------------------
plotMultipleGuideSets(list(SpCas9=cas9GuideSet, AsCas12a=cas12aGuideSet),
                      geneModel=ltn1GeneModel,
                      targetGene="LTN1",
                      bsgenome=BSgenome.Hsapiens.UCSC.hg38,
                      margin=0.2,
                      gcWindow=10)

## ----eval=FALSE---------------------------------------------------------------
# grDevices::quartz("Example plot", width=6, height=7)
# # plot function

## -----------------------------------------------------------------------------
sessionInfo()

