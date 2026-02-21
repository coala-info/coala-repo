# Code example from 'clippda' vignette. See references/ for full tutorial.

### R code from vignette source 'clippda.Rnw'

###################################################
### code chunk number 1: loadPacks
###################################################
library(clippda)


###################################################
### code chunk number 2: setWidth
###################################################
options(width=60)


###################################################
### code chunk number 3: liverdata
###################################################
data(liverdata)
data(liverRawData)
data(liver_pheno)
liverdata[1:4,]
liverRawData[1:4,]


###################################################
### code chunk number 4: decription1
###################################################
names(liverdata)
dim(liverdata)


###################################################
### code chunk number 5: checkNo.replicates
###################################################
no.peaks <- 53
no.replicates <- 2
checkNo.replicates(liverRawData,no.peaks,no.replicates) 


###################################################
### code chunk number 6: preProcRepeatedPeakData
###################################################
threshold <- 0.80 
Data <- preProcRepeatedPeakData(liverRawData, no.peaks, no.replicates, threshold)


###################################################
### code chunk number 7: difference
###################################################
setdiff(unique(liverRawData$SampleTag),unique(liverdata$SampleTag))
setdiff(unique(Data$SampleTag),unique(liverdata$SampleTag))


###################################################
### code chunk number 8: spectrumFilter
###################################################
TAGS <- spectrumFilter(Data,threshold,no.peaks)$SampleTag
NewRawData2 <- Data[Data$SampleTag %in% TAGS,]
dim(Data)
dim(liverdata)
dim(NewRawData2)


###################################################
### code chunk number 9: no.replicates
###################################################
length(liverRawData[liverRawData$SampleTag == 25,]$Intensity)/no.peaks
length(liverRawData[liverRawData$SampleTag == 40,]$Intensity)/no.peaks


###################################################
### code chunk number 10: coherencepeaks
###################################################
Mat1 <- matrix(liverRawData[liverRawData$SampleTag == 25,]$Intensity,53,3)
Mat2 <-matrix(liverRawData[liverRawData$SampleTag == 40,]$Intensity,53,4)
cor(log2(Mat1))
cor(log2(Mat2))


###################################################
### code chunk number 11: coherencepeaks
###################################################
Mat1 <- matrix(liverRawData[liverRawData$SampleTag == 25,]$Intensity,53,3)
Mat2 <-matrix(liverRawData[liverRawData$SampleTag == 40,]$Intensity,53,4)
sort(mostSimilarTwo(cor(log2(Mat1))))
sort(mostSimilarTwo(cor(log2(Mat2))))


###################################################
### code chunk number 12: confirmpreprocessing
###################################################
names(NewRawData2)
dim(NewRawData2)
names(liverdata)
dim(liverdata)
setdiff(NewRawData2$SampleTag,liverdata$SampleTag)
setdiff(liverdata$SampleTag,NewRawData2$SampleTag)
summary(NewRawData2$Intensity)
summary(liverdata$Intensity)


###################################################
### code chunk number 13: sampleClusteredData
###################################################
JUNK_DATA <- sampleClusteredData(NewRawData2,no.peaks)
head(JUNK_DATA)[,1:5] 


###################################################
### code chunk number 14: column1
###################################################
as.vector(t(matrix(liverdata[liverdata$SampleTag %in% 156,]$Intensity,53,2))[,1:5])
length(as.vector(t(matrix(liverdata[liverdata$SampleTag %in% 156,]$Intensity,53,2))))

as.vector(t(matrix(NewRawData2[NewRawData2$SampleTag %in% 156,]$Intensity,53,2))[,1:5])
length(as.vector(t(matrix(NewRawData2[NewRawData2$SampleTag %in% 156,]$Intensity,53,2))))


###################################################
### code chunk number 15: createClassObject
###################################################
OBJECT=new("aclinicalProteomicsData")

OBJECT@rawSELDIdata=as.matrix(NewRawData2) #OBJECT@rawSELDIdata=as.matrix(liverdata)

OBJECT@covariates=c("tumor" ,    "sex")

OBJECT@phenotypicData=as.matrix(liver_pheno)

OBJECT@variableClass=c('numeric','factor','factor')

OBJECT@no.peaks=no.peaks

OBJECT



###################################################
### code chunk number 16: ExtractComponetsOfeSet
###################################################
head(proteomicsExprsData(OBJECT))

head(proteomicspData(OBJECT))


###################################################
### code chunk number 17: Zplots_1
###################################################
probs=seq(0,1,0.01) # provide hypothetical proportions of cases vs controls

ZvaluescasesVcontrolsPlots(probs)


###################################################
### code chunk number 18: Zplots_2
###################################################
nsim=10000;nobs=300;proposeddesign=c(1,2,1,7);balanceddesign=c(1,1,1,1)
ZvaluesfrommultinomPlots(nsim, nobs, proposeddesign, balanceddesign)



###################################################
### code chunk number 19: biologicalParameters
###################################################
intraclasscorr  <-  0.60 
signifcut <- 0.05  
Data=OBJECT

sampleSizeParameters(Data, intraclasscorr, signifcut)

Z <- as.vector(fisherInformation(Data)[2,2])/2
Z 
sampleSize(Data, intraclasscorr, signifcut)


###################################################
### code chunk number 20: contourplot
###################################################
m <- 2
DIFF <- seq(0.1,0.50,0.01) 
VAR <- seq(0.2,4,0.1)
beta <- c(0.90,0.80,0.70)
alpha <-  1 - c(0.001, 0.01,0.05)/2
Corr <- c(0.70,0.90) 
Z <- 2.4   
Indicator <- 1 
observedPara <- c(1,0.4) #the variance you computed from pilot data
#observedPara <- data.frame(var=c(0.7,0.5,1.5),diFF=c(0.37,0.33,0.43))
sampleSizeContourPlots(Z,m,DIFF,VAR,beta,alpha,observedPara,Indicator)


###################################################
### code chunk number 21: contourplot
###################################################
observedVAR=1 
observedDIFF=0.4 


###################################################
### code chunk number 22: scatterplot
###################################################
Z <- 2.460018
m <- 2
DIFF <- seq(0.1,0.50,0.01) 
VAR <- seq(0.2,4,0.1)
beta <- c(0.90,0.80,0.70)
alpha  <-  1 - c(0.001, 0.01,0.05)/2
observedDIFF  <-  0.4
observedVAR  <-  1.0
observedSampleSize  <-  80
Indicator  <-  1 
Angle  <-  60    
sampleSize3DscatterPlots(Z,m,DIFF,VAR,beta,alpha,observedDIFF,observedVAR,observedSampleSize,Angle,Indicator)


