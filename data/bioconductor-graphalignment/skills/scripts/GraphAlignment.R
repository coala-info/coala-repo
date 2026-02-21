# Code example from 'GraphAlignment' vignette. See references/ for full tutorial.

### R code from vignette source 'GraphAlignment.Rnw'

###################################################
### code chunk number 1: GraphAlignment.Rnw:350-352 (eval = FALSE)
###################################################
## vignette(all=FALSE)
## edit(vignette("GraphAlignment"))


###################################################
### code chunk number 2: GraphAlignment.Rnw:357-360
###################################################
options(width = 40)
options(digits = 3);
library(GraphAlignment)


###################################################
### code chunk number 3: GraphAlignment.Rnw:365-369
###################################################
library(GraphAlignment)

ex<-GenerateExample(dimA=22, dimB=22, filling=.5, 
    covariance=.6, symmetric=TRUE, numOrths=10, correlated=seq(1,18))


###################################################
### code chunk number 4: GraphAlignment.Rnw:385-386
###################################################
pinitial<-InitialAlignment(psize=34, r=ex$r, mode="reciprocal")


###################################################
### code chunk number 5: GraphAlignment.Rnw:401-402
###################################################
lookupLink<-seq(-2,2,.5)


###################################################
### code chunk number 6: GraphAlignment.Rnw:407-408
###################################################
linkParams<-ComputeLinkParameters(ex$a, ex$b, pinitial, lookupLink)


###################################################
### code chunk number 7: GraphAlignment.Rnw:421-424
###################################################
lookupNode<-c(-.5,.5,1.5)
nodeParams<-ComputeNodeParameters(dimA=22, dimB=22, ex$r,
    pinitial, lookupNode)


###################################################
### code chunk number 8: GraphAlignment.Rnw:429-436
###################################################
al<-AlignNetworks(A=ex$a, B=ex$b, R=ex$r, P=pinitial, 
    linkScore=linkParams$ls,
    selfLinkScore=linkParams$ls,
    nodeScore1=nodeParams$s1, nodeScore0=nodeParams$s0,
    lookupLink=lookupLink, lookupNode=lookupNode,
    bStart=.1, bEnd=30,
    maxNumSteps=50)


###################################################
### code chunk number 9: GraphAlignment.Rnw:448-454
###################################################
ComputeScores(A=ex$a, B=ex$b, R=ex$r, P=al, 
    linkScore=linkParams$ls,
    selfLinkScore=linkParams$ls,
    nodeScore1=nodeParams$s1, nodeScore0=nodeParams$s0,
    lookupLink=lookupLink, lookupNode=lookupNode,
    symmetric=TRUE)


###################################################
### code chunk number 10: GraphAlignment.Rnw:459-461
###################################################
AnalyzeAlignment(A=ex$a, B=ex$b, R=ex$r, P=al, lookupNode,
    epsilon=.5)


###################################################
### code chunk number 11: GraphAlignment.Rnw:471-480
###################################################
ex<-GenerateExample(30, 30, filling=1, covariance=.95,
    numOrths=20, symmetric=FALSE)
a=ex$a;b=ex$b
a[a>.5]=1;a[a<=.5]=0
b[b>.5]=1;b[b<=.5]=0
pinitial<-InitialAlignment(psize=40, r=ex$r, mode="reciprocal")
lookupLink<-c(-.5,.5,1.5)
linkParams<-ComputeLinkParameters(a, b, pinitial, lookupLink,
    clamp=FALSE)


###################################################
### code chunk number 12: GraphAlignment.Rnw:490-500
###################################################
lookupNode<-c(-.5,.5,1.5)
nsS0<-c(.025,-.025)
nsS1<-c(-.025,4)
al<-AlignNetworks(A=a, B=b, R=ex$r, P=pinitial,
    linkScore=linkParams$ls,
    selfLinkScore=linkParams$lsSelf,
    nodeScore1=nsS1, nodeScore0=nsS0,
    lookupLink=lookupLink, lookupNode=lookupNode,
    bStart=.1, bEnd=100,
    maxNumSteps=500, clamp=FALSE, directed=TRUE)


###################################################
### code chunk number 13: GraphAlignment.Rnw:553-556
###################################################
A <- matrix(c(0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 1), ncol = 4);
B <- matrix(c(0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1), ncol = 4);
R <- matrix(c(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), ncol = 4);


###################################################
### code chunk number 14: GraphAlignment.Rnw:561-563
###################################################
p0 <- c(1,3,4,5,2);
psize <- 5;


###################################################
### code chunk number 15: GraphAlignment.Rnw:568-569
###################################################
AlignedPairs(A, B, p0);


###################################################
### code chunk number 16: GraphAlignment.Rnw:576-577
###################################################
lookupLink <- c(-0.5, 0.5, 1.5);


###################################################
### code chunk number 17: GraphAlignment.Rnw:582-583
###################################################
lookupNode <- c(-0.5, 0.5, 1.5);


###################################################
### code chunk number 18: GraphAlignment.Rnw:593-595
###################################################
linkParams;
nodeParams;


###################################################
### code chunk number 19: GraphAlignment.Rnw:600-601
###################################################
al <- AlignNetworks(A, B, R, p0, linkParams$ls, linkParams$lsSelf, nodeParams$s1, nodeParams$s0, lookupLink, lookupNode, bStart = 0.001, bEnd = 1000, maxNumSteps = 100, clamp = TRUE);


###################################################
### code chunk number 20: GraphAlignment.Rnw:606-608
###################################################
linkParams <- ComputeLinkParameters(A, B, al, lookupLink);
nodeParams <- ComputeNodeParameters(dim(A)[1], dim(B)[1], R, al, lookupNode);


###################################################
### code chunk number 21: GraphAlignment.Rnw:613-614
###################################################
al == AlignNetworks(A, B, R, al, linkParams$ls, linkParams$lsSelf, nodeParams$s1, nodeParams$s0, lookupLink, lookupNode, bStart = 0.001, bEnd = 1000, maxNumSteps = 100, clamp = TRUE);


###################################################
### code chunk number 22: GraphAlignment.Rnw:619-621
###################################################
al;
AlignedPairs(A, B, al);


###################################################
### code chunk number 23: GraphAlignment.Rnw:628-629
###################################################
ComputeScores(A, B, R, al, linkParams$ls, linkParams$lsSelf, nodeParams$s1, nodeParams$s0, lookupLink, lookupNode, symmetric = TRUE, clamp = TRUE);


