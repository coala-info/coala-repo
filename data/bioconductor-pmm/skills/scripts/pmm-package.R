# Code example from 'pmm-package' vignette. See references/ for full tutorial.

### R code from vignette source 'pmm-package.Rnw'

###################################################
### code chunk number 1: data
###################################################
library(pmm)
data(kinome)
head(kinome)


###################################################
### code chunk number 2: fit.pmm.simple
###################################################
fit1 <- pmm(kinome, "InfectionIndex", gene.col = "GeneName",
condition.col = "condition")
head(fit1)


###################################################
### code chunk number 3: fit.pmm.nonsimple
###################################################
fit2 <- pmm(kinome, "InfectionIndex", gene.col = "GeneName",
condition.col = "condition", simplify = FALSE)
class(fit2)
names(fit2)
identical(fit1,fit2[[1]])


###################################################
### code chunk number 4: fit.pmm.NAs
###################################################
kinome$InfectionIndex[kinome$GeneName == "AAK1" &
    kinome$condition == "ADENO"] <- rep(NA,12)
fit3 <- pmm(kinome ,"InfectionIndex", gene.col = "GeneName")
head(fit3,3)


###################################################
### code chunk number 5: plotex1
###################################################
hitheatmap(fit1, threshold = 0.2)


###################################################
### code chunk number 6: pmm-package.Rnw:202-203
###################################################
hitheatmap(fit1, threshold = 0.2)


###################################################
### code chunk number 7: plotex2
###################################################
hitheatmap(fit1, threshold = 0.4, cex.main = 2,
main = "My modified plot", col.main = "white",
col.axis = "white", cex.axis = 0.8, bg = "black", mar = c(6,8,4,6))


###################################################
### code chunk number 8: pmm-package.Rnw:227-228
###################################################
hitheatmap(fit1, threshold = 0.4, cex.main = 2,
main = "My modified plot", col.main = "white",
col.axis = "white", cex.axis = 0.8, bg = "black", mar = c(6,8,4,6))


###################################################
### code chunk number 9: sharedness.fit
###################################################
sh <- sharedness(fit1, threshold = 0.2)
sh[order(sh$Sharedness),]


###################################################
### code chunk number 10: plotex3
###################################################
hitheatmap(fit1, sharedness.score = TRUE, main = "My hits found by PMM")


###################################################
### code chunk number 11: pmm-package.Rnw:262-263
###################################################
hitheatmap(fit1, sharedness.score = TRUE, main = "My hits found by PMM")


