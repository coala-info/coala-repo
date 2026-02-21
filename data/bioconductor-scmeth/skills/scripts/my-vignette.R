# Code example from 'my-vignette' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("scmeth")

## ----warning=FALSE, message=FALSE---------------------------------------------
library(scmeth)

## ----eval=FALSE---------------------------------------------------------------
# directory <- system.file("extdata", "bismark_data", package='scmeth')
# bsObject <- HDF5Array::loadHDF5SummarizedExperiment(directory)

## ----eval=FALSE---------------------------------------------------------------
# report(bsObject, '~/Documents', Hsapiens, "hg38")

## ----warning=FALSE, message=FALSE, comment=FALSE------------------------------
directory <- system.file("extdata", "bismark_data", package='scmeth')
bsObject <- HDF5Array::loadHDF5SummarizedExperiment(directory)

## -----------------------------------------------------------------------------
scmeth::coverage(bsObject)

## ----fig.width=6, fig.height=3------------------------------------------------
readmetrics(bsObject)

## ----warning=FALSE, message=FALSE---------------------------------------------
library(BSgenome.Mmusculus.UCSC.mm10)
load(system.file("extdata", 'bsObject.rda', package='scmeth'))
repMask(bs, Mmusculus, "mm10")

## ----warning=FALSE------------------------------------------------------------
chromosomeCoverage(bsObject)

## ----warning=FALSE,message=FALSE----------------------------------------------
#library(annotatr)
featureList <- c('cpg_islands', 'cpg_shores', 'cpg_shelves')
DT::datatable(featureCoverage(bsObject, features=featureList, "hg38"))

## ----warning=FALSE, message=FALSE---------------------------------------------
library(BSgenome.Hsapiens.NCBI.GRCh38)
DT::datatable(cpgDensity(bsObject, Hsapiens, windowLength=1000, small=TRUE))

## ----warning=FALSE------------------------------------------------------------
DT::datatable(scmeth::downsample(bsObject))

## ----warning=FALSE, message=FALSE, fig.width=6, fig.height=6------------------

methylationBiasFile <- '2017-04-21_HG23KBCXY_2_AGGCAGAA_TATCTC_pe.M-bias.txt'
mbiasList <- mbiasplot(mbiasFiles=system.file("extdata", methylationBiasFile,
                                         package='scmeth'))

mbiasDf <- do.call(rbind.data.frame, mbiasList)
meanTable <- stats::aggregate(methylation ~ position + read, data=mbiasDf, FUN=mean)
sdTable <- stats::aggregate(methylation ~ position + read, data=mbiasDf, FUN=sd)
seTable <- stats::aggregate(methylation ~ position + read, data=mbiasDf, FUN=function(x){sd(x)/sqrt(length(x))})
sum_mt<-data.frame('position'=meanTable$position,'read'=meanTable$read,
                       'meth'=meanTable$methylation, 'sdMeth'=sdTable$methylation,
                       'seMeth'=seTable$methylation)

sum_mt$upperCI <- sum_mt$meth + (1.96*sum_mt$seMeth)
sum_mt$lowerCI <- sum_mt$meth - (1.96*sum_mt$seMeth)
sum_mt$read_rep <- paste(sum_mt$read, sum_mt$position, sep="_")

g <- ggplot2::ggplot(sum_mt)
g <- g + ggplot2::geom_line(ggplot2::aes_string(x='position', y='meth',
                                                colour='read'))
g <- g + ggplot2::geom_ribbon(ggplot2::aes_string(ymin = 'lowerCI',
                        ymax = 'upperCI', x='position', fill = 'read'),
                        alpha=0.4)
g <- g + ggplot2::ylim(0,100) + ggplot2::ggtitle('Mbias Plot')
g <- g + ggplot2::ylab('methylation')
g


## ----warning=FALSE, message=FALSE, fig.width=6, fig.height=3------------------
methylationDist(bsObject)

## ----warning=FALSE, message=FALSE, fig.width=4, fig.height=6------------------
bsConversionPlot(bsObject)

## ----warning=FALSE, message=FALSE---------------------------------------------
sessionInfo()

