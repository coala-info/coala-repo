# Code example from 'ptairMS' vignette. See references/ for full tutorial.

## ----set, include=FALSE-------------------------------------------------------
knitr::opts_chunk$set(fig.width=12, fig.height=8) 

## ----eval=FALSE---------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("ptairMS")

## ----package, message = FALSE, warning = FALSE--------------------------------
library(ptairMS)
library(ptairData)

## ----eval=FALSE---------------------------------------------------------------
# ptairMS::RunShinnyApp()

## ----ptairData----------------------------------------------------------------
dirRaw <- system.file("extdata/exhaledAir", package = "ptairData")

## ----createPtrSet-------------------------------------------------------------
exhaledPtrset <- createPtrSet(dir=dirRaw,
                     setName="exhaledPtrset",
                     mzCalibRef = c(21.022, 60.0525),fracMaxTIC = 0.7,
                     saveDir = NULL )

## -----------------------------------------------------------------------------
exhaledPtrset

## ----getFileNames-------------------------------------------------------------
getFileNames(exhaledPtrset)

## ----plot---------------------------------------------------------------------
plot(exhaledPtrset)

## ----calib table--------------------------------------------------------------
calib_table<-read.csv(system.file("extdata", "reference_tables/calib_table.tsv", package = "ptairMS"),sep="\t")
knitr::kable(calib_table)

## ----calibration--------------------------------------------------------------
plotCalib(exhaledPtrset,fileNames=getFileNames(exhaledPtrset)[1])

## ----plotCalib----------------------------------------------------------------
exhaledPtrset <- calibration(exhaledPtrset, mzCalibRef =  c(21.022, 60.0525,75.04406))
plot(exhaledPtrset,type="calibError")

## ----shinny app, eval=FALSE---------------------------------------------------
# exhaledPtrset <- changeTimeLimits(exhaledPtrset)

## ----timeLimits1--------------------------------------------------------------
samplePath <-getFileNames(exhaledPtrset,fullNames = TRUE)[1]
sampleRaw <- readRaw(samplePath, calib = FALSE)
expirationLimit <- timeLimits(sampleRaw,fracMaxTIC =  0.5,plotDel = TRUE, mzBreathTracer = 60.05)
expirationLimit <- timeLimits(sampleRaw,fracMaxTIC =  0.9,plotDel = TRUE,mzBreathTracer = NULL)

## ----plotTIC1-----------------------------------------------------------------
plotTIC(object = exhaledPtrset,baselineRm = TRUE,type = "ggplot")

## ----getSampleMetadata--------------------------------------------------------
getSampleMetadata(exhaledPtrset)

## ----setSampleMetadata--------------------------------------------------------
sampleMD <- getSampleMetadata(exhaledPtrset)
colnames(sampleMD)[1] <- "individual"  

exhaledPtrset <- setSampleMetadata(exhaledPtrset,sampleMD)
getSampleMetadata(exhaledPtrset)

## ----exportSampleMetada,eval=FALSE--------------------------------------------
# exportSampleMetada(exhaledPtrset, saveFile = file.path(DirBacteria,"sampleMetadata.tsv"))
# exhaledPtrset <- importSampleMetadata(exhaledPtrset, file = file.path(DirBacteria,"sampleMetadata.tsv"))

## ----plotRaw_ptrSet-----------------------------------------------------------
plotRaw(exhaledPtrset, mzRange = 59 , fileNames = getFileNames(exhaledPtrset)[1],showVocDB = TRUE)

## ----plotFeatures, message=FALSE, warning=FALSE-------------------------------
plotFeatures(exhaledPtrset,mz=59.049,type="ggplot",colorBy = "individual")

## ----update-------------------------------------------------------------------
exhaledPtrset <- updatePtrSet(exhaledPtrset)

## ----Detect_peak--------------------------------------------------------------
exhaledPtrset <- detectPeak(exhaledPtrset)

## ----getPeakList--------------------------------------------------------------
peakList<-getPeakList(exhaledPtrset)
peakList1<-peakList$`ind1-1.h5`
X<-Biobase::exprs(peakList1)
Y<-Biobase::fData(peakList1)
mz<-Y[,"Mz"]
plot(X[which.min(abs(mz-59.0498)),],ylab="cps",xlab="time",main=paste("Temporal evolution of acetone "))
head(Y)

## ----updatePtrSet,eval=FALSE--------------------------------------------------
# exhaledPtrset<-updatePtrSet(exhaledPtrset)
# exhaledPtrset<-setSampleMetadata(exhaledPtrset,resetSampleMetadata(exhaledPtrset))
# exhaledPtrset<-detectPeak(exhaledPtrset)

## ----Align patient------------------------------------------------------------
exhaledEset <- alignSamples(exhaledPtrset, group="individual", fracGroup = 1, fracExp=1/6)

## -----------------------------------------------------------------------------
knitr::kable(head(Biobase::exprs(exhaledEset)))
knitr::kable(head(Biobase::pData(exhaledEset)))
knitr::kable(head(Biobase::fData(exhaledEset)))

## ----impute-------------------------------------------------------------------
exhaledEset <- ptairMS::impute(exhaledEset,  exhaledPtrset)

## -----------------------------------------------------------------------------
annotateVOC(59.049)
exhaledEset<-annotateVOC(exhaledEset)
knitr::kable(head(Biobase::fData(exhaledEset)))

## ----eval=FALSE---------------------------------------------------------------
# writeEset(exhaledEset, dirC = file.path(getwd(), "processed_dataset"))

## ----log_transform------------------------------------------------------------
Biobase::exprs(exhaledEset) <- log2(Biobase::exprs(exhaledEset))

## ----view---------------------------------------------------------------------
ropls::view(Biobase::exprs(exhaledEset),printL=FALSE)

## ----discarding isotopes------------------------------------------------------
isotopes<-Biobase::fData(exhaledEset)[,"isotope"]
isotopes<-isotopes[!is.na(isotopes)]
exhaledEset <- exhaledEset[!(Biobase::fData(exhaledEset)[, "ion_mass"] %in% isotopes), ]

## ----pca----------------------------------------------------------------------
exhaledPca<-ropls::opls(exhaledEset,crossvalI=5,info.txtC="none",fig.pdfC="none")
ropls::plot(exhaledPca, parAsColFcVn=Biobase::pData(exhaledEset)[, "individual"],typeVc="x-score")


## -----------------------------------------------------------------------------
load1<-ropls::getLoadingMN(exhaledPca)[,1]
barplot(sort(abs(load1),decreasing = TRUE))
knitr::kable(Biobase::fData(exhaledEset)[names(sort(abs(load1),decreasing = TRUE)[1:10]),c("vocDB_ion_formula","vocDB_name_iupac")])

## ----plotFeatures individual, warning=FALSE-----------------------------------
plotFeatures(exhaledPtrset,mz = 53.0387,typePlot = "ggplot",colorBy = "individual")
plotFeatures(exhaledPtrset,mz = 67.0539,typePlot = "ggplot",colorBy = "individual")

## -----------------------------------------------------------------------------
dir <- system.file("extdata/mycobacteria",  package = "ptairData")
mycobacteriaSet <- createPtrSet(dir = dir, setName = "test", 
                         mzCalibRef = c(21.022,59.049))
mycobacteriaSet <- detectPeak(mycobacteriaSet, smoothPenalty = 0)
plotTIC(mycobacteriaSet,type="ggplot",showLimits = TRUE,file="Specie-a2.h5")
eSet <- alignSamples(mycobacteriaSet)
eSet<-impute(eSet,ptrSet = mycobacteriaSet)
X<-Biobase::exprs(eSet)
pca<-ropls::opls(log2(t(X)),predI =2,crossvalI=5,info.txtC = "none",
  fig.pdfC = "none")
ropls::view(log2(X),printL=FALSE)
plot(pca,type="x-score")

## ----readRaw------------------------------------------------------------------
dirRaw <- system.file("extdata/exhaledAir", package = "ptairData")
samplePath<-list.files(dirRaw,recursive = TRUE,full.names = TRUE,pattern = ".h5$")[1]

## -----------------------------------------------------------------------------
sampleRaw <- readRaw(samplePath, calib = FALSE)
sampleRaw

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

