# Code example from 'kidpack' vignette. See references/ for full tutorial.

### R code from vignette source 'kidpack.Rnw'

###################################################
### code chunk number 1: start1
###################################################
library(kidpack)


###################################################
### code chunk number 2: start2
###################################################
data(eset)
data(cloneanno)


###################################################
### code chunk number 3: kidpack.Rnw:66-69
###################################################
unique(pData(eset)$type)
cols <- c("red", "blue", "darkgreen")
names(cols) <- c("ccRCC", "pRCC", "chRCC")


###################################################
### code chunk number 4: fn1
###################################################
sel <- grep("fibronectin 1", cloneanno$description)
cloneanno[sel, ]


###################################################
### code chunk number 5: fn2
###################################################
eo <- eset[sel, order(pData(eset)$type)]
x  <- exprs(eo)
plot(c(1, ncol(x)), range(x), type="n")
for(i in 1:nrow(x))
  points(x[i, ], col=cols[pData(eo)$type], pch=16)


###################################################
### code chunk number 6: kidpack.Rnw:91-99
###################################################
data(qua)
data(hybanno)
data(spotanno)
s1 <- cloneanno$spot1[sel]
s2 <- cloneanno$spot2[sel]
s1
qua[s1, "fg.green", 1:3]
hybanno[1:3,]


