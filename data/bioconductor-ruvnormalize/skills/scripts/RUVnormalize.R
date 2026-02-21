# Code example from 'RUVnormalize' vignette. See references/ for full tutorial.

### R code from vignette source 'RUVnormalize.Rnw'

###################################################
### code chunk number 1: lib
###################################################
library(RUVnormalize)
library(RUVnormalizeData)


###################################################
### code chunk number 2: data
###################################################
data('gender', package='RUVnormalizeData')

Y <- t(exprs(gender))
X <- as.numeric(phenoData(gender)$gender == 'M')
X <- X - mean(X)
X <- cbind(X/(sqrt(sum(X^2))))
chip <- annotation(gender)

## Extract regions and labs for plotting purposes
lregions <- sapply(rownames(Y),FUN=function(s) strsplit(s,'_')[[1]][2])
llabs <- sapply(rownames(Y),FUN=function(s) strsplit(s,'_')[[1]][3])

## Dimension of the factors
m <- nrow(Y)
n <- ncol(Y)
p <- ncol(X)

Y <- scale(Y, scale=FALSE) # Center gene expressions

cIdx <- which(featureData(gender)$isNegativeControl) # Negative control genes

## Number of genes kept for clustering, based on their variance
nKeep <- 1260


###################################################
### code chunk number 3: plotPrep
###################################################
## Prepare plots
annot <- cbind(as.character(sign(X)))
colnames(annot) <- 'gender'
plAnnots <- list('gender'='categorical')
lab.and.region <- apply(rbind(lregions, llabs),2,FUN=function(v) paste(v,collapse='_'))
gender.col <- c('-1' = "deeppink3", '1' = "blue")


###################################################
### code chunk number 4: centering
###################################################
## Remove platform effect by centering.
Y[chip=='hgu95a.db',] <- scale(Y[chip=='hgu95a.db',], scale=FALSE)
Y[chip=='hgu95av2.db',] <- scale(Y[chip=='hgu95av2.db',], scale=FALSE)


###################################################
### code chunk number 5: scidx
###################################################
## Prepare control samples
scIdx <- matrix(-1,84,3)
rny <- rownames(Y)
added <- c()
c <- 0

# Replicates by lab
for(r in 1:(length(rny) - 1)){
  if(r %in% added)
    next
  c <- c+1
  scIdx[c,1] <- r
  cc <- 2
  for(rr in seq(along=rny[(r+1):length(rny)])){
    if(all(strsplit(rny[r],'_')[[1]][-3] ==  strsplit(rny[r+rr],'_')[[1]][-3])){
      scIdx[c,cc] <- r+rr
      cc <- cc+1
      added <- c(added,r+rr)
    }
  }    
}
scIdxLab <- scIdx 

scIdx <- matrix(-1,84,3)
rny <- rownames(Y)
added <- c()
c <- 0

## Replicates by region
for(r in 1:(length(rny) - 1)){
  if(r %in% added)
    next
  c <- c+1
  scIdx[c,1] <- r
  cc <- 2
  for(rr in seq(along=rny[(r+1):length(rny)])){
    if(all(strsplit(rny[r],'_')[[1]][-2] ==  strsplit(rny[r+rr],'_')[[1]][-2])){
      scIdx[c,cc] <- r+rr
      cc <- cc+1
      added <- c(added,r+rr)
    }
  }
}
scIdx <- rbind(scIdxLab,scIdx)


###################################################
### code chunk number 6: uncorrected
###################################################

## Sort genes by their standard deviation
sdY <- apply(Y, 2, sd)
ssd <- sort(sdY, decreasing=TRUE, index.return=TRUE)$ix

## Cluster the samples
kmres <- kmeans(Y[, ssd[1:nKeep], drop=FALSE], centers=2, nstart=200)
vclust <- kmres$cluster

## Compute the distance between clustering by gender 
## and clustering obtained by k-means
uScore <- clScore(vclust,X)


###################################################
### code chunk number 7: uncorrectedPlot
###################################################
svdResUncorr <- svdPlot(Y[, ssd[1:nKeep], drop=FALSE], 
                        annot=annot, 
                        labels=lab.and.region, 
                        svdRes=NULL, 
                        plAnnots=plAnnots, 
                        kColors=gender.col, file=NULL)


###################################################
### code chunk number 8: MC
###################################################
## Centering by region-lab
YmeanCorr <- Y
for(rr in unique(lregions)){
  for(ll in unique(llabs)){
    YmeanCorr[(lregions==rr)&(llabs==ll),] <- scale(YmeanCorr[(lregions==rr)&(llabs==ll),],scale=FALSE)
  }
}

sdY <- apply(YmeanCorr, 2, sd)
ssd <- sort(sdY,decreasing=TRUE,index.return=TRUE)$ix

kmresMC <- kmeans(YmeanCorr[,ssd[1:nKeep],drop=FALSE],centers=2,nstart=200)
vclustMC <- kmresMC$cluster
MCScore <- clScore(vclustMC, X)


###################################################
### code chunk number 9: MCPlot
###################################################
svdResMC <- svdPlot(YmeanCorr[, ssd[1:nKeep], drop=FALSE], 
                    annot=annot, 
                    labels=lab.and.region, 
                    svdRes=NULL, 
                    plAnnots=plAnnots,                     
                    kColors=gender.col, file=NULL)    


###################################################
### code chunk number 10: nsRUV2
###################################################
## Naive RUV-2 no shrinkage
k <- 20
nu <- 0

nsY <- naiveRandRUV(Y, cIdx, nu.coeff=0, k=k)

sdY <- apply(nsY, 2, sd)
ssd <- sort(sdY,decreasing=TRUE,index.return=TRUE)$ix

kmres2ns <- kmeans(nsY[,ssd[1:nKeep],drop=FALSE],centers=2,nstart=200)
vclust2ns <- kmres2ns$cluster
nsScore <- clScore(vclust2ns, X)


###################################################
### code chunk number 11: nsRUV2plot
###################################################
svdRes2ns <- svdPlot(nsY[, ssd[1:nKeep], drop=FALSE], 
                     annot=annot, 
                     labels=lab.and.region, 
                     svdRes=NULL, 
                     plAnnots=plAnnots,                     
                     kColors=gender.col, file=NULL)    


###################################################
### code chunk number 12: sRUV2
###################################################
## Naive RUV-2 + shrinkage

k <- m
nu.coeff <- 1e-3

nY <- naiveRandRUV(Y, cIdx, nu.coeff=nu.coeff, k=k)

sdY <- apply(nY, 2, sd)
ssd <- sort(sdY,decreasing=TRUE,index.return=TRUE)$ix

kmres2 <- kmeans(nY[,ssd[1:nKeep],drop=FALSE],centers=2,nstart=200)
vclust2 <- kmres2$cluster
nScore <- clScore(vclust2,X)


###################################################
### code chunk number 13: sRUV2plot
###################################################
svdRes2 <- svdPlot(nY[, ssd[1:nKeep], drop=FALSE], 
                     annot=annot, 
                     labels=lab.and.region, 
                     svdRes=NULL, 
                     plAnnots=plAnnots,                     
                     kColors=gender.col, file=NULL)    


###################################################
### code chunk number 14: rep
###################################################
## Replicate-based

sRes <- naiveReplicateRUV(Y, cIdx, scIdx, k=20)

sdY <- apply(sRes$cY, 2, sd)
ssd <- sort(sdY,decreasing=TRUE,index.return=TRUE)$ix

kmresRep <- kmeans(sRes$cY[,ssd[1:nKeep],drop=FALSE],centers=2,nstart=200)
vclustRep <- kmresRep$cluster
RepScore <- clScore(vclustRep,X)


###################################################
### code chunk number 15: repplot
###################################################
svdResRep <- svdPlot(sRes$cY[, ssd[1:nKeep], drop=FALSE], 
                     annot=annot, 
                     labels=lab.and.region, 
                     svdRes=NULL, 
                     plAnnots=plAnnots,                     
                     kColors=gender.col, file=NULL)    


###################################################
### code chunk number 16: rep-iter
###################################################
if (require(spams)){
  ## Iterative replicate-based
  cEps <- 1e-6
  maxIter <- 30
  p <- 20

  paramXb <- list()
  paramXb$K <- p
  paramXb$D <- matrix(c(0.),nrow = 0,ncol=0)
  paramXb$batch <- TRUE
  paramXb$iter <- 1

  ## l1
  paramXb$mode <- 'PENALTY'
  paramXb$lambda <- 0.25 

  iRes <- iterativeRUV(Y, cIdx, scIdx, paramXb, k=20, nu.coeff=0,
  cEps, maxIter,
  Wmethod='rep', wUpdate=11)

  ucY <- iRes$cY

  sdY <- apply(ucY, 2, sd)
  ssd <- sort(sdY,decreasing=TRUE,index.return=TRUE)$ix

  kmresIter <- kmeans(ucY[,ssd[1:nKeep]],centers=2,nstart=200)
  vclustIter <- kmresIter$cluster
  IterScore <- clScore(vclustIter,X)
}else{
    IterScore <- NA
}


###################################################
### code chunk number 17: ridge-iter
###################################################
if (require(spams)){
  ## Iterated ridge
  paramXb <- list()
  paramXb$K <- p
  paramXb$D <- matrix(c(0.),nrow = 0,ncol=0)
  paramXb$batch <- TRUE
  paramXb$iter <- 1
  paramXb$mode <- 'PENALTY' #2
  paramXb$lambda <- 6e-2
  paramXb$lambda2 <- 0

  iRes <- iterativeRUV(Y, cIdx, scIdx=NULL, paramXb, k=nrow(Y), nu.coeff=1e-3/2,
  cEps, maxIter,
  Wmethod='svd', wUpdate=11)

  nrcY <- iRes$cY

  sdY <- apply(nrcY, 2, sd)
  ssd <- sort(sdY,decreasing=TRUE,index.return=TRUE)$ix

  kmresIter <- kmeans(nrcY[,ssd[1:nKeep]],centers=2,nstart=200)
  vclustIter <- kmresIter$cluster
  IterRandScore <- clScore(vclustIter,X)
}else{
    IterRandScore <- NA
}


###################################################
### code chunk number 18: print-scores
###################################################
scores <- c(uScore, MCScore, nsScore, nScore, RepScore, IterScore, IterRandScore)
names(scores) <- c('Uncorrected', 'Centered', 'Naive RUV-2', 'Naive + shrink', 'Replicates', 'Replicates + iter', 'Shrinkage + iter')
print('Clustering errors after each correction')
print(scores)


###################################################
### code chunk number 19: close-connections
###################################################
graphics.off()


###################################################
### code chunk number 20: sessionInfo
###################################################
sessionInfo()


