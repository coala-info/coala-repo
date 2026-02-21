# Code example from 'PepsNMR_minimal_example' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
require(knitr)
knitr::opts_chunk$set(collapse = TRUE, comment = "#>",  fig.width = 10, fig.height = 6, fig.align = "center", tidy = FALSE, tidy.opts=list(width.cutoff=80), fig.keep = 'high', dpi=40)

## ----include=FALSE------------------------------------------------------------
# ==== set graphical parameters =================
# select the index of the spectrum that will be drawn
spectrIndex <- 1
# colors
col1 <-  "gray18"
col2 <- "firebrick1"
library(PepsNMR)


## ----install1,  eval = FALSE, background = "#EFFBF5", highlight = TRUE--------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# BiocManager::install("PepsNMR",
#                      dependencies = c("Depends", "Imports", "Suggests"))

## ----library,  eval = FALSE, background = "#EFFBF5", highlight = TRUE---------
# library(PepsNMR)

## ----dataimport, eval = FALSE-------------------------------------------------
# fidList <- ReadFids(file.path(path,dataset_name))
# 
# Fid_data <- fidList[["Fid_data"]]
# Fid_info <- fidList[["Fid_info"]]

## ----fig.cap="Accepted directory structures for the raw Bruker files", echo=FALSE----
include_graphics("ReadFids.png")

## ----steps, echo=FALSE,  eval=TRUE--------------------------------------------

Steps <- c("Group Delay Correction", 
           "Solvent Suppression",
           "Apodization",
           "ZeroFilling",
           "Fourier Transform",
           "Zero Order Phase Correction",
           "Internal Referencing",
           "Baseline Correction",
           "Negative Values Zeroing",
           "Warping",
           "Window Selection",
           "Bucketing",
           "Region Removal",
           "Zone Aggregation",
           "Normalization")

StepsDescr <- c("Correct for the Bruker Group Delay.",
                "Remove the solvent signal from the FIDs.",
                "Increase the Signal-to-Noise ratio of the FIDs.",
                "Improve the visual representation of the spectra.",
                "Transform the FIDs into a spectrum and convert the frequency scale (Hz ->  ppm).",
                "Correct for the zero order phase dephasing.",
                "Calibrate the spectra with an internal reference compound. Referencing with an internal (e.g. TMSP at 0 ppm)",
                 "Remove the spectral baseline.",
                "Set negatives values to 0.",
                "Warp the spectra according to a reference spectrum.",
                "Select the informative part of the spectrum.",
                "Data reduction.",
                "Set a desired spectral region to 0.",
                "Aggregate a spectral region into a single peak.",
                "Normalize the spectra.")


StepsTable <- cbind(Steps = Steps, Description = StepsDescr)

kable(StepsTable, caption = "Pre-processing steps. They are presented in the suggested order.")
   

## ----availdata----------------------------------------------------------------
library(PepsNMRData)

str(FidData_HU)

str(FinalSpectra_HS)

## -----------------------------------------------------------------------------
data_path <-  system.file("extdata", package = "PepsNMRData")
dir(data_path)

## -----------------------------------------------------------------------------
# ==== read the FIDs and their metadata =================
fidList <- ReadFids(file.path(data_path, "HumanSerum"))
Fid_data0 <- fidList[["Fid_data"]]
Fid_info <- fidList[["Fid_info"]]
kable(head(Fid_info))

## ----FIGRawFID, echo = FALSE, out.width = '100%', fig.cap="Raw FID."----------
time <- as.numeric(colnames(Fid_data0))*1000
plot(time, Re(Fid_data0[spectrIndex,]),type="l", col = col1, xlab=
       expression(paste("Time (", mu,"s)")), ylab = "Intensity", 
     main = "Raw FID (real part)", ylim = c(-1e6,2e5))


## -----------------------------------------------------------------------------
# ==== GroupDelayCorrection =================
Fid_data.GDC <- GroupDelayCorrection(Fid_data0, Fid_info)

## ----echo = FALSE, fig.cap="Signal before and after the Group Delay removal.", out.width = '100%', fig.height=12----
par(mfrow=c(2,1))
plot(time[0:300], Re(Fid_data0[spectrIndex,0:300]),  
     type = "l", ylab = "Intensity", xlab="", 
     main = "FID with the Group Delay (real part - zoom)", col = col1)
plot(time[0:300], Re(Fid_data.GDC[spectrIndex,0:300]), 
     type="l", ylab = "Intensity", xlab=expression(paste("Time (", mu,"s)")), 
     main="FID after Group Delay removal (real part - zoom)", col = col1)

## -----------------------------------------------------------------------------
# ====  SolventSuppression =================
SS.res <- SolventSuppression(Fid_data.GDC, returnSolvent=TRUE)

Fid_data.SS <- SS.res[["Fid_data"]]
SolventRe <- SS.res[["SolventRe"]]


## ----echo = FALSE, fig.cap="Signal before and after the Residual Solvent Removal.", out.width = '100%', fig.height=12----
par(mfrow=c(2,1))
plot(time[0:4000], Re(Fid_data.GDC[spectrIndex,0:4000]),  col=col1, 
     type="l", ylab = "Intensity", xlab="", 
     main="FID and solvent residuals signal (real part - zoom)")
lines(time[0:4000],SolventRe[spectrIndex,0:4000], col=col2 , lwd = 1.3)
legend("topright", bty = "n", legend = c(expression(paste("Estimated solvent residuals signal ", (italic(W)))), expression(paste("FID signal ", (italic(S))))), 
       col=c(col2, col1),  lty = 1)

plot(time[0:4000], Re(Fid_data.SS[1,0:4000]), col=col1, 
     type="l", ylab = "Intensity", xlab=expression(paste("Time (", mu,"s)")), 
     main="FID without solvent residuals signal (real part - zoom)")
lines(time[0:4000], rep(0, 4000), col=col2)

## -----------------------------------------------------------------------------
# ==== Apodization =================
Fid_data.A <- Apodization(Fid_data.SS, Fid_info)


## ----echo = FALSE, fig.cap="Signal before and after Apodization.", out.width = '100%', fig.height=12----
par(mfrow=c(2,1))
plot(time, Re(Fid_data.SS[spectrIndex,]),  col=col1, 
     type="l", ylab = "Intensity", xlab="", main="FID before Apodization")

plot(time, Re(Fid_data.A[spectrIndex,]), col=col1, 
     type="l", ylab = "Intensity", xlab=expression(paste("Time (", mu,"s)")), 
     main="FID after Apodization")

## -----------------------------------------------------------------------------
# ==== Zero Filling =================
Fid_data.ZF <- ZeroFilling(Fid_data.A, fn = ncol(Fid_data.A))


## ----echo = FALSE, fig.cap="Signal before and after Apodization.", out.width = '100%', fig.height=12----

par(mfrow=c(2,1))
plot(time, Re(Fid_data.A[spectrIndex,]),  col=col1, 
     type="l", ylab = "Intensity", xlab="", main="FID before Zero Filling")

time <- as.numeric(colnames(Fid_data.ZF))*1000
plot(time, Re(Fid_data.ZF[spectrIndex,]), col=col1, 
     type="l", ylab = "Intensity", xlab=expression(paste("Time (", mu,"s)")), 
     main="FID after Zero Filling")

## -----------------------------------------------------------------------------
# ==== FourierTransform =================
RawSpect_data.FT <- FourierTransform(Fid_data.ZF, Fid_info)

## ----echo = FALSE, fig.cap="Spectrum after FT.", out.width = '100%'-----------
plot(Re(RawSpect_data.FT[spectrIndex,]), col=col1, xaxt="n",
     type="l", ylab = "Intensity", xlab = "ppm", 
     main="Spectrum after Fourier Transform")
at <- seq(1,dim(RawSpect_data.FT)[2], floor(dim(RawSpect_data.FT)[2]/10))
axis(side=1, at = at, 
     labels = round(as.numeric(colnames(RawSpect_data.FT)[at]),2))

## -----------------------------------------------------------------------------
# ==== ZeroOrderPhaseCorrection =================
Spectrum_data.ZOPC <- ZeroOrderPhaseCorrection(RawSpect_data.FT)

# with a graph of the criterion to maximize over 2pi
Spectrum_data.ZOPC <- ZeroOrderPhaseCorrection(RawSpect_data.FT,
                                               plot_rms = "J1-D1-1D-T1")


## ----echo = FALSE, fig.cap="Spectrum after Zero Order Phase Correction.", out.width = '100%'----
plot(Re(Spectrum_data.ZOPC[spectrIndex,]), col=col1, xaxt="n",
     type="l", ylab = "Intensity", xlab = "ppm", 
     main="Spectrum after Zero Order Phase Correction")
at <- seq(1,dim(Spectrum_data.ZOPC)[2], floor(dim(Spectrum_data.ZOPC)[2]/10))
axis(side=1, at = at, 
     labels = round(as.numeric(colnames(Spectrum_data.ZOPC)[at]),2))

## -----------------------------------------------------------------------------
# ==== InternalReferencing =================
target.value <- 0

IR.res <- InternalReferencing(Spectrum_data.ZOPC, Fid_info,
                                        ppm.value = target.value,
                                        rowindex_graph = c(1,2))
# draws Peak search zone and location of the 2 first spectra
IR.res$plots

Spectrum_data.IR <- IR.res$Spectrum_data

## ----echo = FALSE, fig.cap="Spectrum after Internal Referencing.", out.width = '100%'----

ppmvalues <- as.numeric(colnames(Spectrum_data.IR))
plot(Re(Spectrum_data.IR[spectrIndex,]), col=col1, xaxt="n",
     type="l", ylab = "Intensity", xlab = "ppm", 
     main="Spectrum after internal referencing")
at <- seq(1,dim(Spectrum_data.IR)[2], floor(dim(Spectrum_data.IR)[2]/10))
axis(side=1, at = at, 
     labels = round(ppmvalues[at],2))

index <- which(abs(ppmvalues-target.value) == min(abs(ppmvalues-target.value)))
abline(v = index, col= col2)
legend("topright", bty = "n", legend = "Peak location", 
       col=col2,  lty = 1)

## -----------------------------------------------------------------------------
# ==== BaselineCorrection =================
BC.res <- BaselineCorrection(Spectrum_data.IR, returnBaseline = TRUE,
                             lambda.bc = 1e8, p.bc = 0.01)


## ----echo = FALSE, fig.cap="Spectrum before and after the Baseline Correction.", out.width = '100%', fig.height=12----
par(mfrow=c(2,1))
Spectrum_data.BC <- BC.res[["Spectrum_data"]] 
Baseline <- BC.res[["Baseline"]]


plot(Re(Spectrum_data.IR[spectrIndex,]), col=col1, xaxt="n",
     type="l", ylab = "Intensity", xlab = "", 
     main="Spectrum before Baseline Correction")
at <- seq(1,dim(Spectrum_data.IR)[2], floor(dim(Spectrum_data.IR)[2]/10))
axis(side=1, at = at, labels = round(ppmvalues[at],2))
lines(Baseline[,1], col=col2)
legend("topright", bty = "n", legend = "Estimated baseline ", 
       col = col2,  lty = 1)

plot(Re(Spectrum_data.BC[spectrIndex,]), col=col1, xaxt="n",
     type="l", ylab = "Intensity", xlab = "ppm", 
     main="Spectrum after Baseline Correction")
axis(side=1, at = at, labels = round(ppmvalues[at],2))

## ----NVZ----------------------------------------------------------------------
# ==== NegativeValuesZeroing =================
Spectrum_data.NVZ <- NegativeValuesZeroing(Spectrum_data.BC)

## ----echo = FALSE, fig.cap="Spectrum after Negative Values Zeroing.", out.width = '100%'----

plot(Re(Spectrum_data.NVZ[spectrIndex,]), col=col1, xaxt="n",
     type="l", ylab = "Intensity", xlab = "ppm", 
     main="Spectrum after Negative Values Zeroing")
axis(side=1, at = at, labels = round(ppmvalues[at],2))

## -----------------------------------------------------------------------------
# ==== Warping =================
W.res <- Warping(Spectrum_data.NVZ, returnWarpFunc = TRUE, 
                 reference.choice = "fixed")

Spectrum_data.W <- W.res[["Spectrum_data"]]
warp_func <- W.res[["Warp.func"]]

## ----echo = FALSE, fig.cap="Spectrum before and after the Baseline Correction.", out.width = '100%', fig.height=12----
par(mfrow=c(2,1))

f <- c(21, 20, 24) # warped spectra index to draw
fen <- c(35560:36480) # x-window
ylim <- c(0, max(c(Re(Spectrum_data.NVZ[c(1, f),fen]), Re(Spectrum_data.W[c(spectrIndex, f),fen]))))

# Unwarped spectra
plot(Re(Spectrum_data.NVZ[1, fen]),   xaxt = "n", col=col2, ylab = "Intensity",ylim=ylim, type="l", xlab="ppm", main="Spectra before warping (real part - zoom)")
legend("topright", bty = "n", y.intersp = 0.8,legend=c("Unwarped spectra","Ref. spectrum "), lty = c(1,1), col=c(col1,col2))    
axis(side=1,  at = seq(1,length(fen), 114), labels = round(as.numeric(colnames(Spectrum_data.NVZ[,fen])[seq(1,length(fen), 114)]),2))
for (j in f) {
  graphics::lines(Re(Spectrum_data.NVZ[j,fen]), col=col1, type="l")
  }

# Warped spectra
plot(Re(Spectrum_data.W[1, fen]), col=col2, xaxt = "n",ylab = "Intensity",ylim=ylim, type="l", xlab="ppm", main="Warped spectra (real part - zoom)")
legend("topright",   bty = "n",  y.intersp = 0.8, legend=c("Warped spectra ","Ref. spectrum "), lty = c(1,1), col=c(col1,col2))    
axis(side=1,  at = seq(1,length(fen), 114), labels = round(as.numeric(colnames(Spectrum_data.NVZ[,fen])[seq(1,length(fen), 114)]),2))
for (j in f) {
  graphics::lines(Re(Spectrum_data.W[j,fen]), col=col1, type="l")
  }

## -----------------------------------------------------------------------------
# ==== WindowSelection =================
Spectrum_data.WS <- WindowSelection(Spectrum_data.W, from.ws = 10, 
                                    to.ws = 0.2)

## ----echo = FALSE, fig.cap="Spectrum after Window Selection.", out.width = '100%'----

at <- seq(1,dim(Spectrum_data.WS)[2], floor(dim(Spectrum_data.WS)[2]/10))
ppmvalues <- as.numeric(colnames(Spectrum_data.WS))
plot(Re(Spectrum_data.WS[spectrIndex,]), col = col1, xaxt = "n",
     type = "l", ylab = "Intensity", xlab = "ppm", 
     main = "Spectrum after Window Selection")
axis(side = 1, at = at, labels = round(ppmvalues[at],2))

## -----------------------------------------------------------------------------
# ==== Bucketing =================
Spectrum_data.B <- Bucketing(Spectrum_data.WS, intmeth = "t")

## ----echo = FALSE, fig.cap="Spectrum before and after Bucketing.", out.width = '100%', fig.height=12----
par(mfrow=c(2,1))

at <- seq(1,dim(Spectrum_data.WS)[2], floor(dim(Spectrum_data.WS)[2]/10))
ppmvalues <- as.numeric(colnames(Spectrum_data.WS))
plot(Re(Spectrum_data.WS[spectrIndex,]), col = col1, xaxt = "n",
     type = "l", ylab = "Intensity", xlab = "", 
     main = "Spectrum before Bucketing")
axis(side = 1, at = at, labels = round(ppmvalues[at],2))

at <- seq(1,dim(Spectrum_data.B)[2], floor(dim(Spectrum_data.B)[2]/10))
ppmvalues <- as.numeric(colnames(Spectrum_data.B))
plot(Re(Spectrum_data.B[spectrIndex,]), col = col1, xaxt = "n",
     type = "l", ylab = "Intensity", xlab = "ppm", 
     main = "Spectrum after Bucketing")
axis(side = 1, at = at, labels = round(ppmvalues[at],2))

## -----------------------------------------------------------------------------
# ==== RegionRemoval =================
Spectrum_data.RR <- RegionRemoval(Spectrum_data.B, 
                                  typeofspectra = "serum")

## ----echo = FALSE, fig.cap="Spectrum after Region Removal", out.width = '100%'----

plot(Re(Spectrum_data.RR[spectrIndex,]), col = col1, xaxt = "n",
     type = "l", ylab = "Intensity", xlab = "ppm", 
     main = "Spectrum after Region Removal")
axis(side = 1, at = at, labels = round(ppmvalues[at],2))

## -----------------------------------------------------------------------------
# ==== Normalization =================
Spectrum_data.N <- Normalization(Spectrum_data.RR, type.norm = "mean")

## ----echo = FALSE, fig.cap="Spectrum before and after Normalization", out.width = '100%', fig.height=12----
par(mfrow=c(2,1))


plot(Re(Spectrum_data.RR[spectrIndex,]), col = col1, xaxt = "n",
     type = "l", ylab = "Intensity", xlab = "ppm", 
     main = "Spectrum before Normalization")
axis(side = 1, at = at, labels = round(ppmvalues[at],2))
lines(Re(Spectrum_data.RR[2,]), col = "blue")
lines(Re(Spectrum_data.RR[3,]), col = "green")

plot(Re(Spectrum_data.N[spectrIndex,]), col = col1, xaxt = "n",
     type = "l", ylab = "Intensity", xlab = "ppm", 
     main = "Spectrum after Normalization")
axis(side = 1, at = at, labels = round(ppmvalues[at],2))
lines(Re(Spectrum_data.N[2,]), col = "blue")
lines(Re(Spectrum_data.N[3,]), col = "green")

## ----fig.height=7, fig.width=8, out.width='100%', fig.cap = "4 first pre-processed spectra"----
Draw(Spectrum_data.N[1:4,], type.draw = c("signal"), 
     subtype= "stacked", output = c("default"))

## ----fig.height=6, fig.width=8, out.width='100%', fig.cap = "PCA scores of the pre-processed spectra"----
Draw(Spectrum_data.N, type.draw = c("pca"), 
     output = c("default"), Class = Group_HS, 
     type.pca = "scores")

## ----out.width='100%', out.width='70%', out.width='100%', fig.cap = "PCA loadings of the pre-processed spectra"----
Draw(Spectrum_data.N, type.draw = c("pca"), 
     output = c("default"),
     Class = Group_HS, type.pca = "loadings")

## -----------------------------------------------------------------------------
sessionInfo()

