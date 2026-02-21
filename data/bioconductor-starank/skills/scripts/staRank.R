# Code example from 'staRank' vignette. See references/ for full tutorial.

### R code from vignette source 'staRank.Rnw'

###################################################
### code chunk number 1: staRank.Rnw:50-51
###################################################
set.seed(42)  


###################################################
### code chunk number 2: staRank.Rnw:53-65
###################################################
# sample parameters for data
p<-20	# genes
n<-4	# replicates
trueEffects<-rnorm(p,0,5) # gene effect
s<-rgamma(p,shape=2.5,rate=0.5) # sample variance
	
# draw n replicate values of a gene
simData <- matrix(0,nr=p,nc=n, 
		dimnames=list(paste("Gene",c(1:p)),paste("Replicate",c(1:n))))
for(i in 1:p){
	simData[i,]<-replicate(n,rnorm(1,mean=trueEffects[i],sd=s[i]))
}


###################################################
### code chunk number 3: staRank.Rnw:72-76
###################################################
# load the stability ranking package
library(staRank)
# implemented ranking methods
method<-c('mean','median','mwtest','ttest','RSA')


###################################################
### code chunk number 4: staRank.Rnw:80-86
###################################################
stabilityList<-list()
stabilityList[['mean']]<-stabilityRanking(simData,method='mean')
stabilityList[['median']]<-stabilityRanking(simData,method='median')
stabilityList[['mwtest']]<-stabilityRanking(simData,method='mwtest')
stabilityList[['ttest']]<-stabilityRanking(simData,method='ttest')
stabilityList[['RSA']]<-stabilityRanking(simData,method='RSA')


###################################################
### code chunk number 5: staRank.Rnw:95-108
###################################################
# 1. create a ranking
extRanking <- sort(apply(simData,1,mean))
# 2. create 100 sample rankings
sampleRankings<-matrix(NA,nr=nrow(simData),nc=100)
for(i in 1:100){
	sampleRankings[,i]<-
			apply(simData,1,function(x){mean(sample(x,length(x),replace=TRUE))})
}
rownames(sampleRankings)<-rownames(simData)
sampleRankings<-sampleRankings[names(extRanking),]
# 3. run stabilityRanking
stabilityList[['externalMean']]<-
		stabilityRanking(extRanking,sampleRankings,method='externalMean')


###################################################
### code chunk number 6: staRank.Rnw:116-120
###################################################
#results for the mean ranking
baseRank(stabilityList$mean)
stabRank(stabilityList$mean)
avrgRank(stabilityList$mean)


###################################################
### code chunk number 7: staRank.Rnw:127-128
###################################################
rankCor(stabilityList[['mean']])


###################################################
### code chunk number 8: staRank.Rnw:134-135
###################################################
stableSetSize(stabilityList[['mean']])


###################################################
### code chunk number 9: toyStabilityPlot
###################################################
# plot the stable genes per cutoff k* for each method
mCol<-rainbow(5)
name_out<-c('Mean','Median','Rank sum','t-test','RSA')
plot(1,type='n',xlim=c(0,p),ylim=c(0,p),xlab='k*',ylab='stable genes')
abline(0,1,col='lightgray')
for(i in 5:1){
	lines(stableSetSize(stabilityList[[i]]),lwd=2,col=mCol[i])
}
legend('topleft',name_out,col=mCol,lwd=2)


###################################################
### code chunk number 10: staRank.Rnw:155-156
###################################################
# plot the stable genes per cutoff k* for each method
mCol<-rainbow(5)
name_out<-c('Mean','Median','Rank sum','t-test','RSA')
plot(1,type='n',xlim=c(0,p),ylim=c(0,p),xlab='k*',ylab='stable genes')
abline(0,1,col='lightgray')
for(i in 5:1){
	lines(stableSetSize(stabilityList[[i]]),lwd=2,col=mCol[i])
}
legend('topleft',name_out,col=mCol,lwd=2)


###################################################
### code chunk number 11: staRank.Rnw:176-181
###################################################
#load the data set
data(salmonellaInfection)
data<-as.matrix(salmonellaInfection)
down<-rownames(data[which(apply(data,1,mean)<=-1),])
data<-data[down,]


###################################################
### code chunk number 12: staRank.Rnw:183-187 (eval = FALSE)
###################################################
## salmonellaStability<-list()
## salmonellaStability[['mean']]<-stabilityRanking(data,method='mean')
## salmonellaStability[['mwtest']]<-stabilityRanking(data,method='mwtest')
## salmonellaStability[['RSA']]<-stabilityRanking(data,method='RSA')


###################################################
### code chunk number 13: staRank.Rnw:188-189 (eval = FALSE)
###################################################
## save(salmonellaStability,file='data/salmonellaStability.RData')


###################################################
### code chunk number 14: staRank.Rnw:191-192
###################################################
data(salmonellaStability)


###################################################
### code chunk number 15: staRank.Rnw:196-197
###################################################
rankCor(salmonellaStability$mwtest)


###################################################
### code chunk number 16: staRank.Rnw:202-205
###################################################
# gather all rankings in a matrix
rankings<-lapply(salmonellaStability,getRankmatrix)
rankings<-Reduce(cbind,lapply(rankings,function(x){x[down,]}))


###################################################
### code chunk number 17: dataplot
###################################################
# plot data according to rankings
par(mfrow=c(1,5),mar=c(4,4,2,2))
range<-range(data)
for(m in c(2,3,1,4,8)){
	plot(1,type='n',xlim=c(0,length(down)), ylim=range,main='', 
		ylab='infection score', xlab=paste(colnames(rankings)[m],'rank'))
	orderedData<-data[order(rankings[,m]),]
	for(j in 1:3){
		points(orderedData[,j],pch=20,cex=0.5)
	}
	points(apply(orderedData,1,mean),col='red',pch=20,cex=0.5)
}


###################################################
### code chunk number 18: staRank.Rnw:227-228
###################################################
# plot data according to rankings
par(mfrow=c(1,5),mar=c(4,4,2,2))
range<-range(data)
for(m in c(2,3,1,4,8)){
	plot(1,type='n',xlim=c(0,length(down)), ylim=range,main='', 
		ylab='infection score', xlab=paste(colnames(rankings)[m],'rank'))
	orderedData<-data[order(rankings[,m]),]
	for(j in 1:3){
		points(orderedData[,j],pch=20,cex=0.5)
	}
	points(apply(orderedData,1,mean),col='red',pch=20,cex=0.5)
}


###################################################
### code chunk number 19: infectionStabilityPlot
###################################################
# plot the stable genes per cutoff k* for each method
mCol<-rainbow(3)
name_out<-c('Mean','Rank sum','RSA')
plot(1,type='n',xlim=c(0,length(down)),ylim=c(0,length(down)),
		xlab='k*',ylab='stable genes')
abline(0,1,col='lightgray')
for(i in 1:3){
	lines(stableSetSize(salmonellaStability[[i]]),lwd=2,col=mCol[i])
}
legend('topleft',name_out,col=mCol,lwd=2)


###################################################
### code chunk number 20: staRank.Rnw:255-256
###################################################
# plot the stable genes per cutoff k* for each method
mCol<-rainbow(3)
name_out<-c('Mean','Rank sum','RSA')
plot(1,type='n',xlim=c(0,length(down)),ylim=c(0,length(down)),
		xlab='k*',ylab='stable genes')
abline(0,1,col='lightgray')
for(i in 1:3){
	lines(stableSetSize(salmonellaStability[[i]]),lwd=2,col=mCol[i])
}
legend('topleft',name_out,col=mCol,lwd=2)


###################################################
### code chunk number 21: staRank.Rnw:265-266
###################################################
summary(salmonellaStability$mean)


