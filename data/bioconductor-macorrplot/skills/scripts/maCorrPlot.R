# Code example from 'maCorrPlot' vignette. See references/ for full tutorial.

### R code from vignette source 'maCorrPlot.Rnw'

###################################################
### code chunk number 1: maCorrPlot.Rnw:44-45
###################################################
options(width=65)


###################################################
### code chunk number 2: maCorrPlot.Rnw:57-58
###################################################
library(maCorrPlot)


###################################################
### code chunk number 3: maCorrPlot.Rnw:61-63
###################################################
data(oligodata)
ls()


###################################################
### code chunk number 4: maCorrPlot.Rnw:66-68
###################################################
dim(datA.mas5)
datA.mas5[1:5, 1:5]


###################################################
### code chunk number 5: maCorrPlot.Rnw:74-75
###################################################
corrA.rma = CorrSample(datA.rma, np=1000, seed=213)


###################################################
### code chunk number 6: maCorrPlot.Rnw:80-81 (eval = FALSE)
###################################################
## plot(corrA.rma)


###################################################
### code chunk number 7: maCorrPlot.Rnw:86-87
###################################################
corrA.rma[1:5,]


###################################################
### code chunk number 8: maCorrPlot.Rnw:92-94
###################################################
jj = plot(corrA.rma)
print(jj)


###################################################
### code chunk number 9: maCorrPlot.Rnw:109-111
###################################################
jj = plot(corrA.rma, scatter=TRUE, curve=TRUE)
print(jj)


###################################################
### code chunk number 10: maCorrPlot.Rnw:124-125
###################################################
corrA.mas5 = CorrSample(datA.mas5, np=1000, seed=213)


###################################################
### code chunk number 11: maCorrPlot.Rnw:128-129 (eval = FALSE)
###################################################
## plot(corrA.mas5, corrA.rma, cond=c("MAS5","RMA"))


###################################################
### code chunk number 12: maCorrPlot.Rnw:134-136
###################################################
corrB.rma = CorrSample(datB.rma, np=1000, seed=214)
corrB.mas5 = CorrSample(datB.mas5, np=1000, seed=214)


###################################################
### code chunk number 13: maCorrPlot.Rnw:139-140 (eval = FALSE)
###################################################
## plot(corrA.mas5, corrA.rma, corrB.mas5, corrB.rma, cond=c("MAS5/A","RMA/A","MAS5/B","RMA/B"))


###################################################
### code chunk number 14: maCorrPlot.Rnw:143-144 (eval = FALSE)
###################################################
## plot(corrA.mas5, corrA.rma, corrB.mas5, corrB.rma, cond=list(c("MAS5","RMA","MAS5","RMA"), c("A","A","B","B")))


###################################################
### code chunk number 15: maCorrPlot.Rnw:150-152
###################################################
jj = plot(corrA.mas5, corrA.rma, cond=c("MAS5","RMA"))
print(jj)


###################################################
### code chunk number 16: maCorrPlot.Rnw:160-162
###################################################
jj = plot(corrA.mas5, corrA.rma, corrB.mas5, corrB.rma, cond=list(c("MAS5","RMA","MAS5","RMA"), c("A","A","B","B")))
print(jj)


###################################################
### code chunk number 17: maCorrPlot.Rnw:175-176
###################################################
pcntA = rowSums(datA.amp=="P")


###################################################
### code chunk number 18: maCorrPlot.Rnw:179-180
###################################################
pcntA.pairs = (pcntA[corrA.rma$ndx1]+pcntA[corrA.rma$ndx2])/2


###################################################
### code chunk number 19: maCorrPlot.Rnw:183-185
###################################################
pgrpA.pairs = cut(pcntA.pairs, c(0, 10, 20, 30), include.lowest=TRUE)
table(pgrpA.pairs)


###################################################
### code chunk number 20: maCorrPlot.Rnw:188-189 (eval = FALSE)
###################################################
## plot(corrA.rma, groups=pgrpA.pairs, auto.key=TRUE)


###################################################
### code chunk number 21: maCorrPlot.Rnw:197-200
###################################################
par(mfrow=c(1,2))
hist(pcntA, main="(a) pcntA", xlab="No. of present calls")
hist(pcntA.pairs, main="(b) pcntA.pairs", xlab="Average no. of present calls")


###################################################
### code chunk number 22: maCorrPlot.Rnw:208-210
###################################################
jj = plot(corrA.rma, groups=pgrpA.pairs, auto.key=TRUE)
print(jj)


###################################################
### code chunk number 23: maCorrPlot.Rnw:222-224
###################################################
jj = plot(corrA.mas5, corrA.rma, cond=c("MAS5","RMA"), groups=list(pgrpA.pairs, pgrpA.pairs), nint=5, ylim=c(-0.25, 0.4))
print(jj)


