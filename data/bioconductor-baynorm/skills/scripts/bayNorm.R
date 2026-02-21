# Code example from 'bayNorm' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE, dpi = 30)
knitr::opts_chunk$set(dev="png",fig.align="center")

## ----library, echo=FALSE------------------------------------------------------
library(bayNorm)
library(BiocStyle)
library(SummarizedExperiment)
library(SingleCellExperiment)

## ----install_Bioconductor, eval=FALSE-----------------------------------------
# library(BiocManager)
# BiocManager::install("bayNorm")

## ----install, eval=FALSE------------------------------------------------------
# library(devtools)
# devtools::install_github("WT215/bayNorm")

## ----beta, echo=TRUE,eval=TRUE------------------------------------------------
data('EXAMPLE_DATA_list')
#Suppose the input data is a SummarizedExperiment object:
#Here we just used 30 cells for illustration
rse <- SummarizedExperiment::SummarizedExperiment(assays=SimpleList(counts=EXAMPLE_DATA_list$inputdata[,seq(1,30)]))
#SingleCellExperiment object can also be input in bayNorm:
#rse <- SingleCellExperiment::SingleCellExperiment(assays=list(counts=EXAMPLE_DATA_list$inputdata))

BETA_est<-BetaFun(Data=rse,MeanBETA=0.06)
summary(BETA_est$BETA)

## ----intro_bayNorm, echo=TRUE,eval=TRUE---------------------------------------
#Return 3D array normalzied data, draw 20 samples from posterior distribution:
bayNorm_3D<-bayNorm(
    Data=rse,
    BETA_vec = NULL,
    mode_version=FALSE,
    mean_version = FALSE,S=20
    ,verbose =FALSE,
    parallel = TRUE)

#Return 2D matrix normalized data (MAP of posterior):
#Simply set mode_version=TRUE, but keep mean_version=FALSE


#Return 2D matrix normalized data (mean of posterior):
#Simply set mean_version=TRUE, but keep mode_version=FALSE

## ----intro_bayNorm_sup, echo=TRUE,eval=TRUE-----------------------------------
#Now if you want to generate 2D matrix (MAP) using the same prior
#estimates as generated before:
bayNorm_2D<-bayNorm_sup(
    Data=rse,
    PRIORS=bayNorm_3D$PRIORS,
    input_params=bayNorm_3D$input_params,
    mode_version=TRUE,
    mean_version = FALSE,
    verbose =FALSE)

#Or you may want to generate 2D matrix 
#(mean of posterior) using the same prior
#estimates as generated before:
bayNorm_2D<-bayNorm_sup(
    Data=rse,
    PRIORS=bayNorm_3D$PRIORS,
    input_params=bayNorm_3D$input_params,
    mode_version=FALSE,
    mean_version = TRUE,
    verbose =FALSE)

## ----DE_fun, echo=TRUE,eval=FALSE---------------------------------------------
# library(MAST)
# library(reshape2)
# ########SCnorm_runMAST3##########
# SCnorm_runMAST3 <- function(Data, NumCells) {
#     if(length(dim(Data))==2){
#         resultss<-SCnorm_runMAST(Data, NumCells)
#     } else if(length(dim(Data))==3){
# 
#         library(foreach)
#         resultss<- foreach(sampleind=1:dim(Data)[3],.combine=cbind)%do%{
#             print(sampleind)
# 
#             qq<-SCnorm_runMAST(Data[,,sampleind], NumCells)
#             return(qq$adjpval)
#         }
#     }
# 
#     return(resultss)
# }
# 
# SCnorm_runMAST <- function(Data, NumCells) {
# 
#   NA_ind<-which(rowSums(Data)==0)
#   Data = as.matrix(log2(Data+1))
# 
# 
#   G1<-Data[,seq(1,NumCells[1])]
#   G2<-Data[,-seq(1,NumCells[1])]
# 
#   qq_temp<- rowMeans(G2)-rowMeans(G1)
#   qq_temp[NA_ind]=NA
# 
#   numGenes = dim(Data)[1]
#   datalong = melt(Data)
#   Cond = c(rep("c1", NumCells[1]*numGenes), rep("c2", NumCells[2]*numGenes))
#   dataL = cbind(datalong, Cond)
#   colnames(dataL) = c("gene","cell","value","Cond")
#   dataL$gene = factor(dataL$gene)
#   dataL$cell = factor(dataL$cell)
#   vdata = FromFlatDF(dataframe = dataL, idvars = "cell", primerid = "gene", measurement = "value",  id = numeric(0), cellvars = "Cond", featurevars = NULL,  phenovars = NULL)
# 
#   zlm.output = zlm(~ Cond, vdata, method='glm', ebayes=TRUE)
# 
#   zlm.lr = lrTest(zlm.output, 'Cond')
# 
#   gpval = zlm.lr[,,'Pr(>Chisq)']
#   adjpval = p.adjust(gpval[,1],"BH") ## Use only pvalues from the continuous part.
#   adjpval = adjpval[rownames(Data)]
#   return(list(adjpval=adjpval, logFC_re=qq_temp))
# }
# 
# 
# 
# 

## ----DE_run, echo=TRUE,eval=FALSE---------------------------------------------
# #Now, detect DE genes between two groups of cells with 15 cells in each group respectively
# 
# #For 3D array
# DE_out<-SCnorm_runMAST3(Data=bayNorm_3D$Bay_out, NumCells=c(15,15))
# med_pvals<-apply(DE_out,1,median)
# #DE genes are called with threshold 0.05:
# DE_genes<-names(which(med_pvals<0.05))
# 
# #For 2D array
# DE_out<-SCnorm_runMAST3(Data=bayNorm_2D$Bay_out, NumCells=c(15,15))
# DE_genes<-names(which(DE_out$adjpval<0.05))

## ----SessionInfo--------------------------------------------------------------
sessionInfo()

