# Code example from 'GMRP' vignette. See references/ for full tutorial.

### R code from vignette source 'GMRP.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex(use.unsrturl=FALSE)


###################################################
### code chunk number 2: GMRP.Rnw:47-50
###################################################
#library(knitr)
set.seed(102)
options(width = 90)


###################################################
### code chunk number 3: GMRP.Rnw:53-54
###################################################
library(GMRP)


###################################################
### code chunk number 4: fmerge (eval = FALSE)
###################################################
## data1 <- matrix(NA, 20, 4)
## data2 <- matrix(NA, 30, 7)
## SNPID1 <- paste("rs", seq(1:20), sep="")
## SNPID2 <- paste("rs", seq(1:30), sep="")
## data1[,1:4] <- c(round(runif(20), 4), round(runif(20), 4), round(runif(20), 4), round(runif(20), 4))
## data2[,1:4] <- c(round(runif(30), 4),round(runif(30), 4), round(runif(30), 4), round(runif(30), 4))
## data2[,5:7] <- c(round(seq(30)*runif(30), 4), round(seq(30)*runif(30), 4), seq(30))
## data1 <- cbind(SNPID1, as.data.frame(data1))
## data2 <- cbind(SNPID2, as.data.frame(data2))
## dim(data1)
## dim(data2)
## colnames(data1) <- c("SNP", "var1", "var2", "var3", "var4")
## colnames(data2) <- c("SNP", "var1", "var2", "var3", "var4", "V1", "V2", "V3")
## data1<-DataFrame(data1)
## data2<-DataFrame(data2)
## data12 <- fmerge(fl1=data1, fl2=data2, ID1="SNP", ID2="SNP", A=".dat1", B=".dat2", method="No")


###################################################
### code chunk number 5: GMRP.Rnw:99-103
###################################################
data(cad.data)
#cad <- DataFrame(cad.data)
cad<-cad.data
head(cad)


###################################################
### code chunk number 6: GMRP.Rnw:106-110
###################################################
data(lpd.data)
#lpd <- DataFrame(lpd.data)
lpd<-lpd.data
head(lpd)


###################################################
### code chunk number 7: Step1 (eval = FALSE)
###################################################
## pvalue.LDL <- lpd$P.value.LDL
## pvalue.HDL <-lpd$P.value.HDL
## pvalue.TG <- lpd$P.value.TG
## pvalue.TC <- lpd$P.value.TC
## pv <- cbind(pvalue.LDL, pvalue.HDL, pvalue.TG, pvalue.TC)
## pvj <- apply(pv, 1, min)


###################################################
### code chunk number 8: Step2 (eval = FALSE)
###################################################
## beta.LDL <- lpd$beta.LDL
## beta.HDL <- lpd$beta.HDL
## beta.TG <- lpd$beta.TG
## beta.TC <- lpd$beta.TC
## beta <- cbind(beta.LDL, beta.HDL, beta.TG, beta.TC)


###################################################
### code chunk number 9: Step3 (eval = FALSE)
###################################################
## a1.LDL <- lpd$A1.LDL
## a1.HDL <- lpd$A1.HDL
## a1.TG <- lpd$A1.TG
## a1.TC <- lpd$A1.TC
## alle1 <- cbind(a1.LDL, a1.HDL, a1.TG, a1.TC)


###################################################
### code chunk number 10: Step4 (eval = FALSE)
###################################################
## N.LDL <- lpd$N.LDL
## N.HDL <- lpd$N.HDL
## N.TG <- lpd$N.TG
## N.TC <- lpd$N.TC
## ss <- cbind(N.LDL, N.HDL, N.TG, N.TC)
## sm <- apply(ss,1,sum)
## pcj <- round(sm/max(sm), 6)


###################################################
### code chunk number 11: Step5 (eval = FALSE)
###################################################
## freq.LDL<-lpd$Freq.A1.1000G.EUR.LDL
## freq.HDL<-lpd$Freq.A1.1000G.EUR.HDL
## freq.TG<-lpd$Freq.A1.1000G.EUR.TG
## freq.TC<-lpd$Freq.A1.1000G.EUR.TC
## freq<-cbind(freq.LDL,freq.HDL,freq.TG,freq.TC)


###################################################
### code chunk number 12: Step6 (eval = FALSE)
###################################################
## sd.LDL <- rep(37.42, length(pvj))
## sd.HDL <- rep(14.87, length(pvj))
## sd.TG <-rep(92.73, length(pvj))
## sd.TC <- rep(42.74, length(pvj))
## sd <- cbind(sd.LDL, sd.HDL, sd.TG, sd.TC)


###################################################
### code chunk number 13: Step7 (eval = FALSE)
###################################################
## hg19 <- lpd$SNP_hg19.HDL
## rsid <- lpd$rsid.HDL


###################################################
### code chunk number 14: Step8 (eval = FALSE)
###################################################
## chr<-chrp(hg=hg19)


###################################################
### code chunk number 15: Step9 (eval = FALSE)
###################################################
## newdata<-cbind(freq,beta,sd,pvj,ss,pcj)
## newdata<-cbind(chr,rsid,alle1,as.data.frame(newdata))
## dim(newdata)


###################################################
### code chunk number 16: Step10 (eval = FALSE)
###################################################
## hg18.d <- cad$chr_pos_b36
## SNP.d <- cad$SNP #SNPID
## a1.d<- tolower(cad$reference_allele)
## freq.d <- cad$ref_allele_frequency
## pvalue.d <- cad$pvalue
## beta.d <- cad$log_odds
## N.case <- cad$N_case
## N.ctr <- cad$N_control
## N.d <- N.case+N.ctr
## freq.case <- N.case/N.d


###################################################
### code chunk number 17: Step11 (eval = FALSE)
###################################################
## newcad <- cbind(freq.d, beta.d, N.case, N.ctr, freq.case)
## newcad <- cbind(hg18.d, SNP.d, a1.d, as.data.frame(newcad))
## dim(newcad)


###################################################
### code chunk number 18: Step12 (eval = FALSE)
###################################################
## varname <-c("CAD", "LDL", "HDL", "TG", "TC")


###################################################
### code chunk number 19: Step13 (eval = FALSE)
###################################################
## mybeta <- mktable(cdata=newdata, ddata=newcad, rt="beta", varname=varname, LG=1, Pv=0.00000005, Pc=0.979, Pd=0.979)
## dim(mybeta)
## beta <- mybeta[,4:8]   #  standard beta table for path analysis
## snp <- mybeta[,1:3]   #  snp data for annotation analysis
## beta<-DataFrame(beta)
## head(beta)


###################################################
### code chunk number 20: GMRP.Rnw:268-275
###################################################
data(beta.data)
beta.data<-DataFrame(beta.data)
CAD <- beta.data$cad
LDL <- beta.data$ldl
HDL <- beta.data$hdl
TG <- beta.data$tg
TC <- beta.data$tc


###################################################
### code chunk number 21: TwoScatterPlot
###################################################
par(mfrow=c(2, 2), mar=c(5.1, 4.1, 4.1, 2.1), oma=c(0, 0, 0, 0))
plot(LDL,CAD, pch=19, col="blue", xlab="beta of SNPs on LDL", ylab="beta of SNP on CAD", cex.lab=1.5, cex.axis=1.5, cex.main=2)
abline(lm(CAD~LDL), col="red", lwd=2)
plot(HDL, CAD, pch=19,col="blue", xlab="beta of SNPs on HDL", ylab="beta of SNP on CAD", cex.lab=1.5, cex.axis=1.5, cex.main=2)
abline(lm(CAD~HDL), col="red", lwd=2)
plot(TG, CAD, pch=19, col="blue", xlab="beta of SNPs on TG", ylab="beta of SNP on CAD",cex.lab=1.5, cex.axis=1.5, cex.main=2)
abline(lm(CAD~TG), col="red", lwd=2)
plot(TC,CAD, pch=19, col="blue", xlab="beta of SNPs on TC", ylab="beta of SNP on CAD", cex.lab=1.5, cex.axis=1.5, cex.main=2)
abline(lm(CAD~TC), col="red", lwd=2)


###################################################
### code chunk number 22: figTwoScatterPlot
###################################################
par(mfrow=c(2, 2), mar=c(5.1, 4.1, 4.1, 2.1), oma=c(0, 0, 0, 0))
plot(LDL,CAD, pch=19, col="blue", xlab="beta of SNPs on LDL", ylab="beta of SNP on CAD", cex.lab=1.5, cex.axis=1.5, cex.main=2)
abline(lm(CAD~LDL), col="red", lwd=2)
plot(HDL, CAD, pch=19,col="blue", xlab="beta of SNPs on HDL", ylab="beta of SNP on CAD", cex.lab=1.5, cex.axis=1.5, cex.main=2)
abline(lm(CAD~HDL), col="red", lwd=2)
plot(TG, CAD, pch=19, col="blue", xlab="beta of SNPs on TG", ylab="beta of SNP on CAD",cex.lab=1.5, cex.axis=1.5, cex.main=2)
abline(lm(CAD~TG), col="red", lwd=2)
plot(TC,CAD, pch=19, col="blue", xlab="beta of SNPs on TC", ylab="beta of SNP on CAD", cex.lab=1.5, cex.axis=1.5, cex.main=2)
abline(lm(CAD~TC), col="red", lwd=2)


###################################################
### code chunk number 23: path (eval = FALSE)
###################################################
## data(beta.data)
## mybeta <- DataFrame(beta.data)
## mod <- CAD~LDL+HDL+TG+TC
## pathvalue <- path(betav=mybeta, model=mod, outcome="CAD")


###################################################
### code chunk number 24: GMRP.Rnw:312-319
###################################################
mypath <- matrix(NA,3,4)
mypath[1,] <- c(1.000000, -0.066678, 0.420036, 0.764638)
mypath[2,] <- c(-0.066678, 1.000000, -0.559718, 0.496831)
mypath[3,] <- c(0.420036, -0.559718, 1.000000, 0.414346)
colnames(mypath) <- c("LDL", "HDL", "TG", "path")
mypath<-as.data.frame(mypath)
mypath


###################################################
### code chunk number 25: GMRP.Rnw:332-333
###################################################
library(diagram)


###################################################
### code chunk number 26: PathDiagram
###################################################
pathdiagram(pathdata=mypath, disease="CAD", R2=0.988243, range=c(1:3))


###################################################
### code chunk number 27: figPathDiagram
###################################################
pathdiagram(pathdata=mypath, disease="CAD", R2=0.988243, range=c(1:3))


###################################################
### code chunk number 28: GMRP.Rnw:365-373
###################################################
pathD<-matrix(NA,4,5)
pathD[1,] <- c(1,	-0.070161, 0.399038, 0.907127, 1.210474)
pathD[2,] <- c(-0.070161,	1, -0.552106, 0.212201, 0.147933)
pathD[3,] <- c(0.399038, -0.552106, 1, 0.44100, 0.64229)
pathD[4,] <- c(0.907127, 0.212201, 0.441007, 1, -1.035677)
colnames(pathD) <- c("LDL", "HDL", "TG", "TC", "path")
pathD<-as.data.frame(pathD)
pathD


###################################################
### code chunk number 29: PathDiagram2
###################################################
pathdiagram2(pathD=pathD,pathO=mypath,rangeD=c(1:4),rangeO=c(1:3),disease="CAD", R2D=0.536535,R2O=0.988243)


###################################################
### code chunk number 30: figPathDiagram2
###################################################
pathdiagram2(pathD=pathD,pathO=mypath,rangeD=c(1:4),rangeO=c(1:3),disease="CAD", R2D=0.536535,R2O=0.988243)


###################################################
### code chunk number 31: GMRP.Rnw:397-400
###################################################
data(SNP358.data)
SNP358 <- as.data.frame(SNP358.data)
head(SNP358)


###################################################
### code chunk number 32: GMRP.Rnw:404-405
###################################################
library(graphics)


###################################################
### code chunk number 33: ChromHistogram
###################################################
snpPositAnnot(SNPdata=SNP358,SNP_hg19="chr",main="A")


###################################################
### code chunk number 34: figChromHistogram
###################################################
snpPositAnnot(SNPdata=SNP358,SNP_hg19="chr",main="A")


###################################################
### code chunk number 35: GMRP.Rnw:435-438
###################################################
data(SNP368annot.data)
SNP368<-as.data.frame(SNP368annot.data)
SNP368[1:10, ]


###################################################
### code chunk number 36: GMRP.Rnw:442-443
###################################################
library(plotrix)


###################################################
### code chunk number 37: PIE3D1
###################################################
ucscannot(UCSCannot=SNP368,SNPn=368)


###################################################
### code chunk number 38: figPIE3D1
###################################################
ucscannot(UCSCannot=SNP368,SNPn=368)


###################################################
### code chunk number 39: PIE3D2
###################################################
ucscannot(UCSCannot=SNP368,SNPn=368,A=3,B=2,C=1.3,method=2)


###################################################
### code chunk number 40: figPIE3D2
###################################################
ucscannot(UCSCannot=SNP368,SNPn=368,A=3,B=2,C=1.3,method=2)


###################################################
### code chunk number 41: GMRP.Rnw:495-496
###################################################
sessionInfo()


