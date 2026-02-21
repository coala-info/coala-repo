# Code example from 'LPE' vignette. See references/ for full tutorial.

### R code from vignette source 'LPE.Rnw'

###################################################
### code chunk number 1: LPE.Rnw:108-109 (eval = FALSE)
###################################################
## packageDescription("LPE")


###################################################
### code chunk number 2: LPE.Rnw:118-119
###################################################
set.seed(0) 


###################################################
### code chunk number 3: LPE.Rnw:123-124
###################################################
library(LPE) 


###################################################
### code chunk number 4: LPE.Rnw:134-138
###################################################
data(Ley)
dim(Ley)
head(Ley)
Ley.subset <- Ley[seq(1000),]


###################################################
### code chunk number 5: LPE.Rnw:155-158
###################################################
Ley.normalized <- Ley.subset
Ley.normalized[,2:7] <- preprocess(Ley.subset[,2:7], data.type = "MAS5")
Ley.normalized[1:3,]


###################################################
### code chunk number 6: LPE.Rnw:163-166
###################################################
Ley.final <- Ley.normalized[substring(Ley.normalized$ID,1,4) !="AFFX",] 
dim(Ley.final)
Ley.final[1:3,]


###################################################
### code chunk number 7: LPE.Rnw:175-178
###################################################
var.Naive <- baseOlig.error(Ley.final[,2:4],q=0.01)
dim(var.Naive)
var.Naive[1:3,]


###################################################
### code chunk number 8: LPE.Rnw:184-187
###################################################
var.Activated <- baseOlig.error(Ley.final[,5:7], q=0.01)
dim(var.Activated)
var.Activated[1:3,]


###################################################
### code chunk number 9: LPE.Rnw:198-206
###################################################
lpe.val <- data.frame(lpe(Ley.final[,5:7], Ley.final[,2:4], 
                          var.Activated, var.Naive,
                          probe.set.name=Ley.final$ID)
                      )

lpe.val <- round(lpe.val, digits=2)
dim (lpe.val)
lpe.val[1:3,]


###################################################
### code chunk number 10: LPE.Rnw:219-222
###################################################
fdr.BH <- fdr.adjust(lpe.val, adjp="BH")
dim(fdr.BH)
round(fdr.BH[1:4, ],2)


###################################################
### code chunk number 11: LPE.Rnw:231-233
###################################################
fdr.resamp <- fdr.adjust(lpe.val, adjp="resamp", iterations=2)
fdr.resamp


###################################################
### code chunk number 12: LPE.Rnw:249-251
###################################################
Bonferroni.adjp <- fdr.adjust(lpe.val, adjp="Bonferroni")
head(Bonferroni.adjp)


