# Code example from 'deltaGseg' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("deltaGseg")

## ----loadingPackage,message=FALSE---------------------------------------------
library(deltaGseg)

## -----------------------------------------------------------------------------
data(deltaGseg)

## ----loading-trajectories,tidy=FALSE,warning=FALSE----------------------------
dir<-system.file("extdata",package="deltaGseg")
traj1<-parseTraj(path=dir, files=c("D_GBTOT1","D_GBTOT2","D_GBTOT3"))

## ----test---------------------------------------------------------------------
traj1

## ----plottraj1,eval=FALSE-----------------------------------------------------
# plot(traj1,name='all')

## ----traj1,tidy=TRUE,warning=FALSE--------------------------------------------
traj1.tr<-transformSeries(object=traj1,method='splitting',breakpoints=1)
traj1.tr

## ----figure1,warning=FALSE,fig.width=8,eval=FALSE-----------------------------
# plot(traj1.tr)

## ----breakpoints,warning=FALSE,tidy=TRUE--------------------------------------
all_breakpoints<-splitTraj(traj1,segsplits=c(5,5,5))
all_breakpoints

## ----plot-breakpoints,warning=FALSE,fig.width=8,eval=FALSE--------------------
# plot(traj1,breakpoints=all_breakpoints)

## ----mybreaks,warning=FALSE,tidy=TRUE,warning=FALSE---------------------------
mybreaks<-chooseBreaks(all_breakpoints,numbreaks=3)
mybreaks

## ----transform,warning=FALSE,tidy=TRUE,warning=FALSE--------------------------
traj1.sp.tr<-transformSeries(object=traj1,method='override_splitting',breakpoints=mybreaks)
traj1.sp.tr

## ----plot-denoise,warning=FALSE,eval=FALSE,message=FALSE----------------------
# traj1.denoise<-denoiseSegments(object=traj1.tr,seg_method="SegNeigh",maxQ=15,fn=1,factor=0.8,thresh_level=TRUE,minobs=200)

## ----pvals,eval=FALSE---------------------------------------------------------
# pvals<-clusterPV(object=traj1.denoise,bootstrap=500)

## ----clusterPV,warning=FALSE,eval=FALSE,tidy=TRUE-----------------------------
# traj1.ss<-clusterSegments(object=traj1.denoise,intervention = "pvclust",pv=pvals)
# ##Segment grouping. Click on the root of the groups you want clustered.
# ##Please ensure that ALL segments are grouped (boxed).
# ##Otherwise, function will not exit.
# ##To exit, click Esc (Windows/Linux) or Ctrl-click (Mac)

## ----eval=FALSE---------------------------------------------------------------
# plot(traj1.ss)

## ----getIntervals-------------------------------------------------------------
getIntervals(traj1.ss)

## ----warning=FALSE,tidy=TRUE,eval=FALSE---------------------------------------
# diagnosticPlots(object=traj1.ss,norm.test="KS",single.series=TRUE)

## -----------------------------------------------------------------------------
x<-getTraj(traj1.tr)[['D_GBTOT3_1']]
y<-x[,2]-35; y1<-y[1:2000]; y2<-y[2001:length(y)]+17
ss<-c(seq(50,length(y2),100),length(y2))
for(i in 1:(length(ss)-1)) y2[ss[i]:ss[(i+1)]]<-y2[ss[i]:ss[(i+1)]]+i^1.85
y<-cbind(x[,1],c(y1,y2))
simtraj<-parseTraj(files=list(y),fromfile=FALSE)
simtraj

## ----eval=FALSE---------------------------------------------------------------
# plot(simtraj)

## ----tidy=TRUE,warning=FALSE--------------------------------------------------
simtraj.tr<-transformSeries(object=simtraj,method='splitting',breakpoints=1)
simtraj.tr

## ----eval=FALSE---------------------------------------------------------------
# plot(simtraj.tr)

## ----tidy=TRUE,warning=FALSE,eval=FALSE---------------------------------------
# simtraj.tr2<-transformSeries(object=simtraj.tr,method='differentiation')
# simtraj.tr2

## ----eval=FALSE---------------------------------------------------------------
# plotDiff(simtraj.tr2,name="1_2")

## -----------------------------------------------------------------------------
sessionInfo()

