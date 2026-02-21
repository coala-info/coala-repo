# Code example from 'TFHAZ' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----include=FALSE------------------------------------------------------------
library(TFHAZ)
library(GenomicRanges)
library(IRanges)
library(S4Vectors)
data("data_man")

## -----------------------------------------------------------------------------
# load and visualize the dataset:
data("Ishikawa")
dim(as.data.frame(Ishikawa))
head(Ishikawa)


## -----------------------------------------------------------------------------
# calculate TF accumulation for the chromosome 21 for w=0
TF_acc_21_w_0 <- accumulation(Ishikawa, "TF", "chr21", 0)

## ----eval=FALSE---------------------------------------------------------------
# # plot the accumulation vector
# plot_accumulation(TF_acc_21_w_0)

## ----echo=FALSE, fig.align='center', out.width='75%', fig.cap = "*Plot of the TF accumulation vector for the chromosome 21, obtained for w=0.*"----
knitr::include_graphics('./TF_w_0_chr21.png')

## -----------------------------------------------------------------------------
# find dense DNA zones, with threshold step equal to 1
TF_dense_21_w_0 <- dense_zones(TF_acc_w_0, 1, chr = "chr21")
TF_dense_21_w_0

## ----echo=FALSE, fig.align='center', fig.small = TRUE, fig.cap = "*Content of the 'bed' file with the coordinates of the seven dense DNA zones found  for the chromosome 21 with transcription factor accumulation threshold value equal to 12.*"----
knitr::include_graphics('./dense_zones_12.PNG')

## ----fig.align='center', fig.cap = "*Plot of the number of dense DNA zones found varying the TF accumulation threshold value for the chromosome 21; the point with maximum slope change is plotted circulated with a red full line.*"----
plot_n_zones(TF_dense_w_0, chr = "chr21")

## ----fig.align='center', fig.cap="*Plot of the number of dense DNA zones (red full line) and of the total number of bases belonging to dense DNA zones (blue dashed line) obtained with different values of neighborhood window half-width w for the chromosome 21.*"----
# l is a list with four objects obtained with the dense_zones function with 
# w = 10, 100, 1000, 10000.
l <- list(TF_dense_w_10, TF_dense_w_100, TF_dense_w_1000, TF_dense_w_10000)
# plot
w_analysis(l, chr = "chr21")

## ----PCA, fig.keep="none"-----------------------------------------------------
# TF_dense_21_w_10 is the output of dense_zones function applied to the
# accumulation vector found with w=10, chr="chr21", acctype="TF".
# reg_dense_21_w_10 is the output of dense_zones function applied to the
# accumulation vector found with w=10, chr="chr21", acctype="reg".   
# base_dense_21_w_10 is the output of dense_zones function (with 
# threshold_step=21 in order to have 14 threshold values as in the other two
# inputs) applied to the accumulation vector found with w=10, chr="chr21",
# acctype="base".
# PCA
n_zones_PCA(TF_dense_w_10, reg_dense_w_10, base_dense_w_10, chr = "chr21")

## ----echo=FALSE, fig.align='center', out.width = '75%',fig.cap = "*Plot of the variances of the principal components.*"----
knitr::include_graphics('./PCA_1.png')

## ----echo=FALSE, fig.align='center', out.width='75%', fig.cap = "*Plot of the cumulate variances of the principal components.*"----
knitr::include_graphics('./PCA_2.png')

## ----echo=FALSE, fig.align='center', out.width='100%', fig.cap = "*Plot of the loadings of the three principle components.*"----
knitr::include_graphics('./PCA_3.png')

## -----------------------------------------------------------------------------
# find high accumulation DNA zones
TF_acc_21_w_0 <- accumulation(Ishikawa, "TF", "chr21", 0)
TFHAZ_21_w_0 <- high_accumulation_zones(TF_acc_21_w_0, method = "overlaps",
threshold = "std")
TFHAZ_21_w_0

## ----echo=FALSE, fig.align="center", out.width='75%',fig.cap = "*Plot of the TF accumulation vector (for the chromosome 21, obtained for w=0) and of the high accumulation DNA zones (red boxes on the x axis) found; the threshold used to find these zones (7,268413) is shown with a red horizontal line.*"----
knitr::include_graphics('./high_accumulation_zones_TH_7.3_TF_acc_w_0_chr21.png')

## ----echo=FALSE, fig.align='center', fig.small = TRUE, fig.cap = "*Content of the 'bed' file with the coordinates of 31 out of the 93 high accumulation DNA zones found.*"----
knitr::include_graphics('./HAZ_bed.PNG')

