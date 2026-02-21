# Code example from 'GeneSelector' vignette. See references/ for full tutorial.

### R code from vignette source 'GeneSelector.rnw'

###################################################
### code chunk number 1: preliminaries
###################################################
library(GeneSelector)


###################################################
### code chunk number 2: preliminaries
###################################################
library(GeneSelector)


###################################################
### code chunk number 3: GeneSelector.rnw:119-124
###################################################
data(toydata)
y <- as.numeric(toydata[1,])
x <- as.matrix(toydata[-1,])
dim(x)
table(y)


###################################################
### code chunk number 4: GeneSelector.rnw:130-132
###################################################
par(mfrow=c(2,2))
for(i in 1:4) boxplot(x[i,]~y, main=paste("Gene", i))


###################################################
### code chunk number 5: GeneSelector.rnw:141-142
###################################################
ordT <- RankingTstat(x, y, type="unpaired")


###################################################
### code chunk number 6: GeneSelector.rnw:148-155
###################################################

getSlots("GeneRanking")
str(ordT)

show(ordT)
toplist(ordT)



###################################################
### code chunk number 7: GeneSelector.rnw:168-170
###################################################
loo <- GenerateFoldMatrix(y = y, k=1)
show(loo)


###################################################
### code chunk number 8: GeneSelector.rnw:176-179
###################################################

loor_ordT <- RepeatRanking(ordT, loo)



###################################################
### code chunk number 9: GeneSelector.rnw:184-187
###################################################

ex1r_ordT <- RepeatRanking(ordT, loo, scheme = "labelexchange")



###################################################
### code chunk number 10: GeneSelector.rnw:194-199
###################################################

boot <- GenerateBootMatrix(y = y, maxties=3, minclassize=5, repl=30)
show(boot)
boot_ordT <- RepeatRanking(ordT, boot)



###################################################
### code chunk number 11: GeneSelector.rnw:203-204
###################################################
noise_ordT <- RepeatRanking(ordT, varlist=list(genewise=TRUE, factor=1/10))


###################################################
### code chunk number 12: GeneSelector.rnw:209-210
###################################################
toplist(loor_ordT, show=FALSE)


###################################################
### code chunk number 13: GeneSelector.rnw:219-224
###################################################
par(mfrow=c(2,2))
plot(loor_ordT, col="blue", pch=".", cex=2.5, main = "jackknife")
plot(ex1r_ordT, col="blue", pch=".", cex=2.5, main = "label exchange")
plot(boot_ordT, col="blue", pch=".", cex=2.5, main = "bootstrap")
plot(noise_ordT, frac=1/10, col="blue", pch=".", cex=2.5, main = "noise")


###################################################
### code chunk number 14: GeneSelector.rnw:320-325
###################################################

stab_ex1r_ordT <- GetStabilityOverlap(ex1r_ordT, scheme = "original",
decay="linear")
show(stab_ex1r_ordT)



###################################################
### code chunk number 15: GeneSelector.rnw:332-336
###################################################

summary(stab_ex1r_ordT, measure = "intersection", display = "all", position = 10)
summary(stab_ex1r_ordT, measure = "overlapscore", display = "all", position = 10)



###################################################
### code chunk number 16: GeneSelector.rnw:351-352
###################################################
plot(stab_ex1r_ordT, frac = 1, mode = "mean")


###################################################
### code chunk number 17: GeneSelector.rnw:363-369
###################################################

stab_loo_ordT <- GetStabilityDistance(ex1r_ordT, scheme = "original", measure
= "spearman", decay="linear")
show(stab_loo_ordT)
summary(stab_loo_ordT, display = "all")



###################################################
### code chunk number 18: GeneSelector.rnw:380-385
###################################################
BaldiLongT <- RankingBaldiLong(x, y, type="unpaired")
FoxDimmicT <- RankingFoxDimmic(x, y, type="unpaired")
sam <- RankingSam(x, y, type="unpaired")
wilcox <- RankingWilcoxon(x, y, type="unpaired")
wilcoxeb <- RankingWilcEbam(x, y, type="unpaired")


###################################################
### code chunk number 19: GeneSelector.rnw:393-396
###################################################
Merged <- MergeMethods(list(ordT, BaldiLongT, FoxDimmicT, sam, wilcox, wilcoxeb))
HeatmapRankings(Merged, ind=1:40)



###################################################
### code chunk number 20: GeneSelector.rnw:409-420
###################################################

AggMean <- AggregateSimple(Merged, measure = "mean")
AggMC <- AggregateMC(Merged, type = "MCT", maxrank = 100)
GeneSel <- GeneSelector(list(ordT, BaldiLongT, FoxDimmicT, sam, wilcox,
wilcoxeb), threshold="user", maxrank=50)
show(GeneSel)
sel <- sum(slot(GeneSel, "selected"))

cbind(mean = toplist(AggMean, top = sel, show = F), MC = toplist(AggMC, top
= sel, show = F), GeneSelector = toplist(GeneSel, top = sel, show = F)[,1])



###################################################
### code chunk number 21: GeneSelector.rnw:436-439
###################################################

plot(GeneSel, which = 1)
    


