# Code example from 'OutlierD' vignette. See references/ for full tutorial.

### R code from vignette source 'OutlierD.Rnw'

###################################################
### code chunk number 1: OutlierD.Rnw:89-93
###################################################
library(OutlierD)
data(lcms)
x <- log2(lcms) 
dim(x)


###################################################
### code chunk number 2: OutlierD.Rnw:100-104
###################################################
fit1 <- OutlierD(x1=x[,1], x2=x[,2], k=1.5, method="constant")
fit2 <- OutlierD(x1=x[,1], x2=x[,2], k=1.5, method="linear")
fit3 <- OutlierD(x1=x[,1], x2=x[,2], k=1.5, method="nonlin")
fit4 <- OutlierD(x1=x[,1], x2=x[,2], k=1.5, method="nonpar")


###################################################
### code chunk number 3: OutlierD.Rnw:113-137
###################################################
par(mfrow=c(2,2), pty="s")
plot(fit1$x$A, fit1$x$M, pch=".", xlab="A", ylab="M")
i <- sort.list(fit1$x$A)
lines(fit1$x$A[i], fit1$x$Q3[i], lty=2); lines(fit1$x$A[i], fit1$x$Q1[i], lty=2)
lines(fit1$x$A[i], fit1$x$LB[i]); lines(fit1$x$A[i], fit1$x$UB[i])
title("Constant")

plot(fit2$x$A, fit2$x$M, pch=".", xlab="A", ylab="M")
i <- sort.list(fit2$x$A)
lines(fit2$x$A[i], fit2$x$Q3[i], lty=2); lines(fit2$x$A[i], fit2$x$Q1[i], lty=2)
lines(fit2$x$A[i], fit2$x$LB[i]); lines(fit2$x$A[i], fit2$x$UB[i])
title("Linear")

plot(fit3$x$A, fit3$x$M, pch=".", xlab="A", ylab="M")
i <- sort.list(fit3$x$A)
lines(fit3$x$A[i], fit3$x$Q3[i], lty=2); lines(fit3$x$A[i], fit3$x$Q1[i], lty=2)
lines(fit3$x$A[i], fit3$x$LB[i]); lines(fit3$x$A[i], fit3$x$UB[i])
title("Nonlinear")

plot(fit4$x$A, fit4$x$M, pch=".", xlab="A", ylab="M")
i <- sort.list(fit4$x$A)
lines(fit4$x$A[i], fit4$x$Q3[i], lty=2); lines(fit4$x$A[i], fit4$x$Q1[i], lty=2)
lines(fit4$x$A[i], fit4$x$LB[i]); lines(fit4$x$A[i], fit4$x$UB[i])
title("Nonparametric")


###################################################
### code chunk number 4: OutlierD.Rnw:145-148
###################################################
fit3$n.outliers
dim(fit3$x)
head(fit3$x)


