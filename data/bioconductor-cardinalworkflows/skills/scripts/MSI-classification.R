# Code example from 'MSI-classification' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----setup, echo=FALSE, message=FALSE-----------------------------------------
library(Cardinal)
RNGkind("L'Ecuyer-CMRG")
setCardinalVerbose(FALSE)

## ----library, eval=FALSE------------------------------------------------------
# library(Cardinal)

## ----load-rcc-----------------------------------------------------------------
rcc <- CardinalWorkflows::exampleMSIData("rcc")

## ----show-rcc-----------------------------------------------------------------
rcc

## ----rcc-diagnosis------------------------------------------------------------
image(rcc, "diagnosis", layout=c(2,4), free="xy", col=dpal("Set1"))

## ----rcc-tic------------------------------------------------------------------
rcc <- summarizePixels(rcc, stat=c(TIC="sum"))

## ----plot-cardinal-tic--------------------------------------------------------
image(rcc, "TIC", layout=c(2,4), free="xy")

## ----rcc-peak-pick------------------------------------------------------------
rcc_peaks <- rcc |>
	normalize(method="tic") |>
	peakProcess(SNR=3, filterFreq=FALSE,
		tolerance=0.5, units="mz")

rcc_peaks

## ----rcc-subset---------------------------------------------------------------
rcc_nobg <- subsetPixels(rcc_peaks, !is.na(diagnosis))
rcc_nobg

## ----mz-810-------------------------------------------------------------------
image(rcc_peaks, mz=810.36, layout=c(2,4), free="xy",
	smooth="bilateral", enhance="histogram", scale=TRUE)

## ----mz-886-------------------------------------------------------------------
image(rcc_peaks, mz=886.43, layout=c(2,4), free="xy",
	smooth="bilateral", enhance="histogram", scale=TRUE)

## ----mz-215-------------------------------------------------------------------
image(rcc_peaks, mz=215.24, layout=c(2,4), free="xy",
	smooth="bilateral", enhance="histogram", scale=TRUE)

## ----rcc-pca------------------------------------------------------------------
rcc_pca <- PCA(rcc_nobg, ncomp=2)

## ----pca-image----------------------------------------------------------------
image(rcc_pca, type="x", layout=c(2,4), free="xy", scale=TRUE)

## ----pca-scores-diagnosis-----------------------------------------------------
plot(rcc_pca, type="x", groups=rcc_nobg$diagnosis, shape=20)

## ----pca-scores-run-----------------------------------------------------------
plot(rcc_pca, type="x", groups=run(rcc_nobg), shape=20)

## ----rcc-nmf------------------------------------------------------------------
rcc_nmf <- NMF(rcc_nobg, ncomp=2, niter=5)

## ----nmf-image----------------------------------------------------------------
image(rcc_nmf, type="x", layout=c(2,4), free="xy", scale=TRUE)

## ----nmf-scores-diagnosis-----------------------------------------------------
plot(rcc_nmf, type="x", groups=rcc_nobg$diagnosis, shape=20)

## ----nmf-scores-run-----------------------------------------------------------
plot(rcc_nmf, type="x", groups=run(rcc_nobg), shape=20)

## ----rcc-cv-------------------------------------------------------------------
rcc_ssc_cv <- crossValidate(spatialShrunkenCentroids,
	x=rcc_nobg, y=rcc_nobg$diagnosis, r=1, s=2^(1:5),
	folds=run(rcc_nobg))

rcc_ssc_cv

## ----rcc-ssc-image------------------------------------------------------------
image(rcc_ssc_cv, i=4, layout=c(2,4), free="xy", col=dpal("Set1"))

## ----rcc-ssc-best-------------------------------------------------------------
rcc_ssc1 <- spatialShrunkenCentroids(rcc_nobg,
	y=rcc_nobg$diagnosis, r=1, s=16)

rcc_ssc1

## ----rcc-ssc-mean-------------------------------------------------------------
plot(rcc_ssc1, type="centers", linewidth=2)

## ----rcc-statistic------------------------------------------------------------
plot(rcc_ssc1, type="statistic", linewidth=2)

## ----top-features-------------------------------------------------------------
rcc_ssc_top <- topFeatures(rcc_ssc1)

## ----top-cancer---------------------------------------------------------------
subset(rcc_ssc_top, class=="cancer")

## ----top-mz-886---------------------------------------------------------------
image(rcc_peaks, mz=886.4, layout=c(2,4), free="xy",
	smooth="bilateral", enhance="histogram", scale=TRUE)

## ----top-normal---------------------------------------------------------------
subset(rcc_ssc_top, class=="normal")

## ----top-mz-215---------------------------------------------------------------
image(rcc_peaks, mz=215.24, layout=c(2,4), free="xy",
	smooth="bilateral", enhance="histogram", scale=TRUE)

## ----rcc-split----------------------------------------------------------------
x_threshold <- c(35, 23, 28, 39, 29, 28, 47, 32)

rcc_peaks$rough_diagnosis <- factor("normal", levels=c("cancer", "normal"))

for ( i in seq_len(nrun(rcc_peaks)) ) {
	irun <- run(rcc_peaks) == runNames(rcc_peaks)[i]
	j <- irun & coord(rcc_peaks)$x < x_threshold[i]
	pData(rcc_peaks)$rough_diagnosis[j] <- "cancer"
}

rcc_peaks$samples <- interaction(run(rcc_peaks), rcc_peaks$rough_diagnosis)

## ----rcc-check----------------------------------------------------------------
tapply(rcc_peaks$diagnosis, rcc_peaks$samples,
	function(cond) unique(as.character(cond)[!is.na(cond)]))

## ----rcc-folds----------------------------------------------------------------
fold1 <- run(rcc_peaks) %in% runNames(rcc_peaks)[1:4]

rcc_peaks$folds <- factor(ifelse(fold1, "fold1", "fold2"))

## ----rcc-mi-------------------------------------------------------------------
rcc_ssc_cvmi <- crossValidate(spatialShrunkenCentroids,
	x=rcc_peaks, y=rcc_peaks$diagnosis, r=1, s=2^(1:4),
	folds=rcc_peaks$folds, bags=rcc_peaks$samples)

rcc_ssc_cvmi

## ----rcc-mi-image-------------------------------------------------------------
image(rcc_ssc_cvmi, i=3, layout=c(2,4), free="xy", col=dpal("Set1"),
	subset=!is.na(rcc_peaks$diagnosis))

## ----session-info-------------------------------------------------------------
sessionInfo()

