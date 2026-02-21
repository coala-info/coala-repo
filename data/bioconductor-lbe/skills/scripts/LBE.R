# Code example from 'LBE' vignette. See references/ for full tutorial.

### R code from vignette source 'LBE.Rnw'

###################################################
### code chunk number 1: LBE.Rnw:67-69
###################################################
library(LBE)
data(golub.pval)


###################################################
### code chunk number 2: LBE.Rnw:106-107
###################################################
LBE.res <- LBE(golub.pval)


###################################################
### code chunk number 3: LBE.Rnw:112-117
###################################################
#LBE.res <- LBE(golub.pval)
names(LBE.res)
LBE.res$pi0; LBE.res$pi0.ci; LBE.res$ci.level
LBE.res2 <- LBE(golub.pval, ci.level=0.8,plot.type="none")
LBE.res2$pi0.ci; LBE.res2$ci.level


###################################################
### code chunk number 4: LBE.Rnw:128-131
###################################################
LBE.res3 <- LBE(golub.pval, FDR.level=0.1,plot.type="none")
LBE.res3$qvalues[1:10]
LBE.res3$n.significant


###################################################
### code chunk number 5: LBE.Rnw:135-136
###################################################
LBE.res4 <- LBE(golub.pval,FDR.level=NA,n.significant=300)


###################################################
### code chunk number 6: LBE.Rnw:141-142
###################################################
LBE.res4$qvalues[1:10]


###################################################
### code chunk number 7: LBE.Rnw:155-161
###################################################
LBE.res5 <- LBE(golub.pval,a=2,l=NA,plot.type="none")
LBE.res5$a; LBE.res5$l; LBE.res5$pi0; LBE.res5$pi0.ci; LBE.res5$n.significant
LBE.res6 <- LBE(golub.pval,a=NA,l=0.1,plot.type="none")
LBE.res6$a; LBE.res6$l; LBE.res6$pi0; LBE.res6$pi0.ci; LBE.res6$n.significant
LBE.res7 <- LBE(golub.pval,a=-1,l=NA,plot.type="none")
LBE.res7$a; LBE.res7$l; LBE.res7$pi0; LBE.res7$pi0.ci; LBE.res7$n.significant


###################################################
### code chunk number 8: LBE.Rnw:173-174
###################################################
LBEplot(LBE.res,plot.type="multiple")


###################################################
### code chunk number 9: LBE.Rnw:187-188
###################################################
LBEa(length(golub.pval),l=0.1)


###################################################
### code chunk number 10: LBE.Rnw:198-199
###################################################
LBEsummary(LBE.res)


###################################################
### code chunk number 11: LBE.Rnw:206-207
###################################################
LBEwrite(LBE.res)


###################################################
### code chunk number 12: LBE.Rnw:219-223
###################################################
library(qvalue)
qvalue.res <- qvalue(golub.pval)
summary(qvalue.res)
LBEsummary(LBE.res)


