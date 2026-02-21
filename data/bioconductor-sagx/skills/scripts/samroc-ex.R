# Code example from 'samroc-ex' vignette. See references/ for full tutorial.

### R code from vignette source 'samroc-ex.Rnw'

###################################################
### code chunk number 1: samroc-ex.Rnw:63-69
###################################################
library("SAGx")
library("multtest")
data(golub)
set.seed(849867)
samroc.res <- samrocN(data = golub, formula = ~as.factor(golub.cl))
show(samroc.res)


###################################################
### code chunk number 2: dummyex3 (eval = FALSE)
###################################################
## plot(samroc.res)


###################################################
### code chunk number 3: samroc-ex.Rnw:83-85
###################################################
par(bg = "cornsilk")
plot(samroc.res)


###################################################
### code chunk number 4: samroc-ex.Rnw:99-102
###################################################
par(bg = "cornsilk")
hist(samroc.res@pvalues, xlab = "p-value", main ="", col = 'orange', freq  = F)
print(abline(samroc.res@p0,0, col = 'red'))


###################################################
### code chunk number 5: samroc-ex.Rnw:110-116
###################################################
par(bg = "cornsilk")
fdrs <- pava.fdr(ps = samroc.res@pvalues)
plot(samroc.res@pvalues, fdrs$pava.local.fdr, type = 'n', xlab = "p-value", ylab = "False Discovery Rate (FDR)")
lines(lowess(samroc.res@pvalues, fdrs$pava.local.fdr), col = 'red')
lines(lowess(samroc.res@pvalues, fdrs$pava.fdr), col = 'blue')
legend(0.1,0.9,pch=NULL,col=c("red","blue"),c("pava local FDR","pava FDR"),lty = 1)


###################################################
### code chunk number 6: samroc-ex.Rnw:127-133
###################################################
library("hu6800.db")
kegg <- as.list(hu6800PATH2PROBE)
probeset <- golub.gnames[,3]
GSEA.mean.t(samroc = samroc.res, probeset = probeset, pway = kegg[1],
type = "original", two.side = FALSE)



