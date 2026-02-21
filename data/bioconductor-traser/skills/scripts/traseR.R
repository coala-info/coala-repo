# Code example from 'traseR' vignette. See references/ for full tutorial.

### R code from vignette source 'traseR.Rnw'

###################################################
### code chunk number 1: style
###################################################
    BiocStyle::latex(use.unsrturl=FALSE)


###################################################
### code chunk number 2: traseR.Rnw:112-114 (eval = FALSE)
###################################################
## x=traseR(snpdb=taSNP,region=Tcell)
## print(x)


###################################################
### code chunk number 3: traseR.Rnw:117-119 (eval = FALSE)
###################################################
## x=traseR(snpdb=taSNPLD,region=Tcell)
## print(x)


###################################################
### code chunk number 4: traseR.Rnw:122-123 (eval = FALSE)
###################################################
## x=traseR(snpdb=taSNP,region=Tcell,snpdb.bg=CEU)


###################################################
### code chunk number 5: traseR.Rnw:150-155
###################################################
library(traseR)
data(taSNP)
data(Tcell)
x=traseR(taSNP,Tcell)
print(x)


###################################################
### code chunk number 6: traseR.Rnw:161-162
###################################################
plotContext(snpdb=taSNP,region=Tcell,keyword="Autoimmune")


###################################################
### code chunk number 7: traseR.Rnw:172-173
###################################################
plotPvalue(snpdb=taSNP,region=Tcell,keyword="autoimmune",plot.type="densityplot")


###################################################
### code chunk number 8: traseR.Rnw:183-184
###################################################
plotInterval(snpdb=taSNP,data.frame(chr="chrX",start=152633780,end=152737085))


###################################################
### code chunk number 9: traseR.Rnw:194-196
###################################################
x=queryKeyword(snpdb=taSNP,region=Tcell,keyword="autoimmune",returnby="SNP")
head(x)


###################################################
### code chunk number 10: traseR.Rnw:201-203
###################################################
x=queryGene(snpdb=taSNP,genes=c("AGRN","UBE2J2","SSU72"))
x


###################################################
### code chunk number 11: traseR.Rnw:208-210
###################################################
x=querySNP(snpdb=taSNP,snpid=c("rs3766178","rs880051"))
x


###################################################
### code chunk number 12: traseR.Rnw:219-220
###################################################
sessionInfo()


