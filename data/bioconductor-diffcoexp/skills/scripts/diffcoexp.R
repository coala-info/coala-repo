# Code example from 'diffcoexp' vignette. See references/ for full tutorial.

### R code from vignette source 'diffcoexp.Rnw'

###################################################
### code chunk number 1: diffcoexp.Rnw:89-90
###################################################
help(cor, WGCNA)


###################################################
### code chunk number 2: diffcoexp.Rnw:93-94
###################################################
help(p.adjust, stats)


###################################################
### code chunk number 3: diffcoexp.Rnw:97-98
###################################################
help(diffcoexp, diffcoexp)


###################################################
### code chunk number 4: diffcoexp.Rnw:110-112
###################################################
library(diffcoexp)
data(gse4158part)


###################################################
### code chunk number 5: diffcoexp.Rnw:114-116
###################################################
allowWGCNAThreads()
res=diffcoexp(exprs.1 = exprs.1, exprs.2 = exprs.2, r.method = "spearman" )


###################################################
### code chunk number 6: diffcoexp.Rnw:120-121
###################################################
str(res)


