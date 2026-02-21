# Code example from 'MBQNpackage' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----bc-installation, eval = FALSE--------------------------------------------
# # if (!requireNamespace("BiocManager", quietly = TRUE))
# #    install.packages("BiocManager")
# BiocManager::install("MBQN")

## ----dependencies1, eval = FALSE----------------------------------------------
# # if (!requireNamespace("BiocManager", quietly = TRUE))
# #    install.packages("BiocManager")
# # BiocManager::install(pkgs = c("preprocessCore","limma", "SummarizedExperiment"))

## ----example1, eval = TRUE----------------------------------------------------
## basic example
library("MBQN")
set.seed(1234)
# data generation 
mtx <- mbqnSimuData("omics.dep")
# data distortion
mtx <- mbqnSimuDistortion(mtx)$x.mod

## ----figure1, fig.height = 5, fig.width = 6, fig.align = "left", fig.cap = "Fig. 1 Boxplot of the unnormalized, distorted intensity data matrix. The first feature is an RI feature (red line). It has maximum intensity for each sample!"----
plot.new()
mbqnBoxplot(mtx, irow = 1, main = "Unnormalized")

## ----eval = TRUE--------------------------------------------------------------
res <- mbqnGetNRIfeatures(mtx, low_thr = 0.5)

## ----figure2, fig.height = 5, fig.width = 6, fig.align = 'left', fig.cap = "Fig. 2 Quantile normalized intensities with balanced and unbalanced normalized RI feature. Classical quantile normalization suppresses any intensity variation of the RI feature, while the MBQN preserves its variation while reducing systematic batch effects!"----
plot.new()
mbqn.mtx <- mbqnNRI(x = mtx, FUN = median, verbose = FALSE) # MBQN
qn.mtx <- mbqnNRI(x = mtx, FUN = NULL, verbose = FALSE) # QN
mbqnBoxplot(mbqn.mtx, irow = res$ip, vals = data.frame(QN = qn.mtx[res$ip,]), main = "Normalized")

## ----example2, eval = TRUE----------------------------------------------------
## basic example
library("MBQN")
set.seed(1234)
mtx <- mbqnSimuData("omics.dep") 
# Alternatively: mtx <- matrix(
#            c(5,2,3,NA,2,4,1,4,2,3,1,4,6,NA,1,3,NA,1,4,3,NA,1,2,3),ncol=4)

## ----eval = TRUE--------------------------------------------------------------
qn.mtx <- mbqn(mtx,FUN=NULL, verbose = FALSE)
mbqn.mtx <- mbqn(mtx,FUN = "median", verbose = FALSE)
qn.nri.mtx <- mbqnNRI(mtx,FUN = "median", low_thr = 0.5, verbose = FALSE)

## ----eval = TRUE--------------------------------------------------------------
res <- mbqnGetNRIfeatures(mtx, low_thr = 0.5)
# Maximum frequency of RI/NRI feature(s):  100 %

## ----example3, eval = TRUE----------------------------------------------------
#plot.new()
mtx <- mbqnSimuData("omics.dep", show.fig = FALSE)
mod.mtx <- mbqnSimuDistortion(mtx, s.mean = 0.05, s.scale = 0.01)
mtx2 <- mod.mtx
mod.mtx <- mod.mtx$x.mod

res <- mbqnGetNRIfeatures(mod.mtx, low_thr = 0.5)

# undistorted feature
feature1 <- mtx[1,]
# distorted feature
feature1mod = mod.mtx[1,]
# feature after normalization
qn.feature1 = mbqn(mod.mtx, verbose = FALSE)[1,]
qn.mtx = mbqn(mod.mtx,verbose = FALSE)

mbqn.mtx = mbqn(mod.mtx, FUN = "mean",verbose = FALSE)
mbqn.feature1 = mbqn(mod.mtx, FUN = "mean",verbose = FALSE)[1,]

## ----eval = TRUE--------------------------------------------------------------
# undistorted feature
ttest.res0 <- t.test(feature1[seq_len(9)], feature1[c(10:18)],
                    var.equal =TRUE)
# distorted feature
ttest.res1 <- t.test(feature1mod[seq_len(9)], feature1mod[c(10:18)],
                    var.equal =TRUE)
# mbqn normalized distorted feature
ttest.res <- t.test(mbqn.feature1[seq_len(9)], mbqn.feature1[c(10:18)],
                    var.equal =TRUE)

## ----eval = TRUE--------------------------------------------------------------

## ----figure3, fig.height = 5, fig.width = 6, fig.align = "left", fig.cap = "Fig. 3 "----
plot.new()
matplot(t(rbind(feature1 = feature1,
    mod.feature1 = (feature1mod-mean(feature1mod))/25+mean(feature1),
    qn.feature1 = (qn.feature1-mean(qn.feature1))+mean(feature1),
    mbqn.feature1 = (
        mbqn.feature1-mean(mbqn.feature1))+mean(feature1))),
    type = "b", lty = c(1,1,1), pch = "o",
    ylab = "intensity",
    xlab = "sample",
    main = "Differentially expressed RI feature",
    ylim = c(34.48,34.85))
legend(x=11,y= 34.86, legend = c("feature","distorted feature/25" ,
                                "QN feature", " MBQN feature"),pch = 1,
        col = c(1,2,3,4), lty= c(1,1,1,1), bty = "n", y.intersp = 1.5,
        x.intersp = 0.2)
legend(x = .1, y = 34.6,
        legend = paste("p-value (t-test) =",round(ttest.res1$p.value,2),
            "\np-value (t-test, mbqn) =", round(ttest.res$p.value,4)),
        bty = "n", x.intersp = 0)


if (ttest.res$p.value<0.05)
    message("H0 (=equal mean) is rejected!")


# print(mtx2$x.mod)
# print(mtx2$mx.offset)
# print(mtx2$mx.scale)
print(paste("ttest.undistorted =",ttest.res0)) 
print(paste("ttest.distorted =", ttest.res1))
print(paste("ttest.mbqndistorted =", ttest.res))

