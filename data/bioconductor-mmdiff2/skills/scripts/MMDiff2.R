# Code example from 'MMDiff2' vignette. See references/ for full tutorial.

## ----style-Sweave, eval=TRUE, echo=FALSE, results='asis'-------------------
BiocStyle::latex()

## ----quickstart,message=FALSE,eval=FALSE-----------------------------------
# 
# library('MMDiff2')
# library('MMDiffBamSubset')
# ExperimentData <- list(genome='BSgenome.Mmusculus.UCSC.mm9',
#                        dataDir=system.file("extdata", package="MMDiffBamSubset"),
#                        sampleSheet="Cfp1.csv")
# MetaData <- list('ExpData' = ExperimentData)
# MMD <- DBAmmd(MetaData)
# data("Cfp1-Peaks")
# MMD <- setRegions(MMD,Peaks)
# MMD <- getPeakReads(MMD)
# MMD <- estimateFragmentCenters(MMD)
# MMD <- compHists(MMD)
# MMD <- compDists(MMD)
# MMD <- setContrast(MMD,contrast='byCondition')
# MMD <- compPvals(MMD)
# res <- reportResults(MMD)

## ----setup,message=FALSE---------------------------------------------------

# load software package
library('MMDiff2')

## ----dataload,message=FALSE------------------------------------------------
# load data packages
library('MMDiffBamSubset')

# create metaData:

ExperimentData <- list(genome = 'BSgenome.Mmusculus.UCSC.mm9',
                    dataDir = system.file("extdata", package="MMDiffBamSubset"),
                    sampleSheet="Cfp1.csv")

MetaData <- list('ExpData' = ExperimentData)


## ----regions,message=FALSE-------------------------------------------------

data('Cfp1-Peaks')
MMD <- DBAmmd(MetaData)
MMD <- setRegions(MMD,Peaks)
MMD <- getPeakReads(MMD)

## ----fragC, message=FALSE, markup='hide'-----------------------------------
MMD <- estimateFragmentCenters(MMD)

## ----hists,message=FALSE---------------------------------------------------
MMD <- compHists(MMD, bin.length=20, whichPos="Center")

## ----peakplot1, markup='hide', message=FALSE, fig.width=7, fig.height=3, fig.align='center'----
plotPeak(MMD, Peak.id='241', plot.input = FALSE, whichPos="Center")

## ----motif specifcation----------------------------------------------------
library('MotifDb')
motifs <- query(query(MotifDb, 'Mmusculus'), 'E2F')

## ----peakplot2,message=FALSE,fig.width=7, fig.height=4, fig.align='center'----
plotPeak(MMD, Peak.id='241', NormMethod=NULL,plot.input = FALSE,whichPos="Center",
  Motifs=motifs,Motifcutoff="80%")

## ----peakplot3,message=FALSE,fig.width=7, fig.height=5, fig.align='center'----
data("mm9-Genes")
names(GR) <- GR$tx_name
GR <- list(UCSCKnownGenes = GR)
plotPeak(MMD, Peak.id='241', NormMethod=NULL,plot.input = FALSE,
         whichPos="Center",Motifs=motifs, anno=GR)

## ----dists, message=FALSE, include=FALSE-----------------------------------
MMD <- compDists(MMD, dist.method = "MMD", run.parallel = FALSE)

## ----contrast--------------------------------------------------------------
MMD <- setContrast(MMD,contrast='byCondition')

## ----contrast2,message=FALSE, include=FALSE--------------------------------
group1 <- Samples(MMD)$Condition=='1'
names(group1) <- Samples(MMD)$SampleID
group2 <- Samples(MMD)$Condition=='2'
names(group2) <-  Samples(MMD)$SampleID

contrast <- list(group1=group1,
                 group2=group2,
                 name1='WT,REsc',
                 name2='Null')

#setContrast(MMD,contrast=contrast)

## ----diffTest--------------------------------------------------------------
MMD <- compPvals(MMD,dist.method='MMD')

## --------------------------------------------------------------------------
plotDists(MMD, dist.method='MMD',whichContrast=1,
                          diff.method='MMD.locfit',
                          bUsePval=FALSE, th=0.1,
                          title=NULL, what=3,
                          xlim=NULL,ylim=NULL,Peak.IDs=NULL,
                          withLegend=TRUE)


## --------------------------------------------------------------------------

res <- reportResults(MMD)

Peak.ids <- names(res)

plotPeak(MMD, Peak.id=Peak.ids[1], NormMethod=NULL,plot.input = FALSE,
         whichPos="Center",Motifs=motifs, anno=GR,whichContrast = 1)
dev.off()
plotDISTS4Peak(MMD,Peak.id=Peak.ids[1],dist.method='MMD',
               whichContrast=1,Zoom=TRUE)


## ----shinyApp,eval=FALSE---------------------------------------------------
# runShinyMMDiff2(MMD)

## --------------------------------------------------------------------------
sessionInfo()

