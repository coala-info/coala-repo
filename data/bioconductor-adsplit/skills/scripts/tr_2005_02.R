# Code example from 'tr_2005_02' vignette. See references/ for full tutorial.

### R code from vignette source 'tr_2005_02.Rnw'

###################################################
### code chunk number 1: tr_2005_02.Rnw:42-50
###################################################
library(golubEsets)
oldopt <- options(digits=3)
on.exit( {options(oldopt)} )
options(width=70)
if (interactive()) { 
    options(error=recover)
}
set.seed(123)


###################################################
### code chunk number 2: tr_2005_02.Rnw:149-150
###################################################
library(adSplit) 


###################################################
### code chunk number 3: tr_2005_02.Rnw:158-160
###################################################
library(golubEsets) 
data(Golub_Merge) 


###################################################
### code chunk number 4: tr_2005_02.Rnw:184-190
###################################################
e <- exprs(Golub_Merge)
vars <- apply(e, 1, var)
e <- e[vars > quantile(vars,0.9),]

diana2means(e)
diana2means(e, return.cut=TRUE)


###################################################
### code chunk number 5: tr_2005_02.Rnw:199-201
###################################################
x <- diana2means(e, return.cut=TRUE)
x$cut


###################################################
### code chunk number 6: tr_2005_02.Rnw:217-218
###################################################
adSplit(Golub_Merge, "GO:0006915", "hu6800")


###################################################
### code chunk number 7: tr_2005_02.Rnw:231-232
###################################################
adSplit(Golub_Merge, "GO:0007165", "hu6800")


###################################################
### code chunk number 8: tr_2005_02.Rnw:240-241
###################################################
adSplit(Golub_Merge, "GO:0007165", "hu6800", max.probes=7000)


###################################################
### code chunk number 9: tr_2005_02.Rnw:286-287
###################################################
EID2PSenv <- makeEID2PROBESenv(hu6800ENTREZID)


###################################################
### code chunk number 10: tr_2005_02.Rnw:293-294
###################################################
drawRandomPS(10, EID2PSenv, ls(EID2PSenv))


###################################################
### code chunk number 11: tr_2005_02.Rnw:308-309
###################################################
scores <- randomDiana2means(20, exprs(Golub_Merge), "hu6800", ndraws = 1000) 


###################################################
### code chunk number 12: tr_2005_02.Rnw:319-324
###################################################
scores2 <- randomDiana2means(20, exprs(Golub_Merge), "hu6800", 
                            ndraws = 1000, ignore.genes=5) 
par(mfrow=c(1,2))
hist(scores,  nclass=30, main="", col="grey")
hist(scores2, nclass=30, main="", col="grey")


###################################################
### code chunk number 13: tr_2005_02.Rnw:337-338
###################################################
glutamSplits <- adSplit(Golub_Merge, "KEGG:00251", "hu6800", B=1000) 


###################################################
### code chunk number 14: tr_2005_02.Rnw:346-347
###################################################
print(glutamSplits)


###################################################
### code chunk number 15: tr_2005_02.Rnw:360-362
###################################################
x <- adSplit(Golub_Merge, c("GO:0007165","GO:0006915"), "hu6800", max.probes=7000)
print(x)


###################################################
### code chunk number 16: tr_2005_02.Rnw:378-379
###################################################
x <- adSplit(Golub_Merge, "KEGG", "hu6800")


###################################################
### code chunk number 17: tr_2005_02.Rnw:381-382
###################################################
print(x)


###################################################
### code chunk number 18: tr_2005_02.Rnw:387-390
###################################################
data(golubKEGGSplits)
print(golubKEGGSplits)
summary(golubKEGGSplits$qvalues)


###################################################
### code chunk number 19: tr_2005_02.Rnw:421-423
###################################################
data(golubKEGGSplits)
hist(golubKEGGSplits)


###################################################
### code chunk number 20: tr_2005_02.Rnw:437-438
###################################################
image(golubKEGGSplits, filter.fdr=0.3, outfile="splitSet.eps", res=300)


