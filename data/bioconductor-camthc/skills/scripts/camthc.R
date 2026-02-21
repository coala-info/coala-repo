# Code example from 'camthc' vignette. See references/ for full tutorial.

## ----setup, include = FALSE------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval=FALSE-----------------------------------------------------------
#  rCAM <- CAM(data, K = 2:5, thres.low = 0.30, thres.high = 0.95)

## ---- echo=TRUE------------------------------------------------------------
library(CAMTHC)

data(ratMix3) 
#ratMix3$X: X matrix containing mixture expression profiles to be analyzed
#ratMix3$A: ground truth A matrix containing proportions
#ratMix3$S: ground truth S matrix containing subpopulation-specific expression profiles

data <- ratMix3$X
#10000 genes * 21 tissues
#meet the input data requirements

## ---- echo=TRUE, message=FALSE---------------------------------------------
set.seed(111) # set seed for internal clustering to generate reproducible results
rCAM <- CAM(data, K = 2:5, thres.low = 0.30, thres.high = 0.95)
#CAM return three sub results: 
#rCAM@PrepResult contains details corresponding to data preprocessing.
#rCAM@MGResult contains details corresponding to marker gene clusters detection.
#rCAM@ASestResult contains details corresponding to A and S matrix estimation.

## ---- echo=TRUE------------------------------------------------------------
Aest <- Amat(rCAM, 3)
Sest <- Smat(rCAM, 3)

## ---- echo=TRUE------------------------------------------------------------
MGlist <- MGsforA(rCAM, K = 3) #for three subpopulations

## ---- echo=TRUE------------------------------------------------------------
MGstat <- MGstatistic(data, Aest, boot.alpha = 0.05, nboot = 1000)
MGlist.FC <- lapply(seq_len(3), function(x) 
    rownames(MGstat)[MGstat$idx == x & MGstat$OVE.FC > 10])
MGlist.FCboot <- lapply(seq_len(3), function(x) 
    rownames(MGstat)[MGstat$idx == x & MGstat$OVE.FC.alpha > 10])

## ---- fig.height=6, fig.width=6--------------------------------------------
simplexplot(data, Aest, MGlist)
simplexplot(data, Aest, MGlist.FC)
simplexplot(data, Aest, MGlist.FCboot)

## ---- fig.height=6, fig.width=6--------------------------------------------
simplexplot(data, Aest, MGlist.FCboot, corner.order = c(2,1,3), 
            data.col = "blue", corner.col = c("red","orange","green"))

## ---- eval=FALSE-----------------------------------------------------------
#  library(rgl)
#  Xp <- data %*% t(PCAmat(rCAM))
#  plot3d(Xp[, 1:3], col='gray', size=3,
#         xlim=range(Xp[,1]), ylim=range(Xp[,2:3]), zlim=range(Xp[,2:3]))
#  abclines3d(0,0,0, a=diag(3), col="black")
#  for(i in seq_along(MGlist)){
#      points3d(Xp[MGlist[[i]], 1:3], col= rainbow(3)[i], size = 8)
#  }

## ---- eval=FALSE-----------------------------------------------------------
#  library(rgl)
#  clear3d()
#  Xproj <- XWProj(data, PCAmat(rCAM))
#  Xp <- Xproj[,-1]
#  plot3d(Xp[, 1:3], col='gray', size=3,
#         xlim=range(Xp[,1:3]), ylim=range(Xp[,1:3]), zlim=range(Xp[,1:3]))
#  abclines3d(0,0,0, a=diag(3), col="black")
#  for(i in seq_along(MGlist)){
#      points3d(Xp[MGlist[[i]], 1:3], col= rainbow(3)[i], size = 8)
#  }

## ---- fig.height=6, fig.width=6--------------------------------------------
plot(MDL(rCAM), data.term = TRUE)

## ---- echo=TRUE------------------------------------------------------------
cor(Aest, ratMix3$A)
cor(Sest, ratMix3$S)

## ---- echo=TRUE------------------------------------------------------------
unlist(lapply(seq_len(3), function(k) {
    k.match <- which.max(cor(Aest[,k], ratMix3$A));
    mgk <- MGlist.FCboot[[k]];
    corr <- cor(Sest[mgk, k], ratMix3$S[mgk, k.match]);
    names(corr) <- colnames(ratMix3$A)[k.match];
    corr}))


## ---- echo=TRUE------------------------------------------------------------
set.seed(111)

#Data preprocession
rPrep <- CAMPrep(data, thres.low = 0.30, thres.high = 0.95)

#Marker gene cluster detection with a fixed K
rMGC <- CAMMGCluster(3, rPrep)

#A and S matrix estimation
rASest <- CAMASest(rMGC, rPrep, data)

#Obtain A and S matrix
Aest <- Amat(rASest)
Sest <- Smat(rASest)

#obtain marker gene list detected by CAM and used for A estimation
MGlist <- MGsforA(PrepResult = rPrep, MGResult = rMGC)

#obtain a full list of marker genes 
MGstat <- MGstatistic(data, Aest, boot.alpha = 0.05, nboot = 1000)
MGlist.FC <- lapply(seq_len(3), function(x) 
    rownames(MGstat)[MGstat$idx == x & MGstat$OVE.FC > 10])
MGlist.FCboot <- lapply(seq_len(3), function(x) 
    rownames(MGstat)[MGstat$idx == x & MGstat$OVE.FC.alpha > 10])

## ---- echo=TRUE, message=FALSE---------------------------------------------
#clustering
library(apcluster)
apres <- apclusterK(negDistMat(r=2), t(data),  K = 10) 
#You can also use apcluster(), but need to make sure the number of clusters is large than potential subpopulation number.

data.clusterMean <- lapply(slot(apres,"clusters"), 
                           function(x) rowMeans(data[, x, drop = FALSE]))
data.clusterMean <- do.call(cbind, data.clusterMean)

set.seed(111)
rCAM <- CAM(data.clusterMean, K = 2:5, thres.low = 0.30, thres.high = 0.95)
# or rPrep <- CAMPrep(data.clusterMean, thres.low = 0.30, thres.high = 0.95)

## ---- echo=TRUE------------------------------------------------------------
Sest <- Smat(rCAM,3)
MGlist <- MGsforA(rCAM, K = 3)
Aest <- AfromMarkers(data, MGlist)

## ---- echo=TRUE, message=FALSE---------------------------------------------
#download data and phenotypes
library(GEOquery)
gsm<- getGEO('GSE11058')
pheno <- pData(phenoData(gsm[[1]]))$characteristics_ch1
mat <- exprs(gsm[[1]])
mat <- mat[-grep("^AFFX", rownames(mat)),]
mat.aggre <- sapply(unique(pheno), function(x) rowMeans(mat[,pheno == x]))
data <- mat.aggre[,5:8]

#running CAM
set.seed(111)
rCAM <- CAM(data, K = 4, thres.low = 0.70, thres.high = 0.95)
Aest <- Amat(rCAM, 4)
Aest

#Use ground truth A to validate CAM-estimated A matrix
Atrue <- matrix(c(2.50, 0.50, 0.10, 0.02,
              1.25, 3.17, 4.95, 3.33,
              2.50, 4.75, 1.65, 3.33,
              3.75, 1.58, 3.30, 3.33), 4,4,
              dimnames = list(c("MixA", "MixB", "MixC","MixD"),
                               c("Jurkat", "IM-9", "Raji", "THP-1")))
Atrue <- Atrue / rowSums(Atrue)
Atrue
cor(Aest, Atrue)

## ---- echo=TRUE, message=FALSE, eval=FALSE---------------------------------
#  #download data
#  library(GEOquery)
#  gsm <- getGEO('GSE41826')
#  mixtureId <- unlist(lapply(paste0('Mix',seq_len(9)),
#      function(x) gsm[[1]]$geo_accession[gsm[[1]]$title==x]))
#  data <- gsm[[1]][,mixtureId]
#  
#  #Remove CpG sites in sex chromosomes if tissues are from both males and females
#  #Not necessary in this example as mixtures are from the same subject
#  #gpl<- getGEO('GPL13534')
#  #annot<-dataTable(gpl)@table[,c('Name','CHR')]
#  #rownames(annot) <- annot$Name
#  #annot <- annot[rownames(data),]
#  #data <- data[annot$CHR != 'X' & annot$CHR != 'Y',]
#  
#  #downsample CpG sites
#  featureId <- sample(seq_len(nrow(gsm[[1]])), 20000)
#  
#  #running CAM
#  rCAM <- CAM(data[featureId,], K = 2, thres.low = 0.10, thres.high = 0.60)
#  Aest <- Amat(rCAM, 2)
#  Atrue <- cbind(seq(0.1, 0.9, 0.1), seq(0.9, 0.1, -0.1))
#  cor(Aest, Atrue)
#  
#  #obtain a full list of marker CpG sites
#  MGstat <- MGstatistic(data, Aest)
#  MGlist.FC <- lapply(seq_len(2), function(x)
#      rownames(MGstat)[MGstat$idx == x & MGstat$OVE.FC > 10])

## ---- echo=TRUE, message=FALSE, eval=FALSE---------------------------------
#  rCAM <- CAM(1 - exprs(data[featureId,]),
#              K = 2, thres.low = 0.10, thres.high = 0.60)

## ---- echo=TRUE, eval=FALSE------------------------------------------------
#  Aest <- AfromMarkers(data, MGlist)
#  #MGlist is a list of vectors, each of which contains known markers for one subpopulation

## ---- echo=TRUE------------------------------------------------------------
data <- ratMix3$X
S <- ratMix3$S #known S matrix

pMGstat <- MGstatistic(S, c("Liver","Brain","Lung"))
pMGlist.FC <- lapply(c("Liver","Brain","Lung"), function(x) 
    rownames(pMGstat)[pMGstat$idx == x & pMGstat$OVE.FC > 10])

Aest <- AfromMarkers(data, pMGlist.FC)

## ---- echo=TRUE------------------------------------------------------------
data <- ratMix3$X
A <- ratMix3$A #known A matrix

Sest <- t(NMF::.fcnnls(A, t(data))$coef)
MGstat <- MGstatistic(data, A)

## ---- echo=TRUE, eval=FALSE------------------------------------------------
#  Aest <- AfromMarkers(data, MGlist)
#  #MGlist is a list of vectors, each of which contains known markers and/or CAM-detected markers for one subpopulation

