# Code example from 'SVM2CRM' vignette. See references/ for full tutorial.

### R code from vignette source 'SVM2CRM.Rnw'

###################################################
### code chunk number 1: SVM2CRM.Rnw:29-36
###################################################
library(SVM2CRM)
library(SVM2CRMdata)
library(GenomicRanges)
library(rtracklayer)
library(zoo)
library(squash)
library(pls)


###################################################
### code chunk number 2: SVM2CRM.Rnw:39-50
###################################################
setwd(system.file("extdata", package = "SVM2CRMdata"))
chr<-"chr1"
bin.size<-100
windows<-1000
smoothing<-"FALSE"
function.smoothing<-"median"
list_file<-grep(dir(),pattern=".bz2",value=TRUE)

#completeTABLE_example<-cisREfindbed(list_file=list_file[1],chr=chr,bin.size=bin.size,windows=windows,window.smooth=window.smooth,smoothing="FALSE",function.smoothing="median")

#str(completeTABLE_example)


###################################################
### code chunk number 3: SVM2CRM.Rnw:56-77
###################################################
setwd(system.file("data",package="SVM2CRMdata"))
load("CD4_matrixInputSVMbin100window1000.rda")
completeTABLE<-CD4_matrixInputSVMbin100window1000

new.strings<-gsub(x=colnames(completeTABLE[,c(6:ncol(completeTABLE))]),pattern="CD4.",replacement="")
new.strings<-gsub(new.strings,pattern=".norm.w100.bed",replacement="")
colnames(completeTABLE)[c(6:ncol(completeTABLE))]<-new.strings

#list_file<-grep(dir(),pattern=".sort.txt",value=T)

setwd(system.file("data",package="SVM2CRMdata"))

load("train_positive.rda")
load("train_negative.rda")

#train_positive<-getSignal(list_file,chr="chr1",reference="p300.distal.fromTSS.txt",win.size=500,bin.size=100,label1="enhancers")
#train_negative<-getSignal(list_file,chr="chr1",reference="random.region.hg18.nop300.txt",win.size=500,bin.size=100,label1="not_enhancers")
#training_set<-rbind(train_positive,train_negative)

training_set<-rbind(train_positive,train_negative)
colnames(training_set)[c(5:ncol(training_set))]<-gsub(x=gsub(x=colnames(training_set[,c(5:ncol(training_set))]),pattern="sort.txt.",replacement=""),pattern="CD4.",replacement="")


###################################################
### code chunk number 4: SVM2CRM.Rnw:83-97
###################################################
setwd(system.file("extdata", package = "SVM2CRMdata"))
data_level2 <- read.table(file = "GSM393946.distal.p300fromTSS.txt",sep = "\t", stringsAsFactors = FALSE)
data_level2<-data_level2[data_level2[,1]=="chr1",]

DB <- data_level2[, c(1:3)]
colnames(DB)<-c("chromosome","start","end")

label <- "p300"

table.final.overlap<-findFeatureOverlap(query=completeTABLE,subject=DB,select="all")

data_enhancer_svm<-createSVMinput(inputpos=table.final.overlap,inputfull=completeTABLE,label1="enhancers",label2="not_enhancers")
colnames(data_enhancer_svm)[c(5:ncol(data_enhancer_svm))]<-gsub(gsub(x=colnames(data_enhancer_svm[,c(5:ncol(data_enhancer_svm))]),pattern="CD4.",replacement=""),pattern=".norm.w100.bed",replacement="")



###################################################
### code chunk number 5: SVM2CRM.Rnw:103-104
###################################################
listcolnames<-c("H2AK5ac","H2AK9ac","H3K23ac","H3K27ac","H3K4me1","H3K4me2","H3K4me3")


###################################################
### code chunk number 6: SVM2CRM.Rnw:108-109
###################################################
dftotann<-smoothInputFS(train_positive[,c(6:ncol(train_positive))],listcolnames,k=20)


###################################################
### code chunk number 7: SVM2CRM.Rnw:113-114
###################################################
results<-featSelectionWithKmeans(dftotann,5)


###################################################
### code chunk number 8: SVM2CRM.Rnw:118-119
###################################################
    resultsFS<-results[[7]]


###################################################
### code chunk number 9: SVM2CRM.Rnw:123-124
###################################################
resultsFSfilterICRR<-resultsFS[which(resultsFS[,3]<0.26),]


###################################################
### code chunk number 10: SVM2CRM.Rnw:128-130
###################################################
listHM<-resultsFSfilterICRR[,1]
listHM<-gsub(gsub(listHM,pattern="_.",replacement=""),pattern="CD4.",replacement="")


###################################################
### code chunk number 11: SVM2CRM.Rnw:134-139
###################################################
selectFeature<-grep(x=colnames(training_set[,c(6:ncol(training_set))]),pattern=paste(listHM,collapse="|"),value=TRUE)

colSelect<-c("chromosome","start","end","label",selectFeature)
training_set<-training_set[,colSelect]



###################################################
### code chunk number 12: SVM2CRM.Rnw:146-151
###################################################
vecS <- c(2:length(listHM))
typeSVM <- c(0, 6, 7)[1]
costV <- c(0.001, 0.01, 0.1, 1, 10, 100, 1000)[6]
infofile<-data.frame(a=c(paste(listHM,"signal",sep=".")))
infofile[,1]<-gsub(gsub(x=infofile[,1],pattern="CD4.",replacement=""),pattern=".sort.bed",replacement="")


###################################################
### code chunk number 13: SVM2CRM.Rnw:155-156
###################################################
tuningTAB <- tuningParametersCombROC(training_set = training_set, typeSVM = typeSVM, costV = costV,different.weight="TRUE", vecS = vecS[1],pcClass=100,ncClass=400,infofile)


###################################################
### code chunk number 14: SVM2CRM.Rnw:162-165
###################################################
tuningTABfilter<-tuningTAB[(tuningTAB$fscore<0.95),]
row_max_fscore<-which.max(tuningTABfilter[,"fscore"])
listHM_prediction<-gsub(tuningTABfilter[row_max_fscore,4],pattern="//",replacement="|")


###################################################
### code chunk number 15: SVM2CRM.Rnw:171-174
###################################################
columnPR<-grep(colnames(training_set),pattern=paste(listHM_prediction,collapse="|"),value=TRUE)

predictionGW(training_set=training_set,data_enhancer_svm=data_enhancer_svm, listHM=columnPR,pcClass.string="enhancers",nClass.string="not_enhancers",pcClass=100,ncClas=400,cost=100,type=0,"prediction_enhancers_CD4_results_cost=100_type=0")


###################################################
### code chunk number 16: SVM2CRM.Rnw:187-188
###################################################
sessionInfo()


