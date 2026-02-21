# Code example from 'spqn' vignette. See references/ for full tutorial.

## ----load, message=FALSE------------------------------------------------------
library(spqn)
library(spqnData)
library(SummarizedExperiment)

## ----cor_m, message=FALSE-----------------------------------------------------
data(gtex.4k)
cor_m <- cor(t(assay(gtex.4k)))
ave_logrpkm <- rowData(gtex.4k)$ave_logrpkm

## ----examplePreproc, eval=FALSE-----------------------------------------------
# # only keep coding genes and lincRNA in the counts matrix
# gtex <- gtex[rowData(gtex)$gene_type %in%
#                           c("lincRNA", "protein_coding"), ]
# 
# # normalize the counts matrix by log2rpkm
# cSums <- colSums(assay(gtex))
# logrpkm <- sweep(log2(assay(gtex) + 0.5), 2, FUN = "-",
#                  STATS = log2(cSums / 10^6))
# logrpkm <- logrpkm - log2(rowData(gtex)$gene_length / 1000)
# 
# # only keep those genes with median log2rpkm above 0
# wh.expressed  <- which(rowMedians(logrpkm) > 0)
# 
# gtex.0pcs <- gtex[wh.expressed,]
# logrpkm.0pcs <- logrpkm[wh.expressed,]
# ave_logrpkm <- rowMeans(logrpkm.0pcs)
# logrpkm <- logrpkm - ave_logrpkm # mean centering
# logrpkm  <- logrpkm / matrixStats::rowSds(logrpkm) # variance scaling
# assays(gtex.0pcs) <- SimpleList(logrpkm = logrpkm.0pcs)
# rowData(gtex.0pcs)$ave_logrpkm <- ave_logrpkm
# 
# # remove PCs from the gene expression matrix after scaling each gene to have mean=0 and variance=1
# gtex.4pcs <- gtex.0pcs
# assay(gtex.4pcs) <- removePrincipalComponents(t(scale(t(logrpkm.0pcs))), n = 4)

## ----message=FALSE------------------------------------------------------------
plot_signal_condition_exp(cor_m, ave_logrpkm, signal=0)

## ----message = FALSE----------------------------------------------------------
plot_signal_condition_exp(cor_m, ave_logrpkm, signal=0.001)

## ----message=FALSE------------------------------------------------------------
IQR_list <- get_IQR_condition_exp(cor_m, rowData(gtex.4k)$ave_logrpkm)
plot_IQR_condition_exp(IQR_list)

## ----message = FALSE----------------------------------------------------------
IQR_unlist <- unlist(lapply(1:10, function(ii) IQR_list$IQR_cor_mat[ii, ii:10]))
plot(rep(IQR_list$grp_mean, times = 1:10),
     IQR_unlist,
     xlab="min(average(log2RPKM))", ylab="IQR", cex.lab=1.5, cex.axis=1.2, col="blue")

## ----message = FALSE----------------------------------------------------------
par(mfrow = c(3,3))
for(j in c(1:8,10)){
    qqplot_condition_exp(cor_m, ave_logrpkm, j, j)
}

## ----spqn, message = FALSE----------------------------------------------------
cor_m_spqn <- normalize_correlation(cor_m, ave_exp=ave_logrpkm, ngrp=20, size_grp=300, ref_grp=18)

## ----message = FALSE----------------------------------------------------------
plot_signal_condition_exp(cor_m_spqn, ave_logrpkm, signal=0)

## ----message = FALSE----------------------------------------------------------
plot_signal_condition_exp(cor_m_spqn, ave_logrpkm, signal=0.001)

## ----message=FALSE------------------------------------------------------------
IQR_spqn_list <- get_IQR_condition_exp(cor_m_spqn, rowData(gtex.4k)$ave_logrpkm)
plot_IQR_condition_exp(IQR_spqn_list)

## ----message = FALSE----------------------------------------------------------
par(mfrow = c(3,3))
for(j in c(1:8,10)){
    qqplot_condition_exp(cor_m_spqn, ave_logrpkm, j, j)
}

## ----message = FALSE----------------------------------------------------------
IQR_unlist <- unlist(lapply(1:10, function(ii) IQR_spqn_list$IQR_cor_mat[ii, ii:10]))
plot(rep(IQR_spqn_list$grp_mean, times = 1:10),
     IQR_unlist,
     xlab="min(average(log2RPKM))", ylab="IQR", cex.lab=1.5, cex.axis=1.2, col="blue")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

