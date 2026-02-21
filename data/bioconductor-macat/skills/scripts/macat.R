# Code example from 'macat' vignette. See references/ for full tutorial.

### R code from vignette source 'macat.Rnw'

###################################################
### code chunk number 1: macat.Rnw:468-471
###################################################
library(macat)
loaddatapkg("stjudem")
data(stjude)


###################################################
### code chunk number 2: macat.Rnw:478-479
###################################################
summary(stjude)


###################################################
### code chunk number 3: macat.Rnw:482-483
###################################################
stjude$geneName[1:10]


###################################################
### code chunk number 4: macat.Rnw:486-488
###################################################
unique(stjude$labels)
table(stjude$labels)


###################################################
### code chunk number 5: macat.Rnw:492-493
###################################################
sum(stjude$chromosome==1)


###################################################
### code chunk number 6: macat.Rnw:497-498 (eval = FALSE)
###################################################
## plotSliding(stjude, 6, sample=3, kernel=rbf)


###################################################
### code chunk number 7: macat.Rnw:520-522 (eval = FALSE)
###################################################
## evalkNN6 = evaluateParameters(stjude, class="T", chromosome=6, kernel=kNN,
##                               paramMultipliers=c(0.01,seq(0.1,2.0,0.1),2.5))


