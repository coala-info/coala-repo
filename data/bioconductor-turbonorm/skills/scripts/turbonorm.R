# Code example from 'turbonorm' vignette. See references/ for full tutorial.

### R code from vignette source 'turbonorm.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: code1
###################################################
library(TurboNorm)
funky <- function(x) sin(2*pi*x^3)^3
m <- 100
x <- seq(0, 1, length=m)
y <- funky(x) + rnorm(m, 0, 0.1)


###################################################
### code chunk number 3: code2
###################################################
plot(x, y, type='p', xlab="", ylab="")
curve(funky, add=TRUE)
fitOrig <- turbotrend(x, y, n=15, method="original")
lines(fitOrig, col="green", type='b', pch=1)


###################################################
### code chunk number 4: code3
###################################################
fitOrig


###################################################
### code chunk number 5: code4
###################################################
library(marray)
data(swirl)
x <- pspline(swirl, showArrays=2, pch=20, col="grey")


###################################################
### code chunk number 6: code5
###################################################
library(TurboNorm)
data(methylation)
indices <- methylation$weights[,1]
weights <- rep(1, length(indices))
weights[indices] <- length(indices)/sum(indices)
MA <- normalizeWithinArrays(methylation, method="none", bc.method="none")
labels <- paste("NMB", c("(untreated)", "(treated)"))
labels <- paste(rep(c("Raw"), each=2), labels)


###################################################
### code chunk number 7: code6
###################################################
data <- data.frame(M=as.vector(MA$M),
A=as.vector(MA$A),
Array=factor(rep(labels, each=nrow(MA$A)), levels=rev(labels)))
library(lattice)
print(xyplot(M~A|Array, xlab="", ylab="", data=data, type='g',
panel = function(x, y) {
  panel.xyplot(x, y, col="grey")
  lpoints(x[indices], y[indices], pch=20, col="black")
  panel.pspline(x, y, weights = weights, col="red", lwd=2)
  panel.loess(x, y, col="green", lwd=2)
}))


###################################################
### code chunk number 8: code7
###################################################
toLatex(sessionInfo())


