# Code example from 'M3D_vignette' vignette. See references/ for full tutorial.

## ----style-Sweave, eval=TRUE, echo=FALSE, results='asis'-------------------
BiocStyle::latex()

## ----eval=FALSE------------------------------------------------------------
#  rrbs <- readBedFiles(files, colData, bed_type = 'Encode', eData=NaN)

## ----eval=FALSE------------------------------------------------------------
#  files <- c('wgEncodeHaibMethylRrbsH1hescHaibSitesRep1.bed.gz',
#  'wgEncodeHaibMethylRrbsH1hescHaibSitesRep2.bed.gz',
#  'wgEncodeHaibMethylRrbsK562HaibSitesRep1.bed.gz',
#  'wgEncodeHaibMethylRrbsK562HaibSitesRep2.bed.gz')
#  group <- factor(c('H1-hESC','H1-hESC','K562','K562'))
#  samples <- c('H1-hESC1','H1-hESC2','K562-1','K562-2')
#  colData <- DataFrame(group,row.names= samples)

## ----setup,message=FALSE---------------------------------------------------
library(BiSeq)
library(M3D)

## --------------------------------------------------------------------------
data(rrbsDemo)
rrbsDemo

## --------------------------------------------------------------------------
data(CpGsDemo)
CpGsDemo

## --------------------------------------------------------------------------
data(CpGsDemo)
data(rrbsDemo)
overlaps <- findOverlaps(CpGsDemo,rowRanges(rrbsDemo))

## ----eval=FALSE------------------------------------------------------------
#  MMDlistDemo <- M3D_Wrapper(rrbsDemo, overlaps)

## --------------------------------------------------------------------------
data(MMDlistDemo)

## --------------------------------------------------------------------------
# the full MMD
head(MMDlistDemo$Full)
# the coverage only MMD
head(MMDlistDemo$Coverage)

## --------------------------------------------------------------------------
M3Dstat <- MMDlistDemo$Full-MMDlistDemo$Coverage

## ----M3DstatPlot-----------------------------------------------------------
repCols <- c(1,6)
plot(as.vector(MMDlistDemo$Full[,repCols]),
    as.vector(MMDlistDemo$Coverage[,repCols]),
    xlab='Full MMD',ylab='Coverage MMD')
    title('Test Statistics: Replicate Comparison')
abline(a=0,b=1,col='red',lwd=2)

## ----M3DstatBetweenPlot----------------------------------------------------
groupCols <- 2:5
plot(as.vector(MMDlistDemo$Full[,groupCols]),
    as.vector(MMDlistDemo$Coverage[,groupCols]),
    xlab='Full MMD',ylab='Coverage MMD')
title('Test Statistics: Inter-Group Comparison')
abline(a=0,b=1,col='red',lwd=2)

## ----M3DhistPlot-----------------------------------------------------------
repCols <- c(1,6)
groupCols <- 2:5
M3Dstat <- MMDlistDemo$Full - MMDlistDemo$Coverage
breaks <- seq(-0.2,1.2,0.1)
# WT reps
hReps <- hist(M3Dstat[,repCols], breaks=breaks,plot=FALSE)
# mean between groups
hGroups <- hist(rowMeans(M3Dstat[,groupCols]),breaks=breaks,plot=FALSE)
col1 <- "#0000FF40"
col2 <- "#FF000040"
plot(hReps,col=col1, freq=FALSE, ylab='Density',
    xlab='MMD statistic', main= 'M3D Stat Histogram')
plot(hGroups, col=col2, freq=FALSE, add=TRUE)
legend(x=0.5, y =3, legend=c('Replicates', 'Groups'), fill=c(col1, col2))

## --------------------------------------------------------------------------
data(PDemo)

## --------------------------------------------------------------------------
group1 <- unique(colData(rrbsDemo)$group)[1]
group2 <-unique(colData(rrbsDemo)$group)[2]
PDemo <- pvals(rrbsDemo, CpGsDemo, M3Dstat,
    group1, group2, smaller=FALSE, comparison='allReps', method='empirical', closePara=0.005)
head(PDemo$FDRmean)

## --------------------------------------------------------------------------
called <- which(PDemo$FDRmean<=0.01)
head(called)
head(CpGsDemo[called])

## --------------------------------------------------------------------------
par(mfrow=c(2,2))
for (i in 1:4){
    CpGindex <- called[i]
    plotMethProfile(rrbsDemo, CpGsDemo, 'H1-hESC', 'K562', CpGindex)
}

## ----eval=FALSE------------------------------------------------------------
#  MMDlistDemo <- M3D_Wrapper(rrbsDemo, overlaps)

## ----eval=FALSE------------------------------------------------------------
#  MMDlistDemo <- M3D_Wrapper_lite(rrbsDemo, overlaps)

## ----eval=FALSE------------------------------------------------------------
#  MMDlistDemo <- M3D_Wrapper(rrbsDemo, overlaps)
#  M3Dstat <- MMDlistDemo$Full-MMDlistDemo$Coverage
#  PDemo <- pvals(rrbsDemo, CpGsDemo, M3Dstat,
#      group1, group2, smaller=FALSE, comparison='allReps', method='empirical', closePara=0.005)

## ----eval=FALSE------------------------------------------------------------
#  MMDlistDemo <- M3D_Wrapper_lite(rrbsDemo, overlaps)
#  PDemo <- pvals_lite(rrbsDemo, CpGsDemo, M3Dstat,
#      group1, group2, smaller=FALSE, comparison='allReps', method='empirical', closePara=0.005)

## ----eval=FALSE------------------------------------------------------------
#  # change working directory to the location of the files
#  group <- factor(c('H1-hESC','H1-hESC','K562','K562'))
#  samples <- c('H1-hESC1','H1-hESC2','K562-1','K562-2')
#  colData <- DataFrame(group,row.names= samples)
#  files <- c('wgEncodeHaibMethylRrbsH1hescHaibSitesRep1.bed.gz',
#             'wgEncodeHaibMethylRrbsH1hescHaibSitesRep2.bed.gz',
#             'wgEncodeHaibMethylRrbsK562HaibSitesRep1.bed.gz',
#             'wgEncodeHaibMethylRrbsK562HaibSitesRep2.bed.gz')
#  rrbs <- readBedFiles(files,colData, bed_type = ENCODE)

## ----eval=FALSE------------------------------------------------------------
#  # Create the CpGs
#  rrbs.CpGs <- clusterSites(object=rrbs,groups=unique(colData(rrbs)$group),
#                            perc.samples = 3/4, min.sites = 20, max.dist=100)
#  CpGs <- clusterSitesToGR(rrbs.CpGs)

## ----eval=FALSE------------------------------------------------------------
#  inds <- vector()
#  overlaps <- findOverlaps(CpGs,rowRanges(rrbs.CpGs))
#  for (i in 1:length(CpGs)){
#    covs <- colSums(totalReads(rrbs.CpGs)[subjectHits(
#    	overlaps[queryHits(overlaps)==i]),])
#    if (!any(covs<=100)){
#      inds <- c(inds,i)
#    }
#  }
#  CpGs <- CpGs[inds]
#  rm(inds)

## ----eval=FALSE------------------------------------------------------------
#  # reduce the rrbs to only the cytosine sites within regions
#  rrbs <- rrbs.CpGs
#  CpGs <- CpGs[1:1000] # first 1000 regions
#  overlaps <- findOverlaps(CpGs,rowRanges(rrbs))
#  rrbs <- rrbs[subjectHits(overlaps)]
#  overlaps <- findOverlaps(CpGs,rowRanges(rrbs))

## --------------------------------------------------------------------------
sessionInfo()

