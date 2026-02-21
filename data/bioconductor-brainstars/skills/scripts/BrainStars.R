# Code example from 'BrainStars' vignette. See references/ for full tutorial.

### R code from vignette source 'BrainStars.Rnw'

###################################################
### code chunk number 1: BrainStars.Rnw:70-71
###################################################
library("BrainStars")


###################################################
### code chunk number 2: BrainStars.Rnw:76-77
###################################################
my.eset <- getBrainStars(query = "1439627_at", type = "expression")


###################################################
### code chunk number 3: BrainStars.Rnw:83-86
###################################################
ids <- c("1439627_at", "1439631_at", "1439633_at")
my.esets <- getBrainStars(query = ids, type = "expression")
my.esets


###################################################
### code chunk number 4: BrainStars.Rnw:90-91
###################################################
my.mat <- exprs(my.esets)


###################################################
### code chunk number 5: BrainStars.Rnw:96-97
###################################################
my.ann <- getBrainStars(query = "1439627_at", type = "probeset")


###################################################
### code chunk number 6: BrainStars.Rnw:103-107
###################################################
getBrainStarsFigure("1439627_at", "exprgraph",   "png")
getBrainStarsFigure("1439627_at", "exprmap",     "png")
getBrainStarsFigure("1439627_at", "switchgraph", "pdf")
getBrainStarsFigure("1439627_at", "switchhist",  "png")


###################################################
### code chunk number 7: BrainStars.Rnw:132-134
###################################################
recep.mat   <- getBrainStars(query = "receptor/10,5",  type = "search")
recep.count <- getBrainStars(query = "receptor/count", type = "search")


###################################################
### code chunk number 8: BrainStars.Rnw:143-144
###################################################
mk.genes.count <- getBrainStars(query = "high/LS/count", type = "marker")


###################################################
### code chunk number 9: BrainStars.Rnw:149-150
###################################################
ms.genes.list <- getBrainStars(query = "low/SCN/all", type = "multistate")


###################################################
### code chunk number 10: BrainStars.Rnw:154-155
###################################################
os.genes.count <- getBrainStars(query = "count", type = "onestate")


###################################################
### code chunk number 11: BrainStars.Rnw:160-163
###################################################
gfc.genes1.count <- getBrainStars(query = "tf//count",         type = "genefamily")
gfc.genes2.list  <- getBrainStars(query = "tf/terminal/all",   type = "genefamily")
gfc.genes3.count <- getBrainStars(query = "tf/terminal/count", type = "genefamily")


###################################################
### code chunk number 12: BrainStars.Rnw:168-169
###################################################
os.genes <- getBrainStars(query = "high/SCN/ME/all", type = "ntnh")


