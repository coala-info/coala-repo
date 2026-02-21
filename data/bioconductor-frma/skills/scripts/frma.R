# Code example from 'frma' vignette. See references/ for full tutorial.

### R code from vignette source 'frma.Rnw'

###################################################
### code chunk number 1: frma.Rnw:106-107
###################################################
library(frma)


###################################################
### code chunk number 2: frma.Rnw:116-118
###################################################
library(frmaExampleData)
data(AffyBatchExample)


###################################################
### code chunk number 3: frma.Rnw:121-122
###################################################
object <- frma(AffyBatchExample)


###################################################
### code chunk number 4: frma.Rnw:131-132
###################################################
e <- exprs(object)


###################################################
### code chunk number 5: frma.Rnw:136-137
###################################################
GNUSE(object,type="stats")


###################################################
### code chunk number 6: frma.Rnw:267-268
###################################################
library(frma)


###################################################
### code chunk number 7: frma.Rnw:271-274
###################################################
library(frmaExampleData)
data(AffyBatchExample)
object <- frma(AffyBatchExample)


###################################################
### code chunk number 8: frma.Rnw:277-278
###################################################
bc <- barcode(object)


