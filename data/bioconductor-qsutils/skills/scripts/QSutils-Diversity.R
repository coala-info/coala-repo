# Code example from 'QSutils-Diversity' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----install,message=FALSE----------------------------------------------------
BiocManager::install("QSutils")
library(QSutils)

## ----load-ex------------------------------------------------------------------
filepath<-system.file("extdata","ToyData_10_50_1000.fna", package="QSutils")
lst <- ReadAmplSeqs(filepath,type="DNA")
lst

## ----numbhaplo----------------------------------------------------------------
length(lst$hseqs)

## ----segsites-----------------------------------------------------------------
SegSites(lst$hseqs)

## ----nummutations-------------------------------------------------------------
TotalMutations(lst$hseqs)

## ----shannon------------------------------------------------------------------
Shannon(lst$nr)
NormShannon(lst$nr)

## ----shannon var--------------------------------------------------------------
ShannonVar(lst$nr)
NormShannonVar(lst$nr)

## ----ginnisimpsion------------------------------------------------------------
GiniSimpson(lst$nr)
GiniSimpsonMVUE(lst$nr)

## ----ginivar------------------------------------------------------------------
GiniSimpsonVar(lst$nr)

## ----hill---------------------------------------------------------------------
Hill(lst$nr,q=1)

## ----hillplot, fig.cap="Hill numbers profile", eval=FALSE---------------------
# HillProfile(lst$nr)
# plot(HillProfile(lst$nr),type ="b", main="Hill numbers obtained
#     with HillProfile")

## ----hillprofile,echo=FALSE---------------------------------------------------
HillProfile(lst$nr)

## ----plothill, fig.cap="Hill numbers profile", echo=FALSE---------------------
plot(HillProfile(lst$nr),type ="b", main="Hill numbers obtained
    with HillProfile")

## ----renyi--------------------------------------------------------------------
Renyi(lst$nr,q=3)

## ----reniyprofile,fig.cap="Rényi entropy profile",eval=FALSE------------------
# RenyiProfile(lst$nr)
# plot(RenyiProfile(lst$nr),type ="b", main="Rényi entropy obtained with
#     RenyiProfile")

## ----plotreniy,echo=FALSE-----------------------------------------------------
RenyiProfile(lst$nr)

## ----reniyplot,fig.cap="Rényi entropy profile",echo=FALSE---------------------
plot(RenyiProfile(lst$nr),type ="b", main="Rényi entropy obtained with
    RenyiProfile")

## ----hcq----------------------------------------------------------------------
HCq(lst$nr, q= 4)

## ----hcqvar-------------------------------------------------------------------
HCqVar(lst$nr, q= 4)

## ----hcprofile,fig.cap="Havrda-Charvat entropy profile",eval=FALSE------------
# HCqProfile(lst$nr)
# plot(HCqProfile(lst$nr),type ="b", main="Havrda-Charvat entropy obtained
#     with HCqProfile")

## ----hcqplot,echo=FALSE-------------------------------------------------------
HCqProfile(lst$nr)

## ----plothcq,fig.cap="Havrda-Charvat entropy profile",echo=FALSE--------------
plot(HCqProfile(lst$nr),type ="b", main="Havrda-Charvat entropy obtained 
    with HCqProfile")

## ----dist ,message=FALSE,fig.cap="Correlation among haplotype distances"------
dst <- DNA.dist(lst$hseqs,model="raw")
library(psych)
D <- as.matrix(dst)
rownames(D) <- sapply(rownames(D),function(str) strsplit(str,
                split="\\|")[[1]][1])
colnames(D) <- rownames(D)
D

## ----mfe----------------------------------------------------------------------
MutationFreq(dst) 

## ----fad----------------------------------------------------------------------
FAD(dst)

## ----pi_e---------------------------------------------------------------------
NucleotideDiversity(dst)  

## ----mfm----------------------------------------------------------------------
nm <- nmismatch(pairwiseAlignment(lst$hseqs,lst$hseqs[1]))
MutationFreq(nm=nm,nr=lst$nr,len=width(lst$hseqs)[1])

## ----mfvar--------------------------------------------------------------------
MutationFreqVar(nm,lst$nr,len=width(lst$hseqs)[1])

## ----pi-----------------------------------------------------------------------
NucleotideDiversity(dst,lst$nr)

## ----rao----------------------------------------------------------------------
RaoPow(dst,4,lst$nr)

## ----raovar-------------------------------------------------------------------
RaoVar(dst,lst$nr)

## ----raoprofile,fig.cap="Havrda-Charvat entropy profile",eval=FALSE-----------
# RaoPowProfile(dst,lst$nr)
# plot(RaoPowProfile(dst,lst$nr),type ="b", main="Rao entropy obtained
#     with RaoPowProfile")

## ----raoplot,echo=FALSE-------------------------------------------------------
RaoPowProfile(dst,lst$nr)

## ----plotrao,fig.cap="Rao entropy profile",echo=FALSE-------------------------
plot(RaoPowProfile(dst,lst$nr),type ="b", main="Rao entropy obtained 
        with RaoPowProfile")

## ----downsampling,fig.cap="Diversity index variations due to sample size"-----
set.seed(123)
n <- 2000
y <- geom.series(n,0.8)+geom.series(n,0.00025)
nr.pop <- round(y*1e7)

thr <- 0.1
sz1 <- 5000
sz2 <- 10000

qs.sample <- function(nr.pop,sz1,sz2){ 
    div <- numeric(6)
    nr.sz1 <- table(sample(length(nr.pop),size=sz1,replace=TRUE,p=nr.pop))
    div[1] <- Shannon(nr.sz1)
    nr.sz1 <- nr.sz1[nr.sz1>=sz1*thr/100]
    div[3] <- Shannon(nr.sz1)
    div[5] <- Shannon(nr.sz1[DSFT(nr.sz1,sz1)])
    
    nr.sz2 <- table(sample(length(nr.pop),size=sz2,replace=TRUE,p=nr.pop))
    div[2] <- Shannon(nr.sz2)
    nr.sz2 <- nr.sz2[nr.sz2>=sz2*thr/100]
    div[4] <- Shannon(nr.sz2)
    div[6] <- Shannon(nr.sz2[DSFT(nr.sz2,sz1)])
    div
}

hpl.sim <- replicate(2000,qs.sample(nr.pop,sz1,sz2))
nms <- paste(c(sz1,sz2))

par(mfrow=c(1,3))

boxplot(t(hpl.sim[1:2,]),names=nms,col="lavender",las=2,
        ylab="Shannon entropy",main="raw")
boxplot(t(hpl.sim[3:4,]),names=nms,col="lavender",las=2,
        ylab="Shannon entropy",main="filt")
boxplot(t(hpl.sim[5:6,]),names=nms,col="lavender",las=2,
        ylab="Shannon entropy",main="DSFT")

## ----ex-dsft------------------------------------------------------------------
set.seed(123)
n <- 2000
y <- geom.series(n,0.8)+geom.series(n,0.0002)
nr.pop <- round(y*1e7)
rare <- nr.pop/sum(nr.pop) < 0.01
RHL <- sum(nr.pop[rare])/sum(nr.pop)
round(RHL,4)

## ----ex2-dsft-----------------------------------------------------------------
thr <- 0.1
sz1 <- 5000
sz2 <- 10000
qs.sample <- function(nr.pop,sz1,sz2){
    div <- numeric(2)
    nr.sz1 <- table(sample(length(nr.pop),size=sz1,replace=TRUE,p=nr.pop))
    rare <- nr.sz1/sum(nr.sz1) < 0.01
    div[1] <- sum(nr.sz1[rare])/sum(nr.sz1)
    nr.sz2 <- table(sample(length(nr.pop),size=sz2,replace=TRUE,p=nr.pop))
    rare <- nr.sz1/sum(nr.sz2) < 0.01
    div[2] <- sum(nr.sz2[rare])/sum(nr.sz2)
    div
}

hpl.sim <- replicate(2000,qs.sample(nr.pop,sz1,sz2))
nms <- paste(c(sz1,sz2))
boxplot(t(hpl.sim),names=nms,col="lavender",las=2,ylab="RHL")
abline(h=RHL,lty=4,col="navy")

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

