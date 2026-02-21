# Code example from 'copa' vignette. See references/ for full tutorial.

### R code from vignette source 'copa.Rnw'

###################################################
### code chunk number 1: copa.Rnw:96-100
###################################################
library(copa)
library(colonCA)
data(colonCA)
head(pData(colonCA), 10)


###################################################
### code chunk number 2: copa.Rnw:116-117
###################################################
rslt <- copa(colonCA, as.numeric(pData(colonCA)[,3]))


###################################################
### code chunk number 3: copa.Rnw:122-123 (eval = FALSE)
###################################################
## plotCopa(rslt, idx = 1, col = c("lightgreen","salmon"))


###################################################
### code chunk number 4: copa.Rnw:128-129
###################################################
plotCopa(rslt, idx = 1, col = c("lightgreen","salmon"))


###################################################
### code chunk number 5: copa.Rnw:146-147
###################################################
tableCopa(rslt)


###################################################
### code chunk number 6: copa.Rnw:154-155
###################################################
summaryCopa(rslt, 9)


###################################################
### code chunk number 7: copa.Rnw:170-172
###################################################
prm <- copaPerm(colonCA, rslt, 9, 24)
sum(prm >= 9)


