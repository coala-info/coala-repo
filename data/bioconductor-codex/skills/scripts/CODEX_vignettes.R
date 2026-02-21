# Code example from 'CODEX_vignettes' vignette. See references/ for full tutorial.

### R code from vignette source 'CODEX_vignettes.Rnw'

###################################################
### code chunk number 1: install1 (eval = FALSE)
###################################################
## ## try http:// if https:// URLs are not supported
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("CODEX")


###################################################
### code chunk number 2: install2 (eval = FALSE)
###################################################
## install.packages("devtools")
## library(devtools)
## install_github("yuchaojiang/CODEX/package")


###################################################
### code chunk number 3: bambedObj1
###################################################
library(CODEX)
library(WES.1KG.WUGSC) # Load Toy data from the 1000 Genomes Project.
dirPath <- system.file("extdata", package = "WES.1KG.WUGSC")
bamFile <- list.files(dirPath, pattern = '*.bam$')
bamdir <- file.path(dirPath, bamFile)
sampname <- as.matrix(read.table(file.path(dirPath, "sampname")))
bedFile <- file.path(dirPath, "chr22_400_to_500.bed")
chr <- 22
bambedObj <- getbambed(bamdir = bamdir, bedFile = bedFile, 
                       sampname = sampname, projectname = "CODEX_demo", chr)
bamdir <- bambedObj$bamdir; sampname <- bambedObj$sampname
ref <- bambedObj$ref; projectname <- bambedObj$projectname; chr <- bambedObj$chr


###################################################
### code chunk number 4: coverageObj1
###################################################
coverageObj <- getcoverage(bambedObj, mapqthres = 20)
Y <- coverageObj$Y; readlength <- coverageObj$readlength


###################################################
### code chunk number 5: gcmapp1
###################################################
gc <- getgc(chr, ref)
mapp <- getmapp(chr, ref)


###################################################
### code chunk number 6: qcObj1
###################################################
qcObj <- qc(Y, sampname, chr, ref, mapp, gc, cov_thresh = c(20, 4000), 
    length_thresh = c(20, 2000), mapp_thresh = 0.9, gc_thresh = c(20, 80))
Y_qc <- qcObj$Y_qc; sampname_qc <- qcObj$sampname_qc; gc_qc <- qcObj$gc_qc
mapp_qc <- qcObj$mapp_qc; ref_qc <- qcObj$ref_qc; qcmat <- qcObj$qcmat
write.table(qcmat, file = paste(projectname, '_', chr, '_qcmat', '.txt', sep=''),
            sep='\t', quote=FALSE, row.names=FALSE)


###################################################
### code chunk number 7: normObj1
###################################################
normObj <- normalize(Y_qc, gc_qc, K = 1:9)
Yhat <- normObj$Yhat; AIC <- normObj$AIC; BIC <- normObj$BIC
RSS <- normObj$RSS; K <- normObj$K


###################################################
### code chunk number 8: normObj2 (eval = FALSE)
###################################################
## normObj <- normalize2(Y_qc, gc_qc, K = 1:9, normal_index=seq(1,45,2))
## Yhat <- normObj$Yhat; AIC <- normObj$AIC; BIC <- normObj$BIC
## RSS <- normObj$RSS; K <- normObj$K


###################################################
### code chunk number 9: choiceofK (eval = FALSE)
###################################################
## choiceofK(AIC, BIC, RSS, K, filename = paste(projectname, "_", chr, 
##     "_choiceofK", ".pdf", sep = ""))


###################################################
### code chunk number 10: fig1
###################################################
filename <- paste(projectname, "_", chr, "_choiceofK", ".pdf", sep = "")
Kmax <- length(AIC)
par(mfrow = c(1, 3))
plot(K, RSS, type = "b", xlab = "Number of latent variables")
plot(K, AIC, type = "b", xlab = "Number of latent variables")
plot(K, BIC, type = "b", xlab = "Number of latent variables")


###################################################
### code chunk number 11: segment1
###################################################
optK = K[which.max(BIC)]
finalcall <- segment(Y_qc, Yhat, optK = optK, K = K, sampname_qc,
    ref_qc, chr, lmax = 200, mode = "integer")
finalcall


###################################################
### code chunk number 12: segment2 (eval = FALSE)
###################################################
## write.table(finalcall, file = paste(projectname, '_', chr, '_', optK,
##             '_CODEX_frac.txt', sep=''), sep='\t', quote=FALSE, row.names=FALSE)
## save.image(file = paste(projectname, '_', chr, '_image', '.rda', sep=''),
##      compress='xz')


###################################################
### code chunk number 13: sessionInfo
###################################################
toLatex(sessionInfo())


