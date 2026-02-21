# Code example from 'GeneMeta' vignette. See references/ for full tutorial.

### R code from vignette source 'GeneMeta.Rnw'

###################################################
### code chunk number 1: loaddata
###################################################
library(GeneMeta)
library(RColorBrewer)
#load("~/Bioconductor/Projects/GraphCombine/MetaBreast/data/Nevins.RData")
data(Nevins)


###################################################
### code chunk number 2: Splitting
###################################################
set.seed(1609)
thestatus  <- pData(Nevins)[,"ER.status"]
group1     <- which(thestatus=="pos")
group2     <- which(thestatus=="neg")
rrr        <- c(sample(group1, floor(length(group1)/2)),
		sample(group2,ceiling(length(group2)/2)))
Split1     <- Nevins[,rrr]
Split2     <- Nevins[,-rrr]


###################################################
### code chunk number 3: phenoData
###################################################
#obtain classes
Split1.ER<-pData(Split1)[,"ER.status"]
levels(Split1.ER) <- c(0,1)
Split1.ER<- as.numeric(as.character(Split1.ER))
Split2.ER<-pData(Split2)[,"ER.status"]
levels(Split2.ER) <- c(0,1)
Split2.ER<- as.numeric(as.character(Split2.ER))


###################################################
### code chunk number 4: calcd
###################################################
#calculate d for Split1
d.Split1     <- getdF(Split1, Split1.ER)

#adjust d value
d.adj.Split1    <- dstar(d.Split1, length(Split1.ER))
var.d.adj.Spli1 <- sigmad(d.adj.Split1, sum(Split1.ER==0), sum(Split1.ER==1))


#calculate d for Split2
d.Split2 <- getdF(Split2, Split2.ER)

#adjust d value
d.adj.Split2     <- dstar(d.Split2, length(Split2.ER))
var.d.adj.Split2 <- sigmad(d.adj.Split2, sum(Split2.ER==0), sum(Split2.ER==1))



###################################################
### code chunk number 5: calcQ
###################################################
#calculate Q
mymns  <- cbind(d.adj.Split1, d.adj.Split2)
myvars <- cbind(var.d.adj.Spli1,var.d.adj.Split2)
my.Q   <- f.Q(mymns, myvars)
mean(my.Q)


###################################################
### code chunk number 6: Qplo
###################################################
hist(my.Q,breaks=50,col="red")


###################################################
### code chunk number 7: grapics
###################################################
########### graphics ################

num.studies<-2

#quantiles of the chisq distribution
chisqq <- qchisq(seq(0, .9999, .001), df=num.studies-1)
tmp<-quantile(my.Q, seq(0, .9999, .001))
qqplot(chisqq, tmp, ylab="Quantiles of Sample",pch="*",
    xlab="Quantiles of Chi square", main="QQ Plot")
lines(chisqq, chisqq, lty="dotted",col="red")


###################################################
### code chunk number 8: FEMmodel
###################################################
 muFEM = mu.tau2(mymns, myvars)
 sdFEM = var.tau2(myvars)
 ZFEM = muFEM/sqrt(sdFEM)


###################################################
### code chunk number 9: qnormPlotFEM
###################################################
 qqnorm(ZFEM,pch="*")
 qqline(ZFEM,col="red")


###################################################
### code chunk number 10: estimatedEffects
###################################################
my.tau2.DL<-tau2.DL(my.Q, num.studies, my.weights=1/myvars)

#obtain new variances s^2+tau^2
myvarsDL <- myvars + my.tau2.DL


#compute
muREM <- mu.tau2(mymns, myvarsDL)


#cumpute mu(tau)
varREM <- var.tau2(myvarsDL)

ZREM <- muREM/sqrt(varREM)


###################################################
### code chunk number 11: compMU
###################################################
plot(muFEM, muREM, pch=".")
abline(0,1,col="red")


###################################################
### code chunk number 12: theTau
###################################################
hist(my.tau2.DL,col="red",breaks=50,main="Histogram of tau")


###################################################
### code chunk number 13: claculationAllinOne
###################################################
esets     <- list(Split1,Split2,Nevins)
data.ER   <-pData(Nevins)[,"ER.status"]
levels(data.ER) <- c(0,1)
data.ER<- as.numeric(as.character(data.ER))
classes   <- list(Split1.ER,Split2.ER,data.ER)
theScores <- zScores(esets,classes,useREM=FALSE,CombineExp=1:2)


###################################################
### code chunk number 14: show results
###################################################
theScores[1:2,]


###################################################
### code chunk number 15: originalvsCombination
###################################################
plot(theScores[,"zSco_Ex_3"],theScores[,"zSco"],pch="*",xlab="original score",ylab="combined score")
abline(0,1,col="red")


###################################################
### code chunk number 16: IDRplot
###################################################
IDRplot(theScores,Combine=1:2,colPos="blue", colNeg="red")


###################################################
### code chunk number 17: calculationAllinOne
###################################################
ScoresFDR <- zScoreFDR(esets, classes, useREM=FALSE, nperm=50,CombineExp=1:2)


###################################################
### code chunk number 18: calculation whole set
###################################################
names(ScoresFDR)


###################################################
### code chunk number 19: showSet
###################################################
ScoresFDR$pos[1:2,]


###################################################
### code chunk number 20: gettingFDR
###################################################
FDRwholeSettwo <- sort(ScoresFDR$"two.sided"[,"FDR"])
experimentstwo <- list()
for(j in 1:3){
experimentstwo[[j]] <- sort(ScoresFDR$"two.sided"[,paste("FDR_Ex_",j,sep="")])
}


###################################################
### code chunk number 21: bb2
###################################################
theNewC <- brewer.pal(3,"Set2")


###################################################
### code chunk number 22: FDRtwo
###################################################
#####################
#                   #
#two sided z values #
#                   #
#####################

plot(FDRwholeSettwo,pch="*",col="red",ylab="FDR",xlab="Number of genes")
for(j in 1:3)
points(experimentstwo[[j]],pch="*", col=theNewC[j])
legend(4000,0.4,c("Combined set","Split 1" , "Split 2" ,"original set"), c("red",theNewC[1:3]))


###################################################
### code chunk number 23: theFDRplots
###################################################
#par(mfrow=c(2,2))
#CountPlot(ScoresFDR,Score="FDR",kindof="neg",cols=c("red",theNewC),
#	main="Negative FDR", xlab="FDR threshold", ylab="Number of genes",CombineExp=1:2)
#CountPlot(ScoresFDR,Score="FDR",cols=c("red",theNewC),kindof="pos",
#main="Positive FDR", xlab="FDR threshold", ylab="Number of genes",Combine=1:2)
CountPlot(ScoresFDR,Score="FDR",kindof="two.sided",cols=c("red",theNewC),main="two sided FDR", xlab="FDR threshold",ylab="Number of genes",CombineExp=3)


