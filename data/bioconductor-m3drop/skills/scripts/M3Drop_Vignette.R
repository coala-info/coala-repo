# Code example from 'M3Drop_Vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'M3Drop_Vignette.Rnw'

###################################################
### code chunk number 1: M3Drop_Vignette.Rnw:52-54
###################################################
library(M3Drop)
library(M3DExampleData)


###################################################
### code chunk number 2: M3Drop_Vignette.Rnw:61-66
###################################################
counts <- Mmus_example_list$data
labels <- Mmus_example_list$labels
total_features <- colSums(counts >= 0)
counts <- counts[,total_features >= 2000]
labels <- labels[total_features >= 2000]


###################################################
### code chunk number 3: M3Drop_Vignette.Rnw:74-75
###################################################
norm <- M3DropConvertData(counts, is.counts=TRUE)


###################################################
### code chunk number 4: M3Drop_Vignette.Rnw:80-81
###################################################
norm <- M3DropConvertData(log2(norm+1), is.log=TRUE, pseudocount=1)


###################################################
### code chunk number 5: M3Drop_Vignette.Rnw:92-103
###################################################
K <- 49
S_sim <- 10^seq(from=-3, to=4, by=0.05)
MM <- 1-S_sim/(K+S_sim)
plot(S_sim, MM, type="l", lwd=3, xlab="Expression", ylab="Dropout Rate", 
	xlim=c(1,1000))
S1 <- 10; P1 <- 1-S1/(K+S1);
S2 <- 750; P2 <- 1-S2/(K+S2);
points(c(S1,S2), c(P1,P2), pch=16, col="grey85", cex=3)
lines(c(S1, S2), c(P1,P2), lwd=2.5, lty=2, col="grey35")
mix <- 0.5;
points(S1*mix+S2*(1-mix), P1*mix+P2*(1-mix), pch=16, col="grey35", cex=3)


###################################################
### code chunk number 6: M3Drop_Vignette.Rnw:115-116
###################################################
M3Drop_genes <- M3DropFeatureSelection(norm, mt_method="fdr", mt_threshold=0.01)


###################################################
### code chunk number 7: M3Drop_Vignette.Rnw:153-154
###################################################
count_mat <- NBumiConvertData(Mmus_example_list$data, is.counts=TRUE)


###################################################
### code chunk number 8: M3Drop_Vignette.Rnw:163-169
###################################################
DANB_fit <- NBumiFitModel(count_mat)

# Smoothed gene-specific variances
par(mfrow=c(1,2))
stats <- NBumiCheckFitFS(count_mat, DANB_fit)
print(c(stats$gene_error,stats$cell_error))


###################################################
### code chunk number 9: M3Drop_Vignette.Rnw:182-183
###################################################
NBDropFS <- NBumiFeatureSelectionCombinedDrop(DANB_fit, method="fdr", qval.thres=0.01, suppress.plot=FALSE)


###################################################
### code chunk number 10: M3Drop_Vignette.Rnw:193-195
###################################################
pearson1 <- NBumiPearsonResiduals(count_mat, DANB_fit)
pearson2 <- NBumiPearsonResidualsApprox(count_mat, DANB_fit)


###################################################
### code chunk number 11: M3Drop_Vignette.Rnw:210-212
###################################################
pearson1[pearson1 > sqrt(ncol(count_mat))] <- sqrt(ncol(count_mat))
pearson1[pearson1 < -sqrt(ncol(count_mat))] <- -1*sqrt(ncol(count_mat))


###################################################
### code chunk number 12: M3Drop_Vignette.Rnw:231-232
###################################################
HVG <- BrenneckeGetVariableGenes(norm)


###################################################
### code chunk number 13: M3Drop_Vignette.Rnw:242-244
###################################################
heat_out <- M3DropExpressionHeatmap(M3Drop_genes$Gene, norm, 
		cell_labels = labels)


###################################################
### code chunk number 14: M3Drop_Vignette.Rnw:256-259
###################################################
cell_populations <- M3DropGetHeatmapClusters(heat_out, k=4, type="cell")
library("ROCR") 
marker_genes <- M3DropGetMarkers(norm, cell_populations)


###################################################
### code chunk number 15: M3Drop_Vignette.Rnw:271-273
###################################################
head(marker_genes[marker_genes$Group==4,],20) 
marker_genes[rownames(marker_genes)=="Cdx2",] 


###################################################
### code chunk number 16: M3Drop_Vignette.Rnw:288-290
###################################################
heat_out <- M3DropExpressionHeatmap(NBDropFS$Gene, norm, 
		cell_labels = labels)


###################################################
### code chunk number 17: M3Drop_Vignette.Rnw:307-309
###################################################
heat_out <- M3DropExpressionHeatmap(HVG, norm, 
		cell_labels = labels)


