# Code example from 'genArise' vignette. See references/ for full tutorial.

### R code from vignette source 'genArise.Rnw'

###################################################
### code chunk number 1: genArise.Rnw:43-44
###################################################
library(genArise)


###################################################
### code chunk number 2: genArise.Rnw:65-67
###################################################
data(Simon)
ls()


###################################################
### code chunk number 3: genArise.Rnw:83-87
###################################################
data(Simon)
datos <- attr(Simon, "spotData")
M <- log(datos$Cy3, 2) - log(datos$Cy5, 2)
imageLimma(M, 23, 24, 2, 2)


###################################################
### code chunk number 4: genArise.Rnw:109-113
###################################################
data(Simon)
datos <- attr(Simon, "spotData")
R <- log(datos$BgCy3, 2)
imageLimma(R, 23, 24, 2, 2, high = "red", low = "white")


###################################################
### code chunk number 5: genArise.Rnw:132-136
###################################################
data(Simon)
datos <- attr(Simon, "spotData")
G <- log(datos$BgCy5, 2)
imageLimma(G, 23, 24, 2, 2, low = "white", high = "green")


###################################################
### code chunk number 6: genArise.Rnw:158-160
###################################################
data(Simon)
ri.plot(Simon)


###################################################
### code chunk number 7: genArise.Rnw:174-176
###################################################
data(Simon)
ma.plot(Simon)


###################################################
### code chunk number 8: genArise.Rnw:190-192
###################################################
data(Simon)
cys.plot(Simon)


###################################################
### code chunk number 9: genArise.Rnw:215-218
###################################################
data(Simon)
c.spot <- bg.correct(Simon)
ri.plot(c.spot)


###################################################
### code chunk number 10: genArise.Rnw:243-246
###################################################
data(Simon)
n.spot <- grid.norm(mySpot = Simon, nr = 23, nc = 24)
ri.plot(n.spot)


###################################################
### code chunk number 11: genArise.Rnw:268-271
###################################################
data(Simon)
n.spot <- global.norm(mySpot = Simon)
ri.plot(n.spot)


###################################################
### code chunk number 12: genArise.Rnw:296-299
###################################################
data(Simon)
f.spot <- filter.spot(mySpot = Simon)
ri.plot(f.spot)


###################################################
### code chunk number 13: genArise.Rnw:322-325
###################################################
data(Simon)
u.spot <- spotUnique(mySpot = Simon)
ri.plot(u.spot)


###################################################
### code chunk number 14: genArise.Rnw:345-348
###################################################
data(Simon)
u.spot <- alter.unique(mySpot = Simon)
ri.plot(u.spot)


###################################################
### code chunk number 15: genArise.Rnw:368-371
###################################################
data(Simon)
u.spot <- meanUnique(mySpot = Simon)
ri.plot(u.spot)


###################################################
### code chunk number 16: genArise.Rnw:423-425
###################################################
data(WT.dataset)
Zscore.plot(WT.dataset, Zscore.min=1)


