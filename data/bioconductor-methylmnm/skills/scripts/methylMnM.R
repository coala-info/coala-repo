# Code example from 'methylMnM' vignette. See references/ for full tutorial.

### R code from vignette source 'methylMnM.Rnw'

###################################################
### code chunk number 1: methylMnM.Rnw:63-69 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("edgeR")
## BiocManager::install("statmod")
## library(edgeR)
## library(statmod)


###################################################
### code chunk number 2: methylMnM.Rnw:75-78 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("methylMnM")


###################################################
### code chunk number 3: methylMnM.Rnw:82-83
###################################################
library(methylMnM)


###################################################
### code chunk number 4: methylMnM.Rnw:165-167
###################################################
datafile<-system.file("extdata",  package = "methylMnM")
filepath<-datafile[1]


###################################################
### code chunk number 5: methylMnM.Rnw:174-175
###################################################
dirwrite<-paste(setwd(getwd()),"/",sep="")


###################################################
### code chunk number 6: methylMnM.Rnw:189-195
###################################################
binlength<-500
file.cpgsite<-paste(filepath,"/all_CpGsite_chr18.txt",sep="")
writefile<-paste(dirwrite,"numallcpg.bed",sep="")
reportfile<-paste(dirwrite,"report_numallcpg.txt",sep="")

countcpgbin(file.cpgsite,file.blacklist=NULL,file.bin=NULL, writefile=writefile, reportfile=reportfile, binlength=binlength)


###################################################
### code chunk number 7: methylMnM.Rnw:234-244
###################################################
file<-paste(filepath,"/three_Mre_CpGsite_chr18.txt",sep="")
file1<-paste(filepath,"/all_CpGsite_chr18.txt",sep="")
allcpgfile<-paste(dirwrite,"numallcpg.bed",sep="")
five_Mre_CpGsite<-read.table(file, header=FALSE, as.is=TRUE)
four_Mre_CpGsite<-five_Mre_CpGsite[five_Mre_CpGsite[,4]!="ACGT",]
mrecpg.site<-four_Mre_CpGsite[four_Mre_CpGsite[,4]!="CGCG",]
writefile<-paste(dirwrite,"three_mre_cpg.bed",sep="")


countMREcpgbin(mrecpg.site,file.allcpgsite=file1,file.bin=allcpgfile,writefile=writefile, binlength=500)


###################################################
### code chunk number 8: methylMnM.Rnw:276-282
###################################################
file3<-paste(filepath,"/H1ESB1_MeDIP_18.extended.txt",sep="")
allcpgfile<-paste(dirwrite,"numallcpg.bed",sep="")
writefile<-paste(dirwrite,"H1ESB1_MeDIP_num500_chr18.bed",sep="")
reportfile<-paste(dirwrite,"H1ESB1_MeDIP_num500_chr18_report.txt",sep="")

countMeDIPbin(file.Medipsite=file3,file.blacklist=NULL,file.bin=allcpgfile,file.CNV=NULL,writefile=writefile, reportfile=reportfile, binlength=500)


###################################################
### code chunk number 9: methylMnM.Rnw:316-321
###################################################
file4<-paste(filepath,"/H1ESB1_MRE_18.extended.txt",sep="")
writefile<-paste(dirwrite,"H1ESB1_MRE_num500_chr18.bed",sep="")
reportfile<-paste(dirwrite,"H1ESB1_MRE_num500_chr18_report.bed",sep="")

countMREbin(file.MREsite=file4,file.blacklist=NULL, file.bin=allcpgfile,file.CNV=NULL, cutoff=0.05,writefile=writefile, reportfile=reportfile, binlength=500)


###################################################
### code chunk number 10: methylMnM.Rnw:356-362
###################################################
file5<-paste(filepath,"/H1ESB2_Medip_18.extended.txt",sep="")
allcpgfile<-paste(dirwrite,"numallcpg.bed",sep="")
writefile<-paste(dirwrite,"H1ESB2_MeDIP_num500_chr18.bed",sep="")
reportfile<-paste(dirwrite,"H1ESB2_MeDIP_num500_chr18_report.txt",sep="")

countMeDIPbin(file.Medipsite=file5,file.blacklist=NULL,file.bin=allcpgfile,file.CNV=NULL,writefile=writefile, reportfile=reportfile, binlength=500)


###################################################
### code chunk number 11: methylMnM.Rnw:367-372
###################################################
file6<-paste(filepath,"/H1ESB2_MRE_18.extended.txt",sep="")
writefile<-paste(dirwrite,"H1ESB2_MRE_num500_chr18.bed",sep="")
reportfile<-paste(dirwrite,"H1ESB2_MRE_num500_chr18_report.txt",sep="")

countMREbin(file.MREsite=file6,file.blacklist=NULL, file.bin=allcpgfile,file.CNV=NULL, cutoff=0.05,writefile=writefile, reportfile=reportfile, binlength=500)


###################################################
### code chunk number 12: methylMnM.Rnw:391-403
###################################################
datafile1<-paste(dirwrite,"H1ESB1_MeDIP_num500_chr18.bed",sep="")
datafile2<-paste(dirwrite,"H1ESB2_MeDIP_num500_chr18.bed",sep="")
datafile3<-paste(dirwrite,"H1ESB1_MRE_num500_chr18.bed",sep="")
datafile4<-paste(dirwrite,"H1ESB2_MRE_num500_chr18.bed",sep="")
datafile<-c(datafile1,datafile2,datafile3,datafile4)
chrstring<-NULL
cpgfile<-paste(dirwrite,"numallcpg.bed",sep="")
mrecpgfile<-paste(dirwrite,"three_mre_cpg.bed",sep="")
writefile<-paste(dirwrite,"pvalH1ESB1_H1ESB2_chr18.bed",sep="")
reportfile<-paste(dirwrite,"report_pvalH1ESB1_H1ESB2_chr18.txt",sep="")

MnM.test(file.dataset=datafile,chrstring=chrstring,file.cpgbin=cpgfile,file.mrecpgbin=mrecpgfile,writefile=writefile,reportfile=reportfile,mreratio=3/7,method="XXYY", psd=2,mkadded=1,a=1e-16,cut=100,top=500)


###################################################
### code chunk number 13: methylMnM.Rnw:459-464
###################################################
datafile<-paste(dirwrite,"pvalH1ESB1_H1ESB2_chr18.bed",sep="")
writefile<-paste(dirwrite,"q_H1ESB1_H1ESB2_chr18.bed",sep="")
reportfile<-paste(dirwrite,"report_q_H1ESB1_H1ESB2_chr18.bed",sep="")

MnM.qvalue(datafile,writefile,reportfile)


###################################################
### code chunk number 14: methylMnM.Rnw:489-494
###################################################
file<-paste(dirwrite,"q_H1ESB1_H1ESB2_chr18.bed",sep="")
frames<-read.table(file, header=TRUE,sep="\t", as.is=TRUE)
DMR<-MnM.selectDMR(frames =frames , up = 1.45, down =1/1.45, p.value.MM = 0.01, p.value.SAGE = 0.01,q.value =0.01,cutoff="q-value",  quant= 0.6)
writefile<-paste(dirwrite,"DMR_e5_H1ESB1_H1ESB2_chr18.bed",sep="")
write.table(DMR, writefile,sep="\t", quote=FALSE,row.names=FALSE)


