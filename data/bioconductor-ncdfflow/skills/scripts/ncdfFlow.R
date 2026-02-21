# Code example from 'ncdfFlow' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(
concordance=TRUE
)

## ----loadPackage, echo=FALSE,results='hide'-----------------------------------
library(ncdfFlow)

## ----read.ncdfFlowSet, echo=TRUE, results='markup'----------------------------
path<-system.file("extdata","compdata","data",package="flowCore")
files<-list.files(path,full.names=TRUE)[1:3]
nc1 <- read.ncdfFlowSet(files=files)
nc1

## ----flowSet, echo=TRUE, results='hide'---------------------------------------
fs1  <- read.flowSet(files=files)

## ----unlink, echo=TRUE, results='markup'--------------------------------------
unlink(nc1)
rm(nc1)

## ----isWriteSlice, echo=TRUE,results='markup'---------------------------------
nc1  <- read.ncdfFlowSet(files=files, isWriteSlice= FALSE)
nc1[[1]]

## ----replacement, echo=TRUE,results='markup'----------------------------------
targetSampleName<-sampleNames(fs1)[1]
nc1[[targetSampleName]] <- fs1[[1]]
nc1[[1]]
nc1[[2]]

## ----isEmpty, echo=TRUE,results='hide'----------------------------------------
nc2 <- clone.ncdfFlowSet(nc1, isEmpty = TRUE)
nc2[[1]]
nc2[[sampleNames(fs1)[1]]] <- fs1[[1]]
nc2[[1]]

## ----cleanup, echo=FALSE,results='hide'---------------------------------------
unlink(nc2)
rm(nc2)

unlink(nc1)
rm(nc1)

## ----fstoncdfFlowSet, echo=TRUE,results='markup'------------------------------
data(GvHD)
GvHD <- GvHD[pData(GvHD)$Patient %in% 6:7][1:4]
nc1<-ncdfFlowSet(GvHD)

## ----ncdfFlowSettofs, echo=TRUE,results='markup'------------------------------
fs1<-as.flowSet(nc1,top=2)

## ----metaData, echo=TRUE, results='hide'--------------------------------------
phenoData(nc1)
pData(nc1)
varLabels(nc1)
varMetadata(nc1)
sampleNames(nc1)
keyword(nc1,"FILENAME")
identifier(nc1)
colnames(nc1)
colnames(nc1,prefix="s6a01")
length(nc1)
getIndices(nc1,"s6a01")

## ----extraction, echo=TRUE,results='markup'-----------------------------------

nm<-sampleNames(nc1)[1]
expr1<-paste("nc1$'",nm,"'",sep="")
eval(parse(text=expr1))
nc1[[nm]]

nm<-sampleNames(nc1)[c(1,3)]
nc2<-nc1[nm]
summary(nc2)

## ----fsApply, echo=TRUE,results='hide'----------------------------------------
fsApply(nc1,range)
fsApply(nc1, each_col, median)

## ----Transformation and compensation, echo=TRUE,results='hide'----------------
cfile <- system.file("extdata","compdata","compmatrix", package="flowCore")
comp.mat <- read.table(cfile, header=TRUE, skip=2, check.names = FALSE)
comp <- compensation(comp.mat)

#compensation
summary(nc1)[[1]]
nc2<-compensate(nc1, comp)
summary(nc2)[[1]]
unlink(nc2)
rm(nc2)

#transformation
asinhTrans <- arcsinhTransform(transformationId="ln-transformation", a=1, b=1, c=1)
nc2 <- transform(nc1,`FL1-H`=asinhTrans(`FL1-H`))
summary(nc1)[[1]]
summary(nc2)[[1]]
unlink(nc2)
rm(nc2)

## ----Gating, echo=TRUE,results='hide'-----------------------------------------
rectGate <- rectangleGate(filterId="nonDebris","FSC-H"=c(200,Inf))
fr <- filter(nc1,rectGate)
summary(fr)

rg2 <- rectangleGate(filterId="nonDebris","FSC-H"=c(300,Inf))
rg3 <- rectangleGate(filterId="nonDebris","FSC-H"=c(400,Inf))
flist <- list(rectGate, rg2, rg3)
names(flist) <- sampleNames(nc1[1:3])
fr3 <- filter(nc1[1:3], flist)
summary(fr3[[3]])

## ----Subsetting, echo=TRUE, results='markup'----------------------------------
nc2 <- Subset(nc1,rectGate)
summary(nc2[[1]])

## ----Subsetting2, echo=FALSE, eval=FALSE--------------------------------------
# nc2 <- Subset(nc1, fr)
# summary(nc2[[1]])###this will cause crashing error see #50
# rm(nc2)

## ----Subsetting3, echo=TRUE, results='markup'---------------------------------
library(flowStats)
morphGate <- norm2Filter("FSC-H", "SSC-H", filterId = "MorphologyGate",scale = 2)
smaller <- Subset(nc1[c(1,3)], morphGate,c("FSC-H", "SSC-H"))
smaller[[1]]
nc1[[1]]
rm(smaller)

## ----split, echo=TRUE---------------------------------------------------------

##splitting by a gate
qGate <- quadGate(filterId="qg", "FSC-H"=200, "SSC-H"=400)
fr<-filter(nc1,qGate)
ncList<-split(nc1,fr)
ncList
nc1[[1]]
ncList[[2]][[1]]
ncList[[1]][[1]]

## ----split2, echo=FALSE, eval=FALSE-------------------------------------------
# ncList_new<-split(nc1,fr,isNew=TRUE)###this will cause crashing error see #50

