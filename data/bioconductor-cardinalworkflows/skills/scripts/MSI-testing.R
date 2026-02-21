# Code example from 'MSI-testing' vignette. See references/ for full tutorial.

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
	peakProcess(SNR=3, sampleSize=0.1, filterFreq=0.2,
		tolerance=0.5, units="mz")

rcc_peaks

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
rcc_peaks$cancer <- ifelse(rcc_peaks$rough_diagnosis=="cancer",
	rcc_peaks$TIC, 0)
rcc_peaks$normal <- ifelse(rcc_peaks$rough_diagnosis=="normal",
	rcc_peaks$TIC, 0)

image(rcc_peaks, c("cancer", "normal"), superpose=TRUE,
	layout=c(2,4), free="xy", col=dpal("Set1"),
	enhance="histogram", scale=TRUE)

## ----rcc-var------------------------------------------------------------------
rcc_peaks <- summarizeFeatures(rcc_peaks, stat=c(Variance="var"))

plot(rcc_peaks, "Variance", xlab="m/z", ylab="Intensity")

## ----rcc-filter---------------------------------------------------------------
rcc_peaks <- subsetFeatures(rcc_peaks, Variance >= quantile(Variance, 0.8))

rcc_peaks

## ----dgmm---------------------------------------------------------------------
set.seed(1)
rcc_dgmm <- spatialDGMM(rcc_peaks, r=1, k=3, groups=rcc_peaks$samples)

rcc_dgmm

## ----dgmm-image---------------------------------------------------------------
image(rcc_dgmm, i=2, layout=c(2,4), free="xy")

## ----dgmm-plot----------------------------------------------------------------
plot(rcc_dgmm, i=2)

## ----mtest--------------------------------------------------------------------
rcc_mtest <- meansTest(rcc_peaks, ~rough_diagnosis, samples=rcc_peaks$samples)

rcc_mtest

## ----mtest-top----------------------------------------------------------------
rcc_mtest_top <- topFeatures(rcc_mtest)

subset(rcc_mtest_top, fdr < 0.05)

## ----stest--------------------------------------------------------------------
rcc_stest <- meansTest(rcc_dgmm, ~rough_diagnosis)

rcc_stest

## ----stest-top----------------------------------------------------------------
rcc_stest_top <- topFeatures(rcc_stest)

subset(rcc_stest_top, fdr < 0.05)

## ----stest-plot---------------------------------------------------------------
plot(rcc_stest, i=c("m/z = 884.40"=51, "m/z = 885.44"=52), col=dpal("Set1"))

## ----stest-image--------------------------------------------------------------
image(rcc_peaks, mz=885.43, layout=c(2,4), free="xy",
	smooth="bilateral", enhance="adaptive", scale=TRUE)

## ----session-info-------------------------------------------------------------
sessionInfo()

