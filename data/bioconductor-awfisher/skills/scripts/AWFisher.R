# Code example from 'AWFisher' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

options(stringsAsFactors = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("AWFisher")

## -----------------------------------------------------------------------------
library(AWFisher) # Include the AWFisher package

# load the data
data(data_mouseMetabolism)

# Verify gene names match across three tissues
all(rownames(data_mouseMetabolism$brown) == rownames(data_mouseMetabolism$heart))
all(rownames(data_mouseMetabolism$brown) == rownames(data_mouseMetabolism$liver))

dataExp <- data_mouseMetabolism

# Check the dimension of the three studies
sapply(dataExp, dim)

# Check the head of the three studies
sapply(dataExp, function(x) head(x,n=2))

# Before performing differential expression analysis for each of these three tissues.
# Create an empty matrix to store p-value. 
# Each row represents a gene and each column represent a study/tissue. 

pmatrix <- matrix(0,nrow=nrow(dataExp[[1]]),ncol=length(dataExp)) 
rownames(pmatrix) <- rownames(dataExp[[1]])
colnames(pmatrix) <- names(dataExp)

## -----------------------------------------------------------------------------
library(limma) # Include the limma package to perform differential expression analyses for the microarray data

for(s in 1:length(dataExp)){
  adata <- dataExp[[s]]
  ControlLabel = grep('wt',colnames(adata))
  caseLabel = grep('LCAD',colnames(adata))
  label <- rep(NA, ncol(adata))
  label[ControlLabel] = 0
  label[caseLabel] = 1

  design = model.matrix(~label)  # design matrix
  fit <- lmFit(adata,design)  # fit limma model
  fit <- eBayes(fit)

  pmatrix[,s] <- fit$p.value[,2]
}

head(pmatrix, n=2) ## look at the head of the p-value matrix

## -----------------------------------------------------------------------------
res <- AWFisher_pvalue(pmatrix) ## Perform AW Fisehr meta analysis
qvalue <- p.adjust(res$pvalue, "BH") ## Perform BH correction to control for multiple comparison.
sum(qvalue < 0.05) ## Differentially expressed genes with FDR 5%
head(res$weights) ## Show the AW weight of the first few genes

## -----------------------------------------------------------------------------
## prepare the data to feed function biomarkerCategorization
studies <- NULL
for(s in 1:length(dataExp)){
  adata <- dataExp[[s]]
  ControlLabel = grep('wt',colnames(adata))
  caseLabel = grep('LCAD',colnames(adata))
  label <- rep(NA, ncol(adata))
  label[ControlLabel] = 0
  label[caseLabel] = 1

  studies[[s]] <- list(data=adata, label=label)
}

## See help file about about how to use function biomarkerCategorization.
## Set B = 1,000 (at least) for real data application
## You may need to wrap up a function (i.e., function_limma) 
## to perform differential expression analysis for each study.

set.seed(15213)
result <- biomarkerCategorization(studies,function_limma,B=100,DEindex=NULL)
sum(result$DEindex) ## print out DE index at FDR 5%
head(result$varibility, n=2) ## print out the head of variability index
print(result$dissimilarity[1:4,1:4]) ## print out the dissimilarity matrix

## -----------------------------------------------------------------------------
library(tightClust) ## load tightClust package

tightClustResult <- tight.clust(result$dissimilarity, target=4, k.min=15, random.seed=15213)
clusterMembership <- tightClustResult$cluster

## ----fig.show='hold'----------------------------------------------------------

for(s in 1:length(dataExp)){
  adata <- dataExp[[s]]
  aname <- names(dataExp)[s]
  bdata <- adata[qvalue<0.05, ][tightClustResult$cluster == 1 ,]
  cdata <- as.matrix(bdata)
  ddata <- t(scale(t(cdata))) # standardize the data such that for each gene, the mean is 0 and sd is 1.

  ColSideColors <- rep("black", ncol(adata))
  ColSideColors[grep('LCAD',colnames(adata))] <- "red"

  B <- 16
  redGreenColor <- rgb(c(rep(0, B), (0:B)/B), c((B:0)/16, rep(0, B)), rep(0, 2*B+1))
  heatmap(ddata,Rowv=NA,ColSideColors=ColSideColors,col= redGreenColor ,scale='none',Colv=NA, main=aname)
}

## -----------------------------------------------------------------------------
sessionInfo()

