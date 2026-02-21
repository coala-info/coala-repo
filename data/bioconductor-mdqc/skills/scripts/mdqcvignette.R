# Code example from 'mdqcvignette' vignette. See references/ for full tutorial.

### R code from vignette source 'mdqcvignette.Rnw'

###################################################
### code chunk number 1: mdqcvignette.Rnw:84-88
###################################################
library(mdqc)
data(allQC)
dim(allQC)
allQC[1:2,]


###################################################
### code chunk number 2: mdqcvignette.Rnw:96-100
###################################################
mdout <- mdqc(allQC, method="nogroups") 
plot(mdout) 
print(mdout)
summary(mdout)


###################################################
### code chunk number 3: mdqcvignette.Rnw:105-106
###################################################
plot(mdout)


###################################################
### code chunk number 4: mdqcvignette.Rnw:144-147
###################################################
mdout <- mdqc(allQC, method="apriori",
              groups=list(1:5, 6:9, 10:11))
plot(mdout) 


###################################################
### code chunk number 5: mdqcvignette.Rnw:152-153
###################################################
plot(mdout)


###################################################
### code chunk number 6: mdqcvignette.Rnw:203-206
###################################################
mdout <- mdqc(allQC, method="cluster", k=3)
plot(mdout) 
print(mdout)


###################################################
### code chunk number 7: mdqcvignette.Rnw:211-212
###################################################
plot(mdout)


###################################################
### code chunk number 8: mdqcvignette.Rnw:231-234
###################################################
mdout <- mdqc(allQC, method="loading", k=3, pc=4)
plot(mdout)
print(mdout)


###################################################
### code chunk number 9: mdqcvignette.Rnw:253-255
###################################################
mdout <- mdqc(allQC, method="global", pc=4)
plot(mdout) 


###################################################
### code chunk number 10: mdqcvignette.Rnw:260-261
###################################################
plot(mdout)


