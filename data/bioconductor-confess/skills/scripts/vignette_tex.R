# Code example from 'vignette_tex' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----loading-confess,warning=FALSE,message=FALSE---------------------------
library(CONFESS)

## ----readfiles-------------------------------------------------------------
data_path<-system.file("extdata",package="CONFESSdata")
files<-readFiles(iDirectory=NULL,
                  BFdirectory=paste(data_path,"/BF",sep=""),
                  CHdirectory=paste(data_path,"/CH",sep=""),
                  separator = "_",image.type = c("BF","Green","Red"),
                  bits=2^16)

## ----spotestimator,eval=FALSE----------------------------------------------
# estimates <- spotEstimator(files=files,foregroundCut=seq(0.6,0.76,0.02),
#                         BFarea=7,correctionAlgorithm=FALSE,savePlot="screen")

## ----dlc,eval=FALSE--------------------------------------------------------
# clu <- defineLocClusters(LocData=estimates,out.method="interactive.manual")
# #"Hit Enter to move to the next image or A + Enter to Abort:"

## ----spotestimator2,eval=FALSE---------------------------------------------
# estimates.2 <- spotEstimator(files=files,subset=clu$Outlier.indices,foregroundCut=seq(0.6,0.76,0.02),
#                              correctionAlgorithm=TRUE,QCdata=clu,savePlot="screen")

## ----locationmatrix--------------------------------------------------------
Results <- LocationMatrix(data=estimates.2,
                          filter.by = matrix(c("FDR","Out.Index",0.005,"confidence"),ncol=2))
Results$Output[1:3,]

## ----createfluo------------------------------------------------------------
step1 <- createFluo(from.file=system.file("extdata", "Results_of_image_analysis.txt", 
                                        package = "CONFESS"),separator="_")

## ----checkbatch------------------------------------------------------------
print(unique(step1$batch))

## ----fluo_adjustment,eval=FALSE--------------------------------------------
# step2<-Fluo_adjustment(data=step1,transformation="log",maxMix=3,prior.pi=0.1,
#                        flex.reps = 50, single.batch.analysis=5,
#                        savePlot="screen",seed=999)

## ----gf,fig.show="hide",fig.keep="none"------------------------------------
step2.1<-getFluo(data=step2)
step3 <- Fluo_inspection(data=step2.1,altFUN="kmeans",B.kmeans=5,savePlot="screen")

## ----step345,fig.show="hide",fig.keep="none"-------------------------------
step3.1<-pathEstimator(step3,path.start=3,path.type=c("circular","clockwise"))
step4<-Fluo_modeling(data=step3.1,init.path=step3.1$Path,VSmethod="DDHFmv",
                     CPmethod="ECP",CPgroups=5,CPpvalue=0.01,CPmingroup=10)
step5<-Fluo_ordering(data=step4,savePlot="screen")

## ----summout---------------------------------------------------------------
head(step5$Summary_results,3)

## ----singlebatch,eval=FALSE------------------------------------------------
# step1.1<-FluoSelection_byRun(data=step1,batch=1)
# step2<-getFluo_byRun(data=step1.1,BGmethod="normexp",savePlot="screen")
# step3<-Fluo_inspection(data=step2,fixClusters=0,altFUN="kmeans",k.max=15,
#                        savePlot="screen")
# step3.1 <- pathEstimator(step3,path.start=2,path.type=c("circular","clockwise"))
# step4 <- Fluo_modeling(data=step3.1,init.path=step3.1$Path,VSmethod="DDHFmv",
#                        CPmethod="ECP",CPpvalue=0.01)
# step5<-Fluo_ordering(data=step4,savePlot="screen")

## ----cv1,eval=FALSE--------------------------------------------------------
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

## ----cv2,fig.show="hide",message=FALSE,results="hide"----------------------
steps2_4cv.2<-Fluo_CV_modeling(data=steps2_4,B=1,batch=1:4,perc.cutoff=0.6,q=0.9,
                             f=0.99,seed.it=TRUE,pseudotime.cutoff=20,savePlot="screen")


