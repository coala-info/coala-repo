# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## -----------------------------------------------------------------------------
library(peco)
library(SingleCellExperiment)
library(doParallel)
library(foreach)

## -----------------------------------------------------------------------------
data("training_human")

## -----------------------------------------------------------------------------
data("sce_top101genes")
assays(sce_top101genes)

## -----------------------------------------------------------------------------
sce_top101genes <- data_transform_quantile(sce_top101genes)
assays(sce_top101genes)

## -----------------------------------------------------------------------------
pred_top101genes <- cycle_npreg_outsample(
    Y_test=sce_top101genes,
    sigma_est=training_human$sigma[rownames(sce_top101genes),],
    funs_est=training_human$cellcycle_function[rownames(sce_top101genes)],
    method.trend="trendfilter",
    ncores=1,
    get_trend_estimates=FALSE)

## -----------------------------------------------------------------------------
head(colData(pred_top101genes$Y)$cellcycle_peco)

## -----------------------------------------------------------------------------
plot(y=assay(pred_top101genes$Y,"cpm_quantNormed")["ENSG00000170312",],
     x=colData(pred_top101genes$Y)$theta_shifted, main = "CDK1",
     ylab = "quantile normalized expression")
points(y=training_human$cellcycle_function[["ENSG00000170312"]](seq(0,2*pi, length.out=100)),
       x=seq(0,2*pi, length.out=100), col = "blue", pch =16)

## -----------------------------------------------------------------------------
# predicted cell time in the input data
theta_predict = colData(pred_top101genes$Y)$cellcycle_peco
names(theta_predict) = rownames(colData(pred_top101genes$Y))

# expression values of 10 genes in the input data
yy_input = assay(pred_top101genes$Y,"cpm_quantNormed")[1:6,]

# apply trendfilter to estimate cyclic gene expression trend
fit_cyclic <- fit_cyclical_many(Y=yy_input, 
                                theta=theta_predict)

gene_symbols = rowData(pred_top101genes$Y)$hgnc[rownames(yy_input)]

par(mfrow=c(2,3))
for (i in 1:6) {
plot(y=yy_input[i,],
     x=fit_cyclic$cellcycle_peco_ordered, 
     main = gene_symbols[i],
     ylab = "quantile normalized expression")
points(y=fit_cyclic$cellcycle_function[[i]](seq(0,2*pi, length.out=100)),
       x=seq(0,2*pi, length.out=100), col = "blue", pch =16)
}

## -----------------------------------------------------------------------------
sessionInfo()

