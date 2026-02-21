# Code example from 'flowMeans' vignette. See references/ for full tutorial.

### R code from vignette source 'flowMeans.Rnw'

###################################################
### code chunk number 1: stage0
###################################################
library(flowMeans)


###################################################
### code chunk number 2: stage1
###################################################
data(x)
res <- flowMeans(x, varNames=c("FL1.H", "FL2.H", "FL3.H", "FL4.H"), 
                 MaxN=10)


###################################################
### code chunk number 3: stage2
###################################################
plot(x[,c(3,4)], col=res@Labels[[1]], pch=20);


###################################################
### code chunk number 4: stage3
###################################################
plot(res@Mins, xlab='Iteration', ylab='Distance')


###################################################
### code chunk number 5: stage4
###################################################
plot(res@Mins, xlab=' ', ylab=' ', xlim=c(1, res@MaxN), 
     ylim=c(0, max(res@Mins)))
ft<-changepointDetection(res@Mins)
abline(ft$l1)
abline(ft$l2);
par(new=TRUE)
plot(ft$MinIndex+1, res@Mins[ft$MinIndex+1], col='red', xlab='Iteration', ylab='Distance', xlim=c(1, res@MaxN), ylim=c(0, max(res@Mins)), pch=19);


###################################################
### code chunk number 6: stage5
###################################################
plot(x, res, c("FL1.H", "FL2.H"))


###################################################
### code chunk number 7: stage6
###################################################
plot(x, res, c("FL1.H", "FL2.H","FL3.H", "FL4.H"),pch='.')


