# Code example from 'mitoODE-introduction' vignette. See references/ for full tutorial.

### R code from vignette source 'mitoODE-introduction.Rnw'

###################################################
### code chunk number 1: mitoODE-introduction.Rnw:159-160
###################################################
options(width=80)


###################################################
### code chunk number 2: plotspot
###################################################
library("mitoODE")
spotid <- 1000
plotspot(spotid)
y <- readspot(spotid)
y[1:5,]


###################################################
### code chunk number 3: pconst
###################################################
pconst <- c(g.kim=0.025, g.kmi=0.57, g.mit0=0.05, p.lambda=4)


###################################################
### code chunk number 4: <p0
###################################################
p0 <- getp0()
p0


###################################################
### code chunk number 5: <p0
###################################################
pp1 <- fitmodel(y, p0, pconst)
round(pp1, 2)


###################################################
### code chunk number 6: plotfit
###################################################
plotfit(spotid, pp1)


###################################################
### code chunk number 7: <fitmodel4
###################################################
set.seed(1)
pp2 <- fitmodel(y, p0, pconst, nfits=4, sd=0.1)
round(pp2, 2)


###################################################
### code chunk number 8: plotfigures
###################################################
loadFittedData()
figure1()
figure2()
figure3a()
figure3b()
figure4()


