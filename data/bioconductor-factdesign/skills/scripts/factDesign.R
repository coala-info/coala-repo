# Code example from 'factDesign' vignette. See references/ for full tutorial.

### R code from vignette source 'factDesign.Rnw'

###################################################
### code chunk number 1: loadlibs
###################################################

 library(Biobase)
 library(affy)
 library(stats)
 library(factDesign)



###################################################
### code chunk number 2: phenoData
###################################################
data(estrogen)
estrogen
pData(estrogen)



###################################################
### code chunk number 3: FCplots
###################################################

par(mfrow=c(2,2))
par(las=2)
for (i in c("34371_at","37325_at","33744_at","39792_at")){
	expvals <- 2^exprs(estrogen)[i,]
	plot(expvals,axes=F,cex=1.5,
		xlab="Conditions",ylab="Expression Estimate")
	points(1:2,expvals[1:2],pch=16,cex=1.5,col=2)	
	points(3:4,expvals[3:4],pch=16,cex=1.5,col=3)
	axis(1,at=1:8,labels=c("et1","et2","Et1","Et2","eT1","eT2","ET1","ET2"))
	axis(2)
	FC <- round(mean(expvals[3:4])/mean(expvals[1:2]),3)
	title(paste(i,", FC=",FC,sep=""))
}



###################################################
### code chunk number 4: moreplots
###################################################

par(mfrow=c(2,2))
par(las=2)
for (i in c("32536_at","40446_at","32901_s_at","31826_at")){
	expvals <- exprs(estrogen)[i,]
	plot(expvals,axes=F,cex=1.5,
		xlab="Conditions",ylab="log 2 Expression Estimate")
	axis(1,at=1:8,labels=c("et1","et2","Et1","Et2","eT1","eT2","ET1","ET2"))
	axis(2)
	title(i)
}



###################################################
### code chunk number 5: outliers
###################################################

op1 <- outlierPair(exprs(estrogen)["728_at",],INDEX=pData(estrogen),p=.05)
print(op1)
madOutPair(exprs(estrogen)["728_at",],op1[[3]])



par(mfrow=c(2,2))
par(las=2)
for (i in c("728_at","33379_at")){
	expvals <- exprs(estrogen)[i,]
	plot(expvals,axes=F,cex=1.5,
		xlab="Conditions",ylab="log 2 Expression Estimate")
	if(i=="728_at") points(7:8,expvals[7:8],pch=16,cex=1.5)
	if(i=="33379_at") points(1:2,expvals[1:2],pch=16,cex=1.5)
	axis(1,at=1:8,labels=c("et1","et2","Et1","Et2","eT1","eT2","ET1","ET2"))
	axis(2)
	title(i)
}

#for (j in 1:500){
#	op <- outlierPair(exprs(estrogen)[j,],INDEX=pData(estrogen),p=.05)
#	if(op[[1]]){
#		so <- madOutPair(exprs(estrogen)[j,],op[[3]])
#		if(!is.na(so)) exprs(estrogen)[j,so] <- NA
#	}
#}




###################################################
### code chunk number 6: lm
###################################################
lm.full <- function(y) lm(y ~ ES + TIME + ES:TIME)
lm.time <- function(y) lm(y ~ TIME)

lm.f <- esApply(estrogen, 1, lm.full)
lm.t <- esApply(estrogen, 1, lm.time)

lm.f[[1]]
lm.t[[1]]



###################################################
### code chunk number 7: comparemodels
###################################################

Fpvals <- rep(0,length(lm.f))
for(i in 1:length(lm.f)){
  Fpvals[i]<-anova(lm.t[[i]],lm.f[[i]])$P[2]
}


library(multtest)
procs <- c("BH")
F.res <- mt.rawp2adjp(Fpvals,procs)
F.adjps <- F.res$adjp[order(F.res$index),]

Fsub <- which(F.adjps[,"BH"]<.15)

estrogen.Fsub <- estrogen[Fsub]
lm.f.Fsub <- lm.f[Fsub]

estrogen.Fsub




###################################################
### code chunk number 8: mainES
###################################################

betaNames <- names(coef(lm.f[[1]]))
lambda <- par2lambda(betaNames,c("ESP"),c(1))

mainES <- function(x) contrastTest(x,lambda,p=0.05)[[1]]
mainESgenes <- sapply(lm.f.Fsub,FUN=mainES)
sum(mainESgenes=="REJECT")



###################################################
### code chunk number 9: EShm1
###################################################

heatmap(exprs(estrogen.Fsub)[mainESgenes=="REJECT",],Colv=NA,col=cm.colors(256))



###################################################
### code chunk number 10: EShm2
###################################################

heatmap(exprs(estrogen.Fsub)[mainESgenes=="FAIL TO REJECT",],Colv=NA,col=cm.colors(256))



###################################################
### code chunk number 11: effectsize
###################################################

lambdaNum <- par2lambda(betaNames,list(c("(Intercept)","ESP")),list(c(1,1)))
lambdaDenom <-  par2lambda(betaNames,list(c("(Intercept)")),list(c(1)))
FCval <- findFC(lm.f.Fsub[["32901_s_at"]],lambdaNum,lambdaDenom,logbase=2)
print(FCval)

FCvals <- lapply(lm.f.Fsub,FUN=findFC,lambdaNum,lambdaDenom,logbase=2)
largeFC <- unlist(FCvals>1.4 | FCvals<.7)
estrogen.Fsub.FC <- estrogen.Fsub[largeFC & mainESgenes=="REJECT"]

heatmap(exprs(estrogen.Fsub.FC),Colv=NA,col=cm.colors(256))



###################################################
### code chunk number 12: performct
###################################################

lambdaEST <- par2lambda(betaNames,list(c("ESP","ESP:TIME48h")),list(c(1,1)))

ESTcontrast <- function(x) contrastTest(x,lambdaEST,p=.10)[[1]]
ESTgenes <- sapply(lm.f.Fsub,FUN=ESTcontrast)
sum(ESTgenes=="REJECT")



###################################################
### code chunk number 13: ESThm1
###################################################

heatmap(exprs(estrogen.Fsub)[mainESgenes=="REJECT" & ESTgenes=="REJECT",],Colv=NA,col=cm.colors(256))



