# Code example from 'GenePair' vignette. See references/ for full tutorial.

### R code from vignette source 'GenePair.Rnw'

###################################################
### code chunk number 1: GenePair.Rnw:127-130 (eval = FALSE)
###################################################
## library("GeneGeneInteR")
## data("gene.pair")
## head(gene.pair$Y)


###################################################
### code chunk number 2: GenePair.Rnw:142-143 (eval = FALSE)
###################################################
## gene.pair$G1


###################################################
### code chunk number 3: GenePair.Rnw:158-159 (eval = FALSE)
###################################################
## gene.pair$G2


###################################################
### code chunk number 4: GenePair.Rnw:229-231 (eval = FALSE)
###################################################
## PCA.test(Y=gene.pair$Y, G1=gene.pair$G1, G2=gene.pair$G2,threshold=0.7,
## method="GenFreq")


###################################################
### code chunk number 5: GenePair.Rnw:252-254 (eval = FALSE)
###################################################
## PCA.test(Y=gene.pair$Y, G1=gene.pair$G1, G2=gene.pair$G2,threshold=0.7, 
## method="Std")


###################################################
### code chunk number 6: GenePair.Rnw:297-298 (eval = FALSE)
###################################################
## CCA.test(Y=gene.pair$Y, G1=gene.pair$G1, G2=gene.pair$G2,n.boot=500)


###################################################
### code chunk number 7: GenePair.Rnw:341-344 (eval = FALSE)
###################################################
## set.seed(1234)
## KCCA.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,
## kernel="rbfdot",sigma = 0.05,n.boot=500)


###################################################
### code chunk number 8: GenePair.Rnw:368-371 (eval = FALSE)
###################################################
## set.seed(1234)
## KCCA.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,
## kernel="polydot",degree = 1, scale = 1, offset = 1)


###################################################
### code chunk number 9: GenePair.Rnw:410-412 (eval = FALSE)
###################################################
## set.seed(1234)
## PLSPM.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,n.perm=1000)


###################################################
### code chunk number 10: GenePair.Rnw:489-491 (eval = FALSE)
###################################################
## set.seed(1234)
## CLD.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,n.perm=2000)


###################################################
### code chunk number 11: GenePair.Rnw:532-534 (eval = FALSE)
###################################################
## set.seed(1234)
## GBIGM.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,n.perm=2000)


###################################################
### code chunk number 12: GenePair.Rnw:605-607 (eval = FALSE)
###################################################
## set.seed(1234)
## minP.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2)


###################################################
### code chunk number 13: GenePair.Rnw:644-646 (eval = FALSE)
###################################################
## set.seed(1234)
## gates.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,me.est="ChevNy")


###################################################
### code chunk number 14: GenePair.Rnw:668-670 (eval = FALSE)
###################################################
## set.seed(1234)
## gates.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,alpha=0.05,me.est="Keff")


###################################################
### code chunk number 15: GenePair.Rnw:692-694 (eval = FALSE)
###################################################
## set.seed(1234)
## gates.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,me.est="LiJi")


###################################################
### code chunk number 16: GenePair.Rnw:716-718 (eval = FALSE)
###################################################
## set.seed(1234)
## gates.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,me.est="Galwey")


###################################################
### code chunk number 17: GenePair.Rnw:761-763 (eval = FALSE)
###################################################
## set.seed(1234)
## tTS.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,tau=0.5,n.sim=10000)


###################################################
### code chunk number 18: GenePair.Rnw:785-787 (eval = FALSE)
###################################################
## set.seed(1234)
## tProd.test(Y=gene.pair$Y, G1=gene.pair$G1,G2=gene.pair$G2,tau=0.05,n.sim=1000)


