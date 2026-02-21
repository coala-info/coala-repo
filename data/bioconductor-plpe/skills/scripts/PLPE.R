# Code example from 'PLPE' vignette. See references/ for full tutorial.

### R code from vignette source 'PLPE.Rnw'

###################################################
### code chunk number 1: PLPE.Rnw:111-119
###################################################
library(PLPE)
data(plateletSet)
x <- exprs(plateletSet)
x <- log2(x) #and any normalization

cond <- c(1, 2, 1, 2, 1, 2)   #two different samples
pair <- c(1, 1, 2, 2, 3, 3)   #pairing
design <- cbind(cond, pair)


###################################################
### code chunk number 2: PLPE.Rnw:128-136
###################################################
out <- lpe.paired(x=x, design=design, q=0.1,data.type="ms") #Compute test statistics

out.fdr <- lpe.paired.fdr(x, obj=out) #Compute FDRs

out$test.out[1:10,]

out.fdr$FDR[1:10,]



