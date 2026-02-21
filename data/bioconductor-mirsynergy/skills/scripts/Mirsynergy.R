# Code example from 'Mirsynergy' vignette. See references/ for full tutorial.

### R code from vignette source 'Mirsynergy.Rnw'

###################################################
### code chunk number 1: simulation
###################################################
library(Mirsynergy)

load(system.file("extdata/toy_modules.RData", package="Mirsynergy"))

# run mirsynergy clustering
V <- mirsynergy(W, H, verbose=FALSE)

summary_modules(V)


###################################################
### code chunk number 2: toy
###################################################
load(system.file("extdata/toy_modules.RData", package="Mirsynergy"))

plot_modules(V,W,H)


###################################################
### code chunk number 3: brca data
###################################################
load(system.file("extdata/tcga_brca_testdata.RData", package="Mirsynergy"))


###################################################
### code chunk number 4: lasso
###################################################
library(glmnet)
ptm <- proc.time()

# lasso across all samples
# X: N x T (input variables)
# 
obs <- t(Z)  # T x M

# run LASSO to construct W
W <- lapply(1:nrow(X), function(i) {				
	
	pred <- matrix(rep(0, nrow(Z)), nrow=1,
		dimnames=list(rownames(X)[i], rownames(Z)))
		
	c_i <- t(matrix(rep(C[i,,drop=FALSE], nrow(obs)), ncol=nrow(obs)))
	
	c_i <- (c_i > 0) + 0 # convert to binary matrix
	
	inp <- obs * c_i
	
	# use only miRNA with at least one non-zero entry across T samples
	inp <- inp[, apply(abs(inp), 2, max)>0, drop=FALSE]
	
	if(ncol(inp) >= 2) {
		
		# NOTE: negative coef means potential parget (remove intercept)
#		x <- coef(cv.glmnet(inp, X[i,], nfolds=3), s="lambda.min")[-1]
		x <- as.numeric(coef(glmnet(inp, X[i,]), s=0.1)[-1])
		pred[, match(colnames(inp), colnames(pred))] <- x
	}
	pred[pred>0] <- 0
	
	pred <- abs(pred)
	
	pred[pred>1] <- 1	
	
	pred
})

W <- do.call("rbind", W)

dimnames(W) <- dimnames(C)

print(sprintf("Time elapsed for LASSO: %.3f (min)",
	(proc.time() - ptm)[3]/60))


###################################################
### code chunk number 5: mirsynergy
###################################################
V <- mirsynergy(W, H, verbose=FALSE)

print_modules2(V)

print(sprintf("Time elapsed (LASSO+Mirsynergy): %.3f (min)", 
  (proc.time() - ptm)[3]/60))


###################################################
### code chunk number 6: plot_module_summary
###################################################
plot_module_summary(V)


###################################################
### code chunk number 7: sessi
###################################################
sessionInfo()


