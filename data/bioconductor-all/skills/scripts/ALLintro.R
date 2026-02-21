# Code example from 'ALLintro' vignette. See references/ for full tutorial.

### R code from vignette source 'ALLintro.Rnw'

###################################################
### code chunk number 1: ALLintro.Rnw:51-54
###################################################
library(ALL)
data(ALL)
show(ALL)


###################################################
### code chunk number 2: ALLintro.Rnw:57-58
###################################################
print(summary(pData(ALL)))


###################################################
### code chunk number 3: ALLintro.Rnw:59-60
###################################################
hist(cvv <- apply(exprs(ALL),1,function(x)sd(x)/mean(x)))


###################################################
### code chunk number 4: ALLintro.Rnw:61-66
###################################################
ok <- cvv > .08 & cvv < .18
fALL <- ALL[ok,]
show(fALL)

allx2 <- data.frame(t(exprs(fALL)), class=ALL$BT)


###################################################
### code chunk number 5: ALLintro.Rnw:68-72
###################################################
library(rpart)
rp1 <- rpart(class~.,data=allx2)
plot(rp1)
text(rp1)


