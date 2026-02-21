# Code example from 'cfassay' vignette. See references/ for full tutorial.

### R code from vignette source 'cfassay.Rnw'

###################################################
### code chunk number 1: cfassay.Rnw:66-69
###################################################
library(CFAssay)
datatab <- read.table(system.file("doc", "expl1_cellsurvcurves.txt",
                                  package="CFAssay"), header=TRUE, sep="\t")


###################################################
### code chunk number 2: cfassay.Rnw:73-75
###################################################
names(datatab)
head(datatab, 3)  # First 3 lines


###################################################
### code chunk number 3: cfassay.Rnw:79-83 (eval = FALSE)
###################################################
## dim(datatab)
## table(datatab$cline)
## table(datatab$cline, datatab$Exp)
## table(datatab$cline, datatab$dose)


###################################################
### code chunk number 4: cfassay.Rnw:88-92
###################################################
  X <- subset(datatab, cline=="okf6TERT1")
  dim(X)
  fit <- cellsurvLQfit(X)
  print(fit)


###################################################
### code chunk number 5: fig1
###################################################
  plot(fit)
  S0 <- pes(X)$S0
  names(S0) <- pes(X)$Exp
  sfpmean(X, S0)


###################################################
### code chunk number 6: cfassay.Rnw:106-109 (eval = FALSE)
###################################################
##   pdf("okf6TERT1_experimental_plots.pdf")
##   	plotExp(fit)
##   dev.off()


###################################################
### code chunk number 7: cfassay.Rnw:113-119 (eval = FALSE)
###################################################
##   X <- subset(datatab, cline=="cal33")
##   dim(X)
##   fit <- cellsurvLQfit(X)
##   print(fit)
##   plot(fit)
##   plotExp(fit)


###################################################
### code chunk number 8: cfassay.Rnw:125-127
###################################################
  fitcomp <- cellsurvLQdiff(datatab, curvevar="cline")
  print(fitcomp)


###################################################
### code chunk number 9: fig2
###################################################
  plot(cellsurvLQfit(subset(datatab, cline=="okf6TERT1")), col=1)
  plot(cellsurvLQfit(subset(datatab, cline=="cal33")), col=2, add=TRUE)
  legend(0, 0.02, c("OKF6/TERT1", "CAL 33"), text.col=1:2)


###################################################
### code chunk number 10: cfassay.Rnw:144-146
###################################################
datatab <- read.table(system.file("doc", "exp2_2waycfa.txt", package="CFAssay"),
                      header=TRUE, sep="\t")


###################################################
### code chunk number 11: cfassay.Rnw:150-152
###################################################
names(datatab)
head(datatab, 3) # First 3 lines


###################################################
### code chunk number 12: cfassay.Rnw:156-161 (eval = FALSE)
###################################################
## dim(datatab)
## table(datatab$x5fuCis)
## table(datatab$siRNA)
## table(datatab$Exp, datatab$x5fuCis)
## table(datatab$Exp, datatab$siRNA)


###################################################
### code chunk number 13: cfassay.Rnw:166-167
###################################################
  fitcomp <- cfa2way(datatab, A="siRNA", B="x5fuCis", param="A/B")


###################################################
### code chunk number 14: cfassay.Rnw:171-172
###################################################
print(fitcomp, labels=c(A="siRNA", B="x5fuCis"))


###################################################
### code chunk number 15: cfassay.Rnw:176-179 (eval = FALSE)
###################################################
##   pdf("TwoWay_experimental_plots.pdf")
##     plotExp(fitcomp, labels=c(A="siRNA", B="x5fuCis"))
##   dev.off()


