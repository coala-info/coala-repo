# Code example from 'AMOUNTAIN' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## -----------------------------------------------------------------------------
library(AMOUNTAIN)
n = 100
k = 20
theta = 0.5
pp <- networkSimulation(n, k, theta)
moduleid <- pp[[3]]
netid <- 1:100
restp <- netid[-moduleid]
groupdesign <- list(moduleid,restp)
names(groupdesign) <- c('module','background')

## -----------------------------------------------------------------------------
require(qgraph)
pg <- qgraph(pp[[1]],groups=groupdesign,legend=TRUE)

## -----------------------------------------------------------------------------
n1 = 100
k1 = 20
theta1 = 0.5
n2 = 80
k2 = 10
theta2 = 0.5
ppresult <- twolayernetworkSimulation(n1,k1,theta1,n2,k2,theta2)
A <- ppresult[[3]]
pp <- ppresult[[1]]
moduleid <- pp[[3]]
netid <- 1:n1
restp <- netid[-moduleid]
pp2 <- ppresult[[2]]
moduleid2 <- pp2[[3]]
netid2 <- 1:n2
restp2 <- netid2[-moduleid2]

library(qgraph)
## labelling the groups
groupdesign <- list(moduleid,restp,(moduleid2+n1),(restp2+n1))
names(groupdesign) <- c('module1','background1','module2',
                     'background2')
twolayernet <- matrix(0,nrow=(n1+n2),ncol=(n1+n2))
twolayernet[1:n1,1:n1] <- pp[[1]]
twolayernet[(n1+1):(n1+n2),(n1+1):(n1+n2)] <- pp2[[1]]
twolayernet[1:n1,(n1+1):(n1+n2)] <- A
twolayernet[(n1+1):(n1+n2),1:n1] <- t(A)

## -----------------------------------------------------------------------------
g <- qgraph(twolayernet,groups=groupdesign,legend=TRUE)

## -----------------------------------------------------------------------------
n = 100
k = 20
theta = 0.5
pp <- networkSimulation(n,k,theta)
moduleid <- pp[[3]]
alphaset <- seq(0.1,0.9,by=0.1)
lambdaset <- 2^seq(-5,5)
## using a grid search to select lambda and alpha
Fscores <- matrix(0,nrow = length(alphaset),ncol = length(lambdaset))
for (j in 1:length(alphaset)) {
	for (k in 1:length(lambdaset)) {
		x <- moduleIdentificationGPFixSS(pp[[1]],pp[[2]],rep(1/n,n),maxiter = 500,
		                                 a=alphaset[j],lambda = lambdaset[k])
		predictedid<-which(x[[2]]!=0)
	    recall <- length(intersect(predictedid,moduleid))/length(moduleid)
		precise <- length(intersect(predictedid,moduleid))/length(predictedid)
		Fscores[j,k] <- 2*precise*recall/(precise+recall)
	}
}

## -----------------------------------------------------------------------------
persp(Fscores,theta = 45,phi = 30,col = "gray",scale = FALSE,xlab = 'alpha',ylab = 'lambda',
      zlab = 'F-score',main = 'Fscores of identified module',box = TRUE)

## -----------------------------------------------------------------------------
## network simulation is the same as before
modres <- moduleIdentificationGPFixSSTwolayer(pp[[1]],pp[[2]],rep(1/n1,n1),pp2[[1]],pp2[[2]],rep(1/n2,n2),A)
predictedid <- which(modres[[1]]!=0)
recall <- length(intersect(predictedid,moduleid))/length(moduleid)
precise <- length(intersect(predictedid,moduleid))/length(predictedid)
F1 <- 2*precise*recall/(precise+recall)
predictedid2 <- which(modres[[2]]!=0)
recall2 <- length(intersect(predictedid2,moduleid2))/length(moduleid2)
precise2 <- length(intersect(predictedid2,moduleid2))/length(predictedid2)
F2 <- 2*precise2*recall2/(precise2+recall2)

## -----------------------------------------------------------------------------
## network simulation
n = 100
k = 20
L = 5
theta = 0.5
cpl <- multilayernetworkSimulation(n,k,theta,L)
listz <- list()
for (i in 1:L){
listz[[i]] <- cpl[[i+2]]
}
moduleid <- cpl[[2]]
## use default parameters here
x <- moduleIdentificationGPFixSSMultilayer(cpl[[1]],listz,rep(1/n,n))
predictedid <- which(x[[2]]!=0)
recall <- length(intersect(predictedid,moduleid))/length(moduleid)
precise <- length(intersect(predictedid,moduleid))/length(predictedid)
Fscore <- (2*precise*recall/(precise+recall))

## ----eval=FALSE---------------------------------------------------------------
# ## binary search parameter to fix module size to 100~200
# abegin = 0.01
# aend = 0.9
# maxsize = 200
# minsize = 100
# for (i in 1:100) {
# 	x <- moduleIdentificationGPFixSS(W,z,rep(1/n,n),a=(abegin+aend)/2,lambda = 0.001,maxiter = 500)
# 	predictedid <- which(x[[2]]!=0)	
# 	if(length(predictedid) > maxsize){
# 		abegin <- (abegin+aend)/2
# 	}else if (length(predictedid) < minsize){
# 		aend <- (abegin+aend)/2
# 	}else
# 		break
# }

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

