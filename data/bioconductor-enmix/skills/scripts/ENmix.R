# Code example from 'ENmix' vignette. See references/ for full tutorial.

## ----pipeline, eval=FALSE-----------------------------------------------------
# rgSet <- readidat(datapath)
# beta=mpreprocess(rgSet)

## ----example1, eval=FALSE-----------------------------------------------------
# library(ENmix)
# #read in data
# require(minfiData)
# #read in IDAT files
# path <- file.path(find.package("minfiData"),"extdata")
# rgSet <- readidat(path = path,recursive = TRUE)
# #data pre-processing
# beta=mpreprocess(rgSet,nCores=6)
# #quality control, data pre-processing and imputation
# beta=mpreprocess(rgSet,nCores=6,qc=TRUE,fqcfilter=TRUE,
#      rmcr=TRUE,impute=TRUE)
# 
# #CpG information (from Illumina manifest file) is self-contained in rgDataSet or methDataSet
# cginfo=getCGinfo(rgSet)
# #It has the same infomation if extracted from methDataSet
# meth=getmeth(rgSet)
# cginfo1=rowData(meth)
# #Probe information for internal controls
# ictrl=getCGinfo(rgSet,type="ctrl")

## ----example2, eval=FALSE-----------------------------------------------------
# library(ENmix)
# #read in data
# path <- file.path(find.package("minfiData"),"extdata")
# rgSet <- readidat(path = path,recursive = TRUE)
# #QC info
# qc<-QCinfo(rgSet)
# #background correction and dye bias correction
# #if qc info object is provided, the low quality or outlier samples
# # and probes will be excluded before background correction
# mdat<-preprocessENmix(rgSet, bgParaEst="oob", dyeCorr="RELIC",
#                      QCinfo=qc, nCores=6)
# #between-array normalization
# mdat<-norm.quantile(mdat, method="quantile1")
# #probe-type bias adjustment
# beta<-rcp(mdat,qcscore=qc)
# #set low quality and outlier data points as NA (missing value)
# #remove samples and probes with too many (eg. >5%) missing data
# #perform imputation to replace missing values
# beta <- qcfilter(beta,qcscore=qc,rmcr=TRUE,impute=TRUE)
# #remove suffix and combine duplicated CpGs with rm.cgsuffix(), for EPIC v2
# #beta2=rm.cgsuffix(beta)

## ----example3, eval=FALSE-----------------------------------------------------
# library(ENmix)
# #read in data
# path <- file.path(find.package("minfiData"),"extdata")
# rgSet <- readidat(path = path,recursive = TRUE)
# 
# #attach some phenotype info for later use
# sheet <- read.metharray.sheet(file.path(find.package("minfiData"),
#          "extdata"),pattern = "csv$")
# rownames(sheet)=paste(sheet$Slide,sheet$Array,sep="_")
# colData(rgSet)=as(sheet[colnames(rgSet),],"DataFrame")
# 
# #generate internal control plots to inspect quality of experiments
# plotCtrl(rgSet)
# 
# #generate quality control (QC) information and plots,
# #identify outlier samples in data distribution
# #if set detPtype="negative", recommend to set depPthre to <= 10E-6
# #if set detPtype="oob", depPthre of 0.01 or 0.05 may be sufficient
# #see Heiss et al. PMID: 30678737 for details
# qc<-QCinfo(rgSet,detPtype="negative",detPthre=0.000001)
# 
# ###data preprocessing
# #background correction and dye bias correction
# mdat<-preprocessENmix(rgSet, bgParaEst="oob", dyeCorr="RELIC",
#                       QCinfo=qc, nCores=6)
# #between-array normalization
# mdat<-norm.quantile(mdat, method="quantile1")
# #attach phenotype data for later use
# colData(mdat)=as(sheet[colnames(mdat),],"DataFrame")
# #probe-type bias adjustment
# beta<-rcp(mdat,qcscore=qc)
# 
# #Search for multimodal CpGs, so called gap probes
# #beta matrix before qcfilter() step should be used for this purpose
# nmode<-nmode(beta, minN = 3, modedist=0.2, nCores = 6)
# 
# #filter low quality and outlier data points for each probe
# #rows and columns with too many missing values will be removed if specify
# #Imputation will be performed to fill missing data if specify.
# beta <- qcfilter(beta,qcscore=qc,rmcr=TRUE, rthre=0.05,
#                    cthre=0.05,impute=TRUE)
# 
# #If for epigenetic mutation analysis, outliers should be kept
# beta <- qcfilter(beta,qcscore=qc,rmoutlier=FALSE,rmcr=TRUE, rthre=0.05,
#                    cthre=0.05,impute=FALSE)
# 
# #remove suffix and combine duplicated CpGs with rm.cgsuffix(), for EPIC v2
# #beta2=rm.cgsuffix(beta)
# 
# ##Principal component regression analysis plot to check data variance structure
# #phenotypes to be studied in the plot
# cov<-data.frame(group=colData(mdat)$Sample_Group,
#     slide=factor(colData(mdat)$Slide))
# #missing data is not allowed in the analysis!
# pcrplot(beta, cov, npc=6)
# 
# #Non-negative control surrogate variables, which can be used in
# # downstream association analysis to control for batch effects.
# csva<-ctrlsva(rgSet)
# 
# #estimate cell type proportions
# #rgDataset or methDataSet can also be used for the estimation
# celltype=estimateCellProp(userdata=beta,
#          refdata="FlowSorted.Blood.450k",
#          nonnegative = TRUE,normalize=TRUE)
# 
# #predic sex based on rgDataSet or methDataset
# sex=predSex(rgSet)
# sex=predSex(mdat)
# 
# #Methylation predictors (>150), including methylation age calculation
# pheno=data.frame(SampleID=colnames(beta),Age=c(23,45,52,36,58,43),Female=c(1,0,1,1,0,1))
# mscore=methscore(datMeth=beta,datPheno=pheno)
# 
# #ICC analysis can be performed to study measurement reliability if
# # have duplicates, see manual
# #dupicc()
# 
# #After association analysis, the P values can be used for DMR analysis
# #simulate a small example file in BED format
# dat=simubed()
# #using ipdmr method, low seed value (0.01 or 0.05) should be used in real study.
# ipdmr(data=dat,seed=0.1)
# #using comb-p method
# combp(data=dat,seed=0.1)

## ----readdata, eval=FALSE-----------------------------------------------------
# library(ENmix)
# rgSet <- readidat(path = "directory path for idat files",
#                  recursive = TRUE)
# 
# #Download manifestfile for HumanMethylation450 beadchip
# system("wget https://webdata.illumina.com/downloads/productfiles/humanmethylation450/humanmethylation450_15017482_v1-2.csv")
# mf="HumanMethylation450_15017482_v1-2.csv"
# rgSet <- readidat(path = "path to idat files",manifestfile=mf,recursive = TRUE)

## ----readdata2, eval=FALSE----------------------------------------------------
# M<-matrix_for_methylated_intensity
# U<-matrix_for_unmethylated_intensity
# pheno<-as.data.frame(cbind(colnames(M), colnames(M)))
# names(pheno)<-c("Basename","filenames")
# rownames(pheno)<-pheno$Basename
# pheno<-AnnotatedDataFrame(data=pheno)
# anno<-c("IlluminaHumanMethylation450k", "ilmn12.hg19")
# names(anno)<-c("array", "annotation")
# mdat<-MethylSet(Meth = M, Unmeth = U, annotation=anno,
# phenoData=pheno)

## ----ctrlplot, eval=FALSE-----------------------------------------------------
# plotCtrl(rgSet)

## ----ctrlplot2, eval=FALSE----------------------------------------------------
# 
# path <- file.path(find.package("minfiData"),"extdata")
# rgSet <- readidat(path = path,recursive = TRUE)
# sheet <- read.metharray.sheet(file.path(find.package("minfiData"),
#          "extdata"), pattern = "csv$")
# rownames(sheet)=paste(sheet$Slide,sheet$Array,sep="_")
# colData(rgSet)=as(sheet[colnames(rgSet),],"DataFrame")
# #control plots
# IDorder=rownames(colData(rgSet))[order(colData(rgSet)$Slide,
#         colData(rgSet)$Array)]
# plotCtrl(rgSet,IDorder)

## ----distplot, eval=FALSE-----------------------------------------------------
# 
# mraw <- getmeth(rgSet)
# #total intensity plot is userful for data quality inspection
# #and identification of outlier samples
# multifreqpoly(assays(mraw)$Meth+assays(mraw)$Unmeth,
#              xlab="Total intensity")
# #Compare frequency polygon plot and density plot
# beta<-getB(mraw)
# anno=rowData(mraw)
# beta1=beta[anno$Infinium_Design_Type=="I",]
# beta2=beta[anno$Infinium_Design_Type=="II",]
# library(geneplotter)
# jpeg("dist.jpg",height=900,width=600)
# par(mfrow=c(3,2))
# multidensity(beta,main="Multidensity")
# multifreqpoly(beta,main="Multifreqpoly",xlab="Beta value")
# multidensity(beta1,main="Multidensity: Infinium I")
# multifreqpoly(beta1,main="Multifreqpoly: Infinium I",
# xlab="Beta value")
# multidensity(beta2,main="Multidensity: Infinium II")
# multifreqpoly(beta2,main="Multifreqpoly: Infinium II",
# xlab="Beta value")
# dev.off()

## ----filter, eval=FALSE-------------------------------------------------------
# qc<-QCinfo(rgSet)
# #QCinfo returns "detP","nbead","bisul","badsample","badCpG","outlier_sample"
# #Samples with low quality data
# qc$badsample
# #CpGs with low quality data
# qc$badCpG
# #outlier samples
# qc$outlier_sample
# 
# #Low quality samples and probes should be excluded before data preprocesssing
# #by specifying `QCinfo` in `preprocessENmix()`
# mdat<-preprocessENmix(rgSet, QCinfo=qc, nCores=6)

## ----rmoutlier, eval=FALSE----------------------------------------------------
# #filter outlier values only
# b1=qcfilter(beta)
# #filter low quality and outlier values
# b2=qcfilter(beta,qcscore=qc)
# #filter low quality and outlier values, remove rows
# #and columns with too many missing values
# b3=qcfilter(beta,qcscore=qc,rmcr=TRUE)
# #filter low quality and outlier values, remove rows and
# #columns with too many (rthre=0.05,cthre=0.05, 5% in default) missing values,
# # and then do imputation
# b3=qcfilter(beta,qcscore=qc,rmcr=TRUE,rthre=0.05,
#               cthre=0.05,impute=TRUE)

## ----preprocessENmix, eval=FALSE----------------------------------------------
# qc=QCinfo(rgSet)
# mdat<-preprocessENmix(rgSet, bgParaEst="oob", dyeCorr="RELIC",
# QCinfo=qc, exCpG=NULL, nCores=6)

## ----normalize.quantile, eval=FALSE-------------------------------------------
# mdat<-norm.quantile(mdat, method="quantile1")

## ----rcp, eval=FALSE----------------------------------------------------------
# beta<-rcp(mdat)

## ----ctrlsva, eval=FALSE------------------------------------------------------
# sva<-ctrlsva(rgSet)

## ----pcrplot, eval=FALSE------------------------------------------------------
# require(minfiData)
# mdat <- preprocessRaw(RGsetEx)
# beta=getBeta(mdat, "Illumina")
# group=pData(mdat)$Sample_Group
# slide=factor(pData(mdat)$Slide)
# cov=data.frame(group,slide)
# pcrplot(beta,cov,npc=6)

## ----nmode, eval=FALSE--------------------------------------------------------
# nmode<- nmode(beta, minN = 3, modedist=0.2, nCores = 5)

## ----celltype, eval=FALSE-----------------------------------------------------
# require(minfidata)
# path <- file.path(find.package("minfiData"),"extdata")
# #based on rgDataset
# rgSet <- readidat(path = path,recursive = TRUE)
# celltype=estimateCellProp(userdata=rgSet,
#          refdata="FlowSorted.Blood.450k",
#          nonnegative = TRUE,normalize=TRUE)

## ----mage, eval=FALSE---------------------------------------------------------
# require(minfidata)
# path <- file.path(find.package("minfiData"),"extdata")
# #based on rgDataset
# rgSet <- readidat(path = path,recursive = TRUE)
# meth=getmeth(rgSet)
# beta=getB(meth)
# mage=methyAge(beta)
# 
# pheno=data.frame(SampleID=colnames(beta),Age=c(23,45,52,36,58,43),Female=c(1,0,1,1,0,1))
# mscore=methscore(datMeth=beta,datPheno=pheno)

## ----dmr, eval=FALSE----------------------------------------------------------
# dat=simubed()
# names(dat)
# ipdmr(data=dat,seed=0.1)
# combp(data=dat,seed=0.1)

## ----icc, eval=FALSE----------------------------------------------------------
# require(minfiData)
# path <- file.path(find.package("minfiData"),"extdata")
# rgSet <- readidat(path = path,recursive = TRUE)
# mdat=getmeth(rgSet)
# beta=getB(mdat,"Illumina")
# #assuming list in id1 are corresponding duplicates of id2
# dupidx=data.frame(id1=c("5723646052_R02C02","5723646052_R04C01",
#                        "5723646052_R05C02"),
#                   id2=c("5723646053_R04C02","5723646053_R05C02",
#                        "5723646053_R06C02"))
# iccresu<-dupicc(dat=beta,dupid=dupidx)

## ----oxbs, eval=FALSE---------------------------------------------------------
# load(system.file("oxBS.MLE.RData",package="ENmix"))
# resu<-oxBS.MLE(beta.BS,beta.oxBS,N.BS,N.oxBS)
# dim(resu[["5mC"]])
# dim(resu[["5hmC"]])

## ----ENmixAndminfi, eval=FALSE------------------------------------------------
# library(ENmix)
# #minfi functions to read in data
# sheet <- read.metharray.sheet(file.path(find.package("minfiData"),
#  "extdata"), pattern = "csv$")
# rgSet <- read.metharray.exp(targets = sheet, extended = TRUE)
# #ENmix function for control plot
# plotCtrl(rgSet)
# #minfi functions to extract methylation and annotation data
# mraw <- preprocessRaw(rgSet)
# beta<-getB(mraw, "Illumina")
# anno=getAnnotation(rgSet)
# #ENmix function for fast and accurate distribution plot
# multifreqpoly(beta,main="Data distribution")
# multifreqpoly(beta[anno$Type=="I",],main="Data distribution, type I")
# multifreqpoly(beta[anno$Type=="II",],main="Data distribution, type II")
# #ENmix background correction
# mset<-preprocessENmix(rgSet, bgParaEst="oob", dyeCorr="RELIC", nCores=6)
# #minfi functions for further preprocessing and analysis
# gmSet <- preprocessQuantile(mset)
# bumps <- bumphunter(gmSet, design = model.matrix(~ gmSet$status), B = 0,
# type = "Beta", cutoff = 0.25)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

