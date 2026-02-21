# Code example from 'ssviz' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("ssviz")

## ----loadingPackage,message=FALSE---------------------------------------------
library(ssviz)

## ----loaddata-----------------------------------------------------------------
data(ssviz)

## ----loading-bam,tidy=TRUE,warning=FALSE--------------------------------------
bam.files<-dir(system.file("extdata", package="ssviz"), full=TRUE, patt="bam$")
ctrlbam<-readBam(bam.files[1])
treatbam<-readBam(bam.files[2])

## ----viewobject---------------------------------------------------------------
ctrlbam

## ----gettingReadCounts,warning=FALSE------------------------------------------
ctrl.count<-getCountMatrix(ctrlbam)
treat.count<-getCountMatrix(treatbam)

## ----gettingReadCounts2,warning=FALSE-----------------------------------------
ctrl.count[1,]

## ----plotdistro1,tidy=TRUE,eval=FALSE-----------------------------------------
# plotDistro(list(ctrl.count), type="qwidth", samplenames=c("Control"), ncounts=counts[1])

## ----plotdistro2,tidy=TRUE,eval=FALSE,warning=FALSE---------------------------
# plotDistro(list(ctrl.count, treat.count), type="qwidth", samplenames=c("Control","Treatment"), ncounts=counts)

## ----regiondens,eval=FALSE----------------------------------------------------
# region<-'chr1:3015526-3080526'
# plotRegion(list(ctrl.count), region=region)

## ----pingpong,eval=FALSE------------------------------------------------------
# pp.ctrl<-pingpong(pctrlbam.count)
# plotPP(list(pp.ctrl), samplenames=c("Control"))

## ----ntfreq,eval=FALSE--------------------------------------------------------
# pctrlbam.count<-getCountMatrix(pctrlbam)
# freq.ctrl<-ntfreq(pctrlbam.count, ntlength=10)
# plotFreq(freq.ctrl)

## -----------------------------------------------------------------------------
sessionInfo()

