# Code example from 'Cardinal3-stats' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----setup, echo=FALSE, message=FALSE-----------------------------------------
library(Cardinal)

## ----eda-data, fig.height=4, fig.width=5, fig.align='center'------------------
set.seed(2020, kind="L'Ecuyer-CMRG")
mse <- simulateImage(preset=2, dim=c(32,32), sdnoise=0.5,
	peakheight=c(2,4), centroided=TRUE)

mse$design <- makeFactor(circle=mse$circle,
	square=mse$square, bg=!(mse$circle | mse$square))

image(mse, "design")

## ----eda-image, fig.height=4, fig.width=9-------------------------------------
image(mse, i=c(5, 13, 21), layout=c(1,3))

## ----pca----------------------------------------------------------------------
pca <- PCA(mse, ncomp=3)
pca

## ----pca-image, fig.height=4, fig.width=9-------------------------------------
image(pca, type="x", superpose=FALSE, layout=c(1,3), scale=TRUE)

## ----pca-loadings, fig.height=3, fig.width=9----------------------------------
plot(pca, type="rotation", superpose=FALSE, layout=c(1,3), linewidth=2)

## ----pca-scores, fig.height=4, fig.width=9------------------------------------
plot(pca, type="x", groups=mse$design, linewidth=2)

## ----nmf----------------------------------------------------------------------
nmf <- NMF(mse, ncomp=3)
nmf

## ----nmf-image, fig.height=4, fig.width=9-------------------------------------
image(nmf, type="x", superpose=FALSE, layout=c(1,3), scale=TRUE)

## ----nmf-loadings, fig.height=3, fig.width=9----------------------------------
plot(nmf, type="activation", superpose=FALSE, layout=c(1,3), linewidth=2)

## ----nmf-scores, fig.height=4, fig.width=9------------------------------------
plot(nmf, type="x", groups=mse$design, linewidth=2)

## ----colocalized--------------------------------------------------------------
coloc <- colocalized(mse, mz=1003.3)
coloc

## ----colocalized-images, fig.height=4, fig.width=9----------------------------
image(mse, mz=coloc$mz[1:3], layout=c(1,3))

## ----ssc-clustering-----------------------------------------------------------
set.seed(2020, kind="L'Ecuyer-CMRG")
ssc <- spatialShrunkenCentroids(mse, r=1, k=3, s=c(0,6,12,18))
ssc

## ----ssc-image, fig.height=4, fig.width=9-------------------------------------
image(ssc, i=1:3, type="probability", layout=c(1,3))

## ----ssc-statistic, fig.height=3, fig.width=9---------------------------------
plot(ssc, i=1:3, type="statistic", layout=c(1,3),
	linewidth=2, annPeaks="circle")

## ----ssc-top, fig.height=4, fig.width=9---------------------------------------
ssc_top <- topFeatures(ssc[[2L]])
ssc_top

ssc_top_cl3 <- subset(ssc_top, class==1)
image(mse, mz=ssc_top_cl3$mz[1:3], layout=c(1,3))

## ----dgmm---------------------------------------------------------------------
set.seed(2020, kind="L'Ecuyer-CMRG")
dgmm <- spatialDGMM(mse, r=1, k=3, weights="gaussian")
dgmm

## ----dgmm-image, fig.height=4, fig.width=9------------------------------------
image(dgmm, i=c(5, 13, 21), layout=c(1,3))

## ----dgmm-plot, fig.height=3, fig.width=9-------------------------------------
plot(dgmm, i=c(5, 13, 21), layout=c(1,3), linewidth=2)

## ----dgmm-colocalized, fig.height=4, fig.width=9------------------------------
coloc2 <- colocalized(dgmm, mse$square)
coloc2

image(mse, mz=coloc2$mz[1:3], layout=c(1,3))

## ----classification-data, fig.height=4, fig.width=9---------------------------
set.seed(2020, kind="L'Ecuyer-CMRG")
mse2 <- simulateImage(preset=7, dim=c(32,32), sdnoise=0.3,
	nrun=3, peakdiff=2, centroided=TRUE)

mse2$class <- makeFactor(A=mse2$circleA, B=mse2$circleB)

image(mse2, "class", layout=c(1,3))

## ----classification-images, fig.height=4, fig.width=9-------------------------
image(mse2, i=1, layout=c(1,3))

## ----pls-cv-------------------------------------------------------------------
cv_pls <- crossValidate(PLS, x=mse2, y=mse2$class, ncomp=1:5, folds=run(mse2))
cv_pls

## ----pls----------------------------------------------------------------------
pls <- PLS(mse2, y=mse2$class, ncomp=4)
pls

## ----pls-image, fig.height=4, fig.width=9-------------------------------------
image(pls, type="response", layout=c(1,3), scale=TRUE)

## ----pls-coefficients, fig.height=3, fig.width=9------------------------------
plot(pls, type="coefficients", linewidth=2, annPeaks="circle")

## ----pls-scores, fig.height=4, fig.width=9------------------------------------
plot(pls, type="scores", groups=mse2$class, linewidth=2)

## ----ssc-cv-------------------------------------------------------------------
cv_ssc <- crossValidate(spatialShrunkenCentroids, x=mse2, y=mse2$class,
	r=2, s=c(0,3,6,9,12,15,18), folds=run(mse2))
cv_ssc

## ----ssc-classification-------------------------------------------------------
ssc2 <- spatialShrunkenCentroids(mse2, y=mse2$class, r=2, s=9)
ssc2

## ----ssc-image-2, fig.height=4, fig.width=9-----------------------------------
image(ssc2, type="probability", layout=c(1,3),
	subset=mse2$circleA | mse2$circleB)

## ----ssc-statistic-2, fig.height=4, fig.width=9-------------------------------
plot(ssc2, type="statistic", linewidth=2, annPeaks="circle")

## ----ssc-top-2----------------------------------------------------------------
ssc2_top <- topFeatures(ssc2)

subset(ssc2_top, class == "B")

## ----test-data, fig.height=7, fig.width=9-------------------------------------
set.seed(2020, kind="L'Ecuyer-CMRG")
mse3 <- simulateImage(preset=4, npeaks=10, dim=c(32,32), sdnoise=0.3,
	nrun=4, peakdiff=2, centroided=TRUE)

mse3$trt <- makeFactor(A=mse3$circleA, B=mse3$circleB)

image(mse3, "trt", layout=c(2,4))

## ----test-image, fig.height=7, fig.width=9------------------------------------
image(mse3, i=1, layout=c(2,4))

## ----test-diff----------------------------------------------------------------
featureData(mse3)

## ----test-mean-test-----------------------------------------------------------
mtest <- meansTest(mse3, ~ condition, samples=run(mse3))
mtest

## ----test-mean-plot, fig.height=5, fig.width=9--------------------------------
plot(mtest, i=1:10, layout=c(2,5), ylab="Intensity", fill=TRUE)

## ----test-mean-top------------------------------------------------------------
mtest_top <- topFeatures(mtest)

subset(mtest_top, fdr < 0.05)

## ----test-segment-dgmm--------------------------------------------------------
set.seed(2020, kind="L'Ecuyer-CMRG")
dgmm2 <- spatialDGMM(mse3, r=2, k=2, groups=run(mse3))

## ----test-segment-test--------------------------------------------------------
stest <- meansTest(dgmm2, ~ condition)

stest

## ----test-segment-plot, fig.height=5, fig.width=9-----------------------------
plot(stest, i=1:10, layout=c(2,5), ylab="Intensity", fill=TRUE)

## ----test-segment-top---------------------------------------------------------
stest_top <- topFeatures(stest)

subset(stest_top, fdr < 0.05)

## ----session-info-------------------------------------------------------------
sessionInfo()

