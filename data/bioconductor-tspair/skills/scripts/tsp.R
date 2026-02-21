# Code example from 'tsp' vignette. See references/ for full tutorial.

### R code from vignette source 'tsp.Rnw'

###################################################
### code chunk number 1: tsp.Rnw:55-58
###################################################
library(tspair)
data(tspdata)
dim(dat)


###################################################
### code chunk number 2: tsp.Rnw:66-68
###################################################
tsp1 <- tspcalc(dat,grp)
tsp1


###################################################
### code chunk number 3: tsp.Rnw:75-77
###################################################
tsp2 <- tspcalc(eSet1,grp)
tsp3 <- tspcalc(eSet1,1)


###################################################
### code chunk number 4: tsp.Rnw:84-85
###################################################
tspplot(tsp1)


###################################################
### code chunk number 5: tsp.Rnw:95-98
###################################################
out <- tspsig(dat,grp,B=50,seed=12355)
out$p
out$nullscores


###################################################
### code chunk number 6: tsp.Rnw:106-107
###################################################
summary(tsp1,printall=TRUE) 


###################################################
### code chunk number 7: tsp.Rnw:112-114
###################################################
predict(tsp1,eSet2)
predict(tsp1,dat2)


###################################################
### code chunk number 8: tsp.Rnw:121-133
###################################################
narrays <- ncol(dat)
correct.prediction <- rep(TRUE,narrays)

for(i in 1:narrays){
	testdat <- dat[ , -i]
	testgrp <- grp[-i]
	tsptest <- tspcalc(testdat,testgrp)
	prediction <- predict(tsptest,dat)[i]
	correct.prediction[i] <- prediction == grp[i]
}
cv.error <- mean(correct.prediction==FALSE)
cv.error


