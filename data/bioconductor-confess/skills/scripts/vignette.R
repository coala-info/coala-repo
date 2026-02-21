# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----warning=FALSE,message=FALSE----------------------------------------------
library(CONFESS)

## ----eval=FALSE---------------------------------------------------------------
# library(CONFESSdata)
# data_path<-system.file("extdata",package="CONFESSdata")
# files<-readFiles(iDirectory=NULL,
#                   BFdirectory=paste(data_path,"/BF",sep=""),
#                   CHdirectory=paste(data_path,"/CH",sep=""),
#                   separator = "_",image.type = c("BF","Green","Red"),
#                   bits=2^16)

## ----eval=FALSE---------------------------------------------------------------
# estimates <- spotEstimator(files=files,foregroundCut=seq(0.6,0.76,0.02),
#                         BFarea=7,correctionAlgorithm=FALSE,savePlot="screen")

## ----eval=FALSE---------------------------------------------------------------
# clu <- defineLocClusters(LocData=estimates,out.method="interactive.manual")
# #"Hit Enter to move to the next image or A + Enter to Abort:"

## ----eval=FALSE---------------------------------------------------------------
# estimates.2 <- spotEstimator(files=files,subset=clu$Outlier.indices,
#                              foregroundCut=seq(0.6,0.76,0.02),correctionAlgorithm=TRUE,
#                              cutoff=50,QCdata=clu,median.correction=TRUE,
#                              savePlot="screen")

## -----------------------------------------------------------------------------
Results <- LocationMatrix(data=estimates.2,
                          filter.by = matrix(c("FDR","Out.Index",0.005,"confidence"),ncol=2))
Results$Output[1:3,]

## -----------------------------------------------------------------------------
# step1 <-createFluo(Results) #from previous section's results
step1 <- createFluo(from.file=system.file("extdata", "Results_of_image_analysis.txt", 
                                        package = "CONFESS"),separator="_")

## -----------------------------------------------------------------------------
print(unique(step1$batch))

## ----eval=FALSE,results="hide"------------------------------------------------
# step2<-Fluo_adjustment(data=step1,transformation="log",maxMix=3,prior.pi=0.1,
#                        flex.reps = 50, single.batch.analysis=5,
#                        savePlot="screen",seed=999)

## ----fig.show="hide"----------------------------------------------------------
step2.1<-getFluo(data=step2)
step3<-Fluo_inspection(data=step2.1,fixClusters=0,altFUN="kmeans",
                       k.max=15,B.kmeans=50,savePlot="screen")

## ----fig.show="hide"----------------------------------------------------------
step3.1<-pathEstimator(step3,path.start=3,path.type=c("circular","clockwise"),
                       joinedGroups=NULL)
step4<-Fluo_modeling(data=step3.1,init.path=step3.1$Path,VSmethod="DDHFmv",
                     CPmethod="ECP",CPgroups=5,CPpvalue=0.01,CPmingroup=10)
step5<-Fluo_ordering(data=step4,savePlot="screen")

## -----------------------------------------------------------------------------
head(step5$Summary_results,3)

## ----eval=FALSE---------------------------------------------------------------
# step1.1<-FluoSelection_byRun(data=step1,batch=1)
# step2<-getFluo_byRun(data=step1.1,BGmethod="normexp",savePlot="screen")
# step3<-Fluo_inspection(data=step2,fixClusters=0,altFUN="kmeans",k.max=15,
#                        savePlot="screen")
# step3.1 <- pathEstimator(step3,path.start=2,path.type=c("circular","clockwise"))
# step4 <- Fluo_modeling(data=step3.1,init.path=step3.1$Path,VSmethod="DDHFmv",
#                        CPmethod="ECP",CPpvalue=0.01)
# step5<-Fluo_ordering(data=step4,savePlot="screen")

## ----eval=FALSE---------------------------------------------------------------
# step1 <- createFluo(from.file=system.file("extdata", "Results_of_image_analysis.txt",
#                                         package = "CONFESS"))
# steps2_4<-Fluo_CV_prep(data=step1,init.path = rep("bottom/left",2),
#                        path.type=c("circular","clockwise"),maxMix=3,
#                        single.batch.analysis = 5,transformation = "log",prior.pi = 0.1,
#                        flex.reps=5,areacut=49,fixClusters=0,altFUN="kmeans",
#                        k.max=15,VSmethod="DDHFmv",CPmethod="ECP",CPgroups=5,
#                        B.kmeans=5,CPpvalue=0.01,CPmingroup=15,savePlot="OFF",seed=999)
# steps2_4cv.1<-Fluo_CV_modeling(data=steps2_4,B=10,batch=1:4,perc.cutoff=0.6,q=0.9,
#                                f=0.99,seed.it=TRUE,pseudotime.cutoff=20,savePlot="screen")

## ----results="hide",message=FALSE,fig.show="hide"-----------------------------
steps2_4cv.2<-Fluo_CV_modeling(data=steps2_4,B=1,batch=1:4,perc.cutoff=0.6,q=0.9,
                             f=0.99,seed.it=TRUE,pseudotime.cutoff=20,savePlot="screen")

