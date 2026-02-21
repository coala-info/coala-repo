# Code example from 'Cardinal3-guide' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----setup, echo=FALSE, message=FALSE-----------------------------------------
library(Cardinal)

## ----install, eval=FALSE------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("Cardinal")

## ----library, eval=FALSE------------------------------------------------------
# library(Cardinal)

## ----read-imzML-continuous----------------------------------------------------
path_continuous <- CardinalIO::exampleImzMLFile("continuous")
path_continuous
mse_tiny <- readMSIData(path_continuous)
mse_tiny

## ----read-imzML-processed-----------------------------------------------------
path_processed <- CardinalIO::exampleImzMLFile("processed")
path_processed
msa_tiny <- readMSIData(path_processed)
msa_tiny

## ----show-MSImagingArrays-----------------------------------------------------
msa_tiny

## ----subset-MSImagingArrays---------------------------------------------------
msa_tiny[1:3]

## ----spectraData-MSImagingArrays----------------------------------------------
spectraData(msa_tiny)

## ----spectra-accessor---------------------------------------------------------
spectra(msa_tiny, "mz")
spectra(msa_tiny, "intensity")

## ----intensity-accessor-------------------------------------------------------
mz(msa_tiny)
intensity(msa_tiny)

## ----pixelData-MSImagingArrays------------------------------------------------
pixelData(msa_tiny)
pData(msa_tiny)

## ----coord-accessor-----------------------------------------------------------
coord(msa_tiny)

## ----run-accessor-------------------------------------------------------------
runNames(msa_tiny)
head(run(msa_tiny))

## ----show-MSImagingExperiment-------------------------------------------------
mse_tiny

## ----subset-MSImagingExperiment-----------------------------------------------
mse_tiny[1:500, 1:3]

## ----spectraData-MSImagingExperiment------------------------------------------
spectraData(mse_tiny)
spectra(mse_tiny)

## ----pixelData-MSImagingExperiment--------------------------------------------
pixelData(mse_tiny)

## ----featureData-accessor-----------------------------------------------------
featureData(mse_tiny)
fData(mse_tiny)

## ----mz-accessor--------------------------------------------------------------
head(mz(mse_tiny))

## ----constructor--------------------------------------------------------------
set.seed(2020, kind="L'Ecuyer-CMRG")
s <- simulateSpectra(n=9, npeaks=10, from=500, to=600)

coord <- expand.grid(x=1:3, y=1:3)
run <- factor(rep("run0", nrow(coord)))

fdata <- MassDataFrame(mz=s$mz)
pdata <- PositionDataFrame(run=run, coord=coord)

out <- MSImagingExperiment(spectraData=s$intensity,
	featureData=fdata,
	pixelData=pdata)
out

## ----simulate-----------------------------------------------------------------
# Simulate an MSImagingExperiment
set.seed(2020, kind="L'Ecuyer-CMRG")
mse <- simulateImage(preset=6, dim=c(32,32), baseline=0.5)
mse

# Create a version as MSImagingArrays
msa <- convertMSImagingExperiment2Arrays(mse)
msa

## ----plot-i, fig.height=3, fig.width=9----------------------------------------
plot(msa, i=c(496, 1520))

## ----plot-coord, fig.height=3, fig.width=9------------------------------------
plot(msa, coord=list(x=16, y=16))

## ----plot-superpose, fig.height=3, fig.width=9--------------------------------
plot(msa, i=c(496, 1520), xlim=c(1000, 1250),
	superpose=TRUE)

## ----image-i, fig.height=4, fig.width=9---------------------------------------
image(mse, i=1938)

## ----image-mz, fig.height=4, fig.width=9--------------------------------------
image(mse, mz=1003.3)

## ----image-plusminus, fig.height=4, fig.width=9-------------------------------
image(mse, mz=1003.3, tolerance=0.5, units="mz")

## ----image-run, fig.height=4, fig.width=5-------------------------------------
image(mse, mz=1003.3, run="runA1")

## ----image-subset, fig.height=4, fig.width=9----------------------------------
image(mse, mz=1003.3, subset=mse$circleA | mse$circleB)

## ----image-smooth, fig.height=4, fig.width=9----------------------------------
image(mse, mz=1003.3, smooth="gaussian")

## ----image-contrast, fig.height=4, fig.width=9--------------------------------
image(mse, mz=1003.3, enhance="histogram")

## ----image-superpose, fig.height=4, fig.width=9-------------------------------
image(mse, mz=c(1003.3, 1663.6), superpose=TRUE,
	enhance="adaptive", scale=TRUE)

## ----select-ROI, eval=FALSE---------------------------------------------------
# sampleA <- selectROI(mse, mz=1003.3, subset=run(mse) == "run0")
# sampleB <- selectROI(mse, mz=1003.3, subset=run(mse) == "run1")

## ----makeFactor, eval=FALSE---------------------------------------------------
# regions <- makeFactor(A=sampleA, B=sampleB)

## ----pdf, eval=FALSE----------------------------------------------------------
# pdffile <- tempfile(fileext=".pdf")
# 
# pdf(file=pdffile, width=9, height=4)
# image(mse, mz=1003.3)
# dev.off()

## ----style-dark, fig.height=4, fig.width=9------------------------------------
image(mse, mz=1003.3, style="dark")

## ----print--------------------------------------------------------------------
p <- image(mse, mz=1003.3)
plot(p, smooth="guide")

## ----subset-1-----------------------------------------------------------------
# subset first 5 mass spectra
msa[1:5]

## ----subset-2-----------------------------------------------------------------
# subset first 10 images and first 5 mass spectra
mse[1:10, 1:5]

## ----features-----------------------------------------------------------------
# get row index corresponding to m/z 1003.3
features(mse, mz=1003.3)

# get row indices corresponding to m/z 1002 - 1004
features(mse, 1002 < mz & mz < 1004)

## ----pixels-------------------------------------------------------------------
# get column indices corresponding to x = 10, y = 10 in all runs
pixels(mse, coord=list(x=10, y=10))

# get column indices corresponding to x <= 3, y <= 3 in "runA1"
pixels(mse, x <= 3, y <= 3, run == "runA1")

## ----subset-3-----------------------------------------------------------------
fid <- features(mse, 1002 < mz, mz < 1004)
pid <- pixels(mse, x <= 3, y <= 3, run == "runA1")
mse[fid, pid]

## ----subset-method-1----------------------------------------------------------
# subset MSImagingArrays
subset(msa, x <= 3 & x <= 3)

## ----subset-method-2----------------------------------------------------------
# subset MSImagingExperiment
subset(mse, 1002 < mz & mz < 1004, x <= 3 & x <= 3)

## ----subsetFeatures-----------------------------------------------------------
# subset features
subsetFeatures(mse, 1002 < mz, mz < 1004)

# subset pixels
subsetPixels(mse, x <= 3, y <= 3)

## ----slice--------------------------------------------------------------------
# slice image for first mass feature
a <- sliceImage(mse, 1)
dim(a)

## ----slice-mz-----------------------------------------------------------------
# slice image for m/z 1003.3
a2 <- sliceImage(mse, mz=1003.3, drop=FALSE)
dim(a2)

## ----slice-image, fig.height=4, fig.width=9-----------------------------------
par(mfcol=c(1,2), new=FALSE)
image(a2[,,1,1], asp=1)
image(a2[,,2,1], asp=1)

## ----cbind-divide-------------------------------------------------------------
# divide dataset into separate objects for each run
mse_run0 <- mse[,run(mse) == "runA1"]
mse_run1 <- mse[,run(mse) == "runB1"]
mse_run0
mse_run1

## ----cbind-recombine----------------------------------------------------------
# recombine the separate datasets back together
mse_cbind <- cbind(mse_run0, mse_run1)
mse_cbind

## ----pData-set----------------------------------------------------------------
mse$region <- makeFactor(A=mse$circleA, B=mse$circleB,
	other=mse$square1 | mse$square2)
pData(mse)

## ----fData-set----------------------------------------------------------------
fData(mse)$region <- makeFactor(
	circle=mz(mse) > 1000 & mz(mse) < 1250,
	square=mz(mse) < 1000 | mz(mse) > 1250)
fData(mse)

## ----spectra-set--------------------------------------------------------------
# create a new spectra matrix of log-intensities
spectra(mse, "log2intensity") <- log2(spectra(mse) + 1)
spectraData(mse)

# examine the new spectra matrix
spectra(mse, "log2intensity")[1:5, 1:5]

## ----centroided-get-----------------------------------------------------------
centroided(mse)

## ----centroided-set, eval=FALSE-----------------------------------------------
# centroided(mse) <- FALSE

## ----summarize-features, fig.height=3, fig.width=9----------------------------
# calculate mean spectrum
mse <- summarizeFeatures(mse, stat="mean")

# mean spectrum stored in featureData
fData(mse)

# plot mean spectrum
plot(mse, "mean", xlab="m/z", ylab="Intensity")

## ----summarize-pixels, fig.height=4, fig.width=9------------------------------
# calculate TIC
mse <- summarizePixels(mse, stat=c(TIC="sum"))

# TIC stored in pixelData
pData(mse)

# plot TIC
image(mse, "TIC", col=matter::cpal("Cividis"))

## ----summarize-features-groups, fig.height=3, fig.width=9---------------------
# calculate mean spectrum
mse <- summarizeFeatures(mse, stat="mean", groups=mse$region)

# mean spectrum stored in featureData
fData(mse)

# plot mean spectrum
plot(mse, c("A.mean", "B.mean"), xlab="m/z", ylab="Intensity")

## ----summarize-pixels-groups, fig.height=8, fig.width=9-----------------------
# calculate mean spectrum
mse <- summarizePixels(mse, stat="sum", groups=fData(mse)$region)

# mean spectrum stored in featureData
pData(mse)

# plot mean spectrum
image(mse, c("circle.sum", "square.sum"), scale=TRUE)

## ----matter-------------------------------------------------------------------
# spectra are stored as an out-of-memory matrix
spectra(mse_tiny)
spectraData(mse_tiny) # 'intensity' array is 'matter_mat' object

## -----------------------------------------------------------------------------
# coerce spectra to an in-memory matrix
spectra(mse_tiny) <- as.matrix(spectra(mse_tiny))
spectraData(mse_tiny) # 'intensity' array is 'matrix' object

## ----coerce-1-----------------------------------------------------------------
msa

# coerce to MSImagingExperiment
as(msa, "MSImagingExperiment")

## ----coerce-2-----------------------------------------------------------------
mse

# coerce to MSImagingArrays
as(mse, "MSImagingArrays")

## ----normalize----------------------------------------------------------------
msa_pre <- normalize(msa, method="tic")

## ----smoothSignal-plot, fig.height=7, fig.width=9-----------------------------
p1 <- smooth(msa, method="gaussian") |>
	plot(coord=list(x=16, y=16),
		xlim=c(1150, 1450), linewidth=2)

p2 <- smooth(msa, method="sgolay") |>
	plot(coord=list(x=16, y=16),
		xlim=c(1150, 1450), linewidth=2)

matter::as_facets(list(p1, p2), nrow=2,
	labels=c("Gaussian smoothing", "Savitsky-Golay smoothing"))

## ----smoothSignal-------------------------------------------------------------
msa_pre <- smooth(msa_pre, method="gaussian")

## ----reduceBaseline-plot, fig.height=5, fig.width=9---------------------------
p1 <- reduceBaseline(mse, method="locmin") |>
	plot(coord=list(x=16, y=16), linewidth=2)

p2 <- reduceBaseline(mse, method="median") |>
	plot(coord=list(x=16, y=16), linewidth=2)

matter::as_facets(list(p1, p2), nrow=2,
	labels=c("Local minima interpolation", "Running medians"))

## ----reduceBaseline-----------------------------------------------------------
msa_pre <- reduceBaseline(msa_pre, method="locmin")

## ----unaligned-spectra, fig.height=3, fig.width=9-----------------------------
set.seed(2020, kind="L'Ecuyer-CMRG")
mse_drift <- simulateImage(preset=1, npeaks=10,
	from=500, to=600, sdmz=750, units="ppm")

plot(mse_drift, i=186:195, xlim=c(535, 570),
	superpose=TRUE, key=FALSE, linewidth=2)

## ----recalibrate, fig.height=3, fig.width=9-----------------------------------
peaks_drift <- estimateReferencePeaks(mse_drift)

mse_nodrift <- recalibrate(mse_drift, ref=peaks_drift,
	method="locmax", tolerance=1500, units="ppm")
mse_nodrift <- process(mse_nodrift)

plot(mse_nodrift, i=186:195, xlim=c(535, 570),
	superpose=TRUE, key=FALSE, linewidth=2)

## ----process-execute----------------------------------------------------------
msa_pre <- process(msa_pre)

## ----peakPick-plot, fig.height=7, fig.width=9---------------------------------
p1 <- peakPick(msa_pre, method="diff", SNR=3) |>
	plot(coord=list(x=16, y=16), linewidth=2)

p2 <- peakPick(msa_pre, method="filter", SNR=3) |>
	plot(coord=list(x=16, y=16), linewidth=2)

matter::as_facets(list(p1, p2), nrow=2,
	labels=c("Derivative-based SNR", "Dynamic filtering-based SNR"))

## ----peakPick-----------------------------------------------------------------
msa_peaks <- peakPick(msa_pre, method="filter", SNR=3)

## ----peakAlign----------------------------------------------------------------
mse_peaks <- peakAlign(msa_peaks, tolerance=200, units="ppm")
mse_peaks

## ----subsetFeatures-peaks-----------------------------------------------------
fData(mse_peaks)

# filter to peaks with frequencies > 0.1
mse_filt <- subsetFeatures(mse_peaks, freq > 0.1)
fData(mse_filt)

## ----mean-peaks-1, fig.height=3, fig.width=9----------------------------------
mse_filt <- summarizeFeatures(mse_filt)

plot(mse_filt, "mean", xlab="m/z", ylab="Intensity",
	linewidth=2, annPeaks=10)

## ----peakPick-ref-------------------------------------------------------------
msa_peaks2 <- peakPick(msa_pre, ref=mz(mse_filt), type="area",
	tolerance=600, units="ppm")

mse_peaks2 <- process(msa_peaks2)

## ----mean-peaks-2, fig.height=3, fig.width=9----------------------------------
mse_peaks2 <- as(mse_peaks2, "MSImagingExperiment")
mse_peaks2 <- summarizeFeatures(mse_peaks2)

plot(mse_peaks2, "mean", xlab="m/z", ylab="Intensity",
	linewidth=2, annPeaks=10)

## ----peakProcess--------------------------------------------------------------
mse_peaks3 <- peakProcess(msa_pre, method="diff", SNR=6,
	sampleSize=0.3, filterFreq=0.02)

mse_peaks3

## ----bin----------------------------------------------------------------------
mse_binned <- bin(msa, resolution=1, units="mz")
mse_binned

## ----process-workflow, fig.height=5, fig.width=9------------------------------
mse_queue <- msa |>
	normalize() |>
	smooth() |>
	reduceBaseline() |>
	peakPick(SNR=6)

# preview processing
plot(mse_queue, coord=list(x=16, y=16), linewidth=2)

# apply processing and align peaks
mse_proc <- peakAlign(mse_queue)
mse_proc <- subsetFeatures(mse_proc, freq > 0.1)
mse_proc

## ----write-imzML--------------------------------------------------------------
imzfile <- tempfile(fileext=".imzML")

writeMSIData(mse_proc, file=imzfile)

list.files(imzfile)

## ----read-imzML---------------------------------------------------------------
mse_re <- readMSIData(imzfile)

mse_re

## ----set-BPPARAM, eval=FALSE--------------------------------------------------
# # run in parallel, rather than serially
# mse_mean <- summarizeFeatures(mse, BPPARAM=MulticoreParam())

## ----registered---------------------------------------------------------------
BiocParallel::registered()

## ----getCardinalBPPARAM-------------------------------------------------------
getCardinalBPPARAM()

## ----setCardinalBPPARAM-snow--------------------------------------------------
# register a SNOW backend
setCardinalBPPARAM(SnowParam(workers=2, progressbar=TRUE))

getCardinalBPPARAM()

## ----setCardinalBPPARAM-null--------------------------------------------------
# reset backend
setCardinalBPPARAM(NULL)

## ----RNGkind, eval=FALSE------------------------------------------------------
# set.seed(1, kind="L'Ecuyer-CMRG")

## ----install-CardinalWorkflows, eval=FALSE------------------------------------
# BiocManager::install("CardinalWorkflows")

## ----library-CardinalWorkflows, eval=FALSE------------------------------------
# library(CardinalWorkflows)

## ----session-info-------------------------------------------------------------
sessionInfo()

