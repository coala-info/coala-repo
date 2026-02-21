# Code example from 'RankProd' vignette. See references/ for full tutorial.

### R code from vignette source 'RankProd.Rnw'

###################################################
### code chunk number 1: RankProd.Rnw:134-135
###################################################
library(RankProd)


###################################################
### code chunk number 2: RankProd.Rnw:141-142
###################################################
data(arab)


###################################################
### code chunk number 3: RankProd.Rnw:184-187
###################################################
n <- 5
cl <- rep(1,5)
cl


###################################################
### code chunk number 4: RankProd.Rnw:200-204
###################################################
n1 <- 5
n2 <- 4
cl <- rep(c(0,1),c(n1,n2))
cl


###################################################
### code chunk number 5: RankProd.Rnw:220-226
###################################################
n1 <- 5
n2 <- 4
cl <- rep(c(0,1),c(n1,n2))
cl
origin <- rep(1, n1+n2)
origin


###################################################
### code chunk number 6: RankProd.Rnw:231-236
###################################################
n <- 9
cl <- rep(1,n)
cl
origin <- rep(1, n)
origin


###################################################
### code chunk number 7: RankProd.Rnw:250-252
###################################################
origin <- c(rep(1, 6), rep(2,4), rep(3,8))
origin


###################################################
### code chunk number 8: RankProd.Rnw:263-266
###################################################
colnames(arab)
arab.cl
arab.origin


###################################################
### code chunk number 9: RankProd.Rnw:283-286
###################################################
arab.sub <- arab[,which(arab.origin==1)]
arab.cl.sub <- arab.cl[which(arab.origin==1)]
arab.origin.sub <- arab.origin[which(arab.origin==1)]


###################################################
### code chunk number 10: RankProd.Rnw:293-295
###################################################
RP.out <- RankProducts(arab.sub,arab.cl.sub, logged=TRUE,
na.rm=FALSE,plot=FALSE,  rand=123)


###################################################
### code chunk number 11: RankProd.Rnw:337-338
###################################################
plotRP(RP.out, cutoff=0.05)


###################################################
### code chunk number 12: RankProd.Rnw:358-360
###################################################
topGene(RP.out,cutoff=0.05,method="pfp",
logged=TRUE,logbase=2,gene.names=arab.gnames)


###################################################
### code chunk number 13: RankProd.Rnw:403-409
###################################################
##identify differentially expressed  genes
RP.adv.out <-  RP.advance(arab,arab.cl,arab.origin,
logged=TRUE,gene.names=arab.gnames,rand=123)
#The last command can also be written using the old syntax
#RP.adv.out <-  RPadvance(arab,arab.cl,arab.origin,
#logged=TRUE,gene.names=arab.gnames,rand=123)


###################################################
### code chunk number 14: RankProd.Rnw:413-414
###################################################
plotRP(RP.adv.out, cutoff=0.05)


###################################################
### code chunk number 15: RankProd.Rnw:423-425
###################################################
topGene(RP.adv.out,cutoff=0.05,method="pfp",logged=TRUE,logbase=2,
        gene.names=arab.gnames)


###################################################
### code chunk number 16: RankProd.Rnw:446-447
###################################################
data(lymphoma)


###################################################
### code chunk number 17: RankProd.Rnw:486-495
###################################################
refrs <- (1:8)*2-1
samps <- (1:8)*2
M <- lym.exp[,samps]-lym.exp[,refrs]
colnames(M)
cl <- c(rep(0,4),rep(1,4))
cl  #"CLL" is class 1, and "DLCL" is class 2
RP.out <- RankProducts(M,cl, logged=TRUE, rand=123)
#The last command can also be written using the old syntax
# RP.out <- RP(M,cl,logged=TRUE,rand=123)


###################################################
### code chunk number 18: RankProd.Rnw:498-499
###################################################
topGene(RP.out,cutoff=0.05,logged=TRUE,logbase=exp(1))


###################################################
### code chunk number 19: RankProd.Rnw:556-557
###################################################
data(Apples)


###################################################
### code chunk number 20: RankProd.Rnw:562-563
###################################################
Biom


###################################################
### code chunk number 21: RankProd.Rnw:579-582
###################################################
RS.apples<-RankProducts(apples.data.vsn, apples.cl,
                        gene.names = rownames(apples.data.vsn), 
                        calculateProduct = FALSE, rand=123)


###################################################
### code chunk number 22: RankProd.Rnw:590-593
###################################################
topGene(RS.apples,cutoff = 0.05, method = "pfp",
        gene.names = rownames(apples.data.vsn))
selected <- which(RS.apples$pfp[,1]<= 0.05)


###################################################
### code chunk number 23: RankProd.Rnw:599-600
###################################################
selected %in% Biom


###################################################
### code chunk number 24: RankProd.Rnw:667-671
###################################################
arab.cl2 <- arab.cl
arab.cl2[arab.cl==0 &arab.origin==2] <- 1
arab.cl2[arab.cl==1 &arab.origin==2] <- 0
arab.cl2


###################################################
### code chunk number 25: RankProd.Rnw:678-684
###################################################
Rsum.adv.out <- RP.advance(arab,arab.cl2,arab.origin,calculateProduct=FALSE,
logged=TRUE,gene.names=arab.gnames,rand=123)
# also the old syntax can be used
#Rsum.adv.out <- RSadvance(arab,arab.cl2,arab.origin,
#logged=TRUE,gene.names=arab.gnames,rand=123)
topGene(Rsum.adv.out,cutoff=0.05,gene.names=arab.gnames)


###################################################
### code chunk number 26: RankProd.Rnw:692-693
###################################################
topGene(Rsum.adv.out,num.gene=10,gene.names=arab.gnames)


###################################################
### code chunk number 27: RankProd.Rnw:696-697
###################################################
plotRP(Rsum.adv.out,cutoff=0.05)


###################################################
### code chunk number 28: RankProd.Rnw:705-710
###################################################
RP.adv.out <- RP.advance(arab,arab.cl2,arab.origin,calculateProduct=TRUE,
logged=TRUE,gene.names=arab.gnames,rand=123)
#  also the old syntax can be used
#RP.adv.out <- RPadvance(arab,arab.cl2,arab.origin,
#logged=TRUE,gene.names=arab.gnames,rand=123)


###################################################
### code chunk number 29: RankProd.Rnw:713-714
###################################################
topGene(RP.adv.out,cutoff=0.05,gene.names=arab.gnames)


###################################################
### code chunk number 30: RankProd.Rnw:720-721
###################################################
RP.adv.out$Orirank[[1]][344,]


