# Code example from 'matter2-guide' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----setup, echo=FALSE, message=FALSE-----------------------------------------
library(matter)
register(SerialParam())

## ----install, eval=FALSE------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("matter")

## ----library, eval=FALSE------------------------------------------------------
# library(matter)

## ----atoms--------------------------------------------------------------------
x <- matter_vec(1:10)
y <- matter_vec(11:20)
z <- cbind(x, y)
atomdata(z)

## ----array-1------------------------------------------------------------------
set.seed(1)
a1 <- array(sort(runif(24)), dim=c(4,3,2))

a2 <- matter_arr(a1)
a2

path(a2)

## ----array-2------------------------------------------------------------------
a3 <- matter_arr(type="double", path=path(a2), offset=0, extent=10)
a3

a1[1:10]

## ----matrix-1-----------------------------------------------------------------
set.seed(1)
m1 <- matrix(sort(runif(35)), nrow=5, ncol=7)

m2 <- matter_mat(m1)
m2

## ----matrix-2-----------------------------------------------------------------
m3 <- matter_mat(type="double", path=path(m2), nrow=7, ncol=5, rowMaj=TRUE)
m3

## ----matrix-3-----------------------------------------------------------------
t(m2)

## ----matrix-4-----------------------------------------------------------------
rowMaj(t(m2))
rowMaj(m2)

## ----deferred-1---------------------------------------------------------------
m2 + 100

## ----deferred-2---------------------------------------------------------------
as.matrix(1:5) + m2

## ----deferred-3---------------------------------------------------------------
t(1:7) + m2

## ----lists-1------------------------------------------------------------------
set.seed(1)
l1 <- list(A=runif(10), B=rnorm(15), C=rlnorm(5), D="This is a string!")

l2 <- matter_list(l1)
l2

## ----sparse-1-----------------------------------------------------------------
set.seed(1)
s1 <- matrix(rbinom(35, 10, 0.05), nrow=5, ncol=7)

s2 <- sparse_mat(s1)
s2

## ----sparse-2-----------------------------------------------------------------
atomdata(s2)
atomindex(s2)

## ----sparse-3-----------------------------------------------------------------
s3 <- sparse_mat(atomdata(s2), index=atomindex(s2), nrow=5, ncol=7)
s3

## ----sparse-4-----------------------------------------------------------------
s4 <- sparse_mat(s1, pointers=TRUE)
atomdata(s4)
atomindex(s4)
pointers(s4)

## ----sparse-5-----------------------------------------------------------------
s5 <- sparse_mat(atomdata(s2), index=atomindex(s2), pointers=pointers(s2), nrow=5, ncol=7)
s5

## ----nonuniform-1-------------------------------------------------------------
set.seed(1)
s <- replicate(4, simspec(1), simplify=FALSE)

# spectra with different m/z-values
head(domain(s[[1]]))
head(domain(s[[2]]))
head(domain(s[[3]]))
head(domain(s[[4]]))

# plot each spectrum
p1 <- plot_signal(domain(s[[1]]), s[[1]])
p2 <- plot_signal(domain(s[[2]]), s[[2]])
p3 <- plot_signal(domain(s[[3]]), s[[3]])
p4 <- plot_signal(domain(s[[4]]), s[[4]])

# combine the plots
plt <- as_facets(list(
    "Spectrum 1"=p1,
    "Spectrum 2"=p2,
    "Spectrum 3"=p3,
    "Spectrum 4"=p4), free="x")
plt <- set_channel(plt, "x", label="m/z")
plt <- set_channel(plt, "y", label="Intensity")

plot(plt)

## ----nonuniform-2-------------------------------------------------------------
mzr <- range(
    domain(s[[1]]),
    domain(s[[2]]),
    domain(s[[3]]),
    domain(s[[4]]))
mz <- seq(from=round(mzr[1]), to=round(mzr[2]), by=0.2)

index <- list(
    domain(s[[1]]),
    domain(s[[2]]),
    domain(s[[3]]),
    domain(s[[4]]))

spectra <- sparse_mat(s, index=index, domain=mz,
    sampler="max", tolerance=0.5)

spectra

## ----nonuniform-3-------------------------------------------------------------
plot_signal(mz, as.matrix(spectra), byrow=FALSE)

## ----sparse-deferred-1--------------------------------------------------------
spectra / t(colMeans(spectra))

## ----session-info-------------------------------------------------------------
sessionInfo()

