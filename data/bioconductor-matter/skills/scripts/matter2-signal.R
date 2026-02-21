# Code example from 'matter2-signal' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----setup, echo=FALSE, message=FALSE-----------------------------------------
library(matter)
register(SerialParam())

## ----signal-1d----------------------------------------------------------------
set.seed(1)
s <- simspec(1)

plot_signal(s, xlab="Index", ylab="Intensity")

## ----signal-1d-mz-------------------------------------------------------------
plot_signal(domain(s), s, xlab="m/z", ylab="Intensity")

## ----signal-2d-xy-------------------------------------------------------------
plot_image(volcano)

## ----signal-index-------------------------------------------------------------
set.seed(1)
s1 <- simspec(1)
s2 <- simspec(1)

# spectra with different m/z-values
head(domain(s1))
head(domain(s2))

# create a shared vector of m/z-values
mzr <- range(domain(s1), domain(s2))
mz <- seq(from=mzr[1], to=mzr[2], by=0.2)

# create representations with the same m/z-values
s1 <- sparse_vec(s1, index=domain(s1), domain=mz)
s2 <- sparse_vec(s2, index=domain(s2), domain=mz)

## ----smooth-signal-sim--------------------------------------------------------
set.seed(1)
s <- simspec(1, sdnoise=0.25, resolution=500)

## ----smooth-signal------------------------------------------------------------
p1 <- plot_signal(s)
p2 <- plot_signal(filt1_ma(s))
p3 <- plot_signal(filt1_gauss(s))
p4 <- plot_signal(filt1_bi(s))
p5 <- plot_signal(filt1_diff(s))
p6 <- plot_signal(filt1_guide(s))
p7 <- plot_signal(filt1_pag(s))
p8 <- plot_signal(filt1_sg(s))

plt <- as_facets(list(
    "Original"=p1,
    "Moving average"=p2,
    "Gaussian"=p3,
    "Bilateral"=p4,
    "Diffusion"=p5,
    "Guided"=p6,
    "Peak-aware"=p7,
    "Savitsky-Golay"=p8), nrow=4, ncol=2)

plot(plt)

## ----smooth-signal-zoom-------------------------------------------------------
plot(plt, xlim=c(5800, 6100))

## ----smooth-image-sim---------------------------------------------------------
set.seed(1)
img <- volcano + rnorm(length(volcano), sd=2.5)

## ----smooth-image-------------------------------------------------------------
p1 <- plot_image(img)
p2 <- plot_image(filt2_ma(img))
p3 <- plot_image(filt2_gauss(img))
p4 <- plot_image(filt2_bi(img))
p5 <- plot_image(filt2_diff(img))
p6 <- plot_image(filt2_guide(img))

plt <- as_facets(list(
    "Original"=p1,
    "Moving average"=p2,
    "Gaussian"=p3,
    "Bilateral"=p4,
    "Diffusion"=p5,
    "Guided"=p6), nrow=3, ncol=2)

plot(plt)

## ----smooth-image-2-----------------------------------------------------------
set.seed(1)
dm <- c(64, 64)
img <- array(rnorm(prod(dm)), dim=dm)
i <- (dm[1] %/% 3):(2 * dm[1] %/% 3)
j <- (dm[2] %/% 3):(2 * dm[2] %/% 3)
img[i,] <- img[i,] + 2
img[,j] <- img[,j] + 2

p1 <- plot_image(img)
p2 <- plot_image(filt2_ma(img))
p3 <- plot_image(filt2_gauss(img))
p4 <- plot_image(filt2_bi(img))
p5 <- plot_image(filt2_diff(img))
p6 <- plot_image(filt2_guide(img))

plt <- as_facets(list(
    "Original"=p1,
    "Moving average"=p2,
    "Gaussian"=p3,
    "Bilateral"=p4,
    "Diffusion"=p5,
    "Guided"=p6), nrow=3, ncol=2)

plot(plt)

## ----enhance-image-sim--------------------------------------------------------
set.seed(1)
img <- volcano + rlnorm(length(volcano), sd=1.5)

## ----enhance-image------------------------------------------------------------
p1 <- plot_image(img)
p2 <- plot_image(enhance_adj(img))
p3 <- plot_image(enhance_hist(img))
p4 <- plot_image(enhance_adapt(img))

plt <- as_facets(list(
    "Original"=p1,
    "Adjust"=p2,
    "Histogram"=p3,
    "CLAHE"=p4), nrow=2, ncol=2)

plot(plt, scale=TRUE)

## ----baseline-signal-sim------------------------------------------------------
set.seed(1)
s <- simspec(1, baseline=5, resolution=500)

## ----baseline-signal----------------------------------------------------------
p1 <- plot_signal(s)
p2 <- plot_signal(s - estbase_loc(s))
p3 <- plot_signal(s - estbase_hull(s))
p4 <- plot_signal(s - estbase_snip(s))

plt <- as_facets(list(
    "Original"=p1,
    "Local minima"=p2,
    "Convex hull"=p3,
    "SNIP"=p4), nrow=2, ncol=2)

plot(plt)

## ----warp-signal-sim----------------------------------------------------------
set.seed(1)
s <- simspec(8, sdx=5e-4)

plot_signal(domain(s), s, by=NULL, group=1:8,
    xlim=c(1250, 1450))

## ----warp-signal--------------------------------------------------------------
ref <- rowMeans(s)
s2 <- apply(s, 2L, warp1_loc,
    y=ref, events="max", tol=2e-3, tol.ref="y")

plot_signal(domain(s), s2, by=NULL, group=1:8,
    xlim=c(1250, 1450))

## ----warp-image-sim-----------------------------------------------------------
img1 <- trans2d(volcano, rotate=15, translate=c(-5, 5))

plot_image(list(volcano, img1))

## ----warp-image---------------------------------------------------------------
img2 <- warp2_trans(img1, volcano)

plot_image(list(volcano, img2))

## ----peaks-sim----------------------------------------------------------------
set.seed(1)
s <- simspec(1)

## ----locmax-------------------------------------------------------------------
i <- locmax(s)

plot_signal(domain(s), s, xlim=c(900, 1100))
lines(domain(s)[i], s[i], type="h", col="red")

## ----locmax-wide--------------------------------------------------------------
i <- locmax(s, width=15)

plot_signal(domain(s), s, xlim=c(900, 1100))
lines(domain(s)[i], s[i], type="h", col="red")

## ----knnmax-sim---------------------------------------------------------------
set.seed(1)
dm <- c(64, 64)
img <- array(rnorm(prod(dm)), dim=dm)
w <- 100 * dnorm(seq(-3, 3)) %o% dnorm(seq(-3, 3))
img[1:7,1:7] <- img[1:7,1:7] + w
img[11:17,11:17] <- img[11:17,11:17] + w
img[21:27,21:27] <- img[21:27,21:27] + w
img[21:27,41:47] <- img[21:27,41:47] + w
img[51:57,31:37] <- img[51:57,31:37] + w
img[41:47,51:57] <- img[41:47,51:57] + w

plot_image(img)

## ----knnmax-------------------------------------------------------------------
coord <- expand.grid(lapply(dim(img), seq_len))

i <- knnmax(img, index=coord, k=49)
i <- which(i, arr.ind=TRUE)

plot_image(img)
points(i[,1], i[,2], pch=4, lwd=2, cex=2, col="red")

## ----noise-constant-----------------------------------------------------------
p1 <- plot_signal(domain(s), s,
    xlim=c(900, 1100), ylim=c(0, 15))

p2 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_diff(s),
    params=list(color="blue", linewidth=2))

p3 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_filt(s),
    params=list(color="blue", linewidth=2))

p4 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_quant(s),
    params=list(color="blue", linewidth=2))

p5 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_sd(s),
    params=list(color="blue", linewidth=2))

p6 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_mad(s),
    params=list(color="blue", linewidth=2))

as_facets(list(
    "Original"=p1,
    "Difference"=p2,
    "Filtering"=p3,
    "Quantile"=p4,
    "SD"=p5,
    "MAD"=p6), nrow=3, ncol=2)

## ----noise-variable-----------------------------------------------------------
p1 <- plot_signal(domain(s), s,
    xlim=c(900, 1100), ylim=c(0, 15))

p2 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_diff(s, nbins=20),
    params=list(color="blue", linewidth=2))

p3 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_filt(s, nbins=20),
    params=list(color="blue", linewidth=2))

p4 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_quant(s, nbins=20),
    params=list(color="blue", linewidth=2))

p5 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_sd(s, nbins=20),
    params=list(color="blue", linewidth=2))

p6 <- add_mark(p1, "lines",
    x=domain(s), y=estnoise_mad(s, nbins=20),
    params=list(color="blue", linewidth=2))

as_facets(list(
    "Original"=p1,
    "Difference"=p2,
    "Filtering"=p3,
    "Quantile"=p4,
    "SD"=p5,
    "MAD"=p6), nrow=3, ncol=2)

## ----findpeaks-diff-----------------------------------------------------------
i1 <- findpeaks(s, snr=3, noise="diff")

p1a <- plot_signal(domain(s), s, group="Signal")
p1b <- plot_signal(domain(s)[i1], s[i1], group="Peaks",
    isPeaks=TRUE, annPeaks="circle")

p1 <- as_layers(p1a, p1b)

## ----findpeaks-filt-----------------------------------------------------------
i2 <- findpeaks(s, snr=3, noise="filt")

p2a <- plot_signal(domain(s), s, group="Signal")
p2b <- plot_signal(domain(s)[i2], s[i2], group="Peaks",
    isPeaks=TRUE, annPeaks="circle")

p2 <- as_layers(p2a, p2b)

## ----findpeaks-sd-------------------------------------------------------------
i3 <- findpeaks(s, snr=3, noise="sd")

p3a <- plot_signal(domain(s), s, group="Signal")
p3b <- plot_signal(domain(s)[i3], s[i3], group="Peaks",
    isPeaks=TRUE, annPeaks="circle")

p3 <- as_layers(p3a, p3b)

## ----findpeaks-mad------------------------------------------------------------
i4 <- findpeaks(s, snr=3, noise="mad")

p4a <- plot_signal(domain(s), s, group="Signal")
p4b <- plot_signal(domain(s)[i4], s[i4], group="Peaks",
    isPeaks=TRUE, annPeaks="circle")

p4 <- as_layers(p4a, p4b)

## ----findpeaks----------------------------------------------------------------
plt <- as_facets(list(
    "Difference"=p1,
    "Filtering"=p2,
    "SD"=p3,
    "MAD"=p4))

plot(plt, xlim=c(1200, 1600))

## ----binpeaks-----------------------------------------------------------------
set.seed(1)
s <- simspec(4)

peaklist <- apply(s, 2, findpeaks, snr=3)

peaks <- binpeaks(peaklist)
as.vector(peaks)

## ----mergepeaks---------------------------------------------------------------
peaks <- mergepeaks(peaks, tol=1)
as.vector(peaks)

## ----session-info-------------------------------------------------------------
sessionInfo()

