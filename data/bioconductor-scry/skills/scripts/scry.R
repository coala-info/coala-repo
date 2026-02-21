# Code example from 'scry' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(SingleCellExperiment))
library(ggplot2); theme_set(theme_bw())
library(DuoClustering2018)
require(scry)

## -----------------------------------------------------------------------------
sce<-sce_full_Zhengmix4eq()
#m<-counts(sce) #UMI counts
#cm<-as.data.frame(colData(sce))

## ----fig.width=6, fig.height=4------------------------------------------------
sce<-devianceFeatureSelection(sce, assay="counts", sorted=TRUE)
plot(rowData(sce)$binomial_deviance, type="l", xlab="ranked genes",
     ylab="binomial deviance", main="Feature Selection with Deviance")
abline(v=2000, lty=2, col="red")

## -----------------------------------------------------------------------------
sce2<-sce[1:1000, ]

## ----fig.width=6, fig.height=4------------------------------------------------
set.seed(101)
sce2<-GLMPCA(sce2, 2, assay="counts")
fit<-metadata(sce2)$glmpca
pd<-cbind(as.data.frame(colData(sce2)), fit$factors)
ggplot(pd, aes(x=dim1, y=dim2, colour=phenoid)) + geom_point(size=.8) +
  ggtitle("GLM-PCA applied to high deviance genes")

## ----fig.width=6, fig.height=8------------------------------------------------
sce<-nullResiduals(sce, assay="counts", type="deviance")
sce<-nullResiduals(sce, assay="counts", type="pearson")
sce2<-sce[1:1000, ] #use only the high deviance genes
pca<-function(Y, L=2, center=TRUE, scale=TRUE){
    #assumes features=rows, observations=cols
    res<-prcomp(as.matrix(t(Y)), center=center, scale.=scale, rank.=L)
    factors<-as.data.frame(res$x)
    colnames(factors)<-paste0("dim", 1:L)
    factors
}
pca_d<-pca(assay(sce2, "binomial_deviance_residuals"))
pca_d$resid_type<-"deviance_residuals"
pca_p<-pca(assay(sce2, "binomial_pearson_residuals"))
pca_p$resid_type<-"pearson_residuals"
cm<-as.data.frame(colData(sce2))
pd<-rbind(cbind(cm, pca_d), cbind(cm, pca_p))
ggplot(pd, aes(x=dim1, y=dim2, colour=phenoid)) + geom_point() +
  facet_wrap(~resid_type, scales="free", nrow=2) +
  ggtitle("PCA applied to null residuals of high deviance genes")

