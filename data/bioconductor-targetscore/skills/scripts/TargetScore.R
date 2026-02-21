# Code example from 'TargetScore' vignette. See references/ for full tutorial.

### R code from vignette source 'TargetScore.Rnw'

###################################################
### code chunk number 1: TargetScore
###################################################
library(TargetScore)


###################################################
### code chunk number 2: helppage (eval = FALSE)
###################################################
## ?TargetScore


###################################################
### code chunk number 3: toy
###################################################
trmt <- c(rnorm(10,mean=0.01), rnorm(1000,mean=1), rnorm(90,mean=2)) + 1e3

ctrl <- c(rnorm(1100,mean=1)) + 1e3

logFC <- log2(trmt) - log2(ctrl)

# 8 out of the 10 down-reg genes have prominent seq score A
seqScoreA <- c(rnorm(8,mean=-2), rnorm(1092,mean=0))

# 10 down-reg genes plus 10 more genes have prominent seq score B
seqScoreB <- c(rnorm(20,mean=-2), rnorm(1080,mean=0))

seqScores <- cbind(seqScoreA, seqScoreB)             

p.targetScore <- targetScore(logFC, seqScores, tol=1e-3)

# plot relation between targetScore and input variables
pairs(cbind(p.targetScore, logFC, seqScoreA, seqScoreB))


###################################################
### code chunk number 4: realtest
###################################################
extdata.dir <- system.file("extdata", package="TargetScore") 

# load test data
load(list.files(extdata.dir, "\\.RData$", full.names=TRUE))

myTargetScores <- lapply(mytestdata, function(x) targetScore(logFC=x$logFC, seqScores=x[,c(3,4)], tol=1e3, maxiter=200))

names(myTargetScores) <- names(mytestdata)

valid <- lapply(names(myTargetScores), function(x) table((myTargetScores[[x]] > 0.3), mytestdata[[x]]$validated))

names(valid) <- names(mytestdata)

# row pred and col validated targets
valid


###################################################
### code chunk number 5: getTargetScores demo (eval = FALSE)
###################################################
## library(TargetScoreData)
## library(gplots)
## 
## myTargetScores <- getTargetScores("hsa-miR-1", tol=1e-3, maxiter=200)
## 
## table((myTargetScores$targetScore > 0.1), myTargetScores$validated) # a very lenient cutoff
## 
## # obtain all of targetScore for all of the 112 miRNA (takes time)
## 
## logFC.imputed <- get_precomputed_logFC()
## 
## mirIDs <- unique(colnames(logFC.imputed))
## 
## # targetScoreMatrix <- mclapply(mirIDs, getTargetScores)
## 
## # names(targetScoreMatrix) <- mirIDs


###################################################
### code chunk number 6: getTargetScores limma demo (eval = FALSE)
###################################################
## # Demo using limma
## # download GEO data for hsa-miR-205
## library(limma)
## library(Biobase)
## library(GEOquery)
## library(gplots)
## 
## gset <- getGEO("GSE11701", GSEMatrix =TRUE, AnnotGPL=TRUE)
## 
## if (length(gset) > 1) idx <- grep("GPL6104", attr(gset, "names")) else idx <- 1
## 
## gset <- gset[[idx]]
## 
## geneInfo <- fData(gset)
## 
## x <- normalizeVSN(exprs(gset))
## 
## pData(gset)$title
## 
## design <- model.matrix(~0+factor(c(1,1,1,1,2,2,2,2)))
## 
## colnames(design) <- c("preNeg_control", "miR_205_transfect")
## 
## fit <- lmFit(x, design)
## 
## #contrast
## contrast.matrix <- makeContrasts(miR_205_transfect-preNeg_control,levels=design)
## 
## fit2 <- contrasts.fit(fit, contrast.matrix)
## 
## fit2 <- eBayes(fit2)
## 
## limma_stats <- topTable(fit2, coef=1, number=nrow(fit2))
## 
## limma_stats$gene_symbol <- geneInfo[match(limma_stats$ID, geneInfo$ID), "Gene symbol"]
## 
## logFC <- as.matrix(limma_stats$logFC)
## 
## rownames(logFC) <- limma_stats$gene_symbol
## 
## # targetScore
## myTargetScores <- getTargetScores("hsa-miR-205", logFC, tol=1e-3, maxiter=200)


###################################################
### code chunk number 7: ROC (eval = FALSE)
###################################################
## library(ggplot2)
## library(scales)
## library(ROCR)
## 
## # ROC
## roceval <- function(myscores, labels_true, method) {
##   	
## 	pred <- prediction(myscores, labels_true)
## 		
## 	perf <- performance( pred, "tpr", "fpr" )
## 
## 	auc <- unlist(slot(performance( pred, "auc" ), "y.values"))
## 
## 	fpr <- unlist(slot(perf, "x.values"))
## 	
## 	tpr <- unlist(slot(perf, "y.values"))
##   
## 	cutoffval <- unlist(slot(perf, "alpha.values"))
## 
## 	rocdf <- data.frame(x= fpr, y=tpr, cutoff=cutoffval, auc=auc, method=method,
## 		methodScore=sprintf("%s (%s)", method, percent(auc)), curveType="ROC")
## 
## 	return(rocdf)	
## }
## 
## limma_stats$p.val <- -log10(limma_stats$P.Value)
## 
## limma_stats$p.val[logFC > 0] <- 0
## 
## 
## myeval <- rbind(
##   roceval(myTargetScores$targetScore, myTargetScores$validated, "TargetScore"),
## 	roceval(limma_stats$p.val, myTargetScores$validated, "Limma"))
## 
## 
## ggroc <- ggplot(myeval, aes(x=x, y=y, color=methodScore)) +
## 
## 	geom_line(aes(linetype=methodScore), size=0.7) +
## 	
## 	scale_x_continuous("False positive rate", labels=percent) +
## 	
## 	scale_y_continuous("True positive rate", labels=percent) +
## 	
## 	theme(legend.title= element_blank())
## 
## print(ggroc)
## 


###################################################
### code chunk number 8: getTargetScores deseq demo (eval = FALSE)
###################################################
## library(DESeq)
## 
## cds <- makeExampleCountDataSet()
## 
## cds <- estimateSizeFactors( cds )
## 
## cds <- estimateDispersions( cds )
## 
## deseq_stats <- nbinomTest( cds, "A", "B" )
## 
## logFC <- deseq_stats$log2FoldChange[1:100]
## 
## # random sequence score
## seqScoreA <- rnorm(length(logFC))
## 
## seqScoreB <- rnorm(length(logFC))
## 
## seqScores <- cbind(seqScoreA, seqScoreB)
## 
## p.targetScore <- targetScore(logFC, seqScores, tol=1e-3)


###################################################
### code chunk number 9: sessi
###################################################
sessionInfo()


