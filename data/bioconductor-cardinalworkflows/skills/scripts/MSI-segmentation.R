# Code example from 'MSI-segmentation' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----setup, echo=FALSE, message=FALSE-----------------------------------------
library(Cardinal)
RNGkind("L'Ecuyer-CMRG")
setCardinalVerbose(FALSE)

## ----library, eval=FALSE------------------------------------------------------
# library(Cardinal)

## ----load-pig206--------------------------------------------------------------
pig206 <- CardinalWorkflows::exampleMSIData("pig206")

## ----show-pig206--------------------------------------------------------------
pig206

## ----mz-885-------------------------------------------------------------------
image(pig206, mz=885.5, tolerance=0.5, units="mz")

## ----pig206-mean--------------------------------------------------------------
pig206 <- summarizeFeatures(pig206, c(Mean="mean"))

## ----plot-pig206-mean---------------------------------------------------------
plot(pig206, "Mean", xlab="m/z", ylab="Intensity")

## ----pig206-tic---------------------------------------------------------------
pig206 <- summarizePixels(pig206, c(TIC="sum"))

## ----plot-pig206-tic----------------------------------------------------------
image(pig206, "TIC")

## ----peak-process-------------------------------------------------------------
pig206_peaks <- pig206 |>
	normalize(method="tic") |>
	peakProcess(SNR=3, sampleSize=0.1,
		tolerance=0.5, units="mz")

pig206_peaks

## ----mz-187-------------------------------------------------------------------
image(pig206_peaks, mz=187.36)

## ----mz-840-------------------------------------------------------------------
image(pig206_peaks, mz=840.43)

## ----mz-537-------------------------------------------------------------------
image(pig206_peaks, mz=537.08)

## -----------------------------------------------------------------------------
pig206_pca <- PCA(pig206_peaks, ncomp=3)

pig206_pca

## -----------------------------------------------------------------------------
image(pig206_pca, smooth="adaptive", enhance="histogram")

## -----------------------------------------------------------------------------
plot(pig206_pca, linewidth=2)

## -----------------------------------------------------------------------------
pig206_nmf <- NMF(pig206_peaks, ncomp=3, niter=30)

pig206_nmf

## -----------------------------------------------------------------------------
image(pig206_nmf, smooth="adaptive", enhance="histogram")

## -----------------------------------------------------------------------------
plot(pig206_nmf, linewidth=2)

## ----ssc----------------------------------------------------------------------
set.seed(1)
pig206_ssc <- spatialShrunkenCentroids(pig206_peaks,
	weights="adaptive", r=2, k=8, s=2^(1:6))

pig206_ssc

## ----ssc-image-multi----------------------------------------------------------
image(pig206_ssc, i=3:6)

## ----ssc-image-best-----------------------------------------------------------
pig206_ssc1 <- pig206_ssc[[5]]

image(pig206_ssc1)

## ----ssc-image-class----------------------------------------------------------
image(pig206_ssc1, type="class")

## ----ssc-centers--------------------------------------------------------------
plot(pig206_ssc1, type="centers", linewidth=2)

## ----ssc-centers-2------------------------------------------------------------
plot(pig206_ssc1, type="centers", linewidth=2,
	select=c(4,5,6), superpose=FALSE, layout=c(1,3))

## ----ssc-statistic------------------------------------------------------------
plot(pig206_ssc1, type="statistic", linewidth=2)

## ----ssc-statistic-2----------------------------------------------------------
plot(pig206_ssc1, type="statistic", linewidth=2,
	select=c(4,5,6), superpose=FALSE, layout=c(1,3))

## ----top-ssc------------------------------------------------------------------
pig206_ssc_top <- topFeatures(pig206_ssc1)

## ----top-liver----------------------------------------------------------------
subset(pig206_ssc_top, class==4 & statistic > 0)

## ----top-heart----------------------------------------------------------------
subset(pig206_ssc_top, class==5 & statistic > 0)

## ----top-brain----------------------------------------------------------------
subset(pig206_ssc_top, class==6 & statistic > 0)

## ----load-cardinal------------------------------------------------------------
cardinal <- CardinalWorkflows::exampleMSIData("cardinal")

## ----show-cardinal------------------------------------------------------------
cardinal

## ----cardinal-mean------------------------------------------------------------
cardinal <- summarizeFeatures(cardinal, c(Mean="mean"))

## ----plot-cardinal-mean-------------------------------------------------------
plot(cardinal, "Mean", xlab="m/z", ylab="Intensity")

## ----cardinal-tic-------------------------------------------------------------
cardinal <- summarizePixels(cardinal, c(TIC="sum"))

## ----plot-cardinal-tic--------------------------------------------------------
image(cardinal, "TIC")

## ----cardinal-process---------------------------------------------------------
cardinal_peaks <- cardinal |>
	normalize(method="tic") |>
	peakProcess(SNR=3, sampleSize=0.1,
		tolerance=0.5, units="mz")

cardinal_peaks

## ----ssc-cardinal-------------------------------------------------------------
set.seed(1)
cardinal_ssc <- spatialShrunkenCentroids(cardinal_peaks,
	weights="adaptive", r=2, k=8, s=2^(1:6))

cardinal_ssc

## ----ssc-cardinal-multi-------------------------------------------------------
image(cardinal_ssc, i=3:6)

## ----ssc-cardinal-image-------------------------------------------------------
cardinal_ssc1 <- cardinal_ssc[[3]]

pal <- c("1"=NA, "2"="firebrick", "3"=NA, "4"="black",
	"5"="red", "6"="gray", "7"=NA, "8"="darkred")

image(cardinal_ssc1, col=pal)

## ----top-body-----------------------------------------------------------------
cardinal_ssc_top <- topFeatures(cardinal_ssc1)

subset(cardinal_ssc_top, class==5)

image(cardinal_peaks, mz=207.05, smooth="guided", enhance="histogram")

## ----top-text-----------------------------------------------------------------
subset(cardinal_ssc_top, class==2)

image(cardinal_peaks, mz=648.99, smooth="guided", enhance="histogram")

## ----session-info-------------------------------------------------------------
sessionInfo()

