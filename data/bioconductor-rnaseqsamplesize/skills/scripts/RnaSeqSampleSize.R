# Code example from 'RnaSeqSampleSize' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----prepareData,echo=T,cache=F--------------------------------------------
library(RnaSeqSampleSize)

## ----singlePower,echo=TRUE,tidy=TRUE,cache=T-------------------------------
example(est_power)

## ----singleSampleSize,each=TRUE,tidy=TRUE,cache=T--------------------------
example(sample_size)

## ----showData,echo=F,cache=F-----------------------------------------------
data(package="RnaSeqSampleSizeData")$results[,"Item"]

## ----distributionPower1,echo=TRUE,tidy=FALSE,cache=TRUE--------------------
est_power_distribution(n=65,f=0.01,rho=2,
                       distributionObject="TCGA_READ",repNumber=5)

## ----distributionPower2,echo=TRUE,tidy=FALSE,cache=TRUE--------------------
#Power estimation based on some interested genes. 
#We use storeProcess=TRUE to return the details for all selected genes.
selectedGenes<-c("A1BG","A2BP1","A2M","A4GALT","AAAS")
powerDistribution<-est_power_distribution(n=65,f=0.01,rho=2,
                        distributionObject="TCGA_READ",
                        selectedGenes=selectedGenes,
                        storeProcess=TRUE)
str(powerDistribution)
mean(powerDistribution$power)

## ----distributionPower3,echo=TRUE,tidy=FALSE,cache=T,eval=FALSE------------
# powerDistribution<-est_power_distribution(n=65,f=0.01,rho=2,
#                         distributionObject="TCGA_READ",pathway="00010",
#                         minAveCount=1,storeProcess=TRUE)
# mean(powerDistribution$power)

## ----distributionSampleSize,echo=TRUE,tidy=FALSE,cache=T-------------------
sample_size_distribution(power=0.8,f=0.01,distributionObject="TCGA_READ",
                         repNumber=5,showMessage=TRUE)

## ----generateUserData,echo=TRUE,tidy=TRUE,cache=T--------------------------
#Generate a 10000*10 RNA-seq data as prior dataset
set.seed(123)
dataMatrix<-matrix(sample(0:3000,100000,replace=TRUE),nrow=10000,ncol=10)
colnames(dataMatrix)<-c(paste0("Control",1:5),paste0("Treatment",1:5))
row.names(dataMatrix)<-paste0("gene",1:10000)
head(dataMatrix)

## ----userDataSampleSize,echo=TRUE,tidy=FALSE,cache=TRUE--------------------
#Estitamete the gene read count and dispersion distribution
dataMatrixDistribution<-est_count_dispersion(dataMatrix,
                       group=c(rep(0,5),rep(1,5)))
#Power estimation by read count and dispersion distribution
est_power_distribution(n=65,f=0.01,rho=2,
                       distributionObject=dataMatrixDistribution,repNumber=5)

## ----librarySizeAndGeneRange,echo=TRUE,tidy=FALSE,cache=TRUE,message=FALSE,eval=FALSE----
# library(recount)
# studyId="SRP009615"
# url <- download_study(studyId)
# load(file.path(studyId, 'rse_gene.Rdata'))
# 
# #show percent of mapped reads
# plot_mappedReads_percent(rse_gene)
# #show propotion of gene counts in different range
# plot_gene_counts_range(rse_gene,targetSize = 4e+07)
# 

## ----AnalyzeDataSet,echo=TRUE,tidy=FALSE,cache=TRUE,message=FALSE,eval=FALSE----
# 
# library(ExpressionAtlas)
# 
# 
# projectId="E-ENAD-46"
# allExps <- getAtlasData(projectId)
# ExpressionAtlasObj <- allExps[[ projectId ]]$rnaseq
# 
# #only keeping "g2" (COVID-19) and "g4" (normal) samples
# expObj=ExpressionAtlasObj[,which(colData(ExpressionAtlasObj)$AtlasAssayGroup %in% c("g2","g4"))]
# expObjGroups= 2-as.integer(as.factor(colData(expObj)$AtlasAssayGroup)) #0 for normal and 1 for COVID-19 samples
# #only keeping genes with at least 10 counts
# minAveCount=10
# averageCountsGene=rowSums(assay(expObj))/ncol(expObj)
# expObjFilter=expObj[which(averageCountsGene>=minAveCount),]
# 
# result=analyze_dataset(expObjFilter,expObjGroups=expObjGroups)
# 

## ----singlePowerCurves,echo=TRUE,tidy=TRUE,cache=T-------------------------
result1<-est_power_curve(n=63, f=0.01, rho=2, lambda0=5, phi0=0.5)
result2<-est_power_curve(n=63, f=0.05, rho=2, lambda0=5, phi0=0.5)
plot_power_curve(list(result1,result2))

## ----optimazation,echo=TRUE,tidy=FALSE,cache=T-----------------------------
result<-optimize_parameter(fun=est_power,opt1="n",
                           opt2="lambda0",opt1Value=c(3,5,10,15,20),
                           opt2Value=c(1:5,10,20))

