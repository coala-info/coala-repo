# Code example from 'nudge.vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'nudge.vignette.Rnw'

###################################################
### code chunk number 1: nudge.vignette.Rnw:28-30
###################################################
library(nudge)



###################################################
### code chunk number 2: nudge.vignette.Rnw:35-43
###################################################
data(like)
#lR is the matrix or vector of log ratios to the base 2
#We get this by subtracting the log of the green intensities for each gene from the log of the red intensities for each gene (the colour assignments can be the other way also)
lR<-log(like[,1],2)-log(like[,2],2)
#lI is the matrix or vector of log intensities to the base 2
#We get this by adding the log of the green intensities for each gene from the log of the red intensities for each gene
lI<-log(like[,1],2)+log(like[,2],2)



###################################################
### code chunk number 3: nudge.vignette.Rnw:49-51
###################################################
result<-nudge1(logratio=lR,logintensity=lI)



###################################################
### code chunk number 4: nudge.vignette.Rnw:55-63
###################################################
names(result)
#pdiff is the vector of probabilities of differential expression
#lRnorm is the vector of normalized log ratios
#mu and sigma are the EM estimates of the parameters for the group of non-differentially expressed normalized log ratios
#mixprob is the mixing parameter estimate (or the prior probability for a gene not being differentially expressed)
#a is the min and b is the max of the normalized log ratios (this gives the range for the uniform mixture component)
#loglike is the converged log likelihood value for the fitted model



###################################################
### code chunk number 5: nudge.vignette.Rnw:67-72
###################################################
s<-sort(result$pdiff,decreasing=T,index.return=T)
#Look at the row number and the probabilities of the genes with the 20 highest probabilities of differential expression
names(lR)<-c(1:length(lR))
cbind(names(lR)[s$ix[1:20]],round(s$x[1:20],2))



###################################################
### code chunk number 6: nudge.vignette.Rnw:76-82
###################################################
# Set the threshold value
thresh<-0.5
sum(result$pdiff>=thresh)
#Can also look at the row numbers or names of these genes
names(lR)[result$pdiff>=thresh]



###################################################
### code chunk number 7: nudge.vignette.Rnw:86-89
###################################################
#lRnorm is the mean and variance normalized log ratios for the genes
lRnorm<-result$lRnorm



###################################################
### code chunk number 8: nudge.vignette.Rnw:90-106 (eval = FALSE)
###################################################
## #plot the two different log ratios versus log intensities side by side
## par(mfrow=c(1,2))
## #put them both on the same scale
## yl<-range(lR,lRnorm)
## plot(lI,lR,pch=".",main="Log ratios versus log intensities",xlab="log intensities",ylab="log ratios",ylim=yl)
## #We can also add a loess fitted mean line to the plot/
## l<-loess(lR~lI,span=0.6)
## slI<-sort(lI,index.return=T)
## lines(cbind(slI$x,l$fitted[slI$ix]))
## plot(lI,lRnorm,pch=".",
## main="Normalized log ratios versus log intensities", xlab="average log intensities",ylab="normalized log ratios",ylim=yl)
## #We can also add a loess fitted mean line to the plot
## l<-loess(lRnorm~lI,span=0.6)
## slI<-sort(lI,index.return=T)
## lines(cbind(slI$x,l$fitted[slI$ix]))
## 


###################################################
### code chunk number 9: nudge.vignette.Rnw:115-123
###################################################
data(hiv)
#lR is the matrix of log ratios to the base 2
#We get this by subtracting the logs of the intensities for sample 1 for each gene from the logs of the corresponding intensities for sample 2 for each gene (by corresponding intensities we mean those paired to the same slide)
lR<-log(hiv[,1:4],2)-log(hiv[,5:8],2)
#lI is the matrix of log intensities to the base 2
#We get this by adding the logs of the intensities for sample 1 for each gene from the logs of the corresponding intensities for sample 2 for each gene (by corresponding intensities we mean those paired to the same slide)
lI<-log(hiv[,1:4],2)+log(hiv[,5:8],2)



###################################################
### code chunk number 10: nudge.vignette.Rnw:133-135
###################################################
result<-nudge1(logratio=lR,logintensity=lI,dye.swap=T)



###################################################
### code chunk number 11: nudge.vignette.Rnw:139-147
###################################################
names(result)
#pdiff is the vector of probabilities of differential expression
#lRnorm is the vector of normalized log ratios
#mu and sigma are the EM estimates of the parameters for the group of non-differentially expressed log ratios
#mixprob is the mixing parameter estimate (or the prior probability for a gene not being differentially expressed)
#a is the min and b is the max of the normalized log ratios (this gives the range for the uniform mixture component)
#loglike is the converged log likelihood value for the fitted model



###################################################
### code chunk number 12: nudge.vignette.Rnw:151-156
###################################################
s<-sort(result$pdiff,decreasing=T,index.return=T)
#Look at the row number and the probabilities of the genes with the 20 highest probabilities of differential expression
rownames(lR)<-c(1:nrow(lR))
cbind(rownames(lR)[s$ix[1:20]],round(s$x[1:20],2))



###################################################
### code chunk number 13: nudge.vignette.Rnw:160-166
###################################################
# Set the threshold value
thresh<-0.5
sum(result$pdiff>=thresh)
#Can also look at the row numbers or names of these genes
rownames(lR)[result$pdiff>=thresh]



###################################################
### code chunk number 14: nudge.vignette.Rnw:170-177
###################################################
#lRbar is the average (across replicates) log ratios for the genes
lRbar<-apply(lR,1,mean)
#lIbar is the average (across replicates) log intensities for the genes 
lIbar<-apply(lI,1,mean)
#lRnorm is the mean and variance normalized average log ratios for the genes
lRnorm<-result$lRnorm



###################################################
### code chunk number 15: nudge.vignette.Rnw:178-183 (eval = FALSE)
###################################################
## #plot the two different average log ratios versus average log intensities side by side
## par(mfrow=c(1,2))
## #put them both on the same scale
## yl<-range(lRbar,lRnorm)
## 


###################################################
### code chunk number 16: nudge.vignette.Rnw:184-188 (eval = FALSE)
###################################################
## plot(lIbar,lRbar,pch=".",main="Average log ratios
##  versus 
##  average log  intensities",xlab="average log intensities",ylab="average log ratios", ylim=yl)
## 


###################################################
### code chunk number 17: nudge.vignette.Rnw:197-202 (eval = FALSE)
###################################################
## #We can also add a loess fitted mean line to the plot
## l<-loess(lRbar~lIbar,span=0.6)
## slI<-sort(lIbar,index.return=T)
## lines(cbind(slI$x,l$fitted[slI$ix]))
## 


###################################################
### code chunk number 18: nudge.vignette.Rnw:203-207 (eval = FALSE)
###################################################
## plot(lIbar,lRnorm,pch=".",main="Normalized average log ratios
##  versus 
##  average log intensities",xlab="average log intensities",ylab="normalized average log ratios", ylim=yl)
## 


###################################################
### code chunk number 19: nudge.vignette.Rnw:216-221 (eval = FALSE)
###################################################
## #We can also add a loess fitted mean line to the plot
## l<-loess(lRnorm~lIbar,span=0.6)
## slI<-sort(lIbar,index.return=T)
## lines(cbind(slI$x,l$fitted[slI$ix]))
## 


###################################################
### code chunk number 20: nudge.vignette.Rnw:227-238
###################################################
#diff is a vector of indicator variables with 1 indicating a gene is differentially expressed, 0 not
#ndiff is a vector of indicator variables with 1 indicating a gene is not differentially expressed, 0 is
diff<-round(result$pdiff)
ndiff<-1-diff
sum((diff==pos.contr)&pos.contr)
#we can also calculate the percentage of positive controls found
sum((diff==pos.contr)&pos.contr)/sum(pos.contr)*100
sum((ndiff==neg.contr)&neg.contr)
#we can also calculate the percentage of negative controls found
sum((ndiff==neg.contr)&neg.contr)/sum(neg.contr)*100



###################################################
### code chunk number 21: nudge.vignette.Rnw:242-246 (eval = FALSE)
###################################################
## x<-seq((result$a-1),(result$b+1),0.0001)
## #d is the fitted density at each point in x
## d<-(1-result$mixprob)*dunif(x,result$a,result$b)+ result$mixprob*dnorm(x,result$mu,result$sigma)
## par(mfrow=c(1,2))


###################################################
### code chunk number 22: nudge.vignette.Rnw:247-250 (eval = FALSE)
###################################################
## hist(result$lRnorm,freq=F,main="Histogram of 
## average normalized log ratios", xlab="average normalized log ratios",breaks=25)
## 


###################################################
### code chunk number 23: nudge.vignette.Rnw:257-260 (eval = FALSE)
###################################################
## lines(cbind(x,d),lty=2)
## #We can also take a closer look at the right-hand tail (where the positive controls are)
## 


###################################################
### code chunk number 24: nudge.vignette.Rnw:261-264 (eval = FALSE)
###################################################
## hist(result$lRnorm,freq=F,main="Right-side of the histogram of 
## average normalized log ratios",xlab="average normalized log ratios",xlim=c(1.5, result$b),ylim=c(0,0.1),breaks=25)
## 


###################################################
### code chunk number 25: nudge.vignette.Rnw:272-274 (eval = FALSE)
###################################################
## lines(cbind(x,d),lty=2)
## 


###################################################
### code chunk number 26: nudge.vignette.Rnw:281-283
###################################################
apo<-read.csv(file="http://www.stat.berkeley.edu/users/terry/zarray/Data/ApoA1/rg_a1ko_morph.txt", header=T)



###################################################
### code chunk number 27: nudge.vignette.Rnw:291-295
###################################################
rownames(apo)<-apo[,1]
apo<-apo[,-1]
colnames(apo)



###################################################
### code chunk number 28: nudge.vignette.Rnw:299-310
###################################################
#Because of zero entries we add 1 to all entries to allow us to take  logs
apo<-apo+1
#lRctl is the matrix of control log ratios to the base 2
lRctl<-log(apo[,c(seq(2,16,2))],2)-log(apo[,c(seq(1,15,2))],2)
#lRtxt is the matrix of treatment log ratios to the base 2
lRtxt<-log(apo[,c(seq(18,32,2))],2)-log(apo[,c(seq(17,31,2))],2)
#lIctl is the matrix of control log intensities to the base 2
lIctl<-log(apo[,c(seq(2,16,2))],2)+log(apo[,c(seq(1,15,2))],2)
#lItxt is the matrix of treatment log intensities to the base 2
lItxt<-log(apo[,c(seq(18,32,2))],2)+log(apo[,c(seq(17,31,2))],2)



###################################################
### code chunk number 29: nudge.vignette.Rnw:316-318
###################################################
result<-nudge2(control.logratio=lRctl,txt.logratio=lRtxt, control.logintensity=lIctl,txt.logintensity=lItxt)



###################################################
### code chunk number 30: nudge.vignette.Rnw:322-330
###################################################
names(result)
#pdiff is the vector of probabilities of differential expression
#lRnorm is the vector of normalized log ratio differences
#mu and sigma are the EM estimates of the parameters for the group of non-differentially expressed log ratios
#mixprob is the mixing parameter estimate (or the prior probability for a gene not being differentially expressed)
#a is the min and b is the max of the normalized log ratios (this gives the range for the uniform mixture component)
#loglike is the converged log likelihood value for the fitted model



###################################################
### code chunk number 31: nudge.vignette.Rnw:334-339
###################################################
s<-sort(result$pdiff,decreasing=T,index.return=T)
#Look at the row number and the probabilities of the genes with the 20 highest probabilities of differential expression
rownames(lRtxt)<-rownames(lRctl)<-c(1:nrow(lRtxt))
cbind(rownames(lRtxt)[s$ix[1:20]],round(s$x[1:20],2))



###################################################
### code chunk number 32: nudge.vignette.Rnw:343-349
###################################################
# Set the threshold value
thresh<-0.5
sum(result$pdiff>=thresh)
#Can also look at the row numbers or names of these genes
rownames(lRtxt)[result$pdiff>=thresh]



###################################################
### code chunk number 33: nudge.vignette.Rnw:353-360
###################################################
#lRbar is the average log ratio differences for the genes
lRbar<-apply(lRtxt,1,mean)-apply(lRctl,1,mean)
#lIbar is the average log intensities for the genes
lIbar<-apply(cbind(lItxt,lIctl),1,mean)
#lRnorm is the mean and variance normalized average log ratio differences for the genes
lRnorm<-result$lRnorm



###################################################
### code chunk number 34: nudge.vignette.Rnw:361-366 (eval = FALSE)
###################################################
## #plot the two different average log ratio differences versus average log intensities side by side
## par(mfrow=c(1,2))
## # put them both on the same scale
## yl<-range(lRbar,lRnorm)
## 


###################################################
### code chunk number 35: nudge.vignette.Rnw:367-371 (eval = FALSE)
###################################################
## plot(lIbar,lRbar,pch=".",main="Average log ratio differences
##  versus 
##  average log intensities",xlab="average log intensities",ylab="average log ratio differences", ylim=yl)
## 


###################################################
### code chunk number 36: nudge.vignette.Rnw:380-385 (eval = FALSE)
###################################################
## #We can also add a loess fitted mean line to the plot
## l<-loess(lRbar~lIbar,span=0.6)
## slI<-sort(lIbar,index.return=T)
## lines(cbind(slI$x,l$fitted[slI$ix]))
## 


###################################################
### code chunk number 37: nudge.vignette.Rnw:386-390 (eval = FALSE)
###################################################
## plot(lIbar,lRnorm,pch=".",main="Normalized average log ratio differences
##  versus 
##  average log intensities",xlab="average log intensities",ylab="normalized average log ratio differences",ylim=yl)
## 


###################################################
### code chunk number 38: nudge.vignette.Rnw:399-404 (eval = FALSE)
###################################################
## #We can also add a loess fitted mean line to the plot
## l<-loess(lRnorm~lIbar,span=0.6)
## slI<-sort(lIbar,index.return=T)
## lines(cbind(slI$x,l$fitted[slI$ix]))
## 


###################################################
### code chunk number 39: nudge.vignette.Rnw:413-428
###################################################
data(like)
#lR is the matrix or vector of log ratios to the base 2
#We get this by subtracting the log of the green intensities for each gene from the log of the red intensities for each gene (the colour assignments can be the other way also)
lR<-log(like[,1],2)-log(like[,2],2)
#lI is the matrix or vector of log intensities to the base 2
#We get this by adding the log of the green intensities for each gene from the log of the red intensities for each gene
lI<-log(like[,1],2)+log(like[,2],2)
#p is our believed value of the prior probability
p<-10/nrow(like)
#Generate a random set of labels for being differentially expressed using p
temp<-rbinom(nrow(like),1,p)
#Create a matrix of labels and use it in the nudge1 function
z<-matrix(c(1-temp,temp),nrow(like),2,byrow=F)
result<-nudge1(logratio=lR,logintensity=lI,z=z)



###################################################
### code chunk number 40: nudge.vignette.Rnw:434-454
###################################################
data(hiv)
#lR is the matrix of log ratios to the base 2
#We get this by subtracting the logs of the intensities for sample 1 for each gene from the logs of the corresponding intensities for sample 2 for each gene (by corresponding intensities we mean those paired to the same slide)
lR<-log(hiv[,1:4],2)-log(hiv[,5:8],2)
#lI is the matrix of log intensities to the base 2
#We get this by adding the logs of the intensities for sample 1 for each gene from the logs of the corresponding intensities for sample 2 for each gene (by corresponding intensities we mean those paired to the same slide)
lI<-log(hiv[,1:4],2)+log(hiv[,5:8],2)
#First we generate a random matrix with low probability of differential expression
p<-0.0001
temp<-rbinom(nrow(hiv),1,p)
z<-matrix(c(1-temp,temp),nrow(hiv),2,byrow=F)
# Now we incorporate the information
z[c(3,5,7,771,773,775,1539,1541,1543,2307,2309,2311,3859),1]<-0
z[c(3,5,7,771,773,775,1539,1541,1543,2307,2309,2311,3859),2]<-1
z[c(2348,3186,1943),1]<-0.05
z[c(2348,3186,1943),2]<-0.95
z[c(3075,3077,3079,3843,3845),1]<-1
z[c(3075,3077,3079,3843,3845),2]<-0
result<-nudge1(logratio=lR,logintensity=lI,z=z)



###################################################
### code chunk number 41: nudge.vignette.Rnw:468-473
###################################################
rm(list=ls())
data(like)
ls()
dim(like)



###################################################
### code chunk number 42: nudge.vignette.Rnw:478-485
###################################################
rm(list=ls())
data(hiv)
ls()
dim(hiv)
length(pos.contr)
length(neg.contr)



###################################################
### code chunk number 43: nudge.vignette.Rnw:500-502
###################################################
rm(list=ls())



###################################################
### code chunk number 44: nudge.vignette.Rnw:510-512
###################################################
apo<-read.csv("http://www.stat.berkeley.edu/users/terry/zarray/Data/ApoA1/rg_a1ko_morph.txt",header=T)



###################################################
### code chunk number 45: nudge.vignette.Rnw:513-515
###################################################
dim(apo)



###################################################
### code chunk number 46: nudge.vignette.Rnw:519-521
###################################################
apo[,-1]<-apo[,-1]+1



