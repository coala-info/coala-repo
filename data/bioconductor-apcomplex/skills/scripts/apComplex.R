# Code example from 'apComplex' vignette. See references/ for full tutorial.

### R code from vignette source 'apComplex.Rnw'

###################################################
### code chunk number 1: setup
###################################################
plotGraph <- function(x, ...) {
    if (require("Rgraphviz", quietly=TRUE))
      return(plot(x, ...))
    else {
        msg = "This plot requires Rgraphviz"
        plot(0, 0, type="n")
        text(0, 0.5, msg)
    }
}
      


###################################################
### code chunk number 2: loadlibs
###################################################

library(apComplex)



###################################################
### code chunk number 3: trueData
###################################################
FromT <- c(rep("P1",3),rep("P2",3),rep("P3",2))
ToT <- c("P2","P4","P6","P1","P4","P6","P4","P5")
LT <- cbind(FromT,ToT)
apEXGT <- ftM2graphNEL(LT)
fcT <- c(rep("yellow",3),rep("white",3))
names(fcT) <- c("P1","P2","P3","P4","P5","P6")
nAT <- list(fillcolor=fcT)
ecT <- c("red","red",rep("gray",6))
names(ecT) <-
  c("P1~P2","P2~P1","P1~P6","P1~P4","P2~P4","P2~P6","P3~P4","P3~P5")
eAT <- list(color=ecT)
plotGraph(apEXGT,nodeAttrs=nAT,edgeAttrs=eAT)


###################################################
### code chunk number 4: apEx
###################################################
data(apEX)
apEX


###################################################
### code chunk number 5: observedData
###################################################
From <- c(rep("P1",3),rep("P2",2),rep("P3",3),"P8")
To <- c("P2","P4","P6","P1","P6","P4","P5","P7","P3")
L <- cbind(From,To)
M1 <- ftM2adjM(L)
apEXG <- as(M1,"graphNEL")

fc <- c(rep("yellow",4),rep("white",4))
names(fc) <- c("P1","P2","P3","P8","P4","P5","P6","P7")
nA <- list(fillcolor=fc)

ec <- c("red","red","blue",rep("gray",6))
names(ec) <-
  c("P1~P2","P2~P1","P8~P3","P1~P6","P1~P4","P2~P6","P3~P4","P3~P5","P3~P7")
eA <- list(color=ec)
plotGraph(apEXG,nodeAttrs=nA,edgeAttrs=eA)


###################################################
### code chunk number 6: PCMG0
###################################################
PCMG0 <- bhmaxSubgraph(apEX) 
PCMG0


###################################################
### code chunk number 7: PCMG0graph
###################################################
par(mfrow=c(2,2))

sn1 <- c("P3","P8")
sg1 <- subGraph(sn1,apEXG)
edgemode(sg1) <- "directed"
fc1 <- fc[sn1]
nA1 <- list(fillcolor=fc1)
ec1 <- ec["P8~P3"]
eA1 <- list(color=ec1)
plotGraph(sg1,nodeAttrs=nA1,edgeAttrs=eA1)
title("bhmax1")

sn2 <- c("P1","P2","P6")
sg2 <- subGraph(sn2,apEXG)
edgemode(sg2) <- "directed"
fc2 <- fc[sn2]
nA2 <- list(fillcolor=fc2)
ec2 <- ec[c("P1~P2","P2~P1","P1~P6","P2~P6")]
eA2 <- list(color=ec2)
plotGraph(sg2,nodeAttrs=nA2,edgeAttrs=eA2)
title("bhmax2")

sn3 <- c("P1","P4","P6")
sg3 <- subGraph(sn3,apEXG)
edgemode(sg3) <- "directed"
fc3 <- fc[sn3]
nA3 <- list(fillcolor=fc3)
ec3 <- ec[c("P1~P4","P1~P6")]
eA3 <- list(color=ec3)
plotGraph(sg3,nodeAttrs=nA3,edgeAttrs=eA3)
title("bhmax3")

sn4 <- c("P3","P4","P5","P7")
sg4 <- subGraph(sn4,apEXG)
edgemode(sg4) <- "directed"
fc4 <- fc[sn4]
nA4 <- list(fillcolor=fc4)
ec4 <- ec[c("P3~P4","P3~P5","P3~P7")]
eA4 <- list(color=ec4)
plotGraph(sg4,nodeAttrs=nA4,edgeAttrs=eA4)
title("bhmax4")



###################################################
### code chunk number 8: BP1
###################################################
FromBP1 <- c("P1","P1","P2","P3","P3","P4","P4","P5","P6","P6","P7","P8")
ToBP1 <- paste("BHM",c(2,3,2,1,4,3,4,4,2,3,4,1),sep="")
LBP1 <- cbind(FromBP1,ToBP1)
gBP1 <- ftM2graphNEL(LBP1, edgemode="undirected")
fc <- c(rep("yellow",4),rep("white",4),rep("salmon",4))
names(fc) <- c("P1","P2","P3","P8","P4","P5","P6","P7",paste("BHM",1:4,sep=""))
nABP1 <- list(fillcolor=fc)
plotGraph(gBP1,nodeAttrs=nABP1)



###################################################
### code chunk number 9: mergeComplexes
###################################################

PCMG1 <- mergeComplexes(PCMG0,apEX,sensitivity=.7,specificity=.75)
PCMG1



###################################################
### code chunk number 10: mergedComplex
###################################################
par(mfrow=c(1,3))

plotGraph(sg1,nodeAttrs=nA1,edgeAttrs=eA1)
title("Complex1")

sn5 <- c("P1","P2","P4","P6")
sg5 <- subGraph(sn5,apEXG)
edgemode(sg5) <- "directed"
fc5 <- fc[sn5]
nA5 <- list(fillcolor=fc5)
ec5 <- ec[c("P1~P2","P2~P1","P1~P4","P1~P6","P2~P6")]
eA5 <- list(color=ec5)
plotGraph(sg5,nodeAttrs=nA5,edgeAttrs=eA5)
title("Complex2")

plotGraph(sg4,nodeAttrs=nA4,edgeAttrs=eA4)
title("Complex3")


###################################################
### code chunk number 11: BP2
###################################################
FromBP2 <- paste("P",c(1,2,3,3,8,4,4,5,6,7),sep="")
ToBP2 <- paste("C",c(2,2,1,3,1,2,3,3,2,3),sep="")
LBP2 <- cbind(FromBP2,ToBP2)
gBP2 <- ftM2graphNEL(LBP2, edgemode="undirected")
fc <- c(rep("yellow",4),rep("white",4),rep("thistle",3))
names(fc) <- c("P1","P2","P3","P8","P4","P5","P6","P7",paste("C",1:3,sep=""))
nABP2 <- list(fillcolor=fc)
plotGraph(gBP2,nodeAttrs=nABP2)


###################################################
### code chunk number 12: findComplexes
###################################################

PCMG2 <- findComplexes(apEX,sensitivity=.7,specificity=.75)
PCMG2



###################################################
### code chunk number 13: sortComps
###################################################
sortComplexes(PCMG2,adjMat=apEX)


###################################################
### code chunk number 14: publicDataTAP
###################################################
data(TAP)
dim(TAP)
data(TAPgraph)

which(TAP["Abd1",]==1)
adj(TAPgraph,"Abd1")

data(yTAP)



###################################################
### code chunk number 15: publicDataHMSPCI
###################################################
data(HMSPCI)
dim(HMSPCI)
data(HMSPCIgraph)
which(HMSPCI["YAL015C",]==1)
adj(HMSPCIgraph,"YAL015C")


###################################################
### code chunk number 16: PP2A
###################################################
data(MBMEcTAP)
which(MBMEcTAP[,37]==1)
which(MBMEcTAP[,38]==1)
which(MBMEcTAP[,39]==1)
which(MBMEcTAP[,195]==1)
which(MBMEcTAP[,233]==1)



