# Code example from 'RIVER' vignette. See references/ for full tutorial.

## ----ultaQuick----------------------------------------------------------------
library("RIVER")

## -----------------------------------------------------------------------------
filename <- system.file("extdata", "simulation_RIVER.gz", 
                       package="RIVER")
dataInput <- getData(filename) # import experimental data

## -----------------------------------------------------------------------------
print(dataInput)
Feat <- t(Biobase::exprs(dataInput)) # genomic features (G)
Out <- as.numeric(unlist(dataInput$Outlier))-1 # outlier status (E)

## -----------------------------------------------------------------------------
head(Feat)
head(Out)

## -----------------------------------------------------------------------------
evaROC <- evaRIVER(dataInput)

## -----------------------------------------------------------------------------
cat('AUC (GAM-genomic annotation model) = ', round(evaROC$GAM_auc,3), '\n')
cat('AUC (RIVER) = ', round(evaROC$RIVER_auc,3), '\n')
cat('P-value ', format.pval(evaROC$pvalue, digits=2, eps=0.001), '***\n')

## -----------------------------------------------------------------------------
par(mar=c(6.1, 6.1, 4.1, 4.1))
plot(NULL, xlim=c(0,1), ylim=c(0,1), 
     xlab="False positive rate", ylab="True positive rate", 
     cex.axis=1.3, cex.lab=1.6)
abline(0, 1, col="gray")
lines(1-evaROC$RIVER_spec, evaROC$RIVER_sens, 
      type="s", col='dodgerblue', lwd=2)
lines(1-evaROC$GAM_spec, evaROC$GAM_sens, 
      type="s", col='mediumpurple', lwd=2)
legend(0.7,0.2,c("RIVER","GAM"), lty=c(1,1), lwd=c(2,2),
       col=c("dodgerblue","mediumpurple"), cex=1.2, 
       pt.cex=1.2, bty="n")
title(main=paste("AUC: RIVER = ", round(evaROC$RIVER_auc,3), 
                 ", GAM = ", round(evaROC$GAM_auc,3), 
                 ", P = ", format.pval(evaROC$pvalue, digits=2, 
                                       eps=0.001),sep=""))

## -----------------------------------------------------------------------------
postprobs <- appRIVER(dataInput)

## -----------------------------------------------------------------------------
example_probs <- data.frame(Subject=postprobs$indiv_name, 
                           Gene=postprobs$gene_name, 
                           RIVERpp=postprobs$RIVER_posterior, 
                           GAMpp=postprobs$GAM_posterior)
head(example_probs)

## -----------------------------------------------------------------------------
plotPosteriors(postprobs, outliers=as.numeric(unlist(dataInput$Outlier))-1)

## -----------------------------------------------------------------------------
filename <- system.file("extdata", "simulation_RIVER.gz", 
                       package="RIVER")
dataInput <- getData(filename) # import experimental data
evaROC <- evaRIVER(dataInput, pseudoc=50, 
                   theta_init=matrix(c(.99, .01, .3, .7), nrow=2), 
                   costs=c(100, 10, 1, .1, .01, 1e-3, 1e-4), 
                   verbose=TRUE)

## -----------------------------------------------------------------------------
postprobs <- appRIVER(dataInput, pseudoc=50, 
                      theta_init=matrix(c(.99, .01, .3, .7), nrow=2), 
                      costs=c(100, 10, 1, .1, .01, 1e-3, 1e-4), 
                      verbose=TRUE)

## -----------------------------------------------------------------------------
print(postprobs$fitRIVER$beta)

## -----------------------------------------------------------------------------
print(postprobs$fitRIVER$theta)

## -----------------------------------------------------------------------------
filename <- system.file("extdata", "simulation_RIVER.gz", 
                       package = "RIVER")
system(paste('zcat ', filename, " | head  -2", sep=""), 
       ignore.stderr=TRUE)

## -----------------------------------------------------------------------------
YourInputToRIVER <- getData(filename) # import experimental data

## ----eval=FALSE---------------------------------------------------------------
# ## try http:// if https:// URLs are not supported
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("RIVER")

## ---------------------------------------------------------------------------------------------------------------------
## Session info
library('devtools')
options(width=120)
session_info()

